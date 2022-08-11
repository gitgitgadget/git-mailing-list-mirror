Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27D3C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 11:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiHKL0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiHKL0c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 07:26:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E2E0D5
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:26:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k26so32976098ejx.5
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=cQUoalNn94dlZG4jfvRKgE3Xd/mIFNnP4nkwg0q7KD4=;
        b=CJfwiC9ij3bETt0yEe5DVqwF4tPDvyt+u2sd4v3GeV7P+PCo9C6+X6zsB1NU1vL0wW
         utrGcbyyOCaJE98Tj1u9G+cmBTXRSmGBR1He9PhE7g60S/gU7p3Ym0vb8KUG/xk7S0HR
         DXNo9vfelJ/zNUv24adaubFjyD39SwqKtxPDywS6PcPozMohFjg9idaJ+gs9ubPz/SVQ
         GLzerzwDK0LHv3OK4npujzhgTP0tCaZbFrqz1N+c7pi9a5gY5et6J/7aUvBRqOstevU1
         ZWyxHJ05G6AlSlO2FiGVDTfFF0SrD1Aq8P/aCZRmVJb/FNDYBTXEj01+tTdTgFaZ77B9
         2hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cQUoalNn94dlZG4jfvRKgE3Xd/mIFNnP4nkwg0q7KD4=;
        b=zmcEHpO6iTE6cTlfZIkUWD0EQVHYPHhFZDu+1K2A/jwvz1i5p56A2yGpPQfqGSLp+e
         EShh+ZJOCPLAOqASaDcZg6GR8+ya2q+46jfMnsuFRc2stRTm1D3+5P7TcR3+xgKITFex
         qc1WFGexUXAN58TrCgPJBrjM/Q28crakxO8lCWNoIIfu5bTPSRDedgIPpaCuHOr5UFfP
         CeZHDeV4q+yb3Ux1NeQwunqUIFdi7xc4IhfZVxWAtWVGPIRam8ArM1e1zIjlPaEEygAB
         ux57BJXzagw4CXskDx4LPw319B3bH5kcJrQ1cSEkXjUzFrkYxNJrr71DYa7pOW4UyMRM
         flVA==
X-Gm-Message-State: ACgBeo2zamKIoNinfiIvDhFrdSQArwubXgrE2C3FCouZloBt4NMAgU2J
        /ahJ08H1y5CkmkAr0DAqe2o=
X-Google-Smtp-Source: AA6agR76Op1d92lXhOWY6gFztdKKBZYGpk8iAgyf3gTqxaeg2208NNEeHxcA5vbpHsDPLvTh2htupA==
X-Received: by 2002:a17:906:dc89:b0:731:67eb:b60b with SMTP id cs9-20020a170906dc8900b0073167ebb60bmr12012492ejc.614.1660217188838;
        Thu, 11 Aug 2022 04:26:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906210a00b00715a02874acsm3390935ejt.35.2022.08.11.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:26:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM6KZ-001Bou-2W;
        Thu, 11 Aug 2022 13:26:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] tests: explicitly skip `chmod` calls on Windows
Date:   Thu, 11 Aug 2022 13:22:17 +0200
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <79abfa82c32ea686469cfe2417bc491c04179623.1660143750.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <79abfa82c32ea686469cfe2417bc491c04179623.1660143750.git.gitgitgadget@gmail.com>
Message-ID: <220811.86wnbfowbg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 10 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> However, this quirk is only in effect as long as `chmod` is run inside
> the pseudo Unix root directory structure or within the home directory.
> When run outside, such invocations fail like this:
>
> 	chmod: changing permissions of '<file>': Invalid argument

..ok, but...

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 6da7273f1d5..7c63b22acab 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -492,7 +492,10 @@ test_commit_bulk () {
>  # of a file in the working directory and add it to the index.
>  
>  test_chmod () {
> -	chmod "$@" &&
> +	if test_have_prereq !MINGW
> +	then
> +		chmod "$@"
> +	fi &&
>  	git update-index --add "--chmod=$@"
>  }
>  
> @@ -548,7 +551,10 @@ write_script () {
>  		echo "#!${2-"$SHELL_PATH"}" &&
>  		cat
>  	} >"$1" &&
> -	chmod +x "$1"
> +	if test_have_prereq !MINGW
> +	then
> +		chmod +x "$1"
> +	fi

... you get +x semantics by default, so we didn't need that "chmod +x"
in the first place?

The rest of "test_chmod" seems to *happen to* pass +x or -x, but we
don't care about that, regardless of the "pseudo Unix root directory"?

What if we get a "test_chmod -o <file>", won't this silently do the
wrong thing?

If so isn't something in this direction (untested) a more targeted &
obvious fix?:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 10258def7be..1c3b6692388 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1690,6 +1690,16 @@ case $uname_s in
 	find () {
 		/usr/bin/find "$@"
 	}
+	chmod () {
+		case "$1" in
+		+x|-x)
+			return;
+			;;
+		*)
+			;;
+		esac &&
+		/usr/bin/chmod "$@"
+	}
 	# git sees Windows-style pwd
 	pwd () {
 		builtin pwd -W
