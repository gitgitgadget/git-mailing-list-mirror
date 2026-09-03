Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E54CA297
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448460; cv=none; b=JkmsClOeC01MSw7EuWR9qj8JqD4ZoLM8jlC9Q+wS0DnUYLhm3DLVPjf59xLo74v3oDspA+HuFnOXJQpANR3de8++m4kPEEtiS0vOKO/4Drm1Z+nCR4YbTSxLupTdpydFvKpdDaVr1Pzgo76++BnmTv/8T/8igbM3jIkjs9oM5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448460; c=relaxed/simple;
	bh=twfWgHI5LTe6akifaNCN9UwijtERUTGWKyQ3trJgXGY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=TD2ht+K3KKYVRh4cFu/hK+8+m6i0b8bWgclDHp6QUWpjukKQM1ZghA2M74JeJEdXTTH4h9leJNN7MxWhle4Zpqz5Oebh6TAM1d14H7NHCSBfKnBDe4LTGFnMepcVl4cBDLeol8esJw6mlvCupCAQ0m23C6kz1L/gNFNlx9+Zzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1NksU0O; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1NksU0O"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-86d43cdee51so24044257b3.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448458; x=1789053258; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mI+/914WhIHrQ80jy9tiO6mam2OYrnxsth+N5CFwba4=;
        b=G1NksU0OesCdSfAA1+mEiWCun2NBAQStR9dqtnxYYGuk3dDoEkYugPJa5LqV32qCGt
         xE7dOobOGgqc28yLzFD1pzFzJ3fn7XGvNAwj4XFbG3BvGaB06jRzhiATEDacBIPmUJx/
         5j+VD+Yp2cT8L+NKXJvnQDM4/x9RjMAcilbV9N+f5Hq0rBKhqE2prTiMWVqmp/+bPqu6
         BmFbe0t9JC3RMZxRjfi3JGDeVn1mK2JFxTxdutTWqFhfGHUo4iulkxBKQ33gTPVAOVfQ
         r6a+sGbpP+APbiCGbASsy3F9qcOjJ/weGsFeALIULDpQVvQjVILbQ4scxF+TIZRQXp0A
         sifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448458; x=1789053258;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mI+/914WhIHrQ80jy9tiO6mam2OYrnxsth+N5CFwba4=;
        b=Qaxc8bcaDg34bCT7MednHoFNMm56DLEDKbWzbbWAHUXhAk4la3KKZotJFRutqE7frY
         6ntxPz8CzCh0BmBAYFVbG5A1VGKwitSu9+YQ/FwkjBOjvNBEOwMGZk7onTAaYaQ+49Ek
         gOnNLBPjpxK35tVaZI+QKln8bbbDSpTgb35NL3Iv5Vp2ZEWmZS4eGqdXegf/uhbDQD8O
         W84tvrZ9vMMgr1REpPta44XyDPjkSiIfjfXAl4f1zIrZeEP323Inn/BLwCiVymj+xaC8
         U0CUPV3L2GhI20SPMd/jazSc/Oqt/cx7wYLFOt1QfwS9LHVLUDvXasYRlrG9Ukg4U9l2
         o+kA==
X-Forwarded-Encrypted: i=1; AKwUvBwnis1SeZC1fGNZsJxJ7yoGhYZI55QnpbSQ1kxkFYYX2yL1rkBgosx7voz2JcsZ+lptOmk=@vger.kernel.org
X-Gm-Message-State: AFuF++k/+avbjdIhaSQoH1MAVaN6Aa4QCPCWZOdnqOoSnRTjYnMIUMKe
	l33G9EdakQUtN1K3M8flXN1PjbNbIkX8hSanbWYFLNtuCTrMwyHu5zAq
X-Gm-Gg: AYBFou0vxIvMRmiF9U1IhYTG/2CLCoswlIzL9ChMhn9aLLYJk+cIi6KmtGH2DNgQ948
	C1JF11YKbEXNdxueK5x79OqHKnhEGwAMZnG0+tsoOwO3I1F+PRvrWurMx+ajNaD6tDkn2TAtfz0
	jw2QqeEnVukf3hh59Y5Wbwnn+jMli3O5ZaRQumkvowwiAG1GF7wzLisULzIBAYUCEVGgZqft55s
	7Y02FWGHZZAlOp8RO8/v1djSLn74qsbw2jJZ3PtM27cnv7MUUvbD3heMPUgCTDIV3L2+zx/w1OZ
	1Cu7rxQNfSnfIizepWW0UHQ2riRMQnxLAXIhMFGouSNglm93c16bY2FeDQg7C4A0YKjpqMhpwVr
	SKS8iwyY9X4GokYZtBc8hn6J3VV5oLNOSmaWvjTTt8P/FAfkNQTdrSYswI9j/jYd7noohfpjfWA
	EYvrwk2FXVzoj/FVaVwGAMgm4r/zJgGY8QVjdtjuk5A0yebfZM5/+TBC9AKgXPEQzmORA/HgDoY
	k4SmBY0Xmb823jiGIdRz4APKR3c26y0tqDBgulgLkNbUtuCMxWIZtWzX384htJ4N6EKKuHRFnvd
	pYoRQOmfmiivRnUZpFQfd/yHkjMjWZzr6N5KJw==
X-Received: by 2002:a05:690c:67c5:b0:866:e57f:58dd with SMTP id 00721157ae682-870f05c58f2mr3007607b3.21.1788448457509;
        Thu, 03 Sep 2026 08:14:17 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:494e:2119:a9dd:edd9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c10c94674sm41952137b3.8.2026.09.03.08.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:14:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [Bug] Porcelain allows creation of '@' branch
Date: Thu, 3 Sep 2026 11:14:05 -0400
Message-Id: <E4F5C2BA-B083-42F6-A7B1-93A5FB984604@gmail.com>
References: <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, Jeff King <peff@peff.net>
In-Reply-To: <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
To: =?utf-8?Q?Bence_Cs=C3=B3k=C3=A1s?= <bence.csokas@arm.com>
X-Mailer: iPhone Mail (23D8133)


> Le 3 sept. 2026 =C3=A0 08:36, Bence Cs=C3=B3k=C3=A1s <bence.csokas@arm.com=
> a =C3=A9crit :
>=20
> =EF=BB=BFOn 2026. 09. 03. 10:38, Kristoffer Haugsbakk wrote:
>> Not a bug (2024) https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster.g/
>>=20
>>     I suspect that it is much more productive to deprecate and remove
>>     "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
>>     does not act as a synonym for "refs/remotes/origin/HEAD"). [...]
> I would not want to see @ removed, I have abandoned using HEAD years
> ago, too much typing (especially if you want to express more complex
> things, e.g. `git range-diff long-branch-name{^..otherbranch,..@}`, to
> pick an example out of my bash-history).

Ditto, though thanks for digging up the reference. It will surely be importa=
nt to justify when proposing to tighten the branch-mode rules.=20=
