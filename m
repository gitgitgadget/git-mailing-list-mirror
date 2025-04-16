Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DF207DF7
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785708; cv=none; b=PKfQdp908qT3T1B33nJB8Mk1efAtGMfLlxvt5KpfEmS1QudDsn5XoOpKrQTrVUvvZGJj5UhC20u02RJRU5DJ31KEOrJtbUTbh37yk7yzwROiNOkyKxHBY9MxB3eFt0PxHF0+IC3ohbUarUIXZJ7FOpUnwbaVpRQkMUlxF9qqKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785708; c=relaxed/simple;
	bh=EuQ0jLOK3kSLa7snV1tGXkPjwVEPXdgTuCn/MfU13So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpahzgewzWu1ylxtQyVQVmPHpM3XidLrOuUxrTo7cgI0Id9jkZ99N8klIfYNL6EJUiPPJbYDMB+YrBSxEZv28Yt/e2Hh4e5Ynr7z1elmXC09xVTkVyIyUbH31SLpJCs8dIQP/ZXZ3TLVLeUDuyiXOK0GqsepzUqQI3BWgvUIWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXTb3Yec; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXTb3Yec"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85da5a3667bso172802139f.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744785705; x=1745390505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkFbh6xolqbVS1izBiyJz3lVn2HpAOYBz7juT8jtnjk=;
        b=hXTb3Yec1iNWwVOKr/smEp+B0azO/NQaT2HdvlCfdfYO3uXjrIaReGrG05hosD6Jst
         4Qj0lnJdSHfW+zFinfrz00NIqzcNc2XoFdo1I4CTg2G6WOgqH8I3DO2WTQm9TJTIhde5
         xFTgcJWTYKrckOUdW7wRZ2NZ3bM+UKaQHtMbH47fWX/2sDF18OWe1kv9cqO1oyq11ja1
         ZVYy8uhjCw3VOP82pNw9PFP88Yrlvl8JdKTTS8nseHsDt+KlBP+Pz0/DAAtlAKjvGB8O
         ZqY4UdHHFsCt6OjW+xQp0NkLV7Mztvi2LlK7pocVuON8rP21qs22Q6vxPQdwPLGF/mLm
         VRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785705; x=1745390505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkFbh6xolqbVS1izBiyJz3lVn2HpAOYBz7juT8jtnjk=;
        b=dKUC3SPemGUloIoVaY0l7Gd/PrhIeHz9zEg2HBbA/iQCcXm377jMMKadHOTSB/xsnt
         5wWjDtJab6/5DJvN8672+/ejt3PAbSLbnMw630Ai+AIvEOMqDEDJdwM9ART5cVvCcO1i
         CFNRxSW12aCcVf/pee2QuwL5VGTEUlpIRdUtc364ThYVAT6hs08RWoaplobMhwl8ECQD
         Lu72314bUiCNvfwIJTy40rSe/WXH/2ph4L/4uxPJ0kXmt6ci3l2R/lmKk6h88W9IsDt5
         O6FejHxcXh+E/nizADd555OVIqrD4q5OgQSoVd4lgk/fzhPSq336UZDU0ZiisKVnDU1e
         xRIg==
X-Gm-Message-State: AOJu0YwSsYy/9r6hTWlkucbBs4FiJEXEAXRVZ+coLKTL8qf49DFfHSJC
	yLSQKNoJGc07NDIU8GMDjZgmDZ51C753isBhSXMyOwzXPYKPVcm/aO5GiYNA7vOs6Fe3K7bq9F2
	/TsQEiQt4hoDZLvo/eayNDIsZX68=
X-Gm-Gg: ASbGncsBS69dTNuKQnfW5H8rzbUvlWVzFX9YKrXWY0rODKU0M1oJkSC7PxPjKbgNuDL
	pd2mebw1vJMSi38g04ezmiDeCPOe57EqEIxwzNRFWvZgyys/QnODKp/gMkAA+7r2qB++3vdYCSE
	ke1I2UWzMPDorYWDYr4B4qMF+w7o7Bk2NrhfzHKLY/i5UrT46+4N7I/b8=
X-Google-Smtp-Source: AGHT+IH6x9LCsqB0F1uJdP2tlWcUK/e/NHIwYhlBhxZU0d8bVB9zYHn7gZ4NR7Dc1YvMSs4zex1jgYOQebp4hvRCwWQ=
X-Received: by 2002:a05:6e02:1562:b0:3d3:dece:3dab with SMTP id
 e9e14a558f8ab-3d815af7e72mr6068985ab.1.1744785705640; Tue, 15 Apr 2025
 23:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im> <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Apr 2025 23:41:34 -0700
X-Gm-Features: ATxdqUEUEXEJVFGA8PN-1PfZDJnJ3jNxQsjd9slXd_QPh2Qdklmngdh4ToW_Qv4
Message-ID: <CABPp-BFGeJ6eANb_5m4KSWRY_r9KCWarzya_qMkQNchKD5Q=xg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Split up "object-file.c"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 2:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> "object-file.c" is quite a grab-bag of all kinds of different functions.
> Many of these functions aren't really a good fit though and should be
> owned by a different subsystem. This patch series tries to split up
> concerns a bit better by splitting out this functionality into other
> files:
>
>   - `safe_create_leading_directories()` is moved into "dir.c".
>   - `xmmap()` is moved into "wrapper.c".
>   - `git_open_cloexec()` is moved into "compat/open.c".
>   - Several functions attached to `struct index_state` are moved into
>     "read-cache.c".
>   - Several functions related to `struct object_store` are moved into a
>     new file "object-store.c".
>
> "object-file.c" now mostly contains logic to read and write loose object
> files, whereas "object-store.c" contains the higher-level logic to
> manage different object directories for a repository. Eventually, these
> will become the loose object backend as well as the `struct ref_store`
> equivalent for objects, respectively.
>
> The series is built on top of 9d22ac51228 (The third batch, 2025-04-07)
> with ps/object-wo-the-repository at 9442b1c919a (Merge remote-tracking
> branch 'junio/ps/object-wo-the-repository' into HEAD, 2025-04-08) merged
> into it.
>
> Changes in v2:
>   - Fix a grammar issue in one of the commit messages.
>   - Link to v1: https://lore.kernel.org/r/20250408-pks-split-object-file-=
v1-0-f1fd50191143@pks.im
>
> Changes in v3:
>   - Rename `mkdir_in_gitdir()` to `safe_create_dir_in_gitdir()` to match
>     naming of similar functions.
>   - Move `safe_create_leading_directories()` et al into "path.c" instead
>     of into "dir.c". This also requires us to start injecting a repo via
>     parameters as "path.c" doesn't have `the_repository` available
>     anymore.
>   - Drop the commit that moves `index_blob_stream()` and related
>     functions.
>   - Expand the reasoning why we want to have cached objects per object
>     store instead of globally.
>   - Drop `index_blob_stream()`, which is a trivial wrapper around
>     `index_blob_bulk_checkin()`.
>   - Link to v2: https://lore.kernel.org/r/20250411-pks-split-object-file-=
v2-0-2bea0c9033ae@pks.im

v3 also addressed my feedback on v1 & v2.

[...]
> Range-diff versus v2:

I read over the range-diff and the three new patches (1, 2, & 7); this
round looks good to me.  I particularly like the extended rationale in
the commit message for what is now patch 9.
