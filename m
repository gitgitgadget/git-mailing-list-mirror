Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAA41443E
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070006; cv=pass; b=Lrwsm863FfZOMZla4VdGV3C/1JTw68meeUZT1fjt2jzQLnvqUo/ZUAaeviI0gXqMtSYneLUUj90JvBRL2WZH7TfQEb8th+gjBNponKaybkaRIFXJFQS8wCcCYamxaXoSh+Ku/EtxhMVSPandM7Hl0M8etrezPDqEl7RVpYH0d3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070006; c=relaxed/simple;
	bh=XI1tX/hZDCMjS51O1B6c0LhOTL49rWhifdB/YUmEbU0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUrQ2a475BHt2uCd7Y9MEkBn6zPIPDb/PO5fYPpEdrVMweP4bt3SSzFOwmWuE5bmUkuZ6GmJHpGhpDDicL/2zhJGmm0bH1najVn5nvdBa4kFZanEBTAQvDbEjugUAr3KNnf1VHsx5WHz/SDrCbw7vAxpvOGzVQNKCXlDPH9IhIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF6HxoYV; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF6HxoYV"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a4c5c582eso14985137.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 12:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789070003; cv=none;
        d=google.com; s=arc-20260327;
        b=WTtho0MyZ/cK21NakZwkqOk7n2d2gd1pCnTpT0BgM5egB6/nyOD0mfSt0OaVu+Q7kF
         YuQSFHSo2c93XyiKf+Bes5PagDzltP+GWhHQvQ/9HDuk3VxhhIK9CJVWC6Y9VY8o935L
         BQhthp/EZJf8NaZVUceBAaIZstojWFenuFKC78LhwUGSninnCtVrF4kW4gXKHnN38KS/
         xAGh66ojcnn92WAZTndNGeUrTuSKc3Yn87HOpfZIKjUvipzy24sN4PQov5zgGLGxCHiS
         kd1EYhT3V78a/N5PvlHkYAnZq9A4ztnGTs5KTartrGSNt1nAtR+YYmVdSu5aK2/Sq4oW
         GYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yl+aOThjX1SaBeK+2WzuyVsA5+sLuQkRPy+LpB3EWe0=;
        fh=jeIrU07mAyQ4/Mb1IL5jpxlqs3ojodCD67cH/weYrEs=;
        b=ZD+vlxLdpdAzMRcaiSNryLfZ6W3D8IblXgbNW1qGi22vyPrlp72R41Anvvfs0vwh/x
         zr6qHu1sXUMsM17nmAi6TukzFgYHeyOKZIjPvSpOmAG2WkMElhQ6/FtTbrF5qpkx6wxb
         E7PKDOzZYUsgjnNTgWR80K1meeG/Ejo4wnDBzqbpYUnLPhRfp8pVBPYokfzk6HImjnAB
         VRq9jE5SutDM4jDR2mszw1MjKWqlRVzhbDwnicz6gvrNDXujb90c0ZeFHAQ5LM5RZWvD
         1kvLRFoDqL9Nnp3OqejOMFwkC0vZKiJL1kgip+4ez75NByVKZpn3UlwIwUTeFrbcJ9/T
         rrEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070003; x=1789674803; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yl+aOThjX1SaBeK+2WzuyVsA5+sLuQkRPy+LpB3EWe0=;
        b=SF6HxoYVh2M5frMB+TAfCV8t1kcLcZ+knuRFdniv7/0wJJj51Vqczzjc6mAeBRSTxG
         CPvDXfa7CH3ARotBc7/z31s/FdnTZAwYiuJWBGZdzkrNCm6Io9/7IDGuE6J3KV0K5saC
         FugKqv1QqbnCG1YNh1dGX/R4zwDnKrEP2b4xk0r7wAKHjoBqCJdzo8F4Xn0cQeOkc2KR
         fNxQBHuIHfBMadpIZi8WozWFFNLu94WXZX1HKEYPQvbVis5OzaeI41l1IKF7OUf1SHDA
         VfMwQK5d1SMv2OmycFDE5jcmQvN8JA+udpmBpUe/38hDFgbLJ1wiLSELJPtcCibmTvND
         Qnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070003; x=1789674803;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yl+aOThjX1SaBeK+2WzuyVsA5+sLuQkRPy+LpB3EWe0=;
        b=AQJmIefcCsWUJ4PaR1URi/UQi+oBAscMgpvD+pINNfLqODW7gv8Sp23zjqbJlSgGft
         8QlVGIQ4Ext+VJRNi3gOjape5EardulJjwaPjCQ9Pi5Nq5Txj03weD+aN9cMipyqj5zU
         q0sjradYNs+N90YaeRnIiTtd0D6Dp7C3Y7yCFaolulxtVc8H1py4a6JqgErfh07PZUFe
         jR7WkRKZITjr5tuyo5JIG30MWv9P8U30z4x+YDy2EHyzPcm2aWXXomlTJPDPPTdP5M00
         vPqFhfUNzvJo7mehpZcQrcI6UEmnJjnzuTrBqneuCrn7gTjx4DOUnDrAX+8TWvtsnkUg
         nX4A==
X-Forwarded-Encrypted: i=1; AKwUvByUQjeiYkF3pZbbOb19iwihZIi5Xlka/VsmfY5eGtlkzRkAWkK7HBQD3l8fMZPXvIdJpS8=@vger.kernel.org
X-Gm-Message-State: AFuF++k1X3cXq/PczUg9mGvQU1hqZc1W0+G6OM9vl4FMrELqx1cqCXi5
	zQgmYZXt1UQRvr7GsXLxTB59Ln9JObmgQ5PrBhIg/cGI0sA1DAKD+xkuYGUVvt1qPQ++eQenzio
	y9vlehvcQ0UQiA+p2XvhzlSoypbBnFNgVNbLw
