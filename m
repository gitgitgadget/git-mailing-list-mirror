Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A749C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 22:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54557613DD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhE1WaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhE1WaB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 18:30:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD52C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 15:28:26 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so4941628otl.3
        for <git@vger.kernel.org>; Fri, 28 May 2021 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0l9Kjzr7DqY6r7opvqtN70HQ+jtk5yWthtRSRYHUNw4=;
        b=cqZgqBEQ/EVTKpplzyN7ovGsMVM2PQ5YwxtVxRlYrIMhkT1eZI5FHFSIcWypWlc1Vb
         mRngPqd/MstGIw4dB1F6QcfDJ/lS5eq5pf4lMCw321yDA7/PG7LeYdXn49rJSZ7lQ/Mg
         PxXKCQFlEgyccAk8tPWq2Xs7fEsWK71A6rA/dGK8x7/TaKtOvS1Rc2ej9GLWa2sekCY2
         or+9uvmFl6Sg1UeCnN5kWIzqY1VI256aXhmcp0sbmmzDvEZZFw09+BpRXBd3YgU04RS0
         cQUklwVjKjvbF6H/lUBSZaSdWTrFVrwv5HZxfXTbLVb7UjROKuvtY526ZCdcINSaLabm
         iDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0l9Kjzr7DqY6r7opvqtN70HQ+jtk5yWthtRSRYHUNw4=;
        b=bRN/o+wXiMi/qpXBYBZz66FsfJ+25+i5+KvVkruqVIiMGrfMLgmZmHGA/A3F+Vril6
         1dx0V00OtZd4wMXaGz/XvH5pt/wvIKWrZ4EJbN8DCvlybZ/bNYBzB7dk1c+1ilNxLu8Y
         LHu1odEcAuT/POs/ibwl1NCvK/YmTBlfbsV7O6KvZk1mvgU3+l7xham1NtNOYcfTnnfV
         xfveTfP0QhtKk8enjyaa6uMHTVL5Qdcz6aQzhXZd6Xnj4mz1KvABOCnx8iT2R/rvBoVx
         nxAsXnd4cmftzNYJKluazDbLCE84fjq1FlXOPU1EGXTPi3hqmbt9YKHnkkchPiq1ECkW
         PAHw==
X-Gm-Message-State: AOAM532AQJevXEmtYFczlRCp3NqSyrDA8hlQ3x9zEXEWtOKpimV3oytm
        o0ml09lK9ZalXPZ/PaT5RCGfJKoM/aJx5l6oUficQ3kV6vs=
X-Google-Smtp-Source: ABdhPJz7Uk9JDfquU6qyAcwYHBU+j3vTxugABu6pLloV4us0waiAHgyTT35a5w17oYHJGuxMgfNWU1hGLDEBmvUjvQU=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr8578474otn.162.1622240905757;
 Fri, 28 May 2021 15:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
 <CABPp-BGEtJqorUeQ4evWdmCvb=zsnkAdOn-ToG48=AYp3aUwNg@mail.gmail.com> <60b16d05d87e7_2a3a9a2088@natae.notmuch>
In-Reply-To: <60b16d05d87e7_2a3a9a2088@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 15:28:14 -0700
Message-ID: <CABPp-BGSzgOwG0HjDG9WdytXT-x1-KBC0vipBgpS4a+X6aJ0Rw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Unconvolutize push.default=simple
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 3:22 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >
> > Is "Unconvolutize" a convoluted synonym of simplify, untwist, or
> > perhaps deconvolute?  ;-)
>
> Indeed. Does it give you an urge to remedy that?

Nah, it's fine.
