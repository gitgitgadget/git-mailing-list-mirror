Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1123D7EA
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404857; cv=none; b=QH1gqtrCE29dBLHktRxJDITqdgVvJKdKrlMLVHwQDWOmwWLvOXrwznxv27VXOcAXewjdxocbBP306tPFBN7cHuLskQcBsEiVXADpjp+MI16axACPZWTkeXWkyaoiCWKT0e3WhoIL8QoQSVHNjRzm59Uq746VwvZdFFBXYZ5UxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404857; c=relaxed/simple;
	bh=TbHV48bNAoE2nw4cZAB5Q5eXVHywM3KK8upu9EDUBxM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRY0bZ8U/gUeOYM9HL91BZt+0S5Rr3qyV+9PpztNT5Gzi9dX0mMaF/zABNgGk0mGkpYTt0og4Y6NIzoH6akuBzhCWFksxsVF5UKbZaceGiIBwbMb1uXlO5pj25rEdbU2Vo27/KxZHYy8jj34azodvOk422IB32S902mMxCw5J+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgGLnx6G; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgGLnx6G"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-52dd67b03c8so3807119137.2
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757404854; x=1758009654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aAC8c8brIwp21jrMV6oSML6PF7J1RAxYrx16WIoD6U=;
        b=WgGLnx6G+bbNLNE5hEO1Z8VIqY2AtjvJKlAB+UItThY1GlD+9SjzTGF3MEvILW8Str
         j4dU39TJB5jl28mXkk/vpY8UUtplDEODA8GnKwXTNUt17l4Mp/WQ9NMZaJ+g5OLWm+lY
         jiRwuF82SNAQuE7KOaAageGp3APXYOmWubASnzyvVyzLBMB29pseXgpIualse4x3ggbx
         FOXQeujg6pNnUjJvGXRi5FmQynZ3GajPhvrFjbPV7qeJXQTyJBki3sJEo8BL5E8mbY5f
         a7GhoaTA0r/3tstlVKq69lfP2+zaPe5Hf8zkthV6p5rSFvtGUhGv2jHIj0rNI/ZugUM5
         tOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404854; x=1758009654;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aAC8c8brIwp21jrMV6oSML6PF7J1RAxYrx16WIoD6U=;
        b=IEAjItljbRallNjN43h9oNsK/DoCVevkJiII/GnrqlWS8hQA40KyOS1MsPTWPf6zRB
         c5XuYKy6qe3DTBh+aOvTgR5cR8HkpfCmQOukoEp1us8NZCJ5LpqLud10OiozQs2GuZIA
         vceqUBQWHkluhJZb/QG3FvG643nlHdoHzzg2QoqAXVdWum/sg2y0//t0g675KqC96puh
         v1oX9+jEVFDGA5z9c1rToB8782uGmjWRjftguUW28qgfO3uaCWDqnQfS0RMbRIAUS4zO
         VKWYnYz+94eOad95cDoJcCJs7WlkIJ1eT84j10vkLKu30r460oHujklW5e3jb9kH+reQ
         PH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1UJr744yaaCiCLj0FbnXbcoAocX/+X4cccK+sBmJL82SCrYRvZVPWbYPkJ4Gb9/Qc94M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1mNDjWlYWLNZ54AUNHY0HpAiRVbh3yBvNi4LcUwP3dTOntos
	E4jgnuAQglICUwwR8F/tQIZILoUaaw/Sl6B+Dkfgjk6FxdV1l++Pi9DWcay8n8K7x+0qE20rhB2
	0Wv87MiyG9s1+oR2sL1Xq6rtNt11uLVU=
X-Gm-Gg: ASbGnctNpmJlzcM+uJ1sYAfaKxez9bzUsI+TaX2kI7ks0s6L9pr1XxmmhwY+zLlRDQg
	4jvXzQSI55HMFgtSVVvm5kcKofy5KGt96ctXTDHZ3Sxt/7uCIIW2JyGHs379Fy+/nUSM2aP4YUF
	XiiFXljCYdDJrlWePBl/QUrjEYW//1F+IVLmkcbCgH26VPEPA+6HmFAzC5EM8WAdWu5xJkEs2td
	Wo0jg==
