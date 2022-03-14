Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735EAC43217
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 08:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiCNIIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbiCNII1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 04:08:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C226551
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:07:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y8so13527537edl.9
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/kpYNR/JW8JmJZAS2r0MOLCNkaiEdhqTtSmvQu1E1EU=;
        b=fkR5VY9gVpn3ANdsD8QdxBlhRLeErFcJq6PX2MMXHEiLnBVr2QIvXDwXo35l2N0KAE
         p0gUMAPY+nAu6EajRnH4fu+9zHF1UHnc0Ns6B63MrpgUqhIXAccn7jtW6TvXWJ2EPFtO
         oDDeUe4SneuyeBaWE9rbR6hiu8y5rtvI/pBsFzAwN9kPshXJrqpddnfLCAONqGdvxQWK
         RIwFwBLiUk07yVegmoz/v5mv/AbIwhOPuagpXRK5tZYT+D1/pY/dXj8nXTmOsf3VORYn
         XHq5NWkS8bKHwa0ItzwQwbxtBdAk7tkv+JzeZSgfB8UJzbuw6WpiyNDbmDpu6BWS0r1n
         0yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/kpYNR/JW8JmJZAS2r0MOLCNkaiEdhqTtSmvQu1E1EU=;
        b=Qd6AC59ga5j5E/wFg/hMleq2Q14u+bEKDOXnm11QhiVYJSIIH+0C2v7m27Z/qMGLE7
         7xeuHIcoaNQ4vPMQPVOaQhH2TYTiux4JD1e58NBzm0HIhF4Fu7/003KgTVFsqTZVyu9r
         /fiokMRBT+BhIs/PP2JiVUdGfCHBSepzThkAzd8nwl8xLboureyZdK4ezW0SDsy7Z+9x
         ZQUVnt+AKQ6e18GMlsdQeOXbjW9rBbrzOLxu4irqX174Co82/n/blYMi4ErEmVV36SD3
         3TQydrWwVAjtNOgTZ4Hkuzb6qJniydGSIJu2fulYrNFMfB1wenyo/PiXlbf4NX4WsG2q
         BrNw==
X-Gm-Message-State: AOAM533uhQ+wFT4i+yjW4hBRrJJjnMPKRJUg6djtVs6eGedVlLB+X0Ot
        NMEByUXzsj7PQbRcUZ3E3+GYdCfzk1g=
X-Google-Smtp-Source: ABdhPJxrMfX7DvgVsHDnM1yzIuVJTajltmv1+FHxBw4cfQ3FWDRenCOTD1gm/mj/doaPf/wkEQ1tDw==
X-Received: by 2002:a05:6402:40c4:b0:416:3e66:1825 with SMTP id z4-20020a05640240c400b004163e661825mr19318632edb.284.1647245237055;
        Mon, 14 Mar 2022 01:07:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm6401877ejb.82.2022.03.14.01.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:07:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nTfjX-000JC7-RR;
        Mon, 14 Mar 2022 09:07:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 08/16] t7527: add parameters to start_daemon to handle
 args and subshell
Date:   Mon, 14 Mar 2022 09:03:36 +0100
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
 <6693900600f5b27525dfe7de78e73900306e0ab5.1647033303.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <6693900600f5b27525dfe7de78e73900306e0ab5.1647033303.git.gitgitgadget@gmail.com>
Message-ID: <220314.8635jlez4c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 11 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> fixup! t7527: create test for fsmonitor--daemon
>
> Add parameters to start_daemon() and handle subshell and logging args.
>
> Remove /dev/null from commands.
>
> Fix &&-chaining of functions.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/t7527-builtin-fsmonitor.sh | 217 ++++++++++++++++++-----------------
>  1 file changed, 111 insertions(+), 106 deletions(-)
>
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 0ccbfb9616f..026382a0d86 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -11,30 +11,85 @@ then
>  fi
>  
>  stop_daemon_delete_repo () {
> -	r=$1
> -	git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null
> +	r=$1 &&
> +	test_might_fail git -C $r fsmonitor--daemon stop &&
>  	rm -rf $1
> -	return 0
>  }
>  
>  start_daemon () {
> -	case "$#" in
> -		1) r="-C $1";;
> -		*) r="";
> -	esac
> +	r="" &&
> +	tf="" &&
> +	t2="" &&
> +	tk="" &&

We usually just do : 

	x= &&

Not:

	x="" &&

I.e. no need for the "".

>  
> -	git $r fsmonitor--daemon start || return $?
> -	git $r fsmonitor--daemon status || return $?
> +	while test "$#" -ne 0
> +	do
> +		case "$1" in
> +		-C)
> +			shift;
> +			test "$#" -ne 0 ||
> +				{ echo >&2 "error: -C requires arg"; exit 1; }

IMO this exhaustive checking is better just skipped, we e.g.don't do
this in "test_commit". Can't you just...

> +			r="-C $1"
> +			shift

...properly &&-chain these whole things and have the "shift too many"
and exit code from "shift" catch this?

> +			;;
> +		-tf)
> +			shift;
> +			test "$#" -ne 0 ||
> +				{ echo >&2 "error: -tf requires arg"; exit 1; }
> +			tf="$1"
> +			shift
> +			;;
> +		-t2)
> +			shift;
> +			test "$#" -ne 0 ||
> +				{ echo >&2 "error: -t2 requires arg"; exit 1; }
> +			t2="$1"
> +			shift
> +			;;
> +		-tk)
> +			shift;
> +			test "$#" -ne 0 ||
> +				{ echo >&2 "error: -tk requires arg"; exit 1; }
> +			tk="$1"
> +			shift
> +			;;
> +		*)

ditto.

> +			echo >&2 "error: unknown option: '$1'"
> +			exit 1

But this sort of case is needed, but should use BUG "..."

> +			;;
> +		esac
> +	done &&
> +
> +	(
> +		if test ! -z "$tf"

Instead of "! -z x" use "-n x" ?

> +		then
> +			GIT_TRACE_FSMONITOR="$tf"
> +			export GIT_TRACE_FSMONITOR
> +		fi &&
> +
> +		if test ! -z "$t2"
> +		then
> +			GIT_TRACE2_PERF="$t2"
> +			export GIT_TRACE2_PERF
> +		fi &&
> +
> +		if test ! -z "$tk"

ditto.

> +		then
> +			GIT_TEST_FSMONITOR_TOKEN="$tk"
> +			export GIT_TEST_FSMONITOR_TOKEN

> +		fi &&
> -	touch test_flush/file_1 &&
> -	touch test_flush/file_2 &&
> +	> test_flush/file_1 &&
> +	> test_flush/file_2 &&

style: ">x" not "> x" (ditto below).
