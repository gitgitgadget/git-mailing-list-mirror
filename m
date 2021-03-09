Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE51C433E9
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78DE64FAD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhCIVjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCIVij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:38:39 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD22EC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:38:38 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d16so7342096oic.0
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UOJDGB4IQh0XSe3McEwKnPKb3ySvwLu9LVlkC4pmNLQ=;
        b=dMSSoD6duQ9PzOwMWQcB9K6bwbezF+0pYSAeEWMh+/rubwmh10hxcKYuz9/UU4EpQd
         Hz0xwdOJLJ/ZMoXaEqf/gmduVS869bg6+MeSEGMqi0sNoUS5ueD4LgracfLJtnhfDPSs
         VErHR45sGz9wzVYwAI1ela/c01odcWZlZNgPF4XwBi5d3gJ3oRXzqPuUc5yXqXV8zWib
         yfzGQa7MRWn5EtSRcw5JGXxUH093IDTA3nr77rhRm7nLULJtwtOGJR+uGV2uUuHb8TKV
         /MZo39fFSXWYnaHpb3bZwWq6opVi8Z0makmwRIoXaiLwKcgdEGlXHsMWaSbchh7uyDJF
         ZMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UOJDGB4IQh0XSe3McEwKnPKb3ySvwLu9LVlkC4pmNLQ=;
        b=laN017idQzKFlt5s2IUR4CmNLZ4hj+FjmSgCWUDA47IVLKuGaCKHoGZaK6QSnCBvaQ
         QFXAQxqVcwqo+uRo6GAmnYbDI3wjhqoHFDMB4WOuDU/TTAHlmBisf0VRfjvril95vy/a
         RXMKDIO2smnHtTx6VnebOHkwVAYMn9F/KtIwLk+L53VIyNgCpso457rAEOIghunOSzZu
         MzIPwxtgzyyY85HfSmUHwwcKQ78OUkwVtdqrtC+yCePMkRhFeYTOdolDa/qZk8FQln8v
         TsW4Eff1BFBxDYKCExPkBS2BqalJyYF7nCTQ8Az9HjUJfGJHUDJmh/VhgSPOGXnpCiNd
         qpfQ==
X-Gm-Message-State: AOAM532dF0WkRfzme5q48zDIndg9+eBQvW/pKw8ZYtxNuWNGM46d46Um
        LxtfnC+oUJk3ibmUBbps2nWsatIUxQrZtwv2VQE=
X-Google-Smtp-Source: ABdhPJyzU57DyJFs6XFDP8iyCR46TXYj/Vj5Gl9dxwMR+vk4s0yxcodkAoWWwmid2bVxhVmxXOrPylQeUH7Kw4IkGr0=
X-Received: by 2002:aca:b489:: with SMTP id d131mr136064oif.39.1615325918273;
 Tue, 09 Mar 2021 13:38:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <6d6b230e3318007150aebefebc16dfb8b9b6c401.1614111270.git.gitgitgadget@gmail.com>
 <CAN0heSqPTASn61KKGvWEA3ronaWEPWGP23LUg36JiMxxHEd0zQ@mail.gmail.com>
 <466cb063-0481-cfa6-cc3e-8ca26d73c8fb@gmail.com> <CABPp-BG8Jox=tgVihxOvHXWC2t2wDvDr8BN2VLBmHrJ-r9B3Pg@mail.gmail.com>
 <ca080280-2f35-60fd-cafa-43b18d06cb1b@gmail.com>
In-Reply-To: <ca080280-2f35-60fd-cafa-43b18d06cb1b@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 13:38:27 -0800
Message-ID: <CABPp-BHRNdgLYq4c+uc5wuiPU894xT4PxAJ8hM80zwmXGhOdww@mail.gmail.com>
Subject: Re: [PATCH 16/20] sparse-checkout: toggle sparse index from builtin
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 9, 2021 at 1:10 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/9/2021 4:03 PM, Elijah Newren wrote:
> > On Tue, Mar 9, 2021 at 12:52 PM Derrick Stolee <stolee@gmail.com> wrote=
:
> >>
> >> On 2/24/2021 2:11 PM, Martin =C3=85gren wrote:
> >>> There are several "layers" here, for lack of a better term. "Enabling=
 foo
