Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD6F18FC92
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733345632; cv=none; b=pqeeLpZfd78DOZGauWg2vpViNCXxMK89SC4ZCW7tfm/SSfewVGj2w1mQWhswGUmv2a7c4z8YSEwZ1tUS84dxpCSHuXddzbYAnr22f59+LjJVvDFOSUrdSom+1RoQeEjicun2bsXxPrWG/ZjO235aDDWgw9HOkLZPcBBAAxT10yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733345632; c=relaxed/simple;
	bh=41+uVxzYyZNIfL8T3C8xOgYBdGdSjEuiUjT0mmIqqI8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHwbTZXhhr8Hdd49WHrEu8Y1GfW79i3eOG+uoHNo7gOhSmjpOtCfmIx9a89wfTLnMeCbgtSI0SrxsC2av+vVTImZgLM0dF9jnLjdghSfarr8wl/n0cm/LlazF5svEl0FlDSmCKeXaNh6Y4zcpYkyg08/pALGJd/A6eS1HFXwHOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv5HwFuU; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv5HwFuU"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4af38d1a28fso43577137.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733345630; x=1733950430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DYu3m1v3c8lOJ4dtcpvzWcMo9RA3Owt+Yunrsh5Zug=;
        b=Wv5HwFuU2YtZ7P4q0lZcBo1yNnOZF7B16pRdbYlmLOIuC718LPja6+4o4HeeeLXhil
         Rlx8WmPTme7yCfnTJOUc+QICGvXqOIv39MQHAp8nEMlQLAqvC5kV2yVU77bZFz0y5I/y
         iM6mhhs35WeuAnAb5WTnZhuLyEW7xyU8toHBshvwX91TZdEBfKKf5dqYW73/lDncVTL3
         IYS4nwcqsF9ssIKmZnqcCmti2XcK9l3CljgltGysuzk3iYE7l1s0gehowjbPumRRH1A/
         Xuc13YbioFOclq5MYVNR7swrSK1M4UFgK+snPDKl7bWnqMzAzGy7i1SSURfM3aBD/Ab0
         28GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733345630; x=1733950430;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DYu3m1v3c8lOJ4dtcpvzWcMo9RA3Owt+Yunrsh5Zug=;
        b=UX0alSUn5s9anZ5xcyTo+GLExV2pSoaj0pQ8aQ9mNmmj2l28F1bdya+b9GUG9zQuZh
         9qwPu1lMM+lkFpYxaLRWrW55MyBbGdlpNEeFllk5y6lGNlBRCo0zjVgnw/pcFW7fnfnE
         1hdpIigJ5+CCOOFEhwaInIyZx6Haj0JKwKH7vwM0XKaho+JbNcvfW1yhyGZAplnTuKad
         dxcJxoGWal81h05CjMPnJtMTiocl2J9g64R0SJjWEk3nQTCBC313nWF1u8FP1NdHeb6P
         KC9s/Is8AT20RRzvXf/cZi3Bld5rLQ8yjKnRPeH8u7C3Co3ahc8WzEMVwZ5NW+Xtl6AM
         FYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCULGx78nZO+iD5ZwRSNu5xn8YafIrAptcnoOIVNUtRbtiJXpY4Ecmm07ft8YvfZPPjQnP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiRk6/Y7n+ZTr7Y8AsGM4kDRDrztI3IIZUoYirMeddl1O5w5P
	AH5/3qdS5V+Pv0tWtE/PnzNjRfriAdq4fMp8p6AjwHji/KdIG6xOxq/J5i/y7K/w5fyGY/kY7+8
	fnsGCZiTMHt1jFLcIQbfaPuEk0/M=
X-Gm-Gg: ASbGnctp9YRn2QEG0IJH+3Yn6ebqlbng+JDoDu4q0QuYzDdSwgVru4sSi/bNC1uX6TK
	hv/E2mI3gwTyqz/kfBV3Sfxr0sEURrkR/Biie9vA8I9bvFxpBa+1NVqbkixp6KJsX
X-Google-Smtp-Source: AGHT+IFaVWnhx1e4wGJKe9K8ZqOOess3oHbGjbbwStOCvxncMcB71ooOZT+UsLMoYExUMp0rolrsL6wD16lZXNOfyPo=
X-Received: by 2002:a05:6102:50a8:b0:4af:5c2e:4426 with SMTP id
 ada2fe7eead31-4af97268489mr11145151137.13.1733345630087; Wed, 04 Dec 2024
 12:53:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Dec 2024 15:53:49 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <fb52ca509da6b7a58d7148e3a15ae222ff209cc6.1733181682.git.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com> <fb52ca509da6b7a58d7148e3a15ae222ff209cc6.1733181682.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Dec 2024 15:53:49 -0500
Message-ID: <CAOLa=ZR9QbEZ15aiEKCFcRaewMw7mWs=5xes+NM=9UJ4_CJo7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] pack-objects: add --name-hash-version option
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, 
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com, 
	jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008e15c7062877fa2e"

--0000000000008e15c7062877fa2e
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

[snip]

> diff --git a/builtin/repack.c b/builtin/repack.c
> index d6bb37e84ae..05e13adb87f 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -58,6 +58,7 @@ struct pack_objects_args {
>  	int no_reuse_object;
>  	int quiet;
>  	int local;
> +	int full_name_hash;
>  	struct list_objects_filter_options filter_options;
>  };
>

This variable doesn't seem to be used anywhere in this commit, and the
following commit replaces it. I'm guessing it is from the previous
version.

[snip]

--0000000000008e15c7062877fa2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 20e4855eb1ba1923_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUXdWc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGtxQy85bFpaNXo1K2FXWmNwQXhLeWNZeGxDZnRQWgpPNlRtUWh3MHRx
K2Z0YnN5Nk1xS29EWktyclpFaTJnNEI5VXFxNDBiRndEaUlMYTduYU80STRPT0VlbG13b1pCCmxo
NDM5MjMrcWcvN21CU0s3NkJ3ZnJxbWd2T3A0RzdFTFpScTk3eWFCSzc2Zno1cWxaeHNxTFlWNE9P
cXRWRGMKdlNBK1l5Qll2RzMvTEhCSnNKeWhsYk9ZRmNFZitITUpXaU5PMDlldGRja3VGTEExVUdj
OUMvRlN5MFhHeUF3OQpPTUNiT0lyS3RZSnFCeE5mZ0N3ZC9IOWdkbnlEdkJVOU5vWmcrUUVZTGJy
QkpnOFRlSU9jSGpqUmFMK2tKTkhaCnJPUGNkZXppRFY0ZTVOekFkMHA2bG1nUXpYMllvMlBJNjkx
eXZOY3hhdmQwZHJZdDI1cGxRQlpaVkgwTERDZDgKU251a0Y0Wjc2YmxLZU1DRmNMZ2NQckRBeWZx
L1R5Qm85RGhHa1VCQnZCNC9qWVlqdzZkdzBTdHhyR2FDVzdhNApCWXBFTGlQSlJtQkNwVnFkaVBv
bk9qUVo2dGJCZTBqZk9NZkFoRi9ReG15cDQ2NHRpS2p6ZlVKSjNJWnBhSGpCCmJMMWVqV3RQYlQ0
dDIzdTZ6TUFiTU9DWi9VVm5sSnpqbDJMWGRwVT0KPU9vcFAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008e15c7062877fa2e--
