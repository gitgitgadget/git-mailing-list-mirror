Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EDAC433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 12:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0585C613B5
	for <git@archiver.kernel.org>; Sat, 15 May 2021 12:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhEOMFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 08:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhEOMFU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 08:05:20 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB958C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 05:04:07 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso458225oow.10
        for <git@vger.kernel.org>; Sat, 15 May 2021 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hcXrcZXG3niY16OcgXdBB0QPPwUJuiJAC1TAmyUacSU=;
        b=IV1dx2Vk3JDCQFnlhJ9l/bgbG/4OhLnZWd/tug/HhXVCIEHKMZ0pcA+s4oSZqW8csD
         VsayoMiQ4qYGtytz7jvHh8pYldmqYDtl2UVjtbEaAMktG/dbg/nR0eu7lLgAAH+OX9lF
         OH0SOOZvl2sYpC4MtZgJ5o0sfGRSVWWXZd83QCY2ChcAkj+GLMiUwUD72bmHSttKBO6V
         Y6tz1iI26xlkwg6HjXn8GfJAINX5S5HbBkhMXw2Un2/e7RcC6gIWzjN2GSPwcMbfpdtM
         mFLwLgqYeG7Va+kvMPKf90t48AB9J49tVdseQOwMfiOb1pytqTZF/fwGSqYmlvvdPMpB
         uGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hcXrcZXG3niY16OcgXdBB0QPPwUJuiJAC1TAmyUacSU=;
        b=Pr0crC+Tsb7JR7p3ia75FYm+MZg6u56syFmTt22tLAPngYxyF9GVSU1fIYNLWagik3
         c0I4CjTRUS8EePrWjA5bES1WIqipgtzQDrvArcf7JyCzkGT4TJcIFAVC9AdjaYa38QRd
         Qh1dy6b1xPWKq0lsY7qt4qkKNulR0Gp8mnZyVpDlsdJ1fRxCPrF6nkhUsgS3J5qoNuY8
         yIKEu22Ewd+FXgwsns15VNh7LA7kFts683//n/vNlSzbyUhWkbrL/m+IpvOMjY/zLa7Y
         07IVRZEPUlkljBvh69rWykfXzX1q9uPw2TF5gmRRR+m24rHkVS0nqb8WfTj7GjNBA+DR
         1y1Q==
X-Gm-Message-State: AOAM5329dA8vBHzvBZnk6VseOnutIMQOifABmzpCPKAk1MZ1iBATQiK0
        dAKkmnHVBy/cT/Ei9eLAhO8=
X-Google-Smtp-Source: ABdhPJzpeJ/e94EEcLYegG+Thao3YjnL6Z9WlrWlmbGS4P/rATEpniDmff1/Lu/3Wdd7z/Um0HHUVw==
X-Received: by 2002:a4a:a702:: with SMTP id g2mr31011117oom.86.1621080247191;
        Sat, 15 May 2021 05:04:07 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id a12sm1900730oti.12.2021.05.15.05.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 05:04:06 -0700 (PDT)
Date:   Sat, 15 May 2021 07:04:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <609fb8b5bf799_e173a20897@natae.notmuch>
In-Reply-To: <YJ+TQiYVgocUBQRV@coredump.intra.peff.net>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
 <20210514115631.503276-4-felipe.contreras@gmail.com>
 <YJ+TQiYVgocUBQRV@coredump.intra.peff.net>
Subject: Re: [PATCH v2 3/5] doc: remove unnecessary rm instances
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, May 14, 2021 at 06:56:29AM -0500, Felipe Contreras wrote:
> 
> > Commits 50cff52f1a (When generating manpages, delete outdated targets
> > first., 2007-08-02) and f9286765b2 (Documentation/Makefile: remove
> > cmd-list.made before redirecting to it., 2007-08-06) created these rm
> > instances for a very rare corner-case: building as root by mistake.
> > 
> > It's odd to have workarounds here, but nowhere else in the Makefile--
> > which already fails in this stuation, starting from
> > Documentation/technical/.
> 
> Aren't there tons more that you end up removing in the next patch? E.g.:
> 
>    doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
>   -       $(QUIET_GEN)$(RM) $@+ $@ && \
>   -       $(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
>   -       mv $@+ $@
>   +       $(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@ $(QUIET_STDERR)
> 
> That does differ in that it removes $@+, too, but the premise is the
> same (we know that $@+ could not be a problem, as we're about to
> clobber it anyway).
> 
> I'm OK with getting rid of all of them, but it seems like it ought to be
> happening all in this patch.

Yeah, but the rationale is different.

  1. $(RM) $@: these remove the target file because of permissions
     (i.e. root owned)
  2. $(RM) $@+ $@ && $(CODE) && mv $@+ $@: these are for interrupted builds

To get rid of #2 we need an alternative solution, like .DELETE_ON_ERROR,
to get rid of #1 we don't, we can just do it.

-- 
Felipe Contreras
