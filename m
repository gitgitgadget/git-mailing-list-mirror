Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F9224B1B
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026202; cv=none; b=B/PYo92gQW/Kgw6KLmM35KHZg1w1TP69r98LuyUNHDtw+dTFXrk6KTwreRbcCijCvn2WoVHDsQMVT8/e2X9A9XHuqHoznUKfHIT1lVCE9xpnhaCsXUy48NHoARGUnVTvFRfpcdiacgLuBUuczGu9r8U0UGPpmVHO4d12bvaHQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026202; c=relaxed/simple;
	bh=lpYgjFiOsWO2hD34LBsEyZYYuVcCVSP3sRe+KCJmjkM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FRlKWVB9zgUSX0s8NoJkq37XhdymDODJFvcP7dfY/U4NWV5p914goiVVasTx12IbvvJ7MgkgZ5tTMtODSpHoPpJlctcBdpXGdGVt3FGRtHvsZbuaxV+zRmxgPoFhpkBEcfAwN9QeEal7wqx1ZWRSnyavY7Y2ulmUXHmjJQUOpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhFOoPvo; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhFOoPvo"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6432842cafdso137927d50.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 18:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766026199; x=1766630999; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpYgjFiOsWO2hD34LBsEyZYYuVcCVSP3sRe+KCJmjkM=;
        b=JhFOoPvoAeWOv80wFs2oM34ymJsmMgZ5Xv8Nw8oyeX9gYQIntiDxaClNz3owy9P0rE
         bug6IQNZS/9yghr5NnlqoMenegfmaBhXPkx6gTxRfeTUn5rlViFXaBG8a5eijRnSwL+L
         Leb1uotcZBWFVHfJGB+4ttsUq3H3py7GjYxXZm7NqmzMN+GrSrooAqr05zbBdtC4N3fh
         tlw1FdunvIlnlVQVU/sIinYsVqIBmih18RjeSkrH9+c27gXIuRjhB23URvJ+frN8yiR/
         CrjKNyej+1sQslNiFhkviFn+dOI9fOf9A3GwYvmabbm2BwOurvxeLbnABBPAPbvDjZO3
         RR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766026199; x=1766630999;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lpYgjFiOsWO2hD34LBsEyZYYuVcCVSP3sRe+KCJmjkM=;
        b=qJZqEER+94lNMjyLxUUorKmbGyglvnGE5ebav1osS2S8Dpo09vzczjczdwAS65ckqe
         YK+R4CY3D/jUpur6ohTNDCPj2tc1xQGkADkRidrCoGyK41Xh5SQcefn2XAZRHF26iChD
         NwyrYc8QYvXGNsOGC82MZwOBsrldBPCLJxjc8J5m9UE2CbCjU5L0ntNDauUqFKwAHA4A
         kbo9K3ceWIZEkZZsyIS9ywZZEeWRWxjYX0E36NJ6P/6GlVXFcZw416aQDgi/Tb9I+B8n
         f+juYSpR8zuhZjBxJvuxlpZIaP5NovPE11yuAyj/4pAgZyvBkcSqGOVqBnQ904EjarkI
         cHWQ==
X-Gm-Message-State: AOJu0YyqUrYArp/bWANXj+FnhF/DeDr7SNSgNzRSbQrbsNgeP917TWID
	fNDYVtjzHPPQFeoXM707qfjazVULtr8DGdI7LmTp5nDHn57G17Vhsxyq/LHnrw==
X-Gm-Gg: AY/fxX7WEWHyhex8vVCJgk86xkOyT9JwwJ4phYatXqoVWkSiP/d83fRVqNXZkgLju4m
	EZXrISv2am8BWJmRKo2gOSdGTVDyGMB1ucIvjnuL5cPuYiObLfhRNC2lHEhigAZHT+XaaNZzTEB
	QmJ7pibhLjyXxGamlbB0/KiamImvkZfAszAh59GmNbT+0pJN3eqzb8JiQQbaB0OTdni+AxEYtgu
	sXtsrb+alG2cFw1cAqSOiF0j21uJWFLBl4ZXYEazUQRW3pYsU/2f5yBndQWyvPSUrJgps8LLu44
	p5UByccDZddD0kZopJr9TS7GRJyfc0mYu+gUPixjA9teXSvEt7Ho1rK6dewgtI2tjaBsRHehSuQ
	ClQvqLwsWviK/cCA4/8hH/gEk5plDf134ieEyGUojck1WWDk26idbGzK+Op+FOzJPv6fH/SImgU
	kFHWAq6HE/wdTuqxSjQvK0+0fK08uLsQHWtiwEZjo=
X-Google-Smtp-Source: AGHT+IFrpszb13v3CrqFdIW3duONAsmBMWtqSzEbowg0wzZIHMzPOQ0wa5gx0MeKu7G5Ie07WKHqkw==
X-Received: by 2002:a53:a105:0:b0:645:53d0:2d20 with SMTP id 956f58d0204a3-6455564ea0bmr11111091d50.62.1766026199297;
        Wed, 17 Dec 2025 18:49:59 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:5982:24ab:62e1:eea6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-646636f793asm511178d50.6.2025.12.17.18.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 18:49:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/18] mingw: handle symlinks to directories in `mingw_unlink()`
Date: Wed, 17 Dec 2025 21:49:47 -0500
Message-Id: <20488887-14B7-4471-9241-9CDBC3EAB2E8@gmail.com>
References: <282aba42e8aeed336318614523ff8b36d3131e5f.1765980535.git.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
 Karsten Blees <blees@dcon.de>
In-Reply-To: <282aba42e8aeed336318614523ff8b36d3131e5f.1765980535.git.gitgitgadget@gmail.com>
To: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 17 d=C3=A9c. 2025 =C3=A0 09:17, Karsten Blees via GitGitGadget <gitgitg=
adget@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Karsten Blees <blees@dcon.de>
>=20
> The `_wunlink()` and `DeleteFileW()` functions refuse to delete symlinks
> to directories on Windows; The error code woutl be `ERROR_ACCESS_DENIED`

Casually reading; spotted =E2=80=9Cwoutl.=E2=80=9D Presumably would?=
