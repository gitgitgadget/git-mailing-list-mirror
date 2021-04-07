Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C91C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E7861382
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347416AbhDGNrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245511AbhDGNrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 09:47:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52804C06175F
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 06:47:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w23so9695352edx.7
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LHNlOEu/4VLOxOULh4vW73U+DPl8P1adEjPehiphWVo=;
        b=O4jY3VE+XbtEEw89O+OPUIUnDLjacOngdR+a1B4U7k/6N2HzA7M84KZZVLoBrHVNxl
         8Knuj4Sz0rX8ZRUkPUVZoMr8BEOafzkzdYqAEnAVS3hb4eO9vR+ppxTXx7j44FHOJPkU
         JHDXu0DekpXiVDmtVKQRUqd8qMu0tNUbecSg4HMUgx64GjB52P3jgIN1lGJcb9BOsFnZ
         Uvmir8ZkhFA3290Yu+wje8y/YabUyCh54cHExG1aLP1yPl7vDn4mODkFnPJDhZekj8KL
         H226XAUxzyewTfKWeYaUUvTUejfdh393e7NnrijJox+/mme6iKXdcGpcMRsbPNZx2FQc
         UhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LHNlOEu/4VLOxOULh4vW73U+DPl8P1adEjPehiphWVo=;
        b=hitesW9+hlaRFV3g7voukj/KF2fqtodh/68MrQaDwErlonCWaKW93VzSW0pO1F2jge
         imJoOTe7Q2YYxA8vPO36cIl95XQNkCDwVG+r4c1NTnzqSdog9rsc8s+0KkQPGTXnWC5U
         aDwDjgu9DcAtTVJTBiQf8jzbNC/FN8JgreOXrwNxc3YZo6hkhrL6gnVReLNDngOsbEbp
         AcEG9S/aQ/VnICvSSjnSp+ftI7QdUKIELfJrTvNQnFYklVYpv8qtu4rKAl540I3AY7O1
         wdlaH8ll9GM8aW9WfF0eL6RvAlvrb5/VzMRP5Uyiahp2AzDFigGCtdrFVnppQiabqGGA
         8k7g==
X-Gm-Message-State: AOAM531GZkj+JXUuzury3fcpbFzFJoyn0EqpwWW0y8MReUvcSQWZ5XHK
        5lGcjWAynzQMwsiG6NLhv/o=
X-Google-Smtp-Source: ABdhPJxeNqH34v4l+wd0HzZXAZRQvoxPKHwE6S7RJomoWdWK4imnx075vnKkKf0/x2vBbNF1dqqIWQ==
X-Received: by 2002:a05:6402:7c5:: with SMTP id u5mr4576175edy.7.1617803227159;
        Wed, 07 Apr 2021 06:47:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n3sm12489202ejj.113.2021.04.07.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:47:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Apr 2021 15:47:05 +0200
Message-ID: <87ft02jjfq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:

> This changes the names of the refs that would be fetched by the default
> refspec. Instead of "refs/prefetch/<remote>/<branch>" they will now go
> to "refs/prefetch/remotes/<remote>/<branch>". While this is a change, it
> is not a seriously breaking one: these refs are intended to be hidden
> and not used.

Not "a seriously breaking one" just because we'll assume nobody had a
remote they'd named "remotes" and they'll need to manually clean that
mess up (if needed), or ...?

> [...]
>  	objects from all registered remotes. For each remote, a `git fetch`
>  	command is run. The refmap is custom to avoid updating local or remote
>  	branches (those in `refs/heads` or `refs/remotes`). Instead, the
> -	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
> -	not updated.
> +	refs are stored in `refs/prefetch/`. Also, tags are not updated.

So, "tags are not updated", but:

>  
> -	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
> +	for (i = 0; i < remote->fetch.nr; i++) {
> +		struct refspec_item replace;
> +		struct refspec_item *rsi = &remote->fetch.items[i];
> +		struct strbuf new_dst = STRBUF_INIT;
> +		size_t ignore_len = 0;
> +
> +		if (rsi->negative) {
> +			strvec_push(&child.args, remote->fetch.raw[i]);
> +			continue;
> +		}
> +
> +		refspec_item_init(&replace, remote->fetch.raw[i], 1);
> +
> +		/*
> +		 * If a refspec dst starts with "refs/" at the start,
> +		 * then we will replace "refs/" with "refs/prefetch/".
> +		 * Otherwise, we will prepend the dst string with
> +		 * "refs/prefetch/".
> +		 */
> +		if (!strncmp(replace.dst, "refs/", 5))
> +			ignore_len = 5;
> +
> +		strbuf_addstr(&new_dst, "refs/prefetch/");
> +		strbuf_addstr(&new_dst, replace.dst + ignore_len);
> +		free(replace.dst);
> +		replace.dst = strbuf_detach(&new_dst, NULL);
> +
> +		strvec_push(&child.args, refspec_item_format(&replace));
> +
> +		refspec_item_clear(&replace);
> +	}

Isn't a blanket replacement of refs/heads/* with refs/* going to change
that? I haven't tested this so maybe it still doesn't work, but:

>  	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
>  	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
> -	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
> -	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&
> +	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote1/* <run-prefetch.txt &&
> +	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <run-prefetch.txt &&
> [...]
>
> +	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&

It seems we should at least have a test for the case of having a refspec
that pulls down tags.

I suspect that we could document this as an absolute before, as
refs/heads/* is the only namespace that'll refuse tags, but now that we
fetch refs/<whatever> that'll no longer be the case.

I'd think that this new behavior (if I'm right) is a feature, but that
we need to update the docs/tests appropriately.
