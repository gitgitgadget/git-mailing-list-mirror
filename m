Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A441A8F97
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759007344; cv=none; b=bzql2+gxENuC1961qrnV/GKuvhABtZTFnICSX+jLoweKo8RFqCW6ZDdTNhCXMbUbda/PHgGqD0QGkIa/A4H69OF7CUzmtr5ZfwXYoehuLowJ3So/4bKD4gpdhDnROjS+6V1OsP+wxCXIf7VvrsOc4PIHyhqmxqce6ZjUSURhue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759007344; c=relaxed/simple;
	bh=CEdlSjDwMhfZs3VGdM1QY63KLDtoML3HB/4iG4Ekg4Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ej7n6PrBUEel+hj62ecTM5UOAIeDtvp0z0BPQr7xzC9jIGQErpQDqbwM3YQJqewhtLXHSL5TlRCojLAKYyduBzDS5Dwxpc1hhpBvMJ7kNQzpvzULNdgwcO56Zr6yjllXQZXuukvTDQeAcS/LN0R+LAIeruYocbN0B5UAwvsBUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H21776Kp; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H21776Kp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1759007331; x=1759266531;
	bh=CEdlSjDwMhfZs3VGdM1QY63KLDtoML3HB/4iG4Ekg4Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H21776Kp+uvv75Mls6f8KJA2mUEE9oog/mdoqnh/rv1xN6VNvuhcZkZ1TWVVGeOne
	 lrFeqRvY+jYwRTZO+UD0jZ16VtwruVOwaKuxX8Q4NaPHNrgZpYTZ71Qddi+MsIE+kn
	 RRjeOy0rD2+5NGwbPmOBUbYvwHGPX37bz1CNOjAETlz/xxHVJyhdjj/F9Xw6Q7DDgy
	 wrLOxZm1WSdB780ASxb+8N/SzClwCvS5DLRJgrtf9RAtbxXFLTtjLH/bGuNshCJ/NJ
	 y72FGnfwBtOCH7L6hRKLcYfmyrG00lyFWjbi3btnbweU3woYZUqFAF3+EAr3w8FMfE
	 BSwtPP1TosEig==
Date: Sat, 27 Sep 2025 21:08:44 +0000
To: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
From: Jason Cho <jason11choca@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>, "Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
Message-ID: <KUIfhZpMUwujq7A0Qdiri2OEhWabUXUVVpHZb7o0A-iqAC_46qQd5acUqN9TlkFMGe2t-aY4IXFQCjs6gKsawBCGSazI3QDPigdI7KrRf_A=@proton.me>
In-Reply-To: <aNglDzeOT5_4ZbdV@kitsune.suse.cz>
References: <20250927152824.3132af88@jcubic> <xmqq4isn96s7.fsf@gitster.g> <aNglDzeOT5_4ZbdV@kitsune.suse.cz>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: a909c3ac40775f6dc83423af47e4122b982060c6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> It does not not show its own .git directory as untracked files
>=20
> That can be seen as inconsistent.

Well, I see your point. Since the .git directory is from a git repo, the di=
rectory is ignored by git. Therefore, you want git to also ignore other ite=
ms derived from the repo, including work trees.

However, this is a minor improvement and I suspect your proposed feature ma=
y have an unknown impact.=20

Anyway, what's your real use case? Do you really add hundreds of work trees=
 within the same repo directory so that you hate to see them in git status?
