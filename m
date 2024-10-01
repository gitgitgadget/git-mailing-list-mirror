Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457429A1
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814693; cv=none; b=r9WGiHx1tMclgC0cVfp9fbVuVT9gjSkAcMopyczO7Esfx67xUQAk8YaNTjUGR+1lpSdkrNsC3WjTU7N35M7r+NO5N+APVp6ZvX9EtmtKsO2oo7T+4AhHAXc2iZVt/usMgP8kBalTfxeL83YPInN577QvwTF3U2sWVH6K1HG/ERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814693; c=relaxed/simple;
	bh=LuBQX4zIDaiWnpyOtCsAPkTMcEIt8FgBV/x8z04zzhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8nhw+EjhfeQbcQBh5U/5nuog79K9z4pHohjhKTHKVFO6cq2kp1RDLfiUurlfARKI2/7GKDQLXnqSwzBjiX2XM8MfKSZlzxTXo1LlDk1RDyGUqi6sQCYpjZQXJE0u1h1O9e6uWuAc+T3jCyqTrZ9Fz3ahWzOVnt5H+IzcDvX/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3dtU2otW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3dtU2otW"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45b4e638a9aso20341cf.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727814690; x=1728419490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qmV8XxKmTyivO12k03MGMQvBSBkYhqiJXFzw/6dr3A=;
        b=3dtU2otWEY9ubFeY6ZHgB9O8/Q3HGVQKCjuR2d5kSou+6rgbPd1smTn6GiXKox8OjC
         IXSZqumzK48yQpB//kWQoMy2vBtHne7CD3J5cP5aSBgqfSW4bTKEO7Gr+ydMWNlWZnDq
         pHKwZWBq8ghOa3ZHhmq+WLs9XkOmyuXTn2qOImkMCS0ClLIcyh0rFtA3+FZpd2j216MH
         Ga/NfIbXdHn7WnAghVFju8ZtUO5Z/yjrbbRGX81JJDPzbNrH1nrLVXpcYEDyBPSmT+LU
         IgdQY1wQ/Y3cgczc+ol3/d1SE2cFWg81/Ffs/J5MWlDEx7PTLB/wGzSiPWBWgDlUMzld
         AKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814690; x=1728419490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qmV8XxKmTyivO12k03MGMQvBSBkYhqiJXFzw/6dr3A=;
        b=kfhP8AAVKfxxSjTD0pfRp5huS30HcdmTdxCGKhuBGWpe1Ou+UAuhdKvKSUQzTTnl02
         ahEuGp0SKUO0I7Pt9DOAl6ENJQpqrWgiO1Y4LirKnYr1i2kWiJEYRGssGb3tG0FeDQJ3
         rYVI8sUnyXruYFCE6ulnzWN4IpqqOeppvHwMVm7qyCJo++GXEQFwuPp/r8eSStEHXvzs
         OfzPu2YhONgUAzLgizbGfoQ4AHPiXBipBYNuQIrGAMjdyl3U7wYdsR4q7uSEo4RLN6I2
         DkHPlW2f2tGPAQs5BemD5SAooiUfcmvtAL1Ec13ebbqOVEX4mp2bt9j6BPyn24Om+ZXS
         2jTA==
X-Gm-Message-State: AOJu0YyaElTs8Xp+txboUVK1PeVHzN6nMr+ubxNp33SmtjbJej98gJ5F
	b1OOd0yzTgX+zHYN/yoWjmyL0cfBOTzR0oNzc2xqrSeUnpWo8n8fYRgNl/DdQQjJfjAeRF5kLuP
	kD/zYPjnIQtWlr+VaGC19zAQnXWOpnLGGGgumWUu2LXQIHj002A==
X-Google-Smtp-Source: AGHT+IHr2tcrt9LVKVQziSnas27p1wqDQu5mXDlXwXqP1dE8HvRxQpEetbl6AbZRwexU0/QGQFKTynugy4Dt00hsuvw=
X-Received: by 2002:a05:622a:7d8f:b0:447:f108:f80e with SMTP id
 d75a77b69052e-45d81737095mr759921cf.16.1727814689332; Tue, 01 Oct 2024
 13:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net> <20240930220352.2461975-2-sandals@crustytoothpaste.net>
