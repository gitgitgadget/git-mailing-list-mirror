Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB011FA8C6
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907953; cv=none; b=Xbbaev9m87ZjO0XAIPSo6azSI+/AcZjNNYZlSyF60NPa1Gbk0EgQR8WYvXDexk5cXa+b4sIZCRWSdbmEiOIUeaWDU+U76Re8ZYvCR0/vlh27cxnAJYQiBPV9Q4e0Gu4J8Hhbdj5G646BaipflUfml8AwErvN8k2xm/cQ4u1LXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907953; c=relaxed/simple;
	bh=XzPHoBFU+40CTN5+ALTYeU0avqTywVPwCG8IMfXEMho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cw5MlkTRcp1RIqJGbYGKYXmXlHAt8hb3xKtajq6m9Q2ZGRhAhqgOYZw5ANx1/B33rpci24KJ9OnnZ0VSJS5Rg2fO9m3E8/zpusX6foXaUAhIKbDA3vGWmC4uLd4dY7/7R3gC8ahHpUedQjPsZE36pFcZK5v5ZqKGMDLNqKZgLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Clsy68mZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clsy68mZ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so870875a12.1
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733907950; x=1734512750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z94FPhf51Y1P8YiaUg0Nl7eGX2TxLtOLrlLelxb/jo4=;
        b=Clsy68mZ2MDoI/lKJEaggdie9ILmADeJ2nl0yjWBVh7xj6XmuWeeCKjcOOuId1TI4S
         NqAM4SbVwKuAkUsnPFROwptdMVEfWjVEccDAGS5au2N8UX5N0Tqw7nlwwF87LQVtQhsl
         I2bfwRlEp1HczFn1x3We9hSz+bCQ49qWN4nOjxiIkmY5jo2rX5PEHyqnFFIIt/mz+fLk
         fJoqN4LghUcuv6JjEN74+zuBEEBxeXJnR/R4xKQkVtKyIN375hxi+EVpjUXkCeIGWCSb
         bnFAap/aBDj7vgTM0+21+4Cv3Or/XjYppJ77oDJzhN9h4pHnHeeA/yRIifnKaPxHu5jm
         InMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907950; x=1734512750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z94FPhf51Y1P8YiaUg0Nl7eGX2TxLtOLrlLelxb/jo4=;
        b=ibdZb03CGM4OxSZFnRjwT6Aan5617vHumHpuupaTHgayZjYULENmrBNJgWQmY2Tzww
         AN5UlGAKDIYu94bpt0AhtkUu0ghinuGyuEDv09yzFawyeUei/TnK9iv+zmgSmslh0zQ1
         b67zwiJ+l3q+JH7iarhNGX/6Nm9XXBgYZiZ4OgW0Q247kLtPWmtEi5Tqeoj32A7YL2La
         1yRgRxFcUzIQf05hqCReXpE059iIqZKt3dvzHfxl+E1P9oKZ/WC0i9x7PHiLh+jmSrra
         la9DTrbXzmOe++apEJQOxZgCM/TtJRjb/GsOnU4eFJAJcKuTLvy2iObbn1SjwkjEEGER
         BicQ==
X-Gm-Message-State: AOJu0Ywf3ezkrGQh++tsmA7yWjTrJRrgu1a7VsHE8nTAPXxxWSmdRIUD
	FMVZFxpvJ2MAt/+VD71xIdQN00u3fN/nJLjWhqNEFjK58Lp29MfkGNliRQI25QVWqeXzbj1BF7K
	zT6IBye1vMXLYk962HFmcVESp4o49cogj
X-Gm-Gg: ASbGncus1DKdyNYfWcTCiRgaCMgk/0Q9Lfylfdg26IoJC7z0FUEe1DOm/WhQW+d2TGo
	fU55ce4TRjBfgJ4ZPpEtfgb6J/4Yc7h1c/bA5fA==
X-Google-Smtp-Source: AGHT+IHMI28DM+tCB2kdIjWKcsoKMGLp1j66Hl+fV46EoZ0VwJXw9QlOmSARbXSrjWySRgWaOy77p6fj1NSWOKHSrSU=
X-Received: by 2002:a05:6402:4408:b0:5d0:d328:3a43 with SMTP id
 4fb4d7f45d1cf-5d4331b18damr1757295a12.6.1733907949457; Wed, 11 Dec 2024
 01:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-3-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-3-d4bc37ee860f@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Dec 2024 10:05:37 +0100
Message-ID: <CAP8UFD3StHePPGe+44c83qBYoZLZme+Gw-cP7Weg-neyJg8DOw@mail.gmail.com>
Subject: Re: [PATCH 3/7] refs/files: add count field to ref_lock
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> When refs are updated in the files-backend, a lock is obtained for the
> corresponding file path. This is the case even for reflogs, i.e. a lock
> is obtained on the reference path instead of the reflog path. This
> works, since generally, reflogs are updated alongside the ref.
>
> The upcoming patches will add support for reflog updates in ref
> transaction. This means, in a particular transaction we want to have ref
> updates and reflog updates. For refs, in a given transaction there can
> only be one update.

Maybe something like: "For a given ref in a given transaction there
can be at most one update."

> But, we can theoretically have multiple reflog
> updates in a given transaction.

And: "But we can theoretically have multiple reflog updates for a
given ref in a given transaction."

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 13f8539e6caa923cd4834775fcb0cd7f90d82014..9c929c1ac33bc62a75620e684=
a809d46b574f1c6 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -71,6 +71,8 @@ struct ref_lock {
>         char *ref_name;
>         struct lock_file lk;
>         struct object_id old_oid;
> +       /* count keeps track of users of the lock */
> +       unsigned int count;

Nit: maybe the following is a bit better:

      unsigned int count; /* track users of the lock (ref update +
reflog updates) */

>  };
