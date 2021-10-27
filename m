Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAD4C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D15610A3
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhJ0Rz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhJ0Rz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 13:55:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD0C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:53:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z2-20020aa79482000000b0047c0239f1e3so1953748pfk.22
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=01UMO02YkBm9L3Jtkq0L7b5KUTLdpIlz2OkPqcaGvtE=;
        b=i6PTNgyDEOiEBNMDhFgl9o00e1/jAQ2ezxHksl/Wf3wL8OzhfM3QYgihPGu7CVcmKJ
         EoHUzrkd0aNOGS+dwVt846QlRDmK/Fmnpa5tqKQd/osVLK9IB/Gfk3jQ+F6QhhFwocz6
         Kn1JZ4r2e15ysO/ukS5bpRwWQghkLmRFEslqtYObWSzVKJsHgX1Z7sdLigKwo5xftEQI
         /mqOyh+PUDPVIOyh2nQTNOJVkG2pjNTezCS/JDsf7y3d2E0dyuAA8WrdX6iMyrdZQ+E9
         x4DZohWdf/qFJoMzJ/LfLGwmbemqvuib3HDHOJst2pSg7qOW7WtzbPNY7UbyxQ6SPEwJ
         Kl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=01UMO02YkBm9L3Jtkq0L7b5KUTLdpIlz2OkPqcaGvtE=;
        b=bV5OkOayBBhK6RJkFwuQpmz9foLyu9MHwsAHon7koOvP8hE4vMEdJPUuJt6f1xErHN
         L+s7SwlYWj64E4pjKi9KAHgW/nBxSTT0yW4NeNRQBBt9xQkRV70KSfBbLIEkb1D5r3fy
         qRUiYwdDTZxysdmBMq4VUzEoU6Ipz/pZXORQi3Tm+vdxqNprbNM3iK6ypqTYGeqqokxc
         y4Iji8Uv8x/1RolBtNorSvVml64jd+t9T8avWbTd0BKpt+QApGNDjB3mPZfmQPy7IMCQ
         Ut8rFm1ZLuYXsY18dXPedXkb1ijLCcgeb6aoZewhUN+Hbb/4zc0MJ1Z3FXqCe2h4cALn
         40lA==
X-Gm-Message-State: AOAM530DEk5OH6MlAUGKOA7tP5DTiyi4oJmYOXbDc5IIurHQ/YX+zX3Y
        5Qhr5nVrCkPjfZh93EY9DhM6/5sFLjn4//0LsN8c
X-Google-Smtp-Source: ABdhPJxbRDuv28MAKL+Dzw3UBSjczqhL9eqGiFcpWgFQ0Q1h0A8Y6pElEb8VvPISiv9sUjp28bQJq5CnLfGXAthYWRpu
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:844b:0:b0:47b:eb1a:4afc with
 SMTP id k72-20020a62844b000000b0047beb1a4afcmr23125840pfd.73.1635357181495;
 Wed, 27 Oct 2021 10:53:01 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:52:59 -0700
In-Reply-To: <YXk+TRnndNZkdsGF@coredump.intra.peff.net>
Message-Id: <20211027175259.2230232-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YXk+TRnndNZkdsGF@coredump.intra.peff.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Oct 18, 2021 at 01:48:03PM -0700, Jonathan Tan wrote:
> 
> >  (1) Introduce a "includeAfterIf" (or "deferIncludeIf", or some other
> >      name) command that is executed after all config files are read. (If
> >      there are multiple, they are executed in order of appearance.)
> >      Files included by this mechanism cannot directly or indirectly
> >      contain another "includeAfterIf". This is the same as what was
> >      introduced in this patch set, except for the name of the directive.
> 
> I think this works in terms of having self-consistent rules that make
> sense. But deferring things does introduce new complications in terms of
> overrides, because we rely on last-one-wins. Emily asked elsewhere about
> overriding the inclusion of a file. We don't have a way to do that now,
> and I think it would be tricky to add. But what about overriding a
> single variable?
> 
> Right now this works:
> 
>   git config --global foo.bar true
>   git config --local foo.bar false
> 
> to give you "false". But imagining there was a world of deferred config,
> then:
> 
>   git config --file ~/.gitconfig-foo foo.bar true
>   git config --global deferInclude.path .gitconfig-foo
>   git config --local foo.bar false
> 
> gives "true". We'd read .gitconfig-foo after everything else, overriding
> the repo-level config.
> 
> If the deferred includes were processed at the end of each individual
> file, that would solve that. You're still left with the slight oddness
> that a deferred include may override options within the same file that
> come after it, but that's inherent to the "defer" concept, and the
> answer is probably "don't do that". It's only when it crosses file
> boundaries (which are explicitly ordered by priority) that it really
> hurts.

This would indeed solve the issue of the user needing to know the trick
to override variables set by deferred includes. But this wouldn't solve
our primary use case in which a system-level config defines a
conditional include but the repo config defines the URL, I think.

> >  (2) Leave the name as "includeIf", and when it is encountered with a
> >      remote-URL condition: continue parsing the config files, skipping
> >      all "includeIf hasRemoteUrl", only looking for remote.*.url. After
> >      that, resume the reading of config files at the first "includeIf
> >      hasRemoteUrl", using the prior remote.*.url information gathered to
> >      determine which files to include when "includeIf hasRemoteUrl" is
> >      encountered. Files included by this mechanism cannot contain any
> >      "remote.*.url" variables.
> 
> I think doing this as "continue parsing" and "resume" is hard to do.
> Because you can't look at other non-remote.*.url entries here (otherwise
> you'd see them out of order). So you have to either:
> 
>   - complete the parse, stashing all the other variables away, and then
>     resolve the include, and then look at all the stashed variables as
>     if you were parsing them anew.
> 
>   - teach our config parser how to save and restore state, including
>     both intra-file state and the progress across the set of files

I am implementing something similar to your first approach (stashing
things). It's almost done so hopefully we'll have something concrete to
discuss soon.

> I think it's much easier if you think of it as "start a new config parse
> that does not respect hasRemoteURL". And the easiest way to do that is
> to just let remote.c's existing git_config() start that parse (probably
> by calling git_config_with_options() and telling it "don't respect
> hasRemoteURL includes"). You may also need to teach the config parser to
> be reentrant. We did some work on that a while ago, pushing the state
> int config_source which functions as a stack, but I don't offhand know
> if you can call git_config() from within a config callback.

Besides the reentrancy (which may be difficult, as there are some global
variables, but from a glance, some code seems to take care to save and
restore them, so it may already be reentrant or not too difficult to
make reentrant), we would have to bubble down the config (struct
git_config_source and struct config_options) into all the places that
could potentially start the parse and also have a place to store the
URLs we get. If we're already going to stash URLs, it may be easier to
stash the variables instead.

> > There are other ideas including:
> > 
> >  (3) remote.*.url must appear before a "includeIf hasRemoteUrl" that
> >      wants to match it. (But this doesn't fit our use case, in which a
> >      repo config has the URL but a system or user config has the
> >      include.)
> 
> Yeah, I agree this won't work.
> 
> >  (4) "includeIf hasRemoteUrl" triggers a search of the repo config just
> >      for remote.*.url. (I think this out-of-order config search is more
> >      complicated than (2), though.)
> 
> I think this is what I described above, and actually is less
> complicated. ;)
> 
> -Peff

Well, let me finish up (2), and let's see.
