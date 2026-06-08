Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0E4028CA
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932547; cv=pass; b=AbBJ1Kg4s1IB8IdRFGk/FdUIlh15/cTQKYzvYwMqW16zkjy1kmcMRUZbGpkPjbpJWENgsiqi141trXV88Sa25si1SyyP892DOY7omPUreXy48ehLA93gw94IZfii573aJtWZhrq0w4l1hG3MDWYufHhz3HGbpHMno0SRfVx6fl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932547; c=relaxed/simple;
	bh=zekpV34rDuZP0YI/ApVbvG25QMl1eDoDNJr+d+hUYno=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=fNro6jravG6cfn6F/8uRPbTSE1c+hy/1N2+4OuCPVLWmppZ4vQ7m8fhfZv6FafcpMMyeir14JRaI44hVd3t7fONjNoExRSOptyXKpjE8BcqT3qED+y4OM5CAbuQZ3AqzYZe7m3H2BK8vZVUsCWzEf67Wu5mrlAkM9f1nCnQbf/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWqI+QB0; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWqI+QB0"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6cfb0a137c9so2813893137.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 08:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780932545; cv=none;
        d=google.com; s=arc-20240605;
        b=Ye08HbU2Ih57xQByvfNDSHMJ7N8yK8w0IL+/vIN08sqBJ2hSHy6/qQHCmJQYC5uB+5
         /wgVDYQgLDveeE96c5K+vWe5AfgoF2JsHHATCM1swsONT69EGeRE4U9bIobrYXF62QFT
         JkUHv1THeoizt65Eq1iwNT6NGDJQSvEUc1urK3HaC3UdMGexhS4RxsoET2eDfZvJRJwX
         Knd7aUSgh9U+yeRrFCtbEWg2k/5Y2z9DoBcCDYAB1AFUI9p7uYxACAaIBfECObmytIea
         XWDmjfVmd2aaFUe/enVV19IX5lZa3WoIBEdN+gpUkgpWuMLQKNmqofxejxCFKI2JMKxu
         PGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=KtfoSj6o508bUBl6/RVp9UJDB5VbFGgkceclzMIrq4E=;
        fh=StcappRMgSS7FI0UROnQoGjmRf63qM9dwyvSHeUEnAo=;
        b=LXQlJCNxzRBG17ZA0ljgWpiXuI5VcR63c6WNtq33yAycnAdB/C2CMn1gTCqLLmreNS
         4GDrw1qUs3PNEwL0urLUqAnRx4JYAxTd6ofhI48d1i69IcsLppBWd5IicKRv3VWjVgqi
         XKZMxFKUus2xfjDki88unWCec0FlwV+zlkh3NrQn74sSOCqZ/xA3ptyKovGXOFCCvZaf
         bd+CVmBi7Mv5WXzo6LD1jLBtWKj/do24qwEm8DduFp0GFDg7oLlUZnXSACjUXdRcv5FU
         9T18bUO4y9ms7stqGSvSoAbx7DE+rGyE9RL8Erssda/AY4pIQTcpKnexGLDL3OkTiLyH
         N24w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780932545; x=1781537345; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtfoSj6o508bUBl6/RVp9UJDB5VbFGgkceclzMIrq4E=;
        b=oWqI+QB01YPy9VX34dSwA1bf4lNZjWkiq5dLIPH2pOlNzApcF4x3I3aLTuk8U4VPG+
         Gi+GNVoFteE3o/qS9NmzL4F2yQRgKzehnCVSF26JxkOVlZcZcHaEm4ov3jcFHRORDcIR
         +vZiE8yAzJl63DebrlenEQ5cUhHb1Zk6v9uUsF+dWn09zetfNX5LXDvekFqBU72Bnez2
         htDVsclkYTnTAgcWByk0pvGsS7KtVuOZ0YrcdPDcjoiOnBRcHSnUbC9rMUDHV9dYNpCg
         yaZeGlw/vMPJoYPw7OdFBf3wiuF04hw1UisZhxVJBBgwIrJOgSBa4Gvk/xrfRG9Q7/wo
         CIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932545; x=1781537345;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtfoSj6o508bUBl6/RVp9UJDB5VbFGgkceclzMIrq4E=;
        b=WhEfq/vWdRFcf7MdaM0i8HPKnEQFVnm4e+gx5Hf5d6ipsjcx+C1nM75j6kjO6eftPH
         wvif6m38VFuvWvlBQr9/x8z4Iy0LSTPJxIoDVtfQVh/hv8eb7nS5EmA6L/dyn+hOKDih
         uqZUXuvw+53wyY3jObC5R0ZspdwNR6vHafw3YkclCl9Kr4/V8nHDmw8Xkx+RuBg/bYr/
         8a5hSDMZ6CGUzbI68xfgHrRh6+gH+qwfjOIZ2WlTs7nCHyLwat97zhoX+DZEx9SFXoUm
         gmFCEc30pjtyh7zdl9Bfyg6zf/6YFoxGrFOS+5WXeGcFpVs0O2mKifu4EGlutwCrbeLR
         8Z+g==
