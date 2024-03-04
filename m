Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C181A3D544
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547158; cv=none; b=WNt/Bt8P1TSZdZqCTUP+XFZwCCduiB7+DqUuBTIsFp4Xnr5MnZTWPyVvA05wPDrIPsWG2hXt4y9BObek8vARPIRlr3vhB5eXhqyP6ebi0ZdqgTq54ixr3AJf5WXb562tBWqK1dO4WQ9btZa/Ex5TgWg7tCN7rwZoofGOsru3gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547158; c=relaxed/simple;
	bh=Etw4on1mKOZe+9XilrepCX0OXL1BobYfj7zqIiZaVxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivqB4HKD+rHzj6MyJYY1wM+OK+yC30WaYYP9SsWGtYkL2ZKiC4/5fo5m5/kmMKZn+PWZl+FeN6+BvbklD9tRNPaPGEfPIH+JDJ75re8O5l5JKfhixatclzjm9Nuju2QhgwoQPyJ06Nzx7lxpLql9g1hdI1RZl3QdoMQoneOQ9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0h477qT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0h477qT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412e22315d8so6077935e9.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 02:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709547155; x=1710151955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe1mHCoR2byjrTn1fKxu3yXN/paKdCjPcnoWhniEVrM=;
        b=h0h477qTYnqADHbzjfs42yF314T/WzPZ39otb9lt0LFCgtgF0IXLs+RI436yaUi/8o
         cf6wpzOCMpvY5H2s/6Jx0KnE9K8Z+VJgJi3kVCpVFj1shAum7UVihdY2os6wQAYjvQbj
         VmL8Cpx+yWKQxKbNy929Edt+6M2D/iX0F1X8luZ3oaE30xVyD7T51mCYSAod8K38RTDk
         XHMNXgnFjiX5p8fJ8hhwdNoHDsRxY7X7TEKOomN9Yv40NpzaUVWlg1KAtIXa3lZVANU7
         ZmmsK8RExT0LnS3unDtPDknZg6Ll0W7GoRmhcHw7WuD2ge2ZKUaXfJGYqS7Qp1RhFUTB
         5y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547155; x=1710151955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pe1mHCoR2byjrTn1fKxu3yXN/paKdCjPcnoWhniEVrM=;
        b=lS9QgFn2o5TkXRJ6a1qU6ZjfSajjNLSqJeKnSBUpLKfTaFauhf6+tAlvM0Rn65jiw+
         D3oYhesas5NYYvNA9LvRTu69zwMDSVCHjmjaHdoAHYgrsNGZTpBO7OUxqN4jsmE7aW6/
         rf1iLkVTqwvNXGdX1D3ipMyCPMNldHPjbulkgS/yrTTY/trag+QSqTNXafsJ/PJL5SLv
         VtP7FYDpA/CumMQRscAAdeJ4yLh+LITar77QEIPRQ+QX8pbGOsI+eJUrCrRCLCseB7PP
         sj2ENMuAYItGQmxeD9lJ3yQ2iLiLYw6hjCNnLUjS6+KI4wKGmmiwvRovZb725dYOC6r0
         aUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCBaJRnIQEowodHC/6B1o7ic7WJ9d0j7efRfFCp9BOimvF5X1aKLjAuQnoKUxjOJQy7pBFbCDL8BGQgM9G7XP4OuWC
X-Gm-Message-State: AOJu0YwES8gCgh0ajajLEr2tx1CFjmal/svJban5yDR1r3dH1ufjJjQR
	sYLuZPsLCxVKKp6ZdhzFNUTnH85waUOO4C2QG5oacjS2KY3vumgj0GWgTqUW
