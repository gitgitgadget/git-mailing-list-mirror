Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCFDC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95823613A9
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhJVDPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhJVDPP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:15:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE1C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:12:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h193so2092508pgc.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=euWpoa0Mk8BqDEiv8wZCHFLTxwGuV1GkH00JJhLcCRU=;
        b=P+vqKk8CXYGpB8E9a8HZtq9byue9wukdPmmwlwYDOM/SAgNKG3xveJvfDYlIjYi/OZ
         qJXphJ5cpgLN3Z0yBfI0IbznNSEx+iqLlaQIrqtp9MJ3fI7txD6SlMnD4MmtS2ZaMAQL
         RygCxtG2kTRD/d/uTplgvcOhQpNJ0s5y09uAub841zQypiyQJlekGFTF6agTywvCR0+F
         qegDg6z98jinoX9h0QcBuk9KSyxhVjErntWSuXan8kEFncJlxgA3gR6p9tN1FDvnqACf
         jsx/gtlkcAw0SSOU4q5IEesqiF5cBN0IM5MqnSKC7MYqtwrLfQYpJacfTGPuzIT5gjY3
         S9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=euWpoa0Mk8BqDEiv8wZCHFLTxwGuV1GkH00JJhLcCRU=;
        b=hj0ACjYePjt1gA1kCPy0lwVKRmwTZTlpDVXOf3ev7FvJQN+xdhqkvBlvwSl+Tz1bWg
         5T/9raIdlIZDzWfeL20BC1jU0Ce0M2L2A5/aJppEgMUNfcIQTL9ebCgWLIQoAbV7n8M4
         0YYFXih2Kq86pPq1thkhwTlF3/FqPBBB4pku/1EQFVlYqmeZWkreaHlM/X1iVB7/maO0
         08h65/gJ2QasFRsA5Id+IxuQle2Q+tSFtSadxQrVAhPFqReMiLUPt92C4ZFjeWmtmvT1
         OEzku2oLO+x5fD1K38Dy88VdPUPHV4oXcqbMmAxRsiIG2TYN4VGD/T0P1wCQjc7TxEhs
         7xoQ==
X-Gm-Message-State: AOAM530ZkB//3bjd4ORRjRyBDxN+p2g+RG+naPFq8FjRuMAzSEsOwhtg
        fY99a6fQQ7MMdVF4vUJwUlKX/g==
X-Google-Smtp-Source: ABdhPJxZ/GSgM1cGuuec6ia0MvFwxLjU20+wUalMxOy+cKNnakKT444dyOZry2Ll893atch6i1ZAuA==
X-Received: by 2002:a63:91c7:: with SMTP id l190mr7210142pge.350.1634872377642;
        Thu, 21 Oct 2021 20:12:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3866:91e2:ded9:17f2])
        by smtp.gmail.com with ESMTPSA id b6sm8885833pfv.171.2021.10.21.20.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:12:56 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:12:52 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
Message-ID: <YXIsNIoxhADuM1Mi@google.com>
References: <cover.1634077795.git.jonathantanmy@google.com>
 <20211018204803.75088-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018204803.75088-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 01:48:03PM -0700, Jonathan Tan wrote:
> 
> After some in-office discussion, here are the alternatives as I see it:
> 
>  (1) Introduce a "includeAfterIf" (or "deferIncludeIf", or some other
>      name) command that is executed after all config files are read. (If
>      there are multiple, they are executed in order of appearance.)
>      Files included by this mechanism cannot directly or indirectly
>      contain another "includeAfterIf". This is the same as what was
>      introduced in this patch set, except for the name of the directive.
> 
>  (2) Leave the name as "includeIf", and when it is encountered with a
>      remote-URL condition: continue parsing the config files, skipping
>      all "includeIf hasRemoteUrl", only looking for remote.*.url. After
>      that, resume the reading of config files at the first "includeIf
>      hasRemoteUrl", using the prior remote.*.url information gathered to
>      determine which files to include when "includeIf hasRemoteUrl" is
>      encountered. Files included by this mechanism cannot contain any
>      "remote.*.url" variables.
> 
> In all cases, the include is executed if at least one remote URL
> matches.
> 
> There are other ideas including:
> 
>  (3) remote.*.url must appear before a "includeIf hasRemoteUrl" that
>      wants to match it. (But this doesn't fit our use case, in which a
>      repo config has the URL but a system or user config has the
>      include.)
> 
>  (4) "includeIf hasRemoteUrl" triggers a search of the repo config just
>      for remote.*.url. (I think this out-of-order config search is more
>      complicated than (2), though.)
> 
> For (2), I think that prohibiting "remote.*.url" from any "includeIf
> hasRemoteUrl" files sidesteps questions like "what happens when an
> included file overrides the URL that made us include this file in the
> first place" or "what happens if an included file includes a
> remote.*.url that validates or invalidates a prior or subsequent file",
> because now that cannot happen at all. My main concern with this
> prohibition was that if we were to introduce another similar condition
> (say, one based on remote names), what would happen? But I think this is
> solvable - make the prohibitions based only on all the conditions that
> the actually used, so if the user only uses conditions on remote URLs,
> then the user can still set refspecs (for example), even after the
> remote-name-condition feature is introduced in Git.
> 
> For (1), it is simpler in concept (and also in implementation, I think).
> The user just needs to know that certain includes are on-the-spot and
> certain includes (the ones with "after" in the name) are deferred - in
> particular, if a config variable isn't the value they expect, they'll
> need to check that it wasn't introduced in an includeAfterIf file. (And
> the user also needs to figure out that if they want to override such a
> variable, they'll need to make their own includeAfterIf with an
> always-true condition.)
> 
> From the prior replies, I think that people will be more interested in
> (2) as it preserves the "last config wins" rule, and I'm inclined to go
> for (2) too. I'll see if others have any other opinions, and if not I'll
> see how the implementation of (2) will look like.

Another concern which came up for me in a private conversation today -

How difficult will it be for users to override this include directive if
it is set somewhere outside of their control? For example:

/etc/gitconfig:
[includeIf hasRemoteUrl.https://example.com/example.git] // or whatever
  path = /etc/some-special-config

Will it be possible for a user to "un-include" /etc/some-special-config
themselves?

I don't think this should change your patch much - if my understanding
is correct, we also don't have a way to "un-include" existing include or
includeIf directives made outside of the user's control. But I wonder if
it'd be useful to think about some way to do that. Maybe we can teach
the config parse how to include a config file in reverse? Maybe we need
a "neverInclude" directive? Food for thought, anyway.

Sorry, but I won't have time to take a look at the rest of this series
til next week.

 - Emily

