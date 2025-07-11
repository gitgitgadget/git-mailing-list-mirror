Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4D27F015
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227959; cv=none; b=O6zeUT9kXyrbtsEpvj49IhiDDUasWTtPBi/MSvU+EbWUv8UDi/XVWVR9rXFsCUxXbZCrq8gxqzYSM5bSIqqBmCQqLn1sRNyz7ZsVKjXmltDeI+RocTYjQ1CxCw7haVNYPWSXoeiBxPGu8aKBOS48ON4+Xp7t444f0K+DxV5JIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227959; c=relaxed/simple;
	bh=U7GE+k+Ojx/QfKFafj/I0fW7S4X/E5Vgy9oYad44kr0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=oxzZ6F/asvsg3lp3hmn8hOgqiTyTQXyo8TJbs1ZevhtHQ57eBDnkZD1hG8naN4OzL1X4/xkgpY47pTg9jvSV1xARcYYj2obeXGTGNZ5kxUX1rxvjUj9IiwioexKbgSQxT24LsIVXPokjRWi879vkbwT5v70la/BpLEbio2fQKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyTcHyEE; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyTcHyEE"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5315972826dso1762278e0c.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227957; x=1752832757; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACgeFn8Pi2dxmFULtNT7SXw1pxLttLPfzy2cJhhoorE=;
        b=UyTcHyEED6PSyh6pRcOeMuf0Dq828HRXP3rjfiatgwhqqRPw3ZFNZfnoh99+cnlMjf
         ZoWpfU6Kc30unQtMzJJ+hRQfnUywXIRZSocp13qh6ELKKQed1OzBRJbLNT0MKjqFoWXh
         JyhSgKDzggGrix5lKG2uZIm3Li6sd9VvahmUtgOIznV14VzL0nf/der7cV4sSITIvTUc
         k3b9rb+G4kxBRP0V3dmZTfAw5LkuEO0SrU/uMbjhwgGU7TWwUMdgPamkqlgnNIw9FHHL
         zXOwOLRuCxUwdIW4MxkH7HLFrmlZx8xMjGoeiqNlX/C0EhwmFTyucBx4Myzjl0hNznp1
         qrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227957; x=1752832757;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACgeFn8Pi2dxmFULtNT7SXw1pxLttLPfzy2cJhhoorE=;
        b=uoALy+bEwHMm3O4Z0w9mHUZ04zd56cEv2WQ65jSNKJS6wd8IC/5xuHkGVQBtysK/PE
         GNQHfPVnCV5pWEHE3rB4L8MCzwTO2tML1Wiz2fEa9p5MHxJQvZVTl+EvugSMQzSOL1Yj
         8k+6jSHOsgSRpHF2DGRzDsICwo7aao+GCsQ4T1szNtRKiqIG92SVsJob88b3G4KS5M03
         wLflTH1NHfY0YyqS8lBaiPqI+kVel+IqE9NjLtctO6b868P9v+J/mZvuKBTcKCzhZK5e
         pnRsMPHR68uDpN+AMzrfEfaSk27mCdjyMF/OPn+D/bjLj4V95OUnmApQ0RdlMGpLBgCY
         6cNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/CC8QpxheTAiMQtKlDMik30dxveg9gJdhxNqY+dY4QUnNKWRPqdsw+ZV3oxbG9ZYFfkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHUu11C9CI6Vigymo69DxPueP588KlF6QDU9CsjgnzOgre9Ar
	I9gqA29OPIQG1I/e67pSRrgAzGbiCFlxjSkHCvCCcunxcgXkmwCVOqwFQP4FZgktBsvlFwNLzJv
	3MXN5hWBj+NmUw62738ziUAdiIetSxm8=
