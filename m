Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E552F8E93
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619945; cv=none; b=ZlP54dEV2f/I21V+LX/uRJjLB2GKjWCO++kVarv4MCmz1lNnKAV0Yv0+J/t3QO2LNNJjA9qs+OyMZCmfTUwLrGgd91RLYPVI63dGQICFNmuW2JE2OAZc0P/XKGMyO4DhOyuL2HPXfutPLAgSqDnSNbe/UW9UJBeTLp2QlHwLhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619945; c=relaxed/simple;
	bh=AobG3F98J7ueZXbPkCgDg24ykHpv18Dud8Q2dTq8Bi4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=AsXSAIkgsQTRTOHREBnZxlZD735/YH+pqP7fjNc7BNXWdbReVuKNiCWM/xkL3OUd3EWK7sf+kZYO59KRnHWNlDzDseHJxSUkJ5lhvZYiMk4UN0lLyyf/GzZBBhYWD/oGqDmEFOcGqD2KzhVv0uBYIk4/OFdg6v2hw/Ca6F+kgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlNZThA1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlNZThA1"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8143daf89c7so20942377b3.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 04:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619940; x=1787224740; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J901EixYxDVMNRwL2bQg5LL8otJuo+C0YnEMKxfzLTs=;
        b=WlNZThA1QJAtasWrvtkxyEVhbQOpxrjHVYD/ZXKvcAOFUMgD28HO5jREZblu+ch6kZ
         Ocu2ZkrQxPrL8WMUK7Remkw6gTdDJZwPQaNtDps4GHPOHGxrwBa1LxypIQYTRj/+mH9D
         DxObm5wVIxTE0KzfO586fStkAIQvmbbrxu8lsZgyfL1uquz25WkMqgzVce9qvVgQXoqs
         kNaVpTsvLJV6RA9qPL1/3VwghAPRNSlQgUqfEqjanFLCzsb2yBp11FfISekwtsuKfj8g
         nDd057YmFiX5+CN3Xx+zQtG+kJBG3HQfnZrNZNiitTNtaIdZqHkeJ1xc9bWMboo4r/5n
         Fpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619940; x=1787224740;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J901EixYxDVMNRwL2bQg5LL8otJuo+C0YnEMKxfzLTs=;
        b=mmmNdEi/AQYnmKxguDtNOjyWYtlwmEjNg/DXL8vwrbZhjoPON+lwQ2OzOUpfboyq7C
         PzWtHApY31gasVfF260pgUQFcMVDlK8tqFSd6j13uG8kVQQhBt43SUhisSqs4vHkOEq2
         gQgHibEtpPLQ0u7ETCCiXMwTKYfmP57OwcH4aUwQXk5WRZ4crS/3/ag4rMR1ZWWTLCzP
         HsZx9THQ/Za4qjhTEc+g/n7baJL/7sXXCRiZzkh+7pQhdk+fjWX4AhUyk0YPSS3vNWKr
         7bCo+MJkXRVKRpYd2bG20/PiTtI8DF2725mS1cnD6ZeSUeOLYZQ+Ya+jVI+JkI4A5UrA
         cS/g==
X-Forwarded-Encrypted: i=1; AHgh+Rp3OEuJJJ+8kpM3ik81ASFawhXViCBM/9fkLNVpbgk0kU6rz608IQLL6lTsAL9mcTPPiO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUa8qjE0mRimD+V0b5Hiv+71yMpk+MfO8glfmhwoGg2evQZX+x
	kFletaV2whNku8nNUsolL/ifPC+EvdZl7SRI5RYtER5c037kEuJele98
