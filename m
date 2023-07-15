Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B188EB64DC
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 08:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGOI7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGOI73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 04:59:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4762D66
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 01:59:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso2879437f8f.3
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 01:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689411566; x=1692003566;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jVzDpPzXMTKp3Aa8vipAh6H4F7O8UB9k2aHYeoVs9y8=;
        b=ORpNs+vrvPVyK9orxtB+BV9i+rWqS6vO4ZIX6ncMMft9HjPRzt/unV4UhDIeuRAtE8
         U1ot/g6CtYNrWYoOZws98qxo9rFLbW1k7sdT3gBV0Wii3uNPJZqN3J/i+8dj13x8avOc
         QIZDQ01VtHlFQvZI8IClX2wqJkM3YYuXMEsFtsLwnN6sCLX1guMPL7NN2RtH2Xb4YYCb
         dk9m/oIopbmQ54qilBZjJbEy+iwFVDZx8WYdi/sCKMPftP3QLDy5IwR84DZsaJ7QQM56
         +PxuqJf70I5vtmJCpxvmtp98Nj+uD9l4Xc7GggtTMw++mMeoaLFLj0YNGiDoYW6R3GRD
         50Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689411566; x=1692003566;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVzDpPzXMTKp3Aa8vipAh6H4F7O8UB9k2aHYeoVs9y8=;
        b=dG5q4/CnVG7S22mTc4Hk+DfY9z0NVYrdbaZsnMl3zHitmdoZudDaLVvnefuypv/6Jj
         HEC0MJJg36AIamyzm+kAehTpRM3E6YT57pSR2P1Nj6236852zXalquM6CzKDboe9/wGA
         u5VgOYYii/vt3WoBLtqlSiZLU8+GD9UeOjpMFlgM3IDSokrjBI0ex6At0gXBCQN3hOpt
         lLpS8PWfJ9wTJibm2PHAP6bdeoF/mcgcLzpDUaYaQS0xD+EkAvaiYyE0dsnP38oAF/SY
         JekCm1++VL0i9p7oRl8nQdKnSkfqtH9QmBKynqJK8qnYmZo8QN+WhhB07CjxPczu0b63
         9HOw==
X-Gm-Message-State: ABy/qLbHjvUMCKmMqY5/pfucvX+5Sk4bn275EGkuphyoZaAtsNMfbc6Y
        QyaM+1eoQMXGyK5vNZ93Plc6aEVisyGnOw==
X-Google-Smtp-Source: APBJJlE1hcZyMMwUCCV9RnNQBUqd7bT9RnOEgQ+V7n+hFiKdkS2G6cnhtVepQ+jp66+CWbutAoAJ0A==
X-Received: by 2002:a5d:5706:0:b0:314:46af:e1e7 with SMTP id a6-20020a5d5706000000b0031446afe1e7mr7555680wrv.34.1689411565380;
        Sat, 15 Jul 2023 01:59:25 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b003159d2dabbasm13125615wrr.94.2023.07.15.01.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 01:59:24 -0700 (PDT)
Message-ID: <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
Date:   Sat, 15 Jul 2023 09:59:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230715025512.7574-1-jacobabel@nullpo.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jocab

On 15/07/2023 03:55, Jacob Abel wrote:
> Replace all cases of `\s` with `[[:space:]]` as older versions of GNU
> grep (and from what it seems most versions of BSD grep) do not handle
> `\s`.
>
> For the same reason all cases of `\S` are replaced with `[^[:space:]]`.
> Replacing `\S` also needs to occur as `\S` is technically PCRE and not
> part of ERE even though most modern versions of grep accept it as ERE.

Thanks for working on this fix. Having looked at the changes I think it 
would be better just be using a space character in a lot of these 
expressions - see below.

> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
> This patch is in response to build failures on GGG's Cirrus CI
> freebsd_12 build jobs[1] and was prompted by a discussion thread [2].
> 
> These failures seem to be caused by the behavior outlined in [3].
> Weirdly however they only seem to occur on the FreeBSD CI but not the
> Mac OS CI for some reason despite Mac OS using FreeBSD grep.
> 
> 1. https://github.com/gitgitgadget/git/pull/1550/checks?check_run_id=14949695859
> 2. https://lore.kernel.org/git/CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com/
> 3. https://stackoverflow.com/questions/4233159/grep-regex-whitespace-behavior
> 
>   t/t2400-worktree-add.sh | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 0ac468e69e..7f19bdabff 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -417,9 +417,9 @@ test_wt_add_orphan_hint () {
>   		grep "hint: If you meant to create a worktree containing a new orphan branch" actual &&
>   		if [ $use_branch -eq 1 ]
>   		then
> -			grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" actual
> +			grep -E "^hint:[[:space:]]+git worktree add --orphan -b [^[:space:]]+ [^[:space:]]+[[:space:]]*$" actual

We know that "hint:" is followed by a single space and all we're really 
interested in is that we print something after the "-b " so we can 
simplify this to

	grep "^hint: git worktree add --orphan -b [^ ]"

I think the same applies to most of the other expressions changed in 
this patch.

>   		else
> -			grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
> +			grep -E "^hint:[[:space:]]+git worktree add --orphan [^[:space:]]+[[:space:]]*$" actual
>   		fi
>   
>   	'
> @@ -709,7 +709,7 @@ test_dwim_orphan () {
>   	local info_text="No possible source branch, inferring '--orphan'" &&
>   	local fetch_error_text="fatal: No local or remote refs exist despite at least one remote" &&
>   	local orphan_hint="hint: If you meant to create a worktree containing a new orphan branch" &&
> -	local invalid_ref_regex="^fatal: invalid reference:\s\+.*" &&
> +	local invalid_ref_regex="^fatal: invalid reference:[[:space:]]\+.*" &&
>   	local bad_combo_regex="^fatal: '[a-z-]\+' and '[a-z-]\+' cannot be used together" &&
>   
>   	local git_ns="repo" &&
> @@ -998,8 +998,8 @@ test_dwim_orphan () {
>   					headpath=$(git $dashc_args rev-parse --sq --path-format=absolute --git-path HEAD) &&

I'm a bit confused by the --sq here - why does it need to be shell 
quoted when it is always used inside double quotes? Also when the 
reftable backend is used I'm not sure that HEAD is actually a file in 
$GIT_DIR anymore (that's less of an issue at the moment as that backend 
is not is use yet).

>   					headcontents=$(cat "$headpath") &&
>   					grep "HEAD points to an invalid (or orphaned) reference" actual &&
> -					grep "HEAD path:\s*.$headpath." actual &&
> -					grep "HEAD contents:\s*.$headcontents." actual &&
> +					grep "HEAD path:[[:space:]]*.$headpath." actual &&
> +					grep "HEAD contents:[[:space:]]*.$headcontents." actual &&

Using grep like this makes it harder to debug test failures as one has 
to run the test with "-x" in order to try and figure out which grep 
actually failed. I think here we can replace the sequence of "grep"s 
with "test_cmp"

	cat >expect <<-EOF &&
	HEAD points to an invalid (or orphaned) reference
	HEAD path: $headpath
	HEAD contents: $headcontents
	EOF

	test_cmp expect actual

Best Wishes

Phillip

>   					grep "$orphan_hint" actual &&
>   					! grep "$info_text" actual
>   				fi &&
> 
> base-commit: 830b4a04c45bf0a6db26defe02ed1f490acd18ee
