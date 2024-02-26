Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082F1E866
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973997; cv=none; b=JzmEAb8LU2R7KEB8Z5hPgys1kLrVusObqGpDo8CirBs6A5p54kyRnUd/7Epj2MDGHDNkFHlA+iKtRFbbXxHSPRL1TiOlOUiRP0l0Muln314xZZCUrdYr5GCJ8CHhZbXBLgZe/xczZ6DlwUUD7MT2r1shk9QGIdrEybZcuPs7fbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973997; c=relaxed/simple;
	bh=rfN5KRAsAO/JaTz/tDxl8o0Yy8vQZT4Jj+x/m29NkxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkubSDcpQhIKAtUMLRPd+tpkGvlMsFeNfifHRQ+Il4d3Ak2e/Yh/LL+iXSIoqcznGQuRJMsCe+Q0WZ2DZ/SXYDf4Aw15Kj/+I3FnHK0OXA2NM3GRD8rzwFw+unHgtX1fdOV82YuKuNwAwL6fO/g9WZsgTTADuHuLuzPyvYlTgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M27fCbhI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M27fCbhI"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so5290567a12.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708973994; x=1709578794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUTgBTPLdsOFWknCGoQyPfEezTUnPXuVgZ+fvfXvEDs=;
        b=M27fCbhIYRqZZRmhUouuGLzKfaPzlDK5mlTgSfH6FHHsK+JChrB++QKb/cmKBSxN1j
         Qs/J0NJ0DpFUp7NYyNRGZvn2cdjVbE3du3argVcy3YAgZ+7n7EdsA6++9IeJnKr7oglE
         EA05IrSCKKJFdV6B6F23I9wZLsH2NN5QInEniNO0omr1Ka4I/rTnvMXPQ3/Tb74kGwXg
         HBNa+vXx3eB52685WNBrSow+ATTtB81UgZL8raw5lOuCDnlHKKtvpeGRIkbSJRdiOcDz
         WFa7f4YRd5EgqZLbfwkXKYOtwH2JqBj3jHvA4Pacw3Dx3uLD088tWI66EwJJ226wHwfG
         FW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708973994; x=1709578794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUTgBTPLdsOFWknCGoQyPfEezTUnPXuVgZ+fvfXvEDs=;
        b=lc5+85lB45k+ypB8hUdoniXUGJIjrUj73T+5SAL9wj7zso+VSxh/K3ADNwDTE+zF4k
         brHz2iGrFV0nZ8U/PrirR3LWY1xRNs6VTOhbzXo+nUanGpboyO2MKTs+olLpU1R9qlNe
         Gk8S10P00SyYrG2wRZ5ffjagRPJR0Da7lRifG3dZVx5LqqlY8ZOqcmIIPyO1oVHT7qSb
         ajCjfyZ2N2DR2TPxwmZ+eHKUUL6Jt0TNapFMW7nIllogbgdPG3pWP/1dr1Ka6QT4lCXJ
         nHUI8fy9OCvItt5QExSRokgRyOJVTnNF+ErnBDbA6dSIGjOORLTpzw8s5ZMkJL3Ye14/
         O7xw==
X-Forwarded-Encrypted: i=1; AJvYcCUdilBCnYBrOlDfIco9MCVOaAtLM+1BObaPb21GBjYCh1dvQzFP0SLxqEfJtbTUpmRmQPvuSAuQ36chVu3Vj3DLCLxe
X-Gm-Message-State: AOJu0YzhzXuQQBmDwiNKTVSRSl2PMXl/fCFAMZIddnHAXYuobDvIiUio
	Z87x+5Q2hH2LtX7FU7QVe+2ySi9QEXBVoaHWdkQrD9dHw/v7LDLJiayZvpE0hN/0hbAVS5iLTWT
	VJe8owJZbfDAhRF5B+9nlKHTWV8PIfuvaz/zLXviv+z5tMkBayQ==
X-Google-Smtp-Source: AGHT+IGsCBCpteyEY62Y6RzZzVQD05mmhk0ugeJ1QqlGI/f+ydE1aYI8wr4TE+GAeZDM5enh4CAJ67NhpLkz4TMavQc=
X-Received: by 2002:a17:906:5794:b0:a43:3c20:8682 with SMTP id
 k20-20020a170906579400b00a433c208682mr2832932ejq.73.1708973993757; Mon, 26
 Feb 2024 10:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-2-calvinwan@google.com> <xmqqh6i0cgyo.fsf@gitster.g>
