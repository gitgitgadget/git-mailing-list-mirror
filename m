Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DB4CE17
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072983; cv=none; b=UmUUz4/Re5tSH900GHxkLxnWGzdnB8pZNjoV6s5moHN1HFYgbKkwOgtaAawIsIPCjiamd4CS44C6n2/bUfK2kGBxSa+hiQ7rVFAWNn/QwabswQG/MMp/PFK2L9AdaAldLvJ/CCohke3+NJ4xOf54oP2/6SJJOoQNGOdh7aDUMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072983; c=relaxed/simple;
	bh=61pJURtrC5Djq85WSqth2yseOxibgYb1aVo50vYZ4gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGsYwlgNrKbK4fDT8+NHwlC6yGqco4DRRJYY8o4wETYAMD3akH0ZKsphg/wIutCj88tBjt8kNhW0xWcSw3PBntW6rnjcfko3nOiZeda+JdNbVnLkTvb+gFsWDAubQ81bEv+59RjdCqJI4dUlXEvwd/I3cl99UvosntmvCCPZl14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8/BzNnI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8/BzNnI"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so6652269a12.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709072980; x=1709677780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS4MrqZaFKUCYW9QP/4eI8hlXDXIKiX0H/aNVbgdF/E=;
        b=M8/BzNnI0HgbME7pTc5xqf3FcZGqK2UlKUYHiGW6V3xv4h3fgIsQanpaQ9HyBLg+c4
         DLHGLG+SFXYQSvOXT15Rg5662mJDVhwpLDcpzXgRvCmUppNR9A42WrDrGQi6Ifw9vPSs
         U/xG4Svs6f+CVXY61vGQbyMlipzgnMCiUM33rrE/J45aNN63hvcavuE3+v8a6rpFAzrm
         gULjiJD+QLQNTJkXRiqo5v8nAlgBeYB39HigEsaY3QTI+PjMs5t42Gsb6l+AQ0JiWlbq
         J5PeFhhuTZs9XYr0ZMkGlgJSoLWz0a9q7K2r18dCtg8K8jOq4ZO7kqXO9+zbbmsZj06d
         iTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072980; x=1709677780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS4MrqZaFKUCYW9QP/4eI8hlXDXIKiX0H/aNVbgdF/E=;
        b=vYbLEmW9q2iMCHjZ2/DFQTH+Jhs9i02sbgV+hoqDxE3Y/c53Zjf8JH2o5pi57lVfTL
         1GUSVmtV8IcvcIfLUzdNp+oY+4cCQtN5IPI/314EVapUJe+SHdDFKQrYYWh1m/erNbBZ
         VRnua69LnKVwDN1OoDcdiSA22aMnt8gfsX9qywsmAZcNxAhyd2k1RVG7PNWgfbOuWV8n
         jbcF/PhIe6kTQdO6Pyh8ZEiOMf9iCTmwoGQHTwN02+mqHMRP9ywlqa+SW4VK0Mncejtf
         J49Xx1UdCmCajWMsQ1b6TP+RfqjVDlPXRXPmTRVK5p5BanBV5fgpVDFJBwXf6/2+AJ3t
         MX7w==
X-Forwarded-Encrypted: i=1; AJvYcCV8ojRMvs127BbEgdRzQjqErPsUynGk417WEu1a8lJb+1QwAqADNtdQAAvmoO/QB1eTo8F+A2617sa5qFMCAGC6Qwqd
X-Gm-Message-State: AOJu0YznPKBSDYyWfXGVfYIjaf+23FFUpeBPjIMGd2n6D0YL0U0feIPS
	7s3SZ7I8qAG6//1Jh+p9fVEpD1MF2+ZnTDBGhkFTbMsviWwUgeR3KVOlkMf+MRQhnGAnS1UawlX
	S23XskGXnwTTt9XXDO7UsijHUOXDKrhbvKiB9
