Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD5C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 22:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiAGWb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiAGWb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 17:31:26 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40200C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 14:31:26 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JVycV3q7QzQkF3;
        Fri,  7 Jan 2022 23:31:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1641594680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIniSSZLj9HZBYeSm24Gk1gN0OWj1/pfovOheH6dVjo=;
        b=auHo1hyIvsP6X4r+kB02APqWeokJJFQ6/vxF8pR7eScQyeRu6uaxQxEEP1/l+EmzuzTeno
        Lk+spm93OZFdc6NZ/HXbrijnel5mEL1oG6VgY4+nrAFPOVtzhOLMdG/o3Ayh1CeITogSpI
        tLlWWGz4vPjbURqFF+TgGjsrpfEW/lbujXGQSCbOGK7+wiIJKvEQifu9mnJtSy2Dg8ivjo
        d/7UmaaEuS9tzZDkGvXyTmREuzemUEJf6xPt9gr1n1Ov19jdqm/0IN/FlaZaoKQs/BwtE6
        sLjVNbo133D+yi07u6tGeg9+xlMxFGAzzutrx5JjOHEFWFtZm0cSYZ6OU6vw1w==
Date:   Fri, 7 Jan 2022 17:31:18 -0500 (EST)
From:   "Issam E. Maghni" <issam.e.maghni@mailbox.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Issam Maghni via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <1303411829.1252938.1641594678116@office.mailbox.org>
In-Reply-To: <xmqqr19j6x92.fsf@gitster.g>
References: <pull.1172.git.git.1641528221530.gitgitgadget@gmail.com>
 <xmqqr19j6x92.fsf@gitster.g>
Subject: Re: [PATCH] hook: test -a|o is not POSIX
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 01/07/2022 4:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>=20
> "Issam Maghni via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: "Issam E. Maghni" <issam.e.maghni@mailbox.org>
> >
> > I faced `test: too many arguments` when building using sbase [1]
>=20
> Building "git" with sbase?  It is curious how a loosely written
> sample hook script can cause build failures on a platform with a
> more strict userspace.

Sorry, I rather meant using git with sbase. I=E2=80=99ve submitted at least=
 a
half dozen patches similar to this one. My brain is in auto-mode.

> Perhaps...
>=20
> =09The sample update script in the templates directory uses the
> =09`-o` and `-a` binary primaries of the "test" command, which
> =09are marked obsolescent in the recent versions of POSIX.
>=20
> ...would be sufficient, as 'sbase' would not be the only source of
> the userspace whose 'test' lack the -o/-a primaries.

You=E2=80=99re right, this is much cleaner.

I force-pushed the changes in https://github.com/git/git/pull/1172.
I must admit, I=E2=80=99m not familiar (yet) to submitting patches through
mailing lists.
