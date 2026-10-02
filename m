Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FEF2EA480
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963352; cv=none; b=h4DXZzVDJxuf0moVUQLgIpWnSD6MP6hx/h7ot23Qe8pAnol1y7Mgj+IzyyCRNePsveQjY67mDHGqrdvxm7+hgPGVHvpIAfFtk41Is5h1rIzv5bOUbDDAQMu/7gNXVqgcs0d12OVT1+LQRJiPjCA3gOA1Uk6WUkxpNGKYANESP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963352; c=relaxed/simple;
	bh=i6tI9MA+LsNyUGajDhh2He7bTkeQ/HewARi1Xnu6UOY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=pHh5M6Xm3NaXi5FVhb+qlxw7/XiKwseM97f/Ga+HqU2WSzEjbYJVw67VEiDqQkvFTjjcGJerHHQ7aK1Vx2FBJnkvSjAFEJv13GXjhIQnsg+4YhHt213yHfyMM2egzn/V3OkDMDXIMq8aQdglG3ETa+GrFLyoGqDfgiGZePgTE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxpOWPhq; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxpOWPhq"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso230277a12.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790963340; x=1791568140; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JkMH/PJLOE+bb1eMj1mchFfdI+imTPeZpIwf1Mwek8w=;
        b=LxpOWPhqzUtdYfSzt6aJ00GVzx0hlCBqqd/32xZKsjqWkV13D+6ntWtLpXPqGRn1WK
         k5xHsJ+/qwodAUeuTo5+7zs8H0Oysz3mr3PfYCjc2l+F4+25QpYTwgFKWb/dhvxOl09y
         oUAFAXBX7uTSm4Nt+Op/WzroAN7HTNx7i7pQBCpWq6Kz6XjMICoMFkFRLahxARY1gJAx
         ZHTVrXvnET0UYB5hxrji+uOKKSnO3a9n6nhubq5DGb4TU1kGK9LwxijbUzJlX35lVFCY
         uVplNWkSvwILnkMyLsFHnYk2h01oIxWSJ/9novkA8cFy39JD5i5wDeBAanwD/Et7a26q
         zFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790963340; x=1791568140;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JkMH/PJLOE+bb1eMj1mchFfdI+imTPeZpIwf1Mwek8w=;
        b=cHMD6DCHpGGWzGujWXD4K8d4NJ4ZTX+8/Ofx2QwJgv19ZPV95GpPn/LuTkH33MK2F5
         F6q7OBnBJ/74SrFMKPToRfm3Qqy7nTTajZnCsqQKOA2ZeC1OQM3BXrxB6nHYY1VSz0D9
         In0I0fNuN5XauaC/bsEJ3ajcxJLiOLV5nEq+QPWxsGIMA1dJ/fWObWN61+Va30T4v5Ni
         n9W9HONIugT5uo5hiiZoZNa2jCRCMG1s6FhrobdGtt5UHq7usp2CkBpMM7/V4nEEmaSA
         AeEMlNOiVCM2UZjkv9DgzupINMN1U+Bqpm6A+f5WVJLo7oAd0ZqeIM639buzhXLu0+66
         s3sQ==
X-Gm-Message-State: AFq9FYKNA22lhzZVsZAjTOs91DhOI/xhLlhch10BOxop8MqRpSC8iosz
	MDvd3F2k2KFK7f9ie0NBRjvyLHFSwYGb4l96MBaLxw+WGZsBKZUM+BW5
X-Gm-Gg: AYBFou13Yt8KEaRc9rh7/km8gflOsguhIwq7gC74xJix/agFpJ8bIT8OMjgwTNE4UN9
	MVUYevh3avBKmIs9aTbp9u2kGn1cr++o2yXpxAwLpWKulgoeTzSxwco+MILuq+VYX40iZdTod+s
	GtZ1yg2xvqeZ51TlfMVv42l7gBgvwpMWGAdsMfyAlxD2Ec17nAmenR/d1EnjI7QUzuu41xOVmpz
	d2+UqQa0rFGSdt8PiTiBI3t9lcU8kxd0lQ3LT8B3Prz1ARBTtrEXQ3SXoWF9jhnjRZQ+mch5c5j
	kSLfIGCr5XBMcN/kSRWN1smr2noOomqawiJELfvXzHInJ6SQxDPkfDstcKIpPTUoLzcF02PZwcc
	yFxZtyjnevKGkmZD1tc2yGhGPDiK1aSUDGKlDcytxnS65xjdiJdX/XAlQ+W6wT+uE7Eo9t+eYTw
	xWdWLvmwr0iE1e9kaQeO35DJ6Sok3c4Q+Q2irt7EoTUlJ1Z6VlUNT02nCU0qsFjE8h8Qdiejgtd
	mtemS/BPI4lk+bbHVznPDlCdVKjwUzMTJM=
