Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9A71F461
	for <e@80x24.org>; Wed,  3 Jul 2019 12:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGCMmg (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 08:42:36 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:38450 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbfGCMmg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Jul 2019 08:42:36 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 08:42:35 EDT
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hieLE-00079l-A8; Wed, 03 Jul 2019 14:26:28 +0200
Subject: Re: [PATCH 2/2] ci: disable Homebrew's auto cleanup
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20190629170108.GF21574@szeder.dev>
 <20190703104748.32533-1-szeder.dev@gmail.com>
 <20190703104748.32533-2-szeder.dev@gmail.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <1d10ed33-5c33-8028-c375-d859ef6826dc@virtuell-zuhause.de>
Date:   Wed, 3 Jul 2019 14:26:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703104748.32533-2-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1562157755;2c2449ea;
X-HE-SMSGID: 1hieLE-00079l-A8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.2019 um 12:47 schrieb SZEDER Gábor:
> Lately Homebrew learned to automagically clean up information about
> outdated packages during other 'brew' commands, which might be useful
> for the avarage user, but is a waste of time in CI build jobs, because
> the next build jobs will start from the exact same image containing
> the same outdated packages anyway.
> 
> Export HOMEBREW_NO_AUTO_UPDATE=1 to disable this auto cleanup feature,

The patch below adds HOMEBREW_NO_INSTALL_CLEANUP so maybe you meant
HOMEBREW_NO_INSTALL_CLEANUP here as well?

> shaving off about 20-30s from the time needed to install dependencies
> in our macOS build jobs on Travis CI.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 7f546c8552..8cc72503cb 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -34,7 +34,7 @@ linux-clang|linux-gcc)
>  	popd
>  	;;
>  osx-clang|osx-gcc)
> -	export HOMEBREW_NO_AUTO_UPDATE=1
> +	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time
>  	test -z "$BREW_INSTALL_PACKAGES" ||
> 

