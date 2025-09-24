Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F949218AB4
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758679976; cv=none; b=uhF2oPPIGbhhsfQxL318cPy1h/qUJ6+4j5ZOuLxAhbPJIGRiLTr/u1iH+QcBAm6cbmH91u+M6QbPiqbHXH2Jfs0RhV4C9xg8Jhu+ts7tdWPb8uqRvl0DVpHrWwgQurumEjJ9z+XUfgS4rEHz+DF/9DgxH0AqE0gUtabEa7CYfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758679976; c=relaxed/simple;
	bh=Dhj8udoPqbkI1cwfFGb5gU56mOtxL7XJTaomW9VPdsw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=NI2cMDhvGKnlB8hnJOdZTYkQXHpTOHKmEb1+raR6+a/Hhq5GorSLvX/kNW8p56a1IkQizFtgEssRWAqqtSiJzl6eX5XbKppndm3NZ7rZ6qjIAQFEG6pd8Kx+SB9J7P7wDIug36G2XziOyDC89jAtahPeEc2jg+i/+kY8CMcLdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FehR7/Ci; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FehR7/Ci"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ea5c77525c4so4725587276.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758679973; x=1759284773; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpLykaVs0gFwZwQiM2E1TA8QCUNEj9nDV+lISFFSBrs=;
        b=FehR7/Cidqy338OZUqon+89FSq8SZV/kr/CAhFiZLmh7jfpmbSuYUlEupVoiWCZoHO
         nT9pGmfCLKMN6KHE4/gjjFNOFA5Gc9ByhBsYqJKWcEHFgWzodQLtD6PjL2rU0Y06Qfyr
         G5MrJmL+jhIm4tKjSgvBo9IfbGbMV6M+LjAKKS/KJ32+m9QdMGPa41UI8JBdzYx80cjM
         R43Q6YpFEaYEcAPSaOlmYFglBPG60KD+sucUnu4Cyr9dCZ+GNvTCJyn4U0dcDKx+RtlY
         A0c4Np7BBmWbyaZhwOhifyAgcO97Bc5cEmVMmC74dzu7iieEPjPdbT7nQIeiJY/6alNq
         Szdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758679973; x=1759284773;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpLykaVs0gFwZwQiM2E1TA8QCUNEj9nDV+lISFFSBrs=;
        b=MUU//jiI4e43XT9YVH1cQzXs1FWaDCeXMxYgL7ninXnfrZMQPpOZUSzEq1+bKOQ2Rp
         cCBAjoB6Yhx4p1mYIMnQTSGxszEbcV9CLPoCnZXovsh//5Q3pHRa/Se2Hg4jl50yOHdQ
         NMJioJLQmwPX5oLTBQkXRXTs0+q6cvUYzlsG2bQmGxs7+WMC0IMO9mDOIvPSMRyiTium
         gYAZsPC1b37ul/R8bA0G5nlu0BZW+YX9mEd1qU9SvyADINgHvKGx3Wzn9LxmMdAZ9uNu
         l1teM6sFROMAvsPfLCufldlD1nqF0xyqTBBt5+zX7D9oamZ5A6ma/lK0mNmiKZ09I6/p
         zZhg==
X-Gm-Message-State: AOJu0YxISPz5KO3yMUB+8SjLUWcLAroVPp1iFpzcBbOkJxJeFn1/MwRW
	WUi8/FycTRoNNET6Zhfxr3es9eipdzQQh+bXY4eVdSYr1X7Wko2ijzJB
X-Gm-Gg: ASbGncsU2fAchWtrOomUbz5TueCVtCuMgGKePSibkg+IradftbvLBC66Ks/sRW7PJPl
	CmxXP7rIym1hQPwwU8GPZV9tInisINWLxBbQNxGJaGxfom3cU+HHfgTkUmX6oOr3JvSt2VLeTkJ
	hd3LzQhenJNi45P32SzoPAi/lfs7wLcBKadD4NpO8RYlJCHt1t3t64kxtjCyXkvmGuRVpXaYPtw
	XFO2EPHgP7Cxic/xdaFZLgtsiNWB6ac1HHcmOfwm+GFliuIw7btDZObVVzRwY0v7qLkkZahQd3U
	dxsW4yrRI47OxEn0oKfJLj44EN9oc0GFsfEpro2O49aySObiAAkdQHcM4PdqS+tPA0Rrz11KIy+
	kuZKQP7r/3oDLZTelVWRqV3UnzgfwOqwoz9Sxrmw5RhO0udSicgw=
X-Google-Smtp-Source: AGHT+IHtS8Uq1Ezf6KBixlp09kr+zeThhm7kCW31zUCiFE7/C5DV4nDeRNM1GZgilUQfxUgt7THMLw==
X-Received: by 2002:a05:6902:15c3:b0:ea9:3bc3:8954 with SMTP id 3f1490d57ef6-eb330775b66mr4285487276.42.1758679973510;
        Tue, 23 Sep 2025 19:12:53 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3535:152d:7414:b233])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce72a110sm5535134276.14.2025.09.23.19.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 19:12:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: 0-Based indexes for git log
Date: Tue, 23 Sep 2025 22:12:42 -0400
Message-Id: <2FAD09B7-4776-483E-90F1-31B031DAC2CA@gmail.com>
References: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
Cc: git@vger.kernel.org
In-Reply-To: <fd7758e5-7719-4bed-b1b3-2137c49cc950@velocifyer.com>
To: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW?=
 =?utf-8?B?8J2Vow==?= <velocifyer@velocifyer.com>
X-Mailer: iPhone Mail (21F90)


> Le 23 sept. 2025 =C3=A0 17:16, =F0=9D=95=8D=F0=9D=95=96=F0=9D=95=9D=F0=9D=95=
=A0=F0=9D=95=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=F0=9D=95=A3 <=
velocifyer@velocifyer.com> a =C3=A9crit :
>=20
> =EF=BB=BFIn git log it uses a 1-based index for the date instead of a 0 ba=
sed index. So it says "Fri Sep 19 14:23:24 2025 -0400" when it should say "Fri=
 Sep 18 14:23:24 2025 -0400" (or "Friday 2025-8-18 14:23:24 (-4:00.00)"  to g=
et a better format)

Are these date formats locale-specific? In both the US English and France Fre=
nch locales I use commonly, the 19th of September in 2025 _is_ a Friday. Sho=
wing 18 would only be confusing.=
