Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173D13A86C
	for <git@vger.kernel.org>; Sat, 24 May 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748104118; cv=none; b=fUSAjm0MwBq72HNRKd15eiNOd0m50CTQLqskLBWjuBZ9q04T1s5ptTzkr+vBrspMMxuWNcKN0PLZxuUO1czxLNs+eBboIsIhs3D2jL8zl26a/on/lC2XXePhjDDEG5shtKJO94wuJ7GJcPvB4+uShyLQt6m7ESoQiuI5vpJHsPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748104118; c=relaxed/simple;
	bh=F/AJ61+gzS4TSQNcTLu59po985PIqRE1zTJy66zpyM0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=cHrPFvs0PdWOQA/rTpQlz9mujtyNCYpcZxkeX52n4mbyJpWSzX78LHQauEBtlYdKQwY4UuMmpBD1T6bd485sGpF5JDKRuDsj1qE18VkpjTzuRQFjnom4h/jIvn7s6q3EQOsDmj2a0RRkDpRR5EDcr2MMLFhVmDtutDRcAR6otvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVQLlatt; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVQLlatt"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso632877276.0
        for <git@vger.kernel.org>; Sat, 24 May 2025 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748104115; x=1748708915; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QEU2YVYN+k8PtKf2BVeWMl8NJFc5ygfXRC5OIw7DFg=;
        b=JVQLlattKk1A28KmpYC7fS3nPaM6RvPT8briD0JlKEpaDgf2tHz1MK2SPe4dy2dlh2
         paL/O5ysqaIIJ8L0eGNhchpRW4gvQKygtqgelzuQxwTICnI5t8HJqvqzfLMc+JNy/Q0x
         FGSF44QwZhLR9AlD5OxagFC9FBh5TnDza2C4xuozkmHX8Uq/rAvC4niiFcCRUpj3zRKJ
         DDL3rOM2gTttgsr8N7iNY8ku3I7StKxQuJjNRomwEJ7086BnCU4PvRXhbwJU4BxiFmK1
         FMot0+SsbP1+no6aEXiM5uxp98Uil2eR11QQSEyxq3qYyueldbdlPncKrwddXX7c+bwn
         YS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748104115; x=1748708915;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QEU2YVYN+k8PtKf2BVeWMl8NJFc5ygfXRC5OIw7DFg=;
        b=bp4wps1I9OTBuActVS7gT1QR/gRXTg5fpIOGnrlK65LMEfWvK6FiHWSnUnUD0UBzR+
         hjYyWiLt2sN5YODMOfxhykngMZF1ZWuTRPXHI1VRsojYwzy6zjCLzL6FPs+PnxXPyQOz
         iULF+k1Rn8MxrPYhLpRXz3IvxBMWdJqNp/pyLOpn8Vnb0ZEkQMFkNtc4rEsAi1uwIozf
         ZDLMuKVQPlj96V1aG5tOScDi+KMhgMRRviZUZpPr9MeCM41qGc7mflBV16deAIV6gPF5
         tn1OXYcJGjjAQBVLmusCTNW7ai54QynJ43dmZRGypRedO5E85vKpWHaY6IsXGMDYY8Ta
         e/9g==
X-Forwarded-Encrypted: i=1; AJvYcCV6cfkkheE7J8H2/SX01DcTBCeMlmDvJwh29O0FjRdm9HvFD7nbzrNeJ9ZQWsqTYRzBDEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLeyl++YhONvPUEPI21HT47KSZXCRnEQeOcaiZn1QYFyyNn4/
	v0HQODv2FfHhY8q0eoKJM8PkiLe6jHYDPTGzKYuUA/uHYav0YXgbE+xS
X-Gm-Gg: ASbGncvf3Mu8OCyzSMxTseoAkivTAOCCjx+COq7G5A3OLbbJdVjaTq5mZrhYPf01h/q
	OClveCPdBggYRIp7ClrG6p3jXxUqmewTSh3lm3LXRDyodrQFxCjkYna43rmANzTuCXbICQiopf/
	6ConjnobfemivdKEAcgEjN4H+yKIzlK8krozgDlp30zlmBKjOnnpTc1rOQ3XhViy3P+0EA92CBj
	PPBUTqEQn9F5ZHxtwkUIsak3acwqkmtM2qIgiUtYej2cc93u4Gw2nBG/s9KXpILJFiQ6hBWEU50
	5hZJrRD40ACL2yIQprFS1psxz/+3uPwPY/GiCFbP6G8ZFxMm4jif8tJ0MHW0vcI/DVsov7y93qg
	nL4OvV3Buyx+CFLq0241Bcknd47P2qYaWr0RoWgQfnpxs
X-Google-Smtp-Source: AGHT+IGF7aY2VScYc0FUjOcWslxn1trakjlakDMkn4R5mFHLEgXydHflxBmcRwNVPY5IUn+/U7DFCQ==
X-Received: by 2002:a05:6902:4a0d:b0:e7d:846d:40b0 with SMTP id 3f1490d57ef6-e7d919b620cmr3355317276.3.1748104115643;
        Sat, 24 May 2025 09:28:35 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6ac877b2sm5957777276.16.2025.05.24.09.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 09:28:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to NULL
Date: Sat, 24 May 2025 12:28:24 -0400
Message-Id: <E78F34A7-359E-4049-9780-30FC290DA7E2@gmail.com>
References: <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
In-Reply-To: <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: iPhone Mail (21F90)


> Le 22 mai 2025 =C3=A0 14:26, Eric Sunshine <sunshine@sunshineco.com> a =C3=
=A9crit :
>=20
>    ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));=

>    free(response);
>    if (ret !=3D strlen(response))
>        return error("IMAP error: sending response failed");
>    return 0;

Apologies if I missed something , but : strlen _after_ free?=
