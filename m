Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212213774D
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096146; cv=none; b=ot6C4D0l3lBjbyOmDFehK4HF8/5Q+/MLx/mmVIvbzrVlmiQWpsq1T9zzbtKMwkVB7he2NYUvzAdX9tkbgUELlsMqAE9NweLzpxzmLRjbNk9F8gitGR7Tv8XkI3x1gh+BOFCtq1OZ/fIwozLELDYFdDeh6Oql9Gnf6XVV3ka5ROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096146; c=relaxed/simple;
	bh=eOdBuzX55OgX7+OIch+/+/71aB00mQX3tAqGgt7nJCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvrIj9DkjdlTqBJCJ51u4tn0GhnVQCl/hv5OR1QknH+fL3pN6bfEh2a2mNcgqx9ZVcMPiKFeNYK6fCKoPt1jo6BFSUp5wUblyT3WN0Y+5UQaF2j+R0/KJW5JSiR3pBwF02ZsXDBHJRBgYWGsXJtvTfz2QQ/kcaj0OhKRXIIF8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=yjqQvpER; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="yjqQvpER"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6cdcc280c3so285549a12.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1761096144; x=1761700944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mznrpNE7uF2XWgQ2w5XYUxzGXmuA/nf99L0ieDUIGo=;
        b=yjqQvpERegfdAcYSCznEos6GQAegZUerm5SZNMxy3+hFXmX5mrKT4SQ1tNi74PNLGe
         of2tw4ZQWsBxicIwAkWNmphPINlBeJTTXh+CMl+DoOF2wVqYXIJthil8q+uWePOGdX0N
         dry2AZJ6U0RGBKIHUcU9L3Vb00wMGgbR/Y80fC3X3r43ABmsVVYOBSrPJXYYu/yoG55P
         1PzZlmLTqX6epAfstl/d7wOnCu8lb0CE2d0rAi8BTby2EHeLBryMLhcAEMOGoBwJ1VnS
         C/ljSi0hkV13l6iRjOpKX7hEGC3gXoM4EsZLhG9Rd2B4tP+0o5lDtvTKegS41bfTcF6d
         UCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761096144; x=1761700944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mznrpNE7uF2XWgQ2w5XYUxzGXmuA/nf99L0ieDUIGo=;
        b=L+ZwH8tbZmxjn2VnLf/sYuxJAKRQCNvfjo3oV5CDY2XtEBKYZe13TCLKu0xFlTjabO
         JszUieT8NrhzEaNRvKHWxnWgeUGPlL8s5S3ZHGFunWjEODlVHD/ZNj9BoTc8ch1VQt3D
         u87vAYsfEngMIWr9RnArKSrZ8KnA6LlD7kEiuBPYFZpUK88vaJgvOb2hfp+wjum/34GC
         J+NNLW7aWsraAV5cokw7EniUQo5c07fLT435ax+ay3WHgvlWzx9qXyelKkiFt6DaFzD3
         iQw9MgyMMPDtx2oXHzrThlOrL5ozYzj6Qj/7S4qKmGBmZDdB42DN+0Y/dl1EV19JjOYM
         P4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUQHx+RGDP0KTsJxWks3gTnKWl/P775z+z6QKo1zr3wiN3EZFPi42tn48OM0Y4hR6cE388=@vger.kernel.org
X-Gm-Message-State: AOJu0YycdiDt3uWSsX3eu0wNnmgJpCnJqia/QWGNYDwQx/qX22f0NeVz
	6zdfaBkRBshMUpDhn7q3aafDPm2uBu17NKxzq8JVZfps1uEneJ2BfrRmz4KIOx+ToEyfTFYvDre
	MLwRu3HFEIb07yaLpnRaLW0OB5TsrMeJn2NqNzEjXtNQRFBVu8hpl7ibsySvBl3GosKCdeP2eFO
	GqjeDbPo957Bge7feMNpw2Fu5LJkLdURvHdwFQ65z2Fs+YwhnfGY7V9eL+FcZAHCBINdXk0MFxN
	/5u8Jwk2W9YLs+cZ/qNzrlDG19yJ/v+0/ITxfF+R8uqzvd6DALoJQgMc0MJP3l38DUxYYG32Gxq
	7GpiYV5FWNm1nr0=
