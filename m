Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F554738
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525794; cv=none; b=YZU/T5xasmxhk1BmvWw3keWwIm62EI7HwrETHq64YyaPcDm0xj2xXl5kVhrQyze1PrK/JFMDBP05YAykGTTGLwIB/24p3hWbEUQzZEJek69q62Cz9fCvW9p3cWzgQgdb/k1zv9KPwyVXIE7RRF36PVKg81i8CLd8Ry66jKbMHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525794; c=relaxed/simple;
	bh=Y4+TZs22WOuXuyjfnmhjtTu0GdGsJ3N6mLHNFxukk2k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvA5Ve3R99N/3wu9h1UtAl6y5SPqCxBGLEhRsKjc2HFT1peFgnWzsf9lEFYQ/Ly2DcXhmmwDSQkWZmRkNLU1o5joTI32KLHwtGUiaIO1B5/8+dfUdVr6RWPQv5JwrLOJY40I6axNthrujAedc6aoF2wtl2lEYKa+9Bh23YDXczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5PP0Ez3; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5PP0Ez3"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afdf096fc5so1527994137.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 22:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737525792; x=1738130592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ck8C8iEhgcTJo1sgL76rT6R5b1iV1U8AePNLuMBx8=;
        b=T5PP0Ez3t4bC8biOUCQAVcdUP5rUc+w2slLuxpE2OETpMMw16o4TzWsmVa4lAYB9bY
         jzi0tP9hYts20IOcC2PWjx8u4dYu+D82xZ/EuEup7jP0lmEpHZU9rjAY4rTbAMVdJRwr
         YWHSdFQfiUOFSWNopb0vZm/NW8wRA5GoIH/hZJ40udnRMf962dcVEXekhdh7qItSmvEn
         1yZNIT2P8VyA2pYrf1Yfq7JGIIixpGCCPxeYGFJvtUbZjRBgsgXyyxghsAG+pnjGuyQQ
         wxMrW8uhyxe9COCqbIKy72WEjYvSw7xL2FC/zlkR6PvSCu/ruvuiz58K/i4Ik95qM4Uj
         bSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737525792; x=1738130592;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ck8C8iEhgcTJo1sgL76rT6R5b1iV1U8AePNLuMBx8=;
        b=WgYyvybXHTL3THRTczU5FJFx00bCK9Vbm9NDoXLFHCeR1v30SaZ+Xwou7kN15F+8U9
         BKMKtVVkjKJtrw36c62wudjWBaH9irhyly4wlVX+Citvs9ec+lMDMQp8SygUqtkyC9Fj
         PUC+zzImM+CtNbe8whXzh7Rs3Wf0W8CU0mE/ZZ4IIr9gzNlFNQpxV20nvVdLfoFiDfRk
         zV6TP3uW3WBLop/zho0tqFDP1wYpmtRevxG8H+Wk8PZiRm6OhTWEwK+jeygzQiPMMkro
         Huzmqfuc8LzxTwAY/sm1Qqwow+8BrHpvNXAZsCKY+KVLYUzXXDGuB7u6olixwkg+gCt9
         goUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8SBERc+WVP/cSiC4Ws5aYoUEipP2CpKTfRhN1/3gXcLVjD5w+u8mX3EEkWjPd6MKK7wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOWjmMuLSQARvnZ4M09aVJqbLetyEijG+MMhGpCIQvcx9fVEM
	9Ekf9539jFNPx9p6FWPU7eg81lvkNXxMuBzVsnmSGPxGvr6EfzF3H4TzI94L9wK7Awq/UPPyTUr
	SPbiivz720YoUN7mf3vMVYmTLkIfO6EPC
X-Gm-Gg: ASbGncvqUeJHN2D7iwSd5G7zzR6SELK4FgEJn/OmpPIqVSXdfMbH0UTqfgRjEvy2zU6
	woJVBMbtQ2gZZKvWa9MF6JQXNgq/CHPnLs9PJJ+7OAQekWj8EcPs0
X-Google-Smtp-Source: AGHT+IEqrQ4lT/Ww0o6qZBrvhZgkN2wjJziu/zEtdI06C/hQ31ODu3QwgymGdA39Vosx8BjSNr7BltX7e8RaAxRWTMI=
X-Received: by 2002:a05:6102:3fa3:b0:4af:e643:e1e5 with SMTP id
 ada2fe7eead31-4b690bb1b2emr16982896137.2.1737525792152; Tue, 21 Jan 2025
 22:03:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jan 2025 22:03:11 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z5BTQRlsOj1sygun@tapette.crustytoothpaste.net>