X-Google-Smtp-Source: AGHT+IGUpRkGhhnxPijc2leRApv1pTqB9uzyCFjd9gw4d1QqDoRrik7w94IcniMlbCNsoKl3SGdZfw==
X-Received: by 2002:a05:600c:4ed2:b0:412:7218:bda4 with SMTP id g18-20020a05600c4ed200b004127218bda4mr5610909wmq.19.1709547154887;
        Mon, 04 Mar 2024 02:12:34 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244? ([2a0a:ef40:6ca:8b01:80a6:cae7:d811:7244])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b004122b7a680dsm14348242wmb.21.2024.03.04.02.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 02:12:34 -0800 (PST)
Message-ID: <3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
Date: Mon, 4 Mar 2024 10:12:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
Content-Language: en-US
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe

On 02/03/2024 16:18, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> Allow disabling the advice shown when a squencer operation results in a
> merge conflict through a new config 'advice.sequencerConflict'.

We already have "advice.resolveConflict" to suppress conflict advice. 
Can we extend that to these conflict messages rather than introducing a 
new category? As far as the user is concerned they are all messages 
about resolving conflicts - I don't really see why they'd want to 
suppress the messages from "git merge" separately to "git rebase" (and 
if they do then why is it ok to suppress the messages from "git merge", 
"git rebase" and "git cherry-pick" with a single setting). It would also 
be good to update the "rebase --apply" implementation to respect this 
advice config to be consistent with "rebase --merge".

Best Wishes

Phillip

