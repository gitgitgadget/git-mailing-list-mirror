Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5307BC433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 00:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F90323A7C
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 00:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbhAIAid (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 19:38:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55676 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAIAic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 19:38:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4C4CB45DE;
        Fri,  8 Jan 2021 19:37:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=G
        /4gndyUhSIFWmIAjQPMwhRpH6M=; b=WvAsQOirGe/0BrwDqZamaxrbE1JAhffnG
        a4XC2s8TMz/YC9fZLykx4wDi9Sxp4fylS+aXNru4yMmm31o47PixaejMsKGM+k4q
        jjBcNuddCWThlPS+48GIniuvW3zbdPvZBQwP2y6n58HzYBTH/1YJCXJDqa9rQHBz
        dv/0puUtrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=cAT
        Y1/qIIXsswUbRRiy7la4rnxKJXR9pNHrSpzngqEMk23thS/ghub/9AYETZCO5Byx
        eqgS7YaPjLKsKIyKBFJyrkCGExk0mBCIfRvY9gL6YYq2mFdLSlkDd8wfTjYGqvSG
        RgDnaiqb4RIUx2GVdvH2kAy2RgxQlSzReqvkxjbc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADF7CB45DD;
        Fri,  8 Jan 2021 19:37:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BE70B45DC;
        Fri,  8 Jan 2021 19:37:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Is t5516 somehow flakey only on macOS?
Date:   Fri, 08 Jan 2021 16:37:49 -0800
Message-ID: <xmqq35zbgd2a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6F482C8-5212-11EB-B8BE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've seen this breakage only on "regular (osx-clang, clang,
macos-latest)" so far, but that does not necessarily mean clang on
macOS is miscompiling or anything like that.

 https://github.com/git/git/runs/1671504998?check_suite_focus=true

What is frustrating is that the same CI/PR #1087 fully passes when
told to "Re-run jobs".

 https://github.com/git/git/runs/1671626677?check_suite_focus=true

They are testing exactly the same commit 820e568 that has a tree
identical to that of ed0fd57b97 in seen in today's pushout.

Any interest in helping to find out what's going on from folks in
the macOS land?

Thanks.
