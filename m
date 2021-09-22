Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7D4C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D218660F23
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhIVLSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbhIVLS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:18:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7681EC0613B6
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:16:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg28so8618351edb.1
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7SBslxOTpbKPumKHaIfK8jxbzWZFPJGg44M8yBmiOZA=;
        b=QCZUTddRfMIkuMLF1zgR20BdF+HoaDFQjKfZWqYXnx2oopXe8L823+ywnfL605SJ84
         QcbgtLOO/8LyPSA5JyQkZqEojneGYvcyng8qbBT+gG0b5xc0f+NsC4M0v9whMPNX71kn
         HGAAk4I1SdajzS48h7CcUviKW/2k8BpSTTsT3RSjf7mH/3pK7sKNvChn+FrY25sDpVj8
         SKYpI0nJ5Zjb54j/AuAP3tgXhXE7EUUCf/LKyUAT2QqurznuBi6Dm00h/+SMK40TRlHc
         ttV8TvJUtZQL52WgwR56TDHnV3ZDd73ZgxACBzwsxaxGF7aeXdML+OvIZKzOuCjysMX4
         otOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7SBslxOTpbKPumKHaIfK8jxbzWZFPJGg44M8yBmiOZA=;
        b=KPo3ChCXAYnUrg8ShDLXC6NA23FjM8xM2VfeauUI5fCDrWTakRIsB0Jey0UYLUWKXp
         glTE4+yCD2ahyhnpPKIZB6lsnqvKdJadv81k913VXiBkGFlb3YAPxwvwE4h7m/KwfAIw
         +gQZc3IGaHIvhBB0wd81lzVYcSt+PMEgz0CE5f+X7+3YEFh/pq47ns2HVvG185xS8BDM
         l+wFcEKOcW0/Bz9KGpJqEdXIE6cfngKfCyh5JLM0tIVFepAkuyJBQhDCh98cPErt9hiF
         Lmg0ZhConJSr5iF3rE+impJL2YnOsWnrn254MKFtjvU39EeUAZGenwY8TatGEESVHvhx
         yiJA==
X-Gm-Message-State: AOAM533c0CvYOVnvm75qr5mW5m8KRRa47Jw0rRp9oKlSVNAIDrysVf2r
        IeENc3+zq0CIQvp7fdOdy6+s95VmRLfwLw==
X-Google-Smtp-Source: ABdhPJy78lOFvgJYBsVlEwzKBau6YkAE/mPnJIT8MPPL9dWvNQhb64eB8bDOlqra7ENkk1G2LyOatA==
X-Received: by 2002:a17:906:eca7:: with SMTP id qh7mr40858785ejb.45.1632309372966;
        Wed, 22 Sep 2021 04:16:12 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bq4sm919136ejb.43.2021.09.22.04.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:16:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] branch: add --recurse-submodules option for
 branch creation
Date:   Wed, 22 Sep 2021 13:10:11 +0200
References: <20210921232529.81811-1-chooglen@google.com>
 <20210921232529.81811-3-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210921232529.81811-3-chooglen@google.com>
Message-ID: <87k0j87tdw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 21 2021, Glen Choo wrote:

>  static const char *head;
>  static struct object_id head_oid;
> +static int recurse_submodules = 0;

Nit: just s/ = 0// will do here, and is the convention typically...

> +	r_start_name = strcmp(start_name, "HEAD") ? start_name :
> +		refs_resolve_refdup(get_main_ref_store(r), start_name, 0, NULL, NULL);

IMO clearer just as an if/else.

> +	if (strcmp(r_start_name, "HEAD"))
> +		skip_prefix(r_start_name, "refs/heads/", &r_start_name);


> +	create_branch(r, name, r_start_name, force, clobber_head_ok, reflog,
> +		      quiet, track);
> +
> +	if (!recurse_submodules) {
> +		return;
> +	}

Can lose the braces here...

> +
> +	if (repo_read_index(r) < 0)
> +		die(_("index file corrupt"));

...Just as you do here..

> +
> +	for (i = 0; i < r->index->cache_nr; i++) {
> +		const struct cache_entry *ce = r->index->cache[i];
> +		if (!S_ISGITLINK(ce->ce_mode))
> +			continue;
> +		sub = submodule_from_path(r, null_oid(), ce->name);
> +		if (repo_submodule_init(&subrepo, r, sub) < 0) {
> +			warning(_("Unable to initialize subrepo %s, skipping."), ce->name);
> +			continue;
> +		}
> +		/*
> +		 * NEEDSWORK: branch tracking is not supported for
> +		 * submodules because it is not possible to get the
> +		 * remotes of a submodule.
> +		 */

It isn't?

    $ git -C sha1collisiondetection/ remote -v
    origin  https://github.com/cr-marcstevens/sha1collisiondetection.git
> [...]

> +test_expect_success 'setup superproject and submodule' '
> +	git init parent &&
> +	test_commit -C parent bar &&
> +	git init child &&
> +	test_commit -C child bar &&
> +	git -C parent submodule add ../child sub &&
> +	git -C parent commit -m "add submodule"
> +'
> +
> +test_expect_success '--recurse-submodules should create branches' '
> +	(
> +		cd parent &&
> +		git branch --recurse-submodules abc &&
> +		test_path_is_file .git/refs/heads/abc &&
> +		test_path_is_file .git/modules/sub/refs/heads/abc
> +	)
> +'

All this manual file checking should depend on REFFILES, but better yet
is there a reason this can't use rev-parse? I.e. why can't we inpect
this state with 'for-each-ref', 'rev-parse' and the like? Does this test
need to assert that these files end up in these specific locations, or
just the ref store? Ditto for the later ones.

> [...]
> +		cd parent &&
> +		git -c branch.autoSetupMerge=always branch --recurse-submodules ghi main &&
> +		test_path_is_file .git/modules/sub/refs/heads/ghi &&
> +		test "$(git config branch.ghi.remote)" = . &&
> +		test "$(git config branch.ghi.merge)" = refs/heads/main &&
> +		test "z$(git -C ../child config branch.ghi.remote)" = z &&
> +		test "z$(git -C ../child config branch.ghi.merge)" = z

Use test_cmp, also for this sort of thing the test "x$y" = "x" idiom
isn't needed unless you've got a computer from the mid-90s or something
:)