X-Gm-Gg: ASbGncuuMiHAvSpmS1q0kZktM/CKqXSvoL/AzSoHQAFFrN0SKpQ5UbyRMHoPDBjkPa3
	zSHX3dr6MzT8pYYmmLpelyGqKbgAI1UzPkItQcZ06Lc0HVg9Q82xEgEL6CQ3035BEGEEdo7PEZC
	/xs9ztswJlH4s/txo+nDnAc0hYnA59LoQWivyzjXsHAT5lSeviOGr9fELRBjHRbo3E/iBXWhzlp
	SbUhGKpZvSUWZjK7o/bk9LRHZuvtaDRwye+U5ZR
X-Google-Smtp-Source: AGHT+IFo/CB2EYXC3L0cW7k+626RxgaLEIaFyLY+jf01qzlKDMdS1hM/w8HHEjaaCmAHlHPzeTvAu4Hp1UBjiCvaFAg=
X-Received: by 2002:a05:6122:8c1e:b0:531:1314:618d with SMTP id
 71dfb90a1353d-535f34483b8mr2095940e0c.0.1752227956663; Fri, 11 Jul 2025
 02:59:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 02:59:15 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 02:59:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-5-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-5-62627b55707f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Jul 2025 02:59:15 -0700
X-Gm-Features: Ac12FXwktu7LPxW3ZTxIH73s8_QwHmDz8ErD0L_3MoU9URLdeNqRfl_Gxpu_Hf0
Message-ID: <CAOLa=ZTKLf5EsYGRckxWF1MLARYRdiPZh6ZJ8gYKaMxwBLkqUw@mail.gmail.com>
Subject: Re: [PATCH 05/19] object-file: get rid of `the_repository` when
 freshening objects
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ec422d0639a45c35"

--000000000000ec422d0639a45c35
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We implicitly depend on `the_repository` when freshening either loose or
> packed objects. Refactor these functions to instead accept an object
> database as input so that we can get rid of the global dependency.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 9e17e608f78..3453989b7e3 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -893,23 +893,21 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  					  FOF_SKIP_COLLISION_CHECK);
>  }
>
> -static int freshen_loose_object(const struct object_id *oid)
> +static int freshen_loose_object(struct object_database *odb,
> +				const struct object_id *oid)
>  {

So for functions which only work on object database source, we add a
'_source' suffix. For others, it is expected to work on the database
level. Ok.

[snip]

--000000000000ec422d0639a45c35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3d6a35119d45df17_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1odzRIRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMU0yQy8wWjJPcExrZWxKMmFNQ09OSitzZDJhRVJCawpwS3VuYnRrYkdY
Y2FsWllDVms2eGExTHlWejlYU21uSHl3SkRWSVR1WDhIRUo5K2pRY1I1WFhRbFFhQmd3NGd6CjB6
T2NiZCtwUGRoWkYxZUNpSXZyT3JxTmRrVzl0UlJERWZ6Zi9CVUx5ekd1bFg2V0xFbjhac1A2T0l6
NGF0T3AKNFBqZkhHN25LQUxpSmxrRGRjaHVKelRUTFNHRmJrMmR0K2VHcEdVR0syVWNYSTlHSEZ6
K1RDWXdEemJQOFVlZgpROWo3OEtQV25Na05nVmEvT1ltcjlQOEhhdWszNk5FU1NkWXJOWDhtY09Y
b01wNlFXUnVybExwcUxPU1JSc3E4CmpKSllPMDgwb2N5MnU5bmRlVi9Nc2pNNjZjU3JQSUR1d1NQ
Rm9Xam5xb3h2TVM1dFY3TFh1NjBSdWd1STJlZUoKZWcvaWRpLzh0aDNhN0lENUFJbFAxYXNPOGEz
RFpVeEc4VXBBaHlnZzk3M0tqVXpHcitBNERXRzdGM3JZb1RhbApZK1V0UjFnWHBGMSs1WkJpZTcv
bkpBZkV2ZmZ1N09UZ2xtSmNoSUZnaUljWWZHcUtQSDY1eEwwa2VMTXg3SlZtCitySGJGL3JWZ09o
SStmWkZtSkJtWDVjbDBNQXpVd09aY2kydmJlST0KPUtzaHoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ec422d0639a45c35--
