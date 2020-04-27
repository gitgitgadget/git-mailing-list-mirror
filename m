Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF41C54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E6B2080C
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/jgvbLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD0Qqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgD0Qqp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 12:46:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2249C03C1A7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:46:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so21335083wrw.12
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PVPvcdobFGasfBiuOZmAthWFVKL2BPkav4zuc9gpFYw=;
        b=W/jgvbLEHvZmhy64Tp6o4qlV3lTZij8pS7oFgwQpGFUj/gQS7uPr9us67yud8nlKzR
         H7kdHfGBHp2u+EVqWFkjGZc/JacI3FPfjTwWwVEufct52xt/b4HSv5atplbzyrGxwKFT
         Oj7V96OhSpDGXpJW/6TwlF+jEDiI1sbg12sV37gT8bLMMGvMv9yi5xvJJs/MlwUIt6Qz
         K3EYpvJ46bkEQbWjTa+E1drRKfcD5VuOkW6rdBSQVryksRIA/0LGlO2IgpHyqNJGK+mJ
         oN8GO7HBR3OePg6EuSfYE+QLEaOblcTwHeg+9dX6E4N+opDyhaQoiVxWWoIc41mm8PZt
         6xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PVPvcdobFGasfBiuOZmAthWFVKL2BPkav4zuc9gpFYw=;
        b=qFbWo1pBlKSwYNTim+09LHQikGbkg0wmxqfWG5z2JSlQ+jUMpviuXGbqKIbjsfHjvt
         UiM0v0OP5qbfUmc6s+FMTy0967xR4ztiCNVHiwxZSJX0EPud7jn0JAROl/bJ9KX4Gkh4
         LvgX6m9P+hVhSUWr3aI1WjHtKOf30qlWduI1UUtbzINSlhXya88oiAW8ATkObCA7pkoB
         peFxVyQZV/AQaLaxs/L0cAaaOFOOQh9YT65+7T9RTbiiVW+rlGHfugfS4q/nK08fzdyF
         nnya1FdvsAn8EH9GqhKzeBKd1sTfNDcJKp4B/NsG4ErK8r39jqye3WYGP8RiPDdp055z
         2fEA==
X-Gm-Message-State: AGi0PuaiucuTUPZN4WI9vEjoKglu3kqpKSZLJ6x7aPJbP8W4AvTqVJmV
        1S47HxNnhlxFcZmshMq/vIc=
X-Google-Smtp-Source: APiQypK0CzQBmR6TL1yPDqzo/uEou2KqP2VK394KGRAaIID+/MIxm0JTdiF8KxclouMWmZX/Tk5xDw==
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr29892423wrw.277.1588006003566;
        Mon, 27 Apr 2020 09:46:43 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-318-118.w86-199.abo.wanadoo.fr. [86.199.205.118])
        by smtp.gmail.com with ESMTPSA id a1sm21981577wrn.80.2020.04.27.09.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 09:46:42 -0700 (PDT)
Subject: Re: [PATCH] rebase: display an error if --root and --fork-point are
 both provided
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.771.git.git.1588004500766.gitgitgadget@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7f8b3ab5-9632-637d-27db-7e35330ff31d@gmail.com>
Date:   Mon, 27 Apr 2020 18:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <pull.771.git.git.1588004500766.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 27/04/2020 à 18:21, Elijah Newren via GitGitGadget a écrit :
> From: Elijah Newren <newren@gmail.com>
> 
> --root implies we want to rebase all commits since the beginning of
> history.  --fork-point means we want to use the reflog of the specified
> upstream to find the best common ancestor between <upstream> and
> <branch> and only rebase commits since that common ancestor.  These
> options are clearly contradictory, so throw an error (instead of
> segfaulting on a NULL pointer) if both are specified.
> 
> Reported-by: Alexander Berg <alexander.berg@atos.net>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     rebase: display an error if --root and --fork-point are both provided
>     
>     --root implies we want to rebase all commits since the beginning of
>     history. --fork-point means we want to use the reflog of the specified
>     upstream to find the best common ancestor between and and only rebase
>     commits since that common ancestor. These options are clearly
>     contradictory, so throw an error (instead of segfaulting on a NULL
>     pointer) if both are specified.
>     
>     Reported-by: Alexander Berg alexander.berg@atos.net
>     [alexander.berg@atos.net]Signed-off-by: Elijah Newren newren@gmail.com
>     [newren@gmail.com]
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-771%2Fnewren%2Frebase-fork-point-root-error-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-771/newren/rebase-fork-point-root-error-v1
> Pull-Request: https://github.com/git/git/pull/771
> 
>  builtin/rebase.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index bff53d5d167..287ac1aa21b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1652,6 +1652,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			die(_("cannot combine '--keep-base' with '--root'"));
>  	}
>  
> +	if (options.root && fork_point > 0)
> +		die(_("cannot combine '--root' with '--fork-point'"));
> +
>  	if (action != ACTION_NONE && !in_progress)
>  		die(_("No rebase in progress?"));
>  	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
> 
> base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
> 

The patch is fairly obvious and looks good to me.

The documentation must be updated, too, since it does not mention the
incompatibility between the two switches:

-- snip --
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index bed500f151..a30de5aa20 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -448,12 +448,14 @@ When --fork-point is active, 'fork_point' will be
used instead of
 <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
 ends up being empty, the <upstream> will be used as a fallback.
 +
-If either <upstream> or --root is given on the command line, then the
-default is `--no-fork-point`, otherwise the default is `--fork-point`.
+If <upstream> is given on the command line, then the default is
+`--no-fork-point`, otherwise the default is `--fork-point`.
 +
 If your branch was based on <upstream> but <upstream> was rewound and
 your branch contains commits which were dropped, this option can be used
 with `--keep-base` in order to drop those commits from your branch.
++
+See also INCOMPATIBLE OPTIONS below.

 --ignore-whitespace::
 --whitespace=<option>::
@@ -635,6 +637,7 @@ In addition, the following pairs of options are
incompatible:
  * --preserve-merges and --empty=
  * --keep-base and --onto
  * --keep-base and --root
+ * --fork-point and --root

 BEHAVIORAL DIFFERENCES
 -----------------------
-- snap --

Cheers,
Alban

