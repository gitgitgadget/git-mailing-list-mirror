Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FB20FABE
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641023; cv=none; b=XgMfw9Cu9tHN4VeZ7HD6PzC33DnAXVBzcQDQjam6c9c+QEW+l3AoRXjh9FdfjCB2N9s0/vtpCYwx5p21rI6jFksQBIpgso6RK1GfOuJ4jE4VCPmNqdhGm4uKPnJcG332YESHbEM+eJRgjOXpil3cIRvckrXNIOMiSKdTOnYFTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641023; c=relaxed/simple;
	bh=LsSzL6o2x3t1sTVnHGEm6J0IvcBz0ISNxJQ1DQrvEKM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr4+QEjZqCGlHcM0YBv972HRpDVOClU1RkwsxwDCBY2KlfRd5JqAXzWMG3N9dKM7OajH+EKn2cHcBCBf+LxTJnTkvoDGdz77hAEl8QZFT89HM6Fye42pO+Rk2KHkzEzUcvqdc2KJZR2p63+id/PBHSEin6ybaBiVeEtSUqPfBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TruRmreI; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TruRmreI"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50abd42a6b2so1659000e0c.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728641021; x=1729245821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EsUn4drZ05zre2f8yPiHflqt7BUcgu99DnvypjFAQY=;
        b=TruRmreIeVR/TR0YECM1fii9p83qPsBT3/x3BJPxmJ9RJX5G7KXa+tvfqJYwfja/II
         egWZOa8O9cwt9fhSrCJMZEOHDI+0a+KRPEywEkqw99j9z+t4VwGvE0Qyj3/XxvzVfK/K
         GewzL/41jDaFHEMgFwatnf3WtrqRxwHBiOjvitwxZoAXFVmjZTALTHphXhM8QXNgrP+O
         Inq7U3d/Q8q4IFH+qnKuP9KSH6+Ert4Aaav0gHRmEidKQzuZ+A7e+bAvKHrisK+P+l5d
         TCMKENFkjdW4oRqwidHWcuLCnNburR1tx6vc2pk/RlP8wCWdp/2sinb7DvK9ynpdWUJj
         F1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641021; x=1729245821;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EsUn4drZ05zre2f8yPiHflqt7BUcgu99DnvypjFAQY=;
        b=ORg2zijM47k+39miZZfPipga3LkwPL9NgWB3jHRr9Jn4bkwcVoBYYIfR+EMR5DW2WA
         dvzcEYH2gRtYlbRRGQrtrsndHdlLSph+1+d8G7NnpCyl+H1xxAXPzMqJQQtMUlfVLY5V
         XlFP79T0hlEs+BB7MAUyG0UZwoYWA8/zUpMs9HyxwkOKE9QpLzh2gjKa3Q8XIPNRhGWf
         KeM6Ug8oEXksI8DtgGRfvsqMfD7YvydP/Nl4zz7iMOFifmj9iiVFHNy34kDhIhCNvoe0
         V6+t4TGji6xBXNXiJRRZtPnRCPLUAIPFXf+Z9INMPtA/DkCpEMvikza/hRgDPHDLQL41
         Z8hg==
X-Forwarded-Encrypted: i=1; AJvYcCUmC6wLKG7p20Z7ub+r9AacAFv6Dfh4u4rstcHxt403EJcyrqz3cllAKgT3XMhTz9kr584=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfZFz8K3dfuwsrSuYMaqnwEOZyjYTeCdNx6ED9nYFWKvc6RVV
	pEuZRsKtVHDNBf99YrTY2u4rM34iVeLa/i0A+3ZbD4/DMIvY13jcRWP9JXICfz/r7zhytkxXj2e
	kVr2oHgiu3MeI3BK8ev8llPgn5bKukrTm
X-Google-Smtp-Source: AGHT+IH05Vc/0juc2B5HQKTDnWZS/5YFJCRCS4tjDcvBan9JAd3q49K57wKpIFc8v/37FIZuiUmIv5odB/p/M6VTp4Y=
X-Received: by 2002:a05:6122:134a:b0:50d:2aca:3b13 with SMTP id
 71dfb90a1353d-50d2aca3d10mr304077e0c.3.1728641020741; Fri, 11 Oct 2024
 03:03:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Oct 2024 05:03:39 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <24e31619b936166404b801dde0e2bca478328386.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im> <24e31619b936166404b801dde0e2bca478328386.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 05:03:39 -0500
