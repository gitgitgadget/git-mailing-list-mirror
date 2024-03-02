Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDB1B592
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409723; cv=none; b=Jrt1p0za6xCB0/k5G1ywpys9JJt3xwH15FbWuBVCrEoi3++7bZeoM07x03huf5mXh8L49k1efkJDVvncRSBRPloD992jCli3Qo2CvxMRzxZn05hh4H0GTuEg4ggW6qONx6P6w663LntKcknBxm3HTQGU5+RdR87dGqitz2Em47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409723; c=relaxed/simple;
	bh=e3gkmZh/SqWMLpKI+Lsl55oGET7YjNhqvZp8/tMWIhU=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=OvhV5P1ng+kjWgtd+YsMVuBr5Q6zNi0bijrVYvk1sL6npKLMZUnyo0AmxCMq539bxZLsoJyId5jkpVmfbGfPKQCuzCcWLUd5+5l3cc0L6mNXricYvalYI5xcr7b2qi27kS6Cpb+SPFlkPm5Q4BL92INfT6GSq+VqmN/uXHmEp3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inferencium.net; spf=pass smtp.mailfrom=inferencium.net; dkim=pass (2048-bit key) header.d=inferencium.net header.i=@inferencium.net header.b=n9Qj/k8T; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inferencium.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inferencium.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inferencium.net header.i=@inferencium.net header.b="n9Qj/k8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inferencium.net;
	s=protonmail2; t=1709409697; x=1709668897;
	bh=e3gkmZh/SqWMLpKI+Lsl55oGET7YjNhqvZp8/tMWIhU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=n9Qj/k8TylMcSE/8jELurc3eMMtTqawJaLd7U1/8Yfa/gwrOSmR024eMtrSYABh+V
	 OTn9VRbtbBM9KFj/QKt4+VlcVMmkXvQYn+Ti4+MXi3JRKz+J/yIML9UmZyVqBkoD2F
	 fudlUz99M0/97cODtckwd5lEQGMdoFQ8Lvbu9PHlRQCLIJ81l9f1iRC77c5257D4Fx
	 PaSbmovCNhXEzer0ChZ+Z/nXsj9ueIF6Hj3y+OxEXzjy86JbXJRKkMAO/jr04+pIKK
	 DldUi7ypf8m8unejzAb6eiIGRXZx24jqCVqfkibmf0rWW/rnjiUGUhkAa4k+UpqgwW
	 OA3/4nd2P9z7g==
Date: Sat, 02 Mar 2024 20:01:26 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: admin@inferencium.net
Subject: Modernise .gitconfig Signing Block Name
Message-ID: <KfyeAjLLXySd6IEKwEmOvrDqtBIhoCRPon7r8IuUIwPbUhlf8XR0CCmqP3Y5D-8hur57_SFQPqwk0xOA7p0h6xqw48ZMdNbzTBPN2hh9Ph4=@inferencium.net>
Feedback-ID: 40502204:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As SSH has been supported as a signing method for a while now in Git, the b=
lock name `gpg` within `.gitconfig` no longer makes sense as it's not the o=
nly method of signing commits and tags. I propose renaming `[gpg]` to somet=
hing such as `[sig]` or `[sign]`. The current method of achieving this is `=
format =3D ssh` within the `[gpg]` block, which would be the same (hypothet=
ically) as redefining SHA-1 to be SHA-256 via `format =3D sha256` within a =
`[sha1]` block; it really doesn't make sense in 2024 for it to be this way.

The outcome of this would be using `format =3D gpg` or `format =3D ssh` wit=
hin a `[sig]` or `[sign]` block (or whatever anyone comes up with which cou=
ld be better).

For backwards compatibility, `[gpg]` can also be allowed as an alias for th=
e new name. The default could also be `format =3D gpg`, as it's still the m=
ost widely-used signing method.
