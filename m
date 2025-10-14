Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FD3195F1
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447303; cv=none; b=qGp56qrDDbEAheW719aGNkOViQn4J6Oxeows13OELN0IFH2/gvpgSKQSWK5iMJWH+a+uxqi93fp6cCu95QzBqaQZF+XJVbQZpwy0N95P5kTCG79n5YyQI/DyhNdqbePlxgc+DeP2tV+OqHtkS2Yfkfr6xJ7D8w5IB3HitDnxTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447303; c=relaxed/simple;
	bh=k0z4XViZmG1FIFQWnOhIVINZXQ0LmzcZ3zFBW6dOwzQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSUoMazrj195stmiOWDOfyCbgJB4xbJ9PUPlCO8Bb2lmfRh4Aj17wNowN1ox+jtQDCViIggAYHHczsm/eTDcv3g64KtIESI9KdQBXVxrUQ9uLo7USryeZI2zUx7SXVohDs93UCjzZUVOx/E+Q/V/Tcl7uIcUfkn9PEBHVmiHB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPgRvsLg; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPgRvsLg"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b631b435d59so3417818a12.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760447301; x=1761052101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2exrNgMOHSLN3AiZ0AwJxoMj1FgUVRQ9ObE6Nyi2Iu4=;
        b=mPgRvsLg3vlczPyd0+LDJj2x59q0xMDlFy1quHZXGx0ZxQvF6xYYHHKTRfvNgYRlFF
         rkz9S2mYwrMtDW/qzCvzjPuLvdIJyrm4aEL3vSX3ZOJZuBed3BapMtcL0qr/zuXznI5u
         MltxuZcSBxXxVtaYKIRLgrSMFGEg//dGQvoTVkZ2cgnqLsf2piq23AQtbbdKd+dyMItU
         wqnxMQFqhfnutxySJRAy2bUfgScb5peVWk+jk6WCqNOl9dfcgdEF8laWQ1gHE2Q7moLG
         hYnqig8d217ECcLh6oNDW8vrcoV2QGhtHBTRUtIxKqysSP1FvYQgkTVBIIKewxoHIOJt
         xj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447301; x=1761052101;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2exrNgMOHSLN3AiZ0AwJxoMj1FgUVRQ9ObE6Nyi2Iu4=;
        b=e9aD3tz3KdBhKefNLJkCZLVq5OOWH3J+fLIK2czAOVYnDuaRgoku/suHVDL9nKHpOQ
         KuQpcrs1T2HWqiWU/72lVaHcJpiLl84YwYQlR02B/218OI3F6Ts5aEnruDkDTkW7821V
         /zqTW8wrxhbG4uNZKVEgEmIH680H+VNvuk8CHGfnEQLuYNBxwPaArAAwfFFRw3AMwhON
         fMAGlG+r0pcY+rb4MKi8DregvrfVCmceF22tliK2sYRhM4Hs9qbLQcRbnRoxZdyq2LuU
         dloPzMt2zKVQ3wxpZ7+EQ1B+D5Z/3FGlmurwVsDFTLWDoarJzWkgmgFm0P/SNFHgyRlv
         /2iA==
X-Forwarded-Encrypted: i=1; AJvYcCVMs9DOMg6j++g33Ex3PksMR9HESYXUURrfrnl8tPz4I+8qdpMfSb2sTnUzQX4jTreoPlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8yiKCQ1LLPZxb6Y74PoJMr9iY3Tj8vNwQrIpsL2N0pezrB8t
	KhggAA3SkMipEVGeDgWcJvP5T04gQmqboFHwZbmFwboWzobm5VB0pPKcQ9XCYMFcDNV9Bszw4xE
	pNFDd73Ln76AHysbxD8AM8TBoLnOTgFo=
X-Gm-Gg: ASbGncsVUkXPZ3OoWac9F2eL4Y4B8nLd/LN4S8L+sIlPNZh4lgmNcAVNwIWVrCUIrwd
	02VhLTS5VR0jx30nxrCZXhg3jrSVRFDUv1rKoegFlWCMvFmJN3LD/ABaK62bYJdRoD8JYETUzsC
	3+c9E732XnpIsKNd1DL+4A/MnQs8bJbYx3I/9LIlpPO9foksVupB3ugjmeRq2lyDEFQw9GNzBAi
	ZIlU3eKJlr8tbBiuG5Usoe+vaaiuhxy+iTo5KLy0iiyemRDsA3LbloEOTbXgLEt2qkXzng=
