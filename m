Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1126CDB470
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 18:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjJKSFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjJKSFg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 14:05:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003CFCA
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:05:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406618d0991so1788595e9.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697047532; x=1697652332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i2f2pbO/vy+qoEJLYqsS4HMA/6gm/3u2XvVoS4OI7ms=;
        b=BTZONXKrYikA6yA9aZJX1mqm/rHWp4D1XXYlXpYtk/C8xDoigm8OzeAg7eeHHEDmxk
         4BZ+ywaPfaJYAc/qhvmtwApTj6Bg+AxgB58/MrtcHndcwR8dBIdWIvDsDXJ7IuKcVxWl
         3PQoFMb4C1FCEIEMc7YLpRbiApOgWu0XcunQ95j+++1t++u0of3nUqCr4dLINg0zXSRd
         S2ofSzK7OHulDwLeE1tOoRPKpKbemWiJTXja1i0xEj4+oIVHrLlESVpIMoBExgzbcyyJ
         Zip56MzwGxII+LMXJk5oUneuu1J0b/LbzatWKzm2JzefCyoB82VJgvQzBTW0mhfC+Iwm
         cCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047532; x=1697652332;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2f2pbO/vy+qoEJLYqsS4HMA/6gm/3u2XvVoS4OI7ms=;
        b=dP/8AfnPNHDIj6mUr8pdY9cnGQ21TxYqWrxmDDCwRK+JxBrVP1895Mtyw+acxR59p5
         c0maEPzKfeXUMaB/+PFc1YLpZxcQbaVYupTs3dE+/woLkb6miG0vSlLbC+xLFce5hjUp
         BgCMqdRdTwFOrfNwfmXvL2IVPY06k5QvpnRshiZ/Wo9H+21Wa5yBklZtP+i4aDGcVfpZ
         fi5fuR8ECtm0swfLiESAHuaLgCwrF1Q0wYhFv7ss7KYGPSTYihxrwOT6Fq9+YClH6Gbz
         /wHAALdB/CREnJ54GXXeYBluuiXhv79WrxxDFQqOUihJZk1P1DUadNAHflcv2BvWNXqH
         M8pQ==
X-Gm-Message-State: AOJu0YxuUo5vr29KT5niDEaCEYmXXlLIDGBJeHaEunZOJ2QrCQS73umf
        JxetG3YqGNuVzipXDJQ0pz8=
X-Google-Smtp-Source: AGHT+IGsWF5NZYCDMJ21tIwyM1gRzqxz0NLP9xoLsQPjWn+tdx5B1UgQdYa3Mx5g4HQliY3Eq3tIIw==
X-Received: by 2002:a05:600c:cc:b0:405:3955:5872 with SMTP id u12-20020a05600c00cc00b0040539555872mr18552639wmm.18.1697047532141;
        Wed, 11 Oct 2023 11:05:32 -0700 (PDT)
Received: from [192.168.2.52] (93.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.93])
        by smtp.gmail.com with ESMTPSA id f17-20020a1c6a11000000b004063ea92492sm17367128wmc.22.2023.10.11.11.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 11:05:18 -0700 (PDT)
Message-ID: <06bc7b39-ed70-460f-b6f1-47a0c94c0538@gmail.com>
Date:   Wed, 11 Oct 2023 20:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] branch.c: ammend error messages for die()
To:     Isoken June Ibizugbe <isokenjune@gmail.com>
References: <20231011152424.6957-1-isokenjune@gmail.com>
 <20231011152424.6957-2-isokenjune@gmail.com>
Content-Language: en-US
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20231011152424.6957-2-isokenjune@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-oct-2023 16:24:20, Isoken June Ibizugbe wrote:

Hi Isoken,

> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> ---
>  builtin/branch.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2ec190b14a..a756543d64 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -518,11 +518,11 @@ static void reject_rebase_or_bisect_branch(struct worktree **worktrees,
>  			continue;
>  
>  		if (is_worktree_being_rebased(wt, target))
> -			die(_("Branch %s is being rebased at %s"),
> +			die(_("branch %s is being rebased at %s"),

OK.

>  			    target, wt->path);
>  
>  		if (is_worktree_being_bisected(wt, target))
> -			die(_("Branch %s is being bisected at %s"),
> +			die(_("branch %s is being bisected at %s"),

OK.

>  			    target, wt->path);
>  	}
>  }
> @@ -578,7 +578,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  		if (ref_exists(oldref.buf))
>  			recovery = 1;
>  		else
> -			die(_("Invalid branch name: '%s'"), oldname);
> +			die(_("invalid branch name: '%s'"), oldname);

OK.

>  	}
>  
>  	for (int i = 0; worktrees[i]; i++) {
> @@ -594,9 +594,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  
>  	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
>  		if (oldref_usage & IS_HEAD)
> -			die(_("No commit on branch '%s' yet."), oldname);
> +			die(_("no commit on branch '%s' yet"), oldname);
>  		else
> -			die(_("No branch named '%s'."), oldname);
> +			die(_("no branch named '%s'"), oldname);

OK. Both.

>  	}
>  
>  	/*
> @@ -624,9 +624,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  
>  	if (!copy && !(oldref_usage & IS_ORPHAN) &&
>  	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
> -		die(_("Branch rename failed"));
> +		die(_("branch rename failed"));
>  	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
> -		die(_("Branch copy failed"));
> +		die(_("branch copy failed"));

Ditto

>  
>  	if (recovery) {
>  		if (copy)
> @@ -640,16 +640,16 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  	if (!copy && (oldref_usage & IS_HEAD) &&
>  	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.buf,
>  					      logmsg.buf))
> -		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
> +		die(_("branch renamed to %s, but HEAD is not updated!"), newname);

IMO we can go further here and also remove that final "!".  But it's OK
the way you have done it.

>  
>  	strbuf_release(&logmsg);
>  
>  	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
>  	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
>  	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
> -		die(_("Branch is renamed, but update of config-file failed"));
> +		die(_("branch is renamed, but update of config-file failed"));
>  	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> -		die(_("Branch is copied, but update of config-file failed"));
> +		die(_("branch is copied, but update of config-file failed"));

OK, both.

>  	strbuf_release(&oldref);
>  	strbuf_release(&newref);
>  	strbuf_release(&oldsection);
> @@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  
>  	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
>  	if (!head)
> -		die(_("Failed to resolve HEAD as a valid ref."));
> +		die(_("failed to resolve HEAD as a valid ref"));

OK.

>  	if (!strcmp(head, "HEAD"))
>  		filter.detached = 1;
>  	else if (!skip_prefix(head, "refs/heads/", &head))
> @@ -866,7 +866,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  
>  		if (!argc) {
>  			if (filter.detached)
> -				die(_("Cannot give description to detached HEAD"));
> +				die(_("cannot give description to detached HEAD"));

OK.

>  			branch_name = head;
>  		} else if (argc == 1) {
>  			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
> @@ -892,7 +892,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		if (!argc)
>  			die(_("branch name required"));
>  		else if ((argc == 1) && filter.detached)
> -			die(copy? _("cannot copy the current branch while not on any.")
> +			die(copy? _("cannot copy the current branch while not on any")
>  				: _("cannot rename the current branch while not on any."));

OK.  But I think you want to modify also the second message, to remove
its full stop as well.

>  		else if (argc == 1)
>  			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
> @@ -916,14 +916,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		if (!branch) {
>  			if (!argc || !strcmp(argv[0], "HEAD"))
>  				die(_("could not set upstream of HEAD to %s when "
> -				      "it does not point to any branch."),
> +				      "it does not point to any branch"),

OK.

>  				    new_upstream);
>  			die(_("no such branch '%s'"), argv[0]);
>  		}
>  
>  		if (!ref_exists(branch->refname)) {
>  			if (!argc || branch_checked_out(branch->refname))
> -				die(_("No commit on branch '%s' yet."), branch->name);
> +				die(_("no commit on branch '%s' yet"), branch->name);

OK.

>  			die(_("branch '%s' does not exist"), branch->name);
>  		}
>  
> @@ -946,12 +946,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		if (!branch) {
>  			if (!argc || !strcmp(argv[0], "HEAD"))
>  				die(_("could not unset upstream of HEAD when "
> -				      "it does not point to any branch."));
> +				      "it does not point to any branch"));
>  			die(_("no such branch '%s'"), argv[0]);
>  		}
>  
>  		if (!branch_has_merge_config(branch))
> -			die(_("Branch '%s' has no upstream information"), branch->name);
> +			die(_("branch '%s' has no upstream information"), branch->name);

OK, both.

>  
>  		strbuf_reset(&buf);
>  		strbuf_addf(&buf, "branch.%s.remote", branch->name);
> @@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		const char *start_name = argc == 2 ? argv[1] : head;
>  
>  		if (filter.kind != FILTER_REFS_BRANCHES)
> -			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
> +			die(_("the -a, and -r, options to 'git branch' do not take a branch name\n"
>  				  "Did you mean to use: -a|-r --list <pattern>?"));

Good; the full stop removed and here that question mark is valuable.  And ...

>  
>  		if (track == BRANCH_TRACK_OVERRIDE)
> -			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
> +			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));

also good.  But since we're here, maybe we can break this long message, remove
the first full stop and leave the second part of the message as is, as a
suggestion.  Like we do in the previous message, above.

For your consideration, I mean something like:

--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -969,7 +969,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
                                  "Did you mean to use: -a|-r --list <pattern>?"));

                if (track == BRANCH_TRACK_OVERRIDE)
-                       die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
+                       die(_("the '--set-upstream' option is no longer supported\n"
+                             "Please use '--track' or '--set-upstream-to' instead."));


>  
>  		if (recurse_submodules) {
>  			create_branches_recursively(the_repository, branch_name,
> -- 
> 2.42.0.325.g3a06386e31
> 

One final comment, leaving aside my suggestions; this changes break
some tests that you need to adjust.  Try:

   $ make && (cd t; ./t3200-branch.sh -vi)

Or, as Junio has already suggested in another message:

   $ make test

I have some unfinished work that you might find useful:

https://lore.kernel.org/git/eb3c689e-efeb-4468-a10f-dd32bc0ee37b@gmail.com/

Thank you for working on this.
