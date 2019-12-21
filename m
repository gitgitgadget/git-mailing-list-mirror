Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0006C43603
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 00:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853992082E
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 00:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/AR0VDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLUARP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 19:17:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34538 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfLUARP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 19:17:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so14010616otf.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 16:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Otp3oK9Dtjaws3pIYzqwlUXRoNVpfm9eVu6ck64N2dM=;
        b=h/AR0VDBYOv9D3o1R/hiUAKl5wdYpPw1c6BceB4ORM0m7AjsPnb7S4cmN+qYlGM24E
         8wZmcSrL/bTaTrXTet7Y9u7/DSEtv44MBVu4xGgFl7uUirMksCOfYLnEccoIU69QtTCD
         hgAl1MMPCnvvreYDpBNGB6tGqSd1J/N4rPTo6ODSoBC6zuqnNsD6BPyLPhxtOkFXO9qH
         L82Ys9ZpTWImIwu8eDCUGbeAsQxtzaDXgngglwSsLAfOCxtINZQVSTs4PFQj30AO4lqD
         VPUqYnNW7axIVsY6kG9wyN60KUPLf2T2L62nx7JToiDxpfI0hTLK8GovH8j43w1+5Cjc
         qJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Otp3oK9Dtjaws3pIYzqwlUXRoNVpfm9eVu6ck64N2dM=;
        b=mN11gp0rvwohTykL8X76sZUCMh4R1P/8dtdgEkWoXgK5ou0XcIHCcq79kGg+7jIjBT
         U6wb3zd05VsXAW0Xche0gkK2s+M1y4Q+YaOm3PcsTOo86lKOMnYJwB0gjZWAXu47fqwa
         Pq68C6ToqWF/ocO1GM7C4iMWQcoqxZaqufC7xWbLT6tHGTYWn9eiXJwGNOJrILM/4zNB
         cwIB0IzI0XYlWpY982k+rKH7FJ8Bv3wzqzvnZHKFjD+nsqcqQk/SCrqqA68/VFf17eJL
         8gPZduKHMGoTL180fuNLb0bvNVbJueGAf+XHd5bSj2eEHAyOJsJA3WnJ4XLHGw+WzjY+
         Ibhw==
X-Gm-Message-State: APjAAAV6sxmezIdlZIXfSeJB04j2UfXiW7/lfz3PM0ARNFJpjhbAjChf
        wg5YHRi8OKrYn40xoeTn6OJBTclEA9z58pmvthw=
X-Google-Smtp-Source: APXvYqxNeJuU5FwApW0sZ7H3qa0ZoulEMD2kMM+yaJ+mgJv5EfDHnceWBY3gfkDnmhcEPUTSyKerw6YUTb0k52q2IaI=
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr12519173otn.267.1576887434201;
 Fri, 20 Dec 2019 16:17:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
 <1c3f8ba328982e633e1431eba3fabcb230821ddc.1576861788.git.gitgitgadget@gmail.com>
 <20191220230710.GA32750@szeder.dev>
In-Reply-To: <20191220230710.GA32750@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Dec 2019 16:17:02 -0800
Message-ID: <CABPp-BGu503MgO6zudSnHoaeMksinYvT+YkWTP+VzmDweu7p7g@mail.gmail.com>
Subject: Re: [PATCH 11/15] contrib: change the prompt for am-based rebases
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 3:07 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> The subject prefix for this file is most of the time 'bash prompt' or
> 'git-prompt'.
>
> On Fri, Dec 20, 2019 at 05:09:44PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > The prompt for am-based rebases was REBASE, while for interactive-based
> > rebases was REBASE-i.  A while ago, we switched merge-based rebases fro=
m
> > using REBASE-m to REBASE-i via re-implementing the merge backend based
> > on the interactive backend.  We will soon be changing the default rebas=
e
> > backend to the interactive one, meaning the default prompt will be
> > REBASE-i rather than REBASE.  We have also noted in the documentation
> > that currently am-specific options will be implemented in the
> > interactive backend, and even the --am flag may eventually imply an
> > interactive-based rebase.  As such, change the prompt for an am-based
> > rebase from REBASE to REBASE-a.
>
> I had a bit of a hard time following which rebase variant is
> implemented with which backend and when it was changed, and... etc.

Sorry about that.  I could fix it up, but...

> Makes me wonder: do we really need those "-i", "-m" or "-a" suffixes?
> What benefit do they bring?  Why don't we just say "REBASE" in the
> prompt?

Ooh, I like this idea.  A lot easier to explain in the commit message
and probably less confusing for users as well.
