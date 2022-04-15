Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888FFC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354155AbiDONyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiDONyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:54:22 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 06:51:52 PDT
Received: from smtp-out-3.talktalk.net (smtp-out-3.talktalk.net [62.24.135.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C06BB0AA
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:51:52 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.talktalk.net with SMTP
        id fMLZniD0VXnPffMLanhnWl; Fri, 15 Apr 2022 14:50:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1650030650;
        bh=BuAVaiM1yAK5DXtHP++2OcjnybmNIA4t+kN0I2ZB4Zo=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=REsLs998oaErjRmSCHxQwNgduqz5AvlOUAML4GVuhfj1Mtk5zaWbAchfptaaXdFFV
         YADagNnrnD0f1nyPT3C2tZKQaUl94DQhegrIzCEFbbNyrAr3H5879DJi1e3k+sM/qQ
         Q+dHSPPl45ZlaLizO8466q9eXGpIRh1BsFk+rdqI=
X-Originating-IP: [31.185.185.192]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ufgvt5aN c=1 sm=1 tr=0 a=BhDTt+XCViy/yeGwkgzVOQ==:117
 a=BhDTt+XCViy/yeGwkgzVOQ==:17 a=IkcTkHD0fZMA:10 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=PKzvZo6CAAAA:8 a=pGLkceISAAAA:8 a=fkdCdCRrCurIfpaszyEA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <e9e491d3-eec9-0a30-2e9d-99f1b0d25519@talktalk.net>
Date:   Fri, 15 Apr 2022 14:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci: lock "pedantic" job into fedora 35 and other cleanup
Content-Language: en-GB-large
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
References: <20220415123922.30926-1-carenas@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
In-Reply-To: <20220415123922.30926-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEyUptBQq3yT2en9YiOk+fUV2F/YIKZOWfuGpokUi2HPeXt0av2TwsKA3E8kAbaFzGIoEVain2QHYoPUCqO00622j3yytNNzqYv8HmGAUlOncZZijV/G
 yfYYQMVmspiedZnb0iOnpNlXkxsTGcgQJtX8yoHpTEbwfA+08Ha6uBduc0yE5wVkfh1KGw1sgPtRN3bjnE75tltIixLIGJgSHx1BbeTnwH4c2pJX/sc4teHg
 Hv624NozBl28TUQm5VzXKiRZ+QhuhKAG29QyFIl3qCY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 15/04/2022 13:39, Carlo Marcelo Arenas Belón wrote:
> Fedora 36 is scheduled to be released in Apr 19th, but it includes
> a prerelease of gcc 12 that has known issues[1]

I was confused as that thread seems to be about errors when compiling 
with -O3 rather than -O2 but your fedora bug report[1] indicates that 
there are in fact problems when compiling with -O2 which will affect our ci.

> with our codebase
> and therefore requires extra changes to not break a DEVELOPER=1
> build.
> 
> Lock the CI job to the current release image, and while at it rename
> the job to better reflect what it is currently doing, instead of its
> original objective.
> 
> Finally add git which was a known[2] issue for a while.

It would be useful to explain what the issue is, that email also 
mentions running the tests under this job but we're not doing that here.

Thanks for fixing this before it breaks everyone's ci runs

Phillip

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2075786

> [1] https://lore.kernel.org/git/YZQhLh2BU5Hquhpo@coredump.intra.peff.net/
> [2] https://lore.kernel.org/git/xmqqeeb1dumx.fsf@gitster.g/
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> This merges fine to master, maint and next but will need some work to
> get into seen.
> 
> Alternatively, the fixes to fix the build could be merged instead, but
> it will still require at least one temporary change to disable a flag
> as the underlying bug[3] is yet to be addressed in gcc (or somewhere
> else in Fedora).
> 
> [3] https://bugzilla.redhat.com/show_bug.cgi?id=2075786
> 
>   .github/workflows/main.yml        | 4 ++--
>   ci/install-docker-dependencies.sh | 4 ++--
>   ci/run-build-and-tests.sh         | 3 +--
>   3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index c35200defb9..48e212f4110 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -282,8 +282,8 @@ jobs:
>           - jobname: linux32
>             os: ubuntu32
>             image: daald/ubuntu32:xenial
> -        - jobname: pedantic
> -          image: fedora
> +        - jobname: fedora
> +          image: fedora:35
>       env:
>         jobname: ${{matrix.vector.jobname}}
>       runs-on: ubuntu-latest
> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
> index 78b7e326da6..660e25d1d26 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -15,8 +15,8 @@ linux-musl)
>   	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
>   		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
>   	;;
> -pedantic)
> +fedora)
>   	dnf -yq update >/dev/null &&
> -	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> +	dnf -yq install make gcc git findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
>   	;;
>   esac
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 280dda7d285..de0f8d36d7c 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -37,10 +37,9 @@ linux-clang)
>   linux-sha256)
>   	export GIT_TEST_DEFAULT_HASH=sha256
>   	;;
> -pedantic)
> +fedora)
>   	# Don't run the tests; we only care about whether Git can be
>   	# built.
> -	export DEVOPTS=pedantic
>   	export MAKE_TARGETS=all
>   	;;
>   esac

