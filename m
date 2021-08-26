Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54AFC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E8960232
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbhHZVRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhHZVRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:17:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47553C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:16:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so3323193pjt.0
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JvvKxSY1vuIuxUtRW35uY8Ec8SNuu6QZNHY2GcaiOt4=;
        b=B+v6GcdXnMgWnxR5lXdAZ+a7kCsGmWKc56p0LsAhiUj7RuMXbyIhWJWCE6hi6wZKH2
         c27EOwRVOFnWTi0la4dh+fj/IAukJrIq+fKoN/1uA5dsMumOTDpCT66I16ItJMQiv1J1
         7pWAQQivX3OCQhnUyBtFTG8dBjg0cRUk1eNy4HZwv2wHFwmRIwtCXubsB1rLVIbOShTs
         I3x0YqgasLX8cS4Hcbwlfzgxejd+4U783ltM2Ku757cDhOIxvLxj6jTKLg8pf/7anFeL
         i6EURkN1PksIcoqtrLtWBcPVWGF7/DwxQ0bEBKXZZq+tJKL6fjNsioj62OhGSvjEUMUZ
         D8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JvvKxSY1vuIuxUtRW35uY8Ec8SNuu6QZNHY2GcaiOt4=;
        b=rErR1GZbUd0k/Dr5+p24f/RtqVBROsjanC7zpWQhCj2wuVNElJj/UAi9GaoU0uMQLs
         rhKQVYby/WwflvHHakGNcLvV0LLpED0kYvrmzRqup7Im3ftVegNkidf38LfrsYutsxkB
         vzeZWnsBwztMuU/RAI0eLwZGfyHMaJKyWY9cr7MqCchUTqr/YAIyEN3jFaEomWAkzkhG
         BEMfuCQqCd2G6b7TcKAmPjsqMdOu9o8fV1Vf9fIUFk7QTLouHA/XfWPWxc6uk970p6Br
         QjtPxHwcbvQsZeXOv9Xf/X021dTESd8W3bwxX3J/EVCCIaMMQQ0Xb8YsgfILxMJn9JAN
         kppg==
X-Gm-Message-State: AOAM533rE0T5qEbZ6g5DD+ccTTk/9JeEe3si2bBwfiaQ/FHUDPo8TWZP
        TMsjG7qFSrzb0KeGu5P4EC3pm3+XkeVj2g==
X-Google-Smtp-Source: ABdhPJwLIuOs2r8A8O1rcgJ04Jc2/L5Ja/hEFYe3oLMzwMXm6qGbl17YUCY6Bi7InyxzNefxq+AOtg==
X-Received: by 2002:a17:902:d504:b029:12d:65dd:6034 with SMTP id b4-20020a170902d504b029012d65dd6034mr5464074plg.85.1630012618484;
        Thu, 26 Aug 2021 14:16:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c1d9:3a1d:fe59:b07a])
        by smtp.gmail.com with ESMTPSA id ml10sm51834pjb.9.2021.08.26.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:16:57 -0700 (PDT)
Date:   Thu, 26 Aug 2021 14:16:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/6] hook: run a list of hooks instead
Message-ID: <YSgEw1D3u+MIPx2t@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-2-emilyshaffer@google.com>
 <87zgt6evkf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zgt6evkf.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 04:56:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> 
