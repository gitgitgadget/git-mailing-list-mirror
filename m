Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CD10A1D
	for <git@vger.kernel.org>; Thu,  9 May 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216443; cv=none; b=DXuPsuWBo4i6rzCXtiHTTFBajB88Lj5+zpJblIZp8FbWiImytuuDYGNUA2O74mriZfBd9pKHjLYogJIlKegivTVM9K4UiBVmxAkDkjmZI8aEDh2QvKh4Ca5CHG8XgX5CGF+nmtGWflQzhNRm4XxHBPlilrbQPgG74toKz5zERHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216443; c=relaxed/simple;
	bh=MQAiXz/rCr37/SJ5QdpB9TBgA4r9kqfACrRHvnEYaAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwoUqVPxjJQ83Told6V15nqF0x7E7Mjs5KVudbZD3dTr1BEqGOltNsDU0Pa7cRLdjuL1IlPPfs9zz/rnLjb23/dbzOK31BePddmmEcyCiMnEjBvxJc3N2V84OHyOcKfA/JVeNCKivARvtvnf9P2Gk6NUAFmuuga00H+nSs2O3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xai2keRL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xai2keRL"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e428242a38so4154741fa.2
        for <git@vger.kernel.org>; Wed, 08 May 2024 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715216439; x=1715821239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjAlbGyI8XgQPnaLcwwSwZPtKcvGyEBZPA0kk3lNaoU=;
        b=Xai2keRLuePcIM5iyTjn1TzzAGz56BJemcyf9PfsB9Y5GrNZBBwN6bcKjvkJTcIxeP
         JF8qg+T+HdzZAettytH646zZI0YOy1nAiHZmepmyjlUiyYhArrWJB2uReqvR5j9iXbTO
         pUYlcNW1CmPFOC7hXGQ2wBABsTywrn0ub3EhTBQxQyQoNpPrRYDGx1IRnvT8Txz5jt+b
         H3jqKvJrOEOrzEQdKKj8nBDGyyYfBICTvNB0Rp+r4uxUZ6CLBuXXhkgZZJ0c30BEn7jJ
         uRnAc9cR/4wJD6pNtDCKMxbnFhL/aiJeh/fAZDNgoFzsU88sonQ8WWc1S7CRYzMfGgiu
         PQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715216439; x=1715821239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjAlbGyI8XgQPnaLcwwSwZPtKcvGyEBZPA0kk3lNaoU=;
        b=lG8SmrrPYvFuLbr9DE74MxRfqWOudF9Xo+Ui7d6MrHKKP96zvguYZTn+DdKArymjKD
         Jto+VZnl5qicu4BQmH7q4mqLSewbh9ClO6/3XQaFZQ4g+zzM/XQeK4WAZ9pKIF8McON3
         r7H8IDPUv2mO6zY1KYqrD/0cVC0n7EnZr06xwZNOZye3g7h2chFg4HwsFQ1kxT8yKe89
         +AFRiba0u2gbFaBxM4iGCXW1Xtv9lXzB0KgByAPRSiz4TIaNTZl9SjiFeclGt58pDLob
         hSxBzRPGaSIHxTKbjRDcciVTnrJCCpeGD5F3kRh9V++zqsmsW9QGEQTVL8EAIr2ciKS+
         5New==
X-Gm-Message-State: AOJu0Yy6AtZs/HCq9McsZrKIt2E5V79achl3cq7U1hnHDNvlsaw9ibTI
	sERrZDOYCW+qNy8G/4P0Sy7/qfxaM6Eb+cROH27uPfMRRgNt05oBYAvfVmxmkRwRIOmGC8+F3LX
	4b2Xvf9zGA+8ynzTJfBnTBi5msjq5yFLKUp/G
