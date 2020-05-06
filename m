Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240CC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EA32070B
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfFUPFvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgEFVeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728621AbgEFVeA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 17:34:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32D4C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 14:34:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so1632986pjh.2
        for <git@vger.kernel.org>; Wed, 06 May 2020 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uswc5Bwdq5XEm2s0htyVIYs91wVUMpb4FBoySbCWb7o=;
        b=IfFUPFvyNc4JuScC44KBwHqcMfzdXeDU5QEzfkguqST8hh7FYqKFGpqVy1sLLPmmyW
         dyx5ToGzv4k8S6UjzuTd7yEN6trpRjSsA6udOu8SFqwK3qbzzgG340qHXPCjdD+Ugfm8
         R7i4swlWDB1oJxbMM2nguFXdJyTfEcd1sBeRqfTX9xOmc3rL/0iDa7ZKhH0W2pGIAedZ
         ndVszXQ8SYL1CMifWR3VU1Os5rIrgdjuVEiN8sZ1Uryrwv8s7mFDa/rEOcCzNbm8jF1k
         EpJDz/QSECT86eDuLm5jcz5XUq0BfOjHb2rLN0ylqAVSWA4BZZrTxPMCfh4jmWEk+gJY
         Lf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uswc5Bwdq5XEm2s0htyVIYs91wVUMpb4FBoySbCWb7o=;
        b=SkeYNDuVtgF7reE1CiY1tt5FGDgeCWaLUnxC3Xpay03UG3/VfYKbiogvDzywywt88s
         PK+soYIz8PM2HnxZB7f3ZXn2HitS2C3GeT+mGx4E/zc5nfq+GLs0ZyExomJ35hbBHK7J
         M2hjcpV9VeX7PqZmBIEgfP3rZ+a04HwQPgtlXiCOBEGICaS6y29Ups6BRd8Hl3WO//8k
         7NsCddwATx0vxf9rUpxAzqU0p/tDf89TsVGLVNEBk7D7/KG8uX1hHAqq0AgT2tCFP/zp
         yl+cjwX0sANmZoC5mW/7pANFEuNW82Lf2Nsvw7DND981p8AU/mMpxdmyyAQ8GvnBzj2N
         h/MQ==
X-Gm-Message-State: AGi0PubaYE1mgtN8vUS2cxRv9m2OK2rkmkszSHERaFW0E2fIYNeVcGOq
        EY0uY3NSOXwaiXWJ0Cr53g+AVUwB2+g=
X-Google-Smtp-Source: APiQypIZeS/u53yRo3XoGlJmO+J9MiK54KlpRSSu7S8FzBfprCWgd4ouLPB/9eLpiz5XUNOBgSuzqg==
X-Received: by 2002:a17:902:8a8d:: with SMTP id p13mr704914plo.32.1588800839752;
        Wed, 06 May 2020 14:33:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r28sm2745898pfg.186.2020.05.06.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 14:33:59 -0700 (PDT)
Date:   Wed, 6 May 2020 14:33:54 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] doc: propose hooks managed by the config
Message-ID: <20200506213354.GG77802@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200420235310.94493-1-emilyshaffer@google.com>
 <20200425205727.GB6421@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425205727.GB6421@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 08:57:27PM +0000, brian m. carlson wrote:
> 
> On 2020-04-20 at 23:53:10, Emily Shaffer wrote:
> > +=== Config schema
> > +
> > +Hooks can be introduced by editing the configuration manually. There are two new
> > +sections added, `hook` and `hookcmd`.
> > +
> > +==== `hook`
> > +
> > +Primarily contains subsections for each hook event. These subsections define
> > +hook command execution order; hook commands can be specified by passing the
> > +command directly if no additional configuration is needed, or by passing the
> > +name of a `hookcmd`. If Git does not find a `hookcmd` whose subsection matches
> > +the value of the given command string, Git will try to execute the string
> > +directly. Hook event subsections can also contain per-hook-event settings.
> 
> Can we say explicitly that the commands are invoked by the shell?  Or is
> the plan to try to parse them without passing to the shell?

Sure. If I didn't make it clear it was by mistake, not by intent.

