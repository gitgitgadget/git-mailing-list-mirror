Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19028C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 08:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJLIqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJLIqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 04:46:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F2513E16
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 01:46:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q9so31990919ejd.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 01:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi1zIU/C5vXecTe24aeCQt5Oeu+oyqRxRS6OZIAdXQ4=;
        b=Jd2jDNXufLoYLZJwizwDBsOWYa9DYnMDlnRPNWJxyULiR3ptNRk3whszIkRhQfzddl
         qtDOWu0TBbTFwki+uUrisWHesKXbdzJJa79vtgWJHfxKmBDZBN/diAqjCGc+5UGteQeV
         D51qRUJxx7YJ+Eu0I9qz9ikKQu+oKJcTWGlxJN7CIhZNmMyJb3tpQC7prn3yspt3rOP3
         21gJGBOTIaZzIV639JslXvcNRODXlN+r0gMT/jJcwdpVZoEgCa6qR2fRyeBdkrCkM4zu
         kKtxSQsuKRW3kfvE/Xv14v10Yl+wPKI4Lw7RNf1lgmvZk0k7kOCLHcW5S717fLPlbbGg
         piTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi1zIU/C5vXecTe24aeCQt5Oeu+oyqRxRS6OZIAdXQ4=;
        b=YXI1v9bwW3+TxMts1nOm/6dKpBrC/sFRt1MSaccLUVd2TlpRhB4vd2yiEkmOfyYxFb
         E7RXe4FcmUFLH6dGuECRHYLSWerFMpVGOJ922eQrri4fVb+27eErDaFPPSkWNJoBGgOz
         v3ujQb9SGAjRxqwg2GHG80Z22EpHHwH0uH0QLl1l2V80a98zlzAwXJMTSPcoYbcn4vLu
         CWXmzMCN6qq4QpQW28wNT/UbdoSbf0/tLGsNicTfh0TDPPQFzRNLtr9k+4h1UYaoD05k
         m9gtiOK54vrYrFsd7Zw+yYt4OkpOmGRlZBVgA4Bho2gM0l6jwnYeJ9KYSr/cOqipkOD5
         0KZA==
X-Gm-Message-State: ACrzQf3xF0SW/yObXkEYOZGXtuNw0tf1bjtLxrElpH+V53lT7NMbVYwB
        kEaakkWFtbBS1YUasuPgXMjCJh+ZcxNBLQ==
X-Google-Smtp-Source: AMsMyM57bqWUzqgax10Hz9KEzO7TFZqKzl030Nogv9UZ5wz00qBbYpDn62oxKTDXmnzn5MaYBoB6Pw==
X-Received: by 2002:a17:907:9804:b0:78d:1846:953 with SMTP id ji4-20020a170907980400b0078d18460953mr22240829ejc.330.1665564400635;
        Wed, 12 Oct 2022 01:46:40 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b00782e9943c99sm817469ejh.219.2022.10.12.01.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:46:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiXNv-004FLb-0c;
        Wed, 12 Oct 2022 10:46:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v2 4/4] diff-lib: parallelize run_diff_files for submodules
Date:   Wed, 12 Oct 2022 10:31:51 +0200
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
 <20221011232604.839941-5-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221011232604.839941-5-calvinwan@google.com>
Message-ID: <221012.86v8opmntc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 11 2022, Calvin Wan wrote:

Mostly style comments, but also others.:

> +				     unsigned *dirty_submodule, int *defer_submodule_status,
> +					 int *ignore_untracked_in_submodules)

If you can think of a (much) shorter name for this new paremeter, then...

> +		if (defer_submodule_status && *defer_submodule_status) {
> +			defer = 1;
> +			*ignore_untracked_in_submodules =
> +							diffopt->flags.ignore_untracked_in_submodules;
> +		} else {
> +			*dirty_submodule = is_submodule_modified(ce->name,
> +							diffopt->flags.ignore_untracked_in_submodules);

...code like this becomes a lot less verbose and doesn't need this much
indentation...

> +			if (defer_submodule_status) {
> +				struct string_list_item *item =
> +								string_list_append(&submodules, ce->name);

And e.g. here splittng up the two:

	struct string_list_item *item;

	item = ...

Makes for easier reading IMO.

> +				struct submodule_status_util *util = xmalloc(sizeof(*util));
> +				util->changed = changed;
> +				util->dirty_submodule = 0;
> +				util->ignore_untracked = ignore_untracked_in_submodules;
> +				util->newmode = newmode;
> +				util->ce = ce;

Maybe easier to read as:

	struct submodule_status_util tmp = {
		.changed = ...,
		.dirty_submodule =...,
	};

Then a single memcpy() to copy that data over to the malloc'd region.

> +				item->util = util;

And you can also do this idiomatically as:

	string_list_append(...)->util = util;

> +				continue;

> +		int parallel_jobs = 1;
> +		git_config_get_int("submodule.diffjobs", &parallel_jobs);
> +		if (parallel_jobs < 0) {
> +			die(_("submodule.diffjobs cannot be negative"));

Maybe we want something that uses git_parse_unsigned()?

> +		}

This should be cuddled with the "else if"

> +		else if (!parallel_jobs) {
> +			/*
> +			 * TODO: Decide what a reasonable default for parallel_jobs
> +			 * is. Currently mimics what other parallel config options
> +			 * default to.
> +			 */

It's OK to just drop this comment IMO.


> +			parallel_jobs = online_cpus();
> +		}

And as these are both one statement you can drop the {}'s altogether.

I think this would probably be more idiomatic as (untested):

	if (git_config_get_int(..., &v) || !v)
		jobs = online_cpus();
	else if (v < 0) /* or some API checks it for us? */
		die(...);
	else
		jobs = v;

I.e. we'd be explicitly using the "does the key exist" return value.

> +
> +		if (get_submodules_status(revs->repo, &submodules, parallel_jobs))
> +			BUG("Submodule status failed");

s/Sub/sub/, lower-case for bug(), die() etc.

> +		for (i = 0; i < submodules.nr; i++) {

You're iterating a string_list, so that "i" earlier should be size_t,
but better yet I think you can use for_each_string_list_item() here

> +struct submodule_parallel_status {
> +	int index_count;

Here you have an int...
> +	int result;
> +
> +	struct string_list *submodule_names;

..that'll be tracking the "nr" of this, which is size_t, let's have them
match.

Also, can we remove the "*" there and just have submodule.c populate
this struct directly, maybe not worth making it public, just a
thought...

..I didn't read further than this, ran out of time..
