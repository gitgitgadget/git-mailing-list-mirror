Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09821D5CC6
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016412; cv=none; b=PpHPOBtzxN8BKKBuoqFoMZK7QbxcTKZ8zSKuI2PheInuZGruWfL+eY0OBeHsSW45w0IVGSUw+FYhLep/ihHt5mSSTLKGpP5DzGuTDizzpgDsUQzUQzMMKK6qaLwsxz1Yyh7masy6gyflMcRuju5whETjz51XXeqKZ0QLViloJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016412; c=relaxed/simple;
	bh=QqWm9S9jhOl+vZ1pWPmnpFMyRQZQBLvg065CzkkkmFQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG73/7lX2yGetcK5dtcDT2wagM4wyAuMucU2ze/pbHxcnWqc3JpSauxXUiFa682Kqnu45A6LS3lr9RtH/8aA8o8XgTXsoKVjGIuAITUjEIqpHI2oiLj/KNVwj3/c4ZEXptlD3IDvRq/JM6+qGtpLA42ys1P8OaM8JHzvSHwrLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHk6VL8x; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHk6VL8x"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166360285dso10712835ad.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 00:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737016410; x=1737621210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QqWm9S9jhOl+vZ1pWPmnpFMyRQZQBLvg065CzkkkmFQ=;
        b=mHk6VL8xE3WzgXywo/6BfJG0bWr4fCwwwNGjjXrefDIXKrprgPPPpFPfulh6sIH+2Y
         Dqe1++NBaArkRcNVL+D/Py5y6Uib5JWJxR4sLGdw4xctn+3EgU/oE5FRLih+IKXP1Uqr
         yNPipZYI78DFpYPfHvfNxb9fcuJOXB1R6Oy74EwikfbcEwiCKWS7y8yOUdAi1cq3FdiZ
         i6reNEDLrseAyUCD1mpKiqxY6/ztKnCg4otiAxaG1QC4sVD4iXfMSTuj8ZILK5yQHr5y
         OZSxjfOPJVJYMDxdPziHfiv4MQJ1HnQSrC+SsK0ITMZr7qLQR1wwjdi1EdUDzjnHrnaT
         xUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737016410; x=1737621210;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqWm9S9jhOl+vZ1pWPmnpFMyRQZQBLvg065CzkkkmFQ=;
        b=rZwvJkeUSW6v3wRF/ofJkxN2TM1oBzcwMRV7GD4ESMHpdFvce9FZSftjMdVVpcmmIa
         D/oXPA0otPwenlMCh2mn0wIP0zLB7nHzM/G1KPusJv5xaBsXhVyax1Dd2Ewi9ksl6cub
         VjatRKz7/aYmJEAc+JVw9QkYYL23W6WiMeaFfO48xzjgeQm8i6Yxag6AwagIy9ENjZU+
         +ebvhW4S81nnAyAGlSi0QUo0DPKlbGme0tpkR6wcZqlLYakWvlAYjTOUvSTQ0GJDwNqz
         4zCQZCT72rsGrmHTzTOmAMVmNfDu5t1b9gzUrgKlOwupoIzvlJwAqSsHvsWuC7TGr+Uv
         EObw==
X-Gm-Message-State: AOJu0YwEn2luJcqn0R9otaoHTp4TJi/QZRLJ1sTd93R4zLn+0dbTendg
	b5N57wE+KqTeUToLSFhQ87Yp5ywx9EpJE++zimPsgvNhEXzcME5E+wRa4zd+fEgsJvnKpiTz7au
	FXhPT8HP5fR9/1IwgwOQpieB0jgcSXzA4
X-Gm-Gg: ASbGnct8IuKHQFEduDJJlbrgSHd21H7wpWXJpFdMssqo/ZeZm+u/Tr6OPd1EQO21hLo
	ZEq5yYeV/tsPIIhpLltcPELzZ32oPWKzaVMRPllk=
