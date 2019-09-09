Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04831F463
	for <e@80x24.org>; Mon,  9 Sep 2019 20:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbfIIU3x (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 16:29:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:52409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731865AbfIIU3x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 16:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568060986;
        bh=h5O2A6iKOlaniqqH/cTbOjtMXCKuJcOYU33GNmOoK+Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Oa1MIW/i8uuAZaS/5nYJjIlauHaHi2vor1S1vfgNO2UUlNymy1OLxdNul/Fp5oiF8
         7mJgnjYm1GZtm10GteeYM8tKiSyAN8PrqKsI6nb1qDPBfpkZGk20PX/90anTCBHKq6
         IaeAyft8lp+ECcilbbkLENGOaN+N6ofd9GnNLUxQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlYrb-1if6U912hT-00bN0d; Mon, 09
 Sep 2019 22:29:46 +0200
Date:   Mon, 9 Sep 2019 22:29:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 17/16] t3427: accelerate this test by using fast-export
 and fast-import
In-Reply-To: <20190904214048.29331-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909092229040.5377@tvgsbejvaqbjf.bet>
References: <pull.294.v2.git.gitgitgadget@gmail.com> <20190904214048.29331-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TXvm4qnbfDXMWwtx9b/wJOqlv7HfFqXXaRocur7x8RQxDmRqBpL
 +FruVAoQsnXTRX3rrwiR522RIbH8+Jzh1UjanlPAuq295MgxUXqK+LBq6x6x37soAF9ICrZ
 kSgxOIPa1AgmFASVMKBGZrNU9wSIJ8tP4yL+BVk8QqX4Mxw3SnKO5VUA8Mb8R0oZAxT05wW
 DOqA1M40tRB8Nlq/JJTgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CXrD+m2cKHE=:YTg94KG5vxEusLyiYQN0bz
 UW7PorP/SHYIk5qYhC1BrQVP3QuoPg4SHpOeAUV2v4UJpE0e3+WW17iQwN9d8bnLyv12NyADL
 neZS9gKnIzP+8fQ94Z5HKAMPrP/DWM4JfXHsyX3Hpr6AcBWRH1AVlYvSgnwP7kSjy+s9csASs
 oz0pJ0tZN9r2BzccBCQDqD4U5hbunE5OqwYa/02UHZGc8IBluCqUtpMqlhtkZ1uQbg3GQ8Lsg
 ND7wjr97QwGHJF9vBnGBTFRc+L59n6yigqvmo2hWweUzoGeQAAqL7PTVNzdnS4qZIONdPy5B8
 4MtKfvDVGY4gMPVLIVK6qAEZqM2xWv+gv6ODqwoTt725JoTYIe4j2JzbsRdEDNAULeU0tQ2/d
 ZvUuAfd4206b7rSNOHmWHHzhKNavwtkpPbnHXUFlfL3KF3k8tw/8UxqgJYO8EcTr0FOJXZ0O9
 pr5Y+qHE4qn5UKVEWWDkTT6A/4qtMvh/daLr/rk2ybsYZ+nRTtxdU1od80Ybcu9yHtdaXl8rQ
 rpBTvh2b62X7Ea/iaq1kIgmyY1L8F3PeuXQ/SNgNb4bPPdk8X6iHxxLtwzePV2Dy0TDGHTvRn
 eb1DrkiZGCloXMGXHO8DBkTmOjnKhOIdaBZhqszEKTLLDeK/XNcaOc2jccYQNY0JZT84ZyrCH
 hNOScCiyNKUy7aes0eYn1pfG9wwNZrUFIwrZg6bUsWzLAbva4IPyz2v7n3SoTwGCrlXk+uinB
 +SWSlTVN1xIyMQVz5JQciC8gFETTXWKVB6jdfq9q6t4ob/mYxybMGU+q8E3rl5atgb+MovJwF
 PzG8HpCW+uQl21z+6AhCQwxHwMrrYsm0JtWJo1kUFYTMNJQb5CiIOix02479qnJitMQrr8h1H
 E4+Trz0TJ5gaPcVFli0QsOpyS8ht1g6zb/roGIeE0jhN1ntRuuaxHgVvdz+hBGgiwsz2dTuUP
 afp09YAHXzdylrQAcvm1q0YmZu3AzGL8Mpf30Ilrzp28pqXRWwg7PSNaU76whLx47naW25Kxn
 azWCEK8pVvO8lrpWmpSZRJ2EA+dQkj1VD61wr1dwST236V4soIXlP4ZjdYDS17zxuoOb4hAnE
 g0ijsOpYslX+kCWo3b5EFyEYEz+i4c5JRSw3hzd0P/RmI9N5/Hg0JODdfaoOa130YX5Hkf/yd
 /6DbGomO84U64NQm3AILBmcl7Sm8fHXn31s3eUoUY5QOpWzmMYUVuwIk3w7u1/eZarLCqVkjL
 5JLOpGRg0nZeM8Z+c
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 4 Sep 2019, Elijah Newren wrote:

> fast-export and fast-import can easily handle the simple rewrite that
> was being done by filter-branch, and should be faster on systems with a
> slow fork.  Measuring the overall time taken for all of t3427 (not just
> the difference between filter-branch and fast-export/fast-import) shows
> a speedup of about 5% on Linux and 11% on Mac.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> This patch is meant to be added onto the end of js/rebase-r-strategy; an
> earlier version of this patch conflicted js/rebase-r-strategy so now I'm
> basing on top of that series.  The speedup is also less impressive now
> that there is only one filter-branch invocation being replaced instead o=
f
> a handful.  Still a nice speedup, though.

ACK!

Thanks,
Dscho

>
>  t/t3427-rebase-subtree.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> index 39e348de16..bec48e6a1f 100755
> --- a/t/t3427-rebase-subtree.sh
> +++ b/t/t3427-rebase-subtree.sh
> @@ -59,7 +59,10 @@ test_expect_success 'setup' '
>  	test_commit files_subtree/master5 &&
>
>  	git checkout -b to-rebase &&
> -	git filter-branch --prune-empty -f --subdirectory-filter files_subtree=
 &&
> +	git fast-export --no-data HEAD -- files_subtree/ |
> +		sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" |
> +		git fast-import --force --quiet &&
> +	git reset --hard &&
>  	git commit -m "Empty commit" --allow-empty
>  '
>
> --
> 2.22.0.19.ga495766805
>
>
