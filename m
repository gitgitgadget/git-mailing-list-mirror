Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C318E043
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139405; cv=none; b=P4nZGoGLLVqwVRXaX9rt8vBnZbfYHVBiedAfpiqNJX++YxHHETtVQ6Q2KYm0OiJH3eZ71BragVfvKSYcPDbVdglYujPB1KJP3yXCh1tX5CImS+Jle93u07UL+jP3cfGd6b1mNAJ2aJp4DvNUedbBShX2ousLwQnm+RahTqV2ZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139405; c=relaxed/simple;
	bh=RNBubTif41Uv6gCSnjuL4vP6Ns9utcfqgL7IeVtQn2U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1FC3PFFxIj8s0BUOjGC50DT7IhzjvEwxl3vcg0xLDBqLNH7lnCbVh5FsWqpsTuZz7b9fOu5eDI315Lr5PhZWiuMRmojoKLi7EToSGSlUVQU51s/5gLdedD7GRYAETWu1xyG74g/xNJVrkyePVyfYM3WmZeAZTv/m8WaL5zDgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MikoZDIs; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MikoZDIs"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-502b405abb1so265596e0c.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2024 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726139403; x=1726744203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8/Qy/p03SDjqvffqDLuodcavfnEPCOgQ1h6CJxv/fM=;
        b=MikoZDIszPqiu7dFbYRtVnunhfQ9Ta69CknfxjNGxORDve97uNn6ziWYVDtTQI8YWB
         /dPeEpRHG0R/TbWXdzE0zenQ6Tk786dhPr9R2AMQbiRlw2SVxvP4bkmlQe2K8cVgI+Ka
         EFQqoehp2ZQcp+i1ncqy8UN0lCJcJ7JRSTOFNpWOIHayPG3pZqp2tiNrfPoRwiX/zrV0
         UsZE/5ymGnTKQmUlCtUV/pSo+E55RtO44WIwaqZEngVYnp03ACd178l+3tBkXPWoWXPv
         6p8ZPFwTP/axOoGK0uvVc1QyFyKdPNvvQxP+N7A5HjUzouaXE/OzrgOx16whdBn/FbYP
         Qm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726139403; x=1726744203;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8/Qy/p03SDjqvffqDLuodcavfnEPCOgQ1h6CJxv/fM=;
        b=BZk0/xMgJBD02a4Uk3fdcjVQ5EUKs1X6evzRq+q/YRrrxYQAtnaHA5zVMKprvCyOFQ
         /MEp9nFhAcJztg1nkSG8m6MpL2fKxsTRIvRXKePra9ylHj6V7YLwS+9VtikBHFOoOK9M
         5NQnG3ZjNgFgI5Y8jAOUgNctzU1yXVkfXYKRG3Ae2V/3XgZ8XrBa9CAKbCogUSkWt1iV
         Dhq/bqog7OcY2/aJGQauWJlldCQu/MGMXw+K7+/cCEAg8QbG6vqdfEafYZzaOixBQmz2
         MWOEwcX8HxBb+S4O6X+kTSgMuWut+chmwR3O4QtxuNeUCPsVchX2ukyrIvMr1WoqcWWb
         4V5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoXjfQPPEDAyvrpOcKciJpG0S8t0/6I7J5Gk9IU+YjhDHGsDXIglNNr5kSyoNtD5eOPjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQH+U+h+Z5DC6nuSNmXBxqc0BGslOm02iF7NrOal0awQ7PxMPC
	RTYxqpanTc/EZFfYQX5G3PFGzY8rse+K5pur2PqhOc9x2nsv+ymANlMDe8MNDV3Dao/npaWq+PG
	wKlr9vx7WqieegJwW3Lo5PwWtRMc=
X-Google-Smtp-Source: AGHT+IHJY82yLIwY0MxK4okq8z0ijzEU4nAQ60iyNTZdiQyXaJXNN9ltF8jAkuNafExnGJhPBaJOOSNDPRfnrpcDkPI=
X-Received: by 2002:a05:6122:1786:b0:4f5:abe4:50e2 with SMTP id
 71dfb90a1353d-5032d3e51f0mr1695495e0c.6.1726139402938; Thu, 12 Sep 2024
 04:10:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Sep 2024 11:10:01 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <b5ed6928070ca02463bf53d339aba47bbf25e86a.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im> <cover.1725008897.git.ps@pks.im> <b5ed6928070ca02463bf53d339aba47bbf25e86a.1725008898.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Sep 2024 11:10:01 +0000
Message-ID: <CAOLa=ZSzBadik1cOYvVj0zmf6-gQgn7x3GXvPiJwgzE=2p0T+w@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] environment: stop storing "core.logAllRefUpdates"
 globally
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000f20ceb0621ea25f0"

--000000000000f20ceb0621ea25f0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f5871abcf75..a536d7d1b57 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -75,6 +75,7 @@ struct files_ref_store {
>  	unsigned int store_flags;
>
>  	char *gitcommondir;
> +	enum log_refs_config log_all_ref_updates;
>

So we add it to the backend's store and set it when the backend is
initiated. Makes sense

[snip]

--000000000000f20ceb0621ea25f0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8404441fe85be506_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iaXpBTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGx5REFDUjRBb3QwZ2tBM1lhQTJ6N1VTOEhDc25JTgo4d3I0YWJJalRm
c2lhS1RDeVllTVh2NVBNUWYzODM1OFZzY2xYaXVYVk9jN2NNQnUraWdjQjVPMFA3ck03bEc0CjFr
UWxqU1VVVjhuZmNUUmlkcU1uenNzc2VKcVJlMlBzYU0rZ21JWGhIbVlUVnRJSkVEeWN6bFNMemFW
bzRnUkcKdWpOY20vTlVFckN0RTZpNHFhbkltNzVrb0RGZlIzeU84QmhqSUI3R0R6enM4U3BORGFF
bWhKYjEyRm4xeFVFYgpCb1IrT29vdXlHKy9tVWliMHA2bENYN0FXWmFPb2NwN3BaRHVrUFZ3RkRY
V2dKbnBFd3NackpZSUdwQk5ralE1ClBDenBmMTM5ci9mSlBxa3c4a1p2dkhHNzdvaGl0bTE4bkZv
WTMwaUtmempNUTdUaVhEZTh5VGtMUXJ4NU9QbnEKM0FPdUtwQTBCUkswUWpUNENsZFFBTzFyYzNy
bmY1MXFNN1JqS2kzU3hXL2cvMm5yZW9wRit1N3NXZ2g5SWtmcgpYcUlzNzBpVjgxVmZsVklNK2RK
VUJGRjRiazZVS2lBekhseHNBaXRmNitNMFZpTE8xdnpjQkYwYW5KOEdpZmdUCjVwWXE2VWlzTlln
TWdJcWZMV2VwSERFZEtBQnZoTGw1dzR2RVYrTT0KPUJZa2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f20ceb0621ea25f0--
