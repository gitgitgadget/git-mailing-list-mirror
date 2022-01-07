Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBC1C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 18:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiAGSHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 13:07:53 -0500
Received: from mout.gmx.net ([212.227.17.21]:34083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240587AbiAGSHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 13:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641578868;
        bh=XQ2Sp09OEz4w9ISHoHSIK7gJ7DtD6xk0/iIcuMqfNdg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cZtwKv18XbFXtz6nK1mtJe14EncjgQgxRALdiIBRcCFpXG0Xvf6q+nV7Za1EBCDfv
         MHBpw3+pFYZGw+Q241ig6qp6U6WAo8ceYc62X2GTZfCKLnmhi+ZHp4CbdV62NkE4rS
         GOs0ioBTjU5U4vfr6YK5d3BwEa8vse2XHJReZxmw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1mRe173pza-00hclr; Fri, 07
 Jan 2022 19:07:48 +0100
Date:   Fri, 7 Jan 2022 19:07:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 7/8] merge-tree: support saving merge messages to a
 separate file
In-Reply-To: <4b513a6d696b8e6ff2c1b669059fcd8747bfa10d.1641403655.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201071906050.339@tvgsbejvaqbjf.bet>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <4b513a6d696b8e6ff2c1b669059fcd8747bfa10d.1641403655.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fU+NBLXTkm1rcx3/Fbe1pQLkFP5wr+dyokMqYfEbWtwxpNX7p5c
 Gu0HNwQFVckqk+akSOXHbCBkBUTBizGxExe8SJXWOjmHbGXrzJIMOc9H/CyfUObAAzDjpNj
 o0tmWaQ18ApIF6KUcaeQvrZ4H+/oQFQxyDXV89Zszr2kJphDIpD12u6xE9KfVbUudshYc2m
 RC+boLMt4FYaFeu/HmgDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l5m3HalbeXk=:ehS9AJ/imtPz48+j9jk2qx
 +oylBgZ2hHw8KswOlot5WvN+rfNKBwQGfIVYYUcHKSEQ0QqRWKKVkK4jsNkcoRoKOnyi3a2hC
 ZtZKz6+8nR9ZnbYQmnQ71elDSn/VWRckjjTkUpiFnLsVAKYMltygLCNSxb2v2TRCGZBMuXl4g
 8sSFq60a8247v5YZVHgEP7awZq5vjdivN+zJf/xpWWkZ2HdzabZs0h0pkDH4gn0Is+EyxlOO5
 HTvWdwDJt0GyyIqzQ6Qplokmg4pEilDZNQZ9L1jh0kQNYGpeqAHfLiqPAT9uJLKrEWhHWXQjE
 73qSmFmrkp8wl9zR0J67CKO/3m4f8QAHxwpZkNQf4EC5XU8sQzPJBYAkGGcQJ5ziV6pIwk0KM
 7MvvkoJHzLtuc9zAB8BruUN+WpUEwCPp/rMYfpT3cTSPIUzqx2Q9Nqo8r7HowkarTQiYU1nq6
 8kmirHFc5tXZR7c3ZnRPinAPfUwntK4P6qHmXDdE1ep5FEF+l8B4pXxyCfhwqXJ2dMjli/p2v
 8sHRvcIZ2hm6GsSwYNtzsnXRWmPHwmkMDmvBVWP4xR08nXjzL0DmD2aEOfQ5u4GBzXK2QbLMB
 bJGjrVZFd+1DtfqH5gllivWRfLfSIewcTkuC6HSV8afQqs9KLIWigLbC4RX+/faIj7CP00bkj
 oG06CnFtMCuGFCODrCn9iEN7MRK8Qz5t0Ycy4yTQOQLopJdFGTCKx/vWmbRb9mpKzLhZRVLr0
 7ODcAkQzKQeZGx4mMgFVyDkqGz9iSD60DkJKvI1UjODE+4GoJMH9E/F8nKhz+9SuglCysK1ST
 FYZ/FNaQC1RF+6Zl/V8BXqmRe1LIl7ww6s6qK/V616a5fvoXGtTbgVEt1Su4zMe7R7USo6NIR
 XxoW1dh9Dy4zUkIAgSFYJWuqGWQMG9zbkb2yzo1ObCVrnm9v4CM9fjYY0YzwOik/HZnZjRy0S
 /0e36T2jyfULe60RgC0uAQJD8xrYhsXQ7hLVLcywLbkHHHQuWJs8NmITtE2JH04lKoTO5Dnz7
 gCHRAOo+SSCjIwVcwq6WsJZfDo7q3KvQt0nqSm3WiYQEPwM39Q7I3oPS9hTS5XJX0qkQ4qbRq
 3+TFhBg01Jke54=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 5 Jan 2022, Elijah Newren via GitGitGadget wrote:

> diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> index f7aa310f8c1..5f3f27f504d 100755
> --- a/t/t4301-merge-tree-real.sh
> +++ b/t/t4301-merge-tree-real.sh
> @@ -78,4 +78,22 @@ test_expect_success 'Barf on too many arguments' '
>  	grep "^usage: git merge-tree" expect
>  '
>
> +test_expect_success '--messages gives us the conflict notices and such'=
 '
> +	test_must_fail git merge-tree --real --messages=3DMSG_FILE side1 side2=
 &&

Since we discern between exit status 1 (=3D merge conflict) and >1 (fatal
error), we should probably use `test_expect_code` here.

Other than that, this patch looks good.

Thank you,
Dscho

> +
> +	# Expected results:
> +	#   "greeting" should merge with conflicts
> +	#   "numbers" should merge cleanly
> +	#   "whatever" has *both* a modify/delete and a file/directory conflic=
t
> +	cat <<-EOF >expect &&
> +	Auto-merging greeting
> +	CONFLICT (content): Merge conflict in greeting
> +	Auto-merging numbers
> +	CONFLICT (file/directory): directory in the way of whatever from side1=
; moving it to whatever~side1 instead.
> +	CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified=
 in side1.  Version side1 of whatever~side1 left in tree.
> +	EOF
> +
> +	test_cmp expect MSG_FILE
> +'
> +
>  test_done
> --
> gitgitgadget
>
>
