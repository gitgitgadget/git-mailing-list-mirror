Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 938B31F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF0S4e (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:56:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38340 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF0S4e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:56:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so1685165pfn.5
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BW/RLfmDeMoKviwTid3P3ufxyVvjEK+srDAI2vtOGyY=;
        b=rXknrJPqIKOvBIND6180KNT1KFlN5u7LaV8AgaXkuL5qLHI8cvdP5Ke7L2GbP2FF2q
         v98/zTdmcZ2ddtfP35kO4SulBVVgqiLWqqMwC0TgAy0iT5DtXlVxD57DoCGuqNL9ht4q
         lIQKwvy0L905enXqzGD+O14pdZAv5mZLYEHlKxN7IdLxTMQ4rXDlMORv1/QgyUiF6dw8
         pMbTmOJdPTw2fs8fqXqPSaSKCJT+IGpDgRcda6YfGIYuauHZPSNfS0Co/LPO7+5TEtDo
         zBtf+Vj0khbxxb3iROtuAv1kT1wWjMRtcaZ7Jqs3y02DzwgIwDXGLajjNjyUHgtdIs5S
         vSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BW/RLfmDeMoKviwTid3P3ufxyVvjEK+srDAI2vtOGyY=;
        b=nlv2gPOpAWI6vWUfDZkUw+JSvg6SwPm+LiiBzGC4+mWRAm4W2G6IqwJSINI6Ug9a/g
         mKgsgLp6R/cUQp+u5JIarWBjf4jYDJVeAeQXUHk64yN8esIXC+JfIv7OJmY+fXVWR7LA
         bAC61kiAf7qiTqr1dilEs5FD2ySAfdqCJaqcbmct6grnmSbZZRYkcmHCGM9v+u/96czg
         eXG6vq9yRw5BlAB/FUgcsWj8emqBE4X2v9ZSKX1vuR4ouR77grvuDkLiRqUBm7fXX0a5
         URRyuFMsHmTryRecEroruK+HJrvRGMgPXcyZcZIMlvc97ahnma14PgJTBHpKfKBHZkGa
         EzbQ==
X-Gm-Message-State: APjAAAXtizVO11Txcfpf6eeOWw3VbqF/KqFmBPn7QCfkzHPV2MCF3hlm
        suNaU3CfweD4JfpAY7upjbHlRjl3Ru4=
X-Google-Smtp-Source: APXvYqz1RP4SexSJgrd8pOjKr3MFwlAOAeGA0XoyC0L2fncU/d+EmHK0YNXnKPDQ2OkSzrjdDwqJbg==
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr7997246pjr.132.1561661793007;
        Thu, 27 Jun 2019 11:56:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id k22sm4362870pfg.77.2019.06.27.11.56.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 11:56:32 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:56:27 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 05/13] walken: configure rev_info and prepare for
 walk
Message-ID: <20190627185627.GC245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-6-emilyshaffer@google.com>
 <CAPig+cRduaOcVyrvhXc2moKSUsZa7-7HLh197xYT035HTQp61w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRduaOcVyrvhXc2moKSUsZa7-7HLh197xYT035HTQp61w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:06:32AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > `struct rev_info` is what's used by the struct itself.
> 
> What "struct itself"? Do you mean 'struct rev_info' is used by the
> _walk_ itself? Or something?

Yep, that's the one. Thanks for the fresh eyes.

> 
> > `repo_init_revisions()` initializes the struct; then we need to set it
> > up for the walk we want to perform, which is done in
> > `final_rev_info_setup()`.
> > [...]
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > diff --git a/builtin/walken.c b/builtin/walken.c
> > @@ -30,6 +31,40 @@ static void init_walken_defaults(void)
> > +/*
> > + * cmd_log calls a second set of init after the repo_init_revisions call. We'll
> > + * mirror those settings in post_repo_init_init.
> > + */
> 
> What is 'post_repo_init_init'?
> 
> I found the reference to cmd_log() confusing because I was looking for
> it in this patch (as if it was being introduced here). Newcomers might
> be even more confused. Perhaps if you state explicitly that you're
> referring to existing code in an existing file, it might be clearer.
> Maybe:
> 
>     builtin/log.c:cmd_log() calls a second ...
> 
> Overall, I find this entire function comment mystifying.

Yeah, this is very stale and never got updated when I realized cmd_log()
was calling two init functions for apparently legacy reasons, and I
didn't need to mirror it here. Again a case where fresh eyes caught
something that became invisible after I stared at it for weeks. I really
appreciate you doing the deep review, Eric.

I've replaced it:

 /*
  * Perform configuration for commit walk here. Within this function we set a
  * starting point, and can customize our walk in various ways.
  */

> 
> > +static void final_rev_info_setup(int argc, const char **argv, const char *prefix,
> > +               struct rev_info *rev)
> > +{
> > +       /*
> > +        * Optional:
> > +        * setup_revision_opt is used to pass options to the setup_revisions()
> > +        * call. It's got some special items for submodules and other types of
> > +        * optimizations, but for now, we'll just point it to HEAD and call it
> > +        * good. First we should make sure to reset it. This is useful for more
> > +        * complicated stuff but a decent shortcut for the first pass is
> > +        * add_head_to_pending().
> > +        */
> 
> I had to pause over "call it good" for several seconds (since I
> couldn't understand why someone would want to write "bad" code) until
> I figured out you meant "do nothing else". It would be clearer simply
> to drop that, ending the sentence at "HEAD":
> 
>     ..., but for now, we'll just point it at HEAD.

Definitely. Done.

> 
> > +       /*
> > +        * struct setup_revision_opt opt;
> > +
> > +        * memset(&opt, 0, sizeof(opt));
> > +        * opt.def = "HEAD";
> > +        * opt.revarg_opt = REVARG_COMMITTISH;
> > +        * setup_revisions(argc, argv, rev, &opt);
> > +        */
> > +
> > +       /* Let's force oneline format. */
> > +       get_commit_format("oneline", rev);
> > +       rev->verbose_header = 1;
> > +
> > +       /* add the HEAD to pending so we can start */
> > +       add_head_to_pending(rev);
> > +}
> 
> It would be easier for the reader to associate the
> add_head_to_pending() invocation with the commented-out setting of
> "HEAD" via 'setup_revision_opt' if the two bits abutted one another
> without being separated by the "oneline" gunk.

Good point, done.
