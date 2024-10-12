Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304B146D5A
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728776507; cv=none; b=rEDiWwc9XpMNLY4VwXlHjnKVFNX3EVdFdrOgIczxFP6Nx1XMHn4Cd7e5415wt7hg47W0mtTIFWs80p0K+bkZvCPDl/WwGB+IOq2YCWv9GdrmY72ToYVzBm5oLp4XNrELi9tJd6HTUn7vQldP8tf8dcS6F3h/B0YIiBvrpedeCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728776507; c=relaxed/simple;
	bh=LcxOue4JsbQv/6DFD/4f/HdvHL9hx1VAK3Z5SVyV3FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkAM5249rSqYsQ8Tf9IJaKu7XQPcZ8wzSx/gpQ7WgVLvLHP8njkdYjJNyEYTHLS5zq0bqs5UL4nePQSWCinYuwNa5lHDSiIIozCC7RypC4QYDmEc9xwHGTlm8Z1vvDm4rBWMd9u04Zaf0zuHu6AotvnmeernrPaTlYp/Hzk02BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=willfris.nl; spf=pass smtp.mailfrom=willfris.nl; dkim=pass (1024-bit key) header.d=willfris.nl header.i=@willfris.nl header.b=Z6egwSKY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=willfris.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willfris.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=willfris.nl header.i=@willfris.nl header.b="Z6egwSKY"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso2151053a91.3
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=willfris.nl; s=auth; t=1728776503; x=1729381303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BoW32o9+Miy90pu1d5yO/3QEzI/jsP+JurZ85r1lzw=;
        b=Z6egwSKYsIRu/d2x6MHoGwaVCL69AriekmlGSIGPj5SIKiy9Pq4CRoOuPK0XkfS3Kr
         hEpQ+R769NZLdyWjeGnwl5XLeqFyO7DbjyvJYRY+PoggzG8Uq6ksSmTYVUv+Tz+B+UDH
         FThH1xXKik1tATodFhywppw65t7mmEiwdFDmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728776503; x=1729381303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BoW32o9+Miy90pu1d5yO/3QEzI/jsP+JurZ85r1lzw=;
        b=DLGNIFxRbatYnqXZs7SZsDbpUTHgK05hgfoQr9mqI5WgApOWGtCP59VXdbHs2HZyYK
         VZyGjvTrxIqMABbQbPuvjfxphx6AjI/3ZKRW0renXHjQI9XWrvnTvsseFYldDmFs4HOx
         qJPqTbkhfjMJyIs9hJ9KUFWNtF4W0blDU3i0Qb/Wqi22bt+tc/64nWp6RRpB1m/LrS3Q
         6JUVtiWEH2OqModTAiWYxctZ+C3KV6vp+WpE6uYGKc5rO8+39cTvcCa9OtYNV/4/DQ8m
         0ov0tLgQiMKnu2rNSl/LHh9NdIdcHRvIwRSoQHdQbB+k9aK6ZrIBq6Wjb2DS8ImcHnrF
         Dtbg==
X-Gm-Message-State: AOJu0YzwtFgyL9Nidme68mwfZsDOxBq3/pk/jgF202Wxkf6b6Q72qEBm
	oZ6wU7TcEDbyxrDOwxazwul5uaCiojUHM/bvacl+89aIApPrceZw8q5PeJRlSUR8Y6uU2CI4htT
	O2wmvBxDq1P9mxleJFlHyPhLraw/02Ql8QlZEtSJ+SaW713Sv60I=
X-Google-Smtp-Source: AGHT+IG08KCTiIYpK6lkngYIOWFDPgLzknHpq5GGUE2Vu+BqgxgfBbjd9PbcQmZQftozX9vRUazqj0WoTHObqkPWvHY=
X-Received: by 2002:a17:90a:5588:b0:2e2:d3e1:f863 with SMTP id
 98e67ed59e1d1-2e2f0a49376mr8519705a91.12.1728776502933; Sat, 12 Oct 2024
 16:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
 <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com> <20241012205506.GA55242@coredump.intra.peff.net>
In-Reply-To: <20241012205506.GA55242@coredump.intra.peff.net>
From: =?UTF-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>
Date: Sun, 13 Oct 2024 01:41:06 +0200
Message-ID: <CABOUa4bqPiUM+=6dxW5TTHOdMzXiFD02vWoVJcgAQDhZs8DoXg@mail.gmail.com>
Subject: Re: [PATCH v3] diff-highlight: make install link into DESTDIR
To: git@vger.kernel.org
Cc: =?UTF-8?Q?imme=C3=ABmosol_via_GitGitGadget?= <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending this mail to the list 'cause mail-client added html to previous m=
ail.

