Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6863AC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 10:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbjAMKiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 05:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbjAMKiC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 05:38:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8BD77AE6
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:36:36 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so18453114wms.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia00f/BDEUA5a3NTHRFZLbuGXaluWAYYEyrYdqifWgo=;
        b=IfuVMNcjfXJ4YVX0K6ifziHlZPY9x9CO7269eC9HhDu4isjcL9nKXwJiaLt7e6beCM
         I4ZXr+oUFBcugmwJNE3sHRm2p38uu4JaIUC3A4fCBPE74058Rg5OwhTvPK+xGgm6T1f5
         ucwAv1iagUr52mdq8G2wkb88I+LDWhg0lqEiWw1ZgsCCOi2Xm8Yyapym1EpZznkQyrq+
         nS+Y3tb8PeWbIVnuD+/vbSVC/Eafdk+gGIrejfBCVy/GKOUYsM2XucYMBKpQK9JfNzat
         BY+DgoLgZuQONdlTdZe3diZ6qSeUWVuXf8X4K71OspWOqcv2z9qWxqFYeNksuU8gM9m4
         s09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia00f/BDEUA5a3NTHRFZLbuGXaluWAYYEyrYdqifWgo=;
        b=Yb7vLv3JGHUGm6Ljb7qulWczgVinCfpbZIFlfVor+3xBbp5K4pN730iRUVhhUoIdP0
         FyMkefz8yrGNH+LtoSdZRdc9QQ7KEunmx2rrO0KRUTFEWaOdolpin1nOQyjb5ZrUN4tG
         T889ucDfMVB9EQ8dHWeOBIheZ9RCYajsGKCPbRKJnNqm8jkjUDOSNcTC5kubRYjf2G2r
         iYE0j+3cbUyfVkd3FuXSwChmJMy3GbUEwOC+oOIbyUIVMZg6XShUfFwd7RduvlKopz8/
         0j2VKrh5B0OQFPE5cVLecfh84ky8xKR8eshUzjyuhXx7QEs86c5Nxyk/Db0seMmfWbIv
         ql7Q==
X-Gm-Message-State: AFqh2kolT2XM2WQGobJSmCbenxwUUOxDZ6qgmB1ENbsiCVcgTucQeldc
        DA389o+6CnauuF5WiYtDveU=
X-Google-Smtp-Source: AMrXdXtfYfNof18en52/6NBhn+4OGGmhZe0qk4HNeERta8eQ7noNCEgvnre4TM2KdJvAu8wcA4pi0w==
X-Received: by 2002:a05:600c:600a:b0:3d1:ed41:57c0 with SMTP id az10-20020a05600c600a00b003d1ed4157c0mr61851594wmb.30.1673606194589;
        Fri, 13 Jan 2023 02:36:34 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003d9fb04f658sm10460055wmc.4.2023.01.13.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:36:34 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <cef87708-657c-5611-82bd-9d3fa3a4b241@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 10:36:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/9] builtin/revert.c: move free-ing of "revs" to
 replay_opts_release()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
 <patch-v2-4.9-e83bdfab046-20230112T124201Z-avarab@gmail.com>
In-Reply-To: <patch-v2-4.9-e83bdfab046-20230112T124201Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 12/01/2023 12:45, Ævar Arnfjörð Bjarmason wrote:
> In [1] and [2] I added the code being moved here to cmd_revert() and
> cmd_cherry_pick(),

I'm not sure how relevant this first clause is but the change itself 
looks good.

> now that we've got a "replay_opts_release()" for
> the "struct replay_opts" it should know how to free these "revs",
> rather than having these users reach into the struct to free its
> individual members.
> 
> As explained in earlier change we should be using FREE_AND_NULL() in
> replay_opts_release() rather than free().

This paragraph is out of date

Best Wishes

Phillip

> 1. d1ec656d68f (cherry-pick: free "struct replay_opts" members,
>     2022-11-08)
> 2. fd74ac95ac3 (revert: free "struct replay_opts" members, 2022-07-01)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/revert.c | 6 ------
>   sequencer.c      | 3 +++
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 1cab16bf3ed..77d2035616e 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -248,9 +248,6 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>   	res = run_sequencer(argc, argv, &opts);
>   	if (res < 0)
>   		die(_("revert failed"));
> -	if (opts.revs)
> -		release_revisions(opts.revs);
> -	free(opts.revs);
>   	replay_opts_release(&opts);
>   	return res;
>   }
> @@ -263,9 +260,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>   	opts.action = REPLAY_PICK;
>   	sequencer_init_config(&opts);
>   	res = run_sequencer(argc, argv, &opts);
> -	if (opts.revs)
> -		release_revisions(opts.revs);
> -	free(opts.revs);
>   	if (res < 0)
>   		die(_("cherry-pick failed"));
>   	replay_opts_release(&opts);
> diff --git a/sequencer.c b/sequencer.c
> index 5d8c68912a1..c729ce77260 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -362,6 +362,9 @@ void replay_opts_release(struct replay_opts *opts)
>   	opts->xopts_nr = 0;
>   	free(opts->xopts);
>   	strbuf_release(&opts->current_fixups);
> +	if (opts->revs)
> +		release_revisions(opts->revs);
> +	free(opts->revs);
>   }
>   
>   int sequencer_remove_state(struct replay_opts *opts)
