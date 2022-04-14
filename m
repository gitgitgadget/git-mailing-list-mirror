Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6923C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 08:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiDNIDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 04:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiDNIDM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 04:03:12 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C2740A38
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:00:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p135so4576744iod.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sReVga0zpk5AUvGCoCn5LVMSPk7V8J1bJsqoQW7k8ew=;
        b=RBV9GRVjEd6FRRKZH4Od8Ow+Z5PJ40/FDkOrqyUuo3EJcKtkLXyx8J+9THPwLjGHJB
         UuPaym4eiKgE6QmLZCVxiC0xt2B9F31PslFGpyaYEbg7Bncfx2Lfq1yVkvmbpiflOMXC
         eR0MsZjsCLsHy6c3Ll0MUTgT1zrW4qhvg4y8TejXAa7zz6BJ+Uw1vMNfuVW9oZk5JlJf
         vnR95OJLyI1OprYtaxF1bcd2kGJRIm2P74xlSCWokQ88LrahNZbogvh/Q8B3eMYqX5Lv
         ZiCVnMLPnklzAFIRJECUQcUiexByr/FhULEJnW5CvSOOItJsYgIYnswUAwxHxo93boOZ
         3ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sReVga0zpk5AUvGCoCn5LVMSPk7V8J1bJsqoQW7k8ew=;
        b=V5TxxxjgzgdHRT+3ixMOEHdNccpoS55Y8FweOOUzsSm/mI9O66GvP6GK+tc2QAXSYq
         lIwCAgVTd3rqKUsnX7+wbCAwUTnb7Vs1NJs1iOLLF6lUVOpxjBKvhXOwgrTjFBXOPEX/
         8yIQe+nJKIe1X9vJrFgJix83D0czace7ommLEnn131cX9RZMDwYrKIoH9THaPkA8UiwJ
         XFTrbNNS+/7/LVhLBssalNseWiVXsoTdoVlroMV/ONOhWSbaay+MadvckUm6zA4kI9EL
         TI6IlW3dWw+62ELo8B2wkiZRFjzoN35thHtG1XilQY+9Z4ML9ktKwyKlWiH1UEKECcN/
         k+og==
X-Gm-Message-State: AOAM533yoWE1K4xUywlD/vbdT1nwMWUH7F8CgTxNwfP8EBH/IVadxpQP
        y+/fAxthE7/iJjvrWs3ChNM=
X-Google-Smtp-Source: ABdhPJzUVy5rRz71N1LKNigmfVFOhwEzr0lqyhhJwPZAnw3atYy2TmdFL0P3yI9eq5GskaSBxE3d3A==
X-Received: by 2002:a05:6638:2386:b0:326:4047:9648 with SMTP id q6-20020a056638238600b0032640479648mr733846jat.120.1649923247890;
        Thu, 14 Apr 2022 01:00:47 -0700 (PDT)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id 12-20020a92190c000000b002ca07342072sm684545ilz.50.2022.04.14.01.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 01:00:47 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <214f8670-91d5-f4b6-efa1-76966c3ab1ee@sunshineco.com>
Date:   Thu, 14 Apr 2022 04:00:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v3 29/29] CI: make it easy to use ci/*.sh outside of CI
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <patch-v3-29.29-2e3c02fa0df-20220413T194847Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <patch-v3-29.29-2e3c02fa0df-20220413T194847Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/22 3:51 PM, Ævar Arnfjörð Bjarmason wrote:
 > In preceding commits the ci/.sh scripts have lost most of their
 > CI-specific assumptions. Let's go even further and explicitly support
 > running ci/lib.sh outside of CI.
 >
 > This was possible before by faking up enough CI-specific variables,
 > but as shown in the new "help" output being added here using the
 > ci/lib.sh to provide "CI-like" has now become trivial.
 >
 > The ci/print-test-failures.sh scripts can now be used outside of CI as
 > well, the only GitHub CI-specific part is now guarded by a check that
 > we'll pass if outside of GitHub CI.
 >
 > There's also a special-case here to not clobber $MAKEFLAGS in the
 > environment if we're outside of CI, in case the user has e.g. "jN" or
 > other flags to "make" that they'd prefer configured already.
 >
 > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
 > ---
 > diff --git a/ci/lib.sh b/ci/lib.sh
 > @@ -1,6 +1,30 @@
 > +#  Usage
 > +CI_TYPE_HELP_COMMANDS='
 > +	# run "make all test" like the "linux-leaks" job
 > +	(eval $(jobname=linux-leaks ci/lib.sh --all) && make test)
 > +
 > +	# run "make all test" like the "linux-musl" job
 > +	(eval $(jobname=linux-musl ci/lib.sh --all) && make test)
 > +
 > +	# run "make test" like the "linux-TEST-vars" job (uses various 
GIT_TEST_* modes)
 > +	make && (eval $(jobname=linux-TEST-vars ci/lib.sh --test) && make test)
 > +
 > +	# run "make test" like the "linux-sha256" job
 > +	make && (eval $(jobname=linux-sha256 ci/lib.sh --test) && make test)
 > +'
 > +
 > +CI_TYPE_HELP="
 > +running $0 outside of CI? You can use ci/lib.sh to set up your
 > +environment like a given CI job. E.g.:
 > +$CI_TYPE_HELP_COMMANDS
 > +
 > +note that some of these (e.g. the linux-musl one) may not work as
 > +expected due to the CI job configuring a platform that may not match
 > +yours."
 > +
 > @@ -9,6 +33,10 @@ mode=$1
 >   if test -z "$mode"
 >   then
 >   	echo "need a $0 mode, e.g. --build or --test" >&2
 > +	if test -z "$CI_TYPE"
 > +	then
 > +		echo "$CI_TYPE_HELP" >&2
 > +	fi
 >   	exit 1
 >   fi

It would never occur to me to try running a script named ci/lib.sh in
the first place, and I'm not sure I would even think to poke around in
the `ci` directory with the idea of being able to run CI tasks
locally. Would it make sense to aid discovery by mentioning this new
feature in the "GitHub CI" section of SubmittingPatches as a follow up
to this series? (If so, perhaps the "GitHub CI" section should be
renamed to "CI".)

 > @@ -76,10 +108,29 @@ CC_PACKAGE=
 >   # How many jobs to run in parallel?
 >   NPROC=10
 > +case "$CI_TYPE" in
 > +'')
 > +	if command -v nproc >/dev/null

You need to redirect stderr too in order to avoid a scary error
message on platforms lacking `nproc`:

     if command -v nproc >/dev/null 2>&1

 > +	then
 > +		NPROC=$(nproc)
 > +	else
 > +		NPROC=1
 > +	fi

Neither macOS nor BSD has an `nproc` command, however, they do have
`sysctl`:

     elif command -v sysctl >/dev/null 2>&1
     then # macOS & BSD
         NPROC=$(sysctl -n hw.ncpu 2>/dev/null)

and Windows provides a suitable environment variable:

     elif test -n "$NUMBER_OF_PROCESSORS"
     then # Windows
         NPROC="$NUMBER_OF_PROCESSORS"

 > +	if test -n "$MAKEFLAGS"
 > +	then
 > +		COMMON_MAKEFLAGS="$MAKEFLAGS"
 > +	else
 > +		COMMON_MAKEFLAGS=--jobs=$NPROC
 > +	fi
 > +	;;

