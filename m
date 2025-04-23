Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DA1E2606
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430145; cv=none; b=bLeEAel7rVvRVMvUqYGSpOvCwlpV2xZ8PE+Hbh2XefnE4K0t4TC2hlkmFvwtr8delmzEgY6BDOtjLPBbDmy1SODLusSKzy+Lr3Ndxth/P5r8AZ7Trj8YjbYB6F+Pq29RQW9V5eOHEzs/cgKAbIBi1LpVDSS5MTCJXZ4CvWE539o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430145; c=relaxed/simple;
	bh=269QwDbGpEJ0SItCx+lPuxQL2PdEKXVXS09gaqAChsM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuLPI1MVIkPkfimqoBTVlgjkjdTCs2YeHkxQ6IEVV89nNMIV4fc4x63vwzqpAd2el7zh91WLHub6CNJAWJYcFmazn7KPB6VPgU8kPA4DpNw/A1IfkpkdJUTQnK3dIXmHcLo5f6INw8bd+ZlLnYC5tQRPRo4sGUSxTX/1QruOccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf6VX3PA; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf6VX3PA"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523f1b31cf8so59263e0c.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430142; x=1746034942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=269QwDbGpEJ0SItCx+lPuxQL2PdEKXVXS09gaqAChsM=;
        b=Hf6VX3PAINDmn2PhP40/5qFXBywwTCOTT2oHF+9TSh0STo3LE2+4FC8EKIy1B+D99T
         7tdl2avdOkgKYMfdTUtTr914GPcwEjRUezcks3/IMf1NbOVB8RWJM0efQT9L9boaFFUu
         6ZPhizqA4qCqnOnWREWbkgZlZle0ASP9rPWvGmfyiRHeD3gEuGx5MFeyM3y/ST7xIgco
         +LBr7CBiyXTI3qepW1v5ijLwZvmjgsQ0hC6/xsJ3HrgKkbafjB0vj+3L5BV52DlS/6Yl
         xoiLRsLcPDaDqLgZVWqbLN18jTnxAy7OtNIPdhKLnc4kcAPA/lvBCBbzE1N4SILpNUVm
         0Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430142; x=1746034942;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=269QwDbGpEJ0SItCx+lPuxQL2PdEKXVXS09gaqAChsM=;
        b=oQuFpQrPkmDD8qbTtyCQiq92FExgyi0MIyuE94wX6N1EnVfgiAj89lZYRa6GmuaDPm
         44lyhJOS1MmEhQIDSrUKZv0kXWZXMA3k6HIK2jEf3dP2GgNKKOFzFxcLNXlqgLAKg/dO
         q6bdDxzmmKKwHBw+Z4F0AEFZPhVGz7R4jKS1CkvFVSFCYuSu0nfl1E9/LrRKr9xWxSQu
         99kDfumJ5ouaRBZ28L0BBqaGGR7kkhuAQhT5TJKbqcoYK8yTWjf5pbp9sKnU37WD1hoF
         4B2c3vlEjEWBDEu6QnTWbI6t8xbc0eHyIt63G4bmcEwhWf7x5iyxzjYKB7cekY6/S087
         Hgsw==
X-Forwarded-Encrypted: i=1; AJvYcCWjNFxYgcXLtrhelQRpcpBJvMBEnD/pnJ8SwmksaG11t3fKjhn2JYT/v+Smar0m6iYsF6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCpIy4gAa9fXhENrQhCLvQZ7xbKmgS/+kH7bNuQ8Fjj0QAwTl2
	yY3mQvGr1D4NpgwXlHZP54aoQPRKlDadoVeXwTnyTRYa0PPj9a9XUo56F/yBowRFQgS9v1nI6en
	ZGdQYzCtUvaQqc7ubxcRENpJo+hg9Bcjl
X-Gm-Gg: ASbGncuIEGs9/HV6/3gBw3m7VTDCraCFgsS7P9SpsiQxcoylfMWPE7HdqrUxi+Rcmu8
	5rGXvgzTyBWozhx3xCI5B0X4MHDSCg7/eqjYkPC63nyU2kUqhpPwDYSL9hLR+BKI8tOVexCyxmE
	3eNxoN4a5lewaBucTyGrY/C61EOR6JYO8usPM7SLvom/xdYjfrsiJkoPxk
X-Google-Smtp-Source: AGHT+IH9PYq08rFZLWe7swZvRo10AxNpljLVIOToZbUoGumJnx/bgswls52xctWuIhisfQZvzKHrleAQl31iMuLODDo=
X-Received: by 2002:a05:6122:d98:b0:529:1a6a:cd48 with SMTP id
 71dfb90a1353d-52a76b3b44amr286017e0c.6.1745430142585; Wed, 23 Apr 2025
 10:42:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:42:21 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 10:42:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com> <8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 10:42:21 -0700
X-Gm-Features: ATxdqUHl8XItDoduKXHoPG6jb1QtL5Q_92j6allnBnhp2Gmp72GfrBqlk4QuU0M
Message-ID: <CAOLa=ZSnvTVwooa-S6AE+u1N0MV2D9TBOK3A0NBmCzOF0bjOTg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] meson: add corresponding target for Makefile's hdr-check
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000a1352e0633759f3b"

--000000000000a1352e0633759f3b
Content-Type: text/plain; charset="UTF-8"

phillip.wood123@gmail.com writes:

> Hi Karthik
>
> This looks good, I've left a couple of comments but I don't think there
> is anything that necessitates a re-roll.
>

Hello,

Thanks for your review and guidance, appreciate it. I agree, will hold
off on re-rolling. Let's see if there are other comments :)

> Thanks
>
> Phillip
>

Karthik

--000000000000a1352e0633759f3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9abe3250ef780044_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSkpud1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2lVQy85dHVzSU1zQVpCTTJoclZydFNZWnlVbnI2dwp3ZXBzSHc3NW1z
QVY0SzZxMWFrSWtFVlVwVHI3ZHJoVGRQdml5em12WXhCMmFoMkZGUGtKQnptQmh1ZkQ5d3F1CjQ4
dS84bWplVm4rMUF6NExUY1BRaGlNWm1mQ2EvREtXMnZZd3hRMlFQaEhkWVJ6ZVNRb2R5aFdPdU9s
SEp3ZkQKUGJOejNEdm4rQXNocDh4T1VjOUcwalV6VHhMUDRsN21iRmJvODhoak1IK3JpQnpLaXJJ
QzNJODhWZWtjRHdzdwptblgydUFSelo5TlM0N05kcjdSWWJkSzBFV2pPaVNCcVhqYnY1SVVlNC9m
WlBXWDFDdksxZmp6Z2Rza1ZVZ0VqCkxkelBFbnorZGJtWU9ySFJCNjBLcVZRb052WVJhRXpld2xM
Y3l1aGcwYkl3Qjlld0c5MFhOTlFibXgvRWd4R2MKMldUbnpKYzhnTFJKSDNPZ1FJc3U3dk93bWFv
N2ZvNUQ4T2NwYWdBbTF5S05KeHdjSDlYbVpIVmhDMkhsMUtqSQoxMDNxVlJlZUJaT1N1MkdIL3Br
OEdGeUphd3FPczdzZ01MYTlHdnNsdi9WcE45RWtmeHlKSGd0Zm9TMnJjNXdjCmxaVzBTWGdad1Fx
VWxZZ05kdWprS0tNQTJZMGJrdFBoRVdKaStaUT0KPXl2THgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a1352e0633759f3b--
