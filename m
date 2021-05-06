Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F8C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822E8610E7
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhEFPrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbhEFPrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:47:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B69C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:46:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t2-20020a17090ae502b029015b0fbfbc50so3682893pjy.3
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yTVVNTlVGQyE1T1PHSybv+bl+MdkNDk7koEbIJQ71II=;
        b=Xhrb+Dz+mJIb1EwuCnPTwOX0RifnM3JF5NGe0NTdVywsfWMFU3YeyToha4M+XvuQVb
         +9cyWL2ObVMpDUqTmVLhQqHpBPAnADM8gwWnO0KfOVlD78QwidAD83O3EGhELFBXy22t
         AyMc6jPhihyEwyjcWvaEdeBFwB6wRYWgga9Ss6tjAK6+QTlnyKF5S65Kvx4JClWPKmjb
         rUn8Hb5LHTcgR1RYDqCGDqMI7hm9jxgnsDZT5YcFHzJ2C4hraON9EAOMxHPnfifP05pr
         3PqJSoLUwjnVTgFttGJh7alfo1rv3UC8BeHDHe8vr2/UsB4UijNuGhfBfeHtAtJqQKOw
         aX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yTVVNTlVGQyE1T1PHSybv+bl+MdkNDk7koEbIJQ71II=;
        b=GzK/pJjuYvclaetwPCqjJhpewl1yCKNGi78642s+OEQCkhGpimFswV9FzsEmjiHXcn
         XCQbR+ymeAP6t09el1Z1QBR3IwrpqEXSiQ1jeXD3meVXU53J/T+9V5XyskYHWk/KOdhG
         KBpsNB7VeNxbCgtJ0p1EUCheWs6GJGzNHDiALaL1egxqm2vPps6Cwf8xbdPAXPFGkBG1
         lKAOQKXivtilWWbWmZtZCkSpMgzLsoEXPQ0mEr3ZVSYkfil+BYiG62uTLb/CJaeKQt5o
         cpeI3EXsT5zbgM5zKL1VnbBRdIeEWTF+VmPqK+bdv6dnkz2jhHMrmNr4p6wE6sf0ERAM
         991Q==
X-Gm-Message-State: AOAM533vX54bowcrSPYhnEsQ4JeO64u6tumFZwMDNyJWkpkkRLJ7lTyv
        1/QKzTXc3UWPbseF1kq6KBF5lr0QVXg8HA==
X-Google-Smtp-Source: ABdhPJwMqpBZfH+2exxny5pPOGijd1QB766PBgwr05SMk3ONhqJRkO5k/q/f4dxRPuhu+VtMnvtB6A==
X-Received: by 2002:a17:903:2284:b029:ed:53f0:bdac with SMTP id b4-20020a1709032284b02900ed53f0bdacmr5339195plh.40.1620315997880;
        Thu, 06 May 2021 08:46:37 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id 66sm2310331pgj.9.2021.05.06.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:46:37 -0700 (PDT)
Date:   Thu, 6 May 2021 22:46:35 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v5 01/11] test-lib: bring $remove_trash out of retirement
Message-ID: <YJQPW7r20jfSW28k@danh.dev>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <patch-01.11-75667f98f3a-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-01.11-75667f98f3a-20210423T072006Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-23 09:21:05+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> There's no point in creating a repository or directory only to decide
> right afterwards that we're skipping all the tests. We can save
> ourselves the redundant "git init" or "mkdir" and "rm -rf" in this
> case.
> 
> We carry around the "$remove_trash" variable because if the directory
> is unexpectedly gone at test_done time we'll hit the error about it
> being unexpectedly gone added in df4c0d1a792 (test-lib: abort when
> can't remove trash directory, 2017-04-20).

s/test_done time/&,/ perhaps?

I guess it maybe only me (I'm not a native speaker of any Indo-European
languages). But "because if" sounds weird to me. In my native tongue,
I would say something like:

	We carry around ... variable because we'll hit the error ...
	if the directory is expectedly gone ...

> So let's partially revert 06478dab4c (test-lib: retire $remove_trash
> variable, 2017-04-23) and move the decision about whether to skip all
> tests earlier.
> 
> Let's also fix a bug that was with us since abc5d372ec (Enable
> parallel tests, 2008-08-08): we would leak $remove_trash from the
> environment. We don't want this to error out, so let's reset it to the
> empty string first:
> 
>      remove_trash=t GIT_SKIP_TESTS=t0001 ./t0001-init.sh
> 
> I tested this with --debug, see 4d0912a206 (test-lib.sh: do not barf
> under --debug at the end of the test, 2017-04-24) for a bug we don't
> want to re-introduce.
> 
> While I'm at it let's move the HOME assignment to just before

s/at it/&,/ too?

> test_create_repo, it could be lower, but it seems better to set it
> before calling anything in test-lib-functions.sh
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/test-lib.sh | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 3dec266221c..105c424bf56 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1169,7 +1169,7 @@ test_done () {
>  			esac
>  		fi
>  
> -		if test -z "$debug"
> +		if test -z "$debug" && test -n "$remove_trash"
>  		then
>  			test -d "$TRASH_DIRECTORY" ||
>  			error "Tests passed but trash directory already removed before test cleanup; aborting"
> @@ -1334,6 +1334,22 @@ then
>  	exit 1
>  fi
>  
> +# Are we running this test at all?
> +remove_trash=
> +this_test=${0##*/}
> +this_test=${this_test%%-*}
> +if match_pattern_list "$this_test" $GIT_SKIP_TESTS
> +then
> +	say_color info >&3 "skipping test $this_test altogether"
> +	skip_all="skip all tests in $this_test"
> +	test_done
> +fi
> +
> +# Last-minute variable setup
> +HOME="$TRASH_DIRECTORY"
> +GNUPGHOME="$HOME/gnupg-home-not-used"
> +export HOME GNUPGHOME
> +
>  # Test repository
>  rm -fr "$TRASH_DIRECTORY" || {
>  	GIT_EXIT_OK=t
> @@ -1341,10 +1357,7 @@ rm -fr "$TRASH_DIRECTORY" || {
>  	exit 1
>  }
>  
> -HOME="$TRASH_DIRECTORY"
> -GNUPGHOME="$HOME/gnupg-home-not-used"
> -export HOME GNUPGHOME
> -
> +remove_trash=t
>  if test -z "$TEST_NO_CREATE_REPO"
>  then
>  	test_create_repo "$TRASH_DIRECTORY"
> @@ -1356,15 +1369,6 @@ fi
>  # in subprocesses like git equals our $PWD (for pathname comparisons).
>  cd -P "$TRASH_DIRECTORY" || exit 1
>  
> -this_test=${0##*/}
> -this_test=${this_test%%-*}
> -if match_pattern_list "$this_test" $GIT_SKIP_TESTS
> -then
> -	say_color info >&3 "skipping test $this_test altogether"
> -	skip_all="skip all tests in $this_test"
> -	test_done
> -fi
> -
>  if test -n "$write_junit_xml"
>  then
>  	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
> -- 
> 2.31.1.737.g98b508eba36
> 

-- 
Danh
