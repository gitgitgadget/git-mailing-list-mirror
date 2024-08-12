Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA616B39A
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452206; cv=none; b=LOuI+WwUjsf0a/WFMYBFKkeHJNg/f//W8zXq4VFmckXirmyieG337XCkW6pXR/lRKg5Znlavpk6Ktjz4O0cio74X5TkAkvNXjGj3/nJ/2ld9TicK9FQNVyaq0j3x9LueTv/7ngYfIjvj4gMqfwN1n6INWNE1xLf4rdOG1gUvfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452206; c=relaxed/simple;
	bh=TP1SVfXUkg5jYof0OV3mAXe/sKXLfK/HX8PiiksgxqU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS7E6YJfxFaltfFT4rAE+9BZT6+ZkQHsCYh2yEl+GhIe+6r/jzpDfMWLxygdca6QjIbba589/W2+CHOcgDfp9PuaX0l97Z0BoPaXb+Bq6q4I2wzin6xgd2iPSJytkr1KZuTgwCSxKg4LEyG2Lk9AGGq7PfFIkZFTfjibwvAlw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZy+W6jn; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZy+W6jn"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5f9d68805so2331928eaf.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723452203; x=1724057003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TP1SVfXUkg5jYof0OV3mAXe/sKXLfK/HX8PiiksgxqU=;
        b=bZy+W6jnjDOfCa7TcPK0ckOcc7GekdJTRoOAhcsiOoj83LUkGzoTL4f+O1YzH2Yrim
         uco5sQfaGF/o4gaESm6iIgzYMmsd6ldSRcq2qYWyqBbZJnDW0hOipjOLpyQqaGGSXbbE
         iU9SySxc3IfH2yaUIGnPDbpr+u8A+vqCIvCa5+yXHxUa52lrRJM7rP2GKZUyyP+ZWyaQ
         k7ErAQyMXmYNMLPRAP2oH96e4pDIPwDL1uJR09sngvQSiQzfjpJzyNUXi4FVKxRJtc8t
         EoYiBmGFaIfsbk4YmOBF8NPZ6qSVb34c6YA6aB0pUzlPnyFZYpqVed5erk88ZQ4uoZ2y
         TR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452203; x=1724057003;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP1SVfXUkg5jYof0OV3mAXe/sKXLfK/HX8PiiksgxqU=;
        b=dB9W7KP+hXHyGb4Lpkhpu8AKlk8kPGvJfLR+OJVArFbNxXjRIT6L9VgZw4SHg1/YQs
         ea/7NBY1P0pm92p+h3nbBP1ZQBBtWZhwv5U0OzWb+bRA4RUoDIJcBAuMGg97Oge59VWt
         DXctARf98oyXLBPoPZk4xxGWcQ39H1sCztxLvuPczousQW+YZgmEj/AuB6tyyc/XPpMO
         /TGcSVdrR+8bCLZBL8WlcpW0Fuw2YXTQZTwe9UXVrSZdoDn9Wv34aPqcIM8mDSROPy+V
         BbnW5orthB5Uo7d6MbkAlIo4rR825JiGjSA31jrQ/NdgcbbWh8f6HMrNKVnVKWT8VWZj
         6Fwg==
X-Forwarded-Encrypted: i=1; AJvYcCXRFtUqRdTtUxImftwE+NeKF2uHW4hnxEyiO0igLU2Ig8Xl3Jjlk50saNyMXTtIP8hYxvll81Rj9uAv63L85W49Uz3w
X-Gm-Message-State: AOJu0YxWJqKLXfxJZOXTiF5vCWpkvcCaPuYAA9XF6wyGC1SSf2adOIxV
	GIO8dxDnuVDmwkAmpxlEPM2D6t2UoxxUwecwKa+IGySvl9B4PAMgXMgM9tUptFRa4DvmSiNf34o
	UPalzrCyGQhnmR4eZBgw4adNfgLw=
X-Google-Smtp-Source: AGHT+IGn644FBpAWTDHtRbgtR40b0x3v5nybcN/oHw4gOZCj0+SauUubHJKAgEoRpUTE6UbpOWFl0gQNl52AdoUUESc=
X-Received: by 2002:a05:6820:1b94:b0:5d6:10e1:9523 with SMTP id
 006d021491bc7-5d867dc089emr8747885eaf.3.1723452203476; Mon, 12 Aug 2024
 01:43:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Aug 2024 03:43:22 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <43a38a2281f25db837dc9b5a59ecbe12214ac7bf.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im> <43a38a2281f25db837dc9b5a59ecbe12214ac7bf.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Aug 2024 03:43:22 -0500
Message-ID: <CAOLa=ZRFYL6mWABumWM9pra+749tz7kOg3y9x5Pj9EdQxjC6eA@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] object-file: fix memory leak when reading
 corrupted headers
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000006055a6061f787cfa"

--0000000000006055a6061f787cfa
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When reading corrupt object headers in `read_loose_object()`, then we

s/then//

> bail out immediately. This causes a memory leak though because we would
> have already initialized the zstream in `unpack_loose_header()`, and it
> is the callers responsibility to finish the zstream even on error. While
> this feels weird, other callsites do it correctly already.
>
> Fix this leak by ending the zstream even on errors. We may want to
> revisit this interface in the future such that the callee handles this
> for us already when there was an error.
>

[snip]

--0000000000006055a6061f787cfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4319cc23fc6843b6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hNXl5a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN003Qy8wY1o3UDQ3Wk50VTRlZG0vdStaeExtZXY3Mwp4YlhUUG9nZVlQ
dk1zeHEvM1BiOUdBMmZabFdaRlhYOU54U1lhWCtwTGJySEs2UzVyWHlicXQyQVY5WDlUb2RpCkM5
VDFuT3NRcjhmZGFiR1VuWEFobHhvR21Cak51WWQza01tVVphSFppQXNjT1VMME9BTER2OFNmTzhv
WmVTSVgKYzlJWEMvaE5HVkc3M3Evcit2V3BmTCtib0dJQThnbENoQTFPaGVQak9QK0ducGFHVUdV
bXdWZVR0K21iU3NvdgpRN1V5WFo3ZW83YmlzUkJCUFRrUU55UTJVbkxCdkRicktTUitsUDBkVU01
d0h3bit1Sll1c1JRSU5hbzZWSUdiClhtdUoxdGJ6dHpETjFuTVRRcGVSckRtMDh2MjFScmtnTlAr
MU51eEVQVzJ0L2R3UkR0N3dzQmlESjBQNXp4WmoKZGtxNTFZWXh1VFFZcU03bHJEdFFhbEsyblcw
V1NBVytTaithazdIUzZCT1M5OFJrMmsrOGpTSk9TL2syUUtNawppcXFkNlFsL084am4zdzc3aFVC
aVR5YkJWNW5NRmlkelQ4cVJ5WWs4NDlwRnJPNzVTODFDK2tBK1FQZlpDaDBOCmdreFZpM1oyVDVF
K3dYVVBOa0loQXQrdDJ4d2hHUFJOZFdWUkM0UT0KPXlwdGwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006055a6061f787cfa--
