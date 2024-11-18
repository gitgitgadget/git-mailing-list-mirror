Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58253A7
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938062; cv=none; b=VrNalL8N1HO9CsHzVMlQuReAGjZsJkwuSSKlUfFz++NKLLIhzWD2xt53uauFT65bUwCGApkL3+h1WPshCkbcY/O2sZ6vCgD4iG9NF1UyouQAPs0g1QGb4TfE/vhevaRaiFSWR9HUm0UJx3HHhhH5b+JGviqcckYwjvCBWN0//50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938062; c=relaxed/simple;
	bh=vowYIcpUe6wR2nqtg3hQxPjjWrDjpXox58GCuk4YIAY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlDyDPgvutwqqhS443sBTo5M8VrgUUvIUYot9fmf6CUaaqktIBc5ukFIPrbY5aXeGAebPd8ktDBBBu2koD+Vto+/Ks6bxkCCP6AV40s+bNgoSB6q8klDX4MoYiccdzBZiQFmx6+y2+sCIhPH88KdPZ3qOAMNIGLSBpQXthMrYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd1XBxke; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd1XBxke"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-514543a08d0so815236e0c.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 05:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731938060; x=1732542860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5OEjtTKsHCw2NEJ30iCrwx0r4JXCFy0CyNqY0almaw=;
        b=Pd1XBxkefzEfgC9kYaYu7d+Izz6o5G+/K5vUoVjngRQ2qWgWHKzIVSGZFULtA0VV1I
         wYKuKpJJVS0piM8dR872Z4e0YWMLSltwAd5fr10TBwd3oq7+HCqjPP6DlJNuQ5XoAjpr
         16wuY4jApGHlgzp5XjiAEElCM3oGhEprBCL5OtpYLPN84WUqWv8EgkALq3clTLFIcjef
         yKDmRfvOS8CUgCi525TdkLpV5bG0ZxIBoCCtrXtknYR49CSBUKGzlkv+eRteIlEo1Rzk
         KLl2aKtmXoWn8hfeI1HC6hUo3ftty4tsp7gUcyS2RYAQtHzF4TgXhsSAWwfJte7Nw75N
         Aqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731938060; x=1732542860;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5OEjtTKsHCw2NEJ30iCrwx0r4JXCFy0CyNqY0almaw=;
        b=nv6vIBt0hgwJQ2DcqK1F/HDQm6FSNtPKnsV2/7VEy9i4e9rqJhfeiZfZRcFNyBlX2J
         e/YobXWVR8mUMfrkRQhYXjR/92WlG6dr0OK5NPAGFSrLFuQEBo8aMz6fk9n51rohmBwp
         3EYEph3iPKptwNrkwlueGshtSXXgkhDZUaejdVE9IGvbI2qaOJv+tG/Tca/A9k5Xmwgt
         R5X1NxUsDmLenYB4LV55/AGVUzVvItMwk2G+yP5Z9YiPor8wSKYwa968TA7jkYgCur5F
         V77Q9vm1rnltSkZbHpYIAsVNwubRs68H0jxmHgTinUdc0aUefbL55huVA2B6BGv/pVu1
         +Viw==
X-Forwarded-Encrypted: i=1; AJvYcCVw9K0mIvCIP8/nztP87fTYGJWDnXGh2gi5Ru/blTzQ5T1k+mO7eVVObztBcgbw1zsr55E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37rhHDRgXTlPWFpZ0SLIgb1OSii3KpABPJosw80pJ/W3pu7fH
	rV/7d8jNlVF81TE8vXfG3+qsUE6jHqRN2zqPwpjzRPfqHMaD9iLK1IAjvsajDyQr7ro9vyjVxjN
	guXp43B2crPm7qj1FwB6ow6zlpZhMJZpK
X-Google-Smtp-Source: AGHT+IGFKVkJz/jia4oaok6vgPTGi44lFo/frcSm+j9jw/YQ7t4w0lP+Tuvf1G3OGR2liDhwKIvHou8hQQYClzBsCEM=
X-Received: by 2002:a05:6122:513:b0:509:e7d:b7b2 with SMTP id
 71dfb90a1353d-51477ec75a9mr11580318e0c.2.1731938059703; Mon, 18 Nov 2024
 05:54:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 08:54:18 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <745c1a070ddd7180f0ee89c6a1d057a256894599.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im> <cover.1731047193.git.ps@pks.im> <745c1a070ddd7180f0ee89c6a1d057a256894599.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 08:54:18 -0500
Message-ID: <CAOLa=ZQTb=RFc_fqUDJZEdqbf80upshMn1+V4zEgsdHw0wWcLA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] reftable/system: stop depending on "hash.h"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000d28def06273040da"

--000000000000d28def06273040da
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We include "hash.h" in "reftable/system.h" such that we can use hash
> format IDs as well as the raw size of SHA1 and SHA256. As we are in the
> process of converting the reftable library to become standalone we of
> course cannot rely on those constants anymore.
>
> Introduce a new `enum reftable_hash` to replace internal uses of the
> hash format IDs and new constants that replace internal uses of the hash
> size. Adapt the reftable backend to set up the correct hash function.
>

So with this patch, we now have:
  - `REFTABLE_FORMAT_ID_SHA1` & `REFTABLE_FORMAT_ID_SHA256` which is
  what is stored on disk and used while reading/writing.
  - `enum reftable_hash` which is used to identify the hash function
  internally in the reftable code.
Both of which are separated. Nice!

- Karthik

--000000000000d28def06273040da
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 45f34841869ae6aa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1J3a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHpXQy93TFlsYXhjK2NVL1hKVFZZbkI2N2MyTTRyTApJdktYdDVIVWln
MXNPUWNXTTk3RURGcHp2aUhEajlhTll1ZTQ5Uk9EK1p6TmhGbnFZQ2o4SFowZGM4aHliUDN4CkZE
TjJoNno1elhlcE41UVFSTXB4UElMTjNwSGh5aUMrUkN5WmRycU1uWUx1Y2xCODltdko4Si9OUWs3
ZVZHdVkKVHZXYTVPZjVyVjRDQnlHZWRZd2FBMmFLbjl3UjhkRGY4TkJkM3gySWR4Uk1KWjIxSEpy
d3dHV0JmUTBjaEFZaQpxZVhqa0d3bFVEL3k1VkJHWVZ0UFlSTWtCak9scnB1QzJuVmhLMUYxU0dO
NmcvbE5KMVFEbHFFdGxWdFoxZFZ5CkFwak9TQTNnYnVUaDZkZUl0UFFyOTc5UDRrcTJQSWVLempT
aksxMG5naXd2YlUvSkJKcmY2bVNwUTVDZVhmUmMKdk43VjZNRURmelRzcnNRV2k3SmRIbTZyWUM2
MUVVNHBJZU9pZGQxdEh3QnVkVFJlRTMwL1hHR1RnbGJabkVTcQpsUkcwTFdPeHAvTnVaVDd5VktF
UkVsaVEwT2xLY21uNUVoNVNlMUZEc0tJUVByOHJmVGIwQVJrVEJSRnZrQStwCk9NVStDclExb0xG
MXpXWVZHdkVLelBJL2t0ZnVIWGZ6V0Uzdyt1az0KPTk0SnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d28def06273040da--
