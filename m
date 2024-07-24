Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9C41A80
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821583; cv=none; b=FMuMomNY9raumav0Fei2INAr27yQcpVJjKVqTVfoe6O7UDEZiML69xZ29NhsO2ZfwSH7yuuBR2MD/zBWXFm+dm+x4rPEhmi788WOTYh7R6xxE/2ZVf9z4XktnbNngI5udGrJp9wAQOBQEAW86RKPRAuAuczXDUMVVpx88vxOXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821583; c=relaxed/simple;
	bh=UoVMKcmo7WpLocEeMOzzeRyANvq75198G/lXtPLw510=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=AY3qcjDPZhl5bvav/qdhc+WMzurIOyAIiLCqaXEzK2mjE7GpDS3s9eLiDjKzxqGcu4hStx8VBjGAF1u6n2Fm3LX5nlVYXsEVQ0so+TDe9e6N3wK6J9uOCOMFfSBo5aOe2rLVbxHM3/rlwUAUdH4SYpRsqMd3Ql3C8K5qkMjxKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcZ9Z8Ig; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcZ9Z8Ig"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2610623f445so3290258fac.1
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721821581; x=1722426381; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzIVNnCB4uBRwt/J5MwU6JniwPykyZnckBGh5hZgpHM=;
        b=fcZ9Z8Ig/ZR73KqLQBpzUdh8uhLeSPnPz42bEGARdnqjiAtOYrtshT2JMKWzCBCL+n
         n8KJWKOy54MrAEcpk7c5ZXzDRP689cjrkaMjLsSaIHBwehZT7p+EOgcZWKKS+mlQ49/B
         yPr+8qeHsHNYqlfcjzeIZlveM4sJ9dsodpDEaKWjs++IywbYkGuBQ5cBavqvTp1Ej/yH
         +HuQ12icwVz5Ba51qu4NnQMzBRaEinRG+cIqwGoM/mxZrlWcGnQnkI3F0DWteCCVI115
         yj8eaS23e6rP1zFMqKWWAON962Q7VTYPNrkNi6GsC1rsTRWhtmxuGROHHnGq7SkgirqJ
         MD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721821581; x=1722426381;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzIVNnCB4uBRwt/J5MwU6JniwPykyZnckBGh5hZgpHM=;
        b=f6LKAELp0e45eQVmmm/kg+f34V5yRfp9SRhvXWPiXynZW+9sMsHc0AuasuNRLJZlNX
         oKvYkgfh5Aguzplec973hU2cUopwlT9mmOYHkSqrbG46VfapW/YIruSOqesGqav3efwE
         t9rLEcrIUW0zd118xPRrr0rAjvx+HgIHpsexb3USLXznnd0gEIUMF9/p3bHSBi4ppkS8
         4X1EJDRpSa9eRuErxQPmb023kH8Wo525ywCP7a+rleym9FUI15LzDGS2MxIoORuzG0BA
         S2YTFBai5UyZ9TImN6Sxz+uz6nRL/SOVG9eOST98mvYYamqgjdyB+FVagp9cd0wJeMXd
         DD2A==
X-Forwarded-Encrypted: i=1; AJvYcCWS+ho99KYMa4KE1CEVptRNmmCmyrg5Tt/k50/lMzktghRggq6g8cfbGLk2fNzsHV0RGgO+yOU6PV5dAf7UYfdlFNN9
X-Gm-Message-State: AOJu0YzDpWcd4eoFaP0E86C8M0zLeiU4Sd2RW1CssG5BPf4vWcuTJ2Bn
	qM7odNHIur4xQx8LWxU9aod/swPhted26M9zz0RrWYphm4j8puN3/lYnoXwlRS1gc8CfgAkX9lc
	PWCYjUekFkasX0/BKXymv4/+7UVa4fy0x