X-Google-Smtp-Source: AGHT+IFrnndImqajHfbOJzN5NR8UOxofHNRyFXlOIGJSTk5hsJrv8cJlynK0ZCSfLCHBAWHcBSNZDgg8umWmzOXsd2U=
X-Received: by 2002:a17:906:f0cb:b0:a3e:c2de:2b9e with SMTP id
 dk11-20020a170906f0cb00b00a3ec2de2b9emr6863968ejb.39.1709072979744; Tue, 27
 Feb 2024 14:29:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-2-calvinwan@google.com> <xmqqh6i0cgyo.fsf@gitster.g>
 <CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
 <xmqqle76iwqw.fsf@gitster.g> <CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>
 <xmqqzfvmhbfs.fsf@gitster.g>
In-Reply-To: <xmqqzfvmhbfs.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Tue, 27 Feb 2024 14:29:23 -0800
Message-ID: <CAO_smVgmaXvyZZ7zp6RCFD_6kpL2pHKC9gMDeg+yXBb9R4rR5w@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 6:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> >> In any case, your sources should not include a standard library
> >> header directly yourself, period.  Instead let <git-compat-util.h>
> >> take care of the details of how we need to obtain what we need out
> >> of the system on various platforms.
> >
> > I disagree with this statement. We _can't_ use a magic compatibility
> > header file in the library interfaces, for the reasons I outlined
> > further below in my previous message. For those headers, the ones that
> > might be included by code that's not under the Git project's control,
> > they need to be self-contained, minimal, and maximally compatible.
>
> Note that I am not talking about your random outside program that
> happens to link with gitstdlib.a; it would want to include a header
> file <gitstdlib.h> that comes with the library.

I agree with this.

>
> Earlier I suggested that you may want to take a subset of
> <git-compat-util.h>, because <git-compat-util.h> may have a lot more
> than what is minimally necessary to allow our sources to be
> insulated from details of platform dependence.  You can think of
> that subset as a good starting point to build the <gitstdlib.h>
> header file to be given to the library customers.
>
> But the sources that go to the library, as gitstdlib.a is supposed
> to serve as a subset of gitlib.a to our internal codebase when
> building the git binary, should still follow our header inclusion
> rules.

If I'm understanding this correctly, I agree with it. The .c files
still include <git-compat-util.h>, and don't change. The internal-only
.h files (ones that a pre-built-library consumer doesn't need to even
have in the filesystem) still assume that <git-compat-util.h> was
included, and don't change. <pager.h> falls into this category.

>
> Because we would want to make sure that the sources that are made
> into gitstdlib.a, the sources to the rest of libgit.a, and the
> sources to the rest of git, all agree on what system features we ask
> from the system, feature macros that must be defined to certain
> values before we include system library files (like _XOPEN_SOURCE
> and _FILE_OFFSET_BITS) must be defined consistently across all of
> these three pieces.  One way to do so may be to ensure that the
> definition of them would be migrated to <gitstdlib.h> when we
> separate a subset out of <git-compat-util.h> to it (and of course,
> we make <git-compat-util.h> to include <gitstdlib.h> so that it
> would be still sufficient for our in-tree users to include the
> <git-compat-util.h>)
>
> <gitstdlib.h> may have to expose an API function that uses some
> extended types only available by including system header files,
> e.g. some function may return ssize_t as its value or take an off_t
> value as its argument.

I agree that these types will be necessary (specifically ssize_t and
int##_t, but less so off_t) in the "external" (used by projects other
than Git) library interfaces.

>
> If our header should include system headers to make these types
> available to our definitions is probably open to discussion.  It is
> harder to do so portably, unless your world is limited to POSIX.1
> and ISO C, than making it the responsibility of library users.