In-Reply-To: <xmqqh6i0cgyo.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 26 Feb 2024 10:59:38 -0800
Message-ID: <CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > From: Jonathan Tan <jonathantanmy@google.com>
> >
> > pager.h uses uintmax_t but does not include stdint.h. Therefore, add
> > this include statement.
> >
> > This was discovered when writing a stub pager.c file.
> >
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > ---
> >  pager.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/pager.h b/pager.h
> > index b77433026d..015bca95e3 100644
> > --- a/pager.h
> > +++ b/pager.h
> > @@ -1,6 +1,8 @@
> >  #ifndef PAGER_H
> >  #define PAGER_H
> >
> > +#include <stdint.h>
> > +
> >  struct child_process;
> >
> >  const char *git_pager(int stdout_is_tty);
>
> This is not going in a sensible direction from our portability
> standard's point of view.
>
> The reason why we do not include these system headers directly to
> our source files, and instead make it a rule to include
> <git-compat-util.h> as the first header instead, is exactly because
> there are curiosities in various platforms that Git wants to run on
> which system include headers give us the declarations for types and
> functions we rely on, in what order they must be included, and after
> what feature macros (the ones that give adjustment to what the
> system headers do, like _POSIX_C_SOURCE) are defined, etc.
>
> Given that in <git-compat-util.h>, inclusion of <stdint.h> is
> conditional behind some #ifdef's, it does not look like a sensible
> change.  It is not very likely for <inttypes.h> and <stdint.h> to
> declare uintmax_t in an incompatible way, but on a platform where
> <git-compat-util.h> decides to include <inttypes.h> and use its
> definition of what uintmax_t is, we should follow the same choice
> and be consistent.

Speaking of this specific header file inclusion and the oddities that
have gotten us to where we are:
- Originally, it seems that we were including stdint.h
- 17 years ago, to work around Solaris not providing stdint.h, but
providing inttypes.h, it was switched to being just inttypes.h, with
the explanation being that inttypes is a superset of stdint.
https://github.com/git/git/commit/007e2ba65902b484fc65a313e54594a009841740
- 13 years ago, to work around some platforms not having inttypes.h,
it was made conditional.
(https://github.com/git/git/commit/2844923d62a4c408bd59ddb2caacca4aa7eb86bc=
)

The condition added 13 years ago was, IMHO, backwards from what it
should have been. The intent is to have stdint.h included. We should
include stdint.h. I suspect that 17 years is enough time for that
platform to start conforming to what is now a 25 year old standard,
and I don't know how we can verify that and have this stop being a
haunted graveyard without just trying it and seeing if the build bots
or maintainers identify it as a continuing issue. If it's still an
issue (and only if), we should reintroduce a conditional, but invert
it: if there's no stdint.h, THEN include inttypes.h.

Oh, no, that doesn't work. I tried that, and the build bots told me
that doesn't work, because we're using things from inttypes.h (PRIuMAX
showed up several times in the errors, there may be others). This
makes me wonder how the platforms with no inttypes.h work at all. I
still think we should do something here because it's a 13-year-old
compatibility fix that "shouldn't" be needed anymore, and causes
confusion/concerns like this thread. Maybe just see if we can get away
with always including inttypes.h in git-compat-util.h, or maybe _both_
inttypes.h and stdint.h (in either order), just to be really obvious
that it's acceptable to include stdint.h.

>
> If there is a feature macro that affects sizes of the integer on a
> platform, this patch will break it even more badly.  Perhaps there
> is a platform whose C-library header requires you to define a
> feature macro to use 64-bit, and we may define that feature macro
> in <git-compat-util.h> before including either <inttypes.h> or
> <stdint.h>, but by including <stdint.h> directly like the above
> patch does, only this file and the sources that include only this
> file, refusing to include <git-compat-util.h> as everybody in the
> Git source tree should, will end up using different notion of what
> the integral type with maximum width is from everybody else.

I agree that for pager.h, something like the patch in your next email
would resolve that particular problem. The stub library is of
basically the same stature as git-std-lib: it's code that is provided
by the Git project, compiled by Makefile rules owned and maintained by
the Git project, and should conform to the Git coding standards. The
.c files in the stubs library should include git-compat-util.h,
there's basically no reason not to.

However, I believe that we'll need a good policy for what to do with
libified headers + sources in general. I can see many potential
categorizations of source; there's no need to formally define all of
them and assign files to each category, but the main categories are
basically:
1. files that have code that is an internal part of Git, one of the
helper binaries, or one of its tests, whether it's a library or not.
These should include git-compat-util.h at the top of the .c files like
they do today. The .h files for these translation units are also
considered "internal". These header files should assume that
git-compat-util.h has been included properly, and don't need to be
self-contained, because they're _only_ included by things in this
category.
2. files that have code that define the "library interface", probably
only the ones defining the library interface _as used by external
projects_. I think that we'll likely need to be principled about
defining these, and having them be as minimal and compatible as
possible.
3. code in external projects that directly uses libraries from the Git
project, and thus includes Git headers from category 2
4. the rest of the code in external projects (the code that does not
directly use libraries from the Git project)