> 
> > +Also contains top-level hook execution settings, for example,
> > +`hook.warnHookDir`, `hook.runHookDir`, or `hook.disableAll`.
> > +
> > +----
> > +[hook "pre-commit"]
> > +  command = perl-linter
> > +  command = /usr/bin/git-secrets --pre-commit
> > +
> > +[hook "pre-applypatch"]
> > +  command = perl-linter
> > +  error = ignore
> > +
> > +[hook]
> > +  warnHookDir = true
> > +  runHookDir = prompt
> > +----
> > +
> > +==== `hookcmd`
> > +
> > +Defines a hook command and its attributes, which will be used when a hook event
> > +occurs. Unqualified attributes are assumed to apply to this hook during all hook
> > +events, but event-specific attributes can also be supplied. The example runs
> > +`/usr/bin/lint-it --language=perl <args passed by Git>`, but for repos which
> > +include this config, the hook command will be skipped for all events to which
> > +it's normally subscribed _except_ `pre-commit`.
> > +
> > +----
> > +[hookcmd "perl-linter"]
> > +  command = /usr/bin/lint-it --language=perl
> > +  skip = true
> > +  pre-commit-skip = false
> > +----
> 
> This seems fine to me.  I like this design and it seems sane.
> 
> > +== Implementation
> > +
> > +=== Library
> > +
> > +`hook.c` and `hook.h` are responsible for interacting with the config files. In
> > +the case when the code generating a hook event doesn't have special concerns
> > +about how to run the hooks, the hook library will provide a basic API to call
> > +all hooks in config order with an `argv_array` provided by the code which
> > +generates the hook event:
> > +
> > +*`int run_hooks(const char *hookname, struct argv_array *args)`*
> > +
> > +This call includes the hook command provided by `run-command.h:find_hook()`;
> > +eventually, this legacy hook will be gated by a config `hook.runHookDir`. The
> > +config is checked against a number of cases:
> > +
> > +- "no": the legacy hook will not be run
> > +- "interactive": Git will prompt the user before running the legacy hook
> > +- "warn": Git will print a warning to stderr before running the legacy hook
> > +- "yes" (default): Git will silently run the legacy hook
> > +
> > +If `hook.runHookDir` is provided more than once, Git will use the most
> > +restrictive setting provided, for security reasons.
> 
> I don't think this is consistent with the way the rest of our options
> work.  What if someone generally wants to disable legacy hooks but then
> works with a program in a repository that requires them?

Unfortunately this is something I think my end will want to hold firm
on. In general we disagree with your statement later about not wanting
to make the .git/config secure. I see your use case, and I anticipate
two possible workarounds I'd present:

1) If working in that repo for the short term, run `git -c
hook.runHookDir=yes <command> <arg...>` (and therefore allow the config
from command line scope, which I'm happy with in general). Maybe
someone would want to use an alias, hookgit or hg? Just kidding.. ;P

2) If you're stuck with that repo for the long term, add
`hook.<hookname>.command = /path/.git/hooks/<hookname>` lines to the local
config.

Yes, those are both somewhat user-unfriendly, and I think we can do
better... I'll have to think more and see what I can come up with.
Suggestions welcome.

> 
> > +== Caveats
> > +
> > +=== Security and repo config
> > +
> > +Part of the motivation behind this refactor is to mitigate hooks as an attack
> > +vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
> > +however, as the design stands, users can still provide hooks in the repo-level
> > +config, which is included when a repo is zipped and sent elsewhere.  The
> > +security of the repo-level config is still under discussion; this design
> > +generally assumes the repo-level config is secure, which is not true yet. The
> > +goal is to avoid an overcomplicated design to work around a problem which has
> > +ceased to exist.
> 
> I want to be clear that I'm very much opposed to trying to "secure" the
> config as a whole.  I believe that it's going to ultimately lead to a
> variety of new and interesting attack vectors and will lead to Git
> becoming a CVE factory.  Vim has this problem with modelines, for
> example.

I'm really interested to hear more - it seems like security and config
efforts will end up on my plate before the end of the year, so I'd like
to know what is on your mind.

> 
> I think we should maintain the status quo that the only safe things you
> can do with an untrusted repository are clone and fetch because it sets
> a clear security boundary.

I wish there was a way to make that more apparent. The trouble is that
while you and I and the sysadmin know the dangers, the high schooler
making a website might not. Talking about how to warn users is
definitely out-of-scope for this conversation, but it's on my mind.

> 
> Having said that, I'm otherwise pretty happy with this design and I'm
> looking forward to seeing it implemented.

Thanks very much for the feedback and for reading it through! :)

 - Emily
