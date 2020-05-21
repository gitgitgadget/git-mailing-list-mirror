Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC6EC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 03:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B5F20738
	for <git@archiver.kernel.org>; Thu, 21 May 2020 03:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TegJvS7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgEUDtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 23:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgEUDtd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 23:49:33 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5475C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 20:49:32 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s198so5098808oie.6
        for <git@vger.kernel.org>; Wed, 20 May 2020 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ry2lFj7MwaGlXv7giY3B6NL6WIvhEz9U0k2glgeucts=;
        b=TegJvS7oKjojLl6GtgBjfQ4UJXzuV2ozvbvnLkMsIQVRJTaEn+tWF9xG2sIbcX7WuN
         eKOY8/irdjHHG/+MSn3sPNFNZD4tyzj8MVsuZwZMMTe7F6KC2utPV2zUyNoXIiMrqHZT
         PzoMJVaSLX1pOg+TAYhzCVEmqMdstK7sW9UKEvXy6Cn+4AvDmsTWDLBzg+iwle/NlR1J
         gIvoLtqK8WfxM1eaxmo11My4yD3K7qvOJoDjM//XOpsO0wOa/CjsjD8aLlrVCWZ/uQPE
         vI6S7CZT86KsOf5C+1R2MnwMjPj9IIZMfSUiWL+saQZ6oUDttnSBkakxxD/nbJVLC3fO
         laCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ry2lFj7MwaGlXv7giY3B6NL6WIvhEz9U0k2glgeucts=;
        b=mPowJuv04DB/bPGpaWPc4nfAz5yHfcs+qN5j7ggoGqBYICyprEthQxeZC/XVjUrJh7
         mHcwth9vgzvYP1cmqFvX1oxWOHfmJwarsQ+SGsNk3bSYrSStDtxyywa77khbuckWjmfF
         g05xfRDZxgOs9osc10Sr5nMorEgaA7HUhfzYh3kOJnokkKnoXkcPMjLwXUzmqFrixQ2I
         BZ+0hIDCmMXcCsmORAvlUdSbZ7FJl84m3ge3pv1Bf4Iwo1dm8LWZQ3u8uML/cv37KwMu
         Rhtsr/nIe53JfIjnX8IlayJPseTsyrPbqDxuORfVcdm0jvwLQ3wVS1eIJ857odTp3tmQ
         /8iQ==
X-Gm-Message-State: AOAM531UK/5PGGqF9e4nsYK/BkJ6sFql8ILJk/Vbr81MYIiA3f9vI1be
        otAr8OaeXyl7xAGPZxlm2gsWVJQ/L2PSlu8nd8TJ/Mhn
X-Google-Smtp-Source: ABdhPJzaw60Rkhv4ZvpocrWc6uU5i46IGCmUNdqaY9Bysgqfdn3ABq0PJZcM5YiK1jZiNZbC039Gkcuqy881lLvpP3s=
X-Received: by 2002:aca:3f44:: with SMTP id m65mr5648924oia.167.1590032971975;
 Wed, 20 May 2020 20:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <fcf948bda7aebcc5f88c17f5b308b2ce0cc285f5.1588857462.git.gitgitgadget@gmail.com>
 <CABPp-BEkf0TVTt4=adJ9x70j814frL932vxyQCpm74AQiHWwGQ@mail.gmail.com>
In-Reply-To: <CABPp-BEkf0TVTt4=adJ9x70j814frL932vxyQCpm74AQiHWwGQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 May 2020 20:49:20 -0700
Message-ID: <CABPp-BGcjpJOht7ip_cPcHEtd3kx5fCwm=i19narWCEfCUwWAQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] sparse-checkout: use oidset to prevent repeat blobs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replying to my own questions...

On Wed, May 20, 2020 at 9:40 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, May 7, 2020 at 6:21 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > As we parse the in-tree config files that store the sparse.dir values
> > used to create an in-tree sparse-checkout definition, we can easily
> > avoid parsing the same file multiple times by using an oidset on those
> > blobs. We only parse if the oid is new to the oidset.
> >
> > This is unlikely to have a major performance benefit right now, but will
> > be extremely important when we introduce the sparse.inherit options to
> > link multiple files in a directed graph. This oidset will prevent
> > infinite loops when cycles exist in that digraph, or exponential blowups
> > even in the case of a directed acyclic graph.
>
> I'm still not sure if I like the idea of having a mirror dependency
> structure separate from (and duplicative of) the build code; I'm still
> mulling that over.

I mentioned this to a few other buildsystem folks at $DAYJOB.  They
were strongly opposed to having more than one source of truth, but
generating the git in-tree sparse values from the official build
system files, with commit hooks and build system checks to make sure
they get updated seemed like it'd be fine or not concern them much.

> It's good that you've protected against infinite loops.
>
> Is there any reason to prefer swallowing infinite loops rather than
> warning or flagging as an error?  (I'm not sure, just thinking my
> questions out loud.)

The buildsystem folks also reminded me that we have cylic dependencies
already, and although it's absolutely ugly, it is somewhat forced on
us by a combination of different external tools that we can't change.
As such, warnings or errors would be really annoying and we'd be one
of the ones to want to turn them off.  So drop that idea from me.  :-)
