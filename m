Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF38C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 17:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiHUR4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 13:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHUR4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 13:56:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4A51A818
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 10:56:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so6417578wrr.5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=dbbC9DP+bSSS71RNwEzbYUBQ/YHRk4zq7td/Ski2BRc=;
        b=ouam8U/6e9PIvMyhfPkHMitj8NP5wk13n9VAB+sjYtqYGtsrHmbAjhXOG8cz0sDXCX
         LfQBOJQSML7u6pyr177cRBa+PVEvsp/XulZQOlWN6FQKN31ymk6S8ZPTdhWAWXU41FP8
         Hn77bFkKAlHTkYvdP4B+R1bFpoEBHPbgHVTgk2RdjtofCNBUkTpaQFHDFhC1AAVljvmi
         aEV3AFxW/j1FY/r504TwFQmSuLidSPc9ZXSL2xSPfwjELlVVzaBNrgUrI8EBpa1MEQCI
         KUVAJ06Nlk3Fx8+3rkR79yYUPb3quKAq/sk9Nrn7Ic5kgMbA7JSG+LIB7Qh4Efcs+CcC
         BG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=dbbC9DP+bSSS71RNwEzbYUBQ/YHRk4zq7td/Ski2BRc=;
        b=LT32SRvMToSPqDVGDKiZZI/V+HZ4oPoixl2Eg9C4NMqSPVv0tz7OtLXr5P6FZX54QH
         D8oTzDStgyBz8OD3XsYUrNQyaJ33kfqDfMZCPBVkMxiP2vYOYMmUQxgyTYeM49PuxLYQ
         1r9XNM5FFfHXiv3shgrIDFc1/qmCup9RiI4cmEE/86Ht2b0y36cadTgQNtVg7YE2OtY0
         D75QzpNU5tgy3XuV7cmw12/LY/lYG/IkQHgkgCbj9O9xG80T77dk+D5O91JYY202XINa
         xPYUDavMIj8ZO5xpJ1kUx8cy0ecul8OdwQ+GZ+Ac/sXpH2wL38Eovj7clUkzqCcKVt2Y
         GgCA==
X-Gm-Message-State: ACgBeo3c7ms+m+NBOBw/twtl/VQqK29iDueAR7+20I4FP7W0kL8CpcRG
        09LufNutyrNvT+8i15JylfU=
X-Google-Smtp-Source: AA6agR62ghBpAshfqUSMsyWXO2BAoYEngtlEF2rOc8DeGRncnk3osBR19tRM8oqTNL3RUbpUHROyXw==
X-Received: by 2002:a05:6000:716:b0:225:5a5b:9e4d with SMTP id bs22-20020a056000071600b002255a5b9e4dmr676197wrb.612.1661104572036;
        Sun, 21 Aug 2022 10:56:12 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b003a60f0f34b7sm12887928wmq.40.2022.08.21.10.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:56:11 -0700 (PDT)
Date:   Sun, 21 Aug 2022 19:56:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/20] builtin/notes.c: let parse-options parse
 subcommands
Message-ID: <20220821175609.GF3373722@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-16-szeder.dev@gmail.com>
 <220819.86pmgw5cpk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220819.86pmgw5cpk.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 08:01:55PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Aug 19 2022, SZEDER Gábor wrote:
> 
> > -	int result;
> >  	const char *override_notes_ref = NULL;
> > +	parse_opt_subcommand_fn *fn = list;
> >  	struct option options[] = {
> >  		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
> >  			   N_("use notes from <notes-ref>")),
> > +		OPT_SUBCOMMAND("list", &fn, list),
> > +		OPT_SUBCOMMAND("add", &fn, add),
> > +		OPT_SUBCOMMAND("copy", &fn, copy),
> > +		OPT_SUBCOMMAND("append", &fn, append_edit),
> > +		OPT_SUBCOMMAND("edit", &fn, append_edit),
> > +		OPT_SUBCOMMAND("show", &fn, show),
> > +		OPT_SUBCOMMAND("merge", &fn, merge),
> > +		OPT_SUBCOMMAND("remove", &fn, remove_cmd),
> > +		OPT_SUBCOMMAND("prune", &fn, prune),
> > +		OPT_SUBCOMMAND("get-ref", &fn, get_ref),
> >  		OPT_END()
> >  	};
> >  
> >  	git_config(git_default_config, NULL);
> >  	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
> > -			     PARSE_OPT_STOP_AT_NON_OPTION);
> > +			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
> > +	if (fn == list && argc && strcmp(argv[0], "list")) {
> > +		error(_("unknown subcommand: %s"), argv[0]);

This should have been `%s' here, and in cmd_remote() as well.

> > +		usage_with_options(git_notes_usage, options);
> > +	}
> 
> I wanted to ask why the API can't smartly handle this, but your "Found
> an unknown option given to a command with" comment in an earlier patch
> answered it.

It's not about unknown options but rather about (non-option) arguments.

'git notes list' doesn't accept any --options, and since this 'list'
is the default operation mode, parse_options() is invoked without the
PARSE_OPT_KEEP_UNKNOWN_OPT flag, so 'git notes --foo' errors out even
without any of the extra checks in the above hunk.

However, while 'git notes list' does accept non-option arguments
(objects or refs), 'git notes' does not.  Alas, currently there is no
way to tell parse_options() to error out upon finding a (non-option
and non-subcommand) argument, it always keeps them in 'argv'; that's
why we need these additional checks.

Now, while we could add such a flag, of course, it would not be
limited to this one particular use case, so when the error is
triggered inside parse_options() I doubt that we could have this
specific "unknown subcommand" error message.


> I think something in this direction would be a bit more readble/obvious,
> as it avoids hardcoding "list":
> 	
> 	diff --git a/builtin/notes.c b/builtin/notes.c
> 	index 42cbae46598..43d59b1a98e 100644
> 	--- a/builtin/notes.c
> 	+++ b/builtin/notes.c
> 	@@ -995,7 +995,7 @@ static int get_ref(int argc, const char **argv, const char *prefix)
> 	 int cmd_notes(int argc, const char **argv, const char *prefix)
> 	 {
> 	 	const char *override_notes_ref = NULL;
> 	-	parse_opt_subcommand_fn *fn = list;
> 	+	parse_opt_subcommand_fn *fn = NULL;
> 	 	struct option options[] = {
> 	 		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
> 	 			   N_("use notes from <notes-ref>")),
> 	@@ -1015,10 +1015,11 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
> 	 	git_config(git_default_config, NULL);
> 	 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
> 	 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
> 	-	if (fn == list && argc && strcmp(argv[0], "list")) {
> 	-		error(_("unknown subcommand: %s"), argv[0]);
> 	-		usage_with_options(git_notes_usage, options);
> 	-	}
> 	+	if (!fn && argc)
> 	+		usage_msg_optf(_("unknown subcommand: %s"),
> 	+			       git_notes_usage, options, argv[0]);
> 	+	else if (!fn)
> 	+		fn = list;
> 	 
> 	 	if (override_notes_ref) {
> 	 		struct strbuf sb = STRBUF_INIT;
> 
> I.e. we rely on the API setting it to non-NULL if it finds a subcommand,
> otherwise we just set it to "list" after checking whether we have excess
> arguments.

Oh, that does look nicer indeed.

> > [...]
> > -	else if (!strcmp(argv[0], "get-ref"))
> > -		result = get_ref(argc, argv, prefix);
> > -	else {
> > -		result = error(_("unknown subcommand: %s"), argv[0]);
> > -		usage_with_options(git_notes_usage, options);
> > -	}
> > -
> > -	return result ? 1 : 0;
> > +	return !!fn(argc, argv, prefix);
> >  }
> 
> In any case this is a lot nicer, ditto previous comment about maybe
> skipping the refactoring of this end code, but I'm also fine with
> keeping it.