In-Reply-To: <20240930220352.2461975-2-sandals@crustytoothpaste.net>
From: Emily Shaffer <nasamuffin@google.com>
Date: Tue, 1 Oct 2024 13:31:15 -0700
Message-ID: <CAJoAoZm2RJnu52Pb-vr0VWS_GQkL5n=DZs7KU50EZyuEYhawYw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:04=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> There is work underway to move some of the Git code out into a reusable
> library.  In such a case, it's not very desirable to have the library
> code write random errors to standard error, since this is an antipattern
> which annoys terminal users.
>
> Instead, we will expect callers of our library function to return
> errors.  The reusability of our library will be substantially improved
> if we return typed errors so that users can easily determine what kind
> of error might have occurred and react differently based on different
> contexts.  For example, if we are looking up an object in a partial
> clone and it's not found, we might decide to download it, but we might
> return an error to the user if the problem is instead that the revision
> specified is not syntactically valid.
>
> To help the libification process and make our code more generally
> maintainable, add an error type.  This consists of on 64-bit integer,
> which contains bit flags and a 32-bit code, and a pointer, which depends
> on the code.  It is designed to be passed and returned by value, not
> pointer, and it is possible to do so in two registers on 64-bit systems.
> Similar functionality works well for error types in Rust and for the
> standard library's lldiv_t, so this should not pose a problem.
>
> Provide the ability to specify either an errno value or a git error code
> as the code.  This allows us to use this type generically when handling
> errno values such as processing files, as well as express a rich set of
> possible error codes specific to Git.  We pick an unsigned 32-bit code
> because Windows can use the full set of 32 bits in its error values,
> even though most Unix systems use only a small set of codes which
> traditionally start at 1.  32 bits for Git errors also allows us plenty
> of space to expand as we see fit.
>
> Allow multiple errors to be provided and wrapped in a single object,
> which is useful in many situations, and add helpers to determine if any
> error in the set matches a particular code.
>
> Additionally, provide error formatting functions that produce a suitable
> localized string for ease of use.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Left a few comments below about portability and readability, but
general thoughts: of course this is quite limited, but I think it will
actually be enough in most cases. It also seems like if we need more
later, we can use this same code-OR-with-pointer thing to point to
something more nuanced than `void* meta`. I'd be in favor of applying
this model to somewhere with clear error codes and relatively few
invocations (maybe to the internals of something like argparse or
run-command, without initially modifying the public interface, for
example?) and seeing where we run into friction. I have a little bit
of concern about the idea of centralizing all the `meta` parsing and
error string generation, but it seems like we might be able to adopt a
model more similar to the one we use for `git_config()` callbacks and
do more context-aware parsing instead to keep `git_error_strbuf` from
getting too huge.

Thanks for sending this. I'm looking forward to hearing others' opinions.
 - Emily

> ---
>  Makefile |   1 +
>  error.c  |  43 ++++++++++++++
>  error.h  | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 error.c
>  create mode 100644 error.h
>
> diff --git a/Makefile b/Makefile
> index 7344a7f725..5d9bf992e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1013,6 +1013,7 @@ LIB_OBJS +=3D dir.o
>  LIB_OBJS +=3D editor.o
>  LIB_OBJS +=3D entry.o
>  LIB_OBJS +=3D environment.o
> +LIB_OBJS +=3D error.o
>  LIB_OBJS +=3D ewah/bitmap.o
>  LIB_OBJS +=3D ewah/ewah_bitmap.o
>  LIB_OBJS +=3D ewah/ewah_io.o
> diff --git a/error.c b/error.c
> new file mode 100644
> index 0000000000..713bc42187
> --- /dev/null
> +++ b/error.c
> @@ -0,0 +1,43 @@
> +#include "git-compat-util.h"
> +#include "gettext.h"
> +#include "error.h"
> +#include "hex.h"
> +#include "strbuf.h"
> +
> +const char *git_error_string(struct git_error err)
> +{
> +       struct strbuf buf =3D STRBUF_INIT;
> +       if (!git_error_strbuf(&buf, err))
> +               return NULL;
> +       return strbuf_detach(&buf, NULL);
> +}
> +
> +const char *git_error_strbuf(struct strbuf *buf, struct git_error err)

Is the idea that we continue to extend `git_error_strbuf` with more
`git_error_code` values as we add this method of error handling across
the codebase? I'm worried it could get quite unwieldy. Or are you
suggesting that we could write `git_error_strbuf_object_store`,
`git_error_strbuf_hook`, etc to keep the code->string conversion
local? That would let us do custom processing of err.meta depending on
context, too, wouldn't it?

