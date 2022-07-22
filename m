Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418D3C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 11:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiGVLEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiGVLEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 07:04:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42858BB8E1
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:04:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m8so5397158edd.9
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=g3271ZZz/v6Wmgsi/i0DjFp74rTLbefTZiebTesr448=;
        b=cG/MIIHET1H0VFFvugCDU8HV23n+2GupMUfOkrbzRDNBOC0Fmym6UMtYE0UVNv71RW
         IPj3q3Xn4IBNBDceFisU1Hls9+OhGGZ9tHMStFANwGQdyADyOqSGEECR21AIdP9DbM47
         x69xIYbhhX6CzgMWOgBkHJ9PmWHBNGLQOFy1iZhsnIZqJUT38SQXy5bwZBUUTLVwl3GP
         mVvyUUJaSQHplbkq95jBQFJ4rzxG15vuOCKZHnDuPtN0D5zSH7JOIwpTiEWfe9QfzVzJ
         43iUScs1DHG9LxL4Arfpb6zbcdYH1CW9cC7Z7LTlYJz6JiiF5BbsvtX/lNfEaDyHp2Ra
         eEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=g3271ZZz/v6Wmgsi/i0DjFp74rTLbefTZiebTesr448=;
        b=6QuwN84tgZqvXr7cdqPlXwY07HlO9aJ/FhqaM4GWaYvuFqzDQUy2iccD/SGlNNRTGR
         e3wSEr881X0tgKQb2V9mS/JeHi0XNPuu+bw/pQQq6a1Op0Wah6BAXh9J8bFafSZozXuw
         QhbbRPNLx8fvGlCZzl68Q897jGMUqOpdssTmXw59byDGcU6Dv/A6xqDz7sMLdy9bZIZP
         39276dJU33KP3DD6VZ3u/ecwy96ir3I1rvQqJtJXB/ptB3JocVJNlmdDjhgY3MMkmgAT
         NesuqSjR5N1XmjCkNsfEdYfr1rjeAgFS2MvGLHmb66zAUzbHj3MUZdHUrPxW5QgNrjlU
         OZ7Q==
X-Gm-Message-State: AJIora8HIwi2TSrZrAtqQJ08Fpn7/En5HoQ6WyzeslNZT3C7NdlEkoRr
        9mjlKl/SRO8qrLOAmP8WGNc=
X-Google-Smtp-Source: AGRyM1svUTxPyoJZIKOCGUZ4dBXQ2GX98m5+wZEfyVj+YSlzBYGjytp/x29id66JHdbZWQg0tzwOBA==
X-Received: by 2002:a05:6402:3046:b0:43b:c9c1:864e with SMTP id bs6-20020a056402304600b0043bc9c1864emr50849edb.32.1658487863348;
        Fri, 22 Jul 2022 04:04:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bf26-20020a0564021a5a00b0043a8286a18csm2373707edb.30.2022.07.22.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:04:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEqSD-005Huo-VF;
        Fri, 22 Jul 2022 13:04:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "tenglong.tl" <dyroneteng@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
Date:   Fri, 22 Jul 2022 12:59:12 +0200
References: <cover.1658472474.git.dyroneteng@gmail.com>
 <32f8b9ae6bb6aff0ce55ee494c4c0d40c672752b.1658472474.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <32f8b9ae6bb6aff0ce55ee494c4c0d40c672752b.1658472474.git.dyroneteng@gmail.com>
Message-ID: <220722.86fsits91m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, tenglong.tl wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> It's supported to print "interesting" config key-value paire
> to tr2 log by setting "GIT_TRACE2_CONFIG_PARAMS" environment
> variable and the "trace2.configparam" config, let's add the
> related docs in Documentaion/technical/api-trace2.txt.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/technical/api-trace2.txt | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 77a150b30e..ddc0bfb9c9 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -717,6 +717,7 @@ The "exec_id" field is a command-unique id and is only useful if the
>  {
>  	"event":"def_param",
>  	...
> +	"scope":"global",
>  	"param":"core.abbrev",
>  	"value":"7"
>  }
> @@ -1207,6 +1208,37 @@ at offset 508.
>  This example also shows that thread names are assigned in a racy manner
>  as each thread starts and allocates TLS storage.
>  
> +Print Configs::
> +
> +	  Dump "interesting" config values to trace2 log.
> ++
> +The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
> +`trace2.configparams` can be used to output config values which you care
> +about(see linkgit:git-config[1). For example:

I didn't notice this before, but this is an addition to a long section
where the examples are ------- delimited, starting with "in this
example.." usually.

So this "print configs" seems like on odd continuation. Shouldn't this
copy the template of "Thread Events::" above. I.e. something like (I
have not tried to asciidoc render this):
	
	Config (def param) Events::
		We can optionally emit configuration events, see
		`trace2.configParams` in linkgit:git-config[1] for how to enable
		it.
	+
	< your example below would follow this>

I.e. re my earlier mention of git-config we it explains
GIT_TRACE2_CONFIG_PARAMS, so perhaps it suffices to just link to
linkgit:git-config[1] for that.

Also a nit: trace2.configParams, not trace2.configparams.
	
> ++
> +----------------
> +$ git config color.ui auto
> +----------------
> ++
> +Then, mark the config `color.ui` as "interesting" config with
> +`GIT_TRACE2_CONFIG_PARAMS`:
> ++
> +----------------
> +$ export GIT_TRACE2_PERF_BRIEF=1
> +$ export GIT_TRACE2_PERF=~/log.perf
> +$ export GIT_TRACE2_CONFIG_PARAMS=color.ui
> +$ git version
> +...
> +$ cat ~/log.perf
> +d0 | main                     | version      |     |           |           |              | ...
> +d0 | main                     | start        |     |  0.001642 |           |              | /usr/local/bin/git version
> +d0 | main                     | cmd_name     |     |           |           |              | version (version)
> +d0 | main                     | def_param    |     |           |           |              | color.ui:auto
> +d0 | main                     | data         | r0  |  0.002100 |  0.002100 | fsync        | fsync/writeout-only:0
> +d0 | main                     | data         | r0  |  0.002126 |  0.002126 | fsync        | fsync/hardware-flush:0
> +d0 | main                     | exit         |     |  0.002142 |           |              | code:0
> +d0 | main                     | atexit       |     |  0.002161 |           |              | code:0
> +----------------
>  == Future Work
>  
>  === Relationship to the Existing Trace Api (api-trace.txt)

