Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B113212B
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664699; cv=none; b=RNJohpsB06cD+iBHWR4rcKN/2cWv6wKqM2tgk6X+pIObS2PPN2iYS4X1kFmFHCzL3YZksX0SFD3qwPxROoE+aR8QwT6hrvCyvSVePR2olLIhqJSQDmxrD2BdBktnbuIP32EEbLUgjrBqXEMRBIyEaofAQx5MB2JWmdH5rAxJcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664699; c=relaxed/simple;
	bh=ZaYM6x2INPryzoofA6cX9WCbFGEF5lSQSoexm3suCNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTCAYJr28G7HhwxozI30hZajZOH04eBrOaGVZ4evQUOplItU5hWZ/OJKGL88HrBgA+5mZI2v2kD2OJhunDGLj24ReQrRUXKX7dyhIqRgeALWTM3YDxXg0dpeJCjpFyVFdUX64mMkfi1pR40deTdw2/dQ///N7i4VdujUtKIaEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThJeoyKA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThJeoyKA"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso4394719a12.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 02:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724664696; x=1725269496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM3j8vHUaDKBWQSreARk7iCkwu755fN+6gT0RaAAOPc=;
        b=ThJeoyKAIjAerWVa0LqetcfiK4Ikruga+iqu09f+igELAoUqXSnjQvLjrVWnYak9jm
         4iqw8En/Hr9Ta6pNYpPqBAtW6SkcfQ/scD9VfmpXIvpblQUP29idAyNgRCQWH/IGyJOk
         cEPUu6iV0d0/FobnatNs3YFHrjgpkCW+F3xoVzI1tZ7N4isNGFOreQsiyPMpg0XMAuQN
         4GooY3u08GzE43YX8nHtLUcGfF3+1EctQDoq1PK2vzTM5tAcLxhNLilmQlJ0iiBBO5g6
         O0hEN6KI13kNfTVxDTyDyUJzRnEYK08SzjbXlDl+t1HUJNi06WnZPi41YKHJH+11R6iS
         kqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724664696; x=1725269496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM3j8vHUaDKBWQSreARk7iCkwu755fN+6gT0RaAAOPc=;
        b=trM776oa0F8G4NNhnUtWmdJVGTdNpKhKBqS+lIoRBcQd+xBVEQNOS81rKAL/O4V6mY
         zyaY0XJEl/dKZ8cyi+PH2/tPqM0TNIwiXLdZhiguofFKbulD4iaTbvOb+VJIS/xXDhCt
         94ib186kDR5Blpu2ZpyijDlX+zqPGo1j+x/baR0La2VVfqOLIrkzd3OOJSM/VZUTtW1B
         a41S4nQ3OY0QibfBQgxAgriOAmx3y6AAJFThSMaGdXyLA3prPYiOB+pSN+LSxl1UhiEG
         Hfwog/hkzBt/OR/GgyITQFug2hFaLAaSGyFVmRg/tZeGDho9p7bAx+nGw3i5qWCz5/+5
         e/2g==
X-Gm-Message-State: AOJu0YzF+edz1zw/Nfb863X5sCeHmTfXQbHPM6lVBisWiSzqQixIGpmU
	LlY+ptT5DtwX4SgD7MpSlAo0KHAV+gbRfCkDD7cIqzuoJ6uZDot6RS6lPbtCjliZ2pGEFJZrAZ4
	e1HnU880j2XI3ZCHy2q7VmtvaLEyMZDmY
X-Google-Smtp-Source: AGHT+IFSifbbPFDLgMjVmoYH0ticfmkEGKKROB4ctrNwkcgiZyXtpTqPZDkUABD6T/e7JqImCR/4rF6pb7lknPlZt+Y=
X-Received: by 2002:a17:907:7e95:b0:a7a:9ca6:528 with SMTP id
 a640c23a62f3a-a86a5165852mr731987066b.11.1724664695065; Mon, 26 Aug 2024
 02:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824172028.39419-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240824172028.39419-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 Aug 2024 11:31:22 +0200
Message-ID: <CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 7:20=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> Add tests for oidset.h library, which were not previously present using
> the unit testing framework.

