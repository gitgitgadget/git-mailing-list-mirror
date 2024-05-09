Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B7770EB
	for <git@vger.kernel.org>; Thu,  9 May 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283974; cv=none; b=XmsosQIw2Jbw14v+L5vq8lgryWD/qITTKD4K0phosD1mn8XuEhgu2DgF+kIZT244XXU0il28eQNeS0EKDsn50ELl8z4IrZIDILnPIsaX3aiznhC2KRxxG4KeBsMX/4q10xEZlu+lSbdr5BNst5Ao9yZoGMZJbFpB2qigtYl2r8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283974; c=relaxed/simple;
	bh=BfmtcIL/AiF4M6kccaWlqelBAhcJn+qECBHZVaM/JbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUDbOl9+g/YftrgcFb/WN+Cd9jww1fokyJMT5IScfn1UU3aJ2fY2rkkOvbqw6KG0FMFmc30/IITzBCav/bzrfD5YfbFzXYksFnjaicyeAzEsRFyZxhkuA9RCqv4V9u4nl/Eso2rf4HuYM3Pp9eDwTDrtLmuiL0JkMzOpT/FDqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axeFK0B7; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axeFK0B7"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f0e7af802eso278283a34.0
        for <git@vger.kernel.org>; Thu, 09 May 2024 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715283972; x=1715888772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJGDrhamDB0W/Y5SAb7LkJbxvDn/Rr53K2kX0Z2Qd/E=;
        b=axeFK0B7wM/Rcwc22LbgRLqCZdgb1m6krue6PI9oEJgP2ZRQw3BNEzv1xY7HxTerJI
         1FhYHkrTHVf/lluzSoc1ByKpCOTFHFXv818f99YKCuY4mDj0P3zswiuKdStNkfTQMCzv
         Ts/jrzhX2f8e9EJA9GsXcivNImf+mwmL3vpnLpFtUKs4e1Fu3bdOvv/LSLEpzw/w273y
         sH86VuW1KsEi1VgBpCvssU6bo339nOpYOetQ3n8yIpo/lw+QBQeAb/vBnIdQ9gImFovl
         caE7hMdytwdNJYON1ZZpmAI3Tfb+Sz+nL2Ex2cdn36f1PjzzOUT2Ll7AAYGo5l/uBFCp
         iwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715283972; x=1715888772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJGDrhamDB0W/Y5SAb7LkJbxvDn/Rr53K2kX0Z2Qd/E=;
        b=j4iCNZjijIIyPA6Ld2YN/Sxq643ct95Q1biuS6TuWRUQvk1G8gqNz5ijmqiOXQai9v
         pZKUxCuGxzuP/AOnSitHISAQyGmZU0nPxWWgzlHeXXiXdzh9RseBcnCJN/AwSMdbOO0q
         veuOYhM3BglbN3VC0UmO5Kt7nQcHKoc0XzUrSXbfkzjSOS2QecM0n7nedb5jue8wyxVg
         dFYNQ6xUITh3ilSOlIih90DpXGRwV8tlYC91Py96HGHp7Xi1RqexW+1Hj3AoSiIkn0sA
         3q4RrZm1BZtToj1IUgEdrJgo94PeHfrBhvAw33KCXyRsU1dbH2ZK8XnhXtRaun/hPUjh
         wMiA==
X-Gm-Message-State: AOJu0YyG4Qdua53j1TIoSTy2vrm615PAtt8K9XQLzh8AWfr3qWfe/3QY
	7IXfC05mcbH2mcwOcvaJQvpa0UC+dUN10s3HYjaC9mwtss44CaQHCbCPoq+TKD5zyLUXavm7H6q
	p9xRQdPWLcejhYQpsC2DETxORu2GVotxuVCuR
X-Google-Smtp-Source: AGHT+IFFHI8mYXI9LGJoTO3yohK1ld5axbw2RNy1PCORUQ7gy0po+Nh+rgQInmHk5ks93Ti+wqwfIk83pAzqWoq/pGU=
X-Received: by 2002:a9d:7986:0:b0:6f0:9914:b640 with SMTP id
 46e09a7af769-6f0e91099bcmr703821a34.1.1715283972006; Thu, 09 May 2024
 12:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
 <20240422162617.308366-1-calvinwan@google.com>
In-Reply-To: <20240422162617.308366-1-calvinwan@google.com>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 9 May 2024 12:45:51 -0700
Message-ID: <CAO_smVhjtvHeDR6KYNJL+hzc5uheWjshaayQPN1PkBhRaFTqOQ@mail.gmail.com>
Subject: Re: [RFD] Libification proposal: separate internal and external interfaces
To: Calvin Wan <calvinwan@google.com>
Cc: Git Mailing List <git@vger.kernel.org>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	rsbecker@nexbridge.com, phillip.wood@dunelm.org.uk, 
	Josh Steadmon <steadmon@google.com>, Emily Shaffer <nasamuffin@google.com>, 
	Enrico Mrass <emrass@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 9:26=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:
>
> Thanks everyone for your initial comments on this discussion. I wanted
> to provide some examples of how an internal/external interface could
> look in practice -- originally I had intended to use git-std-lib v6 as
> that example, but found that it fell short due to feedback that only
> being able to expose a smaller subset of functions in that library would
> be insufficient for users since they should have the same tools that we
> have for building Git. In this reply, I have two examples of paths
> forward that such an interface could look like for future libraries
> (both methods would require a non-trivial amount of code change so this
> seemed like a better idea than completely refactoring git-std-lib twice).
>
> Part of the reason for wanting to expose a smaller subset of library
> functions initially was to avoid having to expose functions that do
> things a library function shouldn't, mainly those with die() calls. I
> chose `strbuf_grow()` as the example function to be libified with an
> internal/external interface since it has a die() call and in a library,
> we would want to pass that error up rather than die()ing. I have two
> ideas for how such an interface could look. For reference, this is how
> `strbuf_grow()` currently looks:
>
> void strbuf_grow(struct strbuf *sb, size_t extra)
> {
>         int new_buf =3D !sb->alloc;
>         if (unsigned_add_overflows(extra, 1) ||
>             unsigned_add_overflows(sb->len, extra + 1))
>                 die("you want to use way too much memory");
>         if (new_buf)
>                 sb->buf =3D NULL;
>         ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>         if (new_buf)
>                 sb->buf[0] =3D '\0';
> }
>
> The first idea involves turning `strbuf_grow()` into a wrapper function
> that invokes its equivalent library function, eg.
> `libgit_strbuf_grow()`:
>
> int libgit_strbuf_grow(struct strbuf *sb, size_t extra)
> {
>         int new_buf =3D !sb->alloc;
>         if (unsigned_add_overflows(extra, 1) ||
>             unsigned_add_overflows(sb->len, extra + 1))
>                 return -1;
>         if (new_buf)
>                 sb->buf =3D NULL;
>         ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>         if (new_buf)
>                 sb->buf[0] =3D '\0';
>         return 0;
> }
>
> void strbuf_grow(struct strbuf *sb, size_t extra)
> {
>         if (libgit_strbuf_grow(sb, extra))
>                 die("you want to use way too much memory");
> }
>
> (Note a context object could also be added as a parameter to
> `libgit_strbuf_grow()` for error messages and possibly global variables.)
>
> In this scenario, we would be exposing `libgit_strbuf_grow()` to
> external consumers of the library, while not having to refactor internal
> uses of `strbuf_grow()`. This method would reduce initial churn within
> the codebase, however, we would want to eventually get rid of
> `strbuf_grow()` and use `libgit_strbuf_grow()` internally as well. I
> envision that it would be easier to remove die()'s all at once, from top
> down, once libification has progressed further since top level callers
> do not have to worry about refactoring any callers to accomodate passing
> up error messages/codes.
>
> The shortfall of this approach is that we'd be carrying two different
> functions for every library function until we are able to remove all of
> them. It would also create additional toil for Git contributors to
> figure out which version of the function should be used.
>
> The second idea removes the need for two different functions by removing
> the wrapper function and instead refactoring all callers of
> `strbuf_grow()` (and subsequently callers of other library functions).
>
> int libgit_strbuf_grow(struct strbuf *sb, size_t extra)
> {
>         int new_buf =3D !sb->alloc;
>         if (unsigned_add_overflows(extra, 1) ||
>             unsigned_add_overflows(sb->len, extra + 1))
>                 return -1;
>         if (new_buf)
>                 sb->buf =3D NULL;
>         ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>         if (new_buf)
>                 sb->buf[0] =3D '\0';
>         return 0;
> }
>
> void strbuf_grow_caller() {
>         strbuf *sb;
>         size_t extra;
>
>         // if only success/failure is passed up
>         if (libgit_strbuf_grow(sb, extra))
>                 die("you want to use way too much memory");
>
>         // if context object is used
>         if (libgit_strbuf_grow(sb, extra, context_obj))
>                 die(context_obj->error_msg);
>
>         // if there are multiple error codes that can be passed up
>         if (libgit_strbuf_grow(sb, extra) =3D=3D -1)
>                 die("you want to use way too much memory");
>         else if (libgit_strbuf_grow(sb, extra) =3D=3D -2)
>                 die("some other error");
> }

Thought about this some more last night, and I think we'll _need_ to
go with this approach for most of the libraries (all but the ones used
by builtin/*.c, which can have a wrapper that preserves existing
functionality), otherwise the libraries aren't composable. If we have
three library interfaces, with interface C depending on B which
depends on A, C needs to call the library safe versions of B, and B
needs to call the library safe versions of A, which means that the
"internal" version needs to be the library safe version. So I think
that we're back to my original proposal:

// Library-safe method, used internally
int strbuf_grow(struct strbuf *sb, size_t extra)
{
        int new_buf =3D !sb->alloc;
        if (unsigned_add_overflows(extra, 1) ||
            unsigned_add_overflows(sb->len, extra + 1))
                return -1;
        if (new_buf)
                sb->buf =3D NULL;
        ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
        if (new_buf)
                sb->buf[0] =3D '\0';
        return 0;
}

// "External" version
int libgit_strbuf_grow(struct strbuf *sb, size_t extra)  // Or maybe int64_=
t?
{
        strbuf_grow(sb, extra);
}

I don't expect there's many cases where we want to create a wrapper
that maintains the existing interface and error handling, because that
wrapper can _only_ by used by the git project binaries, not any of the
code that's in a library.

>
> One shortcoming of this approach is the need to refactor all callers of
> library functions, but that can be handled better and the churn made
> more visible with a coccinelle patch. Another shortcoming is the need
> for lengthier code blocks whenever calling a library function, however,
> it could also be seen as a benefit since the caller would understand the
> function can die(). These error messages would also ideally be passed up
> as well in the future rather than die()ing.
>
> While I tried to find a solution that avoided the shortcomings of both
> approaches, I think that answer simply does not exist so the ideas above
> are what I believe to be the least disruptive options. I'm wondering
> which interface would be more suitable, and also open to hearing if
> there are any other ideas!
