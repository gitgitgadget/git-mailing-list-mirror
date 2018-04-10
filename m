Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8F51F404
	for <e@80x24.org>; Tue, 10 Apr 2018 02:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeDJCM5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 22:12:57 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:35108 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeDJCM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 22:12:56 -0400
Received: by mail-pl0-f43.google.com with SMTP id 61-v6so6387821plb.2
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 19:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IhRmfXMHoFXe3BXMi/FzSkH7Pik5kddgQXdqcACV9Gs=;
        b=hpvkw4tpIgMoLJ07JxUnMMeOo+Ask2dB39hyJdwgUks5Pcw3zmIV3+34TTNUIKXvLf
         PTBUr3BOVst8QT6d2etcqOFAEUWoIXmUI2TageWd6jFLiOHkg2V4lAbb1ciqdt+MBZKe
         wJtS5rG8LkUx6ZpTKJ6VfXP1GlNFnKVArMXovxejXU1cz8OyE9nFverhCbsnDTT8VDcr
         SArRIr2BLK85DhAbxKuGf5Cd/yjD/kqR0X2XKSsdwdxlOgcEMyzV65/sjvoMA45oGvXH
         fHux81PVYUmOOzc5Fp0VO5QpWjmeDjQYQ99ATu4uKp0cf9Dy1SkgJgfRntAvzjJ4Y7eH
         O4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IhRmfXMHoFXe3BXMi/FzSkH7Pik5kddgQXdqcACV9Gs=;
        b=H1X5Fi1eIR0FtT7l5+noHKYZHLOiXcCV51vdJo/E2MOitOwvAgah8IV5lU7Wa45uIF
         Ol3eTD3NeqGgqgsw4BxA0nF6x64G3SMRnSUDvtsC1b4LjKq78WMSDx42epVk/N4kEJCE
         sYkbXrLmM9mpIqRu9YxdH3Idb/00Kbig/ty3cMmElEEvSWVU3cbmotDXSLW14AIMBxWX
         pCoYjKXHbeGgheKCYf4o4m94HuaAvdSeP3YD8hhEGzbmhQmDmVltd00fAiGmczn8ByCu
         MvYNzavJciYsiuiVnodiANJqxvDml8yYQA40uC6WDX49MnlHyRQEi1Oj14gltq6jwNTA
         vWgw==
X-Gm-Message-State: AElRT7HlleWVEf38GEc1WhLYgqh/qpYcwdnV/WxUZqlhl6NMVnvWpWN6
        mZCWjlmO+rx28IpOXewCN6MerNKiw64=
X-Google-Smtp-Source: AIpwx48DDnah/RIqatUkNd7E73IMnQAI4YBH2KRAw3Zqf31lTI5NCCDfR6EtDp3kNj8Bl1+rg/ivdQ==
X-Received: by 2002:a17:902:5a0b:: with SMTP id q11-v6mr42458088pli.199.1523326375646;
        Mon, 09 Apr 2018 19:12:55 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id c186sm2489929pfb.40.2018.04.09.19.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 19:12:53 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 9 Apr 2018 19:12:53 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        ericsunshine@sunshineco.com
Subject: Re: [PATCH v7 1/2] builtin/config.c: treat type specifiers singularly
Message-ID: <20180410021253.GA937@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1523313730.git.me@ttaylorr.com>
 <20180409224654.GB34547@syl.local>
 <xmqqy3hv4zzi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3hv4zzi.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 10:22:25AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Internally, we represent `git config`'s type specifiers as a bitset
