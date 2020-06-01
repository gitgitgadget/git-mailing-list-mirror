Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C8C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5F2206E2
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="jlHMln4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAEqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAEqM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 00:46:12 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228A1C061A0E
        for <git@vger.kernel.org>; Sun, 31 May 2020 21:46:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c11so6491854ljn.2
        for <git@vger.kernel.org>; Sun, 31 May 2020 21:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spfz70KsmaWfJPZhaux40i6S/dssFm/wRaPyqLciHLI=;
        b=jlHMln4wUeyv9f64J5yja4kNXS+6TRx2nqDaipCY/jZRIP486LVZIx3xVMTtMijvwa
         MsP1yn0uXRGC2ziZcs1N09qLw2l2JzRGI2gDg3TyqQ7QVgdTbpUOZ/6xUoeR3TPj6Se1
         dkAtw4RQyi/+DWksf+PvmeUcFqqT1R3hrtvJ6HshxO47/vjWwx5lnSzW8P8e+403jmBH
         SHIbQeFsXRm6RWTfDvcjwqdQiooAFmK6vtKGmY6o+weR0lM6zG0Z8aXV+O98ipN1MUJ6
         P4AmZmxYbjkvczUL/ha3Aja1rTRIsatBPqqw63FpS7RCeIjFi0au4xtTLYMNozq/LTtX
         Etkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spfz70KsmaWfJPZhaux40i6S/dssFm/wRaPyqLciHLI=;
        b=XMU7seBLDq7S04RevQHongzkoSipWerfzKEie0qbsEm2tpLdVM5YxreAiDhKPAsbCo
         w7zBpDHwQEWNHVpOAed/boYpiGXyXQk7B1GyMH9uCsGLavGmmfMWJT2IHII8Qo1Lt4qr
         oep8g1XWo96cjIBHHQQDj+MVr7m8D3bw1PVFOvrUeUrz+9YvRhFvLqcOCILikE/DOh77
         dH4Y9NHKRGeoMyrN7IvBDyYp+wSmlHx74KtRcHMejbo30cl6M7K/WdLAsg323LTbeN0K
         W6bdP+6+ECLI9OIT0D2W1PtbEND7BSi9BbEjRTs+Wn0XVzFqvB22O3LwKzYYMXVg8SHm
         jB8w==
X-Gm-Message-State: AOAM532RS4Q9a6MVp+yOJ1GA9+XE/y2ek7UlGvyvIfXSGDgrt35Alj1c
        x9nv+G7N6sjB1SAvsvWEPEI2HF08lSBR/jXuRKLSLdakCOw=
X-Google-Smtp-Source: ABdhPJzjMfzc2c4KE4a3Iv6T3Yv4XrQL2QnxfL9SzFKn9sr/+UUZDFFhKEMXQ2SPg/ntLGJyac/1IH4grN0/2vBzC9o=
X-Received: by 2002:a05:651c:228:: with SMTP id z8mr9434029ljn.202.1590986770573;
 Sun, 31 May 2020 21:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <748b1e955ccdcf7cd897a180f4b4fe82d7bfcf00.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BHzHhBVGZ+vOgE4jTCT3HJzXo+gzZ+6SVGDUWWdfkL6Dw@mail.gmail.com>
