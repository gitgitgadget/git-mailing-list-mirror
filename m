Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A4AC433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 20:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbiD3VAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbiD3VAH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 17:00:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC52E0B9
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 13:56:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F185312621B;
        Sat, 30 Apr 2022 16:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ED63HOeuyudTlNj3JwvZIvntiA5Esw4tHTIHzU
        SmOXw=; b=JpvEOFPTUXlGcqA+JJBf7JzNWDMrTtkgq2teB6iXf4b25zU+A3s2jD
        hHgPaFZNqCmC73BNR7WiC3EJ3C8WvgZa/QBLzKS4/JS2A1Y4cL68GJclP5HqLXrD
        GgPV7LZe4YtTI1DTH+BFGN8mxMrMvzu5dU6DFb7MJFbDu0I3kcfuE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9837126219;
        Sat, 30 Apr 2022 16:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 643D7126218;
        Sat, 30 Apr 2022 16:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
        <20220430041406.164719-2-gitter.spiros@gmail.com>
        <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
Date:   Sat, 30 Apr 2022 13:56:40 -0700
In-Reply-To: <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email> (Philip Oakley's
        message of "Sat, 30 Apr 2022 20:34:45 +0100")
Message-ID: <xmqqpmky70jb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09287296-C8C8-11EC-AD7F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 30/04/2022 05:13, Elia Pinto wrote:
>> Add a coccinelle semantic patch necessary to reinforce the git coding style
>> guideline:
>>
>> "Do not explicitly compute an integral value with constant 0 or '\ 0', or a
>
> s/compute/compare/
>> pointer value with constant NULL."
>
> If this gets re-rolled, perhaps include a simple example for those who
> don't immediately understand that quoted sentence. It will also help
> decode the coccinelle script
>
> so:     `if (ptr == NULL)` becomes `if (!ptr)`  etc.

That is certainly a good suggestion, but I am wondering if we want
to also emphasize another more generally applicable rule that
appears much earlier in the guideline document:

 - Fixing style violations while working on a real change as a
   preparatory clean-up step is good, but otherwise avoid useless code
   churn for the sake of conforming to the style.

   "Once it _is_ in the tree, it's not really worth the patch noise to
   go and fix it up."
   Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
