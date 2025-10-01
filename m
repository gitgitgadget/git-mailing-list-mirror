Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4732D4817
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344226; cv=none; b=myjO+ryrtk+5BRlE9eCD0xEqCI+Rh3qrwtfFRgHL460Z3dQHJcidWWyRVBi4O7h7OpZv7G+0ZGlim/p0oseySq3QSMW3TrwH0HQKs0LbUKs0wkqC4QhtJGvR40HuseGz6Yk/r7Pa3ny1zXHjV0BYlJ50iQeLkTP/yV5MZdDcrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344226; c=relaxed/simple;
	bh=wjyfBesF1jMigcF8nNM6QA3o6j5nn9df8zGqlBXavec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCmUoMwZt0ec3mJI+t+Z8pZNfpmWFcEBV9LRfpgnKN4u20Arp//MXUzyI50Lx84HhrBl0hccKv9BXT/6Ybtd3QAjFWfSumGEhzKW4P8sxbH8efx8m/YXS1ynN6Kqf2AmJe41kTNeLXoRMBh2AFHaid+uFLvwkcxhgnM95WcM1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLRe7t0p; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLRe7t0p"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3696f1d5102so1382361fa.3
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759344222; x=1759949022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjyfBesF1jMigcF8nNM6QA3o6j5nn9df8zGqlBXavec=;
        b=ZLRe7t0p8+gM+Zz5+kft8Y7vLYHq1wL7OV9HcwgN7RvcNP/NnolTQgaIqWNOry8Te8
         yNI2oWiJQ1EJKMZWYg7rkVwBV3uW1A09RtKCUOV5x1my4VrPs0Tn6MW3MgvQ4Bv0dLOh
         4xO+RFRaJBAoE+B/fbXAzYqUX9xsHMYRBF9fql1T7wseiB+7lPMqrDB+E5NIzMMTVjVv
         c1btWv/reIdvp2Hp55W1qpPs/TdnsdiBUtQNDvrSHJZAFP8VYaJs4DOkOP4g8NWIULXZ
         SA2wf12nYXT8OCCvCXVr5yUA687xb7Jk3WOJc7RMsoNPaFutZj46jiOAidgdekrVvSRh
         df4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759344222; x=1759949022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjyfBesF1jMigcF8nNM6QA3o6j5nn9df8zGqlBXavec=;
        b=kd7NPyJJZ+7/ZGMrC8PebjY2sEq7GgtLa9u0khN7xA4fiG82nDdmR9OcCOboI3iZd4
         O16LzqpCIffPYHnRIRHjCf+bijj33zG4F8Av2heH2UY2dU1dmtSA8KABmUAQk+hXwXKs
         XbB47MH8pyNpXz/RXzGU2Y0hzX90K51JC1NBa7yiImlg6CuAZYhWqMn+H6ZjlJM9pJd6
         4jPTXqG7apReOX/SbnqYSyRVc3xn7kbGTUHl8zbu0eNqb5jfpX+1SqkHZntg6aDNkxox
         KPZf3J2x88c4w/xAD0qZvmkDuZgHSxipTnOQIkHehNvqq8IJEEtpQfDBLjKolKunxgl4
         SwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhkGt6+k/wfVCEoaNLbrvP/agONhxtcJXbrvn7eG+Pp08ZTpskx0iXlKbnbFecwc1GezY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvP7qPBJq2kqFvgmlxzwsGXypB2t56CUvOcQ41yM2NoMHCXVIf
	BLG1qMlbWFmAIGq4SGm19szQLNSL8BA3qquvhrCYSsBoFw3UdkX2TUTyspm/i0EQWLd6DtUoE+n
	YmwoLoyk6EL2Nv/4rr9PB6cPhMni7CjY=
X-Gm-Gg: ASbGncu3rgnuAiA0YxCJMAMRCvQYHy6mSBvSmbOLAB0Lpt3Hz1zZyxImBVHXFtNyKej
	8IbtswyBOSJ9WVQD96g5QziVCqGReQrTSzJjSdi27wFjauMkrRTOSEggsKOCLUTPq1Y3j5lSGYK
	YHDON4qpJxBQUlkqmkwyKb2ew8GkzPRTLgIavEZBM7U/FHIEFVrieqNepmjrGeeTB2GnYfW60dy
	5Fn28OwflexFDg5WKbnwIAJQ4ZrZVsL
X-Google-Smtp-Source: AGHT+IH7vMTkCtSs0fz1iGn8CCyarukF56Bske9kHjEiFm5JTRdk3U/cy/C35wWHQIEbyJOXiyylIQsHJxvuQblvxzU=
X-Received: by 2002:a2e:b8c5:0:b0:36a:1852:f33d with SMTP id
 38308e7fff4ca-373a73e30bbmr14453651fa.28.1759344222098; Wed, 01 Oct 2025
 11:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im> <xmqqikh6h4ma.fsf@gitster.g>
In-Reply-To: <xmqqikh6h4ma.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 1 Oct 2025 12:43:30 -0600
X-Gm-Features: AS18NWANSzENwKu96J-HS7Ygzx1E3OsfoO3SVnpDlUjrjUnnNC0VVKoN2e87qDE
Message-ID: <CAH=ZcbAF6k-=k2K6Zi6a=igsCt=aDmmA7UXUw-PVL1WJNif2-Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Introduce Rust and announce that it will become mandatory
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Elijah Newren <newren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> If I recall the coordination discussion correctly, when people are
> happy with this series, Ezekiel's stuff (not the "xdiff clean-up"
> that is to improve/adjust code that is purely in C without any Rust
> component, which can independently advance without waiting for any
> of these) will be rebuilt on top.

Your understanding is correct. I've dropped my "Introduce Rust" patch
series in favor of Patrick's. Once Patrick's stuff gets merged I'll
work on rebasing my Rust stuff on top.

Aside from a few typos, this patch series looks good to me.
