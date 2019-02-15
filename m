Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9CD61F453
	for <e@80x24.org>; Fri, 15 Feb 2019 09:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391946AbfBOJAM (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 04:00:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42800 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfBOJAK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 04:00:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id r15so7300531eds.9
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 01:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLWuBeiKu0gMdXgZXci9PjPKtfOSgLsaQKvbc6+8Tts=;
        b=Js7Ro82PWlafG/bEedgCEfGgsoXDlHclztUSAh07/Gx0IgETtH1p2FaDn7/BWdzvV0
         R8zIxUmIF3Sg2HF8/9RnHMOyP5K7wEWh2y9rSLImVVxTMJtPhPWVKZ+l+NuN60ORSoS2
         wQyw0/FtChUFQJsIX+mGAE614VRBCTUSzmPFRFalCzNpKsqsL8v77HORT8q0l2eywWp+
         Or4Xsdmy3XJAmuxdpygZHVN1znzo/b0PEtJ4feGBtDsmtXAhvJfy3UCIWYcNHn/vpoRk
         im7X7itGywRlz49soHmizSeHHgsKdNctAYAD8tGj2pmQLeA1lFnS0rh9/PaTu7FOh5o2
         tQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLWuBeiKu0gMdXgZXci9PjPKtfOSgLsaQKvbc6+8Tts=;
        b=rHcxebP0Rs12IpfXFlCIX8G1GAE/Y0ZEpCaAg3xlFwZFFOGG9EIxNHfMCMJGeq62KD
         6aBylnrQVaf4E4hviJ43ZsMgESZDWJ8XTRFx7HkLHQPXcw/9srqvipF32/fq3Cz4ioFf
         9aXkr7PEoFNRA971jEIqAxX+jNeExjJE8rSeXbRA5RIUB8Y8skSPTgBg4dFcFpCpFVJk
         PjGY0j/XZ0NZE4q+Idl836ReUGkbidPDf3Ms3O68DcDgfzTKud6dd00b3mRWHmb+Qdpb
         QZsGBXHeZPkFFqYUdrgZFLCFasanho9ldYBSOwP/tbrTmwrvrr3KYmPk6iJv50kbmBm6
         zE9Q==
X-Gm-Message-State: AHQUAuazNbsXFFFEkJpRz3vvktk5pspcSGgjIxntjcmldEXtA7AMvblS
        B95HeN3TUtmdffm29XGsHicMKobVwAPmjQanN/0=
X-Google-Smtp-Source: AHgI3IbQXDK09aUr+oFwun4bs/azmP3vLBF3RhBHPf5QMrAg2c3HrVrxs3D5g+ubmnPZXTyiKONthHpFiGh/Le189K4=
X-Received: by 2002:a05:6402:185a:: with SMTP id v26mr6640461edy.163.1550221208067;
 Fri, 15 Feb 2019 01:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20190213205554.4086-1-matheus.bernardino@usp.br>
 <CAP8UFD1aBn8=KOTp-D=CmO1iEnWUBS1-jR-aqfg3MZ7HZRU7Pg@mail.gmail.com> <CAHd-oW6uHKfa_P+fZNZxG4+pme=SH_Wi+SJkhxwOtfR+L=0JBA@mail.gmail.com>
In-Reply-To: <CAHd-oW6uHKfa_P+fZNZxG4+pme=SH_Wi+SJkhxwOtfR+L=0JBA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Feb 2019 09:59:56 +0100
Message-ID: <CAP8UFD0c7oPdaPkU55mus-3xgYcMmUSa_dsuGcGRF0ijn6r8iw@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH] clone: use dir-iterator to avoid explicit dir traversal
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 11:04 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Thu, Feb 14, 2019 at 7:16 PM Christian Couder
> <christian.couder@gmail.com> wrote:

> > > -static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> > > -                                  const char *src_repo, int src_baselen)
> > > +static void mkdir_if_missing(const char *pathname, mode_t mode)
> >
> > It looks like your patch is both splitting copy_or_link_directory()
> > into 2 functions and converting it to use the dir-iterator API. Maybe
> > it would be better to have 2 patches instead, one for splitting it and
> > one for converting it.
> >
>
> Got it. As the justification for splitting the function was to use the
> extracted part in the section that was previously recursive, I thought
> both changes should be in the same patch. But I really was in doubt
> about that. Should I split it into two patches and mention that
> justification at the first one? Or just split?

If 2 patches instead of 1 makes it easier to review and understand
what's going on, then I think you should indeed send 2 patches and
mention the justification for splitting the function in the commit
message of the first patch.

> > I think we usually put such comments just before the function. And
> > maybe it could be shortened to "Create a dir at pathname unless
> > there's already one"
>
> Right, the shortened version does sounds much better, thanks! About
> the comment placement, I followed what I saw in other functions from
> the same file ("copy_alternates", for example).

Then it's ok to place it like you did. Sorry about the noise.

> But also, I couldn't
> find any instruction about that at Documentation/CodingGuidelines. So
> should I move it as you suggested?

I think we have not been very consistent over the years. Recently I
think we have tried to add or move API documentation inside header
files, and in general before functions in the code, but yeah it might
not have been documented.
