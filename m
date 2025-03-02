Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F315A8
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740895520; cv=none; b=Ugol8FmZ17ofbJDfUO5t7z1iaj9bYY/RVB+73c5U0837TgE1QVSM6gd7gQhmBIJoRgrznQ1llW3q1vxWTVZU9GsXfvHWRuph4HniUEYzsmctKOzEy7O9FJuw75eXNzeAwHd5hpEWScsWHbZmU+8Tac7alKuqRHvE6/2miylKcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740895520; c=relaxed/simple;
	bh=40HpKbL/A6qsgltwMNgDlWnJuU72y519tzrLg2tHAvI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SYmWZTxve1ZwuXyfwp0fPO1F6kE1Rp0DP5+9kHSX7q5zrSgzEgB77w7SCzWpQP3mXDjPiXJ2VlEXZYJI63eCTvJb3PDqhZc5SPnwHmE15pTDCcXd7NFkQQfJ3fGbCZ11sDGjosr+yMprzsk0VQBVMgJK+LclBfutfXlVbbWZwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRfQbGNK; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRfQbGNK"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2533198276.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 22:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740895518; x=1741500318; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=40HpKbL/A6qsgltwMNgDlWnJuU72y519tzrLg2tHAvI=;
        b=kRfQbGNKJhc46kbCf/IkcZKUSLtd6BJFcDdsLj3KySGtErnTjJTQelALb5YkhZfuEC
         EJbsJEDPRh4e/m8l8bQdTFPJECx1QzSWwouIhPdYYj+RSKUS7n1jrVx3c1TzeEFsnBFo
         5CIoBnZOS7FfQz7X06Uz3Z5Digv0uK2dXZxP/IHlRGx4DWcEms4aDfRyxX3h33L6Znkk
         Tg01zckdQ5FlOVSScxg1t5Qmnru10h1Hsols6G1V11fme83uPRIRIlRqd1utTZ8b7jkF
         UDSk7ydf72qxmETJ88Xrequ6qDjjXexg80fVg0sjuouAq/KbE+nbLzqb/SftMSzKVZiV
         vWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740895518; x=1741500318;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40HpKbL/A6qsgltwMNgDlWnJuU72y519tzrLg2tHAvI=;
        b=auPxfitg+GUxxemBdazrexqVpMY4vzW0+QV69eo1T1bfdWPFk+aoOcFWLFDgkWZLcj
         JqzMosX/XHxAalFoeYJOjl4vLLfCzddeKQmOiOtBzN7pHNcjPIDdPMxpq5SDVRhRMNKd
         Mc2oaecJMLdAqaTcKeVIX+LiySdCjFKg/i1Eh9u60i6t/fQIjIyjPJpx4R3MZs7nJM6O
         2O6mHH9nR6QwFHe0HQ5u4/WaIu6QLxSZQwRMsTXVrbZaYFu2xC/85XlltDyzB5S3bh/v
         9QW/ZIYbXaRaC2X68AB5igrWUl3DMoXVxrPm+Wrm4TBQ97FLfrUl5mrWMXgNhOXImkHs
         bcLA==
X-Gm-Message-State: AOJu0YzA4VVplEOd+FkQw9T0Yifvpze6tfLw+Ye+5rJoD5wv8UEck7Wa
	+v0B3UYok/WRmBfEB1LCTNsbBnoPRRflB83ytOrSQvId65k21yNkGOLeLbAd
X-Gm-Gg: ASbGnctvHdFI4eSG3gcOiBtz3jliManc15FJfMlP/Vdrd+QcroAk3gEFh1VgGthccUJ
	4NNpP6+Z3saAhoa3Xt7E+YFJhDCIBUhl95NKdyGqUIgDiO9qxlMjwiXKk35VNIJPpPWr+rfuIUh
	I9S4A6zgnfdHYyjnGylaOCZK7EfYpYxymr/LsfaO4Wm44c4MN7QEHAvrta/rAqhtX0HjYEgzpG3
	NhZhA/VqBbPjISzt3PgKWhX0tgjKKiK9bck9QOHssJpulWXymZQkpyc5ah1C0wd9Qh+g5IU/Dy9
	gCEqAFP2jM5X11yaV0ObIpV1uWp1jpmEjhBwcqU+BPDRwxgxiEbwS//ntEcJ61CakWTF2y/gIow
	UeYLAkm1+fCT51sojlsRN1t0FuvMc5/OT/g==
X-Google-Smtp-Source: AGHT+IH5PMJeV+a+GzPJ54xy5HdNyv98C6w1gRXeRuLzN35+33/mwfOHC3qhDfTFmMDTqlYqr8rtoQ==
X-Received: by 2002:a05:6902:1b04:b0:e5d:f944:c6 with SMTP id 3f1490d57ef6-e609ee93aa9mr17199551276.3.1740895518145;
        Sat, 01 Mar 2025 22:05:18 -0800 (PST)
Received: from SEZPR01MB5486.apcprd01.prod.exchangelabs.com ([2603:1046:101:ae::5])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3aa52edsm2198849276.43.2025.03.01.22.05.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 22:05:17 -0800 (PST)
From: li li <li0371859@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GSoC] Add more builtin patterns for userdiff: Add builtin patterns
 for Verilog
Thread-Topic: [GSoC] Add more builtin patterns for userdiff: Add builtin
 patterns for Verilog
Thread-Index: AQHbizi9Vek0tEvt8UyVcAztOKcN9A==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Sun, 2 Mar 2025 06:05:12 +0000
Message-ID:
	<SEZPR01MB5486758C5EE90BB11B604482A3CE2@SEZPR01MB5486.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gZXZlcnlvbmUsCgpJIGFtIG5ldyB0byB0aGUgR2l0IGNvbW11bml0eSBhbmQgd291bGQg
bGlrZSB0byBjb250cmlidXRlLiBJIG5vdGljZWQgdGhhdCB0aGVyZSBhcmUgbm8gYnVpbHRpbiBw
YXR0ZXJucyBmb3IgdGhlIFZlcmlsb2cgbGFuZ3VhZ2UgaW4gYHVzZXJkaWZmLmNgLiBTaW5jZSBJ
IHJlY2VudGx5IHdvcmtlZCBvbiBhIHByb2plY3QgaW52b2x2aW5nIFZlcmlsb2csIEkgZGVjaWRl
ZCB0byBhZGQgc3VwcG9ydCBmb3IgaXQuCgpCZWxvdyBpcyBhIHN1bW1hcnkgb2YgbXkgY2hhbmdl
czoKCjEuIEFkZGVkIFZlcmlsb2cgYnVpbHRpbiBwYXR0ZXJucyB0byBgdXNlcmRpZmYuY2AuCjIu
IFVwZGF0ZWQgdGhlIGRvY3VtZW50YXRpb24gdG8gcmVmbGVjdCB0aGUgbmV3IHBhdHRlcm5zLgoK
SWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIG9yIGZlZWRiYWNrLCBwbGVhc2UgbGV0IG1lIGtu
b3cuIEkgd291bGQgZ3JlYXRseSBhcHByZWNpYXRlIHlvdXIgZ3VpZGFuY2UgdG8gYXZvaWQgYW55
IG1pc3Rha2VzIG9yIGRldG91cnMuCgpUaGFuayB5b3UgdmVyeSBtdWNoIQoKQmVzdCByZWdhcmRz
LApIYW8gQ2hlbm1pbmc=
