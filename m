Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3180C636CD
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 00:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBHAy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 19:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBHAyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 19:54:55 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3122DDE
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 16:54:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gr7so47332414ejb.5
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 16:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8veoeWsU5tJ2J0twA7XwflE+2PV6EKrjI16GlvpoixE=;
        b=Cn77CFBYdizvN7lXE3v4/tDAHcpyWcRXvQz/pAe0xnfsr2vx9fOq/m7uHfYwB9MrSl
         xjhegjQUW2zmiciDH/Fc6TiDpRIZajCcsMIpwUVbmpZsemOZNU+gb+rSW4zUagQPpMH1
         GIItmB4TJ3s5oB48SIc81yMAE5+1J1c6CMTKwWfNqQMzafZ61nspmSAEn51SC5oW9dA3
         CrKv7prs0efosmilC9wU8GVtnh/mcmbpIr34EDaFByQScPXj+CqcxpmGQOer4QyXIHOn
         TqMLiF/ctarErdLCf4y1RaGDpur+NI1GNiC89jgrLFWE6wXP0lzAFcSz+QVxPopUhQ7E
         CGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8veoeWsU5tJ2J0twA7XwflE+2PV6EKrjI16GlvpoixE=;
        b=FLHK0bPvgAmTG9vebm/PfiVxHf/pLtqqg54MrGpiTaNIV6pSpEn34P123g3GyjPzfx
         ho2IrbNfbFHfNacdIUDHJ1IJEYs6JhD4A5b+UKg8R4tZV+PD3Yl+66BxXsYt/igxMfo+
         VCsKF3k5lrp4Rdyo+hqid2l5y4sI1du2cKjbg1nm/4IWo31XaaRYhtwgBxKfAGuFmB4P
         okihEPtFvhg3CF54FHagmxJa3+OJQAcC9Jx7+VPRZne+hW42GPi4YH7gbconHYM1OA1c
         ITXNC4KBg7CHvpGZ5oqLREKkMLRwn32Bf1RuUnGESdYR11xQ9tHEuVDKxGaHWOaxf83q
         YMww==
X-Gm-Message-State: AO0yUKV5YnWAv38bGc8UArn/CZifYccd6i2/22eO8DwPeG4zKBu8VveQ
        82FucFw5kjSGmuzM1Jm8Sn+ywB2b+rfYqwHk
X-Google-Smtp-Source: AK7set9K4L9iSBC5zFIq9AigKNpbtdBVHAYdscEdtfhT/MotwcLJk7yS3Pg+dQrVB+OpxU3+glctjA==
X-Received: by 2002:a17:906:528d:b0:8aa:8b52:5914 with SMTP id c13-20020a170906528d00b008aa8b525914mr3454951ejm.53.1675817685501;
        Tue, 07 Feb 2023 16:54:45 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906b30500b007aea1dc1840sm7564165ejz.111.2023.02.07.16.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 16:54:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPYjU-00181n-0p;
        Wed, 08 Feb 2023 01:54:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v7 7/7] diff-lib: parallelize run_diff_files for submodules
Date:   Wed, 08 Feb 2023 00:06:48 +0100
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-8-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230207181706.363453-8-calvinwan@google.com>
Message-ID: <230208.86ilgd0yej.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Calvin Wan wrote:

> [...]
> +	sps->result = 1;
> +	strbuf_addf(err,
> +	    _(status_porcelain_start_error),
> +	    task->path);
> +	return 0;
> [...]
> +	if (retvalue) {
> +		sps->result = 1;
> +		strbuf_addf(err,
> +		    _(status_porcelain_fail_error),
> +		    task->path);
> [...]

This is nitpicky, but what's with the short lines and over-wrapping?

If you change these two to (just using my macro version on top, but it's
the same with yours):

	strbuf_addf(err, _(STATUS_PORCELAIN_START_ERROR), task->path);

And:

	strbuf_addf(err, _(STATUS_PORCELAIN_FAIL_ERROR), task->path);

Both of these are under our usual line limit at their respective
indentation (the latter at 77, rule of thumb is to wrap at 79-80).

> +	if (submodules.nr > 0) {

Don't compare unsigned to >0, just use "submodules.nr".

> +		int parallel_jobs;

nit: add extra \n, or maybe just call this "int v", as it's clear from
the scope what it's about...

> +		if (git_config_get_int("submodule.diffjobs", &parallel_jobs))
> +			parallel_jobs = 1;
> +		else if (!parallel_jobs)
> +			parallel_jobs = online_cpus();
> +		else if (parallel_jobs < 0)
> +			die(_("submodule.diffjobs cannot be negative"));

Can't you use the "ulong" instead of "int" and have it handle this "is
negative?" error check for you?

> +
> +		if (get_submodules_status(&submodules, parallel_jobs))
> +			die(_("submodule status failed"));
> +		for (size_t i = 0; i < submodules.nr; i++) {

Another case that can use for_each_string_list_item().

> +struct submodule_parallel_status {
> +	size_t index_count;
> +	int result;
> +
> +	struct string_list *submodule_names;
> +
> +	/* Pending statuses by OIDs */
> +	struct status_task **oid_status_tasks;
> +	int oid_status_tasks_nr, oid_status_tasks_alloc;

For new structs, let's use size_t, not "int" for alloc/nr.

Also, as this is 7/7 and we're not adding another such pattern for the
forseeable future, can we just call these "size_t nr", "size_t alloc"
and "tasks"?

And having said all that, it turns out this is just dead code that can
be removed? Blindly copied from submodule_parallel_fetch?
