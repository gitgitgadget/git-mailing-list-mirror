Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3062C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 09:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiC2JZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiC2JZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 05:25:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE831CFEA
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 02:23:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h4so12180803edr.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IBbKwCmFBwrN906bF+dPlt+kok11PHddCEa00hhpbgQ=;
        b=VlhUFERSU4ErW3YJbzmwkx7vOoxW3a3Say4HXM5OqG32lQS4dS/c3H0rs1n6tokg8J
         WCEpMcbueCQYjH5Xu3biyQ74vQ79wf1FzAMnh1dv4GViyC8SwRWgqmjAFyAlij7qp006
         ZqKCiCkv0d+GnP8Hnr2tNkCrXUYVjyPLe5DZbIHmuobbT4hYRPL3xiqdJaGx1WpShl0e
         /OJ1jBO0MvZp2Ri2ztWf4+NB2uuhHX7i6SrSyxpKMX91OCTBli8S/n+FKAfkTiczpJhC
         72q+/9QkJXd9FSQsgzX3X/pIbakD1c6QBZmJv9rmFtXb0kwVfy+0GaLznnJGVEYEnCT8
         WLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IBbKwCmFBwrN906bF+dPlt+kok11PHddCEa00hhpbgQ=;
        b=toaKvVF2kK6UiT3oMfE8FbM4BJZp7bC7xLuct2bt3RXyBVaxK2x3BWNESF0EsJOOQM
         WahcmPpxnB58CSFRUID+HFVxjSfKZGI8t8hH1WMalz01h9lRHoIMdVgehd10Gmx0s0nX
         r1s9+ynZHTwBLE0y6rb/jeYjPrhblemRUa/K5erTndIIbcn84egNMAheyf2oHMTfXIfd
         t3NDQKsjHdk/bGlz3irK96Wpey+2UPgrEPAhlW4akuHyQJx3K1AA8+ZSDLm3TOWCDCMX
         yrjkFv3en8TQU9pdkjL2BWa7KMnae87qj+SDDPX+0Hu/dihGjgupwuwbQJOE8UuDiGki
         Q1tw==
X-Gm-Message-State: AOAM533O7L5z+9MhoWklnBERwkXZNfIXwgwzqwtXv46lvqCoxLMIeGop
        lid1AWk4JdhyUHkoWMo038A=
X-Google-Smtp-Source: ABdhPJzTZhLc+LHwS7cjPR7tmnd8n02bk/48QGn73sWLNrzykWdzP8BdPH1jPGpOgdGFG8LSOa1RiA==
X-Received: by 2002:a50:d84c:0:b0:418:f176:79df with SMTP id v12-20020a50d84c000000b00418f17679dfmr3217509edj.353.1648545813848;
        Tue, 29 Mar 2022 02:23:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id go40-20020a1709070da800b006dfc3945312sm7031819ejc.202.2022.03.29.02.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 02:23:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZ84a-003XJS-Ms;
        Tue, 29 Mar 2022 11:23:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Date:   Tue, 29 Mar 2022 11:04:18 +0200
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <Yjt6mLIfw0V3aVTO@nand.local>
Message-ID: <220329.86h77h2ju3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Taylor Blau wrote:

> On Wed, Mar 23, 2022 at 03:22:13PM -0400, Derrick Stolee wrote:
>> On 3/23/2022 2:03 PM, Josh Steadmon wrote:
>> > prepare_repo_settings() initializes a `struct repository` with various
>> > default config options and settings read from a repository-local config
>> > file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only
>> > in git repos), prepare_repo_settings was changed to issue a BUG() if it
>> > is called by a process whose CWD is not a Git repository. This approach
>> > was suggested in [1].
>> >
>> > This breaks fuzz-commit-graph, which attempts to parse arbitrary
>> > fuzzing-engine-provided bytes as a commit graph file.
>> > commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
>> > since we run the fuzz tests without a valid repository, we are hitting
>> > the BUG() from 44c7e62 for every test case.
>> >
>> > Fix this by refactoring prepare_repo_settings() such that it sets
>> > default options unconditionally; if its process is in a Git repository,
>> > it will also load settings from the local config. This eliminates the
>> > need for a BUG() when not in a repository.
>>
>> I think you have the right idea and this can work.
>
> Hmmm. To me this feels like bending over backwards in
> `prepare_repo_settings()` to accommodate one particular caller. I'm not
> necessarily opposed to it, but it does feel strange to make
> `prepare_repo_settings()` a noop here, since I would expect that any
> callers who do want to call `prepare_repo_settings()` are likely
> convinced that they are inside of a repository, and it probably should
> be a BUG() if they aren't.

I think adding that BUG() was overzelous in the first place, per
https://lore.kernel.org/git/211207.86r1apow9f.gmgdl@evledraar.gmail.com/;

I don't see what purpose it solves to be this overly anal in this code,
and 44c7e62e51e (repo-settings: prepare_repo_settings only in git repos,
2021-12-06) just discusses "what" and not "why".

I think a perfectly fine solution to this is just to revert it:
	
	diff --git a/repo-settings.c b/repo-settings.c
	index b4fbd16cdcc..e162c1479bf 100644
	--- a/repo-settings.c
	+++ b/repo-settings.c
	@@ -18,7 +18,7 @@ void prepare_repo_settings(struct repository *r)
	 	int manyfiles;
	 
	 	if (!r->gitdir)
	-		BUG("Cannot add settings for uninitialized repository");
	+		return;
	 
	 	if (r->settings.initialized++)
	 		return;

I have that in my local integration branch, because I ended up wanting
to add prepare_repo_settings() to usage.c, which may or may not run
inside a repo (and maybe we'll have that config, maybe not).

But really, in common-main.c we do a initialize_the_repository(), so a
"struct repository" is already a thing we have before we get to the
"RUN_SETUP_GENTLY" or whatever in git.c, and a bunch of things all over
the place assume that it's the equivalent of { 0 }-initialized.

If we actually want to turn repository.[ch] into some strict API where
"Tho Shalt Not Use the_repository unless" we're actually in a repo
surely we should have it be NULL then, and to add that BUG() to the
likes of initialize_the_repository().

Except I think there's no point in that, and it would just lead to
pointless churn, so why do it for the settings in particular? Why can't
they just be { 0 }-init'd too?

If some caller cares about the distinction between r->settings being
like it is because of us actually having a repo, or us using the
defaults why can't they just check r->gitdir themselves?

For the rest the default of "just provide the defaults then" is a much
saner API.

I think *maybe* what this actually wanted to do was to bridge the gap
between "startup_info->have_repository" and a caller in builtin/ calling
prepare_repo_settings(), i.e. that it was a logic error to have that
RUN_SETUP_GENTLY caller do that.

I can see how that *might* be useful as some sanity assertion, but then
maybe we could add a more narrow BUG() just for that case, even having a
builtin_prepare_repo_settings() wrapper in builtin.h or whatever.
