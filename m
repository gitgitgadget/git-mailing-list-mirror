Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C856920899
	for <e@80x24.org>; Sat,  5 Aug 2017 22:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdHEWlr (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 18:41:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54724 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751174AbdHEWlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 18:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32554974C0;
        Sat,  5 Aug 2017 18:41:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g7NO7ywrTJkL8M/YJptU+BLqDMk=; b=k1bSDZ
        lDk/j1lun/UpptJJa5JCKtxL5o5s9zqPSp/CnKl37eUVOvh4IWNTL4StXzorbhR9
        Y6ZxRAOz6miYNAzMs0BUpuengRBHxWJMWMP8McnoZIUwcFiZrOcLqzwUO4H9cp2P
        SNa8zkxLNRzrVG3tuOboUzm58s4FdsfdDrrDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yYTUvxOT1RtXT5YEOuRF9PnbO1i6GVxb
        oKvNLGsE0iVQth8GApTchEozLjfEEtHOq9v5qSI6wCI3Q/9ljoHM9GPqyHfiwge+
        nTCSwHmEOdYFfAnJAYxLPKn3qMn+c3hYsSZQXeNQOfXR6UkEH7HTn+Ri2l1wcDXR
        3DIytieaFxc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B1CB974BF;
        Sat,  5 Aug 2017 18:41:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D4BA974BD;
        Sat,  5 Aug 2017 18:41:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
References: <20170805064905.5948-1-mforney@mforney.org>
Date:   Sat, 05 Aug 2017 15:41:37 -0700
In-Reply-To: <20170805064905.5948-1-mforney@mforney.org> (Michael Forney's
        message of "Fri, 4 Aug 2017 23:49:05 -0700")
Message-ID: <xmqqlgmxskm6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E552898-7A2F-11E7-B015-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Forney <mforney@mforney.org> writes:

> This way, they still work even if the built-in symlinks aren't
> installed.
>
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
> It looks like there was an effort to do this a number of years ago (through
> `make remove-dashes`). These are just a few I noticed were still left in the
> .sh scripts.

Thanks for working on this.  

Have you made sure that all of these scripts, before calling
'git-foo' in the current code, update their PATH so that these found
in the bog standard place (i.e. GIT_EXEC_PATH)?

The reason I ask is because we can rest assured these changes will
be a no-regression improvement if you did so.  I do not offhand
think of a reason why these scripts wouldn't be doing so, but it
never hurts to make sure.

>
>  git-merge-octopus.sh  | 2 +-
>  git-merge-one-file.sh | 8 ++++----
>  git-merge-resolve.sh  | 2 +-
>  git-stash.sh          | 2 +-
>  git-submodule.sh      | 6 +++---
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
> index bcf0d92ec..6c390d6c2 100755
> --- a/git-merge-octopus.sh
> +++ b/git-merge-octopus.sh
> @@ -100,7 +100,7 @@ do
>  	if test $? -ne 0
>  	then
>  		gettextln "Simple merge did not work, trying automatic merge."
> -		git-merge-index -o git-merge-one-file -a ||
> +		git merge-index -o git-merge-one-file -a ||
>  		OCTOPUS_FAILURE=1
>  		next=$(git write-tree 2>/dev/null)
>  	fi
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index 424b034e3..9879c5939 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -115,16 +115,16 @@ case "${1:-.}${2:-.}${3:-.}" in
>  		;;
>  	esac
>  
> -	src1=$(git-unpack-file $2)
> -	src2=$(git-unpack-file $3)
> +	src1=$(git unpack-file $2)
> +	src2=$(git unpack-file $3)
>  	case "$1" in
>  	'')
>  		echo "Added $4 in both, but differently."
> -		orig=$(git-unpack-file e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
> +		orig=$(git unpack-file e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
>  		;;
>  	*)
>  		echo "Auto-merging $4"
> -		orig=$(git-unpack-file $1)
> +		orig=$(git unpack-file $1)
>  		;;
>  	esac
>  
> diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
> index c9da747fc..343fe7bcc 100755
> --- a/git-merge-resolve.sh
> +++ b/git-merge-resolve.sh
> @@ -45,7 +45,7 @@ then
>  	exit 0
>  else
>  	echo "Simple merge failed, trying Automatic merge."
> -	if git-merge-index -o git-merge-one-file -a
> +	if git merge-index -o git-merge-one-file -a
>  	then
>  		exit 0
>  	else
> diff --git a/git-stash.sh b/git-stash.sh
> index 9b6c2da7b..9aa09c3a3 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -573,7 +573,7 @@ apply_stash () {
>  
>  	if test -n "$u_tree"
>  	then
> -		GIT_INDEX_FILE="$TMPindex" git-read-tree "$u_tree" &&
> +		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
>  		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
>  		rm -f "$TMPindex" ||
>  		die "$(gettext "Could not restore untracked files from stash entry")"
> diff --git a/git-submodule.sh b/git-submodule.sh
> index e131760ee..ffa2d6648 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -864,7 +864,7 @@ cmd_summary() {
>  				test $status != A && test $ignore_config = all && continue
>  			fi
>  			# Also show added or modified modules which are checked out
> -			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
> +			GIT_DIR="$sm_path/.git" git rev-parse --git-dir >/dev/null 2>&1 &&
>  			printf '%s\n' "$sm_path"
>  		done
>  	)
> @@ -898,11 +898,11 @@ cmd_summary() {
>  		missing_dst=
>  
>  		test $mod_src = 160000 &&
> -		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
> +		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_src^0 >/dev/null &&
>  		missing_src=t
>  
>  		test $mod_dst = 160000 &&
> -		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
> +		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_dst^0 >/dev/null &&
>  		missing_dst=t
>  
>  		display_name=$(git submodule--helper relative-path "$name" "$wt_prefix")
