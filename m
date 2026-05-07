Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74043BBA18
	for <git@vger.kernel.org>; Thu,  7 May 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158182; cv=none; b=fwzkoltelsjRaOrxXz9Bq4/b0yQz8EdkzIf1VxzeGaFlYYMJCrVDK17ASYwYczZVjyZVd99OACNvnaomLo6qm2YBCwG0BwZDvgc2NqK7tXFTu8Qv31SK/r4Y+NkQV03N4M/bxr2zOgSyOLK4XmVV3KSfZlGG3Ant1+Fcv/9UbzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158182; c=relaxed/simple;
	bh=gYGo37lVasTllOIdGA7t3MWUL6HbCGQXxS3uwwarIzo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OPpoRhrgR7sTFfUYh+0kBz6CdDqdGaTwJrlwBiHDbjduCZXVkMCRgQVgy+yTJBySA7etdoCNxjh35ZB8nIs3YtJiXHWW6TmA2htZiUgm3V8hMnL+GZA/zyfUah+fWTXcXr1mGQB5nA2zoGuf30MYdYdgQxLnYz80/XwfdaV9Lvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fYHiU9tH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fYHiU9tH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778158176; x=1778762976;
	i=johannes.schindelin@gmx.de;
	bh=JKNwiu4h0E3IaQ3InFzbq2GvrnaFexJTbH2n5bgaU6w=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fYHiU9tHvBwlpH5TjV7+awP8Yv2XhCQW9UBgxdnhJ+W4XUzOhg/LnWqCvQ2qHZDB
	 IR4PuHpzqrwRHF7x8HYOq+UzOMagwZUxhBm7OUij8O+rzWz2iSY3aVvj8I6qhFF5t
	 kPMM1ZRY1YqvLY6NY7Zb7LA9dbiaoYvDbjyST5J258+ULsZcFp3XwKrYB60Qk8Umw
	 tzDCGv6LXdEZ7yQmfwmr+UX9z5GbHQV66LW2Wux+OMF3gnoTcHMc+Gev3N4G/3LHv
	 Mq+opywJ6n2YKDesVeXaUoek0bOezpCl6dqH5N+cnWqdmwct1RhTl9ryLcSGJNEpP
	 TkCtqSzENS6R7ryfOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1vIaCs1YUg-00umb9; Thu, 07
 May 2026 14:49:36 +0200
Date: Thu, 7 May 2026 14:49:34 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 1/2] mingw: optionally use legacy (non-POSIX) delete
 semantics
In-Reply-To: <afipTWyj2zVYYqMz@pks.im>
Message-ID: <c980cb5c-cab1-7ff9-d057-8df5e661a5ac@gmx.de>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com> <97508e91b62c91b77447dbba39a84770682591a8.1777380768.git.gitgitgadget@gmail.com> <afipTWyj2zVYYqMz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7gEuSFcFCmhwagNTLkzaRiBRc7KbEK/BNnQNKyF6ckJtUQPwj4F
 +eEnZv6/prgzM+eW4UQmm2cxW6eiDBboQUnpMSL5A5EchK/7MHc3TLhnUIfFgTlnuKvgpcQ
 m75VCCVP0T28l/gIkOF9H3K0vtivlUwHVMSVGAvE0+QwUF4m6CyPl4nn1092LnXtGL41HCd
 ih9zyG8TTKX9NtWCLgYtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3YOmVutOZ6w=;p7IPrLaFFOpdCMoIOaCgSJXyo3+
 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
 FdkmXsspQATUlRXVKEYhYdO15E3YA5pDuMKw=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 7 May 2026, Patrick Steinhardt wrote:

> On Tue, Apr 28, 2026 at 12:52:47PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > =20
> > -	if (DeleteFileW(wpathname))
> > +	if (use_legacy_delete < 0)
> > +		use_legacy_delete =3D !!getenv("GIT_TEST_LEGACY_DELETE");
>=20
> Should this use `git_env_bool()`?

Yes! Will fix in v2.

Ciao,
Johannes