Message-ID: <CAOLa=ZSwHeDAFi9RTzuGAi+5ogo9L6XG2K9WHY8kmvz6v-ZAeQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] reftable/basics: provide new `reftable_buf` interface
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Content-Type: multipart/mixed; boundary="000000000000fc6e690624309940"

--000000000000fc6e690624309940
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Implement a new `reftable_buf` interface that will replace Git's own
> `strbuf` interface. This is done due to three reasons:
>
>   - The `strbuf` interfaces do not handle memory allocation failures and
>     instead causes us to die. This is okay in the context of Git, but is
>     not context of the reftable library, which is supposed to be usable

s/not/not in the/

>     by third-party applications.
>
>   - The `strbuf` interface is quite deeply tied into Git, which makes it
>     hard to use the reftable library as a standalone library. Any
>     dependent would have to carefully extract the relevant parts of it
>     to make things work, which is not all that sensible.
>
>   - The `strbuf` interface does not use the pluggable allocators that
>     can be set up via `refatble_set_alloc()`.
>
> So we have good reasons to use our own type, and the implementation is
> rather trivial. Implement our own type. Conversion of the reftable
> library will be handled in subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

[snip]

> diff --git a/reftable/basics.h b/reftable/basics.h
> index 4c9ef0fe6c5..4cf3f0e7593 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -16,6 +16,22 @@ license that can be found in the LICENSE file or at
>  #include "system.h"
>  #include "reftable-basics.h"
>
> +struct reftable_buf {
> +	size_t alloc;
> +	size_t len;
> +	char *buf;
> +};
> +#define REFTABLE_BUF_INIT { 0 }
> +
> +void reftable_buf_init(struct reftable_buf *buf);
> +void reftable_buf_release(struct reftable_buf *buf);
> +void reftable_buf_reset(struct reftable_buf *buf);
> +int reftable_buf_setlen(struct reftable_buf *buf, size_t len);
> +int reftable_buf_cmp(const struct reftable_buf *a, const struct reftable_buf *b);
> +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
> +int reftable_buf_addstr(struct reftable_buf *buf, const char *s);
> +char *reftable_buf_detach(struct reftable_buf *buf);
> +

Nit: would be nice to have some comments explaining the functions here.
I know most of them are self-explanatory and similar to strbuf, but
since this is supposed to be isolated, it would be nice.

[snip]

--000000000000fc6e690624309940
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8e50a08dde72c4f3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSTkvb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHhQQy80MktUWjc3c25yY3FDNEFJaVZNeUVKbjhFSwpjRzFUR1NyU2Jx
ejQ0WmpCNkQvSGZ4NEtHZlhLdVZvTVQ3ankxWkg5aHB3VSt0WUR1UHNzNXV2cDlEanBxUi9DCjZp
aTRVeWhRM3RtUnVvYmU2dHdKSlNVSHFNd29HeFBIZW9Wb240OFUxT1U1OFlHTzNJbTZqWVZJVHNj
WWpxbWcKRFFVb2VPWlg5UUVOUjdPRkdlNmxXTGVSM1I3eGpjY3k2THBGaGxNS21JNnphWVFmUnlK
REZqZVpadUFPWU50TwoxNmV6Q00wSytrc0I2OUZSTVFNNkI3eE56Rk1qOG9rOFFqbVVnNnkzZ2Fw
RE5hVENKeGlia3Z3cUdSQVFnSDMxCm8waFV3UC9UWDBuREh2Y2V1cGIvSG5rOFp5Z0RzU0FQaHAw
VXFaR1dlNThZcjhqZmsvTCtOQ1hISnJWKzg0dTEKRm5CSkVWb2d5dWZ5Vk1CVUNqSkN4Z2VQSVcw
SWlXSVJCTGV4ZGdrNWRlcFNwT1QvQWorNkxZdUNBQzY0MmFXaAowcEFMSHVNVG03R1dQcGNCT2c1
cnBYYWkxMVpCSW5hb1pPcm5GeXpKblNraUhtaFdrVFFEUE80NDBkU1BqeWt2CkhlK21OYVJ4dmZo
QmRiTm5iRktwVit4MjdwamI5cnMzNVByVWhQUT0KPTF1NHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fc6e690624309940--