X-Google-Smtp-Source: AGHT+IHORs4iYEul5gEmtNKHgB+E4SVuuggvf+ZHuFi3Aqnr5I1IdlYBBFTB4XAFymJwu1KPZToEdF/rf8Ft+LoXKFQ=
X-Received: by 2002:a05:6102:dcd:b0:523:e010:df0f with SMTP id
 ada2fe7eead31-53d0f9be80dmr3781070137.0.1757404854592; Tue, 09 Sep 2025
 01:00:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 01:00:53 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 01:00:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-2-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im> <20250902-b4-pks-packfiles-store-v3-2-6925278efeda@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Sep 2025 01:00:53 -0700
X-Gm-Features: AS18NWCcEjAVb3g13eVFQMlDztaxMb9jMd18H8vxq-soRNvmeOXHozMyfejf_0U
Message-ID: <CAOLa=ZRrBVoGKo+VD25LDBUV2QF1jow62w5Ab3cVmu8S7W+-kw@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] odb: move list of packfiles into `struct packfile_store`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000015d626063e59b473"

--00000000000015d626063e59b473
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> @@ -789,8 +784,8 @@ void install_packed_git(struct repository *r, struct packed_git *pack)
>  	if (pack->pack_fd != -1)
>  		pack_open_fds++;
>
> -	pack->next = r->objects->packed_git;
> -	r->objects->packed_git = pack;
> +	pack->next = r->objects->packfiles->packs;
> +	r->objects->packfiles->packs = pack;
>

So this is where we insert the packfile into the packfile_store. Okay
makes sense.

> +/*
> + * Close all packfiles associated with this store. The packfiles won't be
> + * free'd, so they can be re-opened at a later point in time.
> + */
> +void packfile_store_close(struct packfile_store *store);
> +
>

One immediate question is, how can someone reopen the closed packfiles.
Is that something that the packfile store should offer?

>  static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
>  				     const struct hashmap_entry *entry,
>  				     const struct hashmap_entry *entry2,
>
> --
> 2.51.0.384.g4c02a37b29.dirty

--00000000000015d626063e59b473
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 134094f245fdf30c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pLzNyTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEc0Qy80d2doN28rL3VaZlBWamFUTW8veVlwRUVSZwozSWliWkNOVGRB
d1BSRklHUTU3Q3l1Z2dCYWp2WUs3M1NoazlQMVJDRjcvcFAvWS9MaTF0QU5VdGF1N1pmcU5FClpX
MG5GSkk3RXM0eHB1Y3lpWU13K1B5cGpuWnNpWGcrNVcvaTluR3VXeHc3YXNpTW1NMmJYaXkxTS9J
dlR2NXAKLzI5cmtUbzNqRmZRdmIvZEJlZW9pSjhuTDUwV3BaSkJ3UEpMZFhnNXY4d1VIREJmU0hZ
WkFNQWFCaXJOQjBIeQptWm93Ky92TnZiZWFucWhHNytqZ2orbi9DN25qdzlJTEhaWVF2TTZkRTF3
clBGY1pIU0xlUVk5RU5ESUpSVmc2ClcxN3B5RkVmUDM5NmVqOVd2dEJiVmYwcGVDZ1VIa1FpK1lX
cG1LMldRdHI4M1dnWk1hYWNuc3VFU0hzSlg2aGMKWHhFMGd3RHV6azFRR042djNHU0doZ3NFZCtm
TklsanNpa3puc21pYjRvRGpKUk41MjlzbmpSYkdhbHBZK0FMUApQaDZMMkJmYkVtNjJmeTdpZDQw
MHlCY3p6TTA5cjlGY1hVaUdJeVhzbmZvb1YvOEc1NktxWUFYOTZwbkJ0Q0RpClRJNzdDZmFGYlBj
MG9oZmJDR2kzdVorRk5uVjJsYWJzRWpiWnppWT0KPTR2TU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000015d626063e59b473--