X-Received: by 2002:a05:6402:44c3:b0:6a5:f4cd:ae39 with SMTP id 4fb4d7f45d1cf-6af9e2d4a79mr1737980a12.9.1790963339954;
        Fri, 02 Oct 2026 10:48:59 -0700 (PDT)
Received: from smtpclient.apple ([2606:6d00:11:296d:357e:8622:1521:1c5f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d8739acsm1170013a12.6.2026.10.02.10.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 10:48:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] packfile: fix corruption due to stale delta base cache entries
Date: Fri, 2 Oct 2026 13:48:46 -0400
Message-Id: <046C5954-DB91-4B7B-A89C-70B418CFDFB7@gmail.com>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
Cc: git@vger.kernel.org, Guillaume Chauvel <guillaume.chauvel@gmail.com>
In-Reply-To: <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (22C152)

Hi Patrick,=20

> Le 2 oct. 2026 =C3=A0 03:34, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFThe delta base cache is a process-global hashmap that is keyed by=
 the
> address of the `struct packed_git` plus the offset of the base object
> within that pack. Entries part of the cache are never removed when a
> pack is closed, and neither when the pack is subsequently freed. As a
> consequence, the cache may contain stale entries.
>=20
> For a long time, the worst consequence of this leaking cache was that we
> held on to memory that we could've released. But the reason for this was
> that we didn't even free the packfiles, either. That has changed in
> 6f1e9394e2 (object: fix leaking packfiles when closing object store,
> 2024-08-08), where we plugged that leak.
>=20
> Now that we free them, a new packfile may be allocated using the exact
> same address as a previously allocated one. And if the new packfile has
> both the same address and a similar layout, it may happen that a
> preexisting entry from a previously-allocated in the delta base cache
> would have the exact same key.
>=20
> All of this sounds very theoretical, but we can actually trigger this
> bug somewhat reliably! When doing a merge with "--recurse-submodules" in
> a repository with lots of submodules that have similar-looking packfiles

merge does not have a --recurse-submodules flag, submodules are merged by de=
fault (but not updated after the merge, which would be what the flag would d=
o if it existed :))

> we end up opening and then closing the object databases of each of the
> submodules in sequence. Because of the above mentioned commit we would
> close and free each of the packfiles part of the respective databases,
> but we wouldn't evict thire delta base entries from the cache.

s/thire/their

>=20
> When using glibc, one of the packfiles will eventually get the exact
> same address, and that will then cause Git to read the wrong entry from
> the cache. Git detects this and aborts with an error:
>=20
>    $ git merge branch-b
>    error: Could not read 584ef938be4a749bfa13f68d5ac5545bc029e529
>    error: could not parse commit 584ef938be4a749bfa13f68d5ac5545bc029e529
>    error: failed to merge submodule G (repository corrupt)
>=20
> Now in this case we're lucky that Git detects this error because we try
> to read a commit from a different submodule via an object database that
> doesn't have it. But potentially, in an even more contrived scenario, we
> might even silently yield wrong data from the cache.
>=20
> Fix this bug by evicting cache entries that belong to a specific pack
> when closing it.
>=20
> Note that the added test reliably reproduces the above bug on my machine
> that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
> dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
> specific allocation behaviour of glibc it is very likely that the test
> will not work on other platforms.
>=20
> Reported-by: Guillaume Chauvel <guillaume.chauvel@gmail.com>
> Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Thanks for the trailer and the quick fix !!
I=E2=80=99m still puzzled why it worked correctly on 2.56.0-rc1 on my WSL in=
stance. =46rom your commit message, I guess for some reason I get different a=
dresses and so the bug does not trigger.=20

I see you the test you add merges more than two submodules, in contrast to G=
uillaume=E2=80=99s reproducer. Is that necessary for the bug to trigger for y=
ou?

Cheers,=20

Philippe.=20=
