Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45F27BF99
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695870; cv=none; b=Zhx+tOkjg/NDr8r8Ub9fXqINuJfgp+XLxeh6J+JhODFBRlBPyOUacZf7u7frkdRpWX2NN8+V8aBSDtECYvN8IvPgpyZAobUSOQLuwXT9cHO/8sErXGsLk6WJcK7Qa0rM4/lPEqHArZcBWEi3XfwNuHM/kAJzIyYdsCCpn2uidxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695870; c=relaxed/simple;
	bh=fOAwBwsZ/M9TWJGoE5JGmkigSMH7UB70MTKc4qWhJQ8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=oiu+XdtisVxHcOHioDEprfIxVrP5qNxMxEX4dVaF2Tnn9T1G5YrU5XmocPjoD9V9MHBBl0H5ZNQ0zzu8ZOY28o2z0hC4ZyKimnJuZPpRLHLBwmbs4YrZkTxbqjoZZo0vZg0jrnbeZoEtiSbkEwaNzEjspk+raucw4DmQTM+E3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1d9EuRn; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1d9EuRn"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-50f890e3df6so1825495137.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755695868; x=1756300668; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qq5XTdHNgOy/CcfRiqc3CBhUwNepAjkEy7V7tjCK2DY=;
        b=F1d9EuRnrHOS0RGvIXZzLRU1HcSbZsAgdRUFoeKrOsjRXc1g8+pBrtrmxAKtZ0RGtO
         GxMKgf32HkgsVZsrWcJart4dnN0G0llTHsFl+nnrg2BNX4NGsEU73ro1hXdkPVLz3GE8
         6kX/52lgs67GiiW+PqfYId3whgFZIxeXx3H8HBzMzECni8YgCLk3ThDQcmbYbaXTq8TF
         +KhBi0qom4dWygcyy2RbpomUusSegiUcIIe8lUcx5shzyRxyzUPTO1je2dhCoSHOWH2f
         v8IW+ZfPhVYoepIrCiwrJYNE58TRfelXPECmsBKjjsI2kCaNn3J3whGWu0j4OXa6fZEq
         5pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695868; x=1756300668;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq5XTdHNgOy/CcfRiqc3CBhUwNepAjkEy7V7tjCK2DY=;
        b=UJjgYVO6kkFndxa+twjEu6WDPKnbw1wGMxcgtt91c6XDgrRjrBtGt4yds91b4nYdBQ
         Y/rh4dZuQKBwfhg6PYZFcCrHhRxhpuW4i5f6NLzilJmL21PPdQZ5JwWNNYT0tObc6D//
         hECEnqMlFAS8g8iFyd2Nw+wCayzMBLy6jTAOwzDNObycad/40qpV0gtu+RakZlSRVG2L
         kxdaWvhJEFvIEGIUa6PHyTI6yy7brlekENvuTA2bFdnO9op1fxQOuXmjHGBdoEJh7OWh
         hrFKfYmG0tWfiTCG1Iy2T5p5xLkstIVHR8StWuqLBQkL5/ZUral91ktd8S6Lw/FV2qr7
         Fa0A==
X-Forwarded-Encrypted: i=1; AJvYcCVEo69LZAxzC/gYYZWr7h9fbkOLzoSfde0FKZXKU7sESBnADhH/9f4nE46v6z7i4jspLTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pqv8ZZJDrKqdjmeL9SlGDOupJYoFGvuW+mgfpiCkMvMrUchG
	dQ3c0Xda3OrJ/1Mzmav/FrsfMY29MdpQAVzHLGCoEbZDMhfHCfPEQvc9UM1dC3j+pu+sI8bDCdt
	ns2uUgS1E67g/QIuMsdH7GVgisvK7BOk=
X-Gm-Gg: ASbGncsa2CFNtpM2+55if8YmK+hNmyUcfQuiRrCqifolZs6w0I2uILvCIvPEVhg1Is1
	KFk8qq5oKH7PuEQlN2UlIKrB+KgD/O0n6kssjuP9FMwxYRKnpLC849V7oveOp52uZPX7y5tDj7O
	Kz6ctiL/dUgy4Gu24e6YfkhTfJiWbPfBJJ9dsnGW94NPbLckgKZABpryvpsgMFfKBbftg6v1hv/
	NwA3lDHsuRWe4gm
