Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C169C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B0560551
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 10:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbhJZKKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhJZKKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 06:10:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32CCC061767
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 03:07:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b82-20020a1c8055000000b0032ccc728d63so309450wmd.1
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 03:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CmdGMoaGbH/eE6pGykiIKYXAugU1fVQY31phJpHTaKM=;
        b=cNdpNGWKPi+sS+QIKlaaeSlzImqgQqr+9Vw8TVqa9a5qha0BELYiMy8XTthKPP5YOG
         UqBDrctoOj+Uua8uWtfAP8a3oE7u5OYaCag21vBC4M7DhgOkMwOdnOcWHsd3S1gIIoRp
         DDdZa7oJqviUyMUabE2ENod79Vgpb+um8bMxyo1UnBbrBM0mBBaw9dueAwd6MZphpbJ3
         E+B3vJJAlOk65PEXOOXrElYdXSBw0wUyfr35LU8bPwKnGheeG8s2rBl2u3vPEoRR2QdI
         H7QYcDp+aiNhZPDmNyvTcymt1vpIo/6+PaYWwCLDx+fuXpsOuUjoRW1olgdeJXiFVtsG
         2MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CmdGMoaGbH/eE6pGykiIKYXAugU1fVQY31phJpHTaKM=;
        b=C4JP0VLvG/zdfUJNhpgD+3DDaq8Oazmvd9ZCzI5nabRrAPYIwNpe0yaxsthwRFdSQb
         0Q+DC42fEHaT88jiNzUS92ncaxmkq2cg5WMaVij5EpJyzarbtRouq+kOeRPgyjuosliB
         jqbStDGJkCzcuH3Xl7bgWJ/dnB/9pQvgT5gKQve7MZGAxQhdnSzzUMg5Db6YmxXAGcJ0
         daeMsM0aYTO4j17sqML3JqTTwI3KnoFuiVs+jbHBnf5uGgQKToT7Lx1Cc4goVg1R2Yzv
         HJ5C1Uo4vzaHxLDD+CO1wdVlUlqeoR8X0hVUVdbsWRtiizRgFM9gO6CNAxFPNSbsJm5d
         z5aw==
X-Gm-Message-State: AOAM533viqh5/l+g/J/yBrTS1dCkNkGF+fhGrDZX7O1joJAfmxiWvaGK
        5z4JHpVNzSu/dOzYka4scSA=
X-Google-Smtp-Source: ABdhPJwfsnd09pUAhC99FzbKuyEHiHxVB0YF7grEkbI2A0ypux8jLZbtjBchMEfVstTaGFy7aC/rLw==
X-Received: by 2002:a1c:a991:: with SMTP id s139mr26091185wme.181.1635242855151;
        Tue, 26 Oct 2021 03:07:35 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i14sm112633wmb.48.2021.10.26.03.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 03:07:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfJMk-001kd3-3w;
        Tue, 26 Oct 2021 12:07:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
Date:   Tue, 26 Oct 2021 12:05:40 +0200
References: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
Message-ID: <211026.86fsso14m1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Jeff King wrote:

> Since 8650c6298c (doc lint: make "lint-docs" non-.PHONY, 2021-10-15), we
> put the output for gitlink linter into .build/lint-docs/gitlink. There
> are order-only dependencies to create the sequence of subdirs like:
>
>   .build/lint-docs: | .build
>           $(QUIET)mkdir $@
>   .build/lint-docs/gitlink: | .build/lint-docs
>           $(QUIET)mkdir $@
>
> where each level has to depend on the prior one (since the parent
> directory must exist for us to create something inside it). But the
> "howto" and "config" subdirectories of gitlink have the wrong
> dependency; they depend on "lint-docs", not "lint-docs/gitlink".
>
> This usually works out, because the LINT_DOCS_GITLINK targets which
> depend on "gitlink/howto" also depend on just "gitlink", so the
> directory gets created anyway. But since we haven't given make an
> explicit ordering, things can racily happen out of order.
>
> If you stick a "sleep 1" in the rule to build "gitlink" like this:
>
>    ## Lint: gitlink
>    .build/lint-docs/gitlink: | .build/lint-docs
>   -	$(QUIET)mkdir $@
>   +	$(QUIET)sleep 1 && mkdir $@
>
> then "make clean; make lint-docs" will fail reliably. Or you can see it
> as-is just by building the directory in isolation:
>
>   $ make clean
>   [...]
>   $ make .build/lint-docs/gitlink/howto
>       GEN mergetools-list.made
>       GEN cmd-list.made
>       GEN doc.dep
>       SUBDIR ../
>   make[1]: 'GIT-VERSION-FILE' is up to date.
>       SUBDIR ../
>   make[1]: 'GIT-VERSION-FILE' is up to date.
>   mkdir: cannot create directory =E2=80=98.build/lint-docs/gitlink/howto=
=E2=80=99: No such file or directory
>   make: *** [Makefile:476: .build/lint-docs/gitlink/howto] Error 1
>
> The fix is easy: we just need to depend on the correct parent directory.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The problem starts in ab/fix-make-lint-docs, which is in master.
>
> I wasn't able to trigger the problem locally even with running 'make
> clean; make lint-docs' in a loop, but I did see it in the wild in a CI
> documentation job:
>
>   https://github.com/peff/git/runs/4005766641?check_suite_focus=3Dtrue#st=
ep:4:60
>
> It would have been a lot easier to diagnose from the CI output if the
> mkdir lines weren't silent. I.e., if we had a $(QUIET_MKDIR) which
> printed "MKDIR $@" rather than nothing at all.
>
>  Documentation/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 911b6bf79c..ed656db2ae 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -472,9 +472,9 @@ print-man1:
>  ## Lint: gitlink
>  .build/lint-docs/gitlink: | .build/lint-docs
>  	$(QUIET)mkdir $@
> -.build/lint-docs/gitlink/howto: | .build/lint-docs
> +.build/lint-docs/gitlink/howto: | .build/lint-docs/gitlink
>  	$(QUIET)mkdir $@
> -.build/lint-docs/gitlink/config: | .build/lint-docs
> +.build/lint-docs/gitlink/config: | .build/lint-docs/gitlink
>  	$(QUIET)mkdir $@
>  LINT_DOCS_GITLINK =3D $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(H=
OWTO_TXT) $(DOC_DEP_TXT))
>  $(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink

Thanks a lot for fixing that bug, and sorry for not spotting it. This
fix LGTM and is obviously correct.

I'll try to do something about the $(QUIET*) as a follow-up, I was
trying to find the right balance between over-verbosity & "tracing".
