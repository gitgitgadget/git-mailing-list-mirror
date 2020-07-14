Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA64CC433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 00:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9439A21883
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 00:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaB4J++o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGNAYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGNAYz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 20:24:55 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B5C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 17:24:55 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so11533960qtr.9
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QJZoy/kT51fCLjxGP2/FmxNu0hslEDbUaZzjW5+1cZ8=;
        b=uaB4J++oFbQK/uogVAdrq4U3mbprsKdoI4ZSCKrxLnHPEYdckJCMdUKhuSjGLicyvP
         KnoQjUF2dtMbjPVZqCnRfxmir2A+3CqSzXd9LQbegWM4hvEmPjpj12NVE2ggACZF3wsY
         0ay7jGt9IVy1cZM0PMeg92sRTXt45xZjU/LZSvBP+AO/ghbSSagzQDqYlrlR/dDF6muB
         MtxhwBRxe1U+bp+yZNeYNkaCBJcMZK4Jg6NvFCqqMenJcEkXpgPmH0UuVwFzB7Rs+7Wo
         GRlYuq+l1b+rHHSZr3t7FtXPlPqTMZ/9EtBvTejMVDIRpmuObXOm3CXg8BGk5/CK3qoQ
         R7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJZoy/kT51fCLjxGP2/FmxNu0hslEDbUaZzjW5+1cZ8=;
        b=W7sXzae2FUuvzOhRr6+0s3tO5c64dd0sLkhhdXVdY8DoI/72Z9pBmMlNmcUjEIFNfV
         xrchgxK0SM/Emj8NxIb7t8pcX7fDoaGF7YWJND/Ra5lw6exkXOifLxM9jGGyyMldljNr
         io628or7ltPiuIyr4KrIcEBvVuaUrLpB/irIyxQweGhle6VaDHoDyg59zkawi5WZ1lOR
         wCbf6I5sHNtQbFU8NCSQ1HUWooqLfigNVM/1vU1VTR8wvVGhm4pjJlXnTnTTcIDDETJH
         t9biLI556KvuVscJyNTKigCa/DynIf0huPgemR3lKYne91iG5mfP+4c/7fkWVwexR2M5
         qq2A==
X-Gm-Message-State: AOAM5309kimaouVO+Ol802pRJBFAruJwv9uxGQsjajfiLzcLzdMilBbA
        QzijUCugTnDl8htfPYg3buY=
X-Google-Smtp-Source: ABdhPJztGU9DjmRYK19HXI2AAmWpTMLZepdNOdxj6DrGLptd1E+ErIiUZlmVefpaD+1Yy7xQdjYB/A==
X-Received: by 2002:ac8:66d1:: with SMTP id m17mr2123856qtp.88.1594686294268;
        Mon, 13 Jul 2020 17:24:54 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a3sm20514717qkf.131.2020.07.13.17.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 17:24:53 -0700 (PDT)
Subject: Re: [PATCH] setup: warn about un-enabled extensions
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
Date:   Mon, 13 Jul 2020 20:24:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2020 5:55 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When any `extensions.*` setting is configured, we newly ignore it unless
> `core.repositoryFormatVersion` is set to a positive value.
> 
> This might be quite surprising, e.g. when calling `git config --worktree
> [...]` elicits a warning that it requires
> `extensions.worktreeConfig = true` when that setting _is_ configured
> (but ignored because `core.repositoryFormatVersion` is unset).
> 
> Let's warn about this situation specifically, especially because there
> might be already setups out there that configured a sparse worktree
> using Git v2.27.0 (which does set `extensions.worktreeConfig` but not
> `core.repositoryFormatVersion`) and users might want to work in those
> setups with Git v2.28.0, too.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Warn when extensions.* is ignored
>     
>     I did actually run into this today. One of my pipelines is configured to
>     clone a bare repository, then set up a sparse secondary worktree. This
>     used to work, but all of a sudden, the git config --worktree
>     core.sparseCheckout true call failed because I'm now using v2.28.0-rc0.

I tried your situation with Junio's patch from earlier [1] [2].

[1] https://lore.kernel.org/git/pull.674.git.1594668051847.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/xmqqpn8zmao1.fsf_-_@gitster.c.googlers.com/	

The issue here is that Junio's silent fix for sparse-checkout doesn't
work here for "git config --worktree". However, I think that Johannes
is making the same over-compensating warning message pattern as I was.
That is, this warning happens for all extensions that are enabled when
core.repositoryFormatVersion is less than 1.

To attempt to summarize Junio's opinion, we should keep our situation
isolated to this worktree config extension. Your patch does agree with
the others in that we don't revert the behavior of failing to set the
config, but I think in this instance we can specify the warning more
carefully.

If you don't mind, I was already going to squash Junio's commit into
mine (almost completely replacing mine) but I could add a small
commit on top that provides the following improvement to the error
message:

diff --git a/builtin/config.c b/builtin/config.c
index 5e39f618854..b5de7982a93 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -678,8 +678,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
                else if (worktrees[0] && worktrees[1])
                        die(_("--worktree cannot be used with multiple "
                              "working trees unless the config\n"
-                             "extension worktreeConfig is enabled. "
-                             "Please read \"CONFIGURATION FILE\"\n"
+                             "extension worktreeConfig is enabled "
+                             "and core.repositoryFormatVersion is at least\n"
+                             "1. Please read \"CONFIGURATION FILE\""
                              "section in \"git help worktree\" for details"));
                else
                        given_config_source.file = git_pathdup("config");

Thanks,
-Stolee