On Sat, 12 Oct 2024 at 22:55, Jeff King <peff@peff.net> wrote:
>
> On Sat, Oct 12, 2024 at 08:23:33PM +0000, imme=C3=ABmosol via GitGitGadge=
t wrote:
>
> > diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/M=
akefile
> > index f2be7cc9243..a53e09e0bdd 100644
> > --- a/contrib/diff-highlight/Makefile
> > +++ b/contrib/diff-highlight/Makefile
> > @@ -10,6 +10,9 @@ diff-highlight: shebang.perl DiffHighlight.pm diff-hi=
ghlight.perl
> >       chmod +x $@+
> >       mv $@+ $@
> >
> > +install: diff-highlight
> > +     test -w $(DESTDIR) && ln -s $(abspath $<) $(DESTDIR)
> > +
>
> I'm not opposed to having an install target here, like we do in the main
> Makefile and in a few other contrib directories.
>
> But in that case, I think it should behave more like those other
> targets:
>
>   1. Actually copy the program rather than making a symlink. Preferably
>      using $(INSTALL).
>
>   2. Respect $(prefix) in the usual way.
>
> And also...
>
> >  clean:
> > +     test ! -L $(DESTDIR)/diff-highlight || \
> > +             $(RM) -f $(DESTDIR)/diff-highlight
> >       $(RM) diff-highlight
>
>   3. It's unusual for "clean" to reach outside of the build directory.
>      What you're doing here is more like an "uninstall" target, but we
>      don't usually provide one.
>
> There are a few different approaches other contrib/ items take to
> work like the rest of the Git:
>
>   - in contrib/contacts, we source config.mak from the top-level, and
>     then define a default $(prefix). This gives some repeated
>     boilerplate, but is pretty independent from the top-level Makefile.
>
>   - in contrib/credential/netrc, we piggy-back on the top-level
>     Makefile's "install-perl-script", which knows where the user has
>     asked us to install things. That might not be appropriate here,
>     though, as I think it only puts things in libexec/, so
>     "diff-highlight" wouldn't be generally available in the user's $PATH
>     (though it would be enough to use as a pager within git).
>
> -Peff

As mentioned, `contrib/diff-highlight` is less like other perl contribs
like `contrib/contacts` and `contrib/credential/netrc`, those two seem to
be git subcommands (`git-*`) where diff-highlight is more of a "standalone"
command.

My usecase was to peek at what the command does by making it available in a
`$PATH` writable by a non-root user. (Much like what is mentioned in
`contrib/diff-highlight/README#Use`: `git log -p --color | diff-highlight`.=
=3D
)

```sh
echo '# Given ~/.local/bin is in $PATH,'
( export DESTDIR=3D3D"${HOME?}/.local/bin/" ; make linked-in-destdir )
echo '# In another already open shell, try suggestion from readme.'
( export DESTDIR=3D3D"${HOME?}/.local/bin/" ; make clean )
```

Thanks to all of you for the introduction into how contributions to git/git
are handled.
Though it has been quite an informative introduction, and i can understand
the suggestion of making it a install-target like other contrib-parts, i am
currently not spending more time on this. Thanks again, and have a good day=
=3D
.

---
Make git's diff-highlight program immediately available to the command-line=
=3D
.
Create a link in DESTDIR that
refers to the generated/concatenated diff-highlight perl script

Signed-off-by: imme=3DC3=3DABmosol <will+developer@willfris.nl>
---
 contrib/diff-highlight/Makefile | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/Makefile
b/contrib/diff-highlight/Makefile
index f2be7cc9243719..84f6e65c730380 100644
--- a/contrib/diff-highlight/Makefile
+++ b/contrib/diff-highlight/Makefile
@@ -10,6 +10,11 @@ diff-highlight: shebang.perl DiffHighlight.pm
diff-highlight.perl
     chmod +x $@+
     mv $@+ $@

+linked-in-destdir: diff-highlight
+    test -n "$(DESTDIR)" && \
+        test -w $(DESTDIR) && \
+        ln -s $(abspath $<) $(DESTDIR)
+
 shebang.perl: FORCE
     @echo '#!$(PERL_PATH_SQ)' >$@+
     @cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@
@@ -17,7 +22,13 @@ shebang.perl: FORCE
 test: all
     $(MAKE) -C t

-clean:
+unlink-from-destdir:
+    test -z "$(DESTDIR)" || \
+        test ! -L $(DESTDIR)/diff-highlight || \
+        $(RM) $(DESTDIR)/diff-highlight
+
+clean: unlink-from-destdir
     $(RM) diff-highlight

 .PHONY: FORCE
+.PHONY: linked-in-destdir unlink-from-destdir