I think I'm probably missing the nuance here, and may be making this
discussion much harder because of it. My understanding is that Git is
using C99; is that different from ISO C? There's something at the top
of <git-compat-util.h> that enforces that we're using C99. Therefore,
I'm assuming that any compiler that claims to be C99 and passes that
check at the top of <git-compat-util.h> will support inttypes.h,
stdint.h, stdbool.h, and other files defined by the C99 standard to
include types that we need in our .h files are able to be included
without reservation. To flip it around: any compiler/platform that's
missing inttypes.h, or is missing stdint.h, or raises errors if both
are included, or requires other headers to be included before them
_isn't a C99 compiler_, and _isn't supported_. I'm picking on these
files because I think they will be necessary for the external library
interfaces. I'm intentionally ignoring any file not mentioned in the
C99 standard, because those are platform specific. I acknowledge that
there may be some functionality in these files that's only enabled if
certain #defines are set. Our external interfaces should strive to not
use that functionality, and only do so if we are able to test for this
functionality and refuse to compile if it's not available. I have an
example with uintmax_t below.

>
> But if the platform headers and libraries support feature macros
> that allows you to tweak these sizes (e.g. the size of off_t may be
> controlled by setting the _FILE_OFFSET_BITS to an appropriate
> value), it may be irresponsible to leave that to the library users,
> as they MUST make sure to define such feature macros exactly the
> same way as we define for our code, which currently is done in
> <git-compat-util.h>, before they include their system headers to
> obtain off_t so that they can use <gitstdlib.h>.

I think the only viable solution to this is to not use these types
that depend on #defines in the interface available to non-git
projects. We can't set _FILE_OFFSET_BITS in the library's external
(used by non-Git projects) interface header, as there's a high
likelihood that it's either too late (external project #included
something that relies on _FILE_OFFSET_BITS already), or, if not, we
create the "off_t is a different size" problem for their code.

This means that we can't use off_t in these external interface headers
(and in the .c files that support them, if any). We can't use `struct
stat`. We likely need to limit ourselves to just the typedefs from
stdint.h, and probably will need some additional checks that enforce
that we have the types and sizes we expect (ex: I could imagine that
some platforms define uintmax_t as 32-bit. or 128-bit. Either we can't
use it in these external interfaces, or we have to enforce somehow
that the simplest file we can imagine (#include <stdint.h>) gets a
definition of uintmax_t that is the exact same as the one we'd get if
we included <git-compat-util.h>). The external interface headers don't
need to be as platform-compatible as the rest of the git code base,
because not every platform is going to be a supported target for using
the library in non-git projects, especially at first. The external
interface headers _do_ need to be as tolerant and well behaved as
possible when being included by external projects, which I'm asserting
means they need to be self-contained and minimal. If that means these
external interfaces don't get to use off_t at all, so be it. If it
means they can only be included if sizeof(off_t) =3D=3D 64, and we have a
way of enforcing that at compile time, that's fine with me too. But we
can't #define _FILE_OFFSET_BITS ourselves in this external interface
to get that behavior, because it just doesn't work.

I'm making some assumptions here. I'm assuming that the git binary
uses a different interface to a hypothetical libgitobjstore.a than an
external project would (i.e. that there'd be some
git-obj-store-interface.h that gets included by non-Git projects, but
not by git itself). Is git-std-lib an obvious counterexample to this
assumption? Yes and no. No one (besides Git itself) is going to
include libgitstdlib.a in their project any time soon, so there's no
real "external interface" to define right now. Eventually, having
git-std-lib types in the hypothetical git-obj-store-interface.h _may_
happen, or it may not. I don't know.

...

But I think we're in agreement that pager.h isn't part of
git-std-lib's (currently undefined/non-existent) external interface,
and so doesn't need to be self-contained, and this patch should
probably be dropped?
>
> So the rules for library clients (random outside programs that
> happen to link with gitstdlib.a) may not be that they must include
> <git-compat-util.h> as the first thing, but they probably still have
> to include <gitstdlib.h> fairly early before including any of their
> system headers, I would suspect, unless they are willing to accept
> such responsibility fully to ensure they compile the same way as the
> gitstdlib library, I would think.
>
>
>
