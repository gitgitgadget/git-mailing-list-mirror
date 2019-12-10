Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C02C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83E32073B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="FldF86oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLJKCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:02:11 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:25309 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKCK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 05:02:10 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 05:02:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575972128;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zsvIG4teKGgXCpRYYC2ecEVgr1f2va5eKcaaYlbhQyw=;
        b=FldF86ozX0iA5uYZ4kyJVgYuPCri9IXcy4ZKJyyFo9F2ts0taktPBVxclYyVCc6mQs
        NVTSwCN8qwWeaPU0n9ToZm846LEsCbgc4GZTeC2vMnGBmVEXEILZzhiMvsJwBdlSEX2H
        CzLWQnQWDWDcQtrxyO3GibEh5nXjh56SzW/H/VruesE8ACTbgDq+6waKmOl/yZza9Kkk
        VncJdxtDyYbRBI04V4opb+hTnEz2KNc7fWItq6S8euVZOWq57uRg4KTU0PJZAgPFVm0p
        2KWoHrZdn8FrBf08BTjh8Pjv+/ThCF14iCoLW2LFYwGv90NVi+NuDwu6a6Q7t6+BQ69D
        /lnA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX92EW4mFvNjTRB"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 46.0.2 AUTH)
        with ESMTPSA id a09c40vBA9u54sD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 10 Dec 2019 10:56:05 +0100 (CET)
Date:   Tue, 10 Dec 2019 10:55:45 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: How to detect if a tree is in status "merge"?
Message-ID: <20191210105545.66768b7a.olaf@aepfle.de>
In-Reply-To: <xmqqzhg1tdm9.fsf@gitster-ct.c.googlers.com>
References: <20191208115517.6b319a44.olaf@aepfle.de>
        <xmqqzhg1tdm9.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 2019.05.18 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R5KwA0KQul6xRC0emZ03iwR"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/R5KwA0KQul6xRC0emZ03iwR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 09 Dec 2019 13:04:14 -0800
schrieb Junio C Hamano <gitster@pobox.com>:

> Olaf Hering <olaf@aepfle.de> writes:
> > Is there a way to detect (from a script) if the current working tree is=
 in state 'merge'? =20
> The first step is to define what "state 'merge'" is, I think.

I do a fresh clone of a remote repository, checkout the target branch,
then merge some other branch into it. Usually the 'git status' command
gives me a list of files. In case it creates some output, 'git commit'
is called. In case there is '^UU' in the output, manual intervention
is required prior commit.

In this case the resolved conflict resulted in no changes. I do remember
a plain 'git status' showed something like 'a merge is going on'.
Apparently there is no easy way to get this state from a git command.
But as you said I may be able to test for existence of files in the
.git directory. I will try to recreate the state to repeat this merge.

> Why are you scripting around "git commit"?  Doesn't "git commit"
> refrain from creating an empty commit when there is nothing to
> commit anyway, unless it is recording a merge whose result happens
> to be a no-op?

'git commit' errors out if there is nothing to commit.
But in this case it would have to create a merge commit.

Olaf

--Sig_/R5KwA0KQul6xRC0emZ03iwR
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl3va6EACgkQ86SN7mm1
DoAtGA/9FVXLWvy/9Pgz8e+9UyA0GQNJxDIaQ+04yDLASTV+tVUBu4zrWrESOVW+
LVP8KZg+wFYvpz/Po6+hiA5lrx93jbodVpHk03eSWnC+CDSZBmwu6S5sWTgrA5pE
Z4RjOqktNaMx36Xq+A3hupojlEkhbUkB9scdkcdB/fe7YqdIOJ0lpUt2L6f8ZOmQ
ytnTJbV+lArcQ9mHIDpgt//P7axbndkEdubM4otkGnGnyTblfpkkGzsmE0PRswK1
poayVDIgzfl3WZGjHr/7Xr1rxCoeJgW6xPYRPp7ymhn9I2w9zEfnNuVmy21ovZUi
q21fOoF1C1X/o5089tlxo7h58A+itnvqSJ4SvwyrfH4BUZ2Up+qfKQ+qkdxi95Rv
5Z6wd8P2PUQOLaNiH4fXFcbCgZKUGCt1uTcFA40IaUzN03dpeqghoDG3eCdX/pUt
OwPwRizqSUuzdsfgCp6Xn3xKxvwdBaGjQEuiX9qt+M4jRgdthNs1t7Y7YqhIavij
2BZCUmd1leZRtAMNDLbLDPaCfHpKfKs29c23dg1ofwPF64sAoAOmGMvR9P9V9rh5
N686/AeQJLSYWukAp9aDRmWV5GcR2uRxUzhxhXPqgPL/szP/pDu3rl+ESlcDliK8
Zk/+e9OTaSYbvM8y9e6luNkDhweN9IHXS7GmJhfEw09RQg5EBJ8=
=RAnx
-----END PGP SIGNATURE-----

--Sig_/R5KwA0KQul6xRC0emZ03iwR--
