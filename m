Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01386CA4B
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780737; cv=none; b=Pv1atcXhB9IGCKybP8itF0YOmpMCvmi3ZABOCCIIuRtruFX+XTiH1Gcx/MMLLcCwncXB8vtMxGsZOMa5fo7uD3cwiLwEW3WUhCEG9YbKiF9CpJaN9xjMuHrglEuwYwdyO0jTReAuHu1jubXia+lratenZnypBMcUyLXYZcqP+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780737; c=relaxed/simple;
	bh=xbuPXprcU0RPfKwKVjDhv5rCO+j5qf9RdYLbL0W9t9s=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=IcPJa53b/s3/gPswKWiSPloIdfWYRHjDwGryJoiGVVrT0wePzb1vTcOu8HQ88rx+lJ8cZluJcjPL6hxwQ+u5nte748BMHXYyppFVYOnKKA99lUTGDBHWeZvNOrufTPA8gYQSKP95PW5mB2MYKVEz2FYvEafZbGIeWDome0q52rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgoN8a0p; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgoN8a0p"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70f94fe1e40so28300187b3.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752780734; x=1753385534; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ9x2XaXfI1lHNAwP+t9Mkn9rAGkb05Oa1+jWzrIuX8=;
        b=YgoN8a0pXqx/CHLaHHO7eNmwXxdP7avy+NdjrxOgDx99heGVNKV7D+NukUnvN7ot5K
         U6Z4MI5btW2c9+W6un4JO4QlgKsVyCBudbb0HulPJmptUi9SiAsjVIwFIgZ/L62VvLs6
         9/De1OBURtBK2J5TtFQdSw65fqKawdpNgI3nyklfrt7mniIHEa0t8XT8c/ICvYsSm/VA
         6VHaAOPMaGGxVfzZkUQDeCLt8psdHbOyZvCZ9nbA3za/Vzogzm81iPTeYEUNvxTiXXDl
         g4+3UrY+BTeGWAAp2+98PoT2Hp721abWH5Vd3jifJdX7NsujJCYYQM83hhbeihq1Q6Is
         muKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780734; x=1753385534;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZ9x2XaXfI1lHNAwP+t9Mkn9rAGkb05Oa1+jWzrIuX8=;
        b=hAerS4RPtyYb+VWuCfXYiaLCul8prV6euk/MtuOCqvMySeUuWiKWPsZ2NmbH0Xc/62
         JXunvyRyPr7UmeiRihaeYXeJI8NyZr+4G/O7tmbbiZ52VBX/xtXjGfCAlD7M4JzQmPeN
         39wplKcl4Os0hWwEGzAwxp8secreHAgp6msDnbAX1EmgBikJiOltYQwDrmtVOgZwOy5W
         GwhNz4mLTsX9eS3kvgYHSQy7b3kjoz7eQUogjhNOIKN4U+Bsa3DX8DCHMMih3YTCXlR3
         EC7KSdEAmNX8lX6K1xs389JGYeTniYTY8gXFaDyYoPhv2O7DR3fiYgJIYYIAEHRmAS0q
         XhFw==
X-Forwarded-Encrypted: i=1; AJvYcCUVSH0/yr3yyrLiIwUQHLE3zh4ZbCWPa6w3J+InNoP8oAyKIGDWFJ+DlIDqWiePHbo5rqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhHBvMIEEx8aq+0zG00+cNopZI18Wk084Wh0JQyu8AEv+cEJJ
	iUM3N9j264AEw1R51FupRK+b7CSwaYCsuOvsX9XOZutIrrDK54r+VPU9C6856IiN