X-Google-Smtp-Source: AGHT+IEa1EiZn9w9Q40/OWuICofjD0rCIDpvGf7dyQ3BCoFl+gkI3ir4VVaRtmTGt6oESiVt/xfJtX5YNjRmflqPQAk=
X-Received: by 2002:a05:6102:d8a:b0:4f9:6a91:1339 with SMTP id
 ada2fe7eead31-51a517c4694mr721169137.26.1755695867807; Wed, 20 Aug 2025
 06:17:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:17:47 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:17:47 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-9-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-9-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 06:17:47 -0700
X-Gm-Features: Ac12FXw22Yqe5eMwVz1DMpN1G8fQsA0_UqCqFLTAeWRZoer-IFUDy5PlE9IoS_A
Message-ID: <CAOLa=ZQbeyqdGn1Hj0Utys9UgiUbB4cP4WTsy4fisyZ5czsCcA@mail.gmail.com>
Subject: Re: [PATCH 09/16] packfile: split up responsibilities of `reprepare_packed_git()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000088ea1e063ccbcc55"

--00000000000088ea1e063ccbcc55
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In `reprepare_packed_git()` we perform a couple of operations:
>
>   - We reload alternate object directories.
>
>   - We clear the loose object cache.
>
>   - We reprepare packfiles.
>
> While the logic is hosted in "packfile.c", it clearly reaches into other
> subsystems that aren't related to packfiles.
>
> Split up the responsibility and introduce `odb_reprepare()` which now
> becomes responsible for repreparing the whole object database. The
> existing `reprepare_packed_git()` function is refactored accordingly and
> only cares about reloading the packfile store now.

[snip]

> diff --git a/odb.h b/odb.h
> index f1736b067c..9810ec60a0 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -155,6 +155,12 @@ struct object_database {
>  struct object_database *odb_new(struct repository *repo);
>  void odb_clear(struct object_database *o);
>
> +/*
> + * Clear caches, reload alternates and then reload object sources so that new
> + * objects may become accessible.
> + */
> +void odb_reprepare(struct object_database *o);
>

I was first wondering why you don't go into details like mentioning the
packile cleanup. But since we eventually will move it into its own
object source, this reads better.

--00000000000088ea1e063ccbcc55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1f86f5c40b57bf36_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbHl2Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEJWREFDZ1l4bmxzakEvbUl2dk43NE5zOXQ5aEhSaAo1Rk5NK0lEVHpq
aU1yS3dNamQ4eUlsT1hsQ3dxRVR6cWZ4emFOdEhBNFhOWVdKMkRPRnlMZm9YNVl2MDJrSXpwCjda
bU9KTGFvY29oamtXcko4alp6aUhJaHpZYTVtamFKUldmSlNoYWJtOUZKVjdwbTVlMGVQM1FjOFlx
N2xjc0YKR1RhL0NGTnZJbFlIVWtBWUdNMlhhL0E0K04rckNZWmNQdzg4SDhpNk1Ja0pTNmZIanM1
SldwM2R0aE9FNHBHRQpJMXgzYUNJaVpsRHAwTG52ZWJnemMvNXE3c1l4RjBFRFdaRzlQMUNnZU4z
akY0SnJTSUhTL1FPS0hOZDRHeWw0CnBEbmNVNEdYR1hyazRheCtFa3hpYk0wRGduZVRHYk5pbFR6
eWxoRm1DTHhRU1lrM3VVcG9BUzVPa0QrRm1RTHcKUEhjZVFwbmpmd21BSzh0aHoyUjdybms4RTZM
YU9TeFZOeTNJVm1qMDdlM3hpbHV4VDhPMW5BR280QUVkY0diMwpRMFlGcmFRSVFVS3h5S2ZVdzJr
SHduWE9TNjUrSHBtWUFlL2dsR2dqR1BuV2twUmJaNXZZRit2djNKKzRaTWxWCmJUQitydnN2YU9L
OFljR3pKVkdzUlBFMEE5WnlsVzl6Q1pqL094MD0KPWF6eUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000088ea1e063ccbcc55--
