Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388C21F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 06:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfJBGMF (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 02:12:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51965 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJBGMF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 02:12:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2821982A05;
        Wed,  2 Oct 2019 02:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UfFWIBMHW4jrlt+AfBHIHzjT5EQ=; b=Q/Rv2p
        ou+X2newhMRiFJUvCw3SeKjkloOutHeV+dWK/zAJmHrM2avx8/POQRIVS9BoEOH3
        KFkxXboVEMSmu/6Y+fIvaRfToxKx8Jwiup4ZNdCV1Qhe0dmrjqFf9+xceSi6UQ4g
        fjtG228a93KUp3u6wyE/1KP74c5Ussib8nPhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R/xH5fkoykbpUREvgYsMVP0kfnVx5OBb
        xekyh5cQPCN0WFMHDLt4EdEfOTclN6znMeUPWvU1O3upayX0upAfNXaVCyJhxyqG
        Oc8hpJQpEDzB8PMQhXCsOcw1q7sFHJ/uYx42Vtci+XHAyuD0fOhK4eA5wB/RgZF1
        Wwo3KSNIC1M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2097982A04;
        Wed,  2 Oct 2019 02:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4890282A01;
        Wed,  2 Oct 2019 02:12:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] ci: run `hdr-check` as part of the `Static Analysis` job
References: <pull.368.git.gitgitgadget@gmail.com>
        <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Oct 2019 15:11:58 +0900
In-Reply-To: <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 01 Oct 2019
        04:16:26 -0700 (PDT)")
Message-ID: <xmqq7e5nfzgx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BA17BD8-E4DB-11E9-9663-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -       sudo apt-get install -y coccinelle &&
> +       sudo apt-get install -y coccinelle  coccinelle libcurl4-openssl-dev libssl-dev libexpat-dev gettext &&

I think "s/coccinelle  //" is necessary here (assuming that "apt-get install"
is the same Debian thing I know about).

Will do so locally, so no need to resend, but "Yeah, that was a
typo" or "no stupid, what I wrote is right" would be a nice
response to see, especially if I have to undo the local fix.

Thanks.


> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 8cc72503cb..8ce9ce276e 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -49,7 +49,8 @@ osx-clang|osx-gcc)
>  	;;
>  StaticAnalysis)
>  	sudo apt-get -q update
> -	sudo apt-get -q -y install coccinelle
> +	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
> +		libexpat-dev gettext
>  	;;
>  Documentation)
>  	sudo apt-get -q update
> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> index a19aa7ebbc..65bcebda41 100755
> --- a/ci/run-static-analysis.sh
> +++ b/ci/run-static-analysis.sh
> @@ -26,4 +26,7 @@ then
>  	exit 1
>  fi
>  
> +make hdr-check ||
> +exit 1
> +
>  save_good_tree