X-Google-Smtp-Source: AGHT+IF0vQbPmI7MJtxH8EAmc6RmkzepPn45UnYRmHfpCL7ppv7j+02Nm/yVbK4tPCBqVmcpYmoOgOaoTb8KaFRQCXU=
X-Received: by 2002:a05:6870:e9aa:b0:261:ab8:3de4 with SMTP id
 586e51a60fabf-261213a4a13mr13691224fac.15.1721821580995; Wed, 24 Jul 2024
 04:46:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jul 2024 04:46:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im> <5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jul 2024 04:46:20 -0700
Message-ID: <CAOLa=ZScBn+sMB7BWMpsS=Ld0sUW14Li5JVuKPGKtY91hVo4jA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation: document difference between release
 and free
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b3cfe8061dfcd326"

--000000000000b3cfe8061dfcd326
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We semi-regularly have discussions around whether a function shall be
> named `release()` or `free()`. For most of the part we use these two
> terminologies quite consistently though:
>

I noticed there is also `clear()` used in some places. Should we also
mention that we don't recommend using `clear()` WRT freeing memory?

>   - `release()` only frees internal state of a structure, whereas the
>     structure itself is not free'd.
>
>   - `free()` frees both internal state and the structure itself.
>
> Carve out a space where we can add idiomatic names for common functions
> in our coding guidelines. This space can get extended in the future when
> we feel the need to document more idiomatic names.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/CodingGuidelines | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 34fcbcb5a4..ace4c4ad0c 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -560,6 +560,18 @@ For C programs:
>
>  	void reset_strbuf(struct strbuf *buf);
>
> + - There are several common idiomatic names for functions performing
> +   specific tasks on structures:
> +
> +    - `<struct>_init()` initializes a structure without allocating the
> +      structure itself.
> +
> +    - `<struct>_release()` releases a structure's contents without
> +      freeing the structure.
> +
> +    - `<struct>_free()` releases a structure's contents and frees the
> +      structure.
> +
>  For Perl programs:
>
>   - Most of the C guidelines above apply.
> --
> 2.46.0.rc1.dirty

The patch itself looks good.

--000000000000b3cfe8061dfcd326
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 637cc8f7a695f8fd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZzZZa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0xEQy85UUN2OVd6aThnZ0pSbVg5c2dkekFRdDlGZgpqSFl1K3JsQjVL
TWd6eE1RRlQ2cjJVS0I5NjVBbjhlV1dseXRTTDNwN3I3MXduWXkva3RHemExVW5uUno2eUthCnNk
Q01DbHRnVVU5eGdOa1VvN3JsOXpVV1NlQ1JtU0E1blZlK1hDK1RieU5LQnNxaXRnVHljalRiQXpG
Z2k4bTMKdm5rM1RKaFJ1Ylg4VUFsNGllUGtFV09aeGNJemZ2Z2JoL2NOelRFTDgxM0tmbFRnWWFX
ZDdnelkxN0FMRjBYOApPZFhwYUhFcWF4K3AyeHFMNm1SOGZLY0hWZnBWZ2N6dURLWVRHVVVCWUph
eko2OXkzaGtOMmxrTGV2YmVnMnpICnlRNTV6SG05azloVjExL0lYQWx6cUZoOTJteG55cVozcmxz
OXBJVFdtSlkwN0h2dU40OGxKNkFzY1pRRXY2cS8KQWpocWNVZDNkR0pkM2hIZ01IcFVXUHFuN0Fj
cWJmalVmVTlSbHFqN1QzSmVXcExjaHdzRlI0dmNCNjdRRjczQQpXdFkvMnlZSnBzU3FJWjFzalpF
V2U0bWRWdzRrVXhadXdpNzRJWXZSREF0RHh6clJiZm10TlVXYzZPcUxydnFJCnIrMFliRmJiSjlD
WmxIN2JpeFczdURxM1lrODcyWmtpS2pJZDd2ST0KPUd4cFIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b3cfe8061dfcd326--
