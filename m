Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB222541C
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776647362; cv=none; b=ey/oCnYVeas4+a16RdOrXsXSb7zsqAWEtLZzAonf9xSupFOn5kVwIM0B6HTSi1C2MXotQsnrEkTxstzGG2nctJct01QOUkoINlqWpbFGQGK5/3zKXaHTZt6KAj6Y/n1580DS6fd9khkMGs2LaX/SR6JxTFoGfaydDXvMPd3Ln50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776647362; c=relaxed/simple;
	bh=CbxdwF4X3IUyzHKUCu1A/zDwtNM95s+Z6+s68CwHKuw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=CaxxdZcMb3E1UphvvUqsa34zoL4WPVr7NoTNwoWyVu3DMWMUk6gpgUbYhSecOerNss8UTpONnRAD5t5EMgU8KUZsQA14+TyN4ThQP3LZA7Krk5ajyCDW3qg66j6MAh3vQ+PvrppmWK2ZS1toCmtkDU2lYAepu4y7dRJnnyyQpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1O6omtl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1O6omtl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7b186dfc1d0so32725617b3.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776647360; x=1777252160; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgyKrWsWgjYnw7reKLMMxScTR3H8jaiCsy2k+337jpU=;
        b=r1O6omtlT0IIJEIlV0kiCN7djlCcDv1PKnNqNEiF1jLsYzLSTXDOcAv0fJM5xRUISX
         H+3ewFUe6Cz9Sahhvry6+0YvCLDQxd4pxAOK5HTm//tPEF3NLZ/dimJ8Q4GkRvA1zRWV
         0J7Gyol7K8FnekqgfK7j0dfzzfJWUSnMypEHhTcPcB4JISoCu3+3zdfdGiUaS+BWuDx5
         Fb8sINfij7M+sJfXaxKpU/Bw5Vy+JRVEwq32q5ZoVpdNm9rKxvmlFj7z+ag+WXzr7Qzw
         +0TSRlDH21Qe1qkpthYNBQ+CncC0kfr08j+6u8E2DhoQuYRxVNt/V3ZcJsc9gGg1Kaad
         0pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776647360; x=1777252160;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pgyKrWsWgjYnw7reKLMMxScTR3H8jaiCsy2k+337jpU=;
        b=VeNq+1UCNGhQT9Mi8HO0vAfOsHF1ij2uMim/1nQ2UIezrVed5sDSlBoLtpBfeA9HFc
         Eu1jdCeb3fCCAP/k8qvELi44N87SabIUpx+Llj3XuC+THDbrYoBFQn7mTjbfxImFmLOO
         kuwf606a9rMWLxfIRKoTvT+QJb0hXfUN/dJo26PyKbxqvEMogq9ssXFtsVIN/MLE7NDR
         PKaGRAv/nfdrBHLT5bgQa/PxVcjy4hxkq/tyh92sutEVkBIyi6+bvWU9bT8NO1jbD+5y
         /VxgwYIxuXjygnwaG1M2VzesExhsPqKDgWPdHpOcNwGarDjEALpXRiPjz6uc8IGGj+Cv
         1Scw==
X-Forwarded-Encrypted: i=1; AFNElJ/jR1oOcXH9nW8MuqzfvDigtiF33XHcZJwi3xJdTmPxqusKu8nZ5pu2FVgtH8egwnIaJyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOgBi6dTMJlZroSv9j0xNkafzyl23r5Fp8QJVXs8oHoY7sb3M
	MOrueymOzAYbUXC/K2J2hxAYd52D9LkT9iqa9QecjP2KNKvNAfegTNZk
X-Gm-Gg: AeBDietN9b6QDdTpGB9TUojRMVkS3aYKK2luYeKQ+U9GEa/Mklmq1Upt+psSPMNlaex
	3yyN9Qyx17E4/DO/iX4t3zfMQs0AevP96L+HPaEq8TE6tvsap6txh96VXzAMrxGWqhlm0sjEyLg
	l32SfgFsJw1kIxmBR6ldraHEmSp4m8or3Cei8hN0fc1IjY2y9DpTeDm2hIxYRdzw/hg4ynshzsv
	qqc1VTgFVd3TGfofAMOADBlXEK5xnaUpQ666xWf59fQKFbZ/bPv/1+HsZwfvfnQTQutukepqnDz
	WDhX5y25G+tdPiaV3haB80G+BR45plraH6IeJ4Ui14k+OSMPNa4y5sJNj5tTwLqUgSsAqADT/53
	trY08H8EJhqo4IH4x85ACPBPGxOxnyHM1iEyPSaby0UIftvd1za1/y0fKueymt86a+9eTiFnXDp
	rhkc06o98dThv48xv9PHQpLEPP5c8qB2IpCFFZm2XQFWtCOaw1MtbcfSIljzTzV/RSp/sX+FMWm
	olgzJMAAVauUpWK4jXB9bHIRnQLRvix2LrBT7uEetOR5+k6e4xSEmsv
