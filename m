Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD48FECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 19:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiHaTqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiHaTqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 15:46:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73A645073
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:46:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb36so9605719ejc.10
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=CebBVrOCpMYO+xEiik1IE3zhVoYjxsYS6c/x1C4Ty7U=;
        b=HCHgUJIgXBT93s9bM9jYEEQw4fRXpAnXND+jK8ZuliEZhuUjBbiHi81i+ZVLUjlgOW
         HFgSSAk6KCESGOw5hMvEfcKLsizsu8J4f64qHaeaG0QbZ7n9Qn+1ZYG0J7ZR3CJq+SYN
         qq1oNrWMzY+sb/m2NbjB3jLoxTOgXyy6s0BdDeazbDAV77IRdFhulUVRIETsUKi7RvQV
         BYUd4rmdPG53HEJ5WPDmjSWwnebsXt+9+2ObMrMWWkjngrZNyf99sJbE+RA5fna3VRtM
         9UAJ6WGxDf+w10JWrgT0ZR0FO2r2s1JrZ2RuFtLSDXWN9FWHOGSHK1gxK062uTr0ZgHz
         +BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CebBVrOCpMYO+xEiik1IE3zhVoYjxsYS6c/x1C4Ty7U=;
        b=aHd8lf3krfT1aC2kubdUUTtyXd8SgkzasLOcC/rFI0SRPT3Bx7WLDdCnnM2+NndegV
         97dMIWURfcCSgWFVfodZrhw/C8CeVDsN0SsLQQCmqO66jmZEQa+AOitfVnFuO7XSsteI
         L39n52t/K8kUxl7rP6GGd7U6Y6fRtTnrnk9AQicFg+x9AhnoQWGMSB+6tv+Qmkq5Ulx0
         kd05tzlHK3HmROcFkERkydYHF4xVwCPViz6gMKMKxMLVS8C/0H7NiJwhq8YqOvTkuwbz
         63gv2uYa/UQ3JGJE1YKLCoxq3Vs189rB1++F+EMRYLk+Gt4/0Y1lvs2NgXYDq/rf3f9X
         +u7g==
X-Gm-Message-State: ACgBeo0Mgz9bDnm2GVL4PY6bkZu4xNGuv0D7dZI+stlhOsPPPs/J9z8h
        MOEV8bjl8hRZvCUH39r3dxsP0WR5hp71ag==
X-Google-Smtp-Source: AA6agR4fXdmpc2Wt/3Q1TfGIt1SnucB++SR1soCsSmU0z7iAWt3vAzdubA9p3zLPBqNIMcYjYyInaw==
X-Received: by 2002:a17:907:271b:b0:730:aa8e:74eb with SMTP id w27-20020a170907271b00b00730aa8e74ebmr21707204ejk.478.1661975174339;
        Wed, 31 Aug 2022 12:46:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7db96000000b0044687e93f74sm75634edt.43.2022.08.31.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:46:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTTfA-000Rzs-3B;
        Wed, 31 Aug 2022 21:46:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 1/4] fsmonitor: add two new config options,
 allowRemote and socketDir
Date:   Wed, 31 Aug 2022 21:41:28 +0200
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
Message-ID: <220831.86h71s8ad7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
> [...]
>  	enum fsmonitor_reason reason;
> +	int allow_remote;
>  	char *hook_path;
> +	char *sock_dir;
>  };

Any reason we couldn't just add this to "struct repo_settings" and ...

> +int fsm_settings__get_allow_remote(struct repository *r)
> +{
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		lookup_fsmonitor_settings(r);
> +
> +	return r->settings.fsmonitor->allow_remote;
> +}
> +
> +const char *fsm_settings__get_socket_dir(struct repository *r)
> +{
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		lookup_fsmonitor_settings(r);
> +
> +	return r->settings.fsmonitor->sock_dir;
> +}
> +

...instead of this whole ceremony...

> +void fsm_settings__set_allow_remote(struct repository *r)
> +{
> +	int allow;
> +
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor = alloc_settings();
> +	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
> +		r->settings.fsmonitor->allow_remote = allow;
> +
> +	return;
> +}

Just have a single repo_cfg_bool() line in prepare_repo_settings()
instead?

(There are some reasons for the "lazy" behavior of fsmonitor-settings.c,
but surely a simple boolean variable we can read on startup isn't it,
and we already paid the cost to do so with the configset...)


> +void fsm_settings__set_socket_dir(struct repository *r)
> +{
> +	const char *path;
> +
> +	if (!r)
> +		r = the_repository;
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor = alloc_settings();
> +
> +	if (!repo_config_get_pathname(r, "fsmonitor.socketdir", &path)) {
> +		FREE_AND_NULL(r->settings.fsmonitor->sock_dir);

...maybe this socket dir stuff is the exception though.

> +		r->settings.fsmonitor->sock_dir = strdup(path);

Aren't you strdup()-ing an already strdup()'d string, and therefore
leaking memory? Also this should be xstrdup(), surely?

> +	}
> +
> +	return;
> +}
> +
>  void fsm_settings__set_ipc(struct repository *r)
>  {
> -	enum fsmonitor_reason reason = check_for_incompatible(r);
> +	enum fsmonitor_reason reason;
> +
> +	fsm_settings__set_allow_remote(r);
> +	fsm_settings__set_socket_dir(r);
> +	reason = check_for_incompatible(r);

This seems rather backwards, as odd as this API itself is already, isn't
the whole idea that after we call lookup_fsmonitor_settings() it will
have set() anything that's mandatory?

But maybe I haven't grokked it ... :)