> +{
> +       if (GIT_ERROR_SUCCESS(err)) {
> +               return NULL;
> +       } else if (GIT_ERROR_ERRNO(err) !=3D -1) {
> +               return xstrdup(strerror(GIT_ERROR_ERRNO(err)));
> +       } else {
> +               struct git_error_multiple *me =3D err.meta;
> +               switch (GIT_ERROR_GITERR(err)) {
> +               case GIT_ERR_OBJECT_NOT_FOUND:
> +                       if (err.meta)
> +                               strbuf_addf(buf, _("object not found: %s"=
), oid_to_hex(err.meta));
> +                       else
> +                               strbuf_addf(buf, _("object not found"));
> +               case GIT_ERR_NULL_OID:
> +                       if (err.meta)
> +                               strbuf_addf(buf, _("null object ID not al=
lowed in this context: %s"), (char *)err.meta);
> +                       else
> +                               strbuf_addf(buf, _("null object ID not al=
lowed"));
> +               case GIT_ERR_MULTIPLE:
> +                       strbuf_addf(buf, _("multiple errors:\n"));
> +                       for (size_t i =3D 0; i < me->count; i++) {
> +                               git_error_strbuf(buf, me->errs[i]);
> +                               strbuf_addstr(buf, "\n");
> +                       }
> +               }
> +               return buf->buf;
> +       }
> +}
> diff --git a/error.h b/error.h
> new file mode 100644
> index 0000000000..485cca99e0
> --- /dev/null
> +++ b/error.h
> @@ -0,0 +1,168 @@
> +#ifndef ERROR_H
> +#define ERROR_H
> +
> +#include "git-compat-util.h"
> +
> +/* Set if this value is initialized. */
> +#define GIT_ERROR_BIT_INIT (1ULL << 63)
> +/* Set if the code is an errno code, clear if it's a git error code. */
> +#define GIT_ERROR_BIT_ERRNO (1ULL << 62)
> +/*
> + * Set if the memory in meta should be freed; otherwise, it's statically
> + * allocated.
> + */
> +#define GIT_ERROR_BIT_ALLOC (1ULL << 61)
> +/*
> + * Set if the memory in meta is a C string; otherwise, it's a metadata s=
truct.
> + */
> +#define GIT_ERROR_BIT_MSG (1ULL << 60)
> +
> +#define GIT_ERROR_BIT_MASK (0xf << 60)
> +
> +#define GIT_ERROR_OK (git_error_ok())
> +
> +#define GIT_ERROR_SUCCESS(e) (((e).code =3D=3D GIT_ERROR_BIT_INIT))
> +#define GIT_ERROR_SUCCESS_CONSUME(e) ((git_error_free(&(e)).code =3D=3D =
GIT_ERROR_BIT_INIT)
> +
> +#define GIT_ERROR_ERRNO(e) (((e).code & GIT_ERROR_BIT_ERRNO) ? ((e).code=
 & 0xffffffff) : -1)
> +#define GIT_ERROR_GITERR(e) (((e).code & GIT_ERROR_BIT_ERRNO) ? -1 : ((e=
).code & 0xffffffff))

Aurgh, too bad we don't get bitfields before C11. :) (Although I am
not sure if that helps with your register-level optimization at that
point... but it probably helps with readability.)