References: <Z5BTQRlsOj1sygun@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jan 2025 22:03:11 -0800
X-Gm-Features: AbW1kvbzkHC9LsJAP3kngoGnw0zb_sHQmBrsBlLdKpQZzQvuHk6AtjoGVEbOVFc
Message-ID: <CAOLa=ZQmPRXSNtZfm7noMoUgBYp4+BcOgikkCY+JyAc6n1OuUQ@mail.gmail.com>
Subject: Re: git refs migrate does not migrate stash entries
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000a13c63062c453f4d"

--000000000000a13c63062c453f4d
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> After the recent fix for reflog migrations posted to the list, I
> converted two work repositories. Unfortunately, it doesn't appear as
> though the reflog for `refs/stash` was converted, so I think I may have
> lost my stashes.  While I would have liked to retain them, fortunately
> they were not essential in these repos and I can live without them, but
> we probably do want to fix this issue since users in general will want
> to maintain them.
>
> Here's a shell script that reproduces the problem on the latest `next`:
> ----
> #!/bin/sh -e
>
> rm -fr test-repo
> git version
> git init -b dev test-repo
> cd test-repo
> touch abc.txt
> git add abc.txt
> git commit -m +
> echo abc >abc.txt
> git stash
> git show stash@{0}
> git stash list -p
>
> echo "Converting..."
> git refs migrate --ref-format=reftable
>
> echo "Now using reftable."
>
> git stash show
> git show stash@{0}
> git stash list -p
> ----
>

Confirming that I can also reproduce the issue.

> My expectation is that the script exits 0 and prints the stashes a
> second time, but it exits early and unsuccessfully and the stashes don't
> appear to be preserved.  It does appear to work correctly if you comment
> out the `git refs migrate` command.
>
> I would have liked to have done more investigation, but I'm dealing with
> some administrivia in my personal life that has taken up more of my
> evenings than I would have liked, so I have not done so.
>

I didn't investigate it yet, over the top, it seems like the reflog is
migrated, however the detection and display doesn't work for some reason:

  $ git for-each-ref --include-root-refs
  0652ae7d444e73ed8bee7ca7a0b66e4413386297 commit	HEAD
  0652ae7d444e73ed8bee7ca7a0b66e4413386297 commit	ORIG_HEAD
  0652ae7d444e73ed8bee7ca7a0b66e4413386297 commit	refs/heads/dev
  2652bce3ffc3769feb7eca552d3dbe27ff901aaf commit	refs/stash

I will spend time on this week.

> I also apologize for sending a constant barrage of bug reports that
> might make it seem like I'm dissatisfied with the work on reftable, when
> in fact that's not the case and I do very much appreciate the work being
> done.  I did promise Patrick that I'd try it out and be the guinea pig,
> and so I'm doing so.  I'm excited to see it end up in its final state.
> --

If anything, this is really useful and I really appreciate you putting
efforts to report these bugs. This helps us improve the bridge and also
helps the community overall.

Thanks for your work!

> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

--000000000000a13c63062c453f4d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8e13672c0ba09c07_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lUWloMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXJHQy93TU5zaGRsZlVmMGJxbWZJOUxnSTg5WFk3Kwoyd0U1bXY0Y0hj
K1RHZVpxVmdXeUFIOW9TOXpaM0c4eHJMTitER1B2R0xabFA0YU5aMXVmN2duVHp3ait4STZyCjNi
YnNNSE1TejBwSTRWMEdUT29xNWx5ckc2YWM2Nk5VSVpqVVBwN0l6eEFKUzd3eWY3TkZsNklrOWdm
WEw5SEkKbUFOUzhHZ1VtWEliMWVIajQ4UitNcjBjd0VZZlNoTlVXTGtLMFJkYTI4VHVURWJGY1FR
Nlh6QjYzRTZhYXdKTQpSdEFrWjFscjh4Wi9LanllTzFZbU5TNkx2bmR5ODYrS2xJa2VCQkZWaXNJ
RWE1ZDhoYmhIeTEwS0tsaVVaQS9tClBXbkF0WExkcGJOSjdOS2ZJM01qUWQySzM4U2VpNzFxbjNw
aVpSMU8xdGdWSVZVT3E4M1J1VGVYT0daREovRlgKOHhVcXhiNGhXbFQvQWs1OUJhSVZ4K1VldGFP
YTlPem5SbEUwbW9UQVNWVlFtMnJINUM5ZlFIandjNHNtK3FqUgpYcTdveXZMZWZuMU9mdSs1a0Ex
Y3czK3BZdEYrNEFuY2NnRXBrYjdUUWdKM2JUQnoyanN4OXB2eDhKekcweE1TCnlVTmVGSXhtc1ZE
TjQyUTRGWDJrMU9WdHkxWTJFdEFxeG9VbHN5UT0KPXVhVisKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a13c63062c453f4d--
