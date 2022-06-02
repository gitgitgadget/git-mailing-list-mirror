Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E13C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 17:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiFBRgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiFBRgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 13:36:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92607FCB
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 10:36:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA76218F75A;
        Thu,  2 Jun 2022 13:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QxNRBR61masEFhbz9EdteUHrhpO3uvoDkjHxy1
        ytfic=; b=io8oSac6WHjtO7QQkbOJqYlnV1jQ7Gy+pHtEltPSSlUZAh1xLB3DjQ
        g9Mur0HX65g6gmX/LB3ZACM8QxgoENs52gvdXJMIynwIpd5A9gHWjBW9tuBU9Wg+
        CgrSBu7dSAtAZIVRgObEzCay+q3vibg7G7wfsnpbEQTFD7HQ2R/t8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A33D818F759;
        Thu,  2 Jun 2022 13:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 481EA18F758;
        Thu,  2 Jun 2022 13:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] range-diff: show submodule changes irrespective of
 diff.submodule
References: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2206021724240.349@tvgsbejvaqbjf.bet>
Date:   Thu, 02 Jun 2022 10:36:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206021724240.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 2 Jun 2022 17:36:40 +0200 (CEST)")
Message-ID: <xmqqwndznf0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 928BC6A0-E29A-11EC-A902-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Force the submodule diff format to its default ("short") when invoking
>> 'git log' to generate the patches for each range, such that submodule
>> changes are always shown.
>
> Full disclosure: I do not see much value in range-diffs in the presence of
> submodules. Nothing in the design of range-diffs is prepared for
> submodules.
>
> But since `--submodules=short` does not change anything when running
> `range-diff` in repositories without submodules, I don't mind this change.

IOW, "I wrote it for the purpose of doing X, I do not care those who
have been using it for doing Y, I am OK with changing behaviour on
them".

Philippe, do you have a good guess on other users and workflows that
may benefit from the current behaviour?  I suspect in the longer term
this might have to become configurable, and I am having a hard time
judging if (1) a temporary regression (to them) is acceptable or (2)
the new feature to also show submodule changes is not urgent enough
that it may be better to make it configurable from day one, instead
of using a different hardcoded and only setting like this patch does.

> This test case is very clear and concise, even without my suggested
> changes. Therefore, if you want to keep the patch as-is, I am fine with
> that, too.
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for a review.

Will queue.
