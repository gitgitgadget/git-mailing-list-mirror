Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5EEC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKYJJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKYJI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:08:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A071D27160
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:08:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id x5so5801632wrt.7
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0skDPGAArwLJS/20UCYO5FncElEgYq5agMVr5OV2CoM=;
        b=Fqx2DZ9K31SzG3qW8noOJkYTm9dMRUc+9z5yRryRZPzJbJ2H/i+i+gn4IqSuhMKMPD
         VgnuqMtl7aOBduwg8wEgv6nFqFlMf6w1PHbLbXOAFC/eZez8Zv0FtTXyNUJrwk4Y4qP7
         xvkNDvh2hV64fF0MPsMpt+7SI2tEJcXbySXYOlIl+AS3DYv1nNGOfXOHXVt0+OHd8yIt
         G0NldJ2NFa1jqpjZcjUbA1HKIuZ/Bu9olJV9eCZ9F56QMYEqzIihrfugF6zGrOUQMFZz
         p6Eq5b+N10xlpT98uPJFvHJrUgCCdRdg6+lMpPBdPiSM5ACpdnwgwXkRIPa1ItEwiZ2h
         mLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0skDPGAArwLJS/20UCYO5FncElEgYq5agMVr5OV2CoM=;
        b=LZhSRyamdDI8ZfeAicUJ6XzL3Pv8cxSPfGUV3s6UaGeCAyovZO94bpU9ewAEul28Np
         Qg0CM8nGvg1nA+RavnrZOmoBNTLgxYu9ntTepa55gaYHMO4M5imAek+dSx5AijQXx4tD
         AN8PjiGIcYUTWM2NQg/xe/rlpLiGy6kubs6XbBPDR6QgD9DpHgmAnOV51QuNgUuTluVu
         fE9EkJqV9hWSH0Dm5bEXwkotV/RBC12D1OUDDRb5YgJabbA1Lm0t1C+PnW20dr/JV1D0
         MTMxdxCHVr9uEE8IvzNBYCqLSX8zI5PpFXTguW08hcX5NyI1wAEZibXjy1tljxrtBO0p
         mm2Q==
X-Gm-Message-State: ANoB5png1kDp8krVGzTfrDjrZ3I2SPOULFwJcgccaWs+K9yeXsv/k/3x
        /l8+XnHRTH5hYvoRFdIA85HtKEnAqbBz2cCf
X-Google-Smtp-Source: AA0mqf66EtOASAz/adSeG2YCQNI0i/IDBom6dBvPZ0M0LhjjilWa+4pj+vwwg8Ftx5/q9wYwUwA/4A==
X-Received: by 2002:a5d:5f0a:0:b0:241:dcf9:107e with SMTP id cl10-20020a5d5f0a000000b00241dcf9107emr3201697wrb.363.1669367334245;
        Fri, 25 Nov 2022 01:08:54 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d65c3000000b002383edcde09sm3199141wrw.59.2022.11.25.01.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:08:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyUfU-000S40-09;
        Fri, 25 Nov 2022 10:06:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v7 3/3] git-jump: invoke emacs/emacsclient
Date:   Fri, 25 Nov 2022 09:55:13 +0100
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
 <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
Message-ID: <221125.8635a7o123.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 25 2022, Yoichi Nakayama via GitGitGadget wrote:

> From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
>
> It works with GIT_EDITOR="emacs", "emacsclient" or "emacsclient -t"
>
> Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> ---
>  contrib/git-jump/git-jump | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index cc97b0dcf02..eef9cda832f 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -23,7 +23,22 @@ EOF
>  
>  open_editor() {
>  	editor=`git var GIT_EDITOR`
> -	eval "$editor -q \$1"
> +	case "$editor" in
> +	*emacs*)
> +		# Supported editor values are:
> +		# - emacs
> +		# - emacsclient
> +		# - emacsclient -t
> +		#
> +		# Wait for completion of the asynchronously executed process
> +		# to avoid race conditions in case of "emacsclient".
> +		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat \$1\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
> +		;;
> +	*)
> +		# assume anything else is vi-compatible
> +		eval "$editor -q \$1"
> +		;;
> +	esac
>  }
>  
>  mode_diff() {

I'd really like to have some closer and smarter emacs integration like
this.

But I don't see why we need to run the grep ourselves, pipe it to a
temporary file, and then discover that we're using emacs, and --eval
code into it to switch to that buffer, and fake up a "M-x grep" command
with a compilation buffer to make it look like we ran M-x grep in the
first place.

Let's just ... run M-x grep earlier? Then we can skip all the earlier
steps.

I experimented with this a bit locally, and I didn't get the "switch to
buffer" semantics to work with this (but that's presumably easy, I'm
just rusty on my elisp APIs), but something in this direction seems much
better:
	
	diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
	index eef9cda832f..c932d7acd0f 100755
	--- a/contrib/git-jump/git-jump
	+++ b/contrib/git-jump/git-jump
	@@ -22,23 +22,7 @@ EOF
	 }
	 
	 open_editor() {
	-	editor=`git var GIT_EDITOR`
	-	case "$editor" in
	-	*emacs*)
	-		# Supported editor values are:
	-		# - emacs
	-		# - emacsclient
	-		# - emacsclient -t
	-		#
	-		# Wait for completion of the asynchronously executed process
	-		# to avoid race conditions in case of "emacsclient".
	-		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat \$1\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
	-		;;
	-	*)
	-		# assume anything else is vi-compatible
	-		eval "$editor -q \$1"
	-		;;
	-	esac
	+	eval "$editor -q \$1"
	 }
	 
	 mode_diff() {
	@@ -83,11 +67,14 @@ mode_ws() {
	 }
	 
	 use_stdout=
	+use_magic=t
	 while test $# -gt 0; do
	 	case "$1" in
	 	--stdout)
	 		use_stdout=t
	-		shift
	+		;;
	+	--no-magic)
	+		use_magic=
	 		;;
	 	--*)
	 		usage >&2
	@@ -96,7 +83,8 @@ while test $# -gt 0; do
	 	*)
	 		break
	 		;;
	-	esac
	+	esac &&
	+	shift
	 done
	 if test $# -lt 1; then
	 	usage >&2
	@@ -105,6 +93,22 @@ fi
	 mode=$1; shift
	 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
	 
	+editor=`git var GIT_EDITOR`
	+if test "$use_magic" && test "$mode" = "grep"
	+then
	+	case "$editor" in
	+	*emacs*)
	+		set -x
	+		eval "$editor --eval \" \
	+			(grep \\\"git grep -H "$@"\\\") \
	+		\""
	+		exit
	+		;;
	+	*)
	+		;;
	+	esac
	+fi
	+
	 if test "$use_stdout" = "t"; then
	 	"mode_$mode" "$@"
	 	exit 0

I.e. if we're going to trust emacs to eval this code, and assume that
grep.el etc. works, let's just run the equivalent of M-x grep with our
'git grep' command.

This is already better in that "grep" understands that I searched for
"foo.*bar", so that's highlighted in the resulting buffer, just as with
normal "grep" commands.

This is missing the bit where we'd need to jump.grepCmd etc, so it's
incomplete.

I think this is all the prior art we'd need to invoke "git grep" the
right way from emacs's "grep":
https://github.com/eglaysher/find-things-fast/blob/master/find-things-fast.el#L246

B.t.w. I'd think the "--no-magic" here is something you'd want too. I
like this new behavior (sans the comments above), but presumably there's
people using emacs as their EDITOR who don't want to have this magic
behavior, having an opt-out would be neat.

I.e. if you have an existing customization intercepting these then this
will screw with that, but maybe that's OK...
