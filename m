Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6E7C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346588AbiEZVdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiEZVdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:33:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F268A075
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:33:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ck4so5252992ejb.8
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y1zF2+FYKRkG7mgM8mDwtluw5WQTuHsQZc+8FQ+q2Jg=;
        b=kk8xNOdrJFg3QQD2pNULqMsZnurKo8H4sdeLBGc4UFLDELMz3OKRf6rtKN246tzyXj
         lAmQ7WbZDKYj5Fw9xNbJtJQYTTs6PrPaXjVoLFwUKnrP11p3i26zUQdwlE1pD85iTzMO
         u0qFgpwqbSKBPxztj0Deb6XnoNxuCXeAO3nd042ExLogCz0yOfJQ0dAXBqzrNQCtJGLE
         p9bAAh8WwPPZC2c4zDzXXoSHjzMKLww6GlImu91BS0pGKKf4yC6hgyFO6OnqsPXOJ4Cw
         0V63fbNe+W6eMOMNU56mUwkl+VUBOm4KBqZQqeXI5fGOt9wrfPaalky88xZP/9deZ+Ui
         VIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y1zF2+FYKRkG7mgM8mDwtluw5WQTuHsQZc+8FQ+q2Jg=;
        b=botIEFh9fCpHoDsgM277tfaY364unqL4XB2kmUhhMDxW9Ok8xAh42UjXPLEp7ksB+l
         A/OvSavtjQEABI+OIRpQ5CPsDk3UGbfzvieYR0rVJYIrRcWhx+s9qQ8hzfos0E42KYHZ
         xFDfV7F89Ap77tudPeCAuiqLga9T2rm4AYvtZzyPDDaiMSzKP2lGiYtCUXQFJi4raNeD
         mB/Ky1PXCAzXz10Ywo2VLfnhg/QGyiAHrdwreSeTAB/CSEeGxl004C/EMhs6Rpz+mDAS
         1Q9R1un3NTEiOdJyX3pScuj2fdA4FPqMbiSLQzqGP/MbQmG77MjMXMWeO932hrrREZgu
         z4/g==
X-Gm-Message-State: AOAM533d30ZMujhffl2cGnxQpZR41e26mm3Y0Wfew5emyWWKdgH57WjX
        FHWvrSj8ioLk+SBRgG2jJ34qTbsnRf8=
X-Google-Smtp-Source: ABdhPJxuH0MDYsi4AXn2YllPXUDU1jg38A0sIuXp192+JH6En5o3iYmhP/QP1W16l+xMUh1VBM/CfA==
X-Received: by 2002:a17:906:fa85:b0:6fe:a2b8:ed3d with SMTP id lt5-20020a170906fa8500b006fea2b8ed3dmr30313907ejb.440.1653600788652;
        Thu, 26 May 2022 14:33:08 -0700 (PDT)
Received: from localhost (84-236-78-147.pool.digikabel.hu. [84.236.78.147])
        by smtp.gmail.com with ESMTPSA id wh21-20020a170906fd1500b006fedcc56b0bsm844900ejb.170.2022.05.26.14.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:33:07 -0700 (PDT)
Date:   Thu, 26 May 2022 23:33:05 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: build 'gitweb' in the default target
Message-ID: <20220526213305.GA1707@szeder.dev>
References: <20220525205651.825669-1-szeder.dev@gmail.com>
 <220526.86k0a96sv2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220526.86k0a96sv2.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 02:14:33AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, May 25 2022, SZEDER Gábor wrote:
> 
> > Our Makefile's default target used to build 'gitweb', though
> > indirectly: the 'all' target depended on 'git-instaweb', which in turn
> > depended on 'gitweb'.  Then e25c7cc146 (Makefile: drop dependency
> > between git-instaweb and gitweb, 2015-05-29) removed the latter
> > dependency, and for good reasons (quoting its commit message):
> >
> >   "1. git-instaweb has no build-time dependency on gitweb; it
> >       is a run-time dependency
> >
> >    2. gitweb is a directory that we want to recursively make
> >       in. As a result, its recipe is marked .PHONY, which
> >       causes "make" to rebuild git-instaweb every time it is
> >       run."
> >
> > Since then a simple 'make' doesn't build 'gitweb'.
> >
> > Luckily, installing 'gitweb' is not broken: although 'make install'
> > doesn't depend on the 'gitweb' target, it runs 'make -C gitweb
> > install' unconditionally, which does generate all the necessary files
> > for 'gitweb' and installs them.  However, if someone runs 'make &&
> > sudo make install', then those files in the 'gitweb' directory will be
> > generated and owned by root, which is not nice.
> >
> > List 'gitweb' as a direct dependency of the default target, so a plain
> > 'make' will build it.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index f8bccfab5e..ee74892b33 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2188,6 +2188,8 @@ ifneq (,$X)
> >  	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
> >  endif
> >  
> > +all:: gitweb
> > +
> >  all::
> >  ifndef NO_TCLTK
> >  	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
> 
> In various recent patches & some upcoming ones I plan to submit I've
> been trying to get the runtime of a noop "make" runs down, which really
> helps e.g. with "git rebase -x make ..." running faster on a large
> series.
> 
> While you're right that this wasn't intentional to begin with, we have
> lacked the "gitweb" as part of the default target since v2.4.5 now, and
> adding it back is a major performance regression on noop "make" runs:

