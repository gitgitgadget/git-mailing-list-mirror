Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4CDC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A328F20782
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iFxaJEXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHYPm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:42:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58039 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYPm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 11:42:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A48EDC84F;
        Tue, 25 Aug 2020 11:42:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VAHxDss/lJNt
        feFBNGXIDHt5Aic=; b=iFxaJEXzI+K3GSC1nFPPXxNXO+NloiYvyEtiKZZ7mtEf
        JjGlueTdJSFAFxLRKdMCdltrF7lp2HaZLhzibPbPWNrJ3NERpSXasKv+eiegOe3Q
        yQmjAVv4FVBPYsUc1coJqLbu3zITnVHww81w+vWDxKBr/4poSb9/vaYMz8GFKKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hkOQZv
        2JdoiVKUqeCgOIBdXClzvjGbibO94qeq1lrOGjOmadRaPHEaelOn9oVVoqXRntV9
        7U79/dedJtrlgaHe3iMzv0Oq2TfNsWXdcWX10uQ/PWzwoAMT7ch56JnSeOAGVXFk
        5s3aqZafudoMBTMeYdN/cXYiTGnrt4Tb/XpmI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31EE2DC84D;
        Tue, 25 Aug 2020 11:42:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79ABDDC84C;
        Tue, 25 Aug 2020 11:42:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed versions
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
        <20200825134714.GC25052@szeder.dev>
Date:   Tue, 25 Aug 2020 08:42:20 -0700
In-Reply-To: <20200825134714.GC25052@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 25 Aug 2020 15:47:14 +0200")
Message-ID: <xmqq364a3f6r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 912566EE-E6E9-11EA-A3B8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> I'm afraid I don't understand this patch or the previous one (or
> both?).  So this new Makefile knob stops hard-linking the dashed
> builtins _during 'make install'_, but it doesn't affect how Git is
> built by the default target.  And our CI jobs only build Git by the
> default target, but don't run 'make install', so setting
> SKIP_DASHED_BUILT_INS wouldn't have any affect anyway.

Very very true.  Let's drop 3/3 if it is not testing anything new.

I do understand the concern 2/3 wants to address, and it would be a
real one to you especially if you come from Windows.  People on the
platform wouldn't be able to use shell scripts written in 12 years
ago or written with the promise we made to our users 12 years ago,
and unlike hardlink-capable platforms it incurs real cost to install
these individual binaries on disk.