But, I do wonder if this gluing-together-two-types-into-one-value
thing may break based on endianness? (And if we care? I don't think we
have any tests running on POWER systems, so maybe this falls under the
umbrella of "you should give us tests if you want us to not break
you"?)

> +
> +/*
> + * A value representing an error in Git.
> + */
> +struct git_error {
> +       uint64_t code;
> +       void *meta;
> +};
> +
> +struct git_error_multiple {
> +       struct git_error *errs;
> +       size_t count;
> +};
> +
> +enum git_error_code {
> +       /* The operation was a success. */
> +       GIT_ERR_SUCCESS =3D 0,
> +       /* An object ID was provided, but it was not found.
> +        *
> +        * meta will be NULL or a pointer to struct object ID.
> +        */
> +       GIT_ERR_OBJECT_NOT_FOUND =3D 1,
> +       /*
> +        * An object ID was provided, but it is all zeros and that is not
> +        * allowed.
> +        *
> +        * meta will be NULL or a message explaining the context.
> +        */
> +       GIT_ERR_NULL_OID =3D 2,
> +       /*
> +        * Multiple errors occurred.
> +        *
> +        * meta must be a pointer to struct git_error_multiple.
> +        */
> +       GIT_ERR_MULTIPLE =3D 3,
> +};
> +
> +const char *git_error_string(struct git_error err);
> +const char *git_error_strbuf(struct strbuf *buf, struct git_error err);
> +
> +/*
> + * A successful error status.
> + */
> +static inline struct git_error git_error_ok(void) {
> +       struct git_error e =3D  {
> +               .code =3D 0 | GIT_ERROR_BIT_INIT,
> +               .meta =3D NULL,
> +       };
> +       return e;
> +}
> +
> +static inline struct git_error git_error_new_errno(uint32_t errnoval, co=
nst char *msg, int to_free) {
> +       struct git_error e =3D  {
> +               .code =3D errnoval | GIT_ERROR_BIT_INIT | GIT_ERROR_BIT_E=
RRNO |
> +                       GIT_ERROR_BIT_MSG | (to_free ? GIT_ERROR_BIT_ALLO=
C : 0),
> +               .meta =3D (void *)msg,
> +       };
> +       return e;
> +}
> +
> +static inline struct git_error git_error_new_git(uint32_t gitcode, const=
 char *msg, int to_free) {
> +       struct git_error e =3D  {
> +               .code =3D gitcode | GIT_ERROR_BIT_INIT |
> +                       GIT_ERROR_BIT_MSG | (to_free ? GIT_ERROR_BIT_ALLO=
C : 0),
> +               .meta =3D (void *)msg,
> +       };
> +       return e;
> +}
> +
> +static inline struct git_error git_error_new_simple(uint32_t gitcode) {
> +       struct git_error e =3D  {
> +               .code =3D gitcode | GIT_ERROR_BIT_INIT,
> +               .meta =3D NULL,
> +       };
> +       return e;
> +}
> +
> +static inline struct git_error git_error_new_multiple(struct git_error *=
errs, size_t count)
> +{
> +       struct git_error_multiple *me =3D xmalloc(sizeof(*me));
> +       struct git_error e =3D  {
> +               .code =3D GIT_ERR_MULTIPLE | GIT_ERROR_BIT_INIT | GIT_ERR=
OR_BIT_ALLOC,
> +               .meta =3D me,
> +       };
> +       me->errs =3D errs;
> +       me->count =3D count;
> +       return e;
> +}
> +
> +/*
> + * If this is a git error and the code matches the given code, or if thi=
s is a
> + * multiple error and any of the contained errors are a git error whose =
code
> + * matches, returns a pointer to that error.  If there is no match, retu=
rns
> + * NULL.
> + */
> +static inline struct git_error *git_error_is_git(struct git_error *e, in=
t code) {
> +       int64_t giterr =3D GIT_ERROR_GITERR(*e);
> +       if (giterr =3D=3D code) {
> +               return e;
> +       } else if (giterr =3D=3D GIT_ERR_MULTIPLE) {
> +               struct git_error_multiple *me =3D e->meta;
> +               for (size_t i =3D 0; i < me->count; i++)
> +                       return git_error_is_git(me->errs + i, code);
> +               return NULL;
> +       } else {
> +               return NULL;
> +       }
> +}
> +
> +/*
> + * If this is an errno error and the code matches the given code, or if =
this is
> + * a multiple error and any of the contained errors are an errno error w=
hose
> + * code matches, returns a pointer to that error.  Otherwise, returns NU=
LL.
> + */
> +static inline struct git_error *git_error_is_errno(struct git_error *e, =
int code) {
> +       int64_t giterr =3D GIT_ERROR_GITERR(*e);
> +       if (GIT_ERROR_ERRNO(*e) =3D=3D code) {
> +               return e;
> +       } else if (giterr =3D=3D GIT_ERR_MULTIPLE) {
> +               struct git_error_multiple *me =3D e->meta;
> +               for (size_t i =3D 0; i < me->count; i++)
> +                       return git_error_is_errno(me->errs + i, code);
> +               return NULL;
> +       } else {
> +               return NULL;
> +       }
> +}
> +
> +/* Frees and deinitializes this error structure. */
> +static inline uint64_t git_error_free(struct git_error *e)
> +{
> +       uint64_t code =3D e->code;
> +       if (e->code & GIT_ERROR_BIT_ALLOC)
> +               free(e->meta);
> +       e->code =3D 0;
> +       e->meta =3D NULL;
> +       return code;
> +}
> +
> +#endif
