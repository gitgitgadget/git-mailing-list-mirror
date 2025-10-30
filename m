Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5D2FBE16
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827048; cv=none; b=Oi2PM8Fk8VZ6bwTl/tqdFa0rMHjgCK2XnaSQDcAcD8OWTwyZ4B+V7oM3/kkaoBmrKZsfndbN262GJ4agTzaYMu0TWplzBhK/M4HfyQdwtPfIYGE3+pOwAXm0HX9oBHfmVDLc/HFUewhuA0KAmMhxK3WyHcVYNj8jzp46sAyuv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827048; c=relaxed/simple;
	bh=jFUW/w2yoMnloM7JgG38uvrMS6Abl1wnM8Yk/k6+joI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=BSdjHu/uQ9fnjmzmaQPMEhpDAyApyQAAG7UQv3teTnogXPM44wd9vSBhlLNKZNbEeTsIDK88Xhj/+rV4sCRVw+Lb33FhH521xip0QFlqqOqkQSuv3Ye2woNOQTRAAJOpFfY4aTQhwyLZrndDCDH6a03p49qD0EiwekwGFUs/whA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtepijEn; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtepijEn"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-932dfe14b2eso806417241.3
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827043; x=1762431843; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RtERp3lq+rpGvMNsN+waYAM87E0oKQINMJ91YO8PIo=;
        b=EtepijEndu/Wp2lxwuKf2LuqflWUXevmipzR+E0Kt2G6B0G4O09JxNmPgGPUufwB28
         U7eknRqVCXJB4qSfE4wuJIB59PgpdKsi8V9hed2rDTaUJ5iWzwq3YzWWXlrM8Gt4SIyb
         lJ58P3+P7WKpC2uoGxNYqdDhDaGRa54H4TFzHBw2TckPoTJrFfNjALwHbQhIVQpjM6Ev
         Xozqdk/K26z9NW1SabnnbqW8kxo9jLjF+PVpWF4pG/1H49XLTLxAjsr4R0zngga9kags
         0dezteWbP8uyl5ZoMsnaGl17CN3Kcj3diB3VjJV7jKtvSjOBnA1Pq7qu8WEsknSDMwOg
         S2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827043; x=1762431843;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RtERp3lq+rpGvMNsN+waYAM87E0oKQINMJ91YO8PIo=;
        b=P4V863g08qyae553EWTubT9WSRYzwrq9Y4AFZ93YrL/sEj5+O+cZW6UQBPMK5Jy7ao
         g0hsF1IUwIvk2akkFqhnBrAOjALCnRm/63y2/wBw05Qf7shT2BeHNj+ra5ehpFpP7hbY
         +ex+Q/PGzanVm0e1YPj3JlISc/CQt2TT+oBnFB4SNyMP64k7mFJ8XCFxV84VNNA6Xa/x
         MnZLCeVaPK83oJD4EraSJqUghrzaVsHj0/kIlQ4PE49iERq9t+NF9QyWFj9k9FM1Fnke
         9gYUXzmr9qzcpYba/vvXBpRCo8NhS2Q4mn1c+bXaBWFZAmbPmJ68xm+VyCn97ZCPQAct
         k0cw==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZZ0fI+/GLjR0YEArNZ6XZq/5cYg6vXgnN8gt7JUvyhDca9b5+4fncKNXBTzgdFvrgY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+AtjLCbWWc6cQETBb9GTkGR2fpunmx/J0CKgZcJ4phpeYbGt
	PI5rOk/vDiWaylGQtwuURmkexaZVoqorGphtVtvj7hqqfitJ0eSXO2w2OoaB7EklLeZifrhO+TF
	Pff3YxgyRjQsefb9KZ753N19ZF6++foj5f27N
