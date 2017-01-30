Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4191F9AF
	for <e@80x24.org>; Mon, 30 Jan 2017 21:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754460AbdA3VLr (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:11:47 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35561 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754477AbdA3VLp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:11:45 -0500
Received: by mail-yb0-f193.google.com with SMTP id j82so21702261ybg.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 13:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=awTHnz53+76PqN5w2jGDk13CHFrp/gp5NkvbwjBGQz8=;
        b=D1VlKRs7O/e9cM5IdVOJhjGUvdcv1DvrYRDU147laSnq2nEyHl2EypK/qFrCw7w6n9
         aOvGVx37ehRisgkQQ2HS+z3c6k66iK40egC7x+7TqlPeUFHky+hO3Ughpz5cS1Ju5rcA
         lbU2H6Q8toGXde8nNHJ6XbuknFznCDwSP8T6GCU2fhV1Rn4DmB6yDx68Eb6ttHXHTC7w
         oamjm925VGZimVcduRbvXnXxB5tR5EbXpTc6wG8oIXJdjHvKtMA0fkEVUVij88rixZDY
         YV0POCSnKGpLsNzQZ2ywOQA642x0iKSzvxH7vUhjPDEF8CGHGW/T2pR2xTi7ICq/+D+t
         RfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=awTHnz53+76PqN5w2jGDk13CHFrp/gp5NkvbwjBGQz8=;
        b=q4sb86utBpjLXbONtdEiWZLqIxc7IyyO2kbw40pYs5Ue9pilHKdt/oQOZQYTtDpKWj
         Unngu2tCjd2ZObiz8xUVdGPWjy/ogFA6xhKBHmY8JOpq5vpgCWxR2cfC/Zr+9jCqvY9L
         42WJx6xWFjf84l8EdVZ+euriSLlHLEGwzM+lvKI9RrodAXil9P/GQnfebZa0VZfSol2O
         g8EhFxDiF60Y0gWhHr53pqZMoQLnKcO7OxJP9s+8e1Bh4nDh0RQVztsYtWgZ5WRGm0oI
         u73CU6u9WTLlvyyz4KpbvMPZBUWG0tXCMfwaNQXp55XieqF6D826SQ4vQVoGyAzPrNw0
         oVtw==
X-Gm-Message-State: AIkVDXLwYgL+H/LS2eVFK7drGv5q9zynNhmhaZnqHi3uSmgReSIjpIG19baU0QJZS2cVhg==
X-Received: by 10.129.111.214 with SMTP id k205mr15380479ywc.343.1485810664681;
        Mon, 30 Jan 2017 13:11:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id z37sm7866078ywj.39.2017.01.30.13.11.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 13:11:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/4] stash: support filename argument
In-Reply-To: <20170129201604.30445-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 29 Jan 2017 20:16:04 +0000")
References: <20170121200804.19009-1-t.gummerer@gmail.com>
        <20170129201604.30445-1-t.gummerer@gmail.com>
        <20170129201604.30445-5-t.gummerer@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
Date:   Mon, 30 Jan 2017 13:11:02 -0800
Message-ID: <xmqqa8a8uuc9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Add an optional filename argument to git stash push, which allows for
> stashing a single (or multiple) files.

You can give pathspec with one or more elements, so "an optional
argument" sounds too limiting.  

    Allow 'git stash push' to take pathspec to specify which paths
    to stash.

Also retitle

	stash: teach 'push' (and 'create') to honor pathspec

or something.

> @@ -56,6 +61,10 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
>  	only <message> does not trigger this action to prevent a misspelled
>  	subcommand from making an unwanted stash.
>  +
> +If the paths argument is given in 'git stash push', only these files
> +are put in the new 'stash'.  In addition only the indicated files are
> +changed in the working tree to match the index.

Actually the stash contains "all paths".  You could say that you are
placing _modifications_ to these paths in stash, even though that is
not how Git's world model works (i.e. everything is a snapshot, and
modifications are merely difference between two successive
snapshots).  A technically correct version may be:

	When pathspec is given to 'git stash push', the new stash
	records the modified states only for the files that match
	the pathspec.  The index entries and working tree files are
	then rolled back to the state in HEAD only for these files,
	too, leaving files that do not match the pathspec intact.

> diff --git a/git-stash.sh b/git-stash.sh
> index 5f08b43967..0072a38b4c 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -41,7 +41,7 @@ no_changes () {
>  untracked_files () {
>  	excl_opt=--exclude-standard
>  	test "$untracked" = "all" && excl_opt=
> -	git ls-files -o -z $excl_opt
> +	git ls-files -o -z $excl_opt -- $1

Hmph, why "$1" is spelled without dq, implying that it is split at
$IFS boundary?  This line alone makes me suspect that this is not
prepared to deal correctly with $IFS.  Let's read on...

> @@ -59,6 +59,7 @@ create_stash () {
>  	stash_msg=
>  	untracked=
>  	new_style=
> +	files=
>  	while test $# != 0
>  	do
>  		case "$1" in
> @@ -72,6 +73,12 @@ create_stash () {
>  			untracked="$1"
>  			new_style=t
>  			;;
> +		--)
> +			shift
> +			files="$@"

Isn't this the same as writing files="$*", i.e. concatenate the
multiple arguments with the first whitespace in $IFS in between?

> @@ -134,7 +141,7 @@ create_stash () {
>  		# Untracked files are stored by themselves in a parentless commit, for
>  		# ease of unpacking later.
>  		u_commit=$(
> -			untracked_files | (
> +			untracked_files $files | (

... and this lets it split at $IFS again when passing it down to the
helper.  But the helper looks only at $1 so the second and subsequent
ones will be ignored altogether.

This cannot be correct, and any hunk in the remainder of the patch
that mentions $files will be incorrect for the same reason.

Is it possible to carry what the caller (and the end user) gave you
in "$@" without molesting it at all?  That would mean you do not
need to introduce $files variable at all, and then the places that
do things like this:

> -	create_stash -m "$stash_msg" -u "$untracked"
> +	create_stash -m "$stash_msg" -u "$untracked" -- $files

can instead do

	create_stash -m "$stash_msg" -u "$untracked" -- "$@"

That would allow you to work correctly with pathspec with $IFS
whitespaces in them.
