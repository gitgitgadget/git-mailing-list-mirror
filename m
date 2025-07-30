Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96F1F1537
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861997; cv=none; b=A+wISIpKSE46krf3e3f5k6KrusVc5CyWBsZdRdaAjWQapBdbF3vAF3RRD7fAnH2nAtBSh169jqr11YK4tco1GAThW1gJL28+n+4wRnlyjWUY0/Sjzi6LIIXDoI+YswD5t56lHifTkh4SNho5V89IGj6K1zCOw0SUvtdYUSvX3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861997; c=relaxed/simple;
	bh=/mmS7+i0SdVzWrlHITQPAbEPc5hAibcIyCJgHwASfa8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOqBJrcmHF+PIa5BB6rCLVyhW7kRXRMoJlwYNbmBAEYXRcMLDB4ztHq0vAuhSnrH/RGZ7AmKqDT/Po9rmGyt+h/UFfpGFSAj1zlYcIsR53tnvFX40BEs+MvXEjjziXD5x1vQ4c+42clwvHraVNjwOTuMjp9359GOaKzMW7RgSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nimghOpv; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nimghOpv"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-539207d70daso226010e0c.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753861994; x=1754466794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JnJ/6c2wZwCbEd1sQ3Uocx/aCZmPbMqu6u5JxccuxpM=;
        b=nimghOpv1dM/s5p/D6EKQU64J1A5vsBoU9uqaAZ9Ccw5QNzRmXXr26FSJmiPUN+O/y
         wYhd2IfWx9bwU6XlIINn5T2mnpWT9Q9ZDjzQpi4t/oFoD6W0gUMYchL9rnFUE+SmFKCI
         YfomXJBxc6tWWQu2YMyjbxajxwBhnFyEbl5mFjDSN14Yf2706eL2jBhYozsbTK//5Qjs
         7MLkkT7o4v8rsRZQVcGGPTA39xaHD1sGoIeJWZJjmWjgvEjEXMHEPO/2LjKFj7tNJ0jr
         kFHwwntfg3vIKW2e4NggdhwABW7aohz7XDECN0FFrmisuWBdE1TvL1p4e3yhUtxhIpMv
         Wvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753861994; x=1754466794;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnJ/6c2wZwCbEd1sQ3Uocx/aCZmPbMqu6u5JxccuxpM=;
        b=wxEEo7TYEEbpZgaq7zyyVXUDcv/px5h8N1g7zsoQH1K/qm9LLrc8GLqBUScWkBCF3O
         I+KbwZwy29wjDiEKEAetY1dDEbzsmqsYMwrQG1c11mSOlP4TimS4Frw0o1fRDcB/uqTG
         JEWQZQRaXN+z9frDwi+n5Sq/NThK4l6Ijgzv0Pp13GIqWd2BYyDGn2a0hhnXH8AXn4wc
         HtCzF0xX+70Dpv88fLuMJSYeGSC9XqVCcnk/TwriqGdm2H8vnn813qOO9gla/GMvQze3
         rNGGI14lM6iGQvzrce//rCgBJYABcaZQZ8hnFXHMDhWSD3Fmi4L6eY03iYLF/R1vvH1U
         M4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVFDMwQFiM2L/YaoTStTdWuVdEuU8T31/R5OkKeuPtfrH+MR1pyfl78r2sPiA5g56M8L/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2c088JxqzY0smnHrUqZTkD5XHmNwPuAcBFfj/lmVpyp2hzjY
	kLlxlgEVc8KJm6wMGKKrLq19VvSY2uW9n6dGyVTg+uhFmpTwk+TJKtoFYhagjrGbevZ/OGNExcC
	VC54EilXWGyqpPz+KPMWBEju+0J8O8AU=
X-Gm-Gg: ASbGncsOLHbbitNMN1t36l7+Z1livzc8FOwGR2FTdRGp5D89+j3jYYCmwqpCvsYDwCu
	Q0V6gDEneg18kb9GSMQSME3oADAhZJsdZvrhc4KipCX8H8ur24VhEvFQpYkSTbbZwXJDDJiNsOI
	LPTtvT4a5TR6Cfm8a/rxGW6rxjkG6ahxJh6o8zDIe0b3X/AVaEJTD+lo4v8K0qUH9Ktdm5N1eqp
	4TlR2flR/N1KDJ0TmKr7uzOaN3i74nSSslDE1FdoQ==