In-Reply-To: <CABPp-BHzHhBVGZ+vOgE4jTCT3HJzXo+gzZ+6SVGDUWWdfkL6Dw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 1 Jun 2020 01:45:59 -0300
Message-ID: <CAHd-oW7b41hqfPXm_GL_sth+QRfx56ceMr4VM9B9xhj3_P9iGQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] config: add setting to ignore sparsity patterns in
 some cmds
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 1:18 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 6:14 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> > diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
> > new file mode 100644
> > index 0000000000..2a25b4b8ef
> > --- /dev/null
> > +++ b/Documentation/config/sparse.txt
> > @@ -0,0 +1,24 @@
> > +sparse.restrictCmds::
> > +       Only meaningful in conjunction with core.sparseCheckout. This option
> > +       extends sparse checkouts (which limit which paths are written to the
> > +       working tree), so that output and operations are also limited to the
> > +       sparsity paths where possible and implemented. The purpose of this
> > +       option is to (1) focus output for the user on the portion of the
> > +       repository that is of interest to them, and (2) enable potentially
> > +       dramatic performance improvements, especially in conjunction with
> > +       partial clones.
> > ++
> > +When this option is true (default), some git commands may limit their behavior
> > +to the paths specified by the sparsity patterns, or to the intersection of
> > +those paths and any (like `*.c`) that the user might also specify on the
> > +command line. When false, the affected commands will work on full trees,
> > +ignoring the sparsity patterns. For now, only git-grep honors this setting. In
> > +this command, the restriction takes effect in three cases: with --cached; when
> > +a commit-ish is given; when searching a working tree where some paths excluded
> > +by the sparsity patterns are present (e.g. manually created paths or not
> > +removed submodules).
>
> I think "In this command, the restriction takes effect..." to the end
> of the paragraph should be removed.  I don't want every subcommand's
> behavior to be specified here; it'll grow unreadably long and be more
> likely to eventually go stale.

Yeah, I was also concerned about that. But wouldn't it be important to
inform the users how the setting takes place in grep (specially with
the corner cases)? And maybe others, in the future?

What if we move the information that is only relevant to a single
command into its own man page? I.e. git-grep.txt would have something
like:

sparse.restrictCmds::
See complete definition in linkgit:git-config[1]. In grep, the
restriction takes effect in three cases: with --cached; when a
commit-ish is given; when searching a working tree where some paths
excluded by the sparsity patterns are present (e.g. manually created
paths or not removed submodules).

The only problem then is that the information would be a little
scattered... But I think it shouldn't be a big deal, as a person
interested in knowing how foo behaves with sparse.restrictCmds would
only need to look into foo's man page, anyway.

> > diff --git a/git.c b/git.c
> > index a2d337eed7..6db1382ae4 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -319,6 +324,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> >                 (*argv)++;
> >                 (*argc)--;
> >         }
> > +
> >         return (*argv) - orig_argv;
> >  }
> >
>
> Why the stray whitespace change?

Oops, that shouldn't be there. Thanks!

>
> > diff --git a/sparse-checkout.c b/sparse-checkout.c
> > new file mode 100644
> > index 0000000000..9a9e50fd29
> > --- /dev/null
> > +++ b/sparse-checkout.c
> > @@ -0,0 +1,16 @@
> > +#include "cache.h"
> > +#include "config.h"
> > +#include "sparse-checkout.h"
> > +
> > +int restrict_to_sparse_paths(struct repository *repo)
> > +{
> > +       int ret;
> > +
> > +       if (opt_restrict_to_sparse_paths >= 0)
> > +               return opt_restrict_to_sparse_paths;
> > +
> > +       if (repo_config_get_bool(repo, "sparse.restrictcmds", &ret))
> > +               ret = 1;
> > +
> > +       return ret;
> > +}
>
> Do we want to considering renaming this file to sparse.c, since it's
> for sparse grep and sparse diff and etc., not just for the checkout
> piece?  It would also go along well with our toplevel related config
> being in the "sparse" namespace.

Makes sense. But since Stolee is already working on
"sparse-checkout.c" [1], if we use "sparse.c" in this series we will
end up with two extra files. And as "sparse.c" is quite small, I think
we could unify into the "sparse-checkout.c".

[1]: https://lore.kernel.org/git/0181a134bfb6986dc0e54ae624c478446a1324a9.1588857462.git.gitgitgadget@gmail.com/

> > diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> > index ce080cf572..1aef084186 100755
> > --- a/t/t7817-grep-sparse-checkout.sh
> > +++ b/t/t7817-grep-sparse-checkout.sh
>
> All these testcases look great (modulo the small typo I pointed out
> earlier); I kept thinking "but what about case <x>?" and then I kept
> reading and saw you covered it.  You even added some I wasn't thinking
> about and might have overlooked but seem important.

Thanks :)
