Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9361F453
	for <e@80x24.org>; Fri,  5 Oct 2018 12:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeJETj0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 15:39:26 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51072 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJETj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 15:39:26 -0400
Received: by mail-wm1-f41.google.com with SMTP id s12-v6so1752554wmc.0
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xip45j15EPafa2aCV54zYgL0U24uUp9YsrYhm3a8grU=;
        b=ByA2iTH/TArl3J9vBB3Odb33H+m6IQrytSDidax4pTMPhMf1pFQJal/j/yFF20Qshn
         JCXA2hT0wgYyPYZPuk5fLgsvBBsKciywhWKLYUD3Z82s9rjy5ORuqkG8HH5xVmUOU7a7
         XMN+b5OksZt4F453rBRK5CQKqT/2p7KVvSzWjqCoE6GhOnp+Ww2CYY22ddjVAeicXeoq
         nSgF21S89DzH8P5yJi4Whg6txn2dEP89xGOre2HJU6m6SiUM5eEtBvenorXTbfOfcApY
         5W/L8nSsOIS7rlm/X2fMi0R+Zkr+5wNiBsFsVwvZIMiRXa4OxEp1a2Ortr6Ykd/llqTE
         pLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xip45j15EPafa2aCV54zYgL0U24uUp9YsrYhm3a8grU=;
        b=ue12nn2Zm7s3fQsunj33i2gS4MGWSVh2ptWIBwStxKhirHRbWTrU6KFWoUMl/2Cudx
         peT3EZ2UKblEWz94LHkq/ixGRtSXmm5zV+LbEimvGlD3hHEsP72oGXhk5ejsP58cHYfk
         ZO9ludZJdQrNkx0PamrY8MsdDKjc4ubOQkcQp141E0W09/yl6LHXrSqnHrJMjxSXx0jW
         sho0Re8y6U5rxDTnxagAkPFDzY6Z/PuzAHhTn6NOtyI4kfCUQRbLL2kCVVqHur9hJXjt
         zW0n7+f1SWxxFN2FLTa20VB63y1Lh5CmD8ssChVSJbXfxTc2NGJhFSByJ4dWPZbSQiyx
         7RtA==
X-Gm-Message-State: ABuFfohAJHRunRizfoYp0zQwwJr136GotK/ASHQ4tdUFummUci97aKpv
        o/ZParqDdV+tXncLi1cKZ/o=
X-Google-Smtp-Source: ACcGV63Fgt1Y+5EjqpbixMM7Yp/Lg0t9/Sir76anrf5FFzmFv4dry0DgAE7NlTtetHF3/X2x2WcHSg==
X-Received: by 2002:a1c:e386:: with SMTP id a128-v6mr8322650wmh.106.1538743251776;
        Fri, 05 Oct 2018 05:40:51 -0700 (PDT)
Received: from localhost (x4d0c6f69.dyn.telefonica.de. [77.12.111.105])
        by smtp.gmail.com with ESMTPSA id a18sm5920836wrx.55.2018.10.05.05.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 05:40:50 -0700 (PDT)
Date:   Fri, 5 Oct 2018 14:40:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181005124048.GT23446@localhost>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 07:17:47PM -0700, Jacob Keller wrote:
> Junio, do you want me to update the commit message on my side with the
> memory concerns? Or could you update it to mention memory as a noted
> trade off.

We have been running 'make -j2 coccicheck' in the static analysis
build job on Travis CI, which worked just fine so far.  The Travis CI
build environments have 3GB of memory available [1], but, as shown in
[2], with this patch the memory consumption jumps up to about
1.3-1.8GB for each of those jobs.  So with two parallel jobs we will
very likely bump into this limit.

So this patch should definitely change that build script to run only a
single job.


1 - https://docs.travis-ci.com/user/common-build-problems/#my-build-script-is-killed-without-any-error
2 - https://public-inbox.org/git/20181003101658.GM23446@localhost/


> > >  Makefile | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index df1df9db78da..da692ece9e12 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -2715,10 +2715,8 @@ endif
> > >  %.cocci.patch: %.cocci $(COCCI_SOURCES)
> > >         @echo '    ' SPATCH $<; \
> > >         ret=0; \
> > > -       for f in $(COCCI_SOURCES); do \
> > > -               $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> > > -                       { ret=$$?; break; }; \
> > > -       done >$@+ 2>$@.log; \
> > > +       $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) >$@+ 2>$@.log; \
> > > +       ret=$$?; \
> > >         if test $$ret != 0; \
> > >         then \
> > >                 cat $@.log; \
> > > --
> > > 2.18.0.219.gaf81d287a9da
> > >
