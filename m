Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB92293B44
	for <git@vger.kernel.org>; Fri,  9 May 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798240; cv=none; b=ofLlTTlfDtN5C3wR3nSKn6340DdjWCNFXcBPRGuwgpYi3sWvGEq3RO11V9myBjTr08yjVea/R9ZNUreUDgL8k0MQBR+78mSkrAHtYrl2ZhHJ/+HwcnYBGDdruMZ72sUkJbjxuBlKjlbVq4IN9+bT4jWIIMt1J9XAIiRLB97Qzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798240; c=relaxed/simple;
	bh=AgflAbWZ6W5QkLQLmMiuh+vUB8PXhOXz/strvJIa/EE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pdt9xTtsM54o7BO18pMQqPFcrW3vQNwMiVLCN5SqzHBNvioRcrNHK9Ct6rh76MUtKAi70VXqDVVm3VHeFgnsq2S+YOlMUfsFiqI5x0yRkUVCnP6cyY9X+N1qoYhzbkzkm7tFgrfU0TS+8sxUzb+er9vgksZaVBaTi/ssqjdQ8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz9t1746798206t0e605156
X-QQ-Originating-IP: yyEOFPYIr+3fg6YsQIiqRDRViCOYkHY9T23gdLl9hko=
Received: from smtpclient.apple ( [202.119.43.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 21:43:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4001668109192098052
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2] parse-options: fix xstrdup leak in parse_options_step
 parse-options:984
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <ac89ba0a-b50e-469c-99ce-c70b825ae4af@crinan.ddns.net>
Date: Fri, 9 May 2025 21:43:14 +0800
Cc: Patrick Steinhardt <ps@pks.im>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F0385E0-E5BB-48E0-8E0E-507AB6857CB8@smail.nju.edu.cn>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
 <pull.1954.v2.git.git.1746624294017.gitgitgadget@gmail.com>
 <aB2ejA1tCK9DR1Nq@pks.im>
 <ac89ba0a-b50e-469c-99ce-c70b825ae4af@crinan.ddns.net>
To: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MgQY1K25Ph0mXcCUi90u/1WcapkEId3PXOh97yJ3YBWEefbLxT2YzygD
	eo41z5pG/mHgSwbUev0laKFNWstt07WDn6wSndjAVBigoc35lfQTUYb/mLRgVkj72CpK6Cr
	Dya7zaIT0xtpiw0wgadFk5HQRVnITLGUnLM1ck1XO7B8wJZXys78HOaWrfhoCiVQWYHmEPH
	tF9DNUP54TRJ6Rrc2Voh+q6WrmToKan1G1feuN0sozvW/pkBlfwfyfR6zSQd7pRrWPBofGt
	DhJZtEb8r7SRu9GqQwKkOGisf3Xch8UZHGLSccmMz36fQnciSviHH/R6it9EcOGkJoVGTAo
	ukUh9DRhBMFsEZfRG61ox4kB+j6X7iC5yRGxly2vFTvyV3kDWIn1dZfPJLOTsK7GVLgb6b9
	wDkNX9eKRR8urA5yzF+//ofmky9BvdEpM8k4Zxogx+hmxH84NE7pelChMjw8Nn0MpRgCxDW
	vKdJsLHbucOny2BjOjYjKaU7ovZw322pDJJn/nbm9F7+39yCrulFIUSO0V3wHNCioJ5QTRH
	dcVn0f+qFRwEpb66gT6VGXcZOw08GkZYUdmDfN3izgxa4XVXTqYCFqHe0WSVTLwbxf4AdRj
	Wm35y7Ij3PxRYgboJqxoFvD5OBnZf8+0U50Dd323wGGsnlaKOkE3rsDaUbmqZz5YKYyBVs1
	OVsFDNDBnDImfZf7nAa/qBYNpT/a122L/HLi9bdKgIKJ1r1XqLIJ6p/QvmVY6fXqv3mCmZC
	w4R5PkCOdUy/duxJyErbg+bpIGLBQRxjC8JxrT9J/lE0W2VoGBV6Rcv6j7rcXoVG1+T6CKi
	mqqxr7tzDwunE9r0EUjOivck76n+Pz+I4gvX4efGX8Qado2vypVqFoECmjwfluEs8V7ik79
	mRShLS7sNVz4xqp5DIVd6k4WklV9tRnVTxy4oDmkGgsk0kcWgffogFNAu+f97JuSYT5jQUn
	LBQDz87175VUUUlyFrKCyG+IlZx23aZw8gUTQYln4NInORVsfEF4/nn60
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On 09/05/2025 21:08=EF=BC=8CPhillip Wood <phillip.wood123@gmail.com> =
write=EF=BC=9A
> diff --git a/parse-options.c b/parse-options.c
> index 35fbb3b0d6..9e6e46da27 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -924,12 +924,12 @@ enum parse_opt_result parse_options_step(struct =
parse_opt_ctx_t *ctx,
>                                         if (internal_help && *ctx->opt =
=3D=3D 'h')
>                                                 goto show_usage;
>=20
> -                                        /* fake a short option thing =
to hide the fact that we may have
> +                                        /* move a short option thing =
to hide the fact that we may have
>                                          * started to parse aggregated =
stuff
> -                                         *
> -                                         * This is leaky, too bad.
>                                          */
> -                                        ctx->argv[0] =3D =
xstrdup(ctx->opt - 1);
> +                                        MOVE_ARRAY((char *)arg, =
ctx->opt - 1,
> +                                                   strlen(ctx->opt) + =
2);
> +                                        ctx->argv[0] =3D arg;
>                                         *(char *)ctx->argv[0] =3D '-';
>                                         goto unknown;
>                                 case PARSE_OPT_NON_OPTION:

I=E2=80=99m not sure why git used to use `xtrdup` here instead of =
modifying `arg` directly.
If modifying `arg` is safe, then this is indeed a good solution.=
