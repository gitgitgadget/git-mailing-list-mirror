Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03A8C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhLTOLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhLTOLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:11:43 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63275C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:11:43 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l8so9813530qtk.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T7xbQXEPH4kPFhE26WQM13kalcLlHZHASoZHu965Mi4=;
        b=m2DpbNkI/4PaTYDQWAcvHKTUl7tC88zNIPYwibU5/O+aYfaJ5rJGxyvgQxn+H4hEZr
         089fTLRxx/2z3MN7Duf2VSzpGdQ8Y7JPy9DZV2Fi1dDsku16s90ZoGIWlarOOiB+CMGv
         dmokyg87EIgrGVi4EefZDTW984jgUGYVRAXOjsCFGy8AwDC5kG+TfZDsdfuWTFrBz7vh
         cnHuHZ+L7kh0T9jmqZF51SuUx+XbbRuyOS/bx1AUMsbDiMxo56zHLqskKWQrUrlDW28J
         u7K1tZlQ+mhKyZgBSguIf3VdUKyr0A9SwsFdTL5DdU0vifi1MTkFif79eFI7hsUnuy5j
         Sjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T7xbQXEPH4kPFhE26WQM13kalcLlHZHASoZHu965Mi4=;
        b=uX2hS3640r4Od7D4Xqil90wa5Ct3vL/Q076brEEEMl5c88+XuVvnQph7WCZ4VR4ozY
         9wdZaD2dNWgTe8fCLedk1sASYAvrtrl0K/oE8zQlAllwbqkCdPXtTYqVSSpN25zWmSpI
         P+6K0fF5UEFts4SY3XPDrSky8fqeSUAEuhIacqqer+nj92Qb8tCpl3fR0D8A/r4PaHeP
         h3i+vYd/WJyLTvVD3nGC4rvAuAuOUTFfiz8sgkRIOX6/CN2GiE5pwtkil9p2Ir/XmsxM
         jT6rmr0CEo3wYCaENEjfMyYmkyTcNMFXEd0yoBa2YSjdalrLH3aqjPBH+mzbTD3j586c
         OKgw==
X-Gm-Message-State: AOAM533/XKFohWGvuq6lyYoJTkqy41eQkxtWEOe6j1lWId8jGhwmxYpd
        xCKDrFyC9JZRb+KKWykNZ5E=
X-Google-Smtp-Source: ABdhPJwX9mUOOCOOGzYvs5etOF4Os7pS4vx58ojYlZFCu9n6yUgtBVuKi5MFlN6A1mAlczeKcuBxeQ==
X-Received: by 2002:a05:622a:8b:: with SMTP id o11mr7131686qtw.306.1640009502367;
        Mon, 20 Dec 2021 06:11:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id k19sm11737205qko.73.2021.12.20.06.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 06:11:41 -0800 (PST)
Message-ID: <f39af047-d244-14be-4cd8-b6c3199545f3@gmail.com>
Date:   Mon, 20 Dec 2021 09:11:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <ttaylorr@github.com>,
        Elijah Newren <newren@gmail.com>
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com>
 <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
 <CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/2021 7:58 PM, Eric Sunshine wrote:
> On Sun, Dec 19, 2021 at 3:47 PM Sean Allred <allred.sean@gmail.com> wrote:
>>> However, you missed the step (discussed in [1]) in which it is your
>>> responsibility to move the `core.bare=true` setting from
>>> git.git/config to git.git/worktree.config manually after setting
>>> `extensions.worktreeconfig=true`.

Thanks for this context of added responsibility. It seems a bit strange
to require this, since it doesn't make any sense to have a bare worktree
(at least not to me, feel free to elaborate on the need of such a
situation).

I think the most defensive thing to do would be to always special case
core.bare to false when in a worktree. But if there is a reason to allow
bare worktrees, then that isn't feasible.