X-Gm-Gg: ASbGncsgmZlEkdJReKxkbVF1Mg0y7rv8pi/CWZxG3ItJQ6N6DOsG5STokPHxOn1v10d
	Gv0mfMlRbmI6L5uJZbuhB48OnAzpRhQvQzM/uOiblyYGEBaCk6seK9vwA06lZvunManfmB2ZHi4
	6ESAWSuliNV5yDStcWzbZQW3OBzbyPNs/xHtwYCscTaPlkHUf5L7cd9RfVWSJaQIcH1sQUxwYO7
	ZBU6YtvLOkzcaLiADnT9uGkrWnO2/r9of1AC2Q471eDuIx8IISeuqrXyqBzeGF3GuDCfSZy
X-Google-Smtp-Source: AGHT+IFgon9tefkXa2jBgLgl0IUfnpzo2JuXdQwd+7AYewK/9eMBFa6WKrmjwKkm8mLrZ9DOoZKzQ+0gGANeqVNlar8=
X-Received: by 2002:a17:902:d510:b0:25c:46cd:1dc1 with SMTP id
 d9443c01a7336-290ca216346mr232633725ad.33.1761096143710; Tue, 21 Oct 2025
 18:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1993.git.1760999702581.gitgitgadget@gmail.com> <20251021062621.GA370@tb-raspi4>
In-Reply-To: <20251021062621.GA370@tb-raspi4>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 22 Oct 2025 10:22:12 +0900
X-Gm-Features: AS18NWCp-Msu69GM4AEcZ6QVHquGwRuiajvyZ9HhC6JpoBdPISzAX-Yobt0kBlg
Message-ID: <CAOTNsDwFhCR67qx5aOFntOM3oAAXV4NDMfy_LC5VAYMu-o3uXg@mail.gmail.com>
Subject: Re: [PATCH] macOS: queue for munmap operations
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for detailed suggestions. As I discussed in another thread,
the root cause of many mmap/munmap calls was simply my ~/.gitconfig, so
I'm withdrawing this patch. I'll answer some of your comments below.

On Tue, Oct 21, 2025 at 3:26=E2=80=AFPM Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>
> Some comments inline, all up to improvements
>
> On Mon, Oct 20, 2025 at 10:35:02PM +0000, Koji Nakamaru via GitGitGadget =
wrote:
> > From: Koji Nakamaru <koji.nakamaru@gree.net>
> >
> > Executing many mmap/munmap calls alternately can cause a huge load on
> > macOS. In order to reduce it, we should temporarily store munmap
> > operations in a queue and process them all at once when the queue is
> > filled. When the program terminates, we can discard any remaining munma=
p
> > operations as corresponding mmaped regions are automatically reclaimed.
> >
> > Add a queue for munmap operations to perform them all at once.
> >
>
> Suggestions for rewording:
> In order to reduce the peak load store all munmap operations in a queue.
> Process them all at once (and more efficient) when the queue is filled.
> The queue may be ignored when the git process terminates. The operating
> system will do all munmap() when the process exits.

Thank you, it is much clear.

