Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FCBC433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 17:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9662C20723
	for <git@archiver.kernel.org>; Sat, 30 May 2020 17:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlWH9vJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgE3R0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE3R0V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 13:26:21 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD61C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 10:26:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g5so4008266otg.6
        for <git@vger.kernel.org>; Sat, 30 May 2020 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCl97jV4sFXK4/2byy1NNkJFpXxsSYg9tZ6ECSm8McM=;
        b=qlWH9vJGN/Jp+Jv7ehmERdMEHEWvBclZCETjIhTJ5dgMhQ80T4e+rvhhCSG6b7XcIY
         kN8C2vRQc9ofnPaP2INh+Grv6rKxShoOgelP0oXtqdUS1v1QTjq5nZiKavPTa36YJRXt
         Z7JQEzdjwiJSBKB1SU8ug7naScXTYdn97h4EjxgPyCN+qb5WpsHU77tgslP0wI8IVhkC
         yTWjGyXFTDlimd51m+GbBd88bi44LaePg5U2AYuMAY6L9M56mxcqqS5GteS+R7kFx3WI
         TL4rgWYbMVjOE9smoJ0Z3X7BZRb08MHnCQjiLlv0vlBI/Cx91Gxrf3vJVEfnlXcDQC20
         YYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCl97jV4sFXK4/2byy1NNkJFpXxsSYg9tZ6ECSm8McM=;
        b=AbfW2Y0feWvNwsr0o76FmBpW+6JjLxqoMswviAYpuGRdNOMOZSpCCvCzPNOydkOyvq
         4kRZ2u3a8RcDWBM+W0vO6uw1rc9yEyV1zVvuCUj5yo78M6inW/2owRNCtyyLwXV8Cv0v
         r0SN46TMMfgVk7h9p0N2TwXLmzhDRGmKEpGlHCqye0T0jMAJg0yvVeXJzSS13BjUNWhX
         dtpjT8kQrM7Nc7gtIKZ9FSvq5mVd83Gtk+BvGI7XH9z9xIGvydj4yxM5T4r5oPNvKsDz
         8DykRMW0/GKyvJgl6UtlySm8ZyO//vmwEQkv1IZ2Q4yg2z5mXKFn+lTo/mPqlnoyBjYa
         Mu5Q==
X-Gm-Message-State: AOAM530d+w4VFkfOjcLBSrr8q5zJGCio7omNNGHPeQshiloKXfFQDMBw
        ph3TrK6GL0jEcem+TQwumOtzU3nP04MeNJfSCmI=
X-Google-Smtp-Source: ABdhPJyvAcBdVlke7I4ZWr6VIon82KFpqBvgQzlH9dUjrKDK/p51Aaxix5O1rOGaE/aMaJLkdE4O6A2/rX+fGe/HUDw=
X-Received: by 2002:a9d:868:: with SMTP id 95mr806266oty.316.1590859580897;
 Sat, 30 May 2020 10:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <f55cd0fb3897db9ca22156347293ca830cdf018c.1588857462.git.gitgitgadget@gmail.com>
 <CABPp-BEz42zvT_Vsu2xxg9RnuhBZ2aF8b+KYEu-CW=bMGQOC=Q@mail.gmail.com>
In-Reply-To: <CABPp-BEz42zvT_Vsu2xxg9RnuhBZ2aF8b+KYEu-CW=bMGQOC=Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 May 2020 10:26:09 -0700
Message-ID: <CABPp-BEOb2-7xPfkbf2GBNxgGYpMyWXeKAiYzz2Mc99a8RoxGQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] sparse-checkout: define in-tree dependencies
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, newren@gmaill.com,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just thought of another angle here...  (This feature you suggest
sounds interesting, but I'm still mulling over in my head whether it's
possible to make it work and how...)

On Wed, May 20, 2020 at 11:10 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, May 7, 2020 at 6:22 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

> > --- a/Documentation/git-sparse-checkout.txt
> > +++ b/Documentation/git-sparse-checkout.txt
> > @@ -238,6 +238,32 @@ definition according to the files available at the new commit. If any of
> >  the specified files do not exist at the new commit, then the sparse-checkout
> >  definition will not change.
> >
> > +In a very large repository, there may be need to have multiple of these
> > +in-tree sparse-checkout definitions to fit the roles of multiple types of
> > +users. As each definition grows and the number of user types grow, it can
> > +be difficult to manage updating all of the definitions when a common core
> > +is modified somehow. For this reason, the in-tree pattern sets can inherit
> > +the directories from other in-tree pattern sets. Use the `sparse.inherit`
> > +option to specify other files in the tree.
> > +
> > +For example, suppose the file listed earlier is at `.sparse/core`. Another
> > +file could be stored as `.sparse/extra` with contents
> > +
> > +----------------------------------
> > +[sparse]
> > +       dir = X
> > +       dir = Y/Z
> > +       inherit = .sparse/core
> > +----------------------------------
>
...
> What happens if the user specifies a non-existent path, or perhaps
> equivalently, didn't understand and specified the path using a
> relative path specification?  What if the user specifies a path that
> doesn't exist in the commit, but happens to exist in someones's
> working directory?  (And maybe even did it intentionally as a way to
> cheat and add user-defined additional paths to include?  Do we want to
> allow that, or do we want to enforce that extra includes use some kind
> of pre-defined path?)  What if they specify some path that is invalid
> to record in a git commit (.git/mydeps or
> ../../../../../../../otherdeps) but happens to exist on some machines?
>  (Are there future security vulnerabilities of any sort going down
> this path?)

Although the above considers non-existent paths, perhaps a more common
way that a non-existent path specification arises is when people do
add paths that exist, but then a later merge or rebase or even 'git rm
...' removes them.  In such a case, the path used to be valid, it just
isn't any more.  Perhaps this suggests that the right fallback is to
print a warning and then just ignore that path specification?

(Still have no clue how to handle merge conflicts, as discussed on
patch 4, but maybe this at least addresses one case.)
