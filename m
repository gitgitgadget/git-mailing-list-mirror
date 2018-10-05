Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F8E1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 02:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJEJOa (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 05:14:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41000 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeJEJOa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 05:14:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so10299082edd.8
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 19:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiRcyXqtCRDqBio9QvPR1hiXR7mEKDBcdMa6PMHLBkY=;
        b=Ws9wmO+rf8jgAeELB79K0LU6P7Kx053a1fL/Myf9A/gaddQ5F0fe2nv6QIHZp2CzPC
         5daJmbZamFtH/YHor7ACnf9JtQpJ7hq/5ZacNonvsuAgE+dK6PLniBpcAVgnaRvDbmh6
         wf443Hl39VQc7HOsNtKprfWGRNf8n1XkG2eGIhtJxNJvduYLIAQrKtMgZXaYgL3TOc1D
         tzLMW/nPHLHk0jhnxBd2V1499vThPRVM2otkGp0yHLP12Epw0RP/C/m7GeQsw5U8z6Cy
         uXjtUT0Qfdl122DuzPgFp+QW9U+FE17sBIOyGa5TlpA2jML9jY3Sj2SvKbBggh6GaCAW
         Hjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiRcyXqtCRDqBio9QvPR1hiXR7mEKDBcdMa6PMHLBkY=;
        b=TZ3G11TCvtttnwnBn1JI2PybgeTRk0PN81zBsLw5SOj69KphdJzVAHP8TfxzsZU7bt
         YGhJFfXPNmIpWzSihTVrMIO6ndm4hR0ROrVgfyIqO08U5UltEcH+G8+pCGaS1EK8GZ0i
         LiazOd0AktWVVaOwb+OL1heUeWv9y9uQEEc6LLbkcNAFvS8jJCVC+XX4gvAdIAKuUzR3
         a3HHj0td0Xo7I+uttKIM3RPcEhTwXGbgS5Zkh7q4LwFwIk6gOmU+TT2Wu2qh3wzs2cMq
         MTKPaKDRd8N1FkTdtAEwxy6NxKUMV0UTeBpxOcZKLHf4PZ4QRnY222GNylqiermzWSaI
         ZsoQ==
X-Gm-Message-State: ABuFfohDEpunLWBSC6MI+zG9pJ4fpjXVecht83ecAPKBXg8/h/ITRU1r
        fk1Z4P05yITfXKONraHLMnBW4fofG2wu/X3R5Q8=
X-Google-Smtp-Source: ACcGV60lFHf53IFh9Q4AiDsOg6Lt4s5wKGNca7NM6BYuz0Mv2mEJWfioRTT9QnpCcJUffBt2CGC1Sp82HiRk3TA58lA=
X-Received: by 2002:aa7:c581:: with SMTP id g1-v6mr3195660edq.79.1538705878766;
 Thu, 04 Oct 2018 19:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181002200710.15721-1-jacob.e.keller@intel.com> <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
In-Reply-To: <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 4 Oct 2018 19:17:47 -0700
Message-ID: <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 1:18 PM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Tue, Oct 2, 2018 at 1:07 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> >
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > make coccicheck is used in order to apply coccinelle semantic patches,
> > and see if any of the transformations found within contrib/coccinelle/
> > can be applied to the current code base.
> >
> > Pass every file to a single invocation of spatch, instead of running
> > spatch once per source file.
> >
> > This reduces the time required to run make coccicheck by a significant
> > amount of time:
> >
> > Prior timing of make coccicheck
> >   real    6m14.090s
> >   user    25m2.606s
> >   sys     1m22.919s
> >
> > New timing of make coccicheck
> >   real    1m36.580s
> >   user    7m55.933s
> >   sys     0m18.219s
> >
> > This is nearly a 4x decrease in the time required to run make
> > coccicheck. This is due to the overhead of restarting spatch for every
> > file. By processing all files at once, we can amortize this startup cost
> > across the total number of files, rather than paying it once per file.
> >
> > Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
>
> Forgot to add what changed. I dropped the subshell and "||" bit around
> invoking spatch.
>
> Thanks,
> Jake
>

Junio, do you want me to update the commit message on my side with the
memory concerns? Or could you update it to mention memory as a noted
trade off.

Thanks,
Jake

>
> >  Makefile | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index df1df9db78da..da692ece9e12 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2715,10 +2715,8 @@ endif
> >  %.cocci.patch: %.cocci $(COCCI_SOURCES)
> >         @echo '    ' SPATCH $<; \
> >         ret=0; \
> > -       for f in $(COCCI_SOURCES); do \
> > -               $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> > -                       { ret=$$?; break; }; \
> > -       done >$@+ 2>$@.log; \
> > +       $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) >$@+ 2>$@.log; \
> > +       ret=$$?; \
> >         if test $$ret != 0; \
> >         then \
> >                 cat $@.log; \
> > --
> > 2.18.0.219.gaf81d287a9da
> >
