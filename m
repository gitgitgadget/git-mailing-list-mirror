Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F0C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E2460F9B
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhI1IHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhI1IHS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 04:07:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758DDC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:05:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v10so75440078edj.10
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=opeZetJ9ZhulvOy2FjPPvaor4Mlw3/vPc9ESU3Ohklw=;
        b=CY20L44ChPLQllKWD1RcBdPM5gmWlGtMYB3SwLUIFno1abFu9foR67Ce6i7RLJUNJa
         uSozRr6oxqcVbUlPl8EISLU4zNy6tEwbGxOU+akAnk9krC4CAKfqz9symDMDnmYPmm8l
         Z4NJL6CXGMuLMj6pcum5hseoHiEn/+uND6gdHWpfO8aMBIoJm6hQ859OVW6vbITPvNUj
         QYcbbLd9gbfZvX1N6XNsOm05IaRti1lPv4MiGpgIQRiJU3iYdbbRjSV1IMprenX7u46m
         i51S/YSsg23CSHitLDy4A4KyiGlhQhyPxXI5ghwfJw4LGYlS84CXOziSSEmltW7HeY6I
         tYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=opeZetJ9ZhulvOy2FjPPvaor4Mlw3/vPc9ESU3Ohklw=;
        b=AS0nwEJw+rgTPIXq6bEJyOcWNv/ufifcFndt2EEf0DSyCkKtYpdYgGfojqOMPzQLAV
         aQqcSkCeJlzMBS0Hic8tUq2A2E8cMoG7EhJIvoGpI3Is1zUfaxIyXyDGTrMI7TMFD72z
         ek0oINIzpCjHT/SuzUGqeUt+4WezS076z2BT6tQ1nsUNKSQdhNniNMFjf3dhkgPFh26a
         6LwKUvBrK7A65Zxz2ssjerbMs2NZeH0KRmzmahkSrpoDXy0qt4jbRElPuYCedfg0FRRY
         TftBNQ43ilPTrLHPntT9upqUwl4OmngE26HO0RpXnASJ0bsFiOLW/sFu90E86zdWB3Jx
         W/IQ==
X-Gm-Message-State: AOAM530XTOPC+RC5SZWI15djeG+/pKqediS8yCgdeaG20EjM5MzDSjca
        mdIl9ZABaTXlFu8ojOw1iNa598Xd54dE8w==
X-Google-Smtp-Source: ABdhPJzmpx7i9zOrXp6uJ1Gv/m1YgIdrZIRlif3spG+GSJvFygSQ+2Obf1JSt4V1hx3ikktd/+jjaw==
X-Received: by 2002:a50:d887:: with SMTP id p7mr6119769edj.164.1632816337767;
        Tue, 28 Sep 2021 01:05:37 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d22sm9956921ejk.5.2021.09.28.01.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:05:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 6/7] show, log: provide a --remerge-diff capability
Date:   Tue, 28 Sep 2021 10:01:03 +0200
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <b75e73384fde4f23296bd02eb40455263f805706.1630376800.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <b75e73384fde4f23296bd02eb40455263f805706.1630376800.git.gitgitgadget@gmail.com>
Message-ID: <87mtnxxgz3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Elijah Newren via GitGitGadget wrote:

>  static int decoration_given;
>  static int use_mailmap_config = 1;
> +static struct tmp_objdir *tmp_objdir;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
>  static const char *fmt_pretty;

So here we make this static file-level etc...

> @@ -407,6 +410,17 @@ static int cmd_log_walk(struct rev_info *rev)
>  	int saved_nrl = 0;
>  	int saved_dcctc = 0;
>  
> +	if (rev->remerge_diff) {
> +		tmp_objdir = tmp_objdir_create();
> +		if (!tmp_objdir)
> +			die(_("unable to create temporary object directory"));
> +		tmp_objdir_make_primary(the_repository, tmp_objdir);
> +
> +		strbuf_init(&rev->remerge_objdir_location, 0);
> +		strbuf_addstr(&rev->remerge_objdir_location,
> +			      tmp_objdir_path(tmp_objdir));
> +	}
> +
>  	if (rev->early_output)
>  		setup_early_output();
>  
> @@ -449,6 +463,13 @@ static int cmd_log_walk(struct rev_info *rev)
>  	rev->diffopt.no_free = 0;
>  	diff_free(&rev->diffopt);
>  
> +	if (rev->remerge_diff) {
> +		strbuf_release(&rev->remerge_objdir_location);
> +		tmp_objdir_remove_as_primary(the_repository, tmp_objdir);
> +		tmp_objdir_destroy(tmp_objdir);
> +		tmp_objdir = NULL;

...but all of the "tmp_objdir" usage is in one function, can't the
variable be declared here instead?

We need to hand the "remerge_objdir_location" off to the "rev_info"
struct, but that seems separate from its lifetime.

Re my [1] & [2] I like Neeraj's "atexit cleanup" approach better,
perhaps that makes your cleanup in log-tree.c redundant or easier?

Per [2] it looks like you need to "hand off" the
"remerge_objdir_location", so having the struct live in tmp-objdir.h as
I suggested in [2] might make that work...

1. https://lore.kernel.org/git/87v92lxhh4.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87r1d9xh71.fsf@evledraar.gmail.com/