X-Forwarded-Encrypted: i=1; AFNElJ+14RnTRH5IufeHPGdDPi8OAcOcvnyrcFqDpmhf84v3patyjWwJ+HxfFJsZhaGR7Uey3Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0rxN5bZtlfgLZc7tygX+MPr5osCO4Uze8tZ6qTUNzqVhjnUB
	fNUfO618f8R5ZbjmN//M2AWZoUwHLQIKcRyDHYOIOL5gy2PwYHYCP4QH8ceNmTV1Y6cooPIa4+C
	QkIy8oN5xwMh9AEvl2DIpcGYIvnucK8o=
X-Gm-Gg: Acq92OGcTOVyAQUgR7q198VpqaTJVhRRoPjwCFZBO0BsQtQpHezi9mWC/PzUNO8UOv1
	aO1peb5QgHvW5M4d4ZDSx27RAlXedAV5azMjNP1jaU4gD/soPPHDPVUUI8fW5ldbuoZ8rzafVRQ
	DH07urZyfILA6Yf0cu1oXcoP5XyI+HgZu27+h7KV34shR1IG7dT00NLqyUTGqGZNzpnmnZzmulJ
	G/MynOegVtWnVlPmgLpGtDJ+gSdRIMZ/wTNbxweTACRk2Fz+IQXrUqhhXGoEbhJuk5hvg1NQIsV
	Di3HuVah/w11X2Z+FV5wGX41R/C9ONcCe1DVROSeAGjj78X8itXxjZRtYjhC4AuR8OvfrWgSwX6
	Qn3STiwMT
X-Received: by 2002:a05:6102:548c:b0:639:1e8b:ecd9 with SMTP id
 ada2fe7eead31-6fefa23308cmr7835084137.20.1780932545427; Mon, 08 Jun 2026
 08:29:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 08:29:04 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 08:29:04 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260604-pks-odb-source-packed-v1-4-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im> <20260604-pks-odb-source-packed-v1-4-2e7ab31b4b5c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jun 2026 08:29:04 -0700
X-Gm-Features: AVVi8Ce6FFzOqvUAgfionk9cElQEZJvsBbK1Ip-Fvw-ugTjJ0ft9wzDO7juOJ9w
Message-ID: <CAOLa=ZQst6ucwvtVOfXC6g1ZcP9_UZAwRyAXfQdjL7WcJ6ZzxQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] odb/source-packed: start converting to a proper
 `struct odb_source`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bd736d0653bfab93"

--000000000000bd736d0653bfab93
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Start converting `struct odb_source_packed` into a proper pluggable
> `struct odb_source` by embedding the base struct and assigning it the
> new `ODB_SOURCE_PACKED` type. Furthermore, wire up lifecycle management
> of this source by implementing the `free` callback and taking ownership
> of the chdir notifications.
>
> Note that the packed source is not yet functional as a standalone `struct
> odb_source`, as it's missing all of the callback implementations. These
> will be wired up in subsequent commits.

