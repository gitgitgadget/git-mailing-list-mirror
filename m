Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220CA1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 17:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfGARRF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 13:17:05 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52850 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfGARRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 13:17:05 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45cvDs67dtz1rp5c;
        Mon,  1 Jul 2019 19:17:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45cvDs5MCkz1qqkg;
        Mon,  1 Jul 2019 19:17:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id bhWMu_e_jtto; Mon,  1 Jul 2019 19:17:00 +0200 (CEST)
X-Auth-Info: M4UHp2MLPRM98qTuwEWizfXpXnkMeODPWnhZVlFh7R1oauJQtE2gz8wTC+CUeZV1
Received: from igel.home (ppp-46-244-167-162.dynamic.mnet-online.de [46.244.167.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  1 Jul 2019 19:17:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 2DF622C117A; Mon,  1 Jul 2019 19:17:00 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
References: <pull.261.git.gitgitgadget@gmail.com>
        <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
X-Yow:  NOW, I'm taking the NEXT FLIGHT to ACAPULCO so I can write POEMS about
 BROKEN GUITAR STRINGS and sensuous PRE-TEENS!!
Date:   Mon, 01 Jul 2019 19:17:00 +0200
In-Reply-To: <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org> (Johannes Sixt's
        message of "Sun, 30 Jun 2019 20:57:23 +0200")
Message-ID: <87muhxr7xv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 30 2019, Johannes Sixt <j6t@kdbg.org> wrote:

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 79bfaeafa9..4b4d06a1c8 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
>  		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
>  		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
>  		ls .git/objects/pack >expect &&
> -		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
> +		MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&

You could also use ls -n.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
