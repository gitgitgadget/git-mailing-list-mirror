Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2533C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B641206E2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQ2zsH3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCLTcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:32:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44033 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgCLTcA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 15:32:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id d62so6712545oia.11
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTCkTpU9ABu475lL1dDpxyVEjO7jXJId1V50ckDs9oA=;
        b=qQ2zsH3vV9AVeAMlbAO32JrHuFt0uE4wwcU2egzJNEs/f/G/g9l118mh7QF37ZdJQT
         DUlXDO5ZDNUw/FCky1w5zLPmHhWHmIeUOPp3LkHAaw1+OSNFmzxRIL3XTB78q9w/copd
         pAbej7qFO07mJhrNY87owu3bmEWdT1qYjJ4wJzRgfZHGkXLoRBGHOBuPg/7PeYSl8a5P
         FiHAPzgO31HF14EoA2NAEBM2ts+ZxLp7p5TOA6Sgke7gxMqB+i6i4GZDMFFCWD5Lbvka
         ZJSmHODBrtQDSd0ji+P6can4T5i1vLAnhqwYnLofInxL72ZWdJ8hX+IwuxnuvfzMM/74
         xvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTCkTpU9ABu475lL1dDpxyVEjO7jXJId1V50ckDs9oA=;
        b=Cjhq9AgBXbJMgOwnUmkpIaNQq22pTd4yhdBWPyueKoBNYzrMVsGTS0xi29Ln7Yw2qZ
         NIJHS98TRwkMTqMCLE+LcgPN8gmijRV2txoIkp0B6nymfxoqERsura2pkxLBenOHyLK8
         ICC8OIrahe1t9WBIFZ4FA6BH7h2w0qgQZsqDWPLlXUECCqNGhYNU+AFYAKapMDwpO4/F
         KeG/i2gs1tt+SrA0pPO7/0GUojXHva1+oKd75dKXHeJkw822CtnJPBWW3j04iacXY+mA
         XAzGTjA8+ZxB0yW0uIsECA4NVsEr6ObIBbQXU33hLS6CmV2qqxP59aDUUdQLsz8xzOrP
         D5KQ==
X-Gm-Message-State: ANhLgQ0O/dsUq1D4i6GYZQHOUBwcM98E4+t6/FhPBLsEYZbwQ+2J5JMx
        xNPWLR70hSLam4cnClohY0SuHO9/aa8ksP4F0zY=
X-Google-Smtp-Source: ADFU+vufZHiv7r1BgrJCfmK+kJKG6QYo8d4v5P2G4jZ5gfZTU7pC/+nE6j8kI1481a38rbENdCy3xxNXHEYuAnteHeg=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr4039543oig.39.1584041517838;
 Thu, 12 Mar 2020 12:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com> <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com> <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <20200312175548.GC120942@google.com> <CABPp-BFLwpa019Prd3nf7s4BY2jWp8utOvJD9pzHcbg66b8fWw@mail.gmail.com>
 <20200312184621.GD120942@google.com>
In-Reply-To: <20200312184621.GD120942@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Mar 2020 12:31:46 -0700
Message-ID: <CABPp-BHSAbJzWEsPSTM5Q6MPdmu4VSuOx-=6-MJkHUovg3_1=g@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 11:46 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Thu, Mar 12, 2020 at 10:55 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> >> What if we support multiple merge.backend values, with semantics:
> >>
> >> - last recognized value wins
> >> - if no value is specified, use the default
> >> - if values are specified but none are recognized, error out with a
> >>   clear error message
> >>
> >> ?
> >
> > Sure, but...isn't that what we already do, other than maybe the
> > 'clear' part of step 3?
>
> Sorry for the lack of clarity.  I mean allowing
>
>         [rebase]
>                 backend = am
>                 backend = apply
>                 backend = futuristic
>
> with behavior
>
> - on "git" that understands am but not apply or futuristic, use the am
>   backend
> - on "git" that understands apply but not am or futuristic, use the
>   apply backend
> - on "git" that understands apply and futuristic, use the futuristic
>   backend
>
> That way, a single config file is usable on all three versions of Git.

Ah, gotcha, that makes sense though we'd need to make the thing
multi-valued which is a bit late for 2.26.  But we could at least
extend the logic in that way for 2.27.  Also, to further clarify, if
they have

         [rebase]
                 backend = misspelled
                 backend = futuristic

then what should the error be?  A couple possibilities:

fatal: Unknown rebase backend: futuristic

fatal: Unknown rebase.backend config setting: futuristic

fatal: Unknown rebase.backend config setting; valid values are 'merge', 'apply'.

or should it be something else?
