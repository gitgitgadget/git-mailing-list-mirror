Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E471509AE
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060526; cv=none; b=Qx7CXTjKfed0eyCmFcB8P36+L2/EJZsxQx8KEvQZztzUSE1zx5t5hM5ZmUWnsYNdAoCTM+as17Z8d9XtfiP/z62J5zxKDofNl0mEx0sxrUug6QM4SADOZ6N24onxw02CwWiOHAUw/gPg6D0iNlRs4hK81Z+Rno2ml4yhFzwPFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060526; c=relaxed/simple;
	bh=lp5/y+P2UdEUvfYCcAtChx8VUef4h3BtuQ2FYE5oESI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=t2LjaF+UaOL5JpwKKXiRqwZaS3fZF8+k1wQixJbHC2aK2WQ3+HHkJ72dsMmgZsoh5Qnf/kPoG+T/ssaKzYqbArHR8t2t6Yxk+OIrcewZjaVUus6LivohcWZSMVu0n3Kppg8su5eUPZlQziiLr4QmEfiVzaIsdjsQOAx9d+XTZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8lqpjL6; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8lqpjL6"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ba70a0ed75so241678eaf.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718060519; x=1718665319; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NMtOKSZ7NraxTFFkbLaa2gW2HTDnFenEDXl+1mSZ78=;
        b=X8lqpjL6GkjfyxhJJtadJ1g3x4fQoN+gOjE8PjWmuunzQbXBMJWknWds8Wzgr3+kDZ
         HIAuYMqkR8tkS6j2tUBbqPZmkxFIQ4h8Ki7DNbNX83AfS+5B8exQ/d2IXaixvjW7rF4A
         QRDx1aoXtVR32MHaX6j9lKyOXf1jjWNYgGEHE+JYwdLfFSmwi+R3iPIN6RV3DA4gVRKo
         lDQPm38TbpJRjF+7FXfUwZPOry+2YCsQT56YNT5CMUcHVzvALnNIjA1GZDwpsMpcOptb
         kF2MDjpDFP8OuSZKDsPOL3hJFHjFvZOravt39zekbRqjmjA+TtYZVWmvOSvXNFvM85Av
         Ho9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060519; x=1718665319;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NMtOKSZ7NraxTFFkbLaa2gW2HTDnFenEDXl+1mSZ78=;
        b=nD4FQwxSCYvhK45q/mvTNT0xZax2XctYKDU2NJUWXDbJDLQu9sbhyJQnyzgMvqpqEZ
         dz6j1Mo99+k+jwaSdsa2fIR5ZxnJT+r1fqYDHj3nVVTRJFfRgYevAQA0jLivaaYqihSH
         wXrq9xiFbyostcET/7hlvW+LmRYtSJwRN4GtvbiDKsKmTERNzzCRlc5S1ilPZEHUDRy+
         IVuKFA3FwNK0fv2A/qfdHRMN2metaGK7RwlqCYb8mR/9abA+X49YGpbGeZN+M5OdK8It
         mUqSMMheXKk9QYF6dNHYJSWEmtOZaF8kYHNmCPHzRN9sxJ5fs4pDDb+hB5nwfJfIegQa
         CgQQ==
X-Gm-Message-State: AOJu0Yz7KKapZlVTToclC00f3bMU0Qjd0YZnpVeyMc9PB7jwGi8rL/HB
	asxOlCVbvxsj0ohcQ43itaA9by0h5wasyNuRPK+iH0cq7sdPwadrt0PjSKBN/BQ7MQdDe03T7Ke
	USmQlGmDy8/gYHV0EsVlzAeHPngVHB5vcoXGcGmdlzrTePSzjIHxP
X-Google-Smtp-Source: AGHT+IHSpj84629un8qrznt0XMVeFzlNbm7lr9DXs9O5KUOh4U3Ol/70XpyM4SWlrU0cAfITvZu95aHL+qwsOTn8Otg=
X-Received: by 2002:a4a:a381:0:b0:5ba:e1aa:9346 with SMTP id
 006d021491bc7-5bae1aa93f9mr5641394eaf.4.1718060519002; Mon, 10 Jun 2024
 16:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
In-Reply-To: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 10 Jun 2024 16:01:42 -0700
Message-ID: <CAO_smVjL+Ms1e_Rd5e1k-zMJb_NydBtX76Dh=ifK9Ym9ME9roQ@mail.gmail.com>
Subject: Re: SEGV (detected by Address Sanitizer) when using `core.abbrev` option
To: Git Mailing List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 3:27=E2=80=AFPM Kyle Lippincott <spectral@google.co=
m> wrote:
>

