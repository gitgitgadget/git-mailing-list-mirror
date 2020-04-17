Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B7C2BB1D
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 21:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B5E206B9
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMoUPbYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgDQVc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:32:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63181 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgDQVc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 17:32:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D3CFBE7BD;
        Fri, 17 Apr 2020 17:32:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/q8dppa4laSCjLW00smk+SupVPk=; b=fMoUPb
        YPGlL3nLgBgVmoAvNPgpwyI7iz9A2eE6+PKsTKzmZtCyr1J0E5GYekUiyxPZE2n0
        t3qfyzPCodJJvGGiV/VhJb1KZvfklKH98Cqa0OlIeux1l2YU8CoArSKxDVTlqHJF
        3uKhN+c6f9TaOllTdMB1poIvLF1o8M/7V/7K0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H964ftdx73N8oVEJ2GonJnKEQoWVVwbO
        fNBHos0t31HjyRSYGhq+jUbW0nIr4/O86/qw3i3isYJJr/wsDcfSQ6Ybm86KVbr4
        pUZCzeLdFK34hjGZaYrSUpHzodhIicCEX5V/0wUzhcH+kPmJ8SGgwfJrtQbuMH/x
        qRicaOKHJV8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53FFFBE7BC;
        Fri, 17 Apr 2020 17:32:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9EA27BE7BB;
        Fri, 17 Apr 2020 17:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git diff
References: <65cbee30-fa37-1422-98f2-2c2b5aa094bd@maurel.de>
        <20200416225502.GJ2751707@camp.crustytoothpaste.net>
        <24a180f6-cc7e-fe5b-e810-0fc717d601ea@maurel.de>
        <20200417203323.GK2751707@camp.crustytoothpaste.net>
Date:   Fri, 17 Apr 2020 14:32:51 -0700
In-Reply-To: <20200417203323.GK2751707@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 17 Apr 2020 20:33:23 +0000")
Message-ID: <xmqqh7xhvlvg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEFCAB1C-80F2-11EA-9E93-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't know because I don't use git-gui.  If you would, please keep the
> list in CC, so that other folks who do know the answer can chime in.

I do not use git-gui, either, but IIRC, it stayed away from
scripting around Porcelain commands, so it is not all that
surprising that it does not use diff.algorithm.

There is gui.diffopts configuration used in git-gui/lib/diff.tcl::

	lappend cmd -p
	lappend cmd --color
	set cmd [concat $cmd $repo_config(gui.diffopts)]
	if {$repo_config(gui.diffcontext) >= 1} {
		lappend cmd "-U$repo_config(gui.diffcontext)"
	}

so perhaps you can pass --patience via that configuration?  I.e.

	[gui]
		diffopts = --patience

in .git/config?
