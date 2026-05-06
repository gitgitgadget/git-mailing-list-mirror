Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9D3AB27A
	for <git@vger.kernel.org>; Wed,  6 May 2026 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056452; cv=none; b=srIoSNZkWcrZmbHqytnjAes1YXIA2HxavXnjrGNqQ5xlcqIXomoeve69ZneFoT6ZavRfXg2x/81ZpRXBy/61YmZvhQ3OZf67sbaEVU9Ib4i61NWZ6gJHMDDRZlsB3uU9bcvVcKjfDGGrn8Eez4s1fxMCX/7Kj9DTFOPeV1BNPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056452; c=relaxed/simple;
	bh=G81+8obO/RZZF7/1ttuiaLYQC3u5AwRtU2Y0PK//jAA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A2QzgfhvsV2vsxMBJ1vYixnBQM3FDYpPBH1wZTfFYvPZkyEWnQJYHceE1R6rrVw4yY61DVjwHpVxk4Y2LmH6vw/daYfATeatDtlTcKyqVOMiV5QW7E7fQ7aKzOyvIkal4aE7C5xUGlisS57P2q9W1MfH/oWrCGIzuzgXT2k6Rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=AQbH7Syp; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="AQbH7Syp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778056439; x=1778661239;
	i=johannes.schindelin@gmx.de;
	bh=E2hSq2/ySMFSFU7OgUPzbkPrttXl9d+gwELbvoStw4k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AQbH7SypGFUT/bda9Ja5znKq3kR+V5w9m9QPPutgBjPkpHeFrMq0QaAA0mjhaYSs
	 f5qnlFTj+2UHXsZvpTsy0wwrzaRlGMNmV1LbumPCn/7bTrc97l6V3FwWfoqbR9q27
	 BBHCBBKG5+xGZbdY87aNX9R45RrmR7cX/iyOjwwgwlZfPpOjUfW+Fv0l8/c+Q88T8
	 hTjxCRc+fKMPXZvsjYwiw1oL/blIX5GSIJiAMNYijuBYM44Rsa77whRai/P0/OuT+
	 AcuXafBtP4+BUE7npuS/qnQ7C7gydVY0HEdh1M1v/vxGfWISySMQdhMrX/7AnPtf3
	 vNUARHtAuc6Iixi4dQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1w1US021YV-00UjHs; Wed, 06
 May 2026 10:33:59 +0200
Date: Wed, 6 May 2026 10:33:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Derrick Stolee <stolee@gmail.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
    Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 11/11] ci: run expensive tests on push builds to
 integration branches
In-Reply-To: <CAPc5daUzr+mn6ojzsqpW6mCXzc2yVqpevVk8njefx4j09G_OgA@mail.gmail.com>
Message-ID: <e00dbf04-5866-008f-12e9-efdaacc3f2e0@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com> <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com> <1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com> <42f96e54-7b94-4075-91b1-1c2447b93322@gmail.com>
 <xmqq5x52nhg6.fsf@gitster.g> <CAPc5daUzr+mn6ojzsqpW6mCXzc2yVqpevVk8njefx4j09G_OgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XvQ63o6j3YKBlVmM5n2fl9AEbCRzdQJoJoUYWkNqKMVPM6k8mke
 WorIvFP0GcJQZbquJfKxAmU86KRNkrCpz0pTqdL9mQRSqX2pQ778N+gibcViX7+HPhoGPt/
 HkJNxFeKY09/nz4iqTXDbW4OYVq2juYPR2C/qC12QaP/1xG3HAEFx1E64yNpKt4QCWNthLZ
 JapBKSLxnSWmAfehCBCog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lbHFTSxjQZQ=;2io+3LM7ntwSYFv46hMRoc629yF
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 6 May 2026, Junio C Hamano wrote:

> https://github.com/git/git/actions/runs/25366120610/job/74377320625
>=20
> We seem to be hitting the same _Generic error in various (but not all) j=
obs
>=20
>   /usr/include/x86_64-linux-gnu/sys/cdefs.h:838:3: note: expanded from
> macro '__glibc_const_generic'
>     838 |   _Generic (0 ? (PTR) : (void *) 1,                     \
>         |   ^
>   Error: list-objects-filter-options.c:222:10: '_Generic' is a C11
> extension [-Werror,-Wc11-extensions]
>=20
> I thought we updated the codebase to avoid stripping away constness
> with strchr() and friends, but the error seems to be more like one
> hand in the system passing -Wc11-extensions to stick to older version
> of C and the other hand in the system that uses _Generic to implement
> the const/non-const variants of strchr() in the system header not
> knowing that the other tells C11 const-preserving strchr() should not
> be used?

This was diagnosed (with a proposed fix) by Patrick over in
https://lore.kernel.org/git/20260505-b4-pks-ci-tolerate-glibc-generic-v1-1=
-5786386fe512@pks.im/.

tl;dr It's not about `const`-ness at all, but about glibc using a C11
construct which clang's strict c99 checker now refuses, thanks to the
upgrade to Ubuntu 26.04 in the `ubuntu:rolling` runners.

Ciao,
Johannes
