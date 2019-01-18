Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36E611F453
	for <e@80x24.org>; Fri, 18 Jan 2019 23:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfARXbA (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 18:31:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34387 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfARXa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 18:30:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so12522949ede.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 15:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5OlYeyD4vqhxx+2RcPJ41bIH8YkENb1fguW1MUFSFo=;
        b=kOFoK+3si5oPW1+3Xu2WA/Rx6QbhMNETezTNyTLx4GWe+Iiwq9jBckY1xNNQg4cnxY
         lpf8b8rh5fHtnGJCF2PuaE1wEKss8ZmgwAeYRl3APJLeBNz/WCIIOsLEG3JOnI7Vr9UF
         mk9H2GlTne/q+UlvFRFPvhzTZA+mQ4ZMNGqjJm1CsmawJNrPrBRaNx+IEgJjWHCsmKFs
         lsIXVht6I1F40XHlBcxmQI7Zh+2xYB7oFleTAtbngDKDyNi5xCCL4Kp3nQhmWJ/CWSLQ
         3V/EUsDSoD9aN+7bNJZRp5RPbz3GA39OcHbfXyORilRsSAE0yzV9FFlG24JbwHq6/bKK
         TQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5OlYeyD4vqhxx+2RcPJ41bIH8YkENb1fguW1MUFSFo=;
        b=kaXQ6sJaTG75zM93vuvGgqTEv4X0MFW5Si0U9mnqdWiA0H3+7g/UmwM2hi/Z77gRb1
         Lbv1YjsSK19TEzHOn0vvA+VfDPneuPdGpsgNQ2iLHWypBjIz9c+lmVXUneZ44nIkYi2w
         SHrj7FM5KEZm2tFOMkIRUTOZTB45PhVhcdNEPBrkZoUTZ+5eRiuECrFMAbJXJUETNMdF
         pMWhduuAw9gLq5T7GCxKFZGCeHLztIwetMDuXi5UgCkDAiJGYxrd2AJr/4C+DUoKkx7I
         qsmNaAl1rw1msXTBPQGlaEdN08IhReMCCzzOs6cOnQ7Heg5gwr/OY7gog3XifL9dsFj0
         CYHg==
X-Gm-Message-State: AJcUukdVCMjWjzsSI0ocz6I4XV21ZXaSsof/PAEwzutcpKCmYw6jtIbR
        q/B7eWdzAmjFr8bg5B+9tCUdyO+zUxcrA3RlS6vzUg==
X-Google-Smtp-Source: ALg8bN5sX2qM3vV+STWffx3xY16PE9Ghdt95oRc5Hjed6gv4tza6weQPdbvexhm4IlOK/idcGou9fozUSqsc58dNOnY=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr18071817edy.191.1547854256729;
 Fri, 18 Jan 2019 15:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20190118215519.107700-1-sbeller@google.com> <xmqqlg3himh8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg3himh8.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Jan 2019 15:30:45 -0800
Message-ID: <CAGZ79kY=LOmzQXja6mUiBOSSrmjvGsRDWzzXsq9vMsYWRw02Pw@mail.gmail.com>
Subject: Re: [PATCH] git-submodule: abort if core.worktree could not be set correctly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 3:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > 74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
> > ensure-core-worktree, 2018-08-13) forgot to exit the submodule operation
> > if the helper could not ensure that core.worktree is set correctly.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  git-submodule.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 5e608f8bad3..02a0d728174 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -548,7 +548,7 @@ cmd_update()
> >       do
> >               die_if_unmatched "$quickabort" "$sha1"
> >
> > -             git submodule--helper ensure-core-worktree "$sm_path"
> > +             git submodule--helper ensure-core-worktree "$sm_path" || exit 1
>
> Good to have more places check errors from underlying command.
>
> Thanks.
>
> Out of curiousity, was this found by code inspection, or was there a
> real-world breakage episode?

By code inspection to come up with an answer for
https://public-inbox.org/git/CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com/

That issue in itself is not fully solved (Duy is still looking into it),
but this fixes a minor inconsistency along the way.