> > @@ -25,7 +25,8 @@ static int run(int argc, const char **argv, const char *prefix)
> >  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
> >  	int ignore_missing = 0;
> >  	const char *hook_name;
> > -	const char *hook_path;
> > +	struct list_head *hooks;
> > +
> >  	struct option run_options[] = {
> >  		OPT_BOOL(0, "ignore-missing", &ignore_missing,
> >  			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
> 
> In general in this patch series there's a bunch of little whitespace
> changes like that along with other changes. I think it's probably best
> if I just absorb that in the "base" topic instead of doing them
> here. E.g. in this case we could also add a line between "struct option"
> and the rest.
> 
> I don't mind either way, but the whitespace churn makes for distracting
> reading...

Ah, hm. I don't know if in this specific case it's necessary for me to
even have this whitespace change, since 'run_options' is still a struct
declaration. I'll just drop this one, but in general whichever
whitespace bits you like from this topic, feel free to absorb. Will make
a note to scan through the diff when I rebase onto your next reroll
checking for spurious whitespace changes.

> 
> > @@ -58,15 +59,16 @@ static int run(int argc, const char **argv, const char *prefix)
> >  	git_config(git_default_config, NULL);
> >  
> >  	hook_name = argv[0];
> > -	if (ignore_missing)
> > -		return run_hooks_oneshot(hook_name, &opt);
> > -	hook_path = find_hook(hook_name);
> > -	if (!hook_path) {
> > +	hooks = list_hooks(hook_name);
> > +	if (list_empty(hooks)) {
> > +		/* ... act like run_hooks_oneshot() under --ignore-missing */
> > +		if (ignore_missing)
> > +			return 0;
> >  		error("cannot find a hook named %s", hook_name);
> >  		return 1;
> >  	}
> >  
> > -	ret = run_hooks(hook_name, hook_path, &opt);
> > +	ret = run_hooks(hook_name, hooks, &opt);
> >  	run_hooks_opt_clear(&opt);
> >  	return ret;
> 
> This memory management is a bit inconsistent. So here we list_hooks(),
> pass it to run_hooks(), which clears it for us, OK...
> 
> > -int run_hooks(const char *hook_name, const char *hook_path,
> > -	      struct run_hooks_opt *options)
> > +int run_hooks(const char *hook_name, struct list_head *hooks,
> > +		    struct run_hooks_opt *options)
> >  {
> > -	struct strbuf abs_path = STRBUF_INIT;
> > -	struct hook my_hook = {
> > -		.hook_path = hook_path,
> > -	};
> >  	struct hook_cb_data cb_data = {
> >  		.rc = 0,
> >  		.hook_name = hook_name,
> > @@ -197,11 +241,9 @@ int run_hooks(const char *hook_name, const char *hook_path,
> >  	if (!options)
> >  		BUG("a struct run_hooks_opt must be provided to run_hooks");
> >  
> > -	if (options->absolute_path) {
> > -		strbuf_add_absolute_path(&abs_path, hook_path);
> > -		my_hook.hook_path = abs_path.buf;
> > -	}
> > -	cb_data.run_me = &my_hook;
> > +
> > +	cb_data.head = hooks;
> > +	cb_data.run_me = list_first_entry(hooks, struct hook, list);
> >  
> >  	run_processes_parallel_tr2(jobs,
> >  				   pick_next_hook,
> > @@ -213,18 +255,15 @@ int run_hooks(const char *hook_name, const char *hook_path,
> >  				   "hook",
> >  				   hook_name);
> >  
> > -
> > -	if (options->absolute_path)
> > -		strbuf_release(&abs_path);
> > -	free(my_hook.feed_pipe_cb_data);
> > +	clear_hook_list(hooks);
> >  
> >  	return cb_data.rc;
> >  }
> 
> Which we can see here will call clear_hook_list(), so far so good, but then...
> 
> >  int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
> >  {
> > -	const char *hook_path;
> > -	int ret;
> > +	struct list_head *hooks;
> > +	int ret = 0;
> >  	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
> >  
> >  	if (!options)
> > @@ -233,14 +272,19 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
> >  	if (options->path_to_stdin && options->feed_pipe)
> >  		BUG("choose only one method to populate stdin");
> >  
> > -	hook_path = find_hook(hook_name);
> > -	if (!hook_path) {
> > -		ret = 0;
> > +	hooks = list_hooks(hook_name);
> > +
> > +	/*
> > +	 * If you need to act on a missing hook, use run_found_hooks()
> > +	 * instead
> > +	 */
> > +	if (list_empty(hooks))
> >  		goto cleanup;
> > -	}
> >  
> > -	ret = run_hooks(hook_name, hook_path, options);
> > +	ret = run_hooks(hook_name, hooks, options);
> > +
> >  cleanup:
> >  	run_hooks_opt_clear(options);
> > +	clear_hook_list(hooks);
> 
> ...the oneshot command also does clear_hook_list(), after calling
> run_hooks() which cleared it already.  That looks like a mistake,
> i.e. we should always trust run_hooks() to clear it, no?

Ah, good catch. I will update the comment on run_hooks() and fix
_oneshot() :)

 - Emily
