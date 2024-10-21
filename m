Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237321CB339
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525755; cv=none; b=IogXT1nhc5I/nb0qfb22rAMcoEnwt5QcOD9LZURbvDty2FZG7Qhh7bgQZD60fy6tJvylDUmEt6OTYCDa/H+N7aCYJgMGMP6Lo9HXZmueBNgZPbYi2KtnGiNgDN7GXNbED/qzXOMa/qnglAPRFf8p8nOtjer/IN8TBqQ+txU0nAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525755; c=relaxed/simple;
	bh=c1VNWUpFAQ6sUGk96W5luVa5romOZdqYhW2FijnFSWI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRBXltM36Sv5C4E6Ar7WsTHkuXYTMgAryuPvUNpAR9umX6NS1T7BC/bcCDzp4w0tJHSekOSao0HsRmSmAWf4u0y4664PS0xD3WsIhZ4l53UO+QdorPzWNMaAbO4sLSSwtvOX3qipquRQQ6GCam8zFiM5ZMlbYefcnz3qNi7M/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdYZv8tx; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdYZv8tx"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a46b6affeaso1479315137.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525752; x=1730130552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NVkCX+Kr3hWk6PfU7BiSvU8x14mNFs1plkLkcVYoM1I=;
        b=DdYZv8txfaevWpWxXUOYxi0eKzBqErHhPepc4+YqNpZDfO9URt9PblK0jTbbKmshmd
         5gZtBRY7e/Gk/CtUpiH4xhcEZIQORtzfpY6Pu5jrDh2EZUKrWPoA82ZA1HP6lTseCjDk
         yZ29bMJGgGpj9h5y9C6hrM2wzsAs/iVVy96fhJtprgOpVGbJrcVXpqEPWW3Mnzngn2PI
         DuKaLaNjH4LUoK0AJe7jD4KIS6s2hjkBHS27w0xM6OO3y2K2lyrz82pA7bHHy3EBLAdl
         MO1zt27tfUqab8Dr2q8JfkooTqlwx/5EnwRIM3+K/kbop4BR7R1it23jGBF5LvUBQlJg
         M52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525752; x=1730130552;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVkCX+Kr3hWk6PfU7BiSvU8x14mNFs1plkLkcVYoM1I=;
        b=kC+tyq4T3vMmVjc3gheOel/HhkaED7UKl3iOMQXUo2smK9dlYxWJwwzxaND/yhRAwP
         hZGxRBsdfw5nTc0bk5B3LtHBuTDMHXyG1tmvha0zOaqhMf3PmPk7cboICZl2lVzDzXBD
         UD3p0uVfOhCjcZhpk87KNGTKl5bmYYvX6O9x6Ox9Bn0C6Y48cIbzneckmtICvaDykaGR
         YZhpjMRP+8/YiBck0L1yrIPgqlvNoaJI2hd3E9CfuREiABMFbWkue2LmvLvzZgp3S6Yj
         h9uTtajthmX7IjCAx7H+M4cPWFqqRG6mviABpBOvW/TVdFETLGO5SKO128Xuyw++2tKE
         9D+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW94Psxmmz8RTw0BL2bCNQR1U+tst7SA7LZsvaJ718nGAb1Q/Nr7oxpDQgB3Wu4juN7Z/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qStf6NfBaNZqYp9PzvaKf2W8WoU9wRAHAUvpjO2Yj//yKI8S
	2wT/iqfp/7W+8/ULJCIGClREtbM+bRv9dkkCdeuj1KhIZMkmRtEd5UuIlUA7ehxICliyP877nxe
	JXOh4jiRqXxyUhoH8Fznne67aJS5su9Lk
X-Google-Smtp-Source: AGHT+IHhKBLHHJ4bBxM3bBzSLwl5l5rRyYnQsSDPQJP/Fsm13e762sfZBHJPeoS1hTnW8ZcGICw6lOK80+oKaaezprA=
X-Received: by 2002:a05:6102:6c7:b0:4a3:d2e5:f097 with SMTP id
 ada2fe7eead31-4a5d6bc26c9mr10297515137.24.1729525752002; Mon, 21 Oct 2024
 08:49:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Oct 2024 08:49:11 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxZYZy-9deyT6I9a@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux> <ZxZYZy-9deyT6I9a@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 08:49:11 -0700
Message-ID: <CAOLa=ZQ9b1NVng1=3E8tyGfuASv+FeuNo5cNfh6Pb_xvUok-xw@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] ref: initialize target name outside of check functions
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000014234c0624fe9875"

--00000000000014234c0624fe9875
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> We passes "refs_check_dir" to the "files_fsck_refs_name" function which
> allows it to create the checked ref name later. However, when we
> introduce a new check function, we have to re-calculate the target name.
> It's bad for us to do repeat calculation. Instead, we should calculate
> it only once and pass the target name to the check functions.
>
> In order not to do repeat calculation, rename "refs_check_dir" to
> "target_name". And in "files_fsck_refs_dir", create a new strbuf

Nit: Why `target_name` and not simply `target`?

> "target_name", thus whenever we handle a new target, calculate the
> name and call the check functions one by one.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/files-backend.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>

[snip]

--00000000000014234c0624fe9875
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 137c8f429b99cd16_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jV2QvRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVhUQy85MDhaY1JEVEQ5VmN0UUM1V3ZQVm5GRS9scQpPbGxNeitXdVlh
Um9mTTBWVjUwWGQrT0UvWExzaTdsbjJKVlRvN3l0SHFhbGpsa2NKbzNXdUJPckNkdVFubmZnCnhX
MlZWaUJnV2RSNE55a0VxUHo2ZE03Q2QzTHZVRnVqOWtWdWQ3T0RvNUNDcnA1SFVqVmNHdU9kdjNV
bXVkTmoKc3RhSFdKa3JjNHhHOTBaQ3JHOGI3Z09iZlY3R01qekREMTlIY2daZUlzeXZteTgzSVhK
MFhpcHdScldOckZSRQo0Nk5FaXVxbitOMmhUdGNyb0RlOEFmOWQ4RCtaMktxcGNpbXMzWDBXUjVO
d3NEMTVlbndud3VEUnJxd1hrSVVOCnFEenNPUkJGZWEwRkQrSWl5WUFRMGlHNGZQTmZhb2IxZGVo
cDdPNzBtNDI0WVdrV0F5QWFQc2tNeU9rTlQ1SisKQm5JRk1iVnBMTGlyT0oydWE2dGZYaXBkRmNq
VjRYM1RzTmx1enphTWRQbEhkSFBHQ2xreXNkdzF1cEZkVVltdgo2R2NOVEsrenN2UzJKUVBmL1Ux
Vmlqb2E4UmdTQmQybkVZb1NUT3Y3Y3ZLZWhIalpCOE1ablZRRkZIRGt2TGtyCnVaN21YUVg2YzEy
K0NPU2NiMXIxeitmUEpWYjYrQU41NWtXbjVVOD0KPTlkMUUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000014234c0624fe9875--
