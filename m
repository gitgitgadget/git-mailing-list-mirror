Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3515C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 16:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349879AbiFOQ7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349765AbiFOQ6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 12:58:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B19715809
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 09:58:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s17-20020a170902ea1100b00168b7cad0efso6820865plg.14
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=3ZhBjqwIWgHLP7wlL7qvzYXEvP8I8QHc/3RdI5CUJLU=;
        b=qXhfelLPWsAoSisG0XRO8LhIL6oK+1kTXDGrkLgd4HHwYtDu5tzFyBa5/vxgRSTRQC
         6qc2ZVBRt8wI5x+3SLQ/YzaQWoGiwhnVRdLPRzt9m4hkmk6z3Y4Kqi2EW3D/kGdQgFY7
         D7EDQo4S8w/vqVlN1cBWQA2F0241qwECBjDooUfNcQGNILVoYcGJz7QhOKIZ8EfHQrRs
         Y0QD7MfrcbB5EQQhoiNv8OlD451sRjR2pmNtM/YR987wRc+T1Xg2bDBbV8v4YZNnW7Lx
         ASolV1K8MeAzYOVXbrIGBAKR6RhL2QQH7dyXAoNrn4prnVVL6bNnYuwOtYsw8JhunqT2
         Km1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=3ZhBjqwIWgHLP7wlL7qvzYXEvP8I8QHc/3RdI5CUJLU=;
        b=WRbRT1qgbeIRFgj6zHlPOSG9JtI5oThweFBTWmGGHO6WTvYIsnbsDrq8m9DCmBLSX+
         PYGekMApUDq4osVZZWYcCVssg7n1yscoY6GNvJ32az78AwcDy0BdqThdqDcXsv6aJ4Oe
         jZMnAZyj0+uqhXmYn+3vJnA881Ut8LX0g5/eDCTHtyXMOJHo5njm0HlbxtW4zTmHBfag
         v1l5SxIWSIIdvAu4jabfHzTWcOo8eagwlIX5UvyQ9uhJ6VGQ1cMyiTkYrHVIRGy93QKM
         wDIA6A2JzVzafWXO+qcP775DMpGf5aYmzooiZlATLh4V8Cyvz5DFdKkGWUMf3hGg3uex
         5zYQ==
X-Gm-Message-State: AJIora+wkVo1krk4+DAgtSGuxlGL9Om0F3nNFTAJj9sdnE2XJyEt1n+l
        9Ga3TBLtso69Ek/JvSWRnAzLZ4evLWvpSw==
X-Google-Smtp-Source: AGRyM1uEFAL7lutbgVMeBdl1YhrZODeDFDIKxS2olymfmPOtDkpK/sWiexY/48y1Z+HBHNhy3xCaniureYdXEw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:1687:0:b0:50d:3364:46d4 with SMTP id
 129-20020a621687000000b0050d336446d4mr536790pfw.74.1655312327847; Wed, 15 Jun
 2022 09:58:47 -0700 (PDT)
Date:   Wed, 15 Jun 2022 09:58:46 -0700
In-Reply-To: <patch-v2-12.12-31517345ae8-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6l5yl16eyh.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <patch-v2-12.12-31517345ae8-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 12/12] git-sh-setup.sh: remove "say" function, change
 last users
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Remove the "say" function, with various rewrites of the remaining
> git-*.sh code to C and the preceding change to have git-submodule.sh
> stop using the GIT_QUIET variable there were only four uses in
> git-subtree.sh. Let's have it use an "arg_quiet" variable instead, and
> move the "say" function over to it.
>
> The only other use was a trivial message in git-instaweb.sh, since it
> has never supported the --quiet option (or similar) that code added in
> 0b624b4ceee (instaweb: restart server if already running, 2009-11-22)
> can simply use "echo" instead.
>
> The remaining in-tree hits from "say" are all for the sibling function
> defined in t/test-lib.sh. It's safe to remove this function since it
> has never been documented in Documentation/git-sh-setup.txt.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  contrib/subtree/git-subtree.sh | 15 ++++++++++++---
>  git-instaweb.sh                |  2 +-
>  git-sh-setup.sh                |  9 ---------
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree=
.sh
> index 1af1d9653e9..7562a395c24 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -50,6 +50,14 @@ m,message=3D    use the given message as the commit me=
ssage for the merge commit
> =20
>  indent=3D0
> =20
> +# Usage: say [MSG...]
> +say () {
> +	if test -z "$arg_quiet"
> +	then
> +		printf '%s\n' "$*"
> +	fi
> +}
> +
>  # Usage: debug [MSG...]
>  debug () {
>  	if test -n "$arg_debug"
> @@ -60,7 +68,7 @@ debug () {
> =20
>  # Usage: progress [MSG...]
>  progress () {
> -	if test -z "$GIT_QUIET"
> +	if test -z "$arg_quiet"
>  	then
>  		if test -z "$arg_debug"
>  		then
> @@ -146,6 +154,7 @@ main () {
>  	eval "$set_args"
> =20
>  	# Begin "real" flag parsing.
> +	arg_quiet=3D
>  	arg_debug=3D
>  	arg_prefix=3D
>  	arg_split_branch=3D
> @@ -161,7 +170,7 @@ main () {
> =20
>  		case "$opt" in
>  		-q)
> -			GIT_QUIET=3D1
> +			arg_quiet=3D1
>  			;;
>  		-d)
>  			arg_debug=3D1
> @@ -252,7 +261,7 @@ main () {
>  	dir=3D"$(dirname "$arg_prefix/.")"
> =20
>  	debug "command: {$arg_command}"
> -	debug "quiet: {$GIT_QUIET}"
> +	debug "quiet: {$arg_quiet}"
>  	debug "dir: {$dir}"
>  	debug "opts: {$*}"
>  	debug

Ok, makes sense. I don't know git-subtree.sh well, but this looks
consistent with the rest of the file.

> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 4349566c891..c68f49454cd 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -102,7 +102,7 @@ resolve_full_httpd () {
> =20
>  start_httpd () {
>  	if test -f "$fqgitdir/pid"; then
> -		say "Instance already running. Restarting..."
> +		echo "Instance already running. Restarting..."
>  		stop_httpd
>  	fi
> =20
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index ecb60d9e3cb..ce273fe0e48 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -57,15 +57,6 @@ die_with_status () {
>  	exit "$status"
>  }
> =20
> -GIT_QUIET=3D
> -
> -say () {
> -	if test -z "$GIT_QUIET"
> -	then
> -		printf '%s\n' "$*"
> -	fi
> -}
> -
>  if test -n "$OPTIONS_SPEC"; then
>  	usage() {
>  		"$0" -h

Makes sense.
