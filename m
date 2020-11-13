Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975CC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B582137B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPahHuyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKMOIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMOIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:08:25 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F0C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:08:24 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so10064948wrx.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KuVcmmCFXjt0b0Nc556AAo0s5XF/sHUEmxntt7WTm3o=;
        b=cPahHuyZ+ErlyS/EabjhlClxySc9QeFSr2FdXcaoPSjLrlK637oUZ9s7KLe3wPm3WX
         8ChTy1joE1aoGIgC8A05wg54/zR0caLT8vCdenhCBBA7xKzbJjzJBSm1OHG/FIk2isHC
         wSA0thvRG5vlfQOK3AeK1DLcF+cSk7XZ5kd3O2reIEfj9W4ovOGzru96CdM307SSITk4
         PyhQCOGZaa4DqsvLAHE0VfBQ26DiKEn2Jkem/Cwrv0S8jYuHziaytJgBXaWUHMU9OFcp
         tSHco7FyZIyVe2nK3aNmy7GR0S9uwo6yCFKcH24BM91U6PHIzTUM9KkX4lYVckCaFeVA
         j4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KuVcmmCFXjt0b0Nc556AAo0s5XF/sHUEmxntt7WTm3o=;
        b=mmyUbXU9h7MYu4Obz/l5TBC2pQyzGkjo1aiZpRmDDyrs+X08fzcNU8p3VYaUCpu8Es
         p4bLdrWkdQIguJRgzjerwRMyvaF6A+NUvEvpxy618MZ8IfqDb2PlfCoVkg/wmKRzOOGJ
         RE5atBSW7GzqVTuLJzJ9036YP5lyX5CiS25IwEATrx7e01B+Pm3lSDR7uMmRtCErTsaW
         njlcXRRtSC07FV34r4bpRhhek+yfknbn0OmAsXRk38UkNzqdR+uI19lGjc3j7uYhg3iH
         N0QsdgsBGIR91fhjniYo3yhRumILSfm4JhuKQdkVnv+P+mwYITgAuEk3Kvfuivy17ypo
         It+g==
X-Gm-Message-State: AOAM531k3OMk5rlJb/p4bxmWGAgvOq4VDzipaiUJANoOAmItZL+EACaM
        yuv6jjkzN4DSVO8dWYl1fVc=
X-Google-Smtp-Source: ABdhPJyqwT6+psrtUx87K44m6xDLVQyuE7d8VlNMnbw+jD8nQm24U8SnLxO4AYK2aSXqrhiGV3O83g==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr3728585wru.112.1605276503557;
        Fri, 13 Nov 2020 06:08:23 -0800 (PST)
Received: from [192.168.1.201] (194.55.7.51.dyn.plus.net. [51.7.55.194])
        by smtp.googlemail.com with ESMTPSA id w11sm10693540wmg.36.2020.11.13.06.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 06:08:22 -0800 (PST)
Subject: Re: [PATCH v2 10/11] add -p: prefer color.diff.context over
 color.diff.plain
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <48d8e0badfec5f0e576868f7a406ed7ede6c7200.1605097704.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4ad92124-de1f-df66-093b-5089ad111cb7@gmail.com>
Date:   Fri, 13 Nov 2020 14:08:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <48d8e0badfec5f0e576868f7a406ed7ede6c7200.1605097704.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Git's diff machinery allows users to override the colors to use in
> diffs, even the plain-colored context lines. As of 8dbf3eb6850 (diff.h:
> rename DIFF_PLAIN color slot to DIFF_CONTEXT, 2015-05-27), the preferred
> name of the config setting is `color.diff.context`, although Git still
> allows `color.diff.plain`.
> 
> In the context of `git add -p`, this logic is a bit hard to replicate:
> `git_diff_basic_config()` reads all config values sequentially and if it
> sees _any_ `color.diff.context` or `color.diff.plain`, it accepts the
> new color. The Perl version of `git add -p` needs to go through `git
> config --get-color`, though, which allows only one key to be specified.
> The same goes for the built-in version of `git add -p`, which has to go
> through `repo_config_get_value()`.

One nit pick: the built-in version does not have to go through 
`repo_config_get_value()`, it could get the values in a callback using 
`git_config()` which would match the behavior of diff but chooses not to 
(presumably it is more convenient to just look up the config values). 
Having said that I think this patch is fine and the commit message does 
a good job of explaining the situation.

Thanks for working on this series, it's great to see a test at the end

Best Wishes

Phillip


> The best we can do here is to look for `.context` and if none is found,
> fall back to looking for `.plain`, and if still not found, fall back to
> the hard-coded default (which in this case is simply the empty string,
> as context lines are typically rendered without colored).
> 
> This still needs to inconsistencies when both config names are used: the
> initial diff will be colored by the diff machinery. Once edited by a
> user, a hunk has to be re-colored by `git add -p`, though, which would
> then use the other setting to color the context lines.
> 
> In practice, this is not _all_ that bad. The `git config` manual says
> this in the `color.diff.<slot>`:
> 
> 	`context` (context text - `plain` is a historical synonym)
> 
> We should therefore assume that users use either one or the other, but
> not both names. Besides, it is relatively uncommon to look at a hunk
> after editing it because it is immediately staged by default.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   add-interactive.c         | 6 ++++--
>   git-add--interactive.perl | 6 +++---
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index c298a8b80f..54dfdc56f5 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -49,8 +49,10 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>   
>   	init_color(r, s, "diff.frag", s->fraginfo_color,
>   		   diff_get_color(s->use_color, DIFF_FRAGINFO));
> -	init_color(r, s, "diff.context", s->context_color,
> -		diff_get_color(s->use_color, DIFF_CONTEXT));
> +	init_color(r, s, "diff.context", s->context_color, "fall back");
> +	if (!strcmp(s->context_color, "fall back"))
> +		init_color(r, s, "diff.plain", s->context_color,
> +			   diff_get_color(s->use_color, DIFF_CONTEXT));
>   	init_color(r, s, "diff.old", s->file_old_color,
>   		diff_get_color(s->use_color, DIFF_FILE_OLD));
>   	init_color(r, s, "diff.new", s->file_new_color,
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index adbac2bc6d..bc3a1e8eff 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -30,9 +30,9 @@
>   	$diff_use_color ? (
>   		$repo->get_color('color.diff.frag', 'cyan'),
>   	) : ();
> -my ($diff_plain_color) =
> +my ($diff_context_color) =
>   	$diff_use_color ? (
> -		$repo->get_color('color.diff.plain', ''),
> +		$repo->get_color($repo->config('color.diff.context') ? 'color.diff.context' : 'color.diff.plain', ''),
>   	) : ();
>   my ($diff_old_color) =
>   	$diff_use_color ? (
> @@ -1046,7 +1046,7 @@ sub color_diff {
>   		colored((/^@/  ? $fraginfo_color :
>   			 /^\+/ ? $diff_new_color :
>   			 /^-/  ? $diff_old_color :
> -			 $diff_plain_color),
> +			 $diff_context_color),
>   			$_);
>   	} @_;
>   }
> 

