Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772C245031
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632347; cv=none; b=usbmPAK/UV1Yub9Grc+JQSZgia50hTvFAG7HtGix54IvCWlr4aplztTiz2BP6eqLiHK9EsA4GpnLvqvQZy16zRXzHyi8UP9wyTBEdj4zpRPmZaZSqHo9Ap0EceYh8XuIBQvudb+ZsKffCgOq07cZfzXM7DZ+rCLdzsl8x0a0wtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632347; c=relaxed/simple;
	bh=bXJ+z36yem1wJ3jTXv6Xz3mcobXqFEKQG12QorzCfdk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXpIKmaJ9dy0c7YqUKjdPZLzwR7EKbZ4fjwY7LfnGT8gTZZ2y85EHBOug2BAraWFIXDZbb3ZM1zwcugeB+G51kWK7Du8plSir1j90nu2A+PD6ccUWCI7b0U+W+f1tNRigPZzxFO5CLW+t1LAo1zY0XEeFjwOWSly18xNOMVciQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDEFq2Lf; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDEFq2Lf"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-53090b347dfso2106136e0c.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749632344; x=1750237144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXJ+z36yem1wJ3jTXv6Xz3mcobXqFEKQG12QorzCfdk=;
        b=JDEFq2LfY7EQLczlL94W+y7bSigB19kHOgXN0WH+D3/uSNuepp5ylZrriXhz10otop
         g5HdshP2O5jFKKnrW3XLPowKxQGWnJrwB6Q+LyX1l2WdpXqZh/tR7sv/BWZ/TB3iddro
         B6Vo+DsM2VizmTaGgRO9qm6kra60KF7t+Uf2e5FSHNbWmFDjtW3e7kiLLu+fH1HUi1gi
         U0ALc2PotndsQj7iyvTMoOm+YUhUL5HZFk7cU9E+nji2tWUbZDIAe0HJIjgGAvSqYlLc
         +M/6GBdKxyqlYrw3tBYthaMnzSHsm2c6WdITJlrC+Auufn5M/JvfbQTblMLkXzvkEbaJ
         +hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749632344; x=1750237144;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXJ+z36yem1wJ3jTXv6Xz3mcobXqFEKQG12QorzCfdk=;
        b=qPZ4ZOnOVgxJ1U2Ytw2BeY0GEmYuq+lYQMG9wDlv8NHjVYs+lNeDosQHZY4Fhhq2ER
         9p5AXVZ9U8XzVCUmnHVRCi8qX4U9NY23I0Oy4YAvJ2xxcwVq9Ba+iEGZfO4oIfgcf2pJ
         FsR1GVeyVHzABfzDMfu7caTNxMMM8LfFQkrQvbWmB09JT0faAzJVjb1rJcQ+N9tmHSu6
         zPsNuqvp7Byl9Oi36sTNeDhmpjh5mX+Z9mRWsxBWKiTInXg+5odthDUsgRRU6qkcVXWU
         9S3380l6neJjDfq7m47cSU3d/1pduZoj6Sg1AAQso1L701UBsOOjpQnXkqeaePPZy3ps
         Lpbw==
X-Forwarded-Encrypted: i=1; AJvYcCW5v4Wr3WfBU3ZnePpAJJrAIDKFJ3cO9Dh9X9AlID0jzc1lv/vhq4PRbEVxtFghnPQo/OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapcocSSI2bNpY+IfK34XTNcutlzb7PZfNHo+EhXKFjLnVsrw1
	YjESl9H5ykVUjXKNrWlTW0c/i+O2Xl32R2XFtdxpr0oGkHyEUeJdmQYfqHZkvxE07FZ62H3Ls4I
	vcPj5oHO+nV42+Tn8QIXImoIdBrBcHFBSBTB+4CA=
X-Gm-Gg: ASbGnctJx1ewcsXNn0olqQsu6mkMihGFaVubi52XpwGopyVLewUh02z3MBXG3MHtxdn
	Yju5dwcU251dFYga8mkFrEWgA2GkcDD/ZDGa7QipAt8PP6K4UxJLrbFIp76WOP2Ph2nkUCJfzyE
	VOSn6oi16mKO6hA6YY+pJ0FJePBYVJmvZ8c4Zsu/meCQ==
X-Google-Smtp-Source: AGHT+IGWIN7Ao0FZxtBVKC74YnIKR7Zwijo386LrqX9ob0WZu8t4jkL6Yi0H2r8RC9K1f5vXatcOc2qBRt/11WMicSg=
X-Received: by 2002:a05:6122:178d:b0:52d:bbab:2055 with SMTP id
 71dfb90a1353d-531222a67a9mr2041895e0c.10.1749632343745; Wed, 11 Jun 2025
 01:59:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jun 2025 04:59:02 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250610152117.14826-2-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com> <20250610152117.14826-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Jun 2025 04:59:02 -0400
X-Gm-Features: AX0GCFs5THibNAK_M8fq0eQjYAEPD97HeN5LQ_4v_qAyqxL3bj6PKVLthiXiLpk
Message-ID: <CAOLa=ZS_JC_3DYUmYu65V7J__yr6Wv=j0Om6JJ47HxMkZSSyJA@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 1/5] repo-info: declare the repo-info command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000564b270637480600"

--000000000000564b270637480600
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Create a new Git subcommand called repo-info. `git repo-info` will query
> metadata from the current repository and outputs it as JSON or plaintext.
>
> Also add entries for this new command in:
>
> - the build files (Makefile and meson.build)
> - builtin.h
> - git.c
> - .gitignore
>

We should also add documentation for this new command in
'Documentation/git-repo-info.adoc'.

[snip]

--000000000000564b270637480600
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5d182cc40f01721_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oSlJWSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2ZGQy85T0lpMngxTnNzOWpsTGdhWGRaSlNld0hLSwpWbE5JeGkzL3hC
YjdYeTRMaHdsdmFuRzQ4ckU2UkFZU3ZOWDd5TkVXa0FJdUdsSHpJN1hLUDFyT1k0c2JZVVFqCkY1
L3l2d2lJaEFKZXhINzRteURkSFEvSXRnY1E0NTdpQnRRUUVDREJ4RWo1LzJQV04xdUU4VWp4Wm5M
dFZ4SjAKRG4ycURXVzUwT2s3Rm1qVlM0YjJpWjc4Wkw0WVdTaVM0UHVWRTFrNWt2dE5BbmpwY3Vw
bm9nZXVlQy9FZGVIWQp0RDBqRjVVRTZpU3VYMlBBSXg2TGV5WnlhSnhJUXo4aFZJTTdPKzk5Tm1Z
QytHUDY5Q2RERmF6aVQ0MlhCY0ZGClhQc0ZTTy9lOFFkdk1XZDgyRTBCRzdxdm9XWVR0cVd4NFBh
OXE3ZFRJNWRmR1R2L2c1d0VhWEludUcvdlJrWHUKZkdHVlN0SUdhaUh1clVOdno0dkM0dkV4SURs
a1dEb0FxV29mcVVOcjRGUjZYc1lPcG8wN1l3RjMwZkUzY1FsSApQbEpwZUNMYkRzQ2UvbUhKaFpF
OTJMYkpOK1lvVlBQVERTVFVuWHh0WjIyd2pXWEtER3hFTncySTdxQWdRTXYwCm5zLyt6UnVlUi8r
YUs2UDVYb1BDYWlwZFU3cU9aUEhtM0VtYlBFVT0KPUE0T3gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000564b270637480600--