A hypothetical git-compat-core.h being included at the top of the .c
files in category 2 is feasible, but needs to be carefully handled due
to potential symbol collision (which we're discussing in another
thread and I may have a possible solution for, at least on some
platforms). On the other hand, a git-compat-core.h being included at
the top of the .h files belonging to category 2 doesn't work, because
when these .h files are included by code in category 3, it's too late.

In this example, gnu-source-header.h below is a system header that
changes behavior depending on _GNU_SOURCE (effectively the same
concern as you were raising in the quoted paragraph):

external-project-category3.c:
#include <stdint.h>
#include <gnu-source-header.h>
#include <git/some-lib-interface.h>

git/some-lib-interface.h:
#include <git/git-compat-core.h>

We can't do anything in git/git-compat-core.h that relies on careful
inclusion order, requiring that various things are #defined prior to
the first inclusion of certain headers, etc. stdint.h and
gnu-source-header.h are already included, and so it's too late for us
to #define things that change their behavior, because that won't have
any effect. I don't think it's reasonable to expect the external
project to #include <git/git-compat-core.h> at the top of their files
that are in category3. It's definitely not reasonable to require the
external project to do that for all their files (category 3 and
category 4). It's slightly more reasonable to have them do some set of
#defines for their binaries and libraries, but still quite awkward and
potentially not feasible (for things like _FILE_OFFSET_BITS). This is
why I split it into 4 categories.

I believe that category 2 files need to be maximally compatible, both
to platforms [where we provide support for libraries, and I think this
probably will end up being a subset of all the platforms, especially
at first] and to the environment they're being #included in and
interacting with. So they need to be self-contained: they can't rely
on stdint.h having been included, but they also can't rely on it _not_
having been included already. The category 2 .h files need to be
minimal: just what we want in this external library interface, and
ideally nothing else. The category 2 .h and .c files need to be
compatible with common #defines being set OR not set. The point of a
category 2 .c file is to bridge the gap between the category 1 and
category 3 environments. This likely means that we need to be careful
about certain structs and typedefs defined by the system (vs. structs
defined by the category 2 headers themselves) being passed between the
different environments. For example, if we were to have a library
interface that included a `struct stat`, and the category 3 files
didn't have _FILE_OFFSET_BITS 64, but the category 1 files do? Instant
breakage.

This aspect of this discussion probably should happen on the next
patch, or in a separate thread :) But since I'm here, I'll summarize
these thoughts: basically, the next patch, imho, doesn't go far
enough, but is a very good first step that we can build on. We need to
define what belongs to the "external interface" of the various
libraries (category 2 above) and what is considered category 1.
pager.h is pretty obviously category 1. strbuf.h, abspath.h, etc? I'm
not sure. git-std-lib is weird, because it's so low level and there's
not really much "internal" code to this library. So maybe we declare
those as category 2. But I don't know how that will actually work in
practice. I'll try to find time to write up these thoughts on that
patch.

>
> What this patch _wants_ to do is of course sympathizable, and we
> have "make hdr-check" rule to enforce "a header must include the
> headers that declare what it uses", except that it lets the header
> files being tested assume that the things made available by
> including <git-compat-util.h> are always available.
>
> I think a sensible direction to go for libification purposes is to
> also make sure that sources that are compiled into gitstdlib.a, and
> the headers that makes what is in gitstdlib.a available, include the
> <git-compat-util.h> header file.  There may be things declared in
> the <git-compat-util.h> header that are _too_ specific to what ought
> to be linked into the final "git" binary and unwanted by library
> clients that are not "git" binary, and the right way to deal with it
> is to split <git-compat-util.h> into two parts, i.e. what makes
> system services available like its conditional inclusion of
> <stdint.h> vs <inttypes.h>, definition of feature macros, order in
> which the current <git-compat-util.h> includes system headers, etc.,






> excluding those that made you write this patch to avoid assuming
> that the client code would have included <git-compat-util.h> before
> <pager.h>, would be the new <git-compat-core.h>.  And everything
> else will remain in <git-compat-util.h>, which will include the
> <git-compat-core.h>.  The <pager.h> header for library clients would
> include <git-compat-core.h> instead, to still allow them to use the
> same types as "git" binary itself that way.
>
>
>
>
>
>