It might be interesting to also say if there are tests for oidset in
the end-to-end tests, not just in the unit test framework. Also I
think oidset.h is more an API than a library.

> This imposes a new restriction of running the test from the 't/' and
> 't/unit-tests/bin'

Either "from 't/' and 't/unit-tests/bin'" or "from the 't/' and
't/unit-tests/bin' directory" would be a bit better.

> for constructing the path to the test files which
> are used by t_parse_file(), which tests the parsing of object_ids from
> a file.

This might be clearer if it mentioned that t_parse_file() actually
tests oidset_parse_file() which is part of the oidset.h API.

> This restriction is similar to the one we already have for
> end-to-end tests, wherein, we can only run those tests from 't/'.

Ok.

> The
> addition of allowing 't/unit-tests/bin' for allowing to run tests from
> is for running individual unit tests,

Maybe: "Allowing to run tests from 't/unit-tests/bin', in addition to
't/', makes it possible to run individual unit tests,"

> which is not currently possible
> via any 'make' target. And 'make unit-tests-test-tool' also runs from
> 't/unit-tests/bin'

It would be nice if you gave a few examples of commands that can be
run after this patch while they didn't work before it.

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> I know there is some hesitance from the community in imposing the
> restriction of running the unit tests from certain directories, so
> if this case does not justify imposing such a restriction, I am fine
> with removing t_parse_file() in the next version.

My opinion is that it might be good to remove t_parse_file() for now,
as testing oidset_parse_file() might not be so important. Later an
iteration in a separate patch could then perhap add it while better
discussing if the restrictions that come with adding it are worth it.

> diff --git a/t/unit-tests/lib-oid.c b/t/unit-tests/lib-oid.c
> index 37105f0a8f..8f0ccac532 100644
> --- a/t/unit-tests/lib-oid.c
> +++ b/t/unit-tests/lib-oid.c
> @@ -3,7 +3,7 @@
>  #include "strbuf.h"
>  #include "hex.h"
>
> -static int init_hash_algo(void)
> +int init_hash_algo(void)
>  {
>         static int algo =3D -1;
>
> diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
> index 8d2acca768..fc3e7aa376 100644
> --- a/t/unit-tests/lib-oid.h
> +++ b/t/unit-tests/lib-oid.h
> @@ -14,4 +14,5 @@
>   */
>  int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
>
> +int init_hash_algo(void);
>  #endif /* LIB_OID_H */

It seems that the changes above will go away when some patches you
already sent will be merged, which should happen soon. It might have
been nice to say this in the section after the "---" line.

> +static void t_parse_file(void)
> +{
> +       struct strbuf path =3D STRBUF_INIT;
> +       struct oidset st =3D OIDSET_INIT;
> +       struct object_id oid;
> +       int hash_algo =3D init_hash_algo();
> +
> +       if (!check_int(hash_algo, !=3D, GIT_HASH_UNKNOWN))
> +               return;

If initializing the hash algo fails here, it is likely because it
already failed when get_oid_arbitrary_hex() (which initializes it) was
called in the tests before this one. So I think it might be even
better to move the above hash algo initialization code to setup() and
make setup() error out in case the initialization fails. Then setup()
could pass 'hash_algo' to all the functions it calls, even if some of
them don't use it.

> +       strbuf_test_data_path(&path, hash_algo);
> +       oidset_parse_file(&st, path.buf, &hash_algos[hash_algo]);
> +       check_int(oidset_size(&st), =3D=3D, 6);
> +
> +       if (!get_oid_arbitrary_hex("00", &oid))
> +               check_int(oidset_contains(&st, &oid), =3D=3D, 1);
> +       if (!get_oid_arbitrary_hex("44", &oid))
> +               check_int(oidset_contains(&st, &oid), =3D=3D, 1);
> +       if (!get_oid_arbitrary_hex("cc", &oid))
> +               check_int(oidset_contains(&st, &oid), =3D=3D, 1);
> +
> +       if (!get_oid_arbitrary_hex("11", &oid))
> +               check_int(oidset_contains(&st, &oid), =3D=3D, 0);
> +
> +       oidset_clear(&st);
> +       strbuf_release(&path);
> +}

Thanks.
