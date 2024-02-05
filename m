Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567D20DC9
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138525; cv=none; b=EShKzDq+64LMt4w/ZJ4Gj7XhFO6esZmdQoeDb81Hr1QlKT73KLP5VhX7Nj6tNBBMd+2Oy0O0NUrK1A+qTRhSFs0XUdHv429QvUApjbij816YWiRkAsn0AyNcy06MzT8QEAFvM8CtG78HjdcelPMt3RMXIQY0STUB319KUxD1lU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138525; c=relaxed/simple;
	bh=M9GRJHhEYk6OtxfZgc0rJG3EmAJc3ECg5oiRP1Dp9hQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCF+zgokEnKdUaSF65hwspzmbxeErY8dEY57v7O/RCxbpgost+xZhr7HCvmOGvvZWa82rG863QFKKsNOh6YNNrkcAx4ohSvp5EE0AGs4p84nmnMcFormteh1X2Z5KDdTfzqP2l0uFbe4x4X375t6IcOHovBTxeER27tQLLEaGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK5EBT5C; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK5EBT5C"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-214def5da12so2800395fac.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138523; x=1707743323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9GRJHhEYk6OtxfZgc0rJG3EmAJc3ECg5oiRP1Dp9hQ=;
        b=hK5EBT5CpCWtmG+3kfaam/2/fBP4eWIW3/XAZRP8h9fCk8c+36vpIPYXGNTeoJUTZZ
         SPV5/8xMjqykp1OO2An6Yq/v27DCCGK0YWES6il1CPPv36Kah7/atrJTtUXK8mJGLd+d
         aII5iQNm3yKsGsHlJMDuUgSjk+CEJ+ccXvHhT4Q1OmbpYT5Bg1m+ARGGlkvTrs8qcT8x
         MGbewMYyQsiSQnqGFbYXjBJuO2wxpmuC9Xf5mzJV7ycfKm0qJgIH0wHMBFLJRp+3yj+m
         ZltMEaf+i7dVjnIHi/7mTFc4QbwNgn0bzqH/462YaONMz3JBWchQpLR1K8QA7ifBOsrZ
         WNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138523; x=1707743323;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9GRJHhEYk6OtxfZgc0rJG3EmAJc3ECg5oiRP1Dp9hQ=;
        b=BEPsz4ZDETRIOSYxVSek5y7NldN/cxCaLJb8G96I/JzptC03ogS9KoFeGbOv7R98nA
         JFiqXv62pP1sz/dA+0IjImHB4t3d56/UVeXEJA8fWHXTsxZuih7fRtUEbFGjb9/Xu4ir
         4yrdqnxlgpvjn2UutgtArIO+NkKKo8MiwVDMkJIpe8bLgYO6X/1u3eZv6gdXp6IsdjKt
         9z6FdpfxiZut9+DMvpwZPpjeiXN7fzy8gQ/Yo/ZJs/XB6TY9poDLQPLQijV2TQa0myIJ
         hc5DKsll0JGDOMzkHd1WpqN/X1mNzSyGDPGTuc+GHj4CkhkA6/jmScUtOW9p1ZUWNUc/
         buOg==
X-Gm-Message-State: AOJu0Yy/zH3EKNymNj1M74E1xtkre+1Ii1SmFaiGGDaF0xcIBT8WUiWD
	Uvdl9kKTLcNC6Pto0+D/9ionzRrq5GkWxeQh9hJz7muO/7sKUGefSY0CmmamXGdQttLcII0+FAv
	EaEu+BDny5aBM4DqWmKiXdVKFQsI7tDXZ
X-Google-Smtp-Source: AGHT+IFisNE/enn2tNV6nsBOTXDSLWfE5M8gNdBw6CahUftpnHGSkpCTmM1mnT5/zbw8c47gF3KZ55Vs9LWm2VUnsvc=
X-Received: by 2002:a05:6871:825:b0:219:2209:6448 with SMTP id
 q37-20020a056871082500b0021922096448mr8692903oap.25.1707138523177; Mon, 05
 Feb 2024 05:08:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Feb 2024 05:08:42 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im> <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Feb 2024 05:08:42 -0800
Message-ID: <CAOLa=ZTZAC7ZNrpexiSbfW_-hoaW6iV3rbimqTGX2-7qY_pEHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] reftable: fixes and optimizations (pt.2)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000041be790610a229ed"

--00000000000041be790610a229ed
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

Hello,

> Hi,
>
> this is the third version of my patch series that contains additional
> fixes and optimizations for the reftable library.
>

I have reviewed this version and have nothing to add. Thanks!

--00000000000041be790610a229ed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bdf51711cad4f642_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YQTNkWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK09VQy85L24vRnZUNEs0NTNCWWoxNTdROEsxUHNmUgpwdXV2bnV5bVdF
dFBtQ2hJeXJtckpORDl5SUdoSElCOUZ4bnp5WFlxc2RocElwYTJQMGVGYldpK0xPUVkyQnh4Clkx
OFpBVFJqMHFnaHNwRXdobVU0ZHdQanZIK0xZVEloVHJXdmQwcCtQRWJ6QlJKQkVCa2d1Mlc5czhP
dGRvY3IKUG9VcHhZZnQ4OFJNSTdiQjJyQzN5Njg2dTdvaEFVdHFLdzlBdG1aQmltVWQ4SEk4WUth
NUFGN1kxQUxpVEJFUQp6MnljbXR2NUhJckJaNGxpQUplcXN5M2JndFhOOC8xczZJMFkxd0Q0WUsx
Wit4dXJuVk9icFZ3OUVlYS9KS3ZQCmhybGlCelBLczdIYXpFd1VPNmNFUHFDd2M0c2pDQnZjNEM2
SUR1cWNSelM5dXFOTGdSTXFUbWV0NmJ4b3dTUzUKT2d0RE8wSm5zcWxBV1orS0N4SmxZTng1YzZu
WGw4QVhYMmFEK25LTnM3aEJLQUkzUGFEUEExbUQ3SVk0bklqdQpKOWNoZnFoUkFta3ovSHlSN1pL
VkplcDdjU3YrUGZlMEo2RmtHVzZzUEI2OFBjWnZrTU9uMDViN1FPYWZsczRRClZTbnFJenRhVkh2
SzNWTmhzeVBZSlU1bzkvWjhjVlgwTkhpcnlrOD0KPVVLSmEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000041be790610a229ed--