X-Google-Smtp-Source: AGHT+IExA0ZbEbemOO2lAoo8KDSrGRryr32N6h+hcdCxjMq7MQ0STQg/NJ7zMBc2GR7bPGZrZKu2i/3PZ1ObNoyGHR0=
X-Received: by 2002:a2e:a314:0:b0:2e1:9c57:195a with SMTP id
 38308e7fff4ca-2e447699583mr36169361fa.32.1715216439072; Wed, 08 May 2024
 18:00:39 -0700 (PDT)
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
Date: Wed, 8 May 2024 18:00:24 -0700
Message-ID: <CAO_smVg_RmL2_ERXG0uZ+CgEHZBm34PvmNucbSTdsEDLjU-fhA@mail.gmail.com>
Subject: Re: [RFD] Libification proposal: separate internal and external interfaces
To: Calvin Wan <calvinwan@google.com>
Cc: Git Mailing List <git@vger.kernel.org>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	rsbecker@nexbridge.com, phillip.wood@dunelm.org.uk, 
	Josh Steadmon <steadmon@google.com>, Emily Shaffer <nasamuffin@google.com>, 
	Enrico Mrass <emrass@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for being absent from a thread that I was the initial author
of, there was a family emergency.

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

When writing the initial document, I was thinking of something almost
the exact opposite of this, but I hadn't been thinking about the
problems with the code calling `die` and similar. I was thinking along
the lines of:

// In a .c file that is "library internal".
// This translation unit can assume that we've done #include
"git-compat-util.h" and anything else it wants.
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

// In a .c file for the interface as used by other projects:
int gitlib_strbuf_grow(struct strbuf *sb, size_t extra)  // Or maybe int64_=
t?
{
        return strbuf_grow(sb, extra);
}

After reading this thread, I agree that this isn't sufficient to avoid
churn, and I like the proposed interface, but with one main tweak:

// RENAMED from previous code block (no other changes)
// In a .c file that is "library internal".
// This translation unit can assume that we've done #include
"git-compat-util.h" and anything else it wants.
int strbuf_grow_impl(struct strbuf *sb, size_t extra)
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

// In a .c file for the interface as used by other projects:
int gitlib_strbuf_grow(struct strbuf *sb, size_t extra)
{
        return strbuf_grow_impl(sb, extra);
}

// NEW from previous code block
// In a .c file for the interface as used by the git project itself:
void strbuf_grow(struct strbuf *sb, size_t extra)
{
        if (strbuf_grow_impl(sb, extra))
                die("you want to use way too much memory")
}

I'm recommending this pattern primarily because of our platform
support concerns. If we can't elevate the entire project to assume
that C99 is available in a standards compliant way, we can't have
header files that look like this be part of building the `git` binary
itself (or any of the helper binaries):

#include <stdint.h>  /* Our platform support policy doesn't allow this */
int gitlib_strbuf_grow(struct strbuf *sb, size_t extra);

It's not just the #includes, though. As stated in the original
document, we run into problems with platform-defined types and
everything else that's tweaked in/provided by git-compat-util.h:
- This header file that's included in the non-git projects can't use
`off_t` or `struct stat`.
- This header file can't assume that any types related to sockets are
available, because those come from <sys/socket.h> on Linux and from
winsock2.h on Windows.
- It can't assume that we have `NORETURN` (and it can't assume that we
don't need it), or `MAYBE_UNUSED`, or ...

Most of those issues _may_ be able to be resolved by having a
"gitlib-compat-util.h" file included at the top of the "external
project" .h file. But that's insufficient. Example:

#include <unistd.h>
#include "git/gitlib.h"  // Oops, the `#define _GNU_SOURCE` in the
transitive "gitlib-compat-util.h" has no effect!

Or the opposite:

#include "git/gitlib.h"  // Oops, this set _FILE_OFFSET_BITS=3D64 when
the project wasn't expecting it!
#include <unistd.h>  // For this translation unit only, `off_t` might
be a different size than elsewhere in the project, I hope you like
debugging segfaults.

The only ways I could come up with to solve these problems were to
hold the "external interface" to a different standard, that is
simultaneously both more permissive (it can assume C99), and
restrictive (it can't rely on things like off_t), and this makes it
incompatible with these external interfaces being used by the git
project itself, which has a broader set of platforms it needs to
support. But the external interfaces must be very simple wrappers
around code that _is_ shared with the git executable.

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