> > using OPT_BIT. 'bool' is 1<<0, 'int' is 1<<1, and so on. This technique
> > allows for the representation of multiple type specifiers in the `int
> > types` field, but this multi-representation is left unused.
> >
> > In fact, `git config` will not accept multiple type specifiers at a
> > time, as indicated by:
> >
> >   $ git config --int --bool some.section
> >   error: only one type at a time.
> >
> > This patch uses `OPT_SET_INT` to prefer the _last_ mentioned type
> > specifier, so that the above command would instead be valid, and a
> > synonym of:
> >
> >   $ git config --bool some.section
> >
> > This change is motivated by two urges: (1) it does not make sense to
> > represent a singular type specifier internally as a bitset, only to
> > complain when there are multiple bits in the set. `OPT_SET_INT` is more
> > well-suited to this task than `OPT_BIT` is. (2) a future patch will
> > introduce `--type=<type>`, and we would like not to complain in the
> > following situation:
> >
> >   $ git config --int --type=int
>
> The above does not exactly argue for adopting the last-one-wins
> semantics, and still leaves it unclear if we want to complain
> against
>
>     $ git config --bool --type=int
>
> Is it intentionally left vague if we want to (or not want to)
> complain when such a conflicting specification is given?
>
> We could keep the traditional behaviour of "only one type at a time"
> error and still move away from the bitset representation that does
> not make sense, if we wanted to.  Initialize the "type" variable to
> an unset value, and use a callback to ensure either the variable is
> set to the unset value, or the value being set is already in the
> variable.  I think if you use OPT_CMDMODE(), it would do all of that
> for you automatically.
>
> I suspect that it may be OK to switch to last-one-wins, but then we
> should give a justification that is a bit stronger than "we want to
> avoid complaining against --int --type=int" (i.e. "we want to switch
> to last-one-wins for such and such reasons").

I think that the major justification is to treat --type=int as a _true_
synonym of --int, such that neither `--type=<t1> --type=<t2>` nor
`--<t1> --<t2>` will complain. This, as well as the fact that
OPT_SET_BIT brings us closer to the semantics of `--verbose=1
--verbose=2`, which is something that Eric had mentioned above.

I think that OPT_CMDMODE would not work quite in the way we desire,
since the error messages would not quite line up with the command typed.
For instance, after applying the following diff:

diff --git a/builtin/config.c b/builtin/config.c
index 5c8952a17c..d9b73b949a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -111,11 +111,11 @@ static struct option builtin_config_options[] = {
     OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
     OPT_GROUP(N_("Type")),
     OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
-    OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
-    OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
-    OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
-    OPT_SET_INT(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
-    OPT_SET_INT(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
+    OPT_CMDMODE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
+    OPT_CMDMODE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
+    OPT_CMDMODE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
+    OPT_CMDMODE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
+    OPT_CMDMODE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
     OPT_GROUP(N_("Other")),
     OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
     OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),

The following occurs:

  ~/g/git (tb/config-type-specifier-option!) $ ./git-config --type=int --bool foo.bar
  error: option `bool' : incompatible with --int

Whereas I would expect that to say:

  error: option `bool' is incompatible with `--type=int'.

I am not sure whether amending the implementation of OPT_CMDMODE is something
that you're interested in here.

I can amend my patch to include this extra reasoning, if you think that
would be helpful.

> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> > index 4f8e6f5fde..24de37d544 100755
> > --- a/t/t1300-repo-config.sh
> > +++ b/t/t1300-repo-config.sh
> > @@ -1611,4 +1611,15 @@ test_expect_success '--local requires a repo' '
> >  	test_expect_code 128 nongit git config --local foo.bar
> >  '
> >
> > +cat >.git/config <<-\EOF &&
> > +[core]
> > +number = 10
> > +EOF
> > +
> > +test_expect_success 'later legacy specifiers are given precedence' '
> > +	git config --bool --int core.number >actual &&
> > +	echo 10 >expect &&
> > +	test_cmp expect actual
> > +'
>
> And this expects more than we gave justifications for in the
> proposed log message.  I do not think it is necessarily a bad idea
> to switch to last-one-wins, but if that is where we really want to
> go, the proposed log message is being misleading.  It is true that
> OPT_SET_INT is more suited to complain when two conflicting things
> are given than OPT_BIT, but this example actually tells us that you
> no longer want to catch an error to give conflicting requests.

Yes, since I'd like to be able to insert `--type=` and have it behave
the same way. Since `--type=bool --type=int` will not complain (and
instead adopt `--type=int` given that it comes later in the command
string), neither should `--bool --int`.


Thanks,
Taylor
