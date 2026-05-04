Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B23E5EE6
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919709; cv=none; b=i158QgQPH8GRiuHxI7WLfBLlNtpO0zfGwla/K2oSAEkKIpoxYpC33WKlTklcA8zX0gIFmjyWtSYI7zWPu/0Qki8WZ3b++D2MuXVJy+dS6hStBRm9mWx3SFnDcA/IJV7CnsRHiUmRVXSSV23c9namrXMDb2eaSOvDmzcTpqUUd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919709; c=relaxed/simple;
	bh=emTZFx3ju0B0uQu1q8HcOuYqR0oHVMWlDruZGDpkXc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1yrpIjqBEbSGdnTzGZRykhZtHmSVjsLknuvKTcQtjj+AvhvA22BGADYwuNtAzywVJ9vey4Ep2TUGSy0tGP9ZmBe2dyYIt1owczgQU4wHKPaw3ov2MVJ/S+bbT2PH6RiAoGMeRHGtlfZmCRwjC5MajAOeV8wDjc+IixHfSp1ziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAMRe5jl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAMRe5jl"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ee62a19730so481227185a.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919707; x=1778524507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuqutA/5ZFtt9Y2PzzAZ7LQiWvm8+TX8VNQUP1BNRww=;
        b=IAMRe5jla506T+EvY8g6B8iDG6+HNQ36xbroxcD+fnWeb4KaICEDaSirvnCom4UfgG
         O128DegABJaqvbbxdZptAQiWqEWzzS4+tw9aefe6KDKc9D46YOPwiUHLkKmEFQhp22BX
         Ue74B6bcRVGS3bYN66feZsPheP0Di1MRgmDCF3e/z45Wir6QDwqutYfRRtaueQPSdjrX
         +pkJ9fwuUyC8Loq9klI8Ljap6t9zX0Tmr0L2RcjjUvqCa03roXdHSobAKCnN4Lb8ZQ53
         43hBVrmZUCnUMKOo4ZRhh0xR8DHV7h8TEWX6rrCHP14Z/AXDj1e29J/w0hNRoSOondVX
         ChGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919707; x=1778524507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuqutA/5ZFtt9Y2PzzAZ7LQiWvm8+TX8VNQUP1BNRww=;
        b=BN/ZKeGdqwzwRF5AUIwDe9TS/CpDVxZoK7uMsZ6enpPAbmnNxzDX71xVzIR7oCe8f6
         P1zouQNDWRZz4iv3JMIt8uOkY8OYm570MoY6s+gBFn2a01ASsU6M3IilpOY3G09qHiD6
         rE/oaPSAQyM34GaMgLBup3R4AjFVuCexpxsWjkOFnzJLnE4umVU/+Ou6iFVU/0yR0XHo
         y5Vull+/Taie8zfY+eHCxjHKTy2A28enRcbFQmZ4mmqP1HoGPpp1tF37bXqNxOAXRJ9S
         ridoZuhaUN+Xsd14lPyl0HP7G8sZGw1dWei12+0u6zFOglr0DDwNs1mKdBf7zlzp78le
         mrjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kkaqXiEdj0AXlwWsavklrNw0jrAY2XObkB8u6cBwL6/wsSHMFpwM+YV5HtE9jg5sYXto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgOkXEdoBn1u1SKSDYlM6wDqqlpN6G4ea98KvAQMvR87x27dc
	VFr+j8U40glTXosVLpg0iCRIsgjsTERh84+LrYDEgP4mh4Yy1FUSLmHE
X-Gm-Gg: AeBDiespso6FAnAzpPt9fFK9QFW7+9E3QSU7iXmcfeWI2yaRJNht1P14MaD7S3VCRqR
	Ev+U2ZjeRtV3qi/idUxHAxb9ZKYC9MMtzRrVtRDBmSn3yzn7li6FyrYvGYwWNYZseyZ9QQ8nwVH
	m/Szb1jqh+Tp8BWZOxA7P+lx+6tiLRX88j0fp0BP+p4V6gXD+kMBkTdl2zBvOU7zeYgolhf+QCB
	+b+kER83U1FmHYdjQoKaFInHbJk0m7wt22kOQiOFPN48GdP2u4JwRdUthYAR7CKtFxlbs+XZNG+
	hmTVrqaGJlVKjyqokrCKeC6v3KdrubFLxZwx5dlxFFPH5TcJd20TDHa3MQeyr26bWjCVSNZT/3t
	k01tjjOgZ0xPsuiQUEchVijyOVvAXwo/1oRitfQNTtNvWSC+upG4vypheoVxXno3Ie34fg0Sasq
	y6IhMB8nz9zIZViFZU1pHWnxpvc5j7O3qQtHbzRnaLwZPNKtJ28vFErBinQIgJ50Scq5UNHY8uT
	u5P7rQ1rD3WwuZQNMA=
X-Received: by 2002:a05:620a:19a8:b0:8cf:c4d7:df8 with SMTP id af79cd13be357-8fd163c8e36mr1639298785a.17.1777919706762;
        Mon, 04 May 2026 11:35:06 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29383c15sm1148415985a.6.2026.05.04.11.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 11:35:05 -0700 (PDT)
Message-ID: <42f96e54-7b94-4075-91b1-1c2447b93322@gmail.com>
Date: Mon, 4 May 2026 14:35:05 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] ci: run expensive tests on push builds to
 integration branches
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Jeff King <peff@peff.net>, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/2026 1:08 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Derrick Stolee suggested [1] that expensive tests should be run at a
> regular cadence rather than on every PR iteration. Gate GIT_TEST_LONG
> on push builds to the integration branches (next, master, main, maint)
> so that the EXPENSIVE prereq is satisfied there but not during PR
> validation, where the extra minutes of wall-clock time do not justify
> themselves.
I like that this will be run as part of regular updates to the
important branches. The important bit after that is whether or
not a human pays attention to the signal of these builds.

Junio: Do you pay attention to CI breaks when you push to
'master'?

One way to help this procedure could be to have GitHub CI
failures trigger new issues, which could then be more easily
viewed and noticed by the community watching the repo. This
is of course out-of-scope for this patch series, but could be
considered in the future.

Thanks,
-Stolee

