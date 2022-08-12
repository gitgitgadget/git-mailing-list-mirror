Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF55C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 15:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiHLPE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 11:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiHLPEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 11:04:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F5EA895A
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:04:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a89so1677461edf.5
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=8DrxiMSa+FK9X51gEETLmqBMRdSqHPin/1x7WpCjw6Q=;
        b=qY4jvKzMpVDoCZwFTiWVLDL3TWIarNck/oZrkaGzpumqawZm6HEZZHeLmphgOzB6xo
         hRVYGiRmokm30Azm7Ux2bF0suUKV+8CbBHDn3LrvldZpka0yDo6A8fd/imeFGB8fSgpL
         uAvfGFO8+gT7IRlLnk5LxNpI30/GNxWVePguX87hpon2E2s38r/VgvNyDMUXrVGCKvvN
         ZsUql8tPs42WOiIKgxCFTYVdGVOCjbY0w5/DkmUskDrQuxnkuBBNCXa+tlEdC1eXAcoI
         485zMlJvTz1PjTd4gJv8F+zrEIvOFJBCD0ui/nbKUjivo3BIoDjMpWSWRoXggHhJMAwG
         yOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=8DrxiMSa+FK9X51gEETLmqBMRdSqHPin/1x7WpCjw6Q=;
        b=3gPyWAs0kDKqMeD/6xfFczdJG5+Pvh6PwgrpxExtw+J1oFPOUFmvioFHNAD4Anlw3v
         P3chHQ3HGudehbAvo5KNqgXc3AR3PDEBUEVHvPMC9U72hC48oMCcmR0odQFVttam1Hjt
         F69inguCqCCVjhp4QNAJHpRDJaM2tzbCpuFUvjkSxoL1GmJDzpiq42/wCdn5vTGPQZ5Q
         prAEYILmXrPmpswPo24ace5TYDNHn6wPF4C8pqTIEqJi67HcxjxmfZNdJTHYBahrHR7T
         UodBLGfMDgOj35U24QsCr1v4qg5jLCZA0Wz6ULXwOxPEq3zJ78So97plHCmHm545PcN/
         cFFg==
X-Gm-Message-State: ACgBeo2kW8Mppm4NVS0PBpnBZzB3/5rL067+KTMFY0R0s/w4gi3YChxx
        M/KpXk+IFv2GK3wtviWjXII=
X-Google-Smtp-Source: AA6agR6jf2v3CB4Tvjrc4uh8mCkcDrp9wEeG8immda/zUFMXAdIUHP2X2ojE5j98rWX8YIVzNm1T7A==
X-Received: by 2002:a05:6402:2d1:b0:43c:bb20:71bf with SMTP id b17-20020a05640202d100b0043cbb2071bfmr3961325edx.59.1660316662867;
        Fri, 12 Aug 2022 08:04:22 -0700 (PDT)
Received: from localhost (94-21-58-102.pool.digikabel.hu. [94.21.58.102])
        by smtp.gmail.com with ESMTPSA id x23-20020aa7dad7000000b0043a85d7d15esm1448421eds.12.2022.08.12.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:04:22 -0700 (PDT)
Date:   Fri, 12 Aug 2022 17:04:20 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/20] t0040-parse-options: test parse_options() with
 various 'parse_opt_flags'
Message-ID: <20220812150420.GA3790@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-5-szeder.dev@gmail.com>
 <220725.86edy9p85i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220725.86edy9p85i.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 04:38:48PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jul 25 2022, SZEDER Gábor wrote:
