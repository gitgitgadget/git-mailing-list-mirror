Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599713B7AE
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346164; cv=none; b=K7d7GHg0PQA2Ag6jbHpJUDPX+jBPVYDwDjBNR1njx5a3XB8DQ4+Y9L9Jnas80Qo9z9JSZXvztm0woGzCnaSdptnVl6bLeo62lZ+soEAnG1HqnZ4jISM+72/4CR28ZOnt6W31BSY+qdsJhlFItUIONpVMs03Ibfm92pOhOqk3Eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346164; c=relaxed/simple;
	bh=K0uSYVYHEvRiTGCYODnSTzAIJSN4FQX7xXOErz8mIQA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=s/GN9NgS1e84rKCsKUCPotGcejNIdsORDhoFM1TC3lTwOFeSYPz1Dn54RTkB4KBBMa1gNWb36D/LT42pkWWzDEQz/ppmHz5BlV+XsGn2+Q3IX9x0V/2ZvoL2u/7uZ9/hBHgKK8uyzfDm+wFf/UgtmzvI4t0iuek6nngXevk70nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRgo+Sns; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRgo+Sns"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4f2f2f22c1aso458518137.0
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753346162; x=1753950962; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymVOqI2QV1u0Jzr3t9wMa0P8qYOb0BQdcLMvKG190Bk=;
        b=IRgo+Sns8l/VzeCoC3ET+eUggConOHsp6e2Ou7xqOUq7es7vDBSyU3DuJRtqpHobBW
         Z5aVOnvi2zH8GmM7NbVGg8ihO/gwhvGc5HIRhECqLTWv307wD2nAXoU2dk1CmtkJg4A0
         APb/TfO8tatP3LOqAzXwEluMjvIxpgTCNfxSz95l8mAI/iNOjOv21h6bnqX4pagTMR+c
         oqtvM8a1LL9k7+SXhhr5HptJjYZzBBqTX8J4X5IH9VnTdBnM9Y68MIBcf7lMIuhZ/bvB
         MkOl9HgnHHtDwcOOrq6aGT0WHqS0A9YHIZNMA2YZjGd2bpUgUSbjXy4vCaJj/s9clxge
         rsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753346162; x=1753950962;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymVOqI2QV1u0Jzr3t9wMa0P8qYOb0BQdcLMvKG190Bk=;
        b=RUYNxlmtSu+AUF9+dTwhQLkWAe3Cqh2cY3gBuP2ASskCO4wBXduElJIVvNQpvms1oX
         +qYV9/qR1/BHuIvRu5Mk5FSerSdhBrAsLsBjVkmvQisya+GekZxMS6LMOTS/Cf5uRWye
         Y8IWqTVjDxBfw2eNpHEddAZX44v8BaNnp1CItEv0fyJs77Vv5VQ6/FdD3WmB07DcejmI
         rglU8MsCNKTOGI2skpUC59WklGYIFmuBGX4E/TT2NOr9dYPjN/jm0otQn51Xpl87AGu4
         ty4bhYYT2VPNw0KV5QYmGVrz3RGD1Io5a3lLzH3Q/+ZCUl+iMJtbxio7B4T0RYpSTU33
         hJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2yA7qkc7UCHtNhx0uBweT9cBtaBuZkVs7QcRAFM4REJrW/d7AkgbG7OqnRIj8uFsqk/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54hyVzZa7UHn6cQr/1SOmK0IC4HBokKRsYtOJEV3GIRLy5Sof
	ctd53m09cZrK4EE/SqMJB6ZZ65PLGyKyLZzidcN4VDf/u0WnSH68OpFzFdMYiCyPYlBYmJq+CZk
	ag4+mK/lBMtpcSFuGfeWJPdTBMRxu5Fg=
X-Gm-Gg: ASbGncugwfKAnMDrY1S3W+QcF/Ki2/+2nyhPShTZFW6AaFB09CSjchYv6lH2sGKSUoc
	r7i3RboqDWB39vD4y8pW9iM88bD720QL0TjVetyRu1y825AC3x0xhI1DI+tSWn4nmJRmDrtI8OG
	aYtzXs4GhfewOYYbCdP0tXxhqz/UGv1mABP9I2qJ8d9Wohqk/EPUUyKOehUtQYUK4nFugLMl2Tu
	r3EYQ==
