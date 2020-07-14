Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45E0C433E2
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11302064B
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DCiTd85D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGNUrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:47:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50166 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgGNUrb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 16:47:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3AABD80AE;
        Tue, 14 Jul 2020 16:47:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CGOGI2PwRRNp0Hrm/GoLZEdq3/0=; b=DCiTd8
        5DDl/xwFOEqXdIvrEzhp4YB1qIXMtWFE2T0LwdYHvAEH/+lbdkbmxWCPM31TfjFb
        YGK14rKOYr3sIR6wfh3BAnHePtQK/ZyIAsBTUh7rEJ07cZUPdxK4bAUJcKC6ovJo
        EG/FaoSYEg8+2x9OL178JMyof++Uk8AZQ4ky4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P+mEakaPHfU5zBo0Kt+ZrnuEKGPsA6Kn
        oPoVcnrax9l8a2c6AjWtKuE607LzW+NCvXxHoVAK0bFv6oz52KerFbgHwVrIdi2z
        mymy2i/SJZiyp5vRe8q/HbM3L/hFHwsas34ctAQI433QYwx0KRVo7/N5uDvcqKYP
        y2FDC4VA4d0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBCAED80AD;
        Tue, 14 Jul 2020 16:47:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32736D80AC;
        Tue, 14 Jul 2020 16:47:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Xin Li <delphij@google.com>, Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH] setup: warn about un-enabled extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <18c65b85-2f2a-ff96-1ea7-e16befa6928f@gmail.com>
        <nycvar.QRO.7.76.6.2007142227280.52@tvgsbejvaqbjf.bet>
Date:   Tue, 14 Jul 2020 13:47:25 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007142227280.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 14 Jul 2020 22:30:12 +0200 (CEST)")
Message-ID: <xmqqimeplt7m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A40C43C-C613-11EA-B68D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 14 Jul 2020, Derrick Stolee wrote:
>
>> If "v0" includes "core.repositoryFormatVersion is unset" then I
>> would consider this to be a way to avoid all user pain, which is
>> positive.
>
> I concur.
>
>> I'd be happy to test and review a patch that accomplishes this
>> goal.
>
> Wouldn't that just be a matter of extending your patch to re-set
> `has_unhandled_extensions` also for `preciousObjects` and `partialClone`?

It probably needs a bit more than that.  For example there is this
bit in check_repository_format_gently() that clears the unwanted
extensions that we used to honor by mistake in v0 repository

	if (candidate->version >= 1) {
		repository_format_precious_objects = candidate->precious_objects;
		set_repository_format_partial_clone(candidate->partial_clone);
		repository_format_worktree_config = candidate->worktree_config;
	} else {
		repository_format_precious_objects = 0;
		set_repository_format_partial_clone(NULL);
		repository_format_worktree_config = 0;
	}

and the "different endgame" advocates to keep honoring these (and
only these), the else clause probably needs to go.  There may be
some other tweaks necessary.
