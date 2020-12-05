Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168EC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 09:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478FC22E00
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 09:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLEJZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 04:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgLEJYR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 04:24:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B8C061A52
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 01:23:17 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d3so7323669wmb.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 01:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X995GJ/Bx3wbpwz7SmBl+Bv0cQtFRCqMsivFYhNSD7A=;
        b=s83M+EJtz0HrCkgDpVwaRvrREcN+ZrfNseon/w3HUpH4+fv1eVepAJhHZcHy3HBroW
         RqDcJBmc7RRaRqKMQhgg3pQLb7gdXUU59ocCVlu5FUerFeINMx5x69Epke+JwG8LZ9uM
         9ok0o+1dAOf0cpjb4NJycOARnSPTCpZFIUpepZg+BIPgcdSbF3GwaBpt2fuoyYxg+nAo
         m/kHi0CtsAAg55vwGztBX68thFibxiJGRiKV5lS2ItfPk62osmP+HvrujmeINg4AHwVE
         cBuJlQmep9gOTGIBvLpyZRswrMIdGghbjL5w5WpHq58Shhrg92LObkfokZ2rT+tVZ1CD
         Wb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X995GJ/Bx3wbpwz7SmBl+Bv0cQtFRCqMsivFYhNSD7A=;
        b=NVdSh25CIoCxEd+9DH2PkW1SnRPahEcufx9K3HkV8LhtpykU5Ap9cG7bfZ4Yhs7G8P
         3d0rHrPNp7xElbrvyxL98RG4k8U0xChxEk99Wkyj+O61W18u314CD1itimYpbJUA92+v
         TChICXzIJ9OPMz48BxEmHOgiLTiRHDg4nkVfj+LgxztBWhNgrHD6Yq/j8UZiyQOu3Mdg
         nfLZQ8ZjtY0otkbetXjSCWS1xq5msnzfGeC8uHUYDF+F90qlXHCopZzSP9eUfRi2DEhi
         ZixYDFt+10npv/1HiXUrxGHv6PzNzmnxx7r85Piea9rGZSSjE877BPSl9KKGNMnyFLTQ
         rq0w==
X-Gm-Message-State: AOAM533kBb7hfe+BsUEo3/PDabI6Y3eO3L2A97ELY3fwXasw3ZEJKCsR
        UkJ3BKdwGnZgXT9YLmLWUNX5iydL25FvEJQG7gg=
X-Google-Smtp-Source: ABdhPJx5OoINO0wpPTC5CGHn8k7EcGwijP6RITS0/aonPbBhCVXgOQ/vW2tPWrkwqFh7CYBks+kqd0Xm1unxW6hRkFk=
X-Received: by 2002:a1c:2804:: with SMTP id o4mr8649954wmo.171.1607160196375;
 Sat, 05 Dec 2020 01:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com> <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
In-Reply-To: <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 5 Dec 2020 01:23:05 -0800
Message-ID: <CAPx1Gvf2SZdY_huOGieXD0kJaEn38gsaAiXrV==YxL1-x81dPg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:59 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> But in my mind "fast-forward" is not a noun, it's an adjective, so I
> still expect a noun: fast-forward $what. And I don't have any other
> noun to put there but "merge".

It's a "fast-forward operation". :-)

(The operands are branch name and hash ID.)

It's just been nouned, like "a merge" instead of "a merge commit".

> > > Perhaps: a merge, a rebase, or a fast-forward?
> >
> > Sure, that works; in fact, that's much better than my suggestion.  I like it.

I like this one too.

In a perfect world, I'd have had `git pull` be the user facing command
that does one of: fetch only, fetch-and-fast-forward, fetch-and-rebase,
or fetch-and-merge.  (Obviously one can achieve the fetch-only by
running `git fetch`, but `git fetch` is a plumbing command.)

In that same perfect world, the default probably would have been
fetch only, but fetch-and-fast-forward (or fail if not fast-forward-able)
seems like an OK default as well. But we have to deal with the
imperfect world we have. This seems like an OK way to do that.