>> Ahh, that makes sense!  I did notice the `core.bare` setting being
>> respected in source and figured this had a part to play (which is why
>> I included git-config output).
>>
>> I think then that I was overzealous in trying to MWE-ify the issue: as
>> I noted, I found this issue when I was trying to perform a
>> sparse-checkout within the worktree.  To memory (I don't have my work
>> system at the moment and don't have its `history`), I think it went
>> something like this:
>>
>>     git worktree add --no-checkout ../next && cd ../next
>>     git sparse-checkout init --cone # auto-created a worktree config
>>     git sparse-checkout set t
> 
> Thanks for this information. I haven't followed sparse-checkout mode
> at all and haven't used it, so I quickly scanned the man page for the
> worktree-relevant information, and indeed I was able to reproduce the
> problem using the recipe (with the prerequisite that the repository is
> bare) which you present here.
> 
>> I think either the git-sparse-checkout-set command (or the
>> git-checkout I ran after) would fail complaining that I was not in a
>> worktree.
> 
> It is indeed the `git sparse-checkout set` command which fails.

Right, 'init' will set the sparse-checkout information in your worktree
config and initialize it as needed, here:

static int set_config(enum sparse_checkout_mode mode)
{
	const char *config_path;

	if (upgrade_repository_format(1) < 0)
		die(_("unable to upgrade repository format to enable worktreeConfig"));
	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
		error(_("failed to set extensions.worktreeConfig setting"));
		return 1;
	}

	config_path = git_path("config.worktree");
	git_config_set_in_file_gently(config_path,
				      "core.sparseCheckout",
				      mode ? "true" : NULL);

	git_config_set_in_file_gently(config_path,
				      "core.sparseCheckoutCone",
				      mode == MODE_CONE_PATTERNS ? "true" : NULL);

	if (mode == MODE_NO_PATTERNS)
		set_sparse_index_config(the_repository, 0);

	return 0;
}

So, we are manually specifying "put this in the config.worktree file"
and not going through some "initialize worktree config" helper. Such
a helper would be useful to avoid this issue in the future.

>> Based on the above, it sounds like `init` is creating the
>> worktree-specific config, but is not overriding `core.bare` in that
>> config.  Would a patch to take this step this automatically be
>> well-received?
> 
> This looks like a legitimate oversight, so some sort of patch to
> resolve it would likely be welcomed.
> 
>> I see two options for when to set `core.bare=false` in
>> worktree-specific config:
>>
>>   1. At git-worktree-add: This is probably the earliest time which
>>      makes sense, but may be over-reach.  I'm not up-to-speed on how
>>      worktree-specific configs are generally considered on this list.
>>      If I were implementing a workaround, though, this is probably
>>      where I'd make it.
> 
> My knee-jerk reaction is that applying a "fix" to `git worktree add`
> to assign `core.bare=false` in the worktree-specific config may be
> misguided, or at least feels too much like a band-aid. Although it's
> true that that would address the problem for worktrees created after
> `extensions.worktreeconfig=true` is set, it won't help
> already-existing worktrees. This reason alone makes me hesitant to
> endorse this approach.

Yeah, my concern is that it requires the extension and could cause
some tools to stop working immediately. If we have the extension
already, it might make sense to initialize the file then.

(...)
>>   2. At git-sparse-checkout-init: This is where the problem begins to
>>      have an effect, so this might also make sense.
> 
> Yes, if I'm understanding everything correctly, this seems like the
> best and most localized place to address the problem at this time. The
> simple, but too minimal, approach would be for `git sparse-checkout
> init` to simply add `core.bare=false` to the worktree-specific config,
> however, this only addresses the immediate problem and still leaves
> things broken in general for any non-sparse worktrees.
> 
> So, the better and more correct approach, while still being localized
> to `git sparse-checkout init` is for it to respect the documented
> requirement and automatically move `core.bare` and `core.worktree`
> from .git/config to .git/worktree.config if those keys exist. That
> should leave everything in a nice Kosher state for all worktrees,
> existing and newly-created.

I agree that this is the only place that currently _writes_ to the
worktree config. All other code paths that seem to care about the
worktree config specifically only read from the config using a
modified scope.

My thought on the direction to go would be to extract some code
from the set_config() in builtin/sparse-checkout.c into a config
helper, say "ensure_worktree_config_exists()", that adds the
extension, creates the file, and then adds core.bare=false.

Even better, we could create a config helper that writes to the
worktree config, and _that_ could ensure the config is set
correctly before writing the requested value.

I'll take a stab at this today.

> (I've cc:'d a few sparse checkout area experts, though I may have
> forgotten some.)

Thank you for CC'ing me!
-Stolee
