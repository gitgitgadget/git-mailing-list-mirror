Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C8CCA473
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 20:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiFOUGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiFOUGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 16:06:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781CF369DD
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:06:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v19so17775132edd.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rUfmJYsO5+chxQ5honZzqRcjoEvDMSTMKd4gRLq2LfA=;
        b=DMIGznnasAhpdTChk8kgxgFodDGK9CGKjRer6/yr4xjzT86pfZJRmpFoFHqEctr8qC
         Hn+PUvfZpXrOL68CQa8+niPPnBcV9b+pabiS+f+sWS18bL8FusxNjoxqbtO6DCQB0Eqh
         UQ3u7NGjT69GhSrElw0CnjZuZo4puCm7WzM/vHxgI5D+tTSMjLHfRBMmHlupNcuG+5vy
         4fMvXRTQ5tHGCUnw1Z3nwB/E3GjV8gXqyaQI9PMjVF16GW6w9u+UHnsNhxGQlZA03C7s
         S0k/uI+l+GbqwK7P9Eg3LZmmv5gu7J67QStQXb/06JCeC8XWU1SK9AxB0g40YfCxlU8a
         UdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rUfmJYsO5+chxQ5honZzqRcjoEvDMSTMKd4gRLq2LfA=;
        b=iSufXlDgAfNqCqYRNb184u51zbLV2r0nwKHgs4Y7hTvBO+jGtIRgYbTTty0+p317uv
         QbUB2c+xlwWsKrn98LbnRlHfrYyLeM5mJYZD1b8AHWbBn79P1pgZqZ55g/gAUpA05k2Y
         Sy384DtC96gO5aLQyNA9CdriYfHwzkp8WiDGWjP2DlvwUmp2Rz2aYWcoRyGVWwEmkctk
         GaQjzkxnrEaK8spTCFubAeJsk5sXGgCeSKT9kpXzyu04/hJYLc7vZaPgvo7DPzoYqIVV
         KO9nH/N3jZXmSo1mO782KG3zI3qGrf9s3GuIB1KK/4rsdUJiQD5610elAkGKqPqGEhOi
         kgAQ==
X-Gm-Message-State: AJIora/Nzbcavis2AHaiHQ4puBMOps8ixyXnXF32kihxPbToOSi2MREJ
        YUwp0okr6LG1o3VbY+F2TTE=
X-Google-Smtp-Source: AGRyM1tEeW2guGSphHCcRCRd3tLqDta3P1Ob1D04y5CSQoWk7fbNHH9eJ2YOaCCji4uQWWhqiXmp8Q==
X-Received: by 2002:a05:6402:84c:b0:430:aae2:6dd8 with SMTP id b12-20020a056402084c00b00430aae26dd8mr1875723edz.31.1655323602722;
        Wed, 15 Jun 2022 13:06:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id me26-20020a170906aeda00b006ff045d7c9bsm6716911ejb.173.2022.06.15.13.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:06:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1ZHl-000sya-BQ;
        Wed, 15 Jun 2022 22:06:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Kyle Zhao <kylezhao@tencent.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] send-pack.c: add config push.useBitmaps
Date:   Wed, 15 Jun 2022 21:47:58 +0200
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
Message-ID: <220615.86edzpy9m6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 15 2022, Kyle Zhao via GitGitGadget wrote:

[CC'd Taylor, who's worked a lot on bitmaps]

> From: Kyle Zhao <kylezhao@tencent.com>
>
> This allows you to disabled bitmaps for "git push". Default is false.

Thanks for following up.

Refresh my memory, we always use them if we find them now, correct?
I.e. if repack.writebitmaps=true

This doesn't make it clear: Are we now going to ignore them for "push"
by default, even if they exist? I.e. a change in the current default.

I think I recall from the previous discussions that it was a bit of hit
& miss, maybe we're confident that they're almost (or always?) bad for
"push", but I think there *are* cases where they help.

> Bitmaps are designed to speed up the "counting objects" phase of
> subsequent packs created for clones and fetches.
> But in some cases, turning bitmaps on does horrible things for "push"
> performance[1].
>
> [1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/
>
> Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
> ---
>     send-pack.c: add config push.useBitmaps
>     
>     This patch add config push.useBitmaps to prevent git push using bitmap.
>     
>     The origin discussion is here:
>     https://lore.kernel.org/git/b940e705fbe9454685757f2e3055e2ce@tencent.com/
>     
>     Thanks, Kyle
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1263%2Fkeyu98%2Fkz%2Fpush-usebitmps-config-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1263/keyu98/kz/push-usebitmps-config-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1263
>
>  Documentation/config/push.txt |  4 ++++
>  send-pack.c                   |  6 ++++++
>  send-pack.h                   |  3 ++-
>  t/t5516-fetch-push.sh         | 11 +++++++++++
>  4 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index e32801e6c91..d8fb0bd1414 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -137,3 +137,7 @@ push.negotiate::
>  	server attempt to find commits in common. If "false", Git will
>  	rely solely on the server's ref advertisement to find commits
>  	in common.
> +
> +push.useBitmaps::
> +	If this config and `pack.useBitmaps` are both "true", git will
> +	use pack bitmaps (if available) when git push. Default is false.
> \ No newline at end of file

"git diff" is telling you something is wrong here :) hint: missing \n.