> Update the tests accordingly. Note that the body of the second test in
> t3507-cherry-pick-conflict.sh is enclosed in double quotes, so we must
> escape them in the added line.
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>      sequencer: allow disabling conflict advice
>      
>      CC: Elijah Newren newren@gmail.com CC: Phillip Wood
>      phillip.wood@dunelm.org.uk CC: Johannes Schindelin
>      Johannes.Schindelin@gmx.de CC: ZheNing Hu adlternative@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1682%2Fphil-blain%2Fsequencer-conflict-advice-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1682/phil-blain/sequencer-conflict-advice-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1682
> 
>   Documentation/config/advice.txt |  3 +++
>   advice.c                        |  1 +
>   advice.h                        |  1 +
>   sequencer.c                     | 33 ++++++++++++++++++---------------
>   t/t3501-revert-cherry-pick.sh   |  1 +
>   t/t3507-cherry-pick-conflict.sh |  2 ++
>   6 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index c7ea70f2e2e..736b88407a4 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -104,6 +104,9 @@ advice.*::
>   	rmHints::
>   		In case of failure in the output of linkgit:git-rm[1],
>   		show directions on how to proceed from the current state.
> +	sequencerConflict::
> +		Advice shown when a sequencer operation stops because
> +		of conflicts.
>   	sequencerInUse::
>   		Advice shown when a sequencer command is already in progress.
>   	skippedCherryPicks::
> diff --git a/advice.c b/advice.c
> index 6e9098ff089..23e48194e74 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -71,6 +71,7 @@ static struct {
>   	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
>   	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
>   	[ADVICE_RM_HINTS]				= { "rmHints" },
> +	[ADVICE_SEQUENCER_CONFLICT]                     = { "sequencerConflict" },
>   	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
>   	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
>   	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
> diff --git a/advice.h b/advice.h
> index 9d4f49ae38b..98966f8991d 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -40,6 +40,7 @@ enum advice_type {
>   	ADVICE_RESOLVE_CONFLICT,
>   	ADVICE_RM_HINTS,
>   	ADVICE_SEQUENCER_IN_USE,
> +	ADVICE_SEQUENCER_CONFLICT,
>   	ADVICE_SET_UPSTREAM_FAILURE,
>   	ADVICE_SKIPPED_CHERRY_PICKS,
>   	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
> diff --git a/sequencer.c b/sequencer.c
> index f49a871ac06..3e2f028ce2d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -467,7 +467,7 @@ static void print_advice(struct repository *r, int show_hint,
>   	char *msg = getenv("GIT_CHERRY_PICK_HELP");
>   
>   	if (msg) {
> -		advise("%s\n", msg);
> +		advise_if_enabled(ADVICE_SEQUENCER_CONFLICT, "%s\n", msg);
>   		/*
>   		 * A conflict has occurred but the porcelain
>   		 * (typically rebase --interactive) wants to take care
> @@ -480,22 +480,25 @@ static void print_advice(struct repository *r, int show_hint,
>   
>   	if (show_hint) {
>   		if (opts->no_commit)
> -			advise(_("after resolving the conflicts, mark the corrected paths\n"
> -				 "with 'git add <paths>' or 'git rm <paths>'"));
> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
> +					  _("after resolving the conflicts, mark the corrected paths\n"
> +					    "with 'git add <paths>' or 'git rm <paths>'"));
>   		else if (opts->action == REPLAY_PICK)
> -			advise(_("After resolving the conflicts, mark them with\n"
> -				 "\"git add/rm <pathspec>\", then run\n"
> -				 "\"git cherry-pick --continue\".\n"
> -				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
> -				 "To abort and get back to the state before \"git cherry-pick\",\n"
> -				 "run \"git cherry-pick --abort\"."));
> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
> +					  _("After resolving the conflicts, mark them with\n"
> +					    "\"git add/rm <pathspec>\", then run\n"
> +					    "\"git cherry-pick --continue\".\n"
> +					    "You can instead skip this commit with \"git cherry-pick --skip\".\n"
> +					    "To abort and get back to the state before \"git cherry-pick\",\n"
> +					    "run \"git cherry-pick --abort\"."));
>   		else if (opts->action == REPLAY_REVERT)
> -			advise(_("After resolving the conflicts, mark them with\n"
> -				 "\"git add/rm <pathspec>\", then run\n"
> -				 "\"git revert --continue\".\n"
> -				 "You can instead skip this commit with \"git revert --skip\".\n"
> -				 "To abort and get back to the state before \"git revert\",\n"
> -				 "run \"git revert --abort\"."));
> +			advise_if_enabled(ADVICE_SEQUENCER_CONFLICT,
> +					  _("After resolving the conflicts, mark them with\n"
> +					    "\"git add/rm <pathspec>\", then run\n"
> +					    "\"git revert --continue\".\n"
> +					    "You can instead skip this commit with \"git revert --skip\".\n"
> +					    "To abort and get back to the state before \"git revert\",\n"
> +					    "run \"git revert --abort\"."));
>   		else
>   			BUG("unexpected pick action in print_advice()");
>   	}
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index aeab689a98d..bc7c878b236 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -170,6 +170,7 @@ test_expect_success 'advice from failed revert' '
>   	hint: You can instead skip this commit with "git revert --skip".
>   	hint: To abort and get back to the state before "git revert",
>   	hint: run "git revert --abort".
> +	hint: Disable this message with "git config advice.sequencerConflict false"
>   	EOF
>   	test_commit --append --no-tag "double-add dream" dream dream &&
>   	test_must_fail git revert HEAD^ 2>actual &&
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index c88d597b126..a643893dcbd 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -60,6 +60,7 @@ test_expect_success 'advice from failed cherry-pick' '
>   	hint: You can instead skip this commit with "git cherry-pick --skip".
>   	hint: To abort and get back to the state before "git cherry-pick",
>   	hint: run "git cherry-pick --abort".
> +	hint: Disable this message with "git config advice.sequencerConflict false"
>   	EOF
>   	test_must_fail git cherry-pick picked 2>actual &&
>   
> @@ -74,6 +75,7 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
>   	error: could not apply \$picked... picked
>   	hint: after resolving the conflicts, mark the corrected paths
>   	hint: with 'git add <paths>' or 'git rm <paths>'
> +	hint: Disable this message with \"git config advice.sequencerConflict false\"
>   	EOF
>   	test_must_fail git cherry-pick --no-commit picked 2>actual &&
>   
> 
> base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