X-Google-Smtp-Source: AGHT+IFa0+i5DwdA34+RfvRF7KcVGv/kPq28PS0pLj2j8sC/8RZ+X0kCVoK97JdR/qCXizn4Epo+oGAn6ZJixntjpu8=
X-Received: by 2002:a17:902:f641:b0:27e:edd9:576e with SMTP id
 d9443c01a7336-290273ef199mr285086955ad.30.1760447300763; Tue, 14 Oct 2025
 06:08:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 08:08:18 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 08:08:18 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-10-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im> <20251001-b4-pks-history-builtin-v4-10-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 08:08:18 -0500
X-Gm-Features: AS18NWBn9rAJABp9ocjt3ZDXdlQhkD977LdjAtv0g_4MB4cAFcypkv4pt7WwWyI
Message-ID: <CAOLa=ZQvTxG2Phnitg_=KAs4RxkmKLBbJwKfw_qM8TV9Az3hjw@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] add-patch: add support for in-memory index patching
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000021d8e06411e1419"

--000000000000021d8e06411e1419
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:


[snip]

> @@ -1945,3 +1953,99 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  	add_p_state_clear(&s);
>  	return 0;
>  }
> +
> +int run_add_p_index(struct repository *r,
> +		    struct index_state *index,
> +		    const char *index_file,
> +		    struct interactive_options *opts,
> +		    const char *revision,
> +		    const struct pathspec *ps)
> +{
> +	struct patch_mode mode = {
> +		.apply_args = { "--cached", NULL },
> +		.apply_check_args = { "--cached", NULL },
> +		.prompt_mode = {
> +			N_("Stage mode change [y,n,q,a,d%s,?]? "),
> +			N_("Stage deletion [y,n,q,a,d%s,?]? "),
> +			N_("Stage addition [y,n,q,a,d%s,?]? "),
> +			N_("Stage this hunk [y,n,q,a,d%s,?]? ")

Missing trailing comma.

Rest of the patch looks good.

[snip]

--000000000000021d8e06411e1419
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be8f35ed791ae796_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdVN6d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFk5REFDVmRBejhEV3ZUb1ZPYnQzUGVoU0RlVGN6MwpYS0VERzF6R1RP
RnNUNVV6S0tjUkxFYlpZUW84ai9JVTlzdVZKVU50RmdnTlU4ajYxeU53dXhmemtWQnhRZzVmCmQ0
c25tTk1wcEJTSVVwUVAyM29LR2pOMEU1cE5xM2FZMUR4eEV1R3FWZmtyRDh2NWdhS2REaFU3WS9t
TXdHN20KeUF4Wk5LamIyYjZjN292SG81OVJ1VXBuS0Z0eHZzSm4yWFIxMHM1Z0QwZ2xUQWpzYUkr
OTRQZVFpUEY5Q3FIOAowdmZCMkN4S2Fvd3NlaXpUMzllc1MxR0hvU0hCT1ZGWU9JUGdvZXVvOThl
dEF5UE91ZmgySWM4cXlKYnRYOVNNClNubDNUL0x2Y090b1YyZVZFc3hOTnlqeXFyekRNTzRHUU10
ajlKZFFSM2pBQnRMc2hpRWZSd3RZVW01eWZqZ1cKUWhiUVV4RC9zZ1BOSTBqM2Q3MkkwTGZTdCtU
bWZhOFJxQitZQlJyTzdIZFp4Q09GYnRTa0k2NFpqUjVqSjFPUApJMWU0R28vWHo1MmRhWGJDL1cy
aWlyNVBaMVdVZVNtSm1uRFZkUFpPWkZtZ2lIakh2SGFXSkc1SWYwVlFSWG9CClMzeW9rUGNiY1BR
REJEZllwZldoK1NVNjBlWEEyYzV2anF0ejhCZz0KPXRpYzgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000021d8e06411e1419--
