Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB361C2D0EC
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 00:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AD22083E
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 00:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn0VQfiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDKAHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 20:07:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42394 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgDKAHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 20:07:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id j20so2657341otl.9
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6b0ZPfYhA3Kle0rCErqeuJAnvIV2+A444RfNgBKbn9g=;
        b=Jn0VQfiYFGF1p6DIDqzzFMAn+mXlwXR5YRnuyhNoJcJMuMgIdsoeZbHTR5kPBxZF7u
         5MLXRjZeYqHCFxChB3EG7+cQQ4Mvy5y6wA6S8HN08OvEj291TxVlaspDZd4Eu6jOnzy3
         LbCCUCcc+u3mf7XTAT9Ug+g8aZ/PkhwuPDU3+tWNZl/H03Xsg3pw4f4johm4lq6ROMq+
         at/VS6KZeAQd7Hs2b+CAeRBShdo+8remPai7LSb8SwGvPKYJ6BnHXaKQiSGmO2hzUeyp
         VXgP92hghWSAy4uyCXRhu8+iua4Ft6AJoT8v57XG/Xejk2t83Amxe5rAB3NQdVJyNopU
         E6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6b0ZPfYhA3Kle0rCErqeuJAnvIV2+A444RfNgBKbn9g=;
        b=g8dou8jiCuRwhtr4wTJegQ7G13iuTlEM6au396vdBPbcKmwZnAOr4HH3oGHq7DzzHD
         gKAoSkwulDUO+25HwgOl7ExpLBTnRvWqI1OqunIEXBFK2jwjrPfSELLO8g9xPDnCaMmK
         9xLtqZIXEO4PcknyOG1oOgCqsUwc/Cad072NZ1VMsQB6j7rludsEQh2lvdY0SnR4qPPO
         bIqCb8UfzUWOPBNatFLOOSpQghGScaVxbxLazXL51ggdNKecNTD06Aqj/mM8HUts1IS7
         SzrXo23TsmU0Em1fHR0Ty/Ox9NV7ADgnwQfujgrJYb0ozBJtNKY1F27SE30N/wV5VGjp
         AASQ==
X-Gm-Message-State: AGi0PuYwJanRUi6sh42XlsFuLzbonY7jexzt1WmQcgmkzudrtM/TApKA
        yj1h6YYyifWRPU6aiNPVqB8nsZqPKXU1mdWmegk=
X-Google-Smtp-Source: APiQypKWr0MQamHOiEbCRfQhDmNYYfaFZzHYRJYb9/auj7tvNFqhaEvEnJ8B+SuhkMw5t26+jiYV/+SoHriDhqPtC8c=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr6182331oti.162.1586563665441;
 Fri, 10 Apr 2020 17:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
 <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com> <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
 <xmqqd08fhvx5.fsf@gitster.c.googlers.com> <CABPp-BEQdK8PagqCrKCvkzaWvSQVfW9g9_RbFCNP3r3qeChbzQ@mail.gmail.com>
 <xmqqv9m7geiy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9m7geiy.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Apr 2020 17:07:34 -0700
Message-ID: <CABPp-BEFKEr0hA8V4ZqEEGBCkYRbzrgNx2kyPCTvjSh3Oj25bQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bryan Turner <bturner@atlassian.com>,
        Sami Boukortt <sami@boukortt.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 3:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Apr 10, 2020 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> > So I am OK to rebase the other topic to v2.26.0; would that help?  I
> >> > already saw there was some entanglement with the other topic in one
> >> > of the patches in this series, so...
> > ...
> > Thanks, but wouldn't I want to base his patch on top of mine rather
> > than vice versa?  (Since mine might be labelled bugfix, and his is a
> > new feature?)
>
> If you are willing to rebase the --[no-]keep-empty so that it does
> not depend on v2.26, that may give us a better result.  I just got
> an impression that you somehow wanted to base your changes on the
> newer codebase, but if you want to base both on the older codebase,
> that is fine by me, too.

Rebasing my stuff on the older codebase wouldn't make sense; the
relevant code would be riddled with conflicts.  Rather, I was thinking
of rebasing Jonathan's changes and building his series on top of mine
(and then touching up the docs so the flags reference each other).