> 
> > In 't0040-parse-options.sh' we thoroughly test the parsing of all
> > types and forms of options, but in all those tests parse_options() is
> > always invoked with a 0 flags parameter.
> >
> > Add a few tests to demonstrate how various 'enum parse_opt_flags'
> > values are supposed to influence option parsing.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  t/helper/test-parse-options.c | 61 ++++++++++++++++++++++++++++++
> >  t/helper/test-tool.c          |  1 +
> >  t/helper/test-tool.h          |  1 +
> >  t/t0040-parse-options.sh      | 70 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 133 insertions(+)
> >
> > diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> > index 48d3cf6692..32b906bd6a 100644
> > --- a/t/helper/test-parse-options.c
> > +++ b/t/helper/test-parse-options.c
> > @@ -192,3 +192,64 @@ int cmd__parse_options(int argc, const char **argv)
> >  
> >  	return ret;
> >  }
> > +
> > +static int parse_options_flags__cmd(int argc, const char **argv,
> > +				    enum parse_opt_flags test_flags)
> > +{
> > +	const char *usage[] = {
> > +		"<...> cmd [options]",
> > +		NULL
> > +	};
> > +	int opt = 0;
> > +	const struct option options[] = {
> > +		OPT_INTEGER('o', "opt", &opt, "an integer option"),
> > +		OPT_END()
> > +	};
> > +
> > +	argc = parse_options(argc, argv, NULL, options, usage, test_flags);
> > +
> > +	printf("opt: %d\n", opt);
> > +	for (int i = 0; i < argc; i++)
> > +		printf("arg %02d: %s\n", i, argv[i]);
> > +
> > +	return 0;
> > +}
> > +
> > +static enum parse_opt_flags test_flags = 0;
> > +static const struct option test_flag_options[] = {
> > +	OPT_GROUP("flag-options:"),
> > +	OPT_BIT(0, "keep-dashdash", &test_flags,
> > +		"pass PARSE_OPT_KEEP_DASHDASH to parse_options()",
> > +		PARSE_OPT_KEEP_DASHDASH),
> > +	OPT_BIT(0, "stop-at-non-option", &test_flags,
> > +		"pass PARSE_OPT_STOP_AT_NON_OPTION to parse_options()",
> > +		PARSE_OPT_STOP_AT_NON_OPTION),
> > +	OPT_BIT(0, "keep-argv0", &test_flags,
> > +		"pass PARSE_OPT_KEEP_ARGV0 to parse_options()",
> > +		PARSE_OPT_KEEP_ARGV0),
> > +	OPT_BIT(0, "keep-unknown", &test_flags,
> > +		"pass PARSE_OPT_KEEP_UNKNOWN to parse_options()",
> > +		PARSE_OPT_KEEP_UNKNOWN),
> > +	OPT_BIT(0, "no-internal-help", &test_flags,
> > +		"pass PARSE_OPT_NO_INTERNAL_HELP to parse_options()",
> > +		PARSE_OPT_NO_INTERNAL_HELP),
> > +	OPT_END()
> > +};
> > +
> > +int cmd__parse_options_flags(int argc, const char **argv)
> > +{
> > +	const char *usage[] = {
> > +		"test-tool parse-options-flags [flag-options] cmd [options]",
> > +		NULL
> > +	};
> > +
> > +	argc = parse_options(argc, argv, NULL, test_flag_options, usage,
> > +			     PARSE_OPT_STOP_AT_NON_OPTION);
> > +
> > +	if (argc == 0 || strcmp(argv[0], "cmd")) {
> > +		error("'cmd' is mandatory");
> > +		usage_with_options(usage, test_flag_options);
> > +	}
> > +
> > +	return parse_options_flags__cmd(argc, argv, test_flags);
> > +}
> > diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> > index 318fdbab0c..6e62282b60 100644
> > --- a/t/helper/test-tool.c
> > +++ b/t/helper/test-tool.c
> > @@ -51,6 +51,7 @@ static struct test_cmd cmds[] = {
> >  	{ "online-cpus", cmd__online_cpus },
> >  	{ "pack-mtimes", cmd__pack_mtimes },
> >  	{ "parse-options", cmd__parse_options },
> > +	{ "parse-options-flags", cmd__parse_options_flags },
> >  	{ "parse-pathspec-file", cmd__parse_pathspec_file },
> >  	{ "partial-clone", cmd__partial_clone },
> >  	{ "path-utils", cmd__path_utils },
> 
> I wanted to add some new parse_options() code to
> t/helper/test-parse-options.c in the past, but was stymied by its
> cmd_*() going through a singular parse_options().
> 
> So just creating a new callback is a neat solution.
> 
> But wouldn't it be better to just create a new
> t/helper/test-parse-options-something-.c & test file? It seems this
> doesn't really share anything with the current helper & tests...

Well, at least they share the concept, as they all test parse-options.
And 'parse-options-flags' and 'parse-subcommands' do share the options
array to specify the various parse_opt_flags.

A new test script for these flags and/or for subcommands would
definitely be worse, IMO.  I've found it very convenient that whenever
I updated 'parse-options.{c,h}', I only needed to run a single
'./t0040-parse-options.sh' script to check my changes.