X-Gm-Gg: ASbGnctMyu+bi3eINdeac/2dcGXGahnLaCLRlQ+3tgEjJzq1lTSdCyh0ZhpPkYWw8q4
	AgRhHlbxx/nYgRYixONsPchRBY8KfWDS4Zydh+A6+XCgqnsc+21luwUJ5JIk1NsGu7AHMeZFO5K
	iYj+P7QGpwNlWnqMHkKcK4zHz6oa8MsEuLpBV4ANtx57TAbmV1A59QkGvInJknwA3Iqn+Y1v3gr
	uo9mqjyV7MJXIh5tLiYc5E6/rLNbR+ub99s5uOdvyxthVm/D6BHfD+JY6mhBDkV0rJdPMNi70eL
	Ud+a7CTAJ5MFR+sv6nM3oS6f8L8lONHPU9+GMKp1aGJM/Ct04mwFaaflYCj8yAHFYrIvrN2SfKe
	qUwxTQhFrillbs4h5SEHawWIUZByE8meRwcG8EqPTVlgF8G/7lqO6ZujE285k/y0kQ2BY9lJS/R
	dGOFPF
X-Google-Smtp-Source: AGHT+IH+CTS/ilmzh+gWc+RD03DjLl12SBdeWdrh4qsK9+K596yenQzaHrwd8pQcjfLEJ9X5kxhj3g==
X-Received: by 2002:a05:690c:17:b0:70e:61b:afed with SMTP id 00721157ae682-7184f74a2f7mr61713117b3.7.1752780734429;
        Thu, 17 Jul 2025 12:32:14 -0700 (PDT)
Received: from smtpclient.apple (syn-024-241-139-162.biz.spectrum.com. [24.241.139.162])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b52f3sm35842827b3.71.2025.07.17.12.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 12:32:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when used with --git-dir and --work-tree flags on a bare repository
Date: Thu, 17 Jul 2025 15:32:03 -0400
Message-Id: <66D1F0CE-3DBC-45BE-A777-606D50E84094@gmail.com>
References: <xmqq5xfsdv3w.fsf@gitster.g>
Cc: Johannes Sixt <j6t@kdbg.org>, Lidong Yan <yldhome2d2@gmail.com>,
 Bryan Lee <hi@looping.me>, git@vger.kernel.org
In-Reply-To: <xmqq5xfsdv3w.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 16 juil. 2025 =C3=A0 11:17, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFJohannes Sixt <j6t@kdbg.org> writes:
>=20
>> Instead of this complexity, it is most likely a lot easier to fix the
>> origin of the misconception that `pull.autostash` is the correct
>> configuration. After all, it isn't even mentioned in the git-config nor
>> the git-pull man page.
>=20
> git_pull_config() does pay attention to "rebase.autostash". =20
>=20
> Either it is a bug for the code to do so, or it is a bug that the
> documentation does not talk about it. =20
>=20
> The reason why I think "git pull" that pays attention to
> rebase.autostash is a bug is because the user is more likely to be
> much more familiar with both branches involved and more likely to be
> prepared to deal with conflicts potentially created by autostashing
> behaviour when making a private merge or rebase of local branches,
> than when pulling from other repositories.  So those who show
> willingness to accept the responsibility of having to resolve
> conflicts that arise when popping autostashed changes by setting
> rebase.autostash may not want to be cavalier to the same degree when
> running "git pull".  git_pull_config() that pays attention to
> "rebase.autostash" breaks that expectation.

On the other hand, a pull that rebases is (conceptually) a fetch followed by=
 a rebase, and there is a lot of description and teaching of pull as fetch+m=
erge. Breaking that expectation is also unnatural.

I would consider it far more inconsistent if pulls that rebase don=E2=80=99t=
 honor rebase configuration. So put me in the camp that pull should probably=
 respect merge.autostash, too. (I don=E2=80=99t have any opinion about pull.=
autostash, which seems reasonable on the surface.)

>=20
> There is another curiosity.  git_pull_config() does not pay
> attention to "merge.autostash", which seems inconsistent.
>=20
> If I did not have any existing users, I would actually vote to teach
> git_pull_config() stop paying attention to "rebase.autostash", but
> we do not live in an ideal world.  Perhaps rectify this at Git 3.0?
