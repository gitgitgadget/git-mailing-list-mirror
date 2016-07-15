Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B8220195
	for <e@80x24.org>; Fri, 15 Jul 2016 15:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbcGOP2w (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 11:28:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:65181 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbcGOP2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 11:28:50 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LvzF3-1bIZmG1BFt-017p4Q; Fri, 15 Jul 2016 17:28:33
 +0200
Date:	Fri, 15 Jul 2016 17:28:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Mike Hommey <mh@glandium.org>
cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] blame: Allow to blame paths freshly added to the
 index
In-Reply-To: <20160715125550.24883-1-mh@glandium.org>
Message-ID: <alpine.DEB.2.20.1607151726370.6426@virtualbox>
References: <alpine.DEB.2.20.1607151242020.6426@virtualbox> <20160715125550.24883-1-mh@glandium.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3k09QjI5Q9l9VwUIO5bVpDg/9tVTOeREB2p+EVUgV+H2LmY+fTe
 9sYQ74V8iKWLfGxxVglAeifXGG2adbcwHEiBHPOOlKwp2AF8lkHrTgsaporQny450aOqDOG
 zmu9OORQJrdSSZd/ro/KLbFBuXXT3WxnbXKGiP14NuaWTz4CdQMYU/pZhL5OGvh6jRJJGQ7
 vjga/zHMW4pz9WoB+HrVA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:RkPtVcabBDU=:3PMj+OFaNcq4CkPlMFHYTe
 uihtQOU00znbcqBstl33b0QD/Od/xj877+D/8fAXur57emf5LL5i+WkMr0FgQDm3vYjBPwc+P
 xBkk6Bm8AaixQHTm2TdXmweYkdQZn/BN2CRkHaMg/RNR4SZCNYAVLEDoiphx4XCp0wnjpVSyI
 pPoT21fKVkbk0hqsd24hjs5sdSyds7pzVHLpHXLr9JyRorDYUAEOxjEIlsK4uWtrjUadgdAYC
 XO0lhhL8DeB5eCUIevTEu22K8cv0mzr7wuJycBItUYhubfW8QPcSinLAumWCwBg8b6Yo6Ev2y
 OqJLvPSb9kCW9RCJFcpGVEGolAJsPudvD6WaIHoLsRWZL/IDz/G55pNMg1igXmRfsa+HZhjhq
 g73XKm4ydcp0sZBFdyDBY2lCebXkctBdIW8SbxwDM7C3X0QDEPzIFuwc60lO+BEvaFQ3WEOKA
 CIov3F0R2aKji9VEBPv+FPOYhtsrj2iagyVTBL+O4ZJcqddrfWB/WxwtyvfPC2eo9AFMo0j3/
 8TonEqii1/AQBabRFy7wLxDU2Hix77G6yY1Ig8+viYdCSnXk+95fiCSvLvmcaM7aeeDZekVkU
 fZutjM4vpBH4sc9xWLs75utBsBXuhEiaxN79gCsoUjWOcWRVmero1JLplenLzClNAwZ2dlYss
 wPl5sDV4NfqUdWEvvX06cb6uQbkaC7QJmUFqmMCMe7nL1xKAmwgPiNrfqpT1FQ5IlxsqCCqyQ
 Sjhl6PAVPwMawPeTMKLDgwvIhiIEShjQ12zxj3HWBthQZZlkNNAVjVFMtR9XOQVJCZOTHHDLd
 ZZ7ZK5S
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Mike,

On Fri, 15 Jul 2016, Mike Hommey wrote:

> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index a9b266f..2812d7c 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -41,12 +41,12 @@ test_expect_success setup '
>  	test_tick &&
>  	GIT_AUTHOR_NAME=Fourth git commit -m Fourth &&
>  
> -	{
> -		echo ABC
> -		echo DEF
> -		echo XXXX
> -		echo GHIJK
> -	} >cow &&
> +	cat >cow <<-\EOF &&
> +	ABC
> +	DEF
> +	XXXX
> +	GHIJK
> +	EOF
>  	git add cow &&

Sorry, I did not realize that there was precedent for this awkward
paradigm in the same test script.

I like that you fix them, but I would prefer that to be done in a separate
patch (does not even need to be the same patch series).

Apart from that (i.e. apart from touching unrelated parts of the test
script), the patch looks good to me.

Thanks,
Dscho