> diff --git a/send-pack.c b/send-pack.c
> index bc0fcdbb000..d6091571caa 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -84,6 +84,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
>  		strvec_push(&po.args, "--progress");
>  	if (is_repository_shallow(the_repository))
>  		strvec_push(&po.args, "--shallow");
> +	if (!args->use_bitmaps)
> +		strvec_push(&po.args, "--no-use-bitmap-index");
>  	po.in = -1;
>  	po.out = args->stateless_rpc ? -1 : fd;
>  	po.git_cmd = 1;
> @@ -482,6 +484,7 @@ int send_pack(struct send_pack_args *args,
>  	int use_push_options = 0;
>  	int push_options_supported = 0;
>  	int object_format_supported = 0;
> +	int use_bitmaps = 0;
>  	unsigned cmds_sent = 0;
>  	int ret;
>  	struct async demux;
> @@ -497,6 +500,9 @@ int send_pack(struct send_pack_args *args,
>  	git_config_get_bool("push.negotiate", &push_negotiate);
>  	if (push_negotiate)
>  		get_commons_through_negotiation(args->url, remote_refs, &commons);
> +	git_config_get_bool("push.usebitmaps", &use_bitmaps);
> +	if (use_bitmaps)
> +		args->use_bitmaps = 1;

[A bit rambling, sorry]

A bit off of a use of the API, can't we just do:

	git_config_get_bool("push.usebitmaps", &args->use_bitmaps);

And drop the local variable? I.e. if we have a config variable we'll
write the value to it.

But then again that goes with the suggested default, i.e. I think we
should probably use them by default, and provide an out, unless we're
*really* sure they're useless for "push".

In this case I found the code a bit odd, which took me a moment to put
my finger on.

In builtin/send-pack.c we initialize "struct send_pack_args" in the file
scope, so it's zero'd out.

So all parameters are 0'd by default.

So your new "use_bitmaps" is born false.

Then when we get here you assign 0 to use_bitmaps, and only if it's true
do you use it.

Which to me is a couple of layers in to something that's less clear than
it could be, i.e. we're making the hard assumption here that the default
in the struct is false. So we should really just do:

	int tmp;
	if (!git_config_get_bool("push.usebitmaps", &tmp))
		args->use_bitmaps = tmp;

So don't care what the default was before, we have an explicit config
variable we're going to use, if we saw push.usebitmaps let's use its
value.

This way the default can flip, and this code downstream of that will
still do what's intended.

FWIW that "if" is redundant, but it's the general idiom, but we *can* do
it the way I suggested above, but I think it's clearer to go with the
second form, which reads more obviously as "if the variable exists, set
it to ...".

For config.c in particular the "without the if" works, but I think
that's relying on an implementation detail, i.e. we have a few other
APIs that "zero out" the parameter you put in as the first thing they
do. So if they also return "I didn't error" you want to use a temp
variable, and only assign it to your "real" variable if the return value
was "OK".

>  
>  	git_config_get_bool("transfer.advertisesid", &advertise_sid);
>  
> diff --git a/send-pack.h b/send-pack.h
> index e148fcd9609..f7af1b0353e 100644
> --- a/send-pack.h
> +++ b/send-pack.h
> @@ -26,7 +26,8 @@ struct send_pack_args {
>  		/* One of the SEND_PACK_PUSH_CERT_* constants. */
>  		push_cert:2,
>  		stateless_rpc:1,
> -		atomic:1;
> +		atomic:1,
> +		use_bitmaps:1;
>  	const struct string_list *push_options;
>  };
>  
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index dedca106a7a..ee0b912a5e8 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1865,4 +1865,15 @@ test_expect_success 'push warns or fails when using username:password' '
>  	test_line_count = 1 warnings
>  '
>  
> +test_expect_success 'push with config push.useBitmaps' '
> +	mk_test testrepo heads/main &&
> +	git checkout main &&
> +	GIT_TRACE=1 git push testrepo main:test >/dev/null 2>stderr &&

We generally don't >/dev/null in tests, just emit the output, and if we
run with -v you'll see it.

In this case though you want just:

    GIT_TRACE="$PWD/trace.log" [...]

Without any redirection,

Also, you probably want GIT_TRACE2_EVENT=$PWD/trace.json, and see
"test_subcommand". We have a handy helper for finding if we have trace2
regions.

I'm assuming we have some region for "used bitmaps" already, but I
didn't check...
