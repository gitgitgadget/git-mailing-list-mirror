Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC055C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiLBBln (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiLBBlk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:41:40 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666AD3A09
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669945292; bh=AUB+UiDH7qlCRpQuVQar6w7svSx25pwAa7T6TsmRD+Y=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=uZs1NUAku7YvKxGAxMbw+St1PdoRarn8I3dnGZLRVeIc6kRMrje51RPqomZyLS2nh
         rJVIJfvy6E4qKR8jCbpp2/+dMtxc8K/eUX6ic6/3tTAlQx+kG0dDAyTRHn0rq8aUM/
         GeuvWOUioc/cVqoJJL8AhKGWe87kld4YPw6haZupaixnGF0oYucqp06rc8bQ2TdPSK
         Zpt8RaC59v6VDlRgb7o4I5k4tvglT26hiz3p3hVUlb8zRecAy77tw4GLPWtiGHxJiS
         axrvCPaJZvR+8fn4x1tQnc1a/jv6ZGB50V5XjzMNdg3rXCheZ+xi+onu0ePvwOspCu
         WW3VzC3Nhm7gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myezn-1omOoL1Hm1-00yr4I; Fri, 02
 Dec 2022 02:41:32 +0100
Message-ID: <b32593a2-664b-6ef0-ed8f-194a25a9eb69@web.de>
Date:   Fri, 2 Dec 2022 02:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 6/8] merge tests: don't ignore "rev-parse" exit code in
 helper
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-6.8-5715ff7f0f7-20221202T000227Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v2-6.8-5715ff7f0f7-20221202T000227Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RJkiVi//zwnmUsJ8+B8t0OK1Yy2+WKdvZNjo15kxGODpS5xCCn0
 eWU9n5dx4/G9oLrzdI7XpSm4j0Vj40UFbF3URX+AXeQ9V8napO3nFPzP2IE6CRjnY+N13QB
 ++1hu4+9YzwfnfBmbAZyLpYmwrYSEEUmZyo8IZWYpTLHgXd9GnqKiR3adyYw1MzzV1e4nHE
 /ubSl0U8n8gtYtMTtk+qw==
UI-OutboundReport: notjunk:1;M01:P0:qS+kDWBaeTk=;tGwpxxJ0ijb+rjsLy4ngT2TL2hz
 Jt5WPhqdtcPbTsB6749ORTeF0uvYnWKFQsXkYPqt4JHsPkgMhKNTF4lH1SfvMG6Iry6eOBJxF
 1FjKAiMo3Eqx1fHMYN8l4h/5DB+ICTFjwnsb3p5TMYkhN5zP8eTzAcrfC5d5//oDMu6hdvTRC
 vb5xqKV46MzsqEtq0r8RMAeEZfhr0Z8qiC7Ffw+ar8XK1beqExOtuP5qQ2r8gLx8iu0m5nhwc
 iBbZ1I5UvT7prrPx0pKyQl3z9Mdn3/EoQJTLTCRDLyfeCcen2FS7EjlE8w1RQcHojBVSatoH1
 be8DfHA4S082A95BENel9je3yvvPFElIlqr4CRg+tUFpb0I/MsiEaeX7Ti2KNHDus+hW97G8g
 IydGOl/4Qf+c3O/JyQRJdt9yoGwKK71rsSg8jFn4Og4myp5IZVil9BdSPWQ/axuZwtTVNBkI5
 U5H/hdBu5J+6opk95Lqj3cEpkDXIhpVchkD8wbLa2ehMYtMQ3pE4eLl+/m+sI+zy5VpjxvoYP
 1Hs5pSejuEITYLOBFPnF2oOHVXqCfZjJ+XWt835oj71JQ1gMKUQPupJ762emeOb1p/4wL0qu/
 eYjHHnwYuP3Jp874Q8136OPDVwRoOnzB2Et2nB0P7XresXzIcZR40AFOsLfcOH3tEVxYblIPf
 Em4zrC+LbXyoos1yoeyYH4JATWZ+qNK/k8QNA1Y88neNxiQowNaIGdAxTdi3MsT4McTHlIaDb
 6BC1e/FvzGbl3FtpHVg5iF+cUDC3Bq1tRj19X2Mrql37cIFMTlXpH8J3/XlvuqRbSe87Mxjlx
 Dv1baOwG87pKJG1LpDRZqsnwAd3RrWps6cAX4cET5cr9eahARfXc06k3iSmMF9AngjSIhoFok
 i2vHdJPd0A3gIHYmK+8Lvrr4vZpCnDErkNpll1eklCy76UM41tByT8do0ftWUeecLvE9xp0WH
 K0zcB+ca7nf4M6rWLTp85a0q3D0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.12.2022 um 01:06 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change the verify_mergeheads() helper the check the exit code of "git
> rev-parse". The "$rest" variable added in 274a5c06d52 (merge: record
> tag objects without peeling in MERGE_HEAD, 2011-11-07) wasn't being
> used.
>
> Such a thing is needed to support the .git/MERGE_HEAD format in
> general, but in this case we have no such addition to the line. So
> let's compare with "test_cmp" instead, we can always add back this
> "$rest" parsing if it's needed in the future.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t7600-merge.sh | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 7c3f6ed9943..f5c4cbae9c8 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -102,12 +102,11 @@ verify_parents () {
>  }
>
>  verify_mergeheads () {
> -	test_write_lines "$@" >mergehead.expected &&
> -	while read sha1 rest
> +	for rev in "$@"
>  	do
> -		git rev-parse $sha1
> -	done <.git/MERGE_HEAD >mergehead.actual &&
> -	test_cmp mergehead.expected mergehead.actual
> +		git rev-parse $rev || return 1
> +	done >mergehead.expected &&
> +	test_cmp mergehead.expected .git/MERGE_HEAD

Why all these changes and not just add "|| return 1"?

>  }
>
>  verify_no_mergehead () {