I think that generating stuff, potentially as root, during 'make
install' is a more severe regression, than this noop make slowdown,
which in practice tends to be lost in the noise anyway.  Even in an
unrealistic case (it doesn't modify any C source files explicitly, let
alone a frequently included header file) like this:

  $ git checkout fddc3b420f^
  $ make
  [...]
  $ for i in {1..10} ; do git commit --allow-empty -q -m $i ; done
  $ time git rebase -x 'make -j8 NO_TCLTK=Y >/dev/null' HEAD~10
  [...]
  real	0m31.026s
  user	0m46.897s
  sys	0m11.492s
  $ git checkout fddc3b420f
  $ for i in {1..10} ; do git commit --allow-empty -q -m $i ; done
  $ time git rebase -x 'make -j8 NO_TCLTK=Y >/dev/null' HEAD~10
  [...]
  real	0m30.865s
  user	0m48.315s
  sys	0m12.125s

Hrm, it actually ended up slightly faster.

> 	$ git hyperfine -L rev HEAD~1,HEAD~0 -L t Y, -s 'make' 'make NO_TCLTK={t}' --warmup 1 -r 5
> 	Benchmark 1: make NO_TCLTK=Y' in 'HEAD~1
> 	  Time (mean ± σ):     103.6 ms ±   1.1 ms    [User: 83.8 ms, System: 32.1 ms]
> 	  Range (min … max):   102.2 ms … 105.2 ms    5 runs
> 	 
> 	Benchmark 2: make NO_TCLTK=Y' in 'HEAD~0
> 	  Time (mean ± σ):     191.4 ms ±   1.6 ms    [User: 151.0 ms, System: 60.5 ms]
> 	  Range (min … max):   189.2 ms … 193.3 ms    5 runs
> 	 
> 	Benchmark 3: make NO_TCLTK=' in 'HEAD~1
> 	  Time (mean ± σ):     272.0 ms ±   5.0 ms    [User: 206.3 ms, System: 83.3 ms]
> 	  Range (min … max):   266.7 ms … 277.3 ms    5 runs
> 	 
> 	Benchmark 4: make NO_TCLTK=' in 'HEAD~0
> 	  Time (mean ± σ):     358.3 ms ±   1.4 ms    [User: 282.7 ms, System: 104.0 ms]
> 	  Range (min … max):   356.6 ms … 360.0 ms    5 runs
> 	 
> 	Summary
> 	  'make NO_TCLTK=Y' in 'HEAD~1' ran
> 	    1.85 ± 0.02 times faster than 'make NO_TCLTK=Y' in 'HEAD~0'
> 	    2.63 ± 0.06 times faster than 'make NO_TCLTK=' in 'HEAD~1'
> 	    3.46 ± 0.04 times faster than 'make NO_TCLTK=' in 'HEAD~0'
> 
> I.e. this is with your patch here applied as HEAD~0 and HEAD~1 being
> 'master'.
> 
> I think given that that a better solution would be to just declare this
> as a feature at this point

As long as 'make install' installs 'gitweb', I don't think that's an
option.

> especially as gitweb/INSTALL notes that the
> way to install it is:
> 
>         $ make prefix=/usr gitweb                            ;# as yourself
>         # make gitwebdir=/var/www/cgi-bin install-gitweb     ;# as root

Or are you suggesting not to install 'gitweb' during 'make install'?
I'm fine with that, but I doubt I will argue about it convincingly in
a commit message.

> Or we could just fold gitweb/Makefile into the main Makefile, unlike
> gitk and git-gui it's not externally maintained, and most of it is
> shimmying to work around not being part of the main Makefile (which it
> strongly inter-depends on anyway).
