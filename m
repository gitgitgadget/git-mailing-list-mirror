Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F9C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B88207BB
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGrqWRwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEOPi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726228AbgEOPiZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 11:38:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5CC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:38:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z4so1599143wmi.2
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+CNNHGxZLGRjNBiWlzEQDZB1/bioENJR82usPSuGv6w=;
        b=mGrqWRwqJGwQABID2INQCodERQUSD3es1t4+r6PDm1w53xCViftWJ6XzUB3ErmBTPT
         ZCi592VX/lKaUNHWMUsBQ0xf4Owm+7Q2IFpguov17o5t5k/93UsbUyTPFeKsgUef1ZXy
         B4XIMYSC71X2BfYkRG50TTqH7VHLAzjJCAdpSiFTrg2c1wTuwvfjkxwhoimcxNe43pT1
         PyPi39rXs7kVJWkmSUAdNdjDBrfh76Bn+HbbGFGfKDbV6vV8vI0JJyvDMPnPGbLex0KA
         pYaI2ogg7+gFFSpzpHRXL/DkGXmRecVOg3LuYYyLV94lcPDLXzk0ZSz6Q2S9hhs7lVPk
         vDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+CNNHGxZLGRjNBiWlzEQDZB1/bioENJR82usPSuGv6w=;
        b=BHaq6gOK0BFrvW/JBBPF6XqTQNqIJZEkPhWOA26Ba1fo0RKiJsaLMl9YkR9Fi3y76v
         nTZ43+W4qY2te1vxnj3Z5ljk2NEYMiLaVtyXfq+qC3TyZeMc+IanGo9dLDW/latEYk+M
         wKLsbxslbzYrINqp+QfSlX8oVimYZ7pNm3JNQwvEkqly+96R9Y0vvS9sqzlncjumJlPT
         /G2vBxCpgWGBdq1xNCanGtY0HmCcA8b/ktAzsXLnCgHqhqZe8Xpe5Yh5Ha2MQUx3Y4jG
         cclueLd+wwX/JGrM6KnAeDNgwi1Jb4fOBJ9M7bQarYKzpD8PsigxB1ubSvv89oPxfN4X
         qpMg==
X-Gm-Message-State: AOAM53298zj6/3FnYUcvhEZoptzi2Qn3T0B9sZjjrATKWSI9HMHSBZyX
        GWvvNYyyo+YbQ1Uf2ppgQ5Q=
X-Google-Smtp-Source: ABdhPJyKY7/V0z/rZdcm6Qf/sw32436wZJ8sCngP+XefZ6u4XZfcZ9L9kX3umIsVHrGBE2agFwzGWA==
X-Received: by 2002:a1c:ac44:: with SMTP id v65mr4660830wme.33.1589557103908;
        Fri, 15 May 2020 08:38:23 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-314-129.w86-199.abo.wanadoo.fr. [86.199.201.129])
        by smtp.gmail.com with ESMTPSA id m65sm4179999wmm.17.2020.05.15.08.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:38:23 -0700 (PDT)
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     congdanhqx@gmail.com, johannes.schindelin@gmx.de
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
 <20200515150041.22873-1-carenas@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <880ded78-21c6-9310-6c5e-422f6a63ad47@gmail.com>
Date:   Fri, 15 May 2020 17:38:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200515150041.22873-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 15/05/2020 à 17:00, Carlo Marcelo Arenas Belón a écrit :
> 662f9cf154 (tests: when run in Bash, annotate test failures with file
> name/line number, 2020-04-11) adds metadata to the TAP output to help
> identify the location of the failed test, but does it in a way that
> break the TAP format and therefore confuses prove.
> 
> Move the metadata to the description to workaround the issue and
> change the regex from 676eb0c1ce (ci: add a problem matcher for GitHub
> Actions, 2020-04-11) to match.
> 
> Reported-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  ci/git-problem-matcher.json | 10 +++++-----
>  t/test-lib.sh               |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/ci/git-problem-matcher.json b/ci/git-problem-matcher.json
> index 506dfbd97f..e10e88bba1 100644
> --- a/ci/git-problem-matcher.json
> +++ b/ci/git-problem-matcher.json
> @@ -4,11 +4,11 @@
>              "owner": "git-test-suite",
>              "pattern": [
>                  {
> -                    "regexp": "^([^ :]+\\.sh):(\\d+): (error|warning|info):\\s+(.*)$",
> -                    "file": 1,
> -                    "line": 2,
> -                    "severity": 3,
> -                    "message": 4
> +                    "regexp": "^(.*)(error|warning|info):\\([^ :]+\\.sh):(\\d+)\\)$",
> +                    "file": 3,
> +                    "line": 4,
> +                    "severity": 2,
> +                    "message": 1
>                  }
>              ]
>          }
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index baf94546da..d5f59ab3bf 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -682,8 +682,8 @@ file_lineno () {
>  		for i in ${!BASH_SOURCE[*]}
>  		do
>  			case $i,"${BASH_SOURCE[$i]##*/}" in
> -			0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
> -			*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
> +			0,t[0-9]*.sh) echo "(${1+$1:}t/${BASH_SOURCE[$i]}:$LINENO)"; return;;
> +			*,t[0-9]*.sh) echo "(${1+$1:}t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]})"; return;;

Could you add a space after the "error:"/"warn:"/"info:"?

>  			esac
>  		done
>  	'
> @@ -734,7 +734,7 @@ test_failure_ () {
>  		write_junit_xml_testcase "$1" "      $junit_insert"
>  	fi
>  	test_failure=$(($test_failure + 1))
> -	say_color error "$(file_lineno error)not ok $test_count - $1"
> +	say_color error "not ok $test_count - $1$(file_lineno error)"

Could you add a space before `$(file_lineno error)'?

>  	shift
>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
>  	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
> 

Thinking about it, I think it would make sense to put this kind of
information in a diagnostic line, as we already do for the code of a
failed test.

Instead of this:

> not ok 1 - plain(error:t/./t0001-init.sh:33)
> #
> #               false &&
> #               git init plain &&
> #               check_config plain/.git false unset
> #

Something like this:

> not ok 1 - plain
> # (error:t/./t0001-init.sh:33)
> #
> #               false &&
> #               git init plain &&
> #               check_config plain/.git false unset
> #

Cheers,
Alban

