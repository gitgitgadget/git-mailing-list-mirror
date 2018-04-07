Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 528531F404
	for <e@80x24.org>; Sat,  7 Apr 2018 00:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeDGAtU (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 20:49:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45991 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDGAtT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 20:49:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id v18-v6so1613014ply.12
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 17:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kP75eLlxRoOs/ApOQq5HonkdshHPE0dezWvSgbn4qcE=;
        b=R26vRVpOk/wRHqni4bBaNNM1/qvdeIhapP2r7SD04OyXApNTfiOL1zv+qefOLpBDOY
         lSs0kI9nzt2iZthsciVIX5ryKqsaUVYWJVzFw0WA4H1UZSwSSL6Uvkxf4GPnTWgE193u
         NLRhb6s8yl9nr+CPLPh2JzHlrwsmb+B/4eqv6uILFkagHOqM6BHMM4qg4HMc6Ds43Llf
         UdJW748WSQfwUDpxTWmvO98vaU/IyqeAYT4UoBu1ABQ5d5DdNtabzDK8j/Q2ATnvjtPv
         oC+sj1nu5fKb0LJCx8VMl496U9k6YcrbVwBYTc1w388P4mvZ6jaIfGG3Cm6mwQv5fAT7
         mt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kP75eLlxRoOs/ApOQq5HonkdshHPE0dezWvSgbn4qcE=;
        b=EVwdlWGC+Q2bLPnT/ZJOREkKqH3fGHsWsEjW9zq2H3H5S8p2u0xaUxA0k05Y/ObNib
         JsPcf3AhqVr6fR4BADL1aBUNqSNLr8vLLDEF0iH8h3Db49BoDG5NO+H8oXRyeMhZIfle
         LZh92un//FoxNG4lRlgQQQK3oI7L6N+6F+d/EySApG69TqqQPut8pLE9foWxIWM3UjPj
         yMu2GDcNMgbmd0iphUE3wwKd6XHp1pWLWYjc81uOiqinI4qtudQO8dENFi8PErszWhYv
         d2717zSQAdOfnoWCHNKMX3TJGamJenWMYWOAkJ1PAve/CaYuTmEAPCMEOqEhJx9vsTOs
         QInw==
X-Gm-Message-State: AElRT7EpVIKtgC/d91ZfsoCaweW9VhnpQJuH0PM8jWNZwkj5f2vCBGm6
        FAT3rrA8ZXvloZUVCm3T2NkVig==
X-Google-Smtp-Source: AIpwx4+tSFCJeJIi8Owmk7mkQ2DfAbA8LYlocE+oBFetOBGFLwtaC5nr9wclnvTpLSeX9yVU3McAGw==
X-Received: by 2002:a17:902:b08a:: with SMTP id p10-v6mr29553718plr.60.1523062158737;
        Fri, 06 Apr 2018 17:49:18 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec81:e7e6:a4ca:eef6])
        by smtp.gmail.com with ESMTPSA id 203sm22559403pfb.50.2018.04.06.17.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 17:49:17 -0700 (PDT)
Date:   Fri, 6 Apr 2018 17:49:16 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] builtin/config: introduce `--default`
Message-ID: <20180407004916.GC78042@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1522996150.git.me@ttaylorr.com>
 <20180406063013.GB662@syl.local>
 <CAPig+cRKaxECLHb1id6Mcd0O3uOiDzdGB4ZxPt1UpwUDi9Xb+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRKaxECLHb1id6Mcd0O3uOiDzdGB4ZxPt1UpwUDi9Xb+g@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 02:53:45AM -0400, Eric Sunshine wrote:
> On Fri, Apr 6, 2018 at 2:30 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > [...]
> > This commit (and those following it in this series) aim to eventually
> > replace `--get-color` with a consistent alternative. By introducing
> > `--default`, we allow the `--get-color` action to be promoted to a
> > `--type=color` type specifier, retaining the "fallback" behavior via the
> > `--default` flag introduced in this commit.
> >
> > For example, we aim to replace:
> >
> >   $ git config --get-color variable [default] [...]
> >
> > with:
> >
> >   $ git config --default default --type=color variable [...]
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/builtin/config.c b/builtin/config.c
> > @@ -286,6 +288,16 @@ static int get_value(const char *key_, const char *regex_)
> > +       if (!values.nr && default_value) {
> > +               struct strbuf *item;
> > +               ALLOC_GROW(values.items, values.nr + 1, values.alloc);
> > +               item = &values.items[values.nr++];
> > +               strbuf_init(item, 0);
> > +               if (format_config(item, key_, default_value) < 0) {
> > +                       die(_("failed to format default config value"));
> > +               }
>
> Unnecessary braces.

Ah, that's leftover from changing this around in your last round of
review. Cleaned up locally.

> Also, an error message such as this is typically more helpful when it
> shows the item which caused the problem:
>
>     die(_("failed to format default config value: %s"), default_value);
>
> However, since the message already says "default", it's pretty easy to
> understand that it's talking about the argument to --default, so it's
> perhaps not such a big deal in this case.
>
> Anyhow, neither point is worth a re-roll.

I like including the value of default_value. I've included it locally,

>
> > +       }
> > @@ -624,6 +636,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >                 usage_with_options(builtin_config_usage, builtin_config_options);
> >         }
> >
> > +
>
> Unnecessary new blank line.
>
> > +       if (default_value && !(actions & ACTION_GET)) {
> > +               error("--default is only applicable to --get");
> > +               usage_with_options(builtin_config_usage,
> > +                       builtin_config_options);
> > +       }
> > diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
> > @@ -0,0 +1,38 @@
> > +test_expect_success 'uses --default when missing entry' '
> > +       echo quux >expect &&
> > +       git config -f config --default quux core.foo >actual &&
> > +       test_cmp expect actual
> > +'
> >
> > +test_expect_success 'canonicalizes --default with appropriate type' '
> > +       echo true >expect &&
> > +       git config -f config --default=true --bool core.foo >actual &&
> > +       test_cmp expect actual
> > +'
>
> I would trust this canonicalization test a lot more if it used one of
> the aliases for "true" since it doesn't presently prove that
> canonicalization is taking place. For instance:
>
>     git config -f config --default=yes --bool core.foo >actual &&
>
> > +test_expect_success 'uses entry when available' '
> > +       echo bar >expect &&
> > +       git config --add core.foo bar &&
> > +       git config --default baz core.foo >actual &&
> > +       git config --unset core.foo &&
> > +       test_cmp expect actual
> > +'
>
> If you happen to re-roll, can we move this test so it immediately
> follows the "uses --default when missing entry" test? That's where I
> had expected to find it and had even written a review comment saying
> so (but deleted the comment once I got down to this spot in the
> patch). Also, perhaps rename the test to make it clearer that it
> complements the "uses --default when missing entry" test; perhaps
> "does not fallback to --default when entry present" or something.

That location makes much more sense, as does using --default=yes to
ensure that canonicalization is taking place. I've updated that locally,
as well as the preceding test to make it clearer that they are
contrasting tests:

	- 'falls back to --default when missing entry'
	- 'does not fallback to --default when entry present'

Though I am not sure about "falls back" to mean "uses --default". I am
not sure which to pick here... what are your thoughts?

Thanks,
Taylor
