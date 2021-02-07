Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F3EC433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BDD64DE7
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBGSau (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:30:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58488 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBGSao (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:30:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE3CE113242;
        Sun,  7 Feb 2021 13:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QbxT8mFCgfuz
        RjGIH/NACejaubQ=; b=rK7XxnJf1lrtiOIwEuvAu/dvyLnuibNfVEDgwkrOkpl5
        mxB9OEU3ftRFTUnUkM1uzXAYkj0p1C0XY73T7CixZ08G2U02tjEVcFD/rWLevBPS
        +AYaX4RKbDh2m/pED7NkL1Ir0oGc7kylgvFE5YfYFINTgmZUsL7dHiXEeKt5tGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UHqon2
        WeMdNmR7KArk/ulYzaGZTSxcj3j+o5gLQjEuYQwYZyJFyq4gL/bglUHOQ6dZse+n
        ukG8OQ2Z0h+orjQ1EWvZB89fPhJPcszILrlR8sC9rr5AA8eDIK1jGHwIyyEedxoc
        TVc8HDpLQLmrAVsG2Vz8vMxUYww9F7TwepBo4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A63F4113240;
        Sun,  7 Feb 2021 13:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8DA2811323F;
        Sun,  7 Feb 2021 13:29:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
Subject: Re: [PATCH] git-difftool-helper.sh: learn a new way skip to save point
References: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
Date:   Sun, 07 Feb 2021 10:29:54 -0800
In-Reply-To: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
 (=?utf-8?B?IumYv+W+t+eDiA==?= via
        GitGitGadget"'s message of "Sun, 07 Feb 2021 15:19:13 +0000")
Message-ID: <xmqqczxb91el.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A6B2E50-6972-11EB-B610-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget"  <gitgitgadget@gmail.com> =
writes:

> From: ZheNing Hu <adlternative@gmail.com>

I am a bit confused.  Are =E8=83=A1=E5=93=B2=E5=AE=81 and =E9=98=BF=E5=BE=
=B7=E7=83=88 and ZeNing Hu all the
same person (I am asking that an earlier question came under the
name first listed in this sentence, and the patch uses the latter
two names, where I guess )?

>
> `git difftool` only allow us to select file to view In turn.
> If there is a commit with many files and we exit in search,
> We will have to traverse list again to get the file diff which
> we want to see.Therefore,here is a new method:every time before
> we view the file diff,the current coordinates will be stored in
> `GIT_DIR/difftool_skip_to`,this file will be deleted after
> successful traversing.But if an unexpected exit occurred midway,
> git will view the coordinates in the save point,ask user if they
> want continue from the last saved point.This will improve the
> user experience.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     git-difftool-helper.sh: learn a new way skip to save point
>    =20
>     this patch's origin discuss is here:
>     https://lore.kernel.org/git/gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKf=
r5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=3D@r=
tzoeller.com/
>    =20
>     git user may should travel the diff list to choice file diff to vie=
w, if
>     they exit in midway,they must travel it again. I=E2=80=99m on the b=
asis of the
>     "difftool_skip_to" suggested by Junio,Provides a possibility for th=
is
>     user-friendly solution.
>    =20
>     Thanks!
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2=
Fadlternative%2Fdifftool_save_point-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlt=
ernative/difftool_save_point-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/870
>
>  git-difftool--helper.sh | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 46af3e60b718..56ec1d38a7a1 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -6,6 +6,7 @@
>  # Copyright (c) 2009, 2010 David Aguilar
> =20
>  TOOL_MODE=3Ddiff
> +GIT_DIFFTOOL_SKIP_TO_FILE=3D"$GIT_DIR/difftool-skip-to"
>  . git-mergetool--lib
> =20
>  # difftool.prompt controls the default prompt/no-prompt behavior
> @@ -40,6 +41,31 @@ launch_merge_tool () {
>  	# the user with the real $MERGED name before launching $merge_tool.
>  	if should_prompt
>  	then
> +		if test -f "$GIT_DIFFTOOL_SKIP_TO_FILE"
> +		then
> +			SAVE_POINT_NUM=3D$(cat "$GIT_DIFFTOOL_SKIP_TO_FILE")
> +			if test $SAVE_POINT_NUM -le $GIT_DIFF_PATH_TOTAL &&
> +				test $SAVE_POINT_NUM -gt $GIT_DIFF_PATH_COUNTER
> +			then
> +				# choice skip or not skip when check first file.
> +				if test $GIT_DIFF_PATH_COUNTER -eq "1"
> +				then
> +					printf "do you want to skip to last time difftool save point($SAV=
E_POINT_NUM) [Y/n]?"
> +					read skip_ans || return
> +					if test "$skip_ans" =3D y
> +					then
> +						return
> +					fi
> +				else
> +					return
> +				fi
> +			fi
> +		fi
> +		# write the current coordinates to .git/difftool-skip-to
> +		if test !$SAVE_POINT_NUM || $SAVE_POINT_NUM -ne $GIT_DIFF_PATH_COUNT=
ER
> +		then
> +			echo $GIT_DIFF_PATH_COUNTER > $GIT_DIFFTOOL_SKIP_TO_FILE
> +		fi
>  		printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
>  			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
>  		if use_ext_cmd
> @@ -102,4 +128,10 @@ else
>  	done
>  fi
> =20
> +if test -f $GIT_DIFFTOOL_SKIP_TO_FILE &&
> +	test $GIT_DIFF_PATH_COUNTER -eq $GIT_DIFF_PATH_TOTAL
> +then
> +	rm $GIT_DIFFTOOL_SKIP_TO_FILE
> +
> +fi
>  exit 0
>
> base-commit: e6362826a0409539642a5738db61827e5978e2e4
