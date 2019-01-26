Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3932F1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 13:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfAZN7T (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 08:59:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43181 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfAZN7T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 08:59:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so13063309wrs.10
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 05:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ncKA7/JGXf94OWfmqJf8EzhFrju5KAHtjmWSrkWzAM=;
        b=JPWu0pU5nmNkL9uInDDmpUJY19KYZyp6HJJKIE3kBiP0+hmR/8nkotyqZl7Qt7maZt
         VDtorEPJJBhLMn6pLUorTTKYa/CQPcfbtQjqjSFDxZOX1IKHwB+IqF2UjSakLssSV8Kd
         sFYVZ/DAJs1nziNUN3I3PaS3gzWhR6ROvZSguKamgPn7cI/cBnFJb7AkZx/uTkhGmIHM
         XvwomBItb7N7QgRDBiLLtQpFkiwiC1OfWNSdAVxt3v3B8O5PBOhZwGbqb1tMhAVtWyMM
         gNxF9hDozmVPRWVthsV2gWSqaBa8Em6CTmcUjpt0wq0cMKDQpcFagX2LcRudpauvcTGf
         cqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6ncKA7/JGXf94OWfmqJf8EzhFrju5KAHtjmWSrkWzAM=;
        b=JAFz/9afA/1kSS/Aat9kqh+KkaVFYVjqsdCRF44DcN4YRtVAFSPJYsarGetNL3CBdd
         ktBU/AdBZKkirG1shasGKvJZo7GmINhn+4ny7aYxOP2bXPHYBKy64U53M9qfr4PsKs50
         dbSdwZv3Uzlh3EoxWA2izd9HQrcKYjX779YLDkKHe8W5ocXNyzouf0okT+VwbWn1cLdM
         yEBTK3a7Yr2HHfJCwRQn72hsWI764jVTc5OXCiQwxPqTDyWHpSLLkH0Bb0Hbjo7VWBzr
         2yGJZJp0OFc5W3UXbujc5bfRRTgf/qObWCVkoxux6EwrLe9GXNlwb6s30kuneWfBFEIu
         3ung==
X-Gm-Message-State: AJcUuke2MSJTyZs2S9pNK8shXqRJB5XIlhciu1FIOuQwzzx5tHJYT4nK
        fczozpmzwfLaQkFaK5HK3yk=
X-Google-Smtp-Source: ALg8bN42XucSRcSbboeQGfhxiL5yiQ6g5X2RXXbf6oeQZAMfnfR3E9vGp4m5mQ2nSmZtSrQ8ZP2kew==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr14741743wrw.310.1548511156394;
        Sat, 26 Jan 2019 05:59:16 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.gmail.com with ESMTPSA id k128sm91476774wmd.37.2019.01.26.05.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 05:59:15 -0800 (PST)
Subject: Re: [PATCH v2] rebase: move state_dir to tmp prior to deletion
To:     Ben Woosley <Ben.Woosley@gmail.com>, git@vger.kernel.org
References: <01020168891b1a3e-140bd175-a8cb-4379-a114-de68b1cac5d6-000000@eu-west-1.amazonses.com>
 <0102016889a9145a-83604d85-036b-409b-a3d2-2eb1ef2c5b95-000000@eu-west-1.amazonses.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5c40a594-d23c-dfb5-18fe-2ac6fa9b3865@gmail.com>
Date:   Sat, 26 Jan 2019 14:59:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <0102016889a9145a-83604d85-036b-409b-a3d2-2eb1ef2c5b95-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

Le 26/01/2019 à 11:16, Ben Woosley a écrit :
> From: Ben Woosley <ben.woosley@gmail.com>
> 
> To avoid partial deletion / zombie rebases.
> 
> Example behavior under partial deletion, after
> Ctrl-Cing out of a standard rebase:
> 
>     $ git rebase target
>     First, rewinding head to replay your work on top of it...
>     Applying: [...]
>     ^C
>     $ git status
>     rebase in progress; onto (null)
>     You are currently rebasing.
>       (all conflicts fixed: run "git rebase --continue")
> 
>     Changes to be committed:
>       (use "git reset HEAD <file>..." to unstage)
>     [...]
>     $ git rebase --continue
>     error: could not read '.git/rebase-apply/head-name': No such file or directory
>     $ git rebase --abort
>     error: could not read '.git/rebase-apply/head-name': No such file or directory
> 
> Others report this issue here:
> https://stackoverflow.com/questions/3685001/git-how-to-fix-corrupted-interactive-rebase
> ---
>  git-legacy-rebase.sh           | 17 ++++++++++++++---
>  git-rebase--preserve-merges.sh |  2 +-
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 

This patch does not cover the new builtin rebase, even though it’s also
affected by this bug.  I ran in two bugs trying to reproduce this issue
with the builtin:

 1. Right after invoking `git rebase $target', $target was checked out
but the state directory has not been written yet, leaving the user on
the target without any possibility of aborting the rebase.  I think it’s
because the checkout is done by builtin/rebase.c, whereas the state
directory is created by git-rebase--am -- and it might not be created at
all!

 2. If I wait a little bit, I have the same bug as yours.

I tried to reproduce the issue on master (16a465bc01, "Third batch after
2.20") and builtin.userebase set to false, without success.  It seems
this issue has been fixed in the shell version, but not in the builtin
version -- and it seems that you are using the latter, so it won’t solve
your problem anyway.  Try `git -c rebase.usebuiltin=false rebase
--abort', and the state directory will be removed without any errors.

Things are a bit different with interactive rebase: it checks out the
target branch, then create its state directory.  Only the first issue
can happen, and you have to be very unlucky to run into it.  The same
goes for rebase -p.

> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> index b4c7dbfa575d3..832a211c925c3 100755
> --- a/git-legacy-rebase.sh
> +++ b/git-legacy-rebase.sh
> @@ -128,11 +128,22 @@ read_basic_state () {
>  	}
>  }
>  
> +remove_rebase_state () {
> +  removal_dir=$(mktemp -d -t "git-rebase-state-XXXXXX")
> +  if test -d "$removal_dir"
> +  then
> +    mv "$state_dir" "$removal_dir"
> +  else
> +    removal_dir="$state_dir"
> +  fi
> +  rm -rf "$removal_dir"
> +}
> +
>  finish_rebase () {
>  	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
>  	apply_autostash &&
>  	{ git gc --auto || true; } &&
> -	rm -rf "$state_dir"
> +	remove_rebase_state
>  }
>  
>  run_interactive () {
> @@ -194,7 +205,7 @@ run_specific_rebase () {
>  	elif test $ret -eq 2 # special exit status for rebase -p
>  	then
>  		apply_autostash &&
> -		rm -rf "$state_dir" &&
> +		remove_rebase_state &&
>  		die "Nothing to do"
>  	fi
>  	exit $ret
> @@ -439,7 +450,7 @@ abort)
>  	exit
>  	;;
>  quit)
> -	exec rm -rf "$state_dir"
> +	remove_rebase_state
>  	;;
>  edit-todo)
>  	run_specific_rebase
> diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
> index afbb65765d461..146b52df14928 100644
> --- a/git-rebase--preserve-merges.sh
> +++ b/git-rebase--preserve-merges.sh
> @@ -226,7 +226,7 @@ Once you are satisfied with your changes, run
>  
>  die_abort () {
>  	apply_autostash
> -	rm -rf "$state_dir"
> +	remove_rebase_state
>  	die "$1"
>  }
>  
> 
> --
> https://github.com/git/git/pull/569
>
It seems that you tried to implement the solution proposed in the
stackoverflow thread you linked.  Unfortunately, if it fixed something,
it has a problem: it won’t bring you back to the commit where you called
`git rebase', unlike a `git rebase --abort' on a uncorrupted rebase
state.  This is what happens when aborting a corrupted rebase with the
shell version of rebase.  I think it’s because git-rebase--am will only
create a state directory if it has a problem (ie. a conflict or the user
hits ^C).

So, there is definitely a problem with git-rebase--am, but this does not
address it.

-- Alban

