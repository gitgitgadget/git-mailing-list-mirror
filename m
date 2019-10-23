Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6EA1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404096AbfJWXad (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:30:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44005 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbfJWXac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:30:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id v5so6142520ply.10
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HXxgCLTObsn7Q9IfmqlhZ/TmrvZ0xSROE3upo4LJkZ0=;
        b=aAMPACx3mEmFW7FOpyNoHq5R24JuYHiNY5UB9ECUkPu65iflzkHOqRDbKsx6NZs9mu
         y405KxRS6qexTBqV74qM4EQ/0yZ/6nyRidw5mfFHWzxx8EQdI3jEqV8fRaS7huQBCzWj
         ou6gVw3bdJ+e3K6BgEZwb+dVgY5WuTVO10tGZRzPfVUYULlKlczGrR8Ne4kFaRyTzQiW
         iDHYxKoIIFnfuexzqWwdpmwh1P4kaMVZL03D+t3MpXO1Qb2xuv0Z3/yH7M1Rrc+idG5o
         28BJXGZ540GXNrG3ZeAjEtxZeEqWWfOg53bKAkMvD7aAILqHbcJzYTifR10RkjdmS2nF
         it5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HXxgCLTObsn7Q9IfmqlhZ/TmrvZ0xSROE3upo4LJkZ0=;
        b=YsmZkcwvtzYHFHaSTVLd05c2ZnNxqJcV8e8sItimcQmmfxWoygkkORv5AWs2Fgajt2
         HN2IwZjledabE8z4kNkz2ukqN2AP9kf4777Fn1cIXFD5/KctTJcm4XlwDk3+p2drQIqw
         N2ehTfd5bl2akdGP7xLkz87dA6R47QtHGnPEQvzuyDGLmuEDa+KTTA7Gf9xzX3Fo7Hs4
         eXaSkAk2QHSkteQVWheO8A7wwVOhD/tizWs8sOD+fwQ0QzZOLluCjNS1ASSTntXJrQW7
         Wveio58CCgzY0RSuRLLseG2MkcDeoUksbchzsHiZOwrFt7K3Qtcj4EXSYK7VG7qKAXbW
         pZDw==
X-Gm-Message-State: APjAAAUsEU3YW0jBdX9qcSOs2PCuXXp0rnygIusQWUKRsrfkZrkhPJ1Q
        HIw2nmg54h2sKajmPbLZjsDVlg==
X-Google-Smtp-Source: APXvYqxOO+R1P0Mg4dGesdRl+TrKJJCO/xRdCZsMy9LH+CgUGgX/Hfb2DQuLDue3fylNOQMYFHXHiA==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr12629307plo.233.1571873431384;
        Wed, 23 Oct 2019 16:30:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id p3sm9466237pgp.41.2019.10.23.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:30:30 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:30:26 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: delay fetch_if_missing=0 until after config
Message-ID: <20191023233026.GC124161@google.com>
References: <20191007181825.13463-1-jonathantanmy@google.com>
 <20191023214428.129593-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023214428.129593-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 02:44:28PM -0700, Jonathan Tan wrote:
> Suppose, from a repository that has ".gitmodules", we clone with
> --filter=blob:none:
> 
>   git clone --filter=blob:none --no-checkout \
>     https://kernel.googlesource.com/pub/scm/git/git
> 
> Then we fetch:
> 
>   git -C git fetch
> 
> This will cause a "unable to load config blob object", because the
> fetch_config_from_gitmodules() invocation in cmd_fetch() will attempt to
> load ".gitmodules" (which Git knows to exist because the client has the
> tree of HEAD) while fetch_if_missing is set to 0.
> 
> fetch_if_missing is set to 0 too early - ".gitmodules" here should be
> lazily fetched.  Git must set fetch_if_missing to 0 before the fetch
> because as part of the fetch, packfile negotiation happens (and we do
> not want to fetch any missing objects when checking existence of
> objects), but we do not need to set it so early. Move the setting of
> fetch_if_missing to the earliest possible point in cmd_fetch(), right
> before any fetching happens.

I think your sign-off is missing from the new commit message, right?

Otherwise it looks fine to me.

> ---
> No changes from v1 except that I improved the commit message.
> 
> Thanks, Emily, for taking a look.
> 
> > I'm having some trouble figuring out which object is actually missing.
> > Is this the .git/config object? (That doesn't make much sense to me...)
> > Is it .gitmodules?
> 
> Yes, it is indeed .gitmodules. I improved the commit message to further
> explain what is going on.
> 
> > By the way, I think I understand that this is OK to go in
> > unconditionally because:
> >  - In the full clone case, it's a no-op; we haven't got anything that's
> >    missing, so who cares.
> >  - In the filter case, it's as you said - we don't want to
> >    fetch_if_missing because that will turn someone's partial clone into
> >    a a full clone.
> >    - This probably applies to bare checkout, too.
> 
> Yes, that is correct. What do you mean by bare checkout? If you mean the
> checkout that happens after clone (that we can suppress with
> --no-checkout), that indeed happens after fetch_if_missing=0, so we
> shouldn't have a problem there.

I meant bare clone, not checkout, my apologies, but as I understand it
better, they're completely separate concepts - that is, you can
certainly have a bare clone which is also a full clone. So, please
disregard this comment.

 - Emily
