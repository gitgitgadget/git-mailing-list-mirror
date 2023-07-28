Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70295EB64DD
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjG1VWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 17:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjG1VV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 17:21:59 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE744AA
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690579306; x=1691184106; i=tboegi@web.de;
 bh=bavTJw0USmbor1DYlSAzgfpra19yHTpkXnqXn0Y8NDQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iCIKONUrbv6ypdeTRWGWiFQQwtGlgT0m2N2ZN9ZCI/SD84cNHs2nqRjos3R4dMErx7PqnOQ
 HXCqXV8xE67RUq6D/7WxU/6/Vb1G5KJg9TfHvAIrlazm7aNxFLKm0pLrAPdik0lDnryfIITc9
 vH1jga7re2XE9Zh9Bx18ifG0fsWDcFBDhrCqAp+O34IWJLiriH+HsxhI8l6c4t8JW/Hem7+gJ
 tNvbch4OQ2Wy7wuol8PMbrqWEck1ovs+GAinMnHM7votQTw41XO9D31iPG99LJlTw6j4aDFIN
 m61hFwb23tnwT5phd2b7SQJu+KcwooBZDgDJN+8jb9iBaQep0/Hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Movne-1q5FZc07dm-00qGF5; Fri, 28
 Jul 2023 23:21:46 +0200
Date:   Fri, 28 Jul 2023 23:21:44 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>,
        jacobabel@nullpo.dev
Subject: Re: [PATCH v4] MyFirstContribution: refrain from self-iterating too
 much
Message-ID: <20230728212144.dpcbp6gfhfuiabia@tb-raspi4>
References: <xmqq3583uyk0.fsf@gitster.g>
 <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
 <xmqqcz76tv6d.fsf@gitster.g>
 <xmqqzga9opdu.fsf@gitster.g>
 <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
 <xmqq8rbbbzp2.fsf_-_@gitster.g>
 <owlycz0deykz.fsf@fine.c.googlers.com>
 <xmqq7cqkanm9.fsf@gitster.g>
 <xmqqmszg987u.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmszg987u.fsf_-_@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:IVLLILU49rEdsElwdQCy1lf4XCsSsdliyRdhLcnbm5yZ7qk5Oyo
 8UECoBsJcEHtvGUDCRntcz+LiK6ikvWWnne654cLy+zQTtpNV1s9IalWqaUsaNS7ORhq90z
 pXa6549flU+7+fHO6t6lIB6B2iFsRrL1dbasJF0Xs2G/cMOroOD5LZ933b2vY0m3KqAbTin
 GxjgjyorkqirSlErDFZ0A==
UI-OutboundReport: notjunk:1;M01:P0:eiVJgbItZBo=;LycsYmqRWN1O/jLdilCBP7sFscC
 WoAmnQ7E9QYPiyOEbadyYIbzoKgn2GpufIVJjp/pnz3nF+ZtYFJ0HSbsyRTK6spgg9XNItEm8
 FjbfrAG70exzMz99IWD4tX1ghyilRYaLYHAYRY2dPzh6VIQ+mirZW2FCcwrFNBeW5ID9hZRLZ
 iMdjKt+gD75EQrJQklowu3OZ0L9DRb1zHrHa2Mi7vHLtzf16GBLhMs5tJXj0qRGSd8Z0hRVpU
 wg7BaeaaDUae66BatnPthXqJVahPniptgvAYnq0l/NEi35Shgd6AfCW3wo2Nx68w86YWzQwy4
 OblW9tn/3gizjTbUIjk93qZr1yTLoYvP9Y0Tckvb2aVjlFh6gx433VHy87r3DzDsyB0/sm8Zs
 1/WX5+jgvx3xA/n5DzDuIY+Reu9srYyEiSwrnfSC0rna5DZTJgi0y7ntyWwhkqp2SBpBdZ4/H
 v8JWsyQw02s6AaLhNAKYbk4KsqFJOmq6mIfttOnpPEClugyX63XijtOkOnuZD/jKRfnTAbSjj
 cm05GU9Ic+XnpvZYC/UJcEDblzjbfruBOx468iasz+mkP5DtqS1U8naSnbUu9NogV+LBHlGI4
 zFgNkMsGRnlas2bq2vu/F0+uKn52RkeT/9ERer0m4r6P0t8u6xAknzjuSMNq+wzkPgE0G2kxc
 NCNUQwzafmDhrWH7rUnOXdXs62S3POwySIPh18nfpeXNQSsQr7V8i9PRbrBiyS5J+z4Xq8ZLK
 5+4TzQTPwyJFn9HHrv++WbS+CtKqdcb03Gi08wE9Y3tj5U18epG/rVRBuaGcbhSdF4CVJkNYJ
 iOBq9PbMjyILmGmQRBK9PMzCUbnUSxvIWLnQhEYck4UnZ/uGh29MmYkQPNGABXiKU6TMtGJYU
 hfyUolG0tbKvbwIA5lbsUxY9Q7qexL2anORexu8iWP2MTo5oHbVZvG6r1P5DWycOsYpcwHxrQ
 vucpWA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2023 at 05:43:17PM -0700, Junio C Hamano wrote:
> Finding mistakes in and improving your own patches is a good idea,
> but doing so too quickly is being inconsiderate to reviewers who
> have just seen the initial iteration and taking their time to review
> it.  Encourage new developers to perform such a self review before
> they send out their patches, not after.  After sending a patch that
> they immediately found mistakes in, they are welcome to comment on
> them, mentioning what and how they plan to improve them in an
> updated version, before sending out their updates.

That's all good, no possible improvements from my side.
However, a possible question below.

[]

> +Please give reviewers enough time to process your initial patch before
> +sending an updated version. That is, resist the temptation to send a new
> +version immediately, because others may have already started reviewing
> +your initial version.
> +
> +While waiting for review comments, you may find mistakes in your initial
> +patch, or perhaps realize a different and better way to achieve the goal
> +of the patch. In this case you may communicate your findings to other
> +reviewers as follows:
> +
> + - If the mistakes you found are minor, send a reply to your patch as if
> +   you were a reviewer and mention that you will fix them in an
> +   updated version.
> +
> + - On the other hand, if you think you want to change the course so
> +   drastically that reviews on the initial patch would be a waste of
> +   time (for everyone involved), retract the patch immediately with
> +   a reply like "I am working on a much better approach, so please
> +   ignore this patch and wait for the updated version."
> +
(That's all good)


> +Now, the above is a good practice if you sent your initial patch
> +prematurely without polish.  But a better approach of course is to avoid
> +sending your patch prematurely in the first place.

That is of course a good suggestion.
I wonder, how much a first time contributor knows about "polishing",
in the Git sense ?
From my experience, the polishing is or could be a learning process,
which needs interaction with the reviewers.
Would it make sense to remove the sentences above and ask people
to mark their patch with RFC ?

Or is this all too much bikeshedding, IOW I am happy with V4 as is.