X-Received: by 2002:a05:690c:6a0a:b0:7af:6f22:997b with SMTP id 00721157ae682-7b9ed44413bmr81291917b3.32.1776647359977;
        Sun, 19 Apr 2026 18:09:19 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:adbb:6401:d38c:2263])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89da0csm37069397b3.8.2026.04.19.18.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 18:09:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
Date: Sun, 19 Apr 2026 21:09:08 -0400
Message-Id: <14C41D80-ED09-43CF-9C7C-9862BBCEEB33@gmail.com>
References: <27109.13129.424068.382997@chiark.greenend.org.uk>
Cc: Colin Stagner <ask+git@howdoi.land>, git@vger.kernel.org,
 Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub,
 Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
In-Reply-To: <27109.13129.424068.382997@chiark.greenend.org.uk>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
X-Mailer: iPhone Mail (23D8133)

I didn=E2=80=99t see bmc on cc, so added. I think they have some thoughts on=
 how to organize Rust code with Git. Might be relevant, even though this is c=
ontrib/

>=20
> Le 19 avr. 2026 =C3=A0 15:56, Ian Jackson <ijackson@chiark.greenend.org.uk=
> a =C3=A9crit :
>=20
> =EF=BB=BFColin Stagner writes ("Re: [PATCH v2 0/3] contrib/subtree: reduce=
 recursion during split"):
>> That said, a native Rust version of
>> git-subtree-split would be much faster and easier to read.
>=20
> I prototyped something along the lines of the algorithm I described
> earlier.  It is very fast, as expected.
>=20
> The output looks plausible when I look at it by eye, but there are
> some things that I need to look at more closely.  I should think some
> more about invariants and tests.
>=20
> Overall, I think this is worth pursuing.
>=20
>=20
> Algorithm
>=20
> I don't think it is going to be possible to precisely reproduce the
> output of the existing git-subtree split.  Indeed the existing
> git-subtree split is a bit cavalier with metadata (eg `committer` [1])
> which probably ought to be changed in any case.
>=20
> Even so, it should be possible to avoid foolishly rewriting the whole
> history of the subtree, since we can stop at all the merges made by
> "git-subtree merge", which are easily detectable by the extra metadata
> keyword fields in the commit message.
>=20
>=20
> Packaging
>=20
> Before I go much further, how do we think this would best be packaged?
> Currently my experiment is a standalone Rust package using
> dependencies ("crates" as Rust calls thme) from current Debian stable
> ("trixie"). [2]  I haven't tried it with recent deps from upstream
> crates.io.  There is not currently any entanglement with git.git; the
> repository is accessed using libgit2 via Rust's git2 wrapper (and there
> are no tests yet).
>=20
> I'm tempted to continue this way and rewrite the other git-subtree
> subcommands too, since they don't look that hard.  Using git.git
> offers some packaging and testing continuity but the dependency
> situation might become annoying.
>=20
> It will probably be possible to make a Rust package which will build
> with both recent upstream dependencies, and (say) Debian stable.
> Going back much more than that is going to be awkward.
>=20
> I see there's already some Rust in git.git:contrib/libgit-rs but that
> looks like a poc.
>=20
> Regards,
> Ian.
>=20
> [1] I don't think it's justifiable to convert a commit from the
> downstream, into the subtree split version, and retain the original
> committer line.  That can violate many people's expectations.
> Here's an example from another context:
>  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1124226
>=20
> That means we need to use a dummy committer in split commits, and put
> the original committer into the message.  We should name the original
> downstream commit in the commit message too.
>=20
> The dummy committer needs to be a fixed string: changing it would
> cause history proliferation (maybe even leading to unnecessary merge
> conflicts).
>=20
> [2] I wrote a blog post
>=20
>   How to use Rust on Debian (and Ubuntu, etc.)
>   https://diziet.dreamwidth.org/18122.html
>=20
> which explains why this is a good approach.
>=20
> --
> Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.=
 =20
>=20
> Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
> that is a private address which bypasses my fierce spamfilter.
>=20
