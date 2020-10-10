Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8823C433E7
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 06:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF7420760
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 06:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DrqvP8qL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgJJG35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 02:29:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55547 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgJJG3t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 02:29:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68A52E0ED1;
        Sat, 10 Oct 2020 02:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SCztODXhJJoY1GjzE92xzj2DPbA=; b=DrqvP8
        qLvs3UwbkiEzd988d+98M4p+SaNRzNPyhzS+BrejbCj6FKmAhKClVwQNHwVHOvTF
        +QSoghyvuBqK4Lrgseg11AByUQQYg27WrY5M1EMU37uSf3nOhK07g7TJmSfOtCub
        LWUTlM/40jjWBWn3G6iVAGf2z4a4utwz09rQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eb1Ci7DKTKH840o6zwJAH6paAk2Up3Au
        evwXj8xCKYwb/ityIf1LTBp1PPKUdzk8tDHZKq5iMyPNhrwgpPhxy6Coq6UUBSEo
        Wy6vXoGLzhlMTa03ekLTsS+9vtb/Glpp7gb3Y4B5t0xjWBQZnB3AV2PUmC38rtCr
        sKoGO2K0cPk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55335E0ED0;
        Sat, 10 Oct 2020 02:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3ED32E0ECF;
        Sat, 10 Oct 2020 02:29:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Webster <chris@webstech.net>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
        <20200922170745.GA541915@coredump.intra.peff.net>
        <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
        <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
        <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2010091519460.50@tvgsbejvaqbjf.bet>
        <xmqqtuv3tlkv.fsf@gitster.c.googlers.com>
        <20201009175917.GA963340@coredump.intra.peff.net>
        <xmqqeem7tgh4.fsf@gitster.c.googlers.com>
        <20201009181827.GA965760@coredump.intra.peff.net>
        <xmqq8scfteh7.fsf@gitster.c.googlers.com>
        <CAGT1KpV+vcD59W2qWBsgg2qfSSLaJ37aVi__y5u=wHjsSDiiOQ@mail.gmail.com>
Date:   Fri, 09 Oct 2020 23:29:41 -0700
In-Reply-To: <CAGT1KpV+vcD59W2qWBsgg2qfSSLaJ37aVi__y5u=wHjsSDiiOQ@mail.gmail.com>
        (Chris Webster's message of "Fri, 9 Oct 2020 22:26:35 -0700")
Message-ID: <xmqq7drysiei.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBB35006-0AC1-11EB-A2A4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Webster <chris@webstech.net> writes:

> Thank you for moving forward with this.  I apologize for not
> re-reviewing the SubmittingPatches doc.  I should have done that.
>
> Thanks to Johannes for the input on this before it was submitted.
> Will work on improving the commit messages with more credits.

Thank you to all, and especially to you Chris for pinging to revive
the thread.  Applied and pushed out.

> Is there an opportunity here for a gitgitgadget command to send the
> 'consensus reached' email?  The value may be in deciding who is
> getting the email and trying to select content from the PR comments.