X-Google-Smtp-Source: AGHT+IGjOrRn5rjmI32Lu9FY/F0hhKmPjZr4xSHw4nnQpiUfQfwRJ4fhcFOdU70pRdrYBH6L9CvYfQRKi3puJZMZYBA=
X-Received: by 2002:a05:6102:3307:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-4fa2eb22c6amr283207137.4.1753346161916; Thu, 24 Jul 2025
 01:36:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 01:36:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 01:36:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250722-pks-reflog-append-v1-3-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im> <20250722-pks-reflog-append-v1-3-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Jul 2025 01:36:01 -0700
X-Gm-Features: Ac12FXzHlEBIxBdZYV6BZz21ojhYZMQ0EYngqwp4E510XhlSpNJ3SrLEG7L2lAg
Message-ID: <CAOLa=ZSv0RkxOMAe-X=rsf6ht-AknFdcbmcQECyxzTe1ZKhmGg@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: export `ref_transaction_update_reflog()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000265a78063aa8b767"

--000000000000265a78063aa8b767
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/refs.h b/refs.h
> index efa182c6a14..0faf3bc0422 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -794,6 +794,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err);
>
> +/*
> + * Similar to`ref_transaction_update`, but this function is only for adding
>

Nit: s/to`/to `/

> + * a reflog update. Supports providing custom committer information. The index
> + * field can be utiltized to order updates as desired. When not used, the
> + * updates default to being ordered by refname.
> + */
> +int ref_transaction_update_reflog(struct ref_transaction *transaction,
> +				  const char *refname,
> +				  const struct object_id *new_oid,
> +				  const struct object_id *old_oid,
> +				  const char *committer_info,
> +				  const char *msg,
> +				  uint64_t index,
> +				  struct strbuf *err);
> +
>  /*
>   * Add a reference creation to transaction. new_oid is the value that
>   * the reference should have after the update; it must not be
>
> --
> 2.50.1.465.gcb3da1c9e6.dirty

--000000000000265a78063aa8b767
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2c5bf5932476a7d1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pQjhHOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0dPREFDYjFrRzhzN3JzMWRFUmtkdGFXRTlmb2Z2RQpoaHFIWDBObzZY
aG9Nd3JMbWp4VExNVCs3WGFNajVURzN3TngxT2FGWE9mN25rUVA3M2g0elZyRngwN0JTenM2CjhL
L3dYLzlVeXAzVkVON1VVQUNGeENSNU1PR3JMSEV4eE9iMTVXVjJ2TjYvWHVnNEljWG1lQUpvQ0x4
YWpDTk4KQ1BMbytJcXpkYm9tRkpqalY0Y1Y2TzRic0t4SXVEOGFRT0FVazZndDdpODhUcklYWEtr
L0hWQXA1R3NKYnI3ZgpQbGJuU0FJS0NrR1hkRUdWajBJdjRGVXRZdkdxcDJLL0tLMkVjUEc5cmJ6
dU5pQ1h4MEd0bklrSmo5RUNKZFJ4ClV3YnVkVnhneWthelc5VHV6OHFhME4vQ3MzZU5zRFVpTlZP
Tk1pODY4empQMDhFb2FSM0JtK3oycUNBT3NQd3cKeFBJdHlGTm9Ia2crZytsRFhzV1FMSFlweHdS
MEJYaWNnYzg5RVpGVDUrNG8rdUdUdEZURDVjamFQQzU0dWdBSQoyYUd6SEVZVzZ4S3JMYmNMV1ow
TStjWTNFbVhtclN3dHIwLzlzN2NzYnlkWWZkUWo4RDFMMk0yclFZNGJ1ZGRpClF6TWk2cXNTakpQ
STh5NVV3TzdmL1J6Q3YvUldrMXJYQnU0a2JhTT0KPWlPZGYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000265a78063aa8b767--
