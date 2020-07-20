Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F62DC433E1
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3709322482
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wzx6h1v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgGTSvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:51:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61559 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTSvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 14:51:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFC89E1A74;
        Mon, 20 Jul 2020 14:51:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aw5KBL0q3bn0HxQdmU4arnipX0A=; b=Wzx6h1
        v9tIc29Wb/UZ1FxU4lUV5MEamXk/Hb25slEN4q/soxATqRJNl6OUoA4WkeHkb0Tr
        31Mho9jxWZIw4Wnc3c5ZxMtg8dY7hY6hnaAuSSC7sIv3ydellCBRgKyF6/1Q8QhZ
        P3IOuPDfLXFx24O7TgiEE2NM0/F2DCCp/8bhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nyncPGFMPEH/YeOihZ7LKwgJ9NoxbqdF
        pRJfsxBfmHrFKpk4bqW/VRxWvkgpKQwleAb4H2fgHV76GBLJlGqrBMEAl1iahdY4
        ZzXG7QN09AZK3pt3c2NMpHbjYwxkAECXetB76gG5p4PUw7Cde1Zpmbcb7UmWLocr
        Pszzp8C5ePA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B487DE1A73;
        Mon, 20 Jul 2020 14:51:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 035EFE1A72;
        Mon, 20 Jul 2020 14:51:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pudinha <rogi@skylittlesystem.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Refactor vimdiff and bc merge tool variants
References: <20200718192001.27434-1-rogi@skylittlesystem.org>
        <20200719042335.3913-2-rogi@skylittlesystem.org>
Date:   Mon, 20 Jul 2020 11:51:03 -0700
In-Reply-To: <20200719042335.3913-2-rogi@skylittlesystem.org> (pudinha's
        message of "Sun, 19 Jul 2020 05:23:37 +0100")
Message-ID: <xmqqd04q9g14.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7054192-CAB9-11EA-8D94-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pudinha <rogi@skylittlesystem.org> writes:

> Subject: Re: [PATCH v2 1/2] Refactor vimdiff and bc merge tool variants

cf. https://git-scm.com/docs/SubmittingPatches#describe-changes

Two tricks to pick a good title are:

 - Read a pageful or two of "git shortlog --no-merges" output to get
   accustomed to the general pattern in the entire project.  It
   would become clear why titles with "area:" prefix help the
   patches with them easier to locate.

 - Read a pageful of "git shortlog --no-merges -- mergetools"
   (i.e. the same but limited to the files you are touching) to see
   how the changes that contributed over time to build the subsystem
   are called, so that the new patches can fit in the pattern.

> The merge tools vimdiff2, vimdiff3, gvimdiff2, gvimdiff3 and bc3 are all
> variants of the main tools vimdiff and bc. They are implemented in the
> main and a one-liner script that just sources it exist for each.
>
> This patch allows variants ending in [0-9] to be correctly wired without
> the need for such one-liners, so instead of 5 scripts, only 1 (gvimdiff)
> is needed.

Well explained.  The final paragraph could be made more in line with
the existing commit log messages by writing in the imperative mood
(e.g. "Introduce a new list_tool_variants method, and when a tool
whose name ends with a digit is asked for, and if there is no such
script in mergetools/ directoroy, ask the tool with the name without
the final digit, if exists, if it knows how to handle the variant.
That way, instead of 5 scriptss, ..."), but what is written above is
already good enough.

> ---

cf. https://git-scm.com/docs/SubmittingPatches#sign-off

Thanks.

>  git-mergetool--lib.sh | 28 +++++++++++++++++++++++-----
>  mergetools/bc         |  5 +++++
>  mergetools/bc3        |  1 -
>  mergetools/gvimdiff2  |  1 -
>  mergetools/gvimdiff3  |  1 -
>  mergetools/vimdiff    |  8 ++++++++
>  mergetools/vimdiff2   |  1 -
>  mergetools/vimdiff3   |  1 -
>  8 files changed, 36 insertions(+), 10 deletions(-)
>  delete mode 100644 mergetools/bc3
>  delete mode 100644 mergetools/gvimdiff2
>  delete mode 100644 mergetools/gvimdiff3
>  delete mode 100644 mergetools/vimdiff2
>  delete mode 100644 mergetools/vimdiff3
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 204a5acd66..29fecc340f 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -43,7 +43,14 @@ show_tool_names () {
>  
>  	shown_any=
>  	( cd "$MERGE_TOOLS_DIR" && ls ) | {
> -		while read toolname
> +		while read scriptname
> +		do
> +			setup_tool "$scriptname" 2>/dev/null
> +			variants="$variants$(list_tool_variants)\n"
> +		done
> +		variants="$(echo "$variants" | sort | uniq)"
> +
> +		for toolname in $variants
>  		do
>  			if setup_tool "$toolname" 2>/dev/null &&
>  				(eval "$condition" "$toolname")
> @@ -157,6 +164,10 @@ setup_tool () {
>  		echo "$1"
>  	}
>  
> +	list_tool_variants () {
> +		echo "$tool"
> +	}
> +
>  	# Most tools' exit codes cannot be trusted, so By default we ignore
>  	# their exit code and check the merged file's modification time in
>  	# check_unchanged() to determine whether or not the merge was
> @@ -178,19 +189,26 @@ setup_tool () {
>  		false
>  	}
>  
> -
> -	if ! test -f "$MERGE_TOOLS_DIR/$tool"
> +	if test -f "$MERGE_TOOLS_DIR/$tool"
>  	then
> +		. "$MERGE_TOOLS_DIR/$tool"
> +	elif test -f "$MERGE_TOOLS_DIR/${tool%[0-9]}"
> +	then
> +		. "$MERGE_TOOLS_DIR/${tool%[0-9]}"
> +	else

Nice---if the thing has a custom script in mergetools/ then we do
not do anything special, but if a script is missing for a tool whose
name ends with a digit, and a script exists for a tool with the same
name without that digit, we try to use that instead, and we make
sure it does support the named variant or bail out later...

>  		setup_user_tool
>  		return $?
>  	fi
>  
> -	# Load the redefined functions
> -	. "$MERGE_TOOLS_DIR/$tool"
>  	# Now let the user override the default command for the tool.  If
>  	# they have not done so then this will return 1 which we ignore.
>  	setup_user_tool
>  
> +	if ! list_tool_variants | grep -q "^$tool$"
> +	then
> +		return 1
> +	fi

... like this.  Excellent.
