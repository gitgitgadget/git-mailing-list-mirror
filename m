Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CA0C433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 14:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiBLOeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:34:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBLOeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 09:34:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42929B0B
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:34:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w10so1947158edd.11
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VNiqVIj68JYrwSXxXM53avreQ3VkK9eS9nverVfEp5s=;
        b=i6w7jtiWcnTrISwHh0lXdMX7WqmwriUlUgSZ4cAoSxhCDCJbzLiNB3qfNDa8bGdeZr
         ptufMLys+1n8bNS4nAyZnTP8AddZW7HHR9mILEkDqWcSuqcMDyYB4xZjWYgXv4622zGE
         fBTaK3cMxiQxEa/szm0GdlDVzNQNgEwR9ASF53bwFCXEq+qgPLSupQLU3ECjfZZ/nSnu
         XzbpUFeoooqS6pD9FvstOQgYQA/hgycHMR9GQ3W8Y1BsmYs5nCCe3xFUjYKj7rUAyDDj
         LiSNL8lb0VggPDUUIQ9DZAJ8YfVfyI0no/zY277ZG3+ETl3iROJOKGlZEdxnYuRJ1Z8c
         KUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VNiqVIj68JYrwSXxXM53avreQ3VkK9eS9nverVfEp5s=;
        b=2c8xp9Xcb+hELARECUJHk0yhWeSAxdqmpmC8fD9hYli4QO4yk10MQOG+y73KWppKrr
         QlyqyekiZGYzb9aknxD/Ackz2hZMmi205QtyO5wfq3iKcYOIEnZT5hJ5KkuJv20PA2MR
         XfYxfhh2ZCGV7x5Bzrt2qFXefAGR4sypvc7RHDi67YyZZSmlzlJXN1FJxH2D/exSvjmw
         TfSdWKhCkdgnvkZhAqxw7YW2AzIGDwQkOlQ2rxDtCR75YJKDBLHAQ/bBPMfY8aJOxJvl
         OMvyL/5cEXC9ss1KAYADqeoMgJMqlqPbEO1v2DnZPYFB6PsGtrd7Xxm7uUVN/HfdIyB3
         0vVw==
X-Gm-Message-State: AOAM531OmB16Q4yvZrsRRhGQwQ8mu116TMkd0gBgjHTEfRrfq4aS4NsN
        BiFrBnJfJ7MIe3xp/fIY1HWn/GMPKy6JCQ==
X-Google-Smtp-Source: ABdhPJxCpq1vL4V5bUJZs9UD/8t4e03CPHhQ5oMsxcxkoc63trsb4J6IWmEdGqW7C1g4CB6SUfX3Uw==
X-Received: by 2002:a05:6402:3509:: with SMTP id b9mr6807417edd.192.1644676448579;
        Sat, 12 Feb 2022 06:34:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 22sm59106eja.165.2022.02.12.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:34:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nItTT-000RYm-Bp;
        Sat, 12 Feb 2022 15:34:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 04/20] submodule--helper: run update using child
 process struct
Date:   Sat, 12 Feb 2022 15:33:11 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-5-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220210092833.55360-5-chooglen@google.com>
Message-ID: <220212.86y22gxig0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 10 2022, Glen Choo wrote:

> From: Atharva Raykar <raykar.ath@gmail.com>
>
> We switch to using the run-command API function that takes a
> 'struct child process', since we are using a lot of the options. This
> will also make it simple to switch over to using 'capture_command()'
> when we start handling the output of the command completely in C.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/submodule--helper.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 09cda67c1e..db71e6f4ec 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2344,47 +2344,45 @@ static int fetch_in_submodule(const char *module_=
path, int depth, int quiet, str
>=20=20
>  static int run_update_command(struct update_data *ud, int subforce)
>  {
> -	struct strvec args =3D STRVEC_INIT;
> -	struct strvec child_env =3D STRVEC_INIT;
> +	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	char *oid =3D oid_to_hex(&ud->oid);
>  	int must_die_on_failure =3D 0;
> -	int git_cmd;
>=20=20
>  	switch (ud->update_strategy.type) {
>  	case SM_UPDATE_CHECKOUT:
> -		git_cmd =3D 1;
> -		strvec_pushl(&args, "checkout", "-q", NULL);
> +		cp.git_cmd =3D 1;
> +		strvec_pushl(&cp.args, "checkout", "-q", NULL);
>  		if (subforce)
> -			strvec_push(&args, "-f");
> +			strvec_push(&cp.args, "-f");
>  		break;
>  	case SM_UPDATE_REBASE:
> -		git_cmd =3D 1;
> -		strvec_push(&args, "rebase");
> +		cp.git_cmd =3D 1;
> +		strvec_push(&cp.args, "rebase");
>  		if (ud->quiet)
> -			strvec_push(&args, "--quiet");
> +			strvec_push(&cp.args, "--quiet");
>  		must_die_on_failure =3D 1;
>  		break;
>  	case SM_UPDATE_MERGE:
> -		git_cmd =3D 1;
> -		strvec_push(&args, "merge");
> +		cp.git_cmd =3D 1;
> +		strvec_push(&cp.args, "merge");
>  		if (ud->quiet)
> -			strvec_push(&args, "--quiet");
> +			strvec_push(&cp.args, "--quiet");
>  		must_die_on_failure =3D 1;
>  		break;
>  	case SM_UPDATE_COMMAND:
> -		git_cmd =3D 0;
> -		strvec_push(&args, ud->update_strategy.command);
> +		cp.use_shell =3D 1;
> +		strvec_push(&cp.args, ud->update_strategy.command);
>  		must_die_on_failure =3D 1;
>  		break;
>  	default:
>  		BUG("unexpected update strategy type: %s",
>  		    submodule_strategy_to_string(&ud->update_strategy));
>  	}
> -	strvec_push(&args, oid);
> +	strvec_push(&cp.args, oid);
>=20=20
> -	prepare_submodule_repo_env(&child_env);
> -	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_=
SHELL,
> -				     ud->sm_path, child_env.v)) {
> +	cp.dir =3D xstrdup(ud->sm_path);
> +	prepare_submodule_repo_env(&cp.env_array);
> +	if (run_command(&cp)) {
>  		switch (ud->update_strategy.type) {
>  		case SM_UPDATE_CHECKOUT:
>  			printf(_("Unable to checkout '%s' in submodule path '%s'"),

If this series is re-arranged so that this comes first, this compiles
just fine & passes all tests.

So I wonder if we can peel this and perhaps other such easy to review
prep changes off into its own series, since this one has grown to 20
patches.

We could then hopefully fast-track those easy-to-review prep changes,
which would make the "real" series to follow smaller and easier to
review/grok.
