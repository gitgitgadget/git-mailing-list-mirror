Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DE1DF974
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373404; cv=none; b=iZa/th9bVCh92GE4Jzt5il1k2liUWit+YxebyOBvnn2oepPKsod/ZkdrgbRxO8FgllB0fKoP3NlHQ4aR6GAvo4oU3kP58Em7A5vKn3m780iXz2WaUwNVFmtEmlUhe+qS0bJcNaTCZK50JjaDUhuMRiBz9jN0J47viSgW01RR/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373404; c=relaxed/simple;
	bh=AO0Dh/3XwNwW5yiPf6BL8uZKgt4GRALUiCpAgqzbKzg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+OkgeD7G52qhmK9TCfSFHLE4koKeXhTf3UzSBmctzm92vqHTX4XL9aaVZmFN6y+6hT9b0FNKmktCufKQaOf3NVRL5zFg5T7Z5lVJWfYyOdTxggnLoz/zCbIRPAqR/AplghBG1nfcni0njx9l8yBlaNZhCYwsQQ5VWFAhB3TNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2cF2a4Z; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2cF2a4Z"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a3a8e81897so1895710137.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728373402; x=1728978202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYUPQSS4QqSQj6aF3stvu88epBB31sHYxyGzMBIwsn8=;
        b=f2cF2a4ZgQSxxRdQA0jnMCUjLWtdKBwDIMqPnqKAvzXdUwNuvwiYyvAcdt8QsvxO55
         3zBAmjvBhs7+WgEMtga7W7wV7R3AlTeJNCczVYpTqWMff43DdcJDiZhZewBugxFtV3fa
         66eu1HYakkQtr01DRX9bUHxSX+RC1AbBXccTfzbq7mdnHIGC9Jz+/VrqmXOHQsAmi9lY
         XKEgzvjzve1j4y8au1fAOKW4oYY5uYCVYXp2o1xhhMAgMs7gXGzvUdDMrHDbCS9TTAzL
         P1qiTCWw/XL8+vGonQlTG7BUw55JC14tlS/+MX5UvZpRjNSKOJK8AjnrazHgN/+OexKd
         zvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373402; x=1728978202;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYUPQSS4QqSQj6aF3stvu88epBB31sHYxyGzMBIwsn8=;
        b=rzcRnop8mznL6ELrFosFWZ839QefVnmtzu4rg/O7F0QH2iKjItSTe3V4nC9Zu546eK
         O5Wkk/uJl5V+c6a0fPbeW1RMuKnNhyK5n+7DFz5AFQmn2XFSliEm9taOQRdo9Ciwfwza
         00Z6Q1nZdQKOrwS/uHA/vzQfe8QCFJ4zgkF8aknmILlruk+r66I56B5bj0UtHrHesUiv
         fVDOcuHPRCbMCttriMg4tVT7hwR3KKKwY5RyH/opniJ+pVbsqTm1u4QguzquYTtpxTsH
         rLepizNq1cIeCUSv9QgWcEUBI2qkONxMWkZq7oDc+NfJbYGEJvi4P5LyLuEemx2sC40N
         sAvw==
X-Forwarded-Encrypted: i=1; AJvYcCUx1s98e6GljPL6bZOB65N4gxRVvnLYmgzR7vie9F3q0OFxvP3HtVPKW5sW7e/MDeJWOis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8iIMfFI3Hjyob0MGkZ7AR2i140aMi1zWpaAHpUdHGBK7PJXk
	8aLbXjTuAT5c7E0M1Ccl2opukJQQGjTkzNUjy0z20bCQOlx1ojHsJvGlAH2l7ISSRyMo98frSFz
	XaiWCPLW4Rne5j86cz8Ube/sAaKA=
X-Google-Smtp-Source: AGHT+IFEYBoujT3pTaThz8VorqhYhM+6KSilGd2WH2G20aL01v1VIk/T4udBXAbGTCaU8mkUy5DQXng2zykCH9zUNl8=
X-Received: by 2002:a05:6102:510e:b0:4a3:d2e5:f097 with SMTP id
 ada2fe7eead31-4a405903af0mr13315438137.24.1728373401388; Tue, 08 Oct 2024
 00:43:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Oct 2024 00:43:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Zvj-osCNDMrUQv83@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux> <Zvj-osCNDMrUQv83@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Oct 2024 00:43:20 -0700
Message-ID: <CAOLa=ZQ3Gytt4Lsttxws3DWqbjteJS8mXvZSPzDwBJi_ALS03Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for files backend
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000a127740623f24ad3"

--000000000000a127740623f24ad3
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

[snip]

> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_BAD_REF_CONTENT,
> +				      "cannot read ref file");
> +		goto cleanup;
> +	}
> +

Shouldn't we use `die_errno` here instead? I mean, this is not really a
bad ref content issue. If we don't want to die here, it would still
probably be nice to get the actual issue using `strerror` instead and
use that instead of the generic message we have here.

[snip]

--000000000000a127740623f24ad3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d76486534ea3658f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jRTRwSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODFmQy85VDVMaGxaTzE3WXYxZ1duVGlHd0pkM3lPRgp1K0tMaUJZcmxF
ZGMvcHVsUTMxeENDR0ZhcTR0aEhhVS9ZY0ZybklBTlZOcXR6NE1kYm5INnp4NWE0TlM0Z0xsCnF1
MWQ3Q0pzUHpNazA4T1pnMHVJRmUrcy80OEdFSkcvazk2VlFzZDlja0Z3dTljdjdvL28yem5tVUJh
NzBFT2UKQmVCWTF1L3R5Q3J5RDZVVUpyRWlqUlBISmEzdlhHbEtNajc2SC8zalAvcHhtcmVVM3c5
SzhneWJHUDh3bjZnNwpMLzA4Slg2em41NUhmTUpYcWNIVmpMSFo5RnIwWTBvTTZodjFuNjA4MGpX
NVlHc1pJbW5lSnBqVGJCd0dIUGlRCklpUDEyaU9RQ0gxT05rMzFYQ1UvTzN3dDNhbHhZNVF6TXBJ
TkdGbTNkUXV5ZkdUcW9GNmpQUmhRNk5DZzRTVWwKcXVxclV4bnU3ZDlaUTU1MXlNZDkxa0dpTG02
S3FFckZJejZFdXAxNEI4MitZeVg1M0R2WDZKeTZjRVhoVUZqMQpEbS8rdkJBWklNMnZCeWtNY2RL
Z1lyUzg3Ym8xcWl0ekV5VzRNengzZmlUZWxCK0xHZ2Q3cVJXdVJqK21BRGpnCkNHU0dFcXZ5OTFh
RG4rRkRwTHQ3ZzBrb3ZBamdKSy9nZ2NPV2l4TT0KPXFrSE0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a127740623f24ad3--