> >>> enables bar which may cause baz. If you fail due to baz, try dropping
> >>> bar by dropping foo." If I remove any mention of the config variable =
from
> >>> your text, I get the following.
> >>>
> >>>  Enabling sparse index might cause other tools to stop working with y=
our
> >>>  repository. If you have trouble with this compatibility, then run `g=
it
> >>>  sparse-checkout sparse-index disable` to rewrite your index to not b=
e
> >>>  sparse.
> >>>
> >>> I'm tempted to suggest such a rewrite to relieve readers of knowing o=
f
> >>> the middle step, which you could say is more of an implementation
> >>> detail. But if we think that the symptoms / error messages might invo=
lve
> >>> "extensions.sparseIndex" or, as would be the case with an older Git
> >>> installation,
> >>>
> >>>   fatal: unknown repository extensions found:
> >>>           sparseindex
> >>>
> >>> maybe there is some value in mentioning the config item by name. Just
> >>> thinking out loud, really, and I don't have any strong opinion. I onl=
y
> >>> came here to point out the typo in the docs.
> >>
> >> I agree that the layers are confusing. We could rearrange and have
> >> a similar flow to what you recommend by mentioning the extension at
> >> the end:
> >>
> >> **WARNING:** Using a sparse index requires modifying the index in a wa=
y
> >> that is not completely understood by other tools. If you have trouble =
with
> >> this compatibility, then run `git sparse-checkout sparse-index disable=
` to
> >> rewrite your index to not be sparse. Older versions of Git will not
> >> understand the `sparseIndex` repository extension and may fail to inte=
ract
> >> with your repository until it is disabled.
> >>
> >> Thanks,
> >> -Stolee
> >
> > This looks pretty good to me, but could we change the first sentence
> > to read "...modifying the index in a way that may not yet be
> > understood by external tools." ?  I'm worried "other tools" might make
> > people worry about different builtin commands (e.g. fast-export, log).
> > I also prefer "may" and "yet" because I suspect most external tools
> > (e.g. git filter-repo just to name a personal example) won't need to
> > read an index format and will thus be unaffected, and any tools that
> > do read the index format will probably eventually learn how to work
> > with the new format.
>
> I can make the change, but I do want to point out that the current
> use of a repository extension _does_ mean that tools that (correctly)
> interact with a Git repository should fail even if they don't try to
> access the index file. This is only something to make this work until
> we introduce a new index file format version and then can drop the
> extension.

Good point, though...

> "git filter-repo" _should_ be safe because it's really just shelling
> to Git, right? I'm more concerned about tools like libgit2.

Yes, libgit2 and jgit and similar tools are clearly going to be
affected and deeply.  Those are of concern, but I suspect most users
when they see "external tools" will be thinking of the large multitude
of scripts out there that just shell out to git under the hood to
provide some higher level wrapper of some sort.  And anything that
operates that way won't be affected directly by the repository
extension.

I'm not sure I'd even mark things that shell out to git as _should_ be
safe.  In general, scripts can make all kinds of assumptions on
interpreting output, and I suspect some of those may become
invalidated by this new feature.  We have a recent guidepost that's
very close to home on that too -- git stash had *3* different bugs in
it once sparse-checkouts were introduced, based on the fact that it
was designed as a just-shell-out-to-low-level-git-commands script and
it made assumptions on how those commands worked together.  See
https://lore.kernel.org/git/ccfedc7140dbf63ba26a15f93bd3885180b26517.160686=
1519.git.gitgitgadget@gmail.com/.
Sure git-stash is a builtin (supposedly, anyway), but external tools
can make similar logical jumps.
