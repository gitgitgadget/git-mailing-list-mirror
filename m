Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679FC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 09:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A88613AE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 09:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCJOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCJOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 05:14:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5933BC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 02:12:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k7so8107468ejv.12
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=x1PMbIbr/2WjtVdhE/WxklP9kjZ8ptCkiTWWIsFvCnA=;
        b=qtDK8zggC8ni9OfqGUiWZpnBZlnDKmk7DdCvehl5rcdEGAMHp8pQ6/Up4983krvARk
         df9JujhCjULHZ6EImMY7epJnU/3nKx7X6mSSPnw8o1PaN6TAzvJutiNZtXGRM1kpzTp1
         WQ217CujHvFjMHJ+HpRt/B2dlNmydrbxrSOuBx4JlnRRmDlBvRJ5/CX3zdUD+/QflpEu
         +BKIRY9A/1Vsvbcap21sJUQIObXA9Yuykpvb3/0bYby258GsCJMDrBJpVNC3EAgZ76eJ
         7eSDJgA6/eUQHUdyrwJR4OxcDR0upf/Cj5OlgctVYyb3WUxLA4UTqUT5UTCVCkUX0omi
         x+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=x1PMbIbr/2WjtVdhE/WxklP9kjZ8ptCkiTWWIsFvCnA=;
        b=tRku/QU0dP1iyYO9HdwyOPoYqXU8w/lP4/eCytKs36go0B1q1nKYba4CCHm3CEmfnF
         hCMHgTNQy8RS4yOEfoBYCBSz4sq3MEy+TIyKKjbT7UNnxvYrP2g+roGAYhHBSgMzxjQT
         GTOxL1W67czKlZuRGas5OAQewrDlfzWOiTfPiSL6eDfdRK1Jg5kAzj4lMo/EKLMVS3xQ
         4A/DPIOdf7y8UAfcBNq9YldH5S2vL3dUzU/rYQgn0uku5z3HJFLEj6RvPf3aifOujE5y
         eDZhxzgwsRFiSNL8TNSuafioNp7Ggkg5KIB/gMcc1E/YFtSaqyt7DydBtheQJzRjMA+F
         9GXA==
X-Gm-Message-State: AOAM533uD8LI0bTFma1aziw+GMCHCyVXfoC/xGtrO//vhk3y/Jnr5OFz
        fJxWjbxL5nt2XU6v0+X0SA5ADADAF8Q=
X-Google-Smtp-Source: ABdhPJzu/zohnRftwHb4+rHY5H4liz2yngoeNrM//jwOtjjiIpkIx/+E7ulzs/i/AF4+HMjt+94cBQ==
X-Received: by 2002:a17:906:d967:: with SMTP id rp7mr23586671ejb.424.1622711577302;
        Thu, 03 Jun 2021 02:12:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q9sm1375606edw.51.2021.06.03.02.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:12:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 07/37] hook: add 'run' subcommand
Date:   Thu, 03 Jun 2021 11:07:29 +0200
References: <20210527000856.695702-1-emilyshaffer@google.com>
 <20210527000856.695702-8-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210527000856.695702-8-emilyshaffer@google.com>
Message-ID: <875yyv71lz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Emily Shaffer wrote:

> +void run_hooks_opt_init(struct run_hooks_opt *o)
> +{
> +	strvec_init(&o->env);
> +	strvec_init(&o->args);
> +	o->run_hookdir = configured_hookdir_opt();
> +}

I suggested in
https://lore.kernel.org/git/87y2bs7gyc.fsf@evledraar.gmail.com/ that
this could and should be a RUN_HOOKS_OPT_INIT

After some digging I see that was the case in an earlier version of your
series, i.e. before:
https://lore.kernel.org/git/20210131042254.1032233-1-jonathantanmy@google.com/

You came up with this current pattern because of
configured_hookdir_opt().

But a better option here is to use a RUN_HOOKS_OPT_INIT still and just
defer the initialization of this "run_hookdir" member. I.e. set it to
"we have not asked the config yet" in the initializer. I.e. the diff on
top your series at the end of this E-Mail[1].

That along with doing the same for the "jobs" member means we can move
back to a RUN_HOOKS_OPT_INIT, and also that the final version of this
function in this series, i.e.:
	
	void run_hooks_opt_init_sync(struct run_hooks_opt *o)
	{
		strvec_init(&o->env);
		strvec_init(&o->args);
		o->path_to_stdin = NULL;
		o->run_hookdir = HOOKDIR_UNINITIALIZED;
		o->jobs = 1;
		o->dir = NULL;
		o->feed_pipe = NULL;
		o->feed_pipe_ctx = NULL;
		o->consume_sideband = NULL;
	}

Is now mostly redundant to a designated initializer. I.e. you don't need
to NULL any of these out anymore. Then either don't set "jobs" and have
"0" mean "ask config" or set it to "-1" or whatever for "uninitialized".

1.

diff --git a/hook.c b/hook.c
index ff80e52eddd..daf3ddcc188 100644
--- a/hook.c
+++ b/hook.c
@@ -154,7 +154,7 @@ int configured_hook_jobs(void)
 	return n;
 }
 
-static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
+static int should_include_hookdir(struct run_hooks_opt *options, const char *path)
 {
 	struct strbuf prompt = STRBUF_INIT;
 	/*
@@ -164,7 +164,10 @@ static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
 	if (!path)
 		return 0;
 
-	switch (cfg)
+	if (options->run_hookdir == HOOKDIR_UNINITIALIZED)
+		options->run_hookdir = configured_hookdir_opt();
+
+	switch (options->run_hookdir)
 	{
 	case HOOKDIR_ERROR:
 		fprintf(stderr, _("Skipping legacy hook at '%s'\n"),
@@ -292,7 +295,7 @@ void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 	strvec_init(&o->env);
 	strvec_init(&o->args);
 	o->path_to_stdin = NULL;
-	o->run_hookdir = configured_hookdir_opt();
+	o->run_hookdir = HOOKDIR_UNINITIALIZED;
 	o->jobs = 1;
 	o->dir = NULL;
 	o->feed_pipe = NULL;
@@ -312,6 +315,9 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
 	struct strbuf hook_key = STRBUF_INIT;
 	int could_run_hookdir;
 
+	if (should_run_hookdir != HOOKDIR_USE_CONFIG)
+		BUG("no callers want !HOOKDIR_USE_CONFIG?");
+
 	if (should_run_hookdir == HOOKDIR_USE_CONFIG)
 		should_run_hookdir = configured_hookdir_opt();
 
@@ -459,7 +465,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 		struct hook *hook = list_entry(pos, struct hook, list);
 
 		if (hook->from_hookdir &&
-		    !should_include_hookdir(hook->command.buf, options->run_hookdir))
+		    !should_include_hookdir(options, hook->command.buf))
 			    list_del(pos);
 	}
 
diff --git a/hook.h b/hook.h
index f32189380a8..3c4491a74e7 100644
--- a/hook.h
+++ b/hook.h
@@ -30,6 +30,7 @@ struct list_head* hook_list(const char *hookname);
 
 enum hookdir_opt
 {
+	HOOKDIR_UNINITIALIZED,
 	HOOKDIR_USE_CONFIG,
 	HOOKDIR_NO,
 	HOOKDIR_ERROR,