I just realized I didn't give a reproduction command, sorry about
that; here's the reproduction command provided by our user:

git config --global core.abbrev 12
git clone https://github.com/git/git.git

I realized this because Josh Steadmon informed me that config
loading/parsing is lazy when I asked why `git bisect` still worked
with this setting in my git config. So I think this might be a problem
only for things that go through `git_default_config` (if we set up the
repo object, we probably work just fine).

> c8aed5e8dadf (repository: stop setting SHA1 as the default object
> hash, 2024-05-07) stopped initializing the_hash_algo, but config.c
> references it when it observes a user setting core.abbrev, in two
> ways:
> - if core.abbrev is detected as a 'no' boolean value, then
> default_abbrev is set to the_hash_algo->hexsz
> - if core.abbrev is set to an integer, it verifies that it's within
> range for the hash algorithm (specifically: it errors out if the value
> is < minimum_abbrev or > the_hash_algo->hexsz).
>
> Stack:
> =3D=3D2421488=3D=3DERROR: AddressSanitizer: SEGV on unknown address
> 0x000000000018 (pc 0x56344202585f bp 0x7fff9546fe10 sp 0x7fff9546fcb0
> T0)
> =3D=3D2421488=3D=3DThe signal is caused by a READ memory access.
> =3D=3D2421488=3D=3DHint: address points to the zero page.
>     #0 0x56344202585f in git_default_core_config git/config.c:1466
>     #1 0x56344202585f in git_default_config git/config.c:1815
>     #2 0x56344202064e in configset_iter git/config.c:2185
>     #3 0x563441d531cb in cmd_clone builtin/clone.c:981
>     #4 0x563441cebac2 in run_builtin git/git.c:474
>     #5 0x563441cebac2 in handle_builtin git/git.c:729
>     #6 0x563441ceed0a in run_argv git/git.c:793
>     #7 0x563441cf0aea in cmd_main git/git.c:928
>     #8 0x563441ce9323 in main git/common-main.c:62
>     #9 0x7fa3228456c9 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>     #10 0x7fa322845784 in __libc_start_main_impl ../csu/libc-start.c:360
>     #11 0x563441ceb530 in _start (git/git+0x1e0530) (BuildId:
> c0e4b09d5b212a201769f1eb8e7592cddbe3af1d)
>
> AddressSanitizer can not provide additional info.
>
> ---
>
> My first thought for a fix was to just cap it at 40, with the
> assumption that the code would handle it correctly in the unlikely
> event that the hash size ever decreased, but I don't think that does
> the right thing if `core.abbrev=3Dno`. That's documented as a way of
> obtaining the full hashes (with no abbreviation), and if we're using
> sha256, capping that at 40 hex (160bits) is incorrect.
>
> My second thought was that we could store the requested value and
> validate it on every usage. This complicates usage locations, and can
> lead to poor behavior (crashes in the middle of operation when we
> finally get around to checking the value).
>
> My third thought was that we could store the requested value and
> validate when we have a repository that initializes the hash for us as
> part of that initialization. If we attempt to abbreviate some hashes
> without that setup, we act as if core.abbrev isn't set at all (so they
> get the default behavior). That seems like the best option overall.
> Exploring that further ...
>
> I've looked at a semi-random collection of places where
> `default_abbrev` or `DEFAULT_ABBREV` are used, and they all seem to
> eventually go through `repo_find_unique_abbrev_r`, and they pass in
> the len. This also always has a repository available (otherwise it
> wouldn't be able to disambiguate). Furthermore, it has `if (len < 0)`.
> We could thus carry the "unvalidated" request in default_abbrev by
> having special magic values (auto=3D-1 like today, no=3D-2 (replaced with
> hexsz when we know it), other requests are <=3D -4, for a requested
> length of 4 or higher), or we could have another variable
> (requested_default_abbrev) that gets copied to default_abbrev when we
> have a repo.
>
> The one potential issue I can think of with this is that setting
> `core.abbrev =3D no`, having that resolve to 64 (sha256) when we set up
> the repo, and then if we ever read from a repo that uses 40 hexsz
> (such as sha1), then we have to ensure that we tolerate a requested
> length greater than the current hash algorithm's maximum length. This
> likely wasn't a problem when sha1 was the default, because we're
> unlikely to go to a hash algorithm with <160 bits in the future. But
> if sha256 becomes the default, then this can be problematic.