X-Gm-Gg: AYBFou0rMQ1SpQF+2iMUBR/EIAiwBzO5kiT26pIkjW8px6OArL8GlbwBt4h6pW5a5lM
	cRvPaZgQ/MQh4TaoG52L6vvyGVYIQC3TvuEWAYCo60HYNyPbzKJXEltIChUU8LJDtx2MhqF5Y9w
	4KvNFkHZCeX/CRlXVGn94ZF55+Aetapn0TlZYIZiNcCT090zh4fYru+1uL2uDDedEVal+rPc/gD
	5zpdnuIHAyh2Jl7r3LH3OX9XHx+2O8kTF964XUQK0JBEeNbBFfoO1m36Ft2kHj6vJzd02fcNK8h
	2rrbH3k26OyS8qNGpIiIISvWfQLN7HMYrcw1Lp8/e6gkYR6H0GFUz8w9nvzdv37/Z0h293P4dRK
	oNXEmjrgoWBvsyN4DFxCveRjQD8kJCAcOvv5y6cS9G78v4Q==
X-Received: by 2002:a05:6102:1623:b0:789:100e:3d1b with SMTP id
 ada2fe7eead31-792a2498889mr434885137.0.1789070003296; Thu, 10 Sep 2026
 12:53:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 12:53:21 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 12:53:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 12:53:21 -0700
X-Gm-Features: AcwNN1WDO1HgGabFkFMIw5UiqN-siPUG7_kNa3BKg73gxXtSdXGzTFOddPzB9zo
Message-ID: <CAOLa=ZRYsJL_0sKnfHD0PJO+5c+BKSMiuN20PeQHKJin82TJDw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] odb: write alternates at creation time
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000000687f7065b265266"

--0000000000000687f7065b265266
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> writing alternates into the object database currently happens via
> `odb_source_write_alternate()`. But while that creates the ability to
> create alternates at arbitrary points of a source's lifetime, we don't
> use that functionality in the first place. Instead, we only ever write
> alternates when creating a new repository.
>
> This design is suboptimal due to a couple of reasons:
>
>   - It requires us to have a `write_alternates()` callback, which is
>     overblown as we never even write alternates to an object database
>     after it has been created.
>
>   - We're about to make alternates an implementation detail of the
>     object database's backend in a future patch series, so alternate
>     implementations may not even support them.
>
>   - The backend has more flexibility with how exactly alternates are
>     configured when it itself is in full control over their setup at the
>     time where it creates the object database itself.
>
> This patch series thus refactors how we handle alternates so that we
> don't write them ad-hoc anymore. Instead, the series introduces a new
> option for `odb_source_create_on_disk()` that makes it handle those
> alternates at creation time.
>
> This is part of the bigger goal of moving handling of alternates into
> the "files" backend.
>
> This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
> with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
> `alternates_db` field, 2026-08-17) merged into it.
>
> Changes in v5:
>   - Rename `add_one_alternate` and `add_one_alternate_data` to
>     `collect_one_alternate` and `collect_alternates_data` to clarify
>     their intent a bit.
>   - Drop extra parameter in `collect_alternates()`.
>   - Clarify why we compute `commondir` even though it's unused.
>   - Link to v4: https://patch.msgid.link/20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im
>

Looks like you missed my comment/question in
CAOLa=ZQaPstiQmXm9=TyWPUxL6X2=Lcqeg6y2XeXzSJDpq-GBA@mail.gmail.com, but
otherwise looks good :)

[snip]

--0000000000000687f7065b265266
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1ef4e774adf7db75_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xakNyQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0Q3Qy85Zm1VUWpjRmh1ckVvYmdoOTVFcEpzTWllMwpySjdsSVZlWEhi
V1hick9xeVFwaG0wL0xQWHNVdGlvMk9FZjlZNDJaNzZPSXRwVjRablAxdVUyTllVVmtWb0tOCnNu
K2tTVEJySWl2MXNwc3JLSjViMXJ6WUxsTmJENU15U3JzMkd4eS9ya0hDY2hrR2pPMUc0a29lNjYw
bFUrQVQKaWZRS2tkbGw1M21VSGNpVG9oSFpnMS85OTdBcVlhc2hoeHo0bDdicjhqRGI1YzhCenpS
bEJsTzYxb0xzQ3NUZgpYMktRcTN3cmpWUHZ6aWZTMEJNMUMxbGduT2lUN0tNREJuYno1c2I1Qmd1
NlIzRlhhMHdnQjhJaU54SXIzYnFiCjZiYzUvaFdzOTBmODJvYTBPazlZdngzbXVHWHc0QWxCbHh0
TGxWd1M3N0ZCdklKVFlRL0ZtQ0xrb0ZKM0RzaGoKcGRQeU4vRGNsMitkOWg5SFZMNE5LWUlBOGMx
T0RFbDN1ZXRSeHc0ME5HSUJIbVh0b1d0anEvS0hra0lyeWIrWAp1TUlLRTNzT2ZpSGhaT0pvU1k0
SHhTeTFvWmwvd1l6eUpKWXBScmUwQ3cvYUpPUEtBTXJPUEVnSGhUcVRXaXE4CkJPUzlrQ0kxLzZZ
M1BtSGZ1aXA2bHdxNkttd2lOMzN3OVpKMTJrdz0KPVdPTUkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000687f7065b265266--
