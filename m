Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3D0C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A2D20870
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iL7mLNtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgCCQrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:47:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55303 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCCQrk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 11:47:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AF6B40F0E;
        Tue,  3 Mar 2020 11:47:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wDxRPUTDzF2LULqfAkQgEte3lLo=; b=iL7mLN
        tGknv93zLrum3YJPXVZ4tqavzL6ikRa75YJ+qK3QGBprW2yiZ6Vio8dvGyMw9Pec
        oTLYCfmjVVo53l0rS4ZRMUrfykvwCRlkupd5Sae4RUOylFGtAHhdDQ4NBmQtAgbP
        +iNBOIDI9hb08tWAyAGMFzuUhyOPlbNlf6B7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mM/CNaS2FzEI5sKXNd7R3jCM+RiovucJ
        6s1+Jj3JmNGFQTAdrSCSdqh7+hg6b7TspzECS578VpJNu3tD6nm1Wgop31nHQrVx
        lJoU3Vo6qQWmUGiuf+6xwzLcQ0sj7nOO1p4qLbHXIrtCpo+1oCFtBmA22ImnIsvs
        23bscaNGBA4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3106940F0D;
        Tue,  3 Mar 2020 11:47:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69FDD40F0C;
        Tue,  3 Mar 2020 11:47:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <son.luong@booking.com>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH 2/2] stash: remove the stash.useBuiltin setting
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com>
        <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com>
        <20200302181832.GA1571684@cat> <20200302181924.GB1571684@cat>
        <nycvar.QRO.7.76.6.2003031430180.46@tvgsbejvaqbjf.bet>
Date:   Tue, 03 Mar 2020 08:47:36 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2003031430180.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 3 Mar 2020 14:33:33 +0100 (CET)")
Message-ID: <xmqq8skh9yhj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B057421C-5D6E-11EA-AA3D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  	prefix = setup_git_directory();
>>  	trace_repo_setup(prefix);
>>  	setup_work_tree();
>
> However, this is only needed because we did not change `git.c` at the same
> time (as I had done for `rebase` in 80dfc9242eb (git: mark cmd_rebase as
> requiring a worktree, 2019-07-24)). In other words, I think we will also
> want to address this part of `git.c`:
>
>         /*
>          * NEEDSWORK: Until the builtin stash is thoroughly robust and no
>          * longer needs redirection to the stash shell script this is kept as
>          * is, then should be changed to RUN_SETUP | NEED_WORK_TREE
>          */
>         { "stash", cmd_stash },

Ah, I missed that part; thanks for chiming in.