X-Google-Smtp-Source: AGHT+IGPjJkOzs4XD+LhCpQLVfuwoqNH97gZYlwvc0EyEazdz552g4jpUFpXd4W5jXM9ZNu+3+2NUDElgxCas6h7oZE=
X-Received: by 2002:a05:6102:38d4:b0:4e7:b728:e34b with SMTP id
 ada2fe7eead31-4fbe7f27173mr1440391137.3.1753861994388; Wed, 30 Jul 2025
 00:53:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Jul 2025 09:53:13 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Jul 2025 09:53:13 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-4-f654f2b5c5ae@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im> <20250728-pks-remote-rename-improvements-v1-4-f654f2b5c5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Jul 2025 09:53:13 +0200
X-Gm-Features: Ac12FXwv2d98zGQEAQ3vqjP1cG8cQyxrTyPTFJYgsSWiw0TAHfHe_uHgfeoHkFk
Message-ID: <CAOLa=ZR=pQ58GSKh-M1fg5Ym5U6THmmvgTSNGUGCmdhhuVHFCg@mail.gmail.com>
Subject: Re: [PATCH 4/4] builtin/remote: only iterate through refs that are to
 be renamed
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000293a97063b20d11d"

--000000000000293a97063b20d11d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/refs.c b/refs.c
> index b820c3908bd..861a0deb924 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1840,7 +1840,13 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
>
>  int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
>  {
> -	return do_for_each_ref(refs, "", NULL, fn, 0,
> +	return refs_for_each_rawref_in(refs, "", fn, cb_data);
> +}
> +
> +int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
> +			    each_ref_fn fn, void *cb_data)
> +{
> +	return do_for_each_ref(refs, prefix, NULL, fn, 0,
>  			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
>  }
>
> diff --git a/refs.h b/refs.h
> index a39f873b1fe..9decd3126e3 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -428,6 +428,8 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
>
>  /* can be used to learn about broken ref and symref */
>  int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
> +int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
> +			    each_ref_fn fn, void *cb_data);
>
>  /*
>   * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
>
> --
> 2.50.1.565.gc32cd1483b.dirty

Nit: we do expose the reference iterators now with
'kn/for-each-ref-skip' (merged to next). We could directly use the
iterator instead of introducting a specific function like this.

- Karthik

--000000000000293a97063b20d11d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 66ec7654f0de0cfe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pSnoyY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTIwREFDQXhmNFJ6akFCeEFjZ3VkdnhodjBST21xNQpIUHkvL1p4VkV5
Wmtrbi9teEpHNFIvUWhoZld6T1dSNDUvN0tydnFGbitGY0VFdGZScnZwY2p2ZENXYmhhQW9yCmN0
ZStTTTZSTW9rQmRMbVpuUzNSdjRWa1V5RTkrVVNPS1lEbnlFemd1aVhqb0JZRmcrSWtjWWpqb3ZW
VDFSWFoKWk53K0xpRkcxSkdKUzJiKzlUR1Nza1RHblZFZXo2QUErS0t2ckpEMGhBQ2VkZVRWVHF0
amZOdmZ0Y0RnSlovOAphZ1QrVTlQWWl6TnlWN0NzNHVuZmpWd2JjMHVrN3ZVUnRJdHBYbUkwT3Vr
bXJucGZPd3J2SjlCQjh0blhjQlpQCmh1ZjBmZGFOTHdpcDZQUUNjUGhoZzdOUkdReUcvYlczbVpD
cFlmZVlwRWtWSzVLcU1HdHVzNEdFUktPOWlXa1UKc0RLWXdUK0J2T0N6YUdWZERKdWlKM1Vxd3hP
cGlFRzVmL2VPT3I0Skt0OU1BenpDTUg3dktsSG9obTZUT21VWAo3ZmtSNERFL2ZUT0VqQ0FselVY
NTNvTnJHbXNldWsrMHRQRmpPcmdoT3ZxSk9zdUlMZ0xtcWx0dUNhQ1V0K1pZCk9kVmp0ZlNwYzA2
cWJCY0F1YkY0K2dBMXgzMm9EdWRZN2ZuRFliUT0KPUZheFAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000293a97063b20d11d--
