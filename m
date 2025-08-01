Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62441F2C45
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065691; cv=none; b=Fmefe3jvfKjEOfjjt74edXbk3g5KZL7itF9ScK1tVISVcoAz4aKwAEMdtBjVpGJ+8Z51ZIdOZIgufQ+mHb1SEDDynTNDoO3+DxW3QNAH46Z2n6encOtN/YxCxF4gSoB0ns9GVfiW8fHelpV6Nssa4nygsmqOzif9xNbi4o4pTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065691; c=relaxed/simple;
	bh=HaWlpj/dxprQqDecyyhNCNbLaADl/0cGv8mm6kEcsTY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bp8lDU+xdtrPJAbzxLmvR19ps39o1mqIUfahJbH/5UAgXKi/VxtBa/kJmGoTlGD3suvQ9DAFS1+J8+nJfgLjh2dWjQlIMtEvjb62rQS8y7BKoKhGGlLb6UW46FdVb/dduAO2WAda1r4nK2uOkoUDWo+i43k8h9oVIH/EKcwHZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st; spf=pass smtp.mailfrom=martin.st; dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b=UjYaeYgn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b="UjYaeYgn"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32f1df58f21so17507861fa.3
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martin-st.20230601.gappssmtp.com; s=20230601; t=1754065685; x=1754670485; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f92Qg5fenO3eyZikIbio7ufI9oWp1BoYfcMlWIV9y6A=;
        b=UjYaeYgn2Oddmdc8534L2J0YlTmg0qeWjnNo4n20FuqRjsFRKdu2cTlcVvpED0HV/p
         K5QI9NoUWjIQQ35YCW5F59XWMed4WJeyWobqkE9WYhSIcZA+7qU4czRGXfIh2nhkTVcs
         tDLYAdiDTyKkE4wWObLtK4KHGhzQZZoLFaR9LEEzmtLXz7huP5byvcb63Tdhp9Aw/XV9
         gx8ZDrrUAB/jvf2tPR4cmNWeZio6IiXYQLPcwkvzhezjLTxTv30e/TArR7uHrxHhilJY
         mPWWyqXoJCzN+3JyAFbS9wUKs080wlA65GZhvV1T1nRaGCw9VBFVywh6B0iAifn3/c2X
         P22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065685; x=1754670485;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f92Qg5fenO3eyZikIbio7ufI9oWp1BoYfcMlWIV9y6A=;
        b=mKJ53euw6/myM6LhnsiVM1Kg26KTGleMlgZvPBAEQnIBxW1mOzBX+i+SE11yZt5StA
         EsiBm2bZyGv/VBlcPxNbpkeRRvswpyoCzdJ3A7L3sclAJsUDjIePoHy0rUvFxaqcvw7u
         BcIkDfgKW7zyNyw83K8RNSwVYdFImAYux/4m0p+zdfsy0+D1mlpXDOLQi4oI2UB+224L
         ZV3NBKzHMPIcSTHG2BvGLyRHFfN7PmiCOUev0vi5p6jtxwiuh06mKFuEG1TVrz0FSAvq
         /gIwFc7PNjl2mvPBSpfewNUN5krqv1BmKrb+YnhsZySnvHVsWMYCnuIgpqBzIEv3bVPz
         vN8g==
X-Gm-Message-State: AOJu0YwCRK8XNU2d09Csj/zH2DXCsrguk+eUpPdz0lcLUhlYa5Q4iRMG
	zIPdRr0miAbpZAQtiIVO9goVSmvRjThyvnTjdXAo2+O8KcepX46FDzo5ap/lqBy3IyKvJfYNtCL
	x6wgDQnbj
X-Gm-Gg: ASbGnct6iQeXfKCGdeNpE3G/TgkNt/83U4SBbjYPn5L+rysqio/K1vW+4dyy7MFikyx
	xDA4aYCJk+1SnJ78xQ3c/uluEQJP1o3fkzezbHFHZkYakSOQ4xxyjTxf269Rx5sippv6gGAvIcX
	1AANmoIWsAizhiyRm7nPq8BX61OMnLmmJDvGo0qqOuKQAjDVNqDzWw5mp1IKS51nxhp7CRh5nzd
	J+Yzkw+lmZXStcPYFd4bYJ8f5i7CddNjCr+QsMIRMASLzaJ4vINmBX0bMjWFHDf6i2znRdi6NNe
	dEHeXGMwE8QeCakB+x7QeL7Ae9H7HBqIAVUkbzZmVnba5pgjCYrPzbLHqKlim9QW5UoXri+K/Lc
	8oWB+syBB+o+3KIPOK4Su4lIHxVEP/XMeFe6EqNbEN1csVJyIUbEZVWzaRj3nktsGxBY0AJb3vv
	baJBLBl0akM29UgB0fzQ==
X-Google-Smtp-Source: AGHT+IGqHI1YOB9VT/DaMzRrxo5Bx0ivyoCqIMgCv5GZvmldEc6raUgsxgAaDYWpl2fN18c4UYi5Jw==
X-Received: by 2002:a05:651c:2220:b0:32b:82bf:cc55 with SMTP id 38308e7fff4ca-332567e84damr68411fa.31.1754065684586;
        Fri, 01 Aug 2025 09:28:04 -0700 (PDT)
Received: from tunnel335574-pt.tunnel.tserv24.sto1.ipv6.he.net (tunnel335574-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:11::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332389807eesm6293831fa.88.2025.08.01.09.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:28:03 -0700 (PDT)
Date: Fri, 1 Aug 2025 19:27:59 +0300 (EEST)
From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2] meson: Tolerate errors from git ls-files
 --deduplicate
In-Reply-To: <xmqq34abm3sc.fsf@gitster.g>
Message-ID: <8d86fb70-abd6-1a9d-f5cd-ad4ad7aa8e46@martin.st>
References: <69faab5-43d4-812c-90f-c518ff7f618@martin.st> <20250801075649.1796238-1-martin@martin.st> <xmqq34abm3sc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1443719927-1754065683=:2936788"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1443719927-1754065683=:2936788
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 1 Aug 2025, Junio C Hamano wrote:

> Martin Storsjö <martin@martin.st> writes:
>
>> When using the Meson build system with an old-enough Git version
>
> It would be good to be more specific what you mean by old-enough.
> 93a7d983 (ls-files.c: add --deduplicate option, 2021-01-23) appeared
> in 2.31-rc0, so
>
>    with versions of Git before 2.31
>
> perhaps.

Right, that's even clearer - will resend with amended commit message.

// Martin

--8323329-1443719927-1754065683=:2936788--
