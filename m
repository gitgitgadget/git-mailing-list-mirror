Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BFF156C5F
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663235; cv=none; b=E0ZXWia/SvaIBnX85I60SYnT4oeMXcLh56AZlDgKT09cy3gHDYCUkRpBsYQaJzJXV/HnGY4BSyJN/Q2jRFa8U90yUCIWm13wfPQjSMc3dH30e/El/uqHvS+lOXJC2qCLInjD7Y4sUXgVc/wQXlXt0cY6Hqd3Kn5v61SrLgkZyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663235; c=relaxed/simple;
	bh=77JWeIFHJVjdBvvUvG106O+v7HajwWgx17+WPSoAIqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK+wr2MjmGksJDKThiQOsxhYfFwGtiRfYCozH4n4liWUH07+4PChnGVKpNGSdDGxu5ArEQcolw9upJoAIZAa99U/DcMDF2l6BNZPuqcek8GI2SNNq8/BcmxGAEMygqm6os0/D8PikFVpVC11BhNISXfqsoiJqSk5FnqwaseggPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1137b0a594so423490276.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725663232; x=1726268032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV3am8fHIfH8aY/etl9aleEVVUZUP8qkl13Y793H3HI=;
        b=m/Y0qhfqWZpZH0KU1l7jB0m8eK6CKiij8hjEsLzK3jqDyUdg7pSrKFEijbjHtr9rKr
         45qOo8kC8tD0ufce8cLmvHOj1FlzCTo2dixJVnl/XE3w40DLg7sXo/Zjpt/FOG00Huor
         Y8nQ6c+MlXUCxuUHYZ9uHwYoaEhGR293Kq9xDSXzezLYFLp6iFxwes2DTa4EBwaVCQgS
         FHe1SXWoJj9F0gh+S3lwmhrzH3vWGZQe7GR4JJz63TayZNhb0cwYm7AZphF/xA5Frhj7
         QyEyfVWRLT3JPpV8Qn79KtEkNNCgNs1hk3i3Da1WdP01py0V9y+4fiUyz9RhCD7TOuy4
         +hxw==
X-Gm-Message-State: AOJu0YzEaBI/HXp8DhK8Vo5GCFRkJ3EJg6zPVZNGQMJ6eRIPpU1eJPBH
	TKuaNgmSs5UaiB23bT72FrecdA05JHDrPE+k4ul2nv34zXXPaWclZ+l6ktjD9PYWVFmVEYKVdJj
	DikkUNURHqUx960BR45x+zC+GkSo=
X-Google-Smtp-Source: AGHT+IHHTedGC5oJD0Vu1tmSZVaNbiFkpm9sE/ONlGtsWoE/IZXd+bdJ1OLyESn5qdLnBcl2H+JvZFkkYYGmNrTNAwo=
X-Received: by 2002:a05:690c:101:b0:65e:684a:2d95 with SMTP id
 00721157ae682-6db451436e1mr20889927b3.7.1725663232031; Fri, 06 Sep 2024
 15:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com> <20240906222116.270196-3-calvinwan@google.com>
In-Reply-To: <20240906222116.270196-3-calvinwan@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 6 Sep 2024 18:53:40 -0400
Message-ID: <CAPig+cQDa7pw5p22CQJZsm8BF_0b6MMyoknAAkFO2zcrPciSiw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] libgit-sys: add repo initialization and config access
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, steadmon@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:21=E2=80=AFPM Calvin Wan <calvinwan@google.com> wr=
ote:
> Wrap a few repo setup and config access functions in libgit-sys. These
> were selected as proof-of-concept items to show that we can access local
> config from Rust.
>
> Co-authored-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>

Josh's sign-off is missing?

> ---
> diff --git a/contrib/libgit-rs/libgit-sys/src/lib.rs b/contrib/libgit-rs/=
libgit-sys/src/lib.rs
> @@ -1,8 +1,19 @@
>  extern "C" {
> +    pub fn libgit_setup_git_directory() -> *const c_char;
> +
> +    // From config.c
> +    pub fn libgit_config_get_int(key: *const c_char, dest: *mut c_int) -=
> c_int;

Perhaps add a comment above libgit_setup_git_directory() stating its
origin, as you do for the other functions mentioned here?

    // From setup.c
    pub fn libgit_setup_git_directory() -> *const c_char;

(Nit: I would probably drop the word "From" from these comments, as it
doesn't seem to add value and ends up being noise. Even better, drop
the comments altogether since they don't really add value and can
easily become outdated if code is ever moved around.)

> +
> +    // From common-init.c
> +    pub fn libgit_init_git(argv: *const *const c_char);
> +
> +    // From parse.c
> +    pub fn libgit_parse_maybe_bool(val: *const c_char) -> c_int;
