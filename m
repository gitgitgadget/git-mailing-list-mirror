Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68FBC1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeBWWqE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:46:04 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38959 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752341AbeBWWp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:45:58 -0500
Received: by mail-wr0-f194.google.com with SMTP id w77so15572958wrc.6
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l+wNa/CaUurDyMR3VIX+U1LCR5oT+O7vIe4YKgnmJ8g=;
        b=rQZcSgifl8v80+ijKCfeP5sncEI97ifBGoTmjI9fsVsElSPVeJsHlt754oy0M0rcZn
         ZhQVQvSVxrvuT/OTlWCkDBilnk4nSc7wXyTzwb/V+Tv+7Avuh0F5Bj/bAyo1V1hC0uq3
         QKTJnULxYlyEvNAA/tdMlTCfWYOQHolTPlN8zT43xdY3esDUU8QVYGraaY0G1tQFWuXb
         wEwf73F7BdJDerFaNVNmzl3t7PivT3CQaW0qifA7VkpQt/ZFRZ/MuOh5PP2rnY70JuXy
         W+RLHxGKcLDFYsXP/W95XUBYUZJk58W0PwX0oDj38uTf5J3jI1Xmopq16ZKaE/0mM8cn
         BkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l+wNa/CaUurDyMR3VIX+U1LCR5oT+O7vIe4YKgnmJ8g=;
        b=FW2lFZ1f97aEDgaJXN86Wli9RvdI8+pVIn8uQuk1pj5DmXxmAAPzpC6eIqfMGLWVBR
         kTLmFdNpopOjLqpJb83ms5CXrE42TdopYONItcP19sFjTfiqHpaRaR8KYjnJ69oZi8Xa
         aTKRWQeZfT47FKra4kSe9zG5u6WLhidQDe9cHMUyLpkTJ6XxY8vB2W1yIVziCFHPE40G
         SUm7Rn+lpiMG5jq0hTmmntNQ4k6KuH9U31quvN+ySRTo6J527Qv5myGFSXcj3NyYhY06
         eW/q5H4nAonbnG7e2CV8UoO/Bvbxo5Jm7D7xe/BbGeRyUdUYhKShpakldZ61q+2XkOy4
         DQnA==
X-Gm-Message-State: APf1xPCpVm96KuZI1VHYlk5mVMi1tsfedWRBvMzy4jpLoeZ2X5TjFp+Z
        LeLvnf0+o1azniOJfcP32RI56RA9
X-Google-Smtp-Source: AH8x226Cd4uWYyH5JeAk/AR7JQJ7qcVhqK54PUmcBiiZOwIO8WX9JDRjSeC2+xJ9LKynSlY9zO3QLQ==
X-Received: by 10.223.132.38 with SMTP id 35mr3135195wrf.2.1519425957247;
        Fri, 23 Feb 2018 14:45:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 41sm5880871wrc.12.2018.02.23.14.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 14:45:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen R Guglielmo <srguglielmo@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH v2] subtree: fix add and pull for GPG-signed commits
References: <CADfK3RVJ9pYtpX9x2=CZSKLVy2qxBKeyyGA_S=jo8K-Fa4FOqA@mail.gmail.com>
Date:   Fri, 23 Feb 2018 14:45:56 -0800
In-Reply-To: <CADfK3RVJ9pYtpX9x2=CZSKLVy2qxBKeyyGA_S=jo8K-Fa4FOqA@mail.gmail.com>
        (Stephen R. Guglielmo's message of "Fri, 23 Feb 2018 15:41:25 -0500")
Message-ID: <xmqq7er3s4t7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen R Guglielmo <srguglielmo@gmail.com> writes:

> If log.showsignature is true (or --show-signature is passed) while
> performing a `subtree add` or `subtree pull`, the command fails.
>
> toptree_for_commit() calls `log` and passes the output to `commit-tree`.
> If this output shows the GPG signature data, `commit-tree` throws a
> fatal error.
>
> This commit fixes the issue by adding --no-show-signature to `log` calls
> in a few places, as well as using the more appropriate `rev-parse`
> instead where possible.
>
> Signed-off-by: Stephen R Guglielmo <srg@guglielmo.us>
> ---
>  contrib/subtree/git-subtree.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

This was too heavily whitespace damaged so I recreated your patch
manually from scratch and queued, during which time I may have made
silly and simple mistakes.  Please double check what appears on the
'pu' branch in a few hours.

Thanks.

I am however starting to feel that

 (1) add gitlog="git log" and then do s/git log/$gitlog/; to the
     remainder of the whole script in patch 1/2; and

 (2) turn the variable definition to gitlog="git log --no-show-signature"
     in patch 2/2

may be a better approach.  After all, this script is not prepared to
be used by any group of people who use signed commits, and showing
commit signature in any of its use of 'git log', either present or
in the future, will not be useful to it, I suspect.

>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index dec085a23..9594ca4b5 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -297,7 +297,7 @@ find_latest_squash () {
>   main=
>   sub=
>   git log --grep="^git-subtree-dir: $dir/*\$" \
> - --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
> + --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
>   while read a b junk
>   do
>   debug "$a $b $junk"
> @@ -341,7 +341,7 @@ find_existing_splits () {
>   main=
>   sub=
>   git log --grep="^git-subtree-dir: $dir/*\$" \
> - --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
> + --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
>   while read a b junk
>   do
>   case "$a" in
> @@ -382,7 +382,7 @@ copy_commit () {
>   # We're going to set some environment vars here, so
>   # do it in a subshell to get rid of them safely later
>   debug copy_commit "{$1}" "{$2}" "{$3}"
> - git log -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
> + git log --no-show-signature -1
> --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
>   (
>   read GIT_AUTHOR_NAME
>   read GIT_AUTHOR_EMAIL
> @@ -462,8 +462,8 @@ squash_msg () {
>   oldsub_short=$(git rev-parse --short "$oldsub")
>   echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
>   echo
> - git log --pretty=tformat:'%h %s' "$oldsub..$newsub"
> - git log --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
> + git log --no-show-signature --pretty=tformat:'%h %s' "$oldsub..$newsub"
> + git log --no-show-signature --pretty=tformat:'REVERT: %h %s'
> "$newsub..$oldsub"
>   else
>   echo "Squashed '$dir/' content from commit $newsub_short"
>   fi
> @@ -475,7 +475,7 @@ squash_msg () {
>
>  toptree_for_commit () {
>   commit="$1"
> - git log -1 --pretty=format:'%T' "$commit" -- || exit $?
> + git rev-parse --verify "$commit^{tree}" || exit $?
>  }
>
>  subtree_for_commit () {