> > Here are some example timings. On the Linux kernel repository that
> > requires about 1700 mmap/munmap calls:
> >
> >   time git ls-tree -r -l --full-tree 211ddde > /dev/null
> >
> >   Before:
> >         real    0m2.083s
> >         user    0m0.201s
> >         sys     0m1.873s
> >
> >   After:
> >         real    0m0.243s
> >         user    0m0.179s
> >         sys     0m0.052s
> >
> > On a private repository that requires about 943000 mmap/munmap calls:
> >
> >   time git ls-tree -r -l --full-tree xxxxxxx > /dev/null
> >
> >   Before:
> >         real    27m15.138s
> >         user    0m5.084s
> >         sys     27m9.636s
> >
> >   After:
> >         real    0m24.209s
> >         user    0m3.055s
> >         sys     0m21.123s
> >
> > Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
> > ---
> >     macOS: queue for munmap operations
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1993%=
2FKojiNakamaru%2Ffeature%2Fosx-queued-munmap-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1993/Koj=
iNakamaru/feature/osx-queued-munmap-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1993
> >
> >  Makefile                            |  1 +
> >  compat/osxmmap.c                    | 49 +++++++++++++++++++++++++++++
> >  compat/posix.h                      |  7 +++++
> >  contrib/buildsystems/CMakeLists.txt |  4 +++
> >  meson.build                         |  2 ++
> >  5 files changed, 63 insertions(+)
> >  create mode 100644 compat/osxmmap.c
> >
> > diff --git a/Makefile b/Makefile
> > index f79c905bdc..058bc83753 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1654,6 +1654,7 @@ ifeq ($(uname_S),Darwin)
> >               COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
> >          endif
> >       PTHREAD_LIBS =3D
> > +     COMPAT_OBJS +=3D compat/osxmmap.o
> >  endif
> >
> >  ifdef NO_LIBGEN_H
> > diff --git a/compat/osxmmap.c b/compat/osxmmap.c
> > new file mode 100644
> > index 0000000000..5f9cf633ca
> > --- /dev/null
> > +++ b/compat/osxmmap.c
> > @@ -0,0 +1,49 @@
> > +#include <pthread.h>
> > +#include "../git-compat-util.h"
> > +/* We need original mmap/munmap here. */
> > +#undef mmap
> > +#undef munmap
> > +
> > +/*
> > + * OSX doesn't have any specific setting like Linux's vm.max_map_count=
,
> > + * so COUNT_MAX can be any large number. We here set it to the default
> > + * value of Linux's vm.max_map_count.
> > + */
> > +#define COUNT_MAX (65530)
>
> Why the parantheses ?
> And would a less generic name be better, like
> MAX_UNMAP_COUNT

The parentheses are not required but I prefer them as discussed in [1].
I agree MAX_UNMAP_COUNT is more clear.

> > +
> > +struct munmap_queue {
> > +     void *start;
> > +     size_t length;
> > +};
> > +
> > +void *git_mmap(void *start, size_t length, int prot, int flags, int fd=
, off_t offset)
> > +{
> > +     /*
> > +      * We can simply discard munmap operations in the queue by
> > +      * restricting mmap arguments.
> > +      */
> Should I read this as
> The munmap queue is only ment to defere read-only mappings.
> And that is what Git does at the moment.

Yes. This part is actually borrowed from compat/mmap.c and I've also
verified that the predicate is valid by searching all mmap calls.

> > +     if (start !=3D NULL || flags !=3D MAP_PRIVATE || prot !=3D PROT_R=
EAD)
> > +             die("invalid usage of mmap");
> > +     return mmap(start, length, prot, flags, fd, offset);
> > +}
> > +
> > +int git_munmap(void *start, size_t length)
> > +{
> > +     static pthread_mutex_t mutex;
> > +     static struct munmap_queue *queue;
> > +     static int count;
> > +     int i;
> > +
> > +     pthread_mutex_lock(&mutex);
> > +     if (!queue)
> > +             queue =3D xmalloc(COUNT_MAX * sizeof(struct munmap_queue)=
);
> > +     queue[count].start =3D start;
> > +     queue[count].length =3D length;
> > +     if (++count =3D=3D COUNT_MAX) {
> > +             for (i =3D 0; i < COUNT_MAX; i++)
> > +                     munmap(queue[i].start, queue[i].length);
> > +             count =3D 0;
> > +     }
> > +     pthread_mutex_unlock(&mutex);
> > +     return 0;
> > +}
> > diff --git a/compat/posix.h b/compat/posix.h
> > index 067a00f33b..3fa1218289 100644
> > --- a/compat/posix.h
> > +++ b/compat/posix.h
> > @@ -278,6 +278,13 @@ int git_munmap(void *start, size_t length);
> >
> >  #include <sys/mman.h>
> >
> > +#if defined(__APPLE__)
> I think it would be better to have a global Makefile knob here.
> Which
> a) allows to take out this patch once the MacOs kernel is improved
> b) allows to hook in this code for other OS
> Something like DEFER_MUNMAPS - better suggestions welcome

I followed your suggestion and adjusted code and Makefile, etc. (locally)

> > [snip]

[1] https://stackoverflow.com/questions/9081479/is-there-a-good-reason-for-=
always-enclosing-a-define-in-parentheses-in-c
