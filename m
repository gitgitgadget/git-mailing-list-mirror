Received: from mta-sndfb-w07.biglobe.ne.jp (mta-sndfb-w07.biglobe.ne.jp [27.86.113.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65E17994D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=27.86.113.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492378; cv=none; b=hUnbmBW9VLNexgu0jE0SCKCrWx6/k3nzQJQ+GZikDi+aLjpjBG+wX9IkERTG79ri3DyStItHVDbYISI/BymblgboMPEPDVft3gTB84WvOyHPoA6nI0Ey8PYP7JCqTU1vYdjPMRXVenb/PXjCS74IQLOYZ1YFRKvyD304EDXKRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492378; c=relaxed/simple;
	bh=93/3+r3SfMlSdlsu6IYF41gq4MDGtrms7/5D1yFeqBE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ks8IGFoLtowbsAhza7DUFmz3X/hCERlVuGiUjWJB0OmUpowpH1G47ecC/4xx3V5rNyFYG1SFbfzydJ0RJ8PdfYwInHKvfFR/L4YKbJyqA1ELkRu7d4bSXMD3WCTzs0kPPKbTOKx7o7IvbDUtkdEQK18DIMIKlpYhCmLBsNcmbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp; spf=pass smtp.mailfrom=kba.biglobe.ne.jp; dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b=qg1oiWIn; arc=none smtp.client-ip=27.86.113.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b="qg1oiWIn"
Received: from mail.biglobe.ne.jp by mta-snd-w04.biglobe.ne.jp with ESMTP
          id <20240430155240931.PBZB.83843.mail.biglobe.ne.jp@biglobe.ne.jp>;
          Wed, 1 May 2024 00:52:40 +0900
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [BUG] 'ls-files path' fails if absolute path of workdir contains
 NFD (macOS)
From: "Jun. T" <takimoto-j@kba.biglobe.ne.jp>
In-Reply-To: <20240430071247.GB1504@tb-raspi4>
Date: Wed, 1 May 2024 00:52:38 +0900
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <44EB4C2D-5C86-4448-B8D8-3E90F75DB5CB@kba.biglobe.ne.jp>
References: <55D75808-70E0-46FA-906D-C00CD612A262@kba.biglobe.ne.jp>
 <20240430071247.GB1504@tb-raspi4>
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Biglobe-Sender: takimoto-j@kba.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kba.biglobe.ne.jp; s=default-1th84yt82rvi; t=1714492361;
 bh=yZr9ooVyn8Rgq8xQqGT6ajn6GIVdIBEqIdhchlwtXbg=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=qg1oiWIntero61KXXGUrqbguKbMmWFlfrGoENi9zhsvoBIYDBxLpuMRPV4+dLehojeoQB4Zs
 3BkoHMZl3OvFdd2NF15KuQtSsErcstt4bhe/4l1zvvPe7i1qfa2opvydGmly8o17/G8UQ7lxJP
 tXPJUPXbPEJgREbi5Kw4cHc9pMZ8Vx8GX5R7W//I75T/6N3yEztcKL2nnubAhkOHil4hdXmxun
 AAvUNxCCHrZ6QhFtWWOEyoc9zHLbCQw4piQQSk7U6S7ainfncqC5YUEaM4h5lXbhVXLKaOS9jD
 yCFyAjTdQrDFnkywwn40YF7YLZMoS6R0+11zLxvtzZH4L1Xg==


> 2024/04/30 16:12, Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
>=20
> I am familar with the NFC/NFD stuff, but not with get_git_work_tree(),
> at least not yet.
>=20
> If you have a suggestion for a patch, would you like to share it ?

Well, the only thing I can tell is the patch below _seems_ to fix
the _current_ problem. There may be other problems, it may introduce
new problem(s) (such as memory leak), etc.

But I don't know anything about the git internals and have no time
now to investigate further. Sorry.

get_git_work_tree() just returns the value of the_repository->worktree
but I have no idea where this variable is set.

get_git_work_tree() and the_repository->worktree are used in
many places, and I'm not sure changing the function/variable has
no bad side effects or not.

And how to convert into NFC? By precompose_string_if_needed()?
Does this function allocate a new memory for NFC? If so, do we
need to free it at some point?


diff --git a/setup.c b/setup.c
index f4b32f76e3..3f2f3ed016 100644
--- a/setup.c
+++ b/setup.c
@@ -47,7 +47,7 @@ static int abspath_part_inside_repo(char *path)
 	size_t wtlen;
 	char *path0;
 	int off;
-	const char *work_tree =3D get_git_work_tree();
+	const char *work_tree =3D =
precompose_string_if_needed(get_git_work_tree());
 	struct strbuf realpath =3D STRBUF_INIT;
=20
 	if (!work_tree)