X-Gm-Gg: AR+sD12X4wlg4IKteoO8AG0j9h8+RgvjNVyKk9aA0sU1C8AQY8/dC/rb9/uY9ew9hRQ
	eB3/7dXBSoplzBNWAE19EtIO5nHqtMaPab7rzjZhjlrIH+4zyDWd3marixNdIaP18e237qHkaq3
	Ohomsj3f/4mmzd8qr+vcWyTyywsk3Y4vX2Mx+fP0ETjKVkirfnpTzQtJpykd6CMrglmN7mgXIl2
	+YBLhzhRW0gv1UGNTusX6udm4RdGnMjFWchC7YUTYV0XlEPr5wa9TyPbYx9zd4tivOjhAfi0LJR
	bFQdyA9Kf6lgdULtqthWuX2Ck4qDgJmteJpB038qE/BF8RM+G+SMva3K2xLii/vjrr4DBhj18i3
	ybcismDZfnmXa2L6/KYAb6RBDT6e3y5CsrvDF6POo5wDQt6LZBo64/usfglPJxM54lxNDWdN2+C
	kvXhzvznga+DuPG5p6UspGgAJT7/cSRzBYCuHYBVutyW5MK70kw1Tzhd2EL/iGS7t74cuFf1f6e
	7ZFttz/H3MNX9HSlC88Jaaj5Wu0otjO58tLaUM3jndH2Vg04rlzkM/4u8ohdZAGmLb1N9uCJQq4
	hONIUncl5k4kyd6c505KxkXWcGydYqauh96h
X-Received: by 2002:a81:8ac1:0:b0:803:6bb9:1753 with SMTP id 00721157ae682-834775bbf6fmr17044707b3.21.1786619940036;
        Thu, 13 Aug 2026 04:19:00 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:40d:fe73:73b0:d337])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8346f704851sm8721407b3.48.2026.08.13.04.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:18:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Date: Thu, 13 Aug 2026 07:18:48 -0400
Message-Id: <2CE87145-D86E-47DF-8761-8FBCFB774C51@gmail.com>
References: <704409ee-0319-7493-cdc9-8cdb0fea1ace@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
In-Reply-To: <704409ee-0319-7493-cdc9-8cdb0fea1ace@gmx.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: iPhone Mail (23D8133)



> Le 13 ao=C3=BBt 2026 =C3=A0 05:04, Johannes Schindelin <johannes.schindeli=
n@gmx.de> a =C3=A9crit :
>=20
> =EF=BB=BFHi Ben,
>=20
> On Wed, 12 Aug 2026, Ben Knoble wrote:
>=20
>>> Le 12 ao=C3=BBt 2026 =C3=A0 15:15, Johannes Schindelin via GitGitGadget
>>> <gitgitgadget@gmail.com> a =C3=A9crit :
>>>=20
>>> [...]
>>>   packfile: fix perf regression with many packs
>>>=20
>>>   This issue was spotted by a Microsoft Git user with the massive
>>>   amount of packfiles typical of an average, long-running monorepo
>>>   checkout.
>>=20
>> As a different kind of intermediate solution, would turning on
>> maintenance for that user=E2=80=99s checkout help? (Not sure that would h=
elp CI
>> clone times unless the server repacks, of course.)
>=20
> I should have clarified that the issue is a _Scalar_ clone. And
> specifically a _Microsoft Git Scalar_ clone.
>=20
> This matters because, for various reasons that I don't want to elaborate
> on because today I'm in need of lifting up my mood, a substantial part of
> Microsoft Git failed to get upstreamed to core Git.
>=20
> One of these is the "shared cache repository", i.e. a bare repository that=

> is established as an alternate of the actual clone, and into which the
> actual scheduled fetches go. For full details, see
> https://github.com/microsoft/git/commit/55226d12ed36 (scalar: do
> initialize `gvfs.sharedCache`, 2021-05-03).
>=20
> Now, maintenance _does_ run, usually, on that shared cache repository
> (being careful not to inadvertently drop objects merely because they're
> unreachable within the shared cache repository). So theoretically, you're
> right that maintenance should help this issue.
>=20
> For reasons (which I don't have the time to find out, but I suspect that
> maintenance simply takes too long and does not finish by the time the
> machine is shut down for the day), it is still not exactly rare to find
> setups with five-digit packfile counts. And since we _can_ handle this
> more gracefully, we should ;-)
>=20
> Ciao,
> Johannes

Thanks, very informative!

What I actually meant, sorry if I wasn=E2=80=99t clear, is that maintenance s=
eems likely to help the local (=C3=A0 la PS1) case more than the clone. But m=
aybe it will suffer from the same =C2=AB takes too long =C2=BB problem, idk.=
