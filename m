Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C6BC433E1
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 02:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE10F20757
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 02:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhfGTWod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgFCCkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCCkG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 22:40:06 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FDDC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 19:40:05 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x17so214361oog.6
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 19:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueUbOxOe06NPQFbWGXoFrW/sktiX95WCMAQsvPUGXrI=;
        b=IhfGTWodfOv+dqoSR03NHh4uPX4EO6kNvAUvMEDePodBm1Ovf2dR1e7Y/k1ATbYThr
         D0BGuPf4foYtXj2JsxGm5VsiCAACoBqEEMc7UmaqvmTsguVMZuzE2dHq+wd+H3jagscE
         d6M0jTj3n3SaojALe+4yoANo9FhY4+icw+WGWY2xmiEY2QNu1T7LKIr9Lz9ewNosa39V
         78eKf3WShCZgHrDKgPqGdxZZocQp3V7Jslfp6CXBnD2Y9SSfzzI2xIVbWcO1PDPLHunX
         QFpzgunHo2LqRsMG4sB20VoTN75KWjDVEnYOPuFpxRJCP0r3aYxysNLQkQ1/zSgaqY69
         wMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueUbOxOe06NPQFbWGXoFrW/sktiX95WCMAQsvPUGXrI=;
        b=DmXjPmhi9plBaphhSwNIMkM1waVglCHZdTQFWic9p0sdCIAeaBYq6+aNWNap6Eiirq
         l6ak185t7qKi6QMwhBXACJ4fph11UZcOt5hkOCh6pr9htWoL5VXNlUJ6+oK2jtdPB199
         R8Wgq4OooNJIrmGTDrpHSL+3Ns01u9bEfZ1owQASKoYU/pUIUphfoJSl4lqJEFfZwEmv
         PJn+yPU6QVQp4TYNOQCoC89mNu0qEMT3VEfZ1bgEOoFKgGGqh2VEoWEiv7TNftRdYCCh
         ftyKwR65W6SbEnQZJTf8O59OTMCsFsfii4v7q1O5FARvdgKpSWis3xZ2LFeH6YEdOR3L
         2Kgg==
X-Gm-Message-State: AOAM532kRfMfAQScRH2yhUEhPok/lPtscHgGzN1UZW2HRNzBPFnzlQzR
        2NkuZ8rUGFL5PDt/GqrXkVMsgMCiMiYjuTnW87I=
X-Google-Smtp-Source: ABdhPJxzREUVFWCH7bLUmuTp5YdhcDrw8L96VPBFHDmRfr134XPN1yrmmk6FJ0BbbG2wSZqERAeCqjxHXeiigW4B8t4=
X-Received: by 2002:a4a:8688:: with SMTP id x8mr9679550ooh.7.1591152004823;
 Tue, 02 Jun 2020 19:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <748b1e955ccdcf7cd897a180f4b4fe82d7bfcf00.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BHzHhBVGZ+vOgE4jTCT3HJzXo+gzZ+6SVGDUWWdfkL6Dw@mail.gmail.com> <CAHd-oW7b41hqfPXm_GL_sth+QRfx56ceMr4VM9B9xhj3_P9iGQ@mail.gmail.com>
In-Reply-To: <CAHd-oW7b41hqfPXm_GL_sth+QRfx56ceMr4VM9B9xhj3_P9iGQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Jun 2020 19:39:53 -0700
Message-ID: <CABPp-BH0d5WKz7bXLkFQGDBKXbd0tccS_+1_iNc1Wqr93h+KaQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] config: add setting to ignore sparsity patterns in
 some cmds
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 31, 2020 at 9:46 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Sat, May 30, 2020 at 1:18 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Wed, May 27, 2020 at 6:14 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> > > diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
> > > new file mode 100644
> > > index 0000000000..2a25b4b8ef
> > > --- /dev/null
> > > +++ b/Documentation/config/sparse.txt
> > > @@ -0,0 +1,24 @@
> > > +sparse.restrictCmds::
> > > +       Only meaningful in conjunction with core.sparseCheckout. This option
> > > +       extends sparse checkouts (which limit which paths are written to the
> > > +       working tree), so that output and operations are also limited to the
> > > +       sparsity paths where possible and implemented. The purpose of this
> > > +       option is to (1) focus output for the user on the portion of the
> > > +       repository that is of interest to them, and (2) enable potentially
> > > +       dramatic performance improvements, especially in conjunction with
> > > +       partial clones.
> > > ++
> > > +When this option is true (default), some git commands may limit their behavior
> > > +to the paths specified by the sparsity patterns, or to the intersection of
> > > +those paths and any (like `*.c`) that the user might also specify on the
> > > +command line. When false, the affected commands will work on full trees,
> > > +ignoring the sparsity patterns. For now, only git-grep honors this setting. In
> > > +this command, the restriction takes effect in three cases: with --cached; when
> > > +a commit-ish is given; when searching a working tree where some paths excluded
> > > +by the sparsity patterns are present (e.g. manually created paths or not
> > > +removed submodules).
> >
> > I think "In this command, the restriction takes effect..." to the end
> > of the paragraph should be removed.  I don't want every subcommand's
> > behavior to be specified here; it'll grow unreadably long and be more
> > likely to eventually go stale.
>
> Yeah, I was also concerned about that. But wouldn't it be important to
> inform the users how the setting takes place in grep (specially with
> the corner cases)? And maybe others, in the future?
>
> What if we move the information that is only relevant to a single
> command into its own man page? I.e. git-grep.txt would have something
> like:

