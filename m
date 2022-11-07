Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5C0C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 16:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiKGQhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 11:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiKGQhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 11:37:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C496466
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 08:37:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id 13so31726692ejn.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 08:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFEmdo5QMCjXNd6OIKU3rO/aRSsK5tIvbqroCK/+siA=;
        b=GgBisr44lgPEoji5+NkBIED1NNbdPU62149/fil2aDtXNjdtzuC20xIilQxosBvhMD
         qJPue9VJyNcBPxTym09TyOYHHa9bTnH2OmxPluPzMiq7JS25A6RhS7eHu0couUgz2oXI
         6i+cS9j/ZB+eRmDQ4WcdrsGfxNbfGBTItyIZcgnsNVx5jiHLbb0QDTgZL2xMmb8+LDmQ
         LQDETENoq4V9KpGQl9behkssuS6qgZI8fzo7RfdAxmjqOXgSRCrBot8HQy4cGqtON9CY
         sQFEtVR6ZLlctt19OURmwbYe1N2SYXo4HDDftP08HE9PCdqBLrPf0vwAycSftpgFG0aI
         7ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFEmdo5QMCjXNd6OIKU3rO/aRSsK5tIvbqroCK/+siA=;
        b=4kI1wHnHnOGDJ9RSLvhFRpVp21y3CCGYbvcK5o3GI/2HKk8OFcdFVLcFV11pW1mp+V
         WulL8kZhW8I66C2LQUawPINy0JQQVT4Xu65qeBQoT5qRb/5m46K3hKq/ckQyr9LTmdCz
         51oVwO/y62IKsO/BKDzHzDskn1mtR3TOb9xwhszyVMNjFyuRPznaI3Dtpv9E46+nHfuk
         gGbPE5MVzv3Uhm3xybmfEHTMobvoHFx7B87M4sKjhgm0GbLyf1St/i0ucQMOmBI9i0k0
         VFH0jSPUgYHNloEbE0448GQQrij4c9i1zQBREtBI1mz2Ang6JT3lLm0Q/0CAi/R0nZ/X
         chPA==
X-Gm-Message-State: ACrzQf0HMXz5JOAt1Lm5tqEnqgPRfiLo80svNYMkodvBAXTIKR02TtLm
        r/dUEydZN5jgAwHs70wPtfs=
X-Google-Smtp-Source: AMsMyM6o3Vn4XMEynTFKooIzpt//cSru6E73UJoXMYE8t3JX0pN7jLHa9SceLqqbpCa/1mTwGF02gw==
X-Received: by 2002:a17:907:97d5:b0:7ae:2c4d:9e72 with SMTP id js21-20020a17090797d500b007ae2c4d9e72mr18551419ejc.503.1667839029643;
        Mon, 07 Nov 2022 08:37:09 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b0078df3b4464fsm3654309eje.19.2022.11.07.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:37:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os57U-000Bhd-1m;
        Mon, 07 Nov 2022 17:37:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] sequencer: stop exporting GIT_REFLOG_ACTION
Date:   Mon, 07 Nov 2022 17:12:08 +0100
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <e9c3f5ac5c6b7a01ee9e43730889d8066a270271.1667575142.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <e9c3f5ac5c6b7a01ee9e43730889d8066a270271.1667575142.git.gitgitgadget@gmail.com>
Message-ID: <221107.86iljqvhzf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>

> +static const char *sequencer_reflog_action(struct replay_opts *opts)
> +{
> +	if (!opts->reflog_action) {
> +		opts->reflog_action = getenv(GIT_REFLOG_ACTION);
> +		opts->reflog_action =
> +			xstrdup(opts->reflog_action ? opts->reflog_action
> +						    : action_name(opts));
> +	}
> +
> +	return opts->reflog_action;
> +}

We always return an xstrdup'd here, so this should be a "char *" return
value, not a "const char *"., but

>  __attribute__((format (printf, 3, 4)))
>  static const char *reflog_message(struct replay_opts *opts,
>  	const char *sub_action, const char *fmt, ...)
>  {
>  	va_list ap;
>  	static struct strbuf buf = STRBUF_INIT;
> -	char *reflog_action = getenv(GIT_REFLOG_ACTION);
>  
>  	va_start(ap, fmt);
>  	strbuf_reset(&buf);

Here we just reset the strbuf...

> -	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
> +	strbuf_addstr(&buf, sequencer_reflog_action(opts));

Here we leak the freshly xstrdup'd value, mostly untested, but shouldn't
this instead be:
	
	diff --git a/sequencer.c b/sequencer.c
	index e23f6f0b718..58a97e04c67 100644
	--- a/sequencer.c
	+++ b/sequencer.c
	@@ -3695,10 +3695,11 @@ static const char *reflog_message(struct replay_opts *opts,
	 {
	 	va_list ap;
	 	static struct strbuf buf = STRBUF_INIT;
	+	char *msg = sequencer_reflog_action(opts);
	 
	 	va_start(ap, fmt);
	 	strbuf_reset(&buf);
	-	strbuf_addstr(&buf, sequencer_reflog_action(opts));
	+	strbuf_attach(&buf, msg, strlen(msg), strlen(msg) + 1);
	 	if (sub_action)
	 		strbuf_addf(&buf, " (%s)", sub_action);
	 	if (fmt) {

Of course that requires dropping the "const", per the above...


>  	if (sub_action)
>  		strbuf_addf(&buf, " (%s)", sub_action);
>  	if (fmt) {
> @@ -4497,7 +4511,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>  				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
>  		.head_msg = reflog_message(opts, "start", "checkout %s",
>  					   onto_name),
> -		.default_reflog_action = "rebase"
> +		.default_reflog_action = sequencer_reflog_action(opts)

Here we'd before hand a fixed string to reset_head(), but now it's
xstrdup()'d, but the corresponding free() on that side is missing.

But aren't we always just returing "rebase" here still?

> [...]
> @@ -5116,7 +5121,7 @@ static int single_pick(struct repository *r,
>  			TODO_PICK : TODO_REVERT;
>  	item.commit = cmit;
>  
> -	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> +	opts->reflog_message = sequencer_reflog_action(opts);
>  	return do_pick_commit(r, &item, opts, 0, &check_todo);

Here you're adding a new memory leak, which you can see if you run
e.g. the 1st test of ./t1013-read-tree-submodule.sh before & after this
change.
