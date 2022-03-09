Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB09C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 21:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbiCIVya (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiCIVy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 16:54:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92E2E6A0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 13:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646862804;
        bh=+pC6UqGD7n8yd+uW6VN7rznI7rjNo1CUPU6RKYce4mc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hnR9tsGXuBkVi9o2dao/TF9k6RKBZTsioXNWFw8QO08h7a8rnGmo8TUlEgBuuk0AE
         YifzAe38K1DNl6qcgkgjHqay+VBC+WUbqoJxLMC9e6NHKwVN1UKoE5XU3d6RpAFq/W
         uokAFXjx9oYPZ2MJmLNJZLujzJDlZzPgLGq6i9yU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1nTRp50QEx-001xkd; Wed, 09
 Mar 2022 22:53:24 +0100
Date:   Wed, 9 Mar 2022 22:53:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v3 2/2] t7063: mtime-mangling instead of delays in
 untracked cache testing
In-Reply-To: <dceb2857609fad8a8f93e489adc478ab0eb71c51.1646201124.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203092250080.357@tvgsbejvaqbjf.bet>
References: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>        <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com> <dceb2857609fad8a8f93e489adc478ab0eb71c51.1646201124.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o5jvWtqAKLP1twAvvkVmFMi9nCzaXiklcmqfDCTMZW8/5L2owTg
 MkSUMWsiSVjAHZaEN/xGArL8HBEicSt4YTYudAY1My+bX+ImwCjkFOpTxQG8+uSiftL+kAW
 8Up/u7yp0VUjvGFBoMInGfNj7PMCP1mXUBo/llwgn4GnbJ4JHfKqYpCS54IQN4FOqPTWGX1
 lL8g+Xvrc39DNCHbi0ebQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BKKfPhJgiAw=:I4pZUOkWtIZeBcuD+9uHj7
 RRefgMzvg2rHqWDNj1njG2WHOcaufTZo0lwJEIrKmnXdIoSOa6F/zPQtoSwPd76L9imxwuQYG
 hFkbniqssz0w+cpXGx8j+ldMHjQ1cLMxMr8NNVPSwQMpkrQvt4rVn1iVJg+OHS+RFADpRYfmt
 BKyNGzwAlwknV8vczqGqJN/stZtoNRsGPi63pkO/dFV/eGAFpQkzxds4JvqC9TLAkzB9hxgu+
 yfeooq8XoRmkWiGR6chRg93fDe28BN/69Zajc4ID9nKKskXWHNHP8qIUt3PcJvZiVJMj0dwSR
 66jP/4tr+ARdojbl+rH4JO5HFfp7hHLYCer2zy1EWRmisRBCqG4CRNrrU7HTyeObsPMe7n7Ml
 zljlys6YXeU8rFUXk1KPltsr7PQv0F3Qb3FqAdpt979Cug75Mnrk0qzhODmr6oQD3F1L7Dmnj
 BVZ9uHrSrt8sgoZOJn68UTLRP4cs6dKaSQJpykzvgoj4Xky59ysiOa1GyyEJ/pEhcjmMmY6Fw
 EmjdNmMfD8Wj/eR2xdoN2Ycr75A/kArlk5D9IPGulU1FKye9iIVGDThhgf8yZeeNHD+cxUydp
 LrAU0krvepOYn3PVEsZKa85lzqWgXosrgI1W2f1gVIaUm4tiFokY6T/a3deSenSHMSkyYH7gg
 TIS5CdUEVtj1b+gBjrWA2pTrpe4qCSlFXGKQQTS5vk8OK1iglek1KrG5MA44fLnS1wIYFxAgo
 UKS/AW9BZjYkXy4aGxUIPtT0w7fYnlMljlpLgoV3cvQ7zKgZW48KbWzuKy+j+AjxFIpde+tqF
 PnJsXY5dbEceXb2K9uyXnzryOC5S/X3I6wF/sQd6Xd6Hq0F+08JXo/YoDzZKmMBLcRmC2TnNV
 ApYvEtiVVBYsjwMIMFOgy0J6lqUCiNbTugT2bqWXnGbdnDrjwV3dPdUac3+wAALRH2SKm6JLJ
 4QZ6Y4Yx+Oq30UKcGMWQl5sRs3JkhN/GuiqpmY/HxHDn35xMP9aTz74yr2yr8IEdJMz1+PlsS
 dX90absbCL6LHn33C73feMZx2/Ccf3838/Fo239diGScxOyyHCyFQExCbvW5xdzAvpHcz6/d+
 5nsoqu/EufrCxs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao,

On Wed, 2 Mar 2022, Tao Klerks via GitGitGadget wrote:

> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index a0c123b0a77..ca90ee805e7 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -90,6 +90,9 @@ test_expect_success 'setup' '
>  	cd worktree &&
>  	mkdir done dtwo dthree &&
>  	touch one two three done/one dtwo/two dthree/three &&
> +	test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
> +	test-tool chmtime =-300 done dtwo dthree &&
> +	test-tool chmtime =-300 . &&

At first I puzzled why we need `done`, `dtwo`, dthree` and `.`, too, but
it makes sense: the invariant is that all of the files/directories whose
mtime is adjusted in these three new lines have the same mtime.

A similar issue is...

> @@ -520,14 +519,14 @@ test_expect_success 'create/modify files, some of which are gitignored' '
>  	echo three >done/three && # three is gitignored
>  	echo four >done/four && # four is gitignored at a higher level
>  	echo five >done/five && # five is not gitignored
> -	echo test >base && #we need to ensure that the root dir is touched
> -	rm base &&
> +	test-tool chmtime =-180 done/two done/three done/four done/five done &&
> +	# we need to ensure that the root dir is touched (in the past);
> +	test-tool chmtime =-180 . &&

Here, where I needed a moment to understand the invariant (and hence the
need to adjust more than just the root directory's mtime).


> @@ -597,11 +595,11 @@ EOF
>  test_expect_success 'set up for test of subdir and sparse checkouts' '
>  	mkdir done/sub &&
>  	mkdir done/sub/sub &&
> -	echo "sub" > done/sub/sub/file
> +	echo "sub" > done/sub/sub/file &&
> +	test-tool chmtime =-120 done/sub/sub/file done/sub/sub done/sub done

Similar situation here, too.

All this is to say that this patch looks good to me.

Thanks,
Dscho
