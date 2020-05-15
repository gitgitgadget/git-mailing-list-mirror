Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EB5C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0179D20728
	for <git@archiver.kernel.org>; Fri, 15 May 2020 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOhvTqzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgEOTEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOTEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 15:04:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F00CC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 12:04:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so4734306wrn.6
        for <git@vger.kernel.org>; Fri, 15 May 2020 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ky+aXZ1uIsoTztzhOh/G3pVtuHcNh1CRRM62ViwC4xA=;
        b=cOhvTqzK6NYKoY/ZYFNEGJyDVgh21PgOL4DYSL1iMpiHUBz84xPpi9lRpmTB/Ei5BQ
         WA6lTjUIR26naRTOvEO759wU9g9geq4UzLNVsyz1Fx/oXOrmIyvM1wU1O+fqfjGYW3tA
         FleP7Uc3yizEPxM4a942K2V1KXAj/5cvsC8xWp9vP+PVF5xHXlbda2QU5o+iw4uW4sN1
         +n8L8bqUekhrRweOjP+UGP2WBGlWwm7bbuVQaooCBMfVf3TROn74BM5P8o09pwayBw8c
         XBcn78J9spjb7QInTI31mYZ/tJMUxwfLIScX+lJ8l0S9gqi0fRPYP2gkG6wDhLR+EMvd
         uadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ky+aXZ1uIsoTztzhOh/G3pVtuHcNh1CRRM62ViwC4xA=;
        b=MtRF5H77+OTKp0Dm6iUa9RCd8rw6nl/juBWWzlQFOObcIQljMNOQnaUbDSm2tFF47S
         xes2e8X1XUcKiSmCBHSGdjQD34cAbX4S4O99b5VBK7GqLk/bbJd91x1iIJnVfrjIixE/
         PmmeWOmvGTd6T/DkSi5NNEaAOwn4QznnqUMvV90+SmGYHYIUkBdV9iJLBvWB/IaGfKQw
         1CLq/G/EYyoHIX2lu40HEVEE3zpBd+lbnILrqpguiHJvvWGrvlu8LZF5ojzEcSVmgN/v
         LvgEOfKGxoB2jzN+DmbfXv2SGgBR2n/cD63bDT61Um41m/eI8s5Ejrjtz6o77trqPJ2I
         8+Ew==
X-Gm-Message-State: AOAM531/avqGKm1wSAQE7YLVvtaJebFZ9EBwh5h1JR5JbZL4BZ4GO24Z
        n6/PfTRhuU1ICjs0rpXW44y4V3cA
X-Google-Smtp-Source: ABdhPJwdMx+AomcTjdyRdr/meyVjSposNi0v5N0+XJ+zVYDXLZD91b49tjumulec6RSkf25mm5sU6Q==
X-Received: by 2002:adf:e38e:: with SMTP id e14mr6030591wrm.2.1589569478240;
        Fri, 15 May 2020 12:04:38 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-314-129.w86-199.abo.wanadoo.fr. [86.199.201.129])
        by smtp.gmail.com with ESMTPSA id p9sm4929568wrj.29.2020.05.15.12.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 12:04:37 -0700 (PDT)
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     congdanhqx@gmail.com, johannes.schindelin@gmx.de
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
 <20200515150041.22873-1-carenas@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <b70e0c9d-dbea-1c72-4235-cf24b6678be6@gmail.com>
Date:   Fri, 15 May 2020 21:04:36 +0200
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

I missed this earlier but this regex is invalid; the last parenthesis in
unmatched.

Alban

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
>  			esac
>  		done
>  	'
> @@ -734,7 +734,7 @@ test_failure_ () {
>  		write_junit_xml_testcase "$1" "      $junit_insert"
>  	fi
>  	test_failure=$(($test_failure + 1))
> -	say_color error "$(file_lineno error)not ok $test_count - $1"
> +	say_color error "not ok $test_count - $1$(file_lineno error)"
>  	shift
>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
>  	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
> 