Okay, so individual commits going on will implement the callbacks.

[snip]

> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 12e785be48..f81a990cbd 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -1,11 +1,50 @@
>  #include "git-compat-util.h"
> +#include "abspath.h"
> +#include "chdir-notify.h"
>  #include "odb/source-packed.h"
> +#include "packfile.h"
> +
> +static void odb_source_packed_reparent(const char *name UNUSED,
> +				       const char *old_cwd,
> +				       const char *new_cwd,
> +				       void *cb_data)
> +{
> +	struct odb_source_packed *packed = cb_data;
> +	char *path = reparent_relative_path(old_cwd, new_cwd,
> +					    packed->base.path);
> +	free(packed->base.path);
> +	packed->base.path = path;
> +}
> +
> +static void odb_source_packed_free(struct odb_source *source)
> +{
> +	struct odb_source_packed *packed = odb_source_packed_downcast(source);
> +
> +	chdir_notify_unregister(NULL, odb_source_packed_reparent, packed);
> +
> +	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
> +		free(e->pack);
> +	packfile_list_clear(&packed->packs);
> +
> +	strmap_clear(&packed->packs_by_path, 0);
> +	odb_source_release(&packed->base);
> +	free(packed);
> +}
>
>  struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
>  {
> -	struct odb_source_packed *store;
> -	CALLOC_ARRAY(store, 1);
> -	store->files = parent;
> -	strmap_init(&store->packs_by_path);
> -	return store;
> +	struct odb_source_packed *packed;
> +

Nit: we could've had a better diff if we used `struct odb_source_packed
*packed` from the start. But its tiny and doesn't bother me.

> +	CALLOC_ARRAY(packed, 1);
> +	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
> +			parent->base.path, parent->base.local);
> +	packed->files = parent;
> +	strmap_init(&packed->packs_by_path);
> +
> +	packed->base.free = odb_source_packed_free;
> +
> +	if (!is_absolute_path(parent->base.path))
> +		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
> +

Tangent: seems like no one sets the 'name' field within
`chdir_notify_register()`. It is meant for tracing purposes, but if no
one is using it, we might as well remove it...? Perhaps #leftoverbits

[snip]

--000000000000bd736d0653bfab93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 91d73da30cad28e5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vbTM3NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGFYQy85M2dqVnJXM2R6ZlgyU0NGeVlodG0rbTlGZgpxU3dLMzc0NXpi
S0JoQlhnYUlpNm5LdUZFTVdqMnAzQitBcmNST1pUMW9oWnkvbDlFSGxKRjdzV0FyTlVHYVRDCmRT
bHpEZXkvVEhDNldKcGhvY1YwZmc1KzdCQytISFI1K2F4dWQwQkhsYS82TXM3bmRpSmlVZkpIb3lv
ejhIN2EKVFcyVXBacjBJOUIxdUphOXpiUjJiVlFPdktmN1Vrc200VmpOTm15ZjBHVGxxNkFWLzVs
Y2xCdXdrajNpMFJ0dgpOekhxSHA5OGxEWEFuSTY1V011bXVoL0dHY01EcnFYbndhZWNMQ1lsSDI1
ZDNzamtFdk9RVnRXZHgrdm1BWHpUCkxJV015VFp6dFZmdEJPMEFVQm1LeDRndFZXak0rS3A1T3lJ
YWpWQmJXb1AzN3J1NE91UFB6aFkrYXd4MENhUkQKZXo1TFh0cllUaGRybnA5UTZwcmRYL0xRa29u
cGdHT3BzdFkzWm5rb0lieWVGN3RhMkdCY0NiV1pmM2VBcWRjWApKRTZEUHhHMEpqTi91WDV6NGlL
M3hYeUZNSVdsOXgxbGV0N1F6cFovMXN2Y3FBV3hXaXp3aUd5alcrbVdONTFoCnlscDZqZERzWitV
dDVCbENHL2t4ZlJXVExOaXZiaDlmdVBuMWVqTT0KPXgycXEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bd736d0653bfab93--