X-Gm-Gg: ASbGncvmzHOP2BSC799m+mszydxqyEo9wXNFtTEgdTvJTw1ztBTugFgx7C4K97G6YZJ
	oT7oa+ojjLgMeQAMLRNAz/7rac3XasEQKtOW9CgUMZRkyWzNNdJ96GzrKMGdN7mXMbJJMIVx8x+
	81Xxqimu6BErdaKwdKQ78liyHWlOayZ7Ku/hcGfrf2EYExtJZSRR9pKvrCaGhMqOon3oyGcnL+9
	nmDWVk84p3ewBMryxMu94q7Va3i6GfeD3MkAvAcEMFQ3qtcfbP7N4yAxsFZEJ/249uWYdRv8WER
	fOpkMMPol9UJ+FSUww==
X-Google-Smtp-Source: AGHT+IHjgwDPD4xbyPAmJR8+/TjZ0BSkOXmupirumf+mGAaunK+o6tMy0OvKL0ksvPmhEbwo7lOh6QScgy97Q/ZMyVg=
X-Received: by 2002:a05:6102:32c3:b0:5d6:1565:e4fe with SMTP id
 ada2fe7eead31-5dba1fdac99mr782105137.36.1761827043441; Thu, 30 Oct 2025
 05:24:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 08:24:02 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 08:24:02 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Oct 2025 08:24:02 -0400
X-Gm-Features: AWmQ_blUvCDhLDEqJAMeHQgUA8OPCiL7sweBOIjBLIwHP392n9lG6aBC3T8g1aM
Message-ID: <CAOLa=ZTr-9==Xs1G39EbjKaT3PDOVTY5uDXiJYmzEwqpZLdY6Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] Carve out loose object source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000014b80906425f532f"

--00000000000014b80906425f532f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series carves out loose object sources. The idea is to store
> all data that relates to loose objects in a single structure, similar to
> our `struct packfile_store`.
>
> The series is structured as follows:
>
>   - Patches 1 to 4 perform some cleanups in the vicinity of object
>     databases.
>
>   - Patches 5 to 8 create a new `struct odb_loose_source` and move all
>     state that is specific to loose objects into it.
>
>   - Patches 9 to 13 then adjust functions to work on top of that new
>     structure.
>
> The motivation here is to make handling of loose objects completely
> self-contained as a step towards pluggable object databases.
>
> Thanks!
>
> Patrick
>

The series looks good in its current form, I only had one comment. Will
leave it to if it needs to be re-rolled :)

Karthik

--00000000000014b80906425f532f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1f0b32763769ae4d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rRFdPQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTRrQy85UTh4ZERtVUlRZ0FCVE5nUXY0NzE5T0lubAp0WFk0SENHSjVP
c1VQT2xScVlXNHVWRks3VEVQdytkTnVvN3FBTWNEOUpBT0JjcFFnNmVScUpob3dpOWM1c2grCmw1
NWFmWStTRUI2czZobmt5UzRlMGZpRjArSmhibkpXVXkzV08xbHFOOVc4NTBpaXRzeWxHZ0RjY0FQ
NXFpdXoKVk5xZU4zL2pPNXBKTkc4cGNQYzgzZkdPNXFwNlVKYjlQRCtvTGpDenRVWjd2NUhQYSth
UkpEcjFiWHlHdEFwcQp4K2NaMGJ0VXlTY2ZpU1h4MVZVSjNWOFBuK0h6M0M5ZFNKMDhIVks1MWZr
V1VkNDczQ1dLVkNJYnRuQkFSSjkwCkN2SUpwVEtTVTNYQkJzT0E1cWl2YytsOGNvc0ttSVVYaVpa
cWNqbVRaN2NzdXUwSXZLRENZbHNnczFHU2dSbkQKSXpsWnV5S3VnRDlvWTFKcWVDVS9jMVk0VWti
dk13MUY0VUVyQllURUpHay9kRm82V1FmT0J4M3VuMUN1QnAwZgoxa1ZUTDJnbEF3OXBESVZsN3ow
bzg3NXhtZE1UU25USUNULzBiandyYVE3SmE5Tmdac3lDQzhreERTWkw1clovClhYaEdCM2pvc2ZW
ZjdsN0Y5MU0xelhpYVVHeFAxaW1pMFZweUdHTT0KPWlWblIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000014b80906425f532f--
