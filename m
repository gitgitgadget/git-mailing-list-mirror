Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F414290C
	for <git@vger.kernel.org>; Tue, 21 May 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302491; cv=none; b=jt+IADo75nOeRxx1izXIqeKoK6ShMAnZRdHsk98rRQw1on+fHVDJxLKskUhi+5RVvHdvpiqM6bjpYP0RlqWAtXg+r78F8mwMdY4zMGlMuSwVCX5ljoghsnbk65qRp9p6ckpO3974zD8QvGMHfZtHbNYKb9VKryhnfPhr6KgLyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302491; c=relaxed/simple;
	bh=5gulFy91ip8S0GNbCCnwo2DO7E13r452KRUhaXdNH+Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rV93fJInF3aBIGMHYNt05ASlMyNrH6s9pMopd5tUxdaD/y6gkMJJVy+YtrT2844vDEazAlX1OI3uAbTtqD5wXjhTKM+GsiBru+wK+kGJCa9kz67cOGzzXV3rAP1kiuEGsV4KwYfTEe8Vtkq7lAUpWSeo3xQOTYJYOpwW+uqQyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJpd64U/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJpd64U/"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23d3d092a1bso2559104fac.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716302489; x=1716907289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gulFy91ip8S0GNbCCnwo2DO7E13r452KRUhaXdNH+Q=;
        b=FJpd64U/I3XMptPg/Zi0sF2+7zyaPU3tZb4JtUD0lbjGplpRXQ4/0vwVUyW7gVMPgM
         y/70677UQfkd0frTmSAncaONlvNihLVAAqKqCJVuFDyGPPx8osl/H1HQT4F+dsWjouBl
         nSfMBPOGbSNAjeTRwigFN6Nn8HNE3UVbKeWYKxGiW0Qza8b69xbkhc5Tv7m612Ui/+Pk
         1qz5bD3IeIS7BNxvRMxi3KbAZjj1cVTD74XGEeYAIq91uu8ml3hIIvbq+HZfteeGQXAc
         DswlB7uDZcPXOnhbeEbs7nwQ3DBYruvdxgItNvDj7PFOkK469WRRrfzslto+GmuKiDB+
         jz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302489; x=1716907289;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gulFy91ip8S0GNbCCnwo2DO7E13r452KRUhaXdNH+Q=;
        b=Er1bRYKeXcILmNTvnlvL10UTy5LKuZL1F6tme/BNBicfWjoujVdrwfDtWWX1sp5n+h
         W3dJ84mHW2Wxw4R4tMtPF9CNXchhmAdO0V55GNgM5AYb8CdlLJe3xzPKv/DADA8znMp6
         U2yczeIGgaV6mMJmjJzGqvhsldMXgrrEVwwc1fxowI7g0xSnaRJ1wGdb6jfGbSi6hLEh
         V2vs6H4y8qkJYuXB2Rcr9xKU07CxkhP8O21ERB3Fabm48HZAeWJMeoogT15sBEvD7eNw
         FZkBhFOJJIMxfps7FfbjZVub3tDHsa69iTTeekwcPuVsaHimT1Bq8SIdM0h0mTrQclmT
         +93A==
X-Forwarded-Encrypted: i=1; AJvYcCWnJUsS6++E3AvxkCXQ1IOIAV630VvMZg1Ek1RrGKRw6U6W/SghCKfVrUzQFLVp84E4uCR2U9/1vm+y1mPf7QBYo3AC
X-Gm-Message-State: AOJu0Yxtt/X0LOa+VYUv1kju8GDGFTLkxIpP+AE6eBIitbJZE4RjN/bm
	gMNv5UmQjrpfaZsQVGsh1POiUt3jC29to0gfmcg6Pi4w99f5J5sXWxToAX/ACz41i5rpK5322e2
	JqGXN9vsDsOq0Kp0zOZ+62/A6GtE=
X-Google-Smtp-Source: AGHT+IHPx0Qa8+UyL5GIY+1QwD4ItJCcMIwttGyDIEfIlecShZ48VGVagvGPZNXUAgDA9pKA8Orb6Du1lXchIBlFZxk=
X-Received: by 2002:a05:6870:d69c:b0:232:f9da:5cf3 with SMTP id
 586e51a60fabf-24172a77b3dmr34174155fac.15.1716302489242; Tue, 21 May 2024
 07:41:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 May 2024 14:41:27 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <716863a580f9e1ef8ea796c25c97e50c63585a7b.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im> <cover.1715589670.git.ps@pks.im> <716863a580f9e1ef8ea796c25c97e50c63585a7b.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 May 2024 14:41:27 +0000
Message-ID: <CAOLa=ZSC4OF9b1STzEZfPjrJDbee04A-piNZ86kDS_GDij_3Jw@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] reftable/reader: unify indexed and linear seeking
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000032e98f0618f7d0a4"

--00000000000032e98f0618f7d0a4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In `reader_seek_internal()` we either end up doing an indexed seek when
> there is one or a linear seek otherwise. These two code paths are

Are we missing the subject here?

[snip]

--00000000000032e98f0618f7d0a4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9c2100d9c99927bc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aTXNwVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFlNQy8wUlJnTDBMYk5BZlMzRjJxL3RoUGRUS2REcwpwMDlJRVhQdWdt
eUhMR2dTcFp4RjVhZmpGeUNON2tnMmFOdHVXdnJOK0FZYW9wTXRGMzZnRFFidUFIWnRZcnFPClF5
S0FDSTdyN3JHNTZNTkNZemIvM052T20xTS9YOWJrSCtwM28yL3dyakFKNVI5aTZLckF4ZWl1OHRm
b09JVnEKbEZBK2Y5V3FyUDVGQWFKVk81ZXVWYU1LdWppVzZkaFVodjdld0FaS3dMWjE0TWtYbCtP
RFAyTFlabzJMTENJbgpvTDdzUWZtYitNQVV3QWJrbGN0ZUZ4Nzc2SHpONmEweDlHWGloWVM1ajBO
TlhqNTNYZnFvdXpSUUhhSEpTUFVMCmFTTHcvL3pYRUxNZStwalRBdmZwNC9iL0V4VElucmZpZ3VP
R2pocThIQ1ZZOEF1UncyZk9CZWR4M2UyTlhTL0cKWUsrelp4ZTFlWkxObDhXVzNkQ2VDSUpPaStM
UmNqVXV0WTcwdXJPaWU1Zis5dzZ6L0svdzBJVFBnWWEwb3JQUApNWWNTc0Juc084NTloV0U4RS9E
THZFSkhXRWFTNVFmVTQ2Q0FxQ0RRYzR0SEdUN25ySENMdk4rV3lLcUxVSXc0CldBWk11b2thUnhy
TDdWeUkwcTUyVXV0VnNGL0czSW1aZE1pNEQvVT0KPUMrYlkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000032e98f0618f7d0a4--
