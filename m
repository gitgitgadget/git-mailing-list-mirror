Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2ACC433E3
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 02:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8760120775
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 02:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ARwE35qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgGPCGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:06:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50148 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgGPCGn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 22:06:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DCA9E1441;
        Wed, 15 Jul 2020 22:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YVSc8tN1GMM4qCg+/87iRWZ2qYs=; b=ARwE35
        qgQzPYv1KJNyeUr1U1j2fQAf4WGQ4lAdCmIFxrA5mEBkujNgDhEGMETHs+gUNoz4
        PnwUVrZjihhbMbvyNrjoYvIclYVzegfoB8kbw7/UJxm4lFjHNteVGN6KPTmwHXVH
        069n00tUMSVpVV2p3x/AJJEVfknb1pR/vlQyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M4doZciuAsbLprWNHRqBSyuAAyKlSFaJ
        DoDtdrmvIgSBIMTI7U1uCdFib9cWPCnvcJmgxEm+2a2HwntsEizaMm17zVw/tG5p
        OsxtPZY6Sx+WB4ZKJzlWy0aFT6bpyEFsopbNw8lcQp8JvScQ8S2Jek+gdJrgijpt
        v5RVJWXidh0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 868F8E1440;
        Wed, 15 Jul 2020 22:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1DE7E143C;
        Wed, 15 Jul 2020 22:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com
Subject: Re: [PATCH] setup: warn about un-enabled extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <20200715182011.GA2950865@google.com>
Date:   Wed, 15 Jul 2020 19:06:37 -0700
In-Reply-To: <20200715182011.GA2950865@google.com> (Jonathan Nieder's message
        of "Wed, 15 Jul 2020 11:20:11 -0700")
Message-ID: <xmqqlfjki576.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBF0F8C2-C708-11EA-A339-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I'll shift my attention to other topics that should be in the
>> release for the rest of the day, but am pessimistic that I can tag
>> the -rc1 today, which won't happen until we at least have a
>> concensus on what to do with the (apparent) regression due to the
>> "upgrade repository version" topic.
>
> Ah, I hadn't realized an -rc1 tomorrow instead of today was on the
> table. ;-)

It could be delayed even more if we do not have a good solution
agreed upon.

> I'll do what I can (in other words, expect a patch from me; but also,
> I am very interested in analysis, proposed patches, etc from others so
> that we can end up wit ha good fix with the solution space well
> explored).

Yup, that's the spirit.  Thanks!

