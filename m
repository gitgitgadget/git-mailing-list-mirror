Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38990C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiEZJvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbiEZJvn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:51:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BBCC8BEE
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:51:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id q15so1139235edb.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fKnKKZ6YaJ3ncDB4GT2TOdERTWHIos5oj8Ou4Tuvu88=;
        b=X1SnMANVp/iphOCfWwV9DsdWO5HPhA2nLAUxBZL9aKheS8DkFf/P6VyDz2dEcKZPO3
         Ju234OzBlHD/8jOmhrs1/174dYF1dUb0cblK7MKQaShyOKMLwDdwAar+By6dqPMCR5eI
         3fKsfsP4Pr8my6ZKf1Iv+FW6ABdNNEJazDBKM2lx9DlsOq5qwhPeQQXC0imuL55Xd81P
         qaMUQYhXeGcGJJ+8UG0IsZa2FhaoBjxQjFMTLeZInk5Y/zN2Esx1qoIk0kbi0mcoOpgC
         EhLZL36CJC9r5ehkS5EcG+ZzoKRwEEVFH/CvTu78n0tQlueY5a9qJi9R78cRP7VrWUHr
         +inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fKnKKZ6YaJ3ncDB4GT2TOdERTWHIos5oj8Ou4Tuvu88=;
        b=Mb5bwQf5mT9iyAWoLUs/y0fG2uCUWSaDTTvaqaaCs6/bkhs18JtT2U+fD6MBAUDcU6
         Q/X+N2GSPa8YQlLvJHQauZLfY1/4zKCeU1dYQQWPwQCVXWbEnZwLwwRMGRlz0ihSBx63
         kyHUQZBCSgMqMiCYN7Uq0rxDy5mhUAxUw+cFpu/zPSNWIuS1irw7m2fzZfcgCzOxj12s
         sgPVw5dfUlz1ByRuWUa1rjGZ/uGy2/jgb5lhuq+qkQR3t6iQOzXwA0g73a0aqQqFkk6p
         RnVu05rnscBhglxK/VgdF4KWnzLfHOOUjwzGjI0jA9UsQI8U9UZlC1cGAhNEe+Wk1lds
         G0EA==
X-Gm-Message-State: AOAM533cAdsO53QKqQ8ILNLHxHEmUANElAooHGW1fHsh+OR0A421azL5
        f7GTDhP8XkFPJ1J+IG852lPbGQEwIFCECw==
X-Google-Smtp-Source: ABdhPJy71hGQN+1av+85fMwwjVwLsukUnODbpKsrrYadUPsQWwmSd2HrWWIeuIuqTueTf4BfRZMGiA==
X-Received: by 2002:a05:6402:b0d:b0:42b:ddcc:6a7e with SMTP id bm13-20020a0564020b0d00b0042bddcc6a7emr1470522edb.258.1653558700931;
        Thu, 26 May 2022 02:51:40 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j4-20020a508a84000000b0042aa153e73esm589468edj.12.2022.05.26.02.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:51:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuA9b-000BCT-UR;
        Thu, 26 May 2022 11:51:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 3/3] rebase: note `preserve` merges may be a pull config
 option
Date:   Thu, 26 May 2022 11:50:40 +0200
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <ece3eecdc4de44cdec1b6efa9079930721db85ad.1653556865.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <ece3eecdc4de44cdec1b6efa9079930721db85ad.1653556865.git.gitgitgadget@gmail.com>
Message-ID: <220526.8635gw7has.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:

> From: Philip Oakley <philipoakley@iee.email>
>
> The `--preserve-merges` option was removed by v2.35.0. However
> users may not be aware that it is also a Pull option, and it is
> still offered by major IDE vendors such as Visual Studio.
>
> Extend the `--preserve-merges` die message to also direct users to
> the use of the `preserve` option in the `pull` config.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  builtin/rebase.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index aada25a8870..6fc0aaebbb8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1205,7 +1205,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			     builtin_rebase_usage, 0);
>  
>  	if (preserve_merges_selected)
> -		die(_("--preserve-merges was replaced by --rebase-merges"));
> +		die(_("--preserve-merges was replaced by --rebase-merges\n"
> +			"Your `pull` configuration, may also invoke this option."));
>  
>  	if (action != ACTION_NONE && total_argc != 2) {
>  		usage_with_options(builtin_rebase_usage,

Ditto 2/3 about maybe die_message() + advise(). In this case that has
the slight advantace of allowing us to keep the existing translated
string as-is.

But also, is *our* pull configuration causing us to end up here? I
vaguely recall that being discussed (probably in answer to a question of
mine) in the earlier round, or is this the IDE picking it up & invoking
us like this?