X-Google-Smtp-Source: AGHT+IFvxpG+NXOv5A61dlna5CmaooAZCvDGOP8XxvAMiHbXIUjYyukEW8QxS6g9Ry48NRSRx6mod/mbSXzX5TGc5mc=
X-Received: by 2002:a17:902:e84c:b0:215:4757:9ef3 with SMTP id
 d9443c01a7336-21a83f338b0mr445458165ad.9.1737016409678; Thu, 16 Jan 2025
 00:33:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jan 2025 03:33:27 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4foAvj_5meT-a4P@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-3-614a2158e34e@pks.im>
 <CAOLa=ZTvW2T3rds3YN0m9iWQC+sAaSCsiRw+fo57FqqF24pMaQ@mail.gmail.com> <Z4foAvj_5meT-a4P@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jan 2025 03:33:27 -0500
X-Gm-Features: AbW1kvbjmwImcrs4QUkegi1ikS1xkDZEC1hhYvNjhoPiBhyefJvLNeQv9vTZJoo
Message-ID: <CAOLa=ZSPen6zhAQGmwVVZRDxO5ZWJ2==ABNYsma_VbXP=7JLJw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] compat: introduce new "zlib.h" header
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000001180e1062bcea66e"

--0000000000001180e1062bcea66e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 15, 2025 at 02:00:15PM +0000, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > Introduce a new "compat/zlib-compat.h" header that we include instead of
>> > including <zlib.h> directly. This will allow us to wire up zlib-ng as an
>> > alternative backend for zlib compression in a subsequent commit.
>> >
>> > Note that we cannot just call the file "compat/zlib.h", as that may
>> > otherwise cause us to include that file instead of <zlib.h>.
>> >
>>
>> TIL. This would be an issue if we added "compat/" to the list of paths
>> the compiler checks for headers no? I couldn't find anything in our
>> Makefile doing this, or did I miss it?
>
> You did :) Most platforms don't, but we do with MinGW and Windows. This
> is done in "config.mak.uname", which is probably why you missed it.
>

Right! Thanks for clarifying :)

> Patrick

--0000000000001180e1062bcea66e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6732caae053dd6ff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSXhGVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWZmQy8wVjFTQVFYQXFIVlZrbFBBMldyV2VBb2ovVgo2Wk5TVGpvWWJj
d0U2TGxuZzVya3NXT3lMeDh2ZUxpRTdzTW9KZW5mbUZ6eWRFYWVhcjM2YWtsNU5LZTZzenVHCnI5
Rm9IZGNKREdSbWd1SXZGOHNKdGVSdDlwRjdQZ2FzVzZWQWQwQ2hvdDIzTzdmVW8wTitVTlg5bzBs
YzhMUWkKenVsYzFyQnpGMURhc2FCMEFqUDhQTjR6QzIvc2RNc1FqWjhsZ3h0ZktXRlo2L2xvNHph
RXdOWHllOGtWbHpLQwp0WkRtSlQxek9JaytHR3ZXQkhYWktxbUh0b0g3UlNZa1pYS3ljc3ZFNW4x
OS8zTlVjNGtRdHRJcFJURGhRSGh1Cnh1S3hVSzJpWmdFZVVmZDZjRytTa0QreW91U0ZDNjIzRjJP
dnlTbVdHTHRObWFuYzdaVjMyempGanJYaXhRUnUKN0RyTUE2UTNiTVU4WUdxOTVaOEF6eU5pUjJx
VmxlYnpsUmdndHNsdVdFTjF3SXRuNGp2MzBmR3dwYWlpOE1kYgpIVnFpWGpRN2VUSTU5VmVVVUxa
bGx1ekFZTDI4NVhKbzNNNGpUVDFVZitrZGYyNldqUlRGMlNIRWFwL1RzY3BGCkdPWUFrNFlZYndx
NGFqcUVHcFV2cXBZVWxrZ1RKbDRVSnVxYmRkQT0KPWlPVm0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001180e1062bcea66e--
