Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843F6C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD1920740
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Wdgb0CC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbgEMAFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMAFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 20:05:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C0C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 17:05:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so15731384ljl.2
        for <git@vger.kernel.org>; Tue, 12 May 2020 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaCz6+riharYwiRZjy+ZCYr0uAVopQotyPZJAHV9ya8=;
        b=Wdgb0CC7LAuJS/zVWbWbxBqscG8WMpyfmM5sgP+733j6TmH9vLnoffzX939WxRkJPE
         QZxcqXZ01cDUs9NOL041tvuIQk1VGLqSeL8zh1nO/wBuKmY+xQCEiR1pOUVr+wstrvsF
         BORXzetywW30qeFa5d4Z1ioE37JCHpkgUxG/hONg3uJkZ7EKSi550DcMD280jqWx4kkE
         wnjQ9XoQp5CWoY8HWB8NQfTbn5d1y4/2vAby7I6JxuBLDX0zPT/l6PAmf3aEQrNO2jEb
         Jj0oIHDfjTCABd7tptb4RRZlTORqk/ImuCgjlN6S1ZkX5sFgf4/k0dGttMYxZ7Q7HtXP
         lIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaCz6+riharYwiRZjy+ZCYr0uAVopQotyPZJAHV9ya8=;
        b=mFZZ4AwX1iqdVe3hCkGvJQAYBiqS0w1uQbjx6igcXe7g8OFXZJ7k5F/RG6PIYVVDRC
         NUPaB/OI7q4xMo4l5T+lyN0ur/bl250xBLbVhEnWmJxDN0YtIXLtifkgKQimKrjwUCbl
         54VAw0MX0VsJlpHJPn86JPbX18040RA3Duxi/Ut0yJXTe8UQcPfc2FqPd7XdeMvI1PzB
         1VsQDn4zYqGw45boLBDgC88oXahLf3tKHCF7u7v8InSD/OfcwKtyX+NIeviwS7g4EsDp
         7gCflbRR42h7bJw5XNSvB4MPXATcwktNPp4+cXIwEM+O9jB++98vh1ifB9mNIOpIPypu
         8ziQ==
X-Gm-Message-State: AOAM530gvoU01GBjn9HD50mpOfdnM5waDwjwoI+gK7nVBD0/PbHO85+3
        X0MA87+YldwpAxWeGOPxDIEiHRs/AAiJPf4PjT998A==
X-Google-Smtp-Source: ABdhPJyo9uIc9/TRPcLirY09ODD9UoZGWXe9jlBM9BR6DnMWR56gMOtCbVBn8ym5wonc71buqfm+2fI1NA+SMO9yxOA=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr15546509lji.73.1589328329712;
 Tue, 12 May 2020 17:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br>
 <e00674c7278b032b826110f33e25a5dee176c7ba.1589058209.git.matheus.bernardino@usp.br>
 <xmqqh7wmqn7k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7wmqn7k.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 12 May 2020 21:05:18 -0300
Message-ID: <CAHd-oW4k-9ZHQJcqEUqzxw0YShPWCaG61=v4wyBvXte2sSTV5g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 4:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > One of the main uses for a sparse checkout is to allow users to focus on
> > the subset of files in a repository in which they are interested. But
> > git-grep currently ignores the sparsity patterns and report all matches
> > found outside this subset, which kind of goes in the opposite direction.
> > Let's fix that, making it honor the sparsity boundaries for every
> > grepping case:
> >
> > - git grep in worktree
> > - git grep --cached
> > - git grep $REVISION
>
> It makes sense for these to be limited within the "sparse" area.
>
> > - git grep --untracked and git grep --no-index (which already respect
> >   sparse checkout boundaries)
>
> I can understand the former; those untracked files are what _could_
> be brought into attention by "git add", so limiting to the same
> "sparse" area may make sense.
>
> I am not sure about the latter, though, as "--no-index" is an
> explicit request to pretend that we are dealing with a random
> collection of files, not managed in a git repository.  But perhaps
> there is a similar justification like how "--untracked" is
> unjustifiable.  I dunno.

Yeah, I think there was no need to mention those two cases here. My
intention was to say that, in these cases, we should stick to the
files that are present in the working tree (which should match the
sparsity patterns + untracked {and ignored, in --no-index}), as
opposed to how the worktree grep used to behave until now, falling
back to the cache on files excluded by the sparse checkout.

> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index a5056f395a..91ee0b2734 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -410,7 +410,7 @@ static int grep_cache(struct grep_opt *opt,
> >                     const struct pathspec *pathspec, int cached);
> >  static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >                    struct tree_desc *tree, struct strbuf *base, int tn_len,
> > -                  int check_attr);
> > +                  int is_root_tree);
> >
> >  static int grep_submodule(struct grep_opt *opt,
> >                         const struct pathspec *pathspec,
> > @@ -508,6 +508,10 @@ static int grep_cache(struct grep_opt *opt,
> >
> >       for (nr = 0; nr < repo->index->cache_nr; nr++) {
> >               const struct cache_entry *ce = repo->index->cache[nr];
> > +
> > +             if (ce_skip_worktree(ce) && !S_ISGITLINK(ce->ce_mode))
> > +                     continue;
>
> Hmph.  Why exclude gitlink from this rule?  If a submodule sits at a
> path that is excluded by the sparse pattern, should we still recurse
> into it?

The idea behind not skipping gitlinks here was to be compliant with
what we have in the working tree. In 4fd683b ("sparse-checkout:
document interactions with submodules"), we decided that, if the
sparse-checkout patterns exclude a submodule, the submodule would
still appear in the working tree. The purpose was to keep these
features (submodules and sparse-checkout) independent. Along the same
lines, I think we should always recurse into initialized submodules in
grep, and then load their own sparsity patterns, to decide what should
be grepped within.

[...]
> > +static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> > +                  struct tree_desc *tree, struct strbuf *base, int tn_len,
> > +                  int is_root_tree)
> > +{
> > +     struct pattern_list *patterns = NULL;
> > +     int ret;
> > +
> > +     if (is_root_tree)
> > +             patterns = get_sparsity_patterns(opt->repo);
> > +
> > +     ret = do_grep_tree(opt, pathspec, tree, base, tn_len, is_root_tree,
> > +                        patterns, 0);
> > +
> > +     if (patterns) {
> > +             clear_pattern_list(patterns);
> > +             free(patterns);
> > +     }
>
> OK, it is not like this codepath is driven by "git log" to grep from
> top-level tree objects of many commits, so it is OK to grab the
> sparsity patterns once before do_grep_tree() and discard it when we
> are done.

Yeah. A possible performance problem here would be when users pass
many trees to git-grep (since we are reloading the pattern lists, from
both the_repository and submodules, for each tree). But, as Elijah
pointed out [1], the cases where this overhead might be somewhat
noticeable should be very rare.

[1]: https://lore.kernel.org/git/CABPp-BGUf-4exGW23xka1twf2D=nFOz1CkD_f-rDX_AGdVEeDA@mail.gmail.com/
