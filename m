Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EECC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F7B2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="H4UT5c6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgFJVQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgFJVQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:16:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B396FC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:16:00 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z206so2305170lfc.6
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wv3q/cXi1Nx0P6ygB7ulDEjRJRhp/8q3hZnzpovdZTc=;
        b=H4UT5c6nQLsQJgWW0Cm0XZvh74gYRI94RKc5EMxWsJ0+hdXLYkvlgzu973Za5Xf5qM
         +kR3oroFyGkjYjJmPHDOJ45c9h/ISeHveKvdQsjlppTpbGETc+KmBCbhd0kPGp6v/eil
         nXou1lY12bSJ+z/lty56cKnubm4oosw0jbVn1REbt1bB2fF+x+n8SB+to6j5/byrLj1K
         04HFVoh5Vti9kcAbHCbM3p7+BKijhhE2vYuDBPxoGSuaijRKSpHeoPUD4B7j63kfIhQI
         g7lacM76YQJEv/kyWzqbGCQGjKWdMUxD/sTuLljBugppUKhcNHWRw3Xu6NqZ0ehUyfaf
         EkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wv3q/cXi1Nx0P6ygB7ulDEjRJRhp/8q3hZnzpovdZTc=;
        b=YrAUoZLNr/cPY7NEl6+pmu6w+1Vl8yj7Tt7U8WjhjhGLDHl6ma/3rOQYO9qjrCMTSJ
         b5SeCR598vK231NPL4z6E9G+a6HEODHd7QpeiieC2VvPGz0IdulbsqValv6R7X15mvM6
         jwdUJ+gdWYXybKxRPmozwQTUDEX2DjKHg0QRxIYsBcSCEHTw61SdIZjYjrGPNn6iNzKK
         lerNbYWPZzyBk6m04Ts/KB2YXxWGENWOhoWEsV3rN++ch/ngSqgTeRR7y9lxub1PWiU2
         kyk12kqBm2CnlAOW9GMEt6fQ2Opwq/+R8z9o35iDer712OIpjRsyrtlKxoLVXz5Zpzo9
         l9aw==
X-Gm-Message-State: AOAM531y4YcPcoeqeenoQvGJLDXDi2G7tG40xonGQNrBtiALci7x3KPZ
        ONWd+Xu5yxxi/PWsBTGm+r0oH85/gN6OViUpBH2aZA==
X-Google-Smtp-Source: ABdhPJxKY009VHwe5oUtWLwIZ/F6FAivs67pePjfjJpOMLKnt00RzGRk/td6WwzdHViJh9O5fTlDzo1IRwDURLO/BB8=
X-Received: by 2002:a19:5206:: with SMTP id m6mr2616622lfb.144.1591823758860;
 Wed, 10 Jun 2020 14:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <748b1e955ccdcf7cd897a180f4b4fe82d7bfcf00.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BHzHhBVGZ+vOgE4jTCT3HJzXo+gzZ+6SVGDUWWdfkL6Dw@mail.gmail.com>
 <CAHd-oW7b41hqfPXm_GL_sth+QRfx56ceMr4VM9B9xhj3_P9iGQ@mail.gmail.com> <CABPp-BH0d5WKz7bXLkFQGDBKXbd0tccS_+1_iNc1Wqr93h+KaQ@mail.gmail.com>
In-Reply-To: <CABPp-BH0d5WKz7bXLkFQGDBKXbd0tccS_+1_iNc1Wqr93h+KaQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 10 Jun 2020 18:15:47 -0300
Message-ID: <CAHd-oW5gqs1uG5L4=JaT6Jzs58StE1WO0goPJE2atumbyC3Wow@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] config: add setting to ignore sparsity patterns in
 some cmds
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 2, 2020 at 11:40 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Sun, May 31, 2020 at 9:46 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
>
> Moving it to grep's manpage seems ideal to me.  grep's behavior should
> be defined in grep's manual.
>
> > sparse.restrictCmds::
> > See complete definition in linkgit:git-config[1]. In grep, the
> > restriction takes effect in three cases: with --cached; when a
> > commit-ish is given; when searching a working tree where some paths
> > excluded by the sparsity patterns are present (e.g. manually created
> > paths or not removed submodules).
>
> That looks more than a little confusing.  Could this definition be
> something more like "See base definition in linkgit:git-config[1].
> grep honors sparse.restrictCmds by limiting searches to the sparsity
> paths in three cases: when searching the working tree, when searching
> the index with --cached, or when searching a specified commit"

Yes, this looks better, thanks. I would only add a brief explanation
on what we mean by limiting the search in the working tree case. Since
the working tree should already contain only the sparse paths (in most
cases), I think this sentence may sound a little confusing without
some explanation. Even further, some users might expect that `git -c
sparse.restrictCmds=false grep $pattern` would restore the previous
behavior of falling back to the cache for non-present entries, which
is not true.

In particular, I would like to emphasize that the use for
`sparse.restrictCmds=false` in the working tree case, is for
situations like the one you described in [1]:

* uses sparse-checkout to remove a bunch of files/directories they
don't care about
* creates a new file that happens to have the same name as an
(unfortunately) generically worded filename that exists in the index
(but is marked SKIP_WORKTREE and had previously been removed)

In this situation, grep would ignore the said file by default, but
search it with `sparse.restrictCmds=false`.

So what do you think of the following:

sparse.restrictCmds::
See base definition in linkgit:git-config[1]. grep honors
sparse.restrictCmds by limiting searches to the sparsity paths in
three cases: when searching the working tree, when searching the index
with --cached, and when searching a specified commit. Note: when this
option is set to true (default), the working tree search will ignore
paths that are present despite not matching the sparsity patterns.
This can happen, for example, if you create a new file in a path that
was previously removed by git-sparse-checkout. Or if you don't
deinitialize a submodule that is excluded by the sparsity patterns
(thus remaining in the working copy, anyway).

[1]: https://lore.kernel.org/git/CABPp-BE+BL3Nq=Co=-kNB_wr=6gqX8zcGwa0ega_pGBpk6xYsg@mail.gmail.com/
