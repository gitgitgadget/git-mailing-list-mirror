Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F68C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhLGNFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhLGNFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:05:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8193AC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:01:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o20so56681359eds.10
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=czmKAvgqHfYY8l7Nq0vEuYcd65MKRFtbnbweDRQwOGk=;
        b=aor1pkz8qtuYPFC6JteNOimWeBIT1fvcdUyJp12RQNTN1iGnAZR+7usbQzqghkWEDC
         6rDKZ9I41uskUxROs/4onWgij46wUQy1OCR8mZcOfz8iC6E5JrQiOi7KpuGFajzIfJV9
         UusJ83xeu4XMeE4hGr2dEwcNbrZ5A+80zr5XknMNq02PS+XjhFpdvBa4qtEYveOVS4cz
         Ls/NFIaOfCNczAdaIRRHGEqT3k/vKFIlzCPvIMvzGdpXdeqpVzEV1pR2A/MoMz28Vo6v
         6IfRwXKDCuwvgS7Zux2mTdGinAVLLrsDlQfzXTTa+aqa1fbgXOo5Yolrl8fTjbtA+QcY
         Owmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=czmKAvgqHfYY8l7Nq0vEuYcd65MKRFtbnbweDRQwOGk=;
        b=HVr59RPoXiDO9pnTCFg14EIJUgYGXH3Rqedop2ZxZvT0DT5ofrWtKM+cx5sfSrYuUT
         Jvu19rrxHifLIS+lUYmEpO2k+Q0vVzek1fvHY1Mlz/RqoKediWBrilgccDTaZb4m2Xb3
         fLR6oMswv8IV5935O38Yf8EaoD5S6r+TJ4UOWCRNhNiEcKogUG2w6zTER/LTcXhgNWd6
         H5N/s6OwcJvie4lxTuek5nGQ+Q2IuDiyHy59Bbqbv6+UHv3zgZHwj3pqNoWWdbIYZ/BE
         qZ0JGykjOmbBsAD1/YtGYOIgToXJ6CdPMbnXHMYpg/67g032LRlyiLPFDpZOOS7PcBY5
         hsTg==
X-Gm-Message-State: AOAM5326jKaihHEqiZOt2Lja7KUV9+vGmUBejmJNNNenUFLyEwY71EHj
        Snb5boP32T5XyOL7qYIfj+NzRk/I22avXA==
X-Google-Smtp-Source: ABdhPJzeUhpUBbaGqlBw/4o+bBf1RDWNR6Lg+Rob5yRJ2K+LxczAtBoS2smsZ6eNI9gRtHufX8Qg0g==
X-Received: by 2002:a17:907:e8a:: with SMTP id ho10mr52356707ejc.191.1638882101685;
        Tue, 07 Dec 2021 05:01:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qk40sm8406046ejc.2.2021.12.07.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:01:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mua6G-0019l8-Kn;
        Tue, 07 Dec 2021 14:01:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, nksingh85@gmail.com, ps@pks.im,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
Date:   Tue, 07 Dec 2021 13:29:04 +0100
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
Message-ID: <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> This commit introduces the `core.fsync` configuration
> knob which can be used to control how components of the
> repository are made durable on disk.
>
> This setting allows future extensibility of the list of
> syncable components:
> * We issue a warning rather than an error for unrecognized
>   components, so new configs can be used with old Git versions.

Looks good!

> * We support negation, so users can choose one of the default
>   aggregate options and then remove components that they don't
>   want. The user would then harden any new components added in
>   a Git version update.

I think this config schema makes sense, but just a (I think important)
comment on the "how" not "what" of it. It's really much better to define
config as:

    [some]
    key = value
    key = value2

Than:

    [some]
    key = value,value2

The reason is that "git config" has good support for working with
multi-valued stuff, so you can do e.g.:

    git config --get-all -z some.key

And you can easily (re)set such config e.g. with --replace-all etc., but
for comma-delimited you (and users) need to do all that work themselves.

Similarly instead of:

    some.key = want-this
    some.key = -not-this
    some.key = but-want-this

I think it's better to just have two lists, one inclusive another
exclusive. E.g. see "log.decorate" and "log.excludeDecoration",
"transfer.hideRefs"

Which would mean:

    core.fsync = want-this
    core.fsyncExcludes = -not-this

For some value of "fsyncExcludes", maybe "noFsync"? Anyway, just a
suggestion on making this easier for users & the implementation.

> This also supports the common request of doing absolutely no
> fysncing with the `core.fsync=none` value, which is expected
> to make the test suite faster.

Let's just use the git_parse_maybe_bool() or git_parse_maybe_bool_text()
so we'll accept "false", "off", "no" like most other such config?

> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  Documentation/config/core.txt | 27 +++++++++----
>  builtin/fast-import.c         |  2 +-
>  builtin/index-pack.c          |  4 +-
>  builtin/pack-objects.c        |  8 ++--
>  bulk-checkin.c                |  5 ++-
>  cache.h                       | 39 +++++++++++++++++-
>  commit-graph.c                |  3 +-
>  config.c                      | 76 ++++++++++++++++++++++++++++++++++-
>  csum-file.c                   |  5 ++-
>  csum-file.h                   |  3 +-
>  environment.c                 |  1 +
>  midx.c                        |  3 +-
>  object-file.c                 |  3 +-
>  pack-bitmap-write.c           |  3 +-
>  pack-write.c                  | 13 +++---
>  read-cache.c                  |  2 +-
>  16 files changed, 164 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index dbb134f7136..4f1747ec871 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -547,6 +547,25 @@ core.whitespace::
>    is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
>    errors. The default tab width is 8. Allowed values are 1 to 63.
>  
> +core.fsync::
> +	A comma-separated list of parts of the repository which should be
> +	hardened via the core.fsyncMethod when created or modified. You can
> +	disable hardening of any component by prefixing it with a '-'. Later
> +	items take precedence over earlier ones in the list. For example,
> +	`core.fsync=all,-pack-metadata` means "harden everything except pack
> +	metadata." Items that are not hardened may be lost in the event of an
> +	unclean system shutdown.
> ++
> +* `none` disables fsync completely. This must be specified alone.
> +* `loose-object` hardens objects added to the repo in loose-object form.
> +* `pack` hardens objects added to the repo in packfile form.
> +* `pack-metadata` hardens packfile bitmaps and indexes.
> +* `commit-graph` hardens the commit graph file.
> +* `objects` is an aggregate option that includes `loose-objects`, `pack`,
> +  `pack-metadata`, and `commit-graph`.
> +* `default` is an aggregate option that is equivalent to `objects,-loose-object`
> +* `all` is an aggregate option that syncs all individual components above.
> +

It's probably a *bit* more work to set up, but I wonder if this wouldn't
be simpler if we just said (and this is partially going against what I
noted above):

== BEGIN DOC

core.fsync is a multi-value config variable where each item is a
pathspec that'll get matched the same way as 'git-ls-files' et al.

When we sync pretend that a path like .git/objects/de/adbeef... is
relative to the top-level of the git
directory. E.g. "objects/de/adbeaf.." or "objects/pack/...".

You can then supply a list of wildcards and exclusions to configure
syncing.  or "false", "off" etc. to turn it off. These are synonymous
with:

    ; same as "false"
    core.fsync = ":!*"

Or:

    ; same as "true"
    core.fsync = "*"

Or, to selectively sync some things and not others:

    ;; Sync objects, but not "info"
    core.fsync = ":!objects/info/**"
    core.fsync = "objects/**"

See gitrepository-layout(5) for details about what sort of paths you
might be expected to match. Not all paths listed there will go through
this mechanism (e.g. currently objects do, but nothing to do with config
does).

We can and will match this against "fake paths", e.g. when writing out
packs we may match against just the string "objects/pack", we're not
going to re-check if every packfile we're writing matches your globs,
ditto for loose objects. Be reasonable!

This metharism is intended as a shorthand that provides some flexibility
when fsyncing, while not forcing git to come up with labels for all
paths the git dir, or to support crazyness like "objects/de/adbeef*"

More paths may be added or removed in the future, and we make no
promises that we won't move things around, so if in doubt use
e.g. "true" or a wide pattern match like "objects/**". When in doubt
stick to the golden path of examples provided in this documentation.

== END DOC


It's a tad more complex to set up, but I wonder if that isn't worth
it. It nicely gets around any current and future issues of deciding what
labels such as "loose-object" etc. to pick, as well as slotting into an
existing method of doing exclude/include lists.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 857be7826f3..916c55d6ce9 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
>  		 * If so, rewrite it like in fast-import
>  		 */
>  		if (pack_to_stdout) {
> -			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
> +			finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
> +					  CSUM_HASH_IN_STREAM | CSUM_CLOSE);

Not really related to this per-se, but since you're touching the API
everything goes through I wonder if callers should just always try to
fsync, and we can just catch EROFS and EINVAL in the wrapper if someone
tries to flush stdout, or catch the fd at that lower level.

Or maybe there's a good reason for this...

> [...]
> +/*
> + * These values are used to help identify parts of a repository to fsync.
> + * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
> + * repository and so shouldn't be fsynced.
> + */
> +enum fsync_component {
> +	FSYNC_COMPONENT_NONE			= 0,

I haven't read ahead much but in most other such cases we don't define
the "= 0", just start at 1<<0, then check the flags elsewhere...

> +static const struct fsync_component_entry {
> +	const char *name;
> +	enum fsync_component component_bits;
> +} fsync_component_table[] = {
> +	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
> +	{ "pack", FSYNC_COMPONENT_PACK },
> +	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
> +	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
> +	{ "objects", FSYNC_COMPONENTS_OBJECTS },
> +	{ "default", FSYNC_COMPONENTS_DEFAULT },
> +	{ "all", FSYNC_COMPONENTS_ALL },
> +};
> +
> +static enum fsync_component parse_fsync_components(const char *var, const char *string)
> +{
> +	enum fsync_component output = 0;
> +
> +	if (!strcmp(string, "none"))
> +		return output;
> +
> +	while (string) {
> +		int i;
> +		size_t len;
> +		const char *ep;
> +		int negated = 0;
> +		int found = 0;
> +
> +		string = string + strspn(string, ", \t\n\r");

Aside from the "use a list" isn't this hardcoding some windows-specific
assumptions with \n\r? Maybe not...
