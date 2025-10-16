Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89D1CEAD6
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645415; cv=none; b=oz9Ijbqaiw3vQfCfyfkjHCLn7jKUITawrbfxbQNEuVaOiwHJ0XoBTS0dsMmg4gjRBGbG9xC8kmCLWH+7pGkVdOaDdJ8WNCvkMIiy9hQKGGi/30yKFydLlbfZJTdPJNmd5qAlfnR/ObZ2XN3FeLTdvxKe5XitALmJoaMZNGkUch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645415; c=relaxed/simple;
	bh=JqRmWmb8d+fkRb0L+fBxHeV2scUNMS3DZZGNuR5c/6s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvAmHqNydrH1q26n35pjGrVhgsMvyt2uSKC7QRy/eyuKfUQ+rtXCASV/xZ965bmxX2kB/rHf0FKSaFBrgs6qNDjw5466QqwID5UyRDf6qjF4AsocgUoHZfG6CLafIhAJEU8YNvmeRyPvh3AIrncUaQYupg/NEWa5/GsXqeozxc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZVGi+t4X; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZVGi+t4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1760645412;
	bh=JqRmWmb8d+fkRb0L+fBxHeV2scUNMS3DZZGNuR5c/6s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZVGi+t4XEdjTsxAHydjNaY5QvpcZycZY91IEVJpJeAtujpkwNfSzlJ5Pg6NO2d/IY
	 OsU04ZZwqmHr3n9XxuOwrj8FDqGxnA7k5fAVBLe3GKS3ldWC/6W72ithB37X+INMhU
	 /tXu6Y/K/2MB+WqptOqv5fNtLTmpgJB62Fg/G9sg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 2E5781C0014;
	Thu, 16 Oct 2025 16:10:12 -0400 (EDT)
Message-ID: <5e056d3cee9453079d4251009ecd57b208285ae0.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/3] add a message-id header to git
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	git@vger.kernel.org
Date: Thu, 16 Oct 2025 16:10:11 -0400
In-Reply-To: <6fd0ac40-6cf8-436a-af73-1159f6569efd@app.fastmail.com>
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
	 <6fd0ac40-6cf8-436a-af73-1159f6569efd@app.fastmail.com>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 21:26 +0200, Kristoffer Haugsbakk wrote:
> On Thu, Oct 16, 2025, at 20:57, James Bottomley wrote:
> > There has been some debate in the kernel community about how to
> > link
> > commits back to email, which is the basis of a lot of scripting we
> > do
> >=20
> > https://lore.kernel.org/ksummit/a7878386f3546ba475cdf7250ab4f5a6af2a167=
6.camel@HansenPartnership.com/
> >=20
> > However, this problem is one that goes beyond the kernel, so having
> > git always track the message-id of the email used to create the
> > commit
> > will be useful beyond our tools as well.=C2=A0 The design of this
> > message-id header is that it never shows up except in --pretty=3Draw
> > output, so it will never be ordinarily visible, but can be
> > extracted
> > by scripts.=C2=A0 Some projects use the -m flag of git-am to add the
> > Message-Id to the trailers and for backwards compatibility, this
> > functionality is not changed although it is hoped that it is now
> > redundant.
>=20
> Related discussions: =E2=80=9CChange-ID=E2=80=9D:
>=20
> https://lore.kernel.org/git/aOQWWkj%2Fq7GfKZY7@nand.local/
>=20
> https://lore.kernel.org/git/20250703074952.20737-1-drew@ddevault.org/
>=20
> https://lore.kernel.org/git/CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdc=
ywqUUw@mail.gmail.com/
>=20
> Inspired by Gerrit, Git Butler, Jujutsu, according to the last link.

So this is a different beast from change-id.  Change-id is used to
track the same change across different commits in a fully git based
workflow ... and in that workflow a message-id wouldn't exist because
there's really no email based interaction.  The reason email projects
need the message-id is so that all of the ci type tooling we have can
link a commit back to the email it came from (so tip bots use it to
reply when the commit is accepted and things).  In an email based
workflow there's not really such a thing as a global change-id and so
the two proposals are pretty orthogonal.

Regards,

James