Moving it to grep's manpage seems ideal to me.  grep's behavior should
be defined in grep's manual.

> sparse.restrictCmds::
> See complete definition in linkgit:git-config[1]. In grep, the
> restriction takes effect in three cases: with --cached; when a
> commit-ish is given; when searching a working tree where some paths
> excluded by the sparsity patterns are present (e.g. manually created
> paths or not removed submodules).

That looks more than a little confusing.  Could this definition be
something more like "See base definition in linkgit:git-config[1].
grep honors sparse.restrictCmds by limiting searches to the sparsity
paths in three cases: when searching the working tree, when searching
the index with --cached, or when searching a specified commit"

> The only problem then is that the information would be a little
> scattered... But I think it shouldn't be a big deal, as a person
> interested in knowing how foo behaves with sparse.restrictCmds would
> only need to look into foo's man page, anyway.
>
> > > diff --git a/git.c b/git.c
> > > index a2d337eed7..6db1382ae4 100644
> > > --- a/git.c
> > > +++ b/git.c
> > > @@ -319,6 +324,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> > >                 (*argv)++;
> > >                 (*argc)--;
> > >         }
> > > +
> > >         return (*argv) - orig_argv;
> > >  }
> > >
> >
> > Why the stray whitespace change?
>
> Oops, that shouldn't be there. Thanks!
>
> >
> > > diff --git a/sparse-checkout.c b/sparse-checkout.c
> > > new file mode 100644
> > > index 0000000000..9a9e50fd29
> > > --- /dev/null
> > > +++ b/sparse-checkout.c
> > > @@ -0,0 +1,16 @@
> > > +#include "cache.h"
> > > +#include "config.h"
> > > +#include "sparse-checkout.h"
> > > +
> > > +int restrict_to_sparse_paths(struct repository *repo)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (opt_restrict_to_sparse_paths >= 0)
> > > +               return opt_restrict_to_sparse_paths;
> > > +
> > > +       if (repo_config_get_bool(repo, "sparse.restrictcmds", &ret))
> > > +               ret = 1;
> > > +
> > > +       return ret;
> > > +}
> >
> > Do we want to considering renaming this file to sparse.c, since it's
> > for sparse grep and sparse diff and etc., not just for the checkout
> > piece?  It would also go along well with our toplevel related config
> > being in the "sparse" namespace.
>
> Makes sense. But since Stolee is already working on
> "sparse-checkout.c" [1], if we use "sparse.c" in this series we will
> end up with two extra files. And as "sparse.c" is quite small, I think
> we could unify into the "sparse-checkout.c".
>
> [1]: https://lore.kernel.org/git/0181a134bfb6986dc0e54ae624c478446a1324a9.1588857462.git.gitgitgadget@gmail.com/

Or we could just suggest he use sparse.c too.  :-)

Stolee?


> > > diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> > > index ce080cf572..1aef084186 100755
> > > --- a/t/t7817-grep-sparse-checkout.sh
> > > +++ b/t/t7817-grep-sparse-checkout.sh
> >
> > All these testcases look great (modulo the small typo I pointed out
> > earlier); I kept thinking "but what about case <x>?" and then I kept
> > reading and saw you covered it.  You even added some I wasn't thinking
> > about and might have overlooked but seem important.
>
> Thanks :)
