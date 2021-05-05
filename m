Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C92C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FADB61076
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhEET3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 15:29:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:44427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhEET33 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 15:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620242908;
        bh=0eaj4RUAK11M/+18yOE4Ze5UM6y9/GDLElkcdbKw+8s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c2S2Fl9VZW7+0S5niy5LMBQ8L3O09HYgiAwiA257JiZMMqroipEfypK7ARRz3djqB
         ljruGmVgDPO6pOny+U4gcko/3gp5cMEqHAeDOcBUOePVByoGGLgjyST5jA+gwwbpBy
         MOI84gC/a9KVOUxjtGiujUP955WLZrRuz+ce3AYQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.146.104] ([89.1.212.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1lvu2u0dNI-00Hj0D; Wed, 05
 May 2021 21:28:28 +0200
Date:   Wed, 5 May 2021 21:28:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH] builtin/init-db: preemptively clear repo_fmt to avoid
 leaks
In-Reply-To: <pull.1018.git.git.1620240022594.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2105052125452.50@tvgsbejvaqbjf.bet>
References: <pull.1018.git.git.1620240022594.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HspcJZ/tmmZA2lqIEElQNZjkQ2HT6ShugI7+UuKUYX5QdLP8kiR
 BtBceB/ZeZurhx2SkhAuv0CGkbj47xB856/o4mTzzNSwxu2XgU3qweANyqxAu1vMtkwqt5B
 ZKgyeOKmYlEwGLfIV16LsphLi0UdYJy0Clhj45pEEh2RKZpoqh3kTNZzhfny3UhH+Lg12N+
 TxTPqVdIQzLJ2pWH2hl1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KEscUJ3jzMk=:ngBa1h15HfCVoNZ02pXZk/
 k2ARHSqcUwJTsSEhCh1o6G6Qd45arV/QQl5zpNqzCbsVcEZmnnCl/jaH2McR8yidN9GALFGmg
 JkBcBMBzXY50guDPEpAoNvbb81fRmDCFfKJifLwmiagDl8VnxLDGqaEFtS1JOI8ViXEc/7RXz
 4jag98WUAclY/cUdqyjHtJ6zEt06bEd+8gpP0SXlmKSeGJc7puOz8VRMhrTGcqndJzroFhaLn
 3zoRdOnZo0aQl/BbyV+kJ4YJ/grtRgKeOaZJTeq/jRhuX9ueJLm/o3cKvBg8Lo4Gd62byQOfD
 4Qd4kMgQeSUW3Nr8bnb8+cs5CkeLt9uZoJZLDLdFsUqmZa14C923Fe1uMTaBo3p50PBd97c+Z
 Ua0GK+JKiy/d7kQY9jFB6MWlKQiQC9gGoT2LbHd1MY8HSfAv+t3xIuApgrCcPnIPlWx6BnQx7
 PVni+pyIpyVW90+xNwZZXTjg67FucCJSnlm/4BYdvQQvESPNAdYfwRf5dhZTPtC3AUOS31o8J
 MccDctJ4MnTcIhGwok0uT/4//zCFDKVSHrjnboow56aCowCxQtZ2WsHOXQtjPmhr382hg8pkx
 eTxjCTikrxJ/AE+sPs7p59zLlPmK/P86KsZENRDXGqwaV29iDBLPfc4w6xHINc+tgRlVmlex/
 UXhKrDbtCci5r+X5Bl4vv86c+/QKAj4q++PJH2WNA8CnTMghJWnF88oAlDkRbGZXWZGIzi625
 X9j5Y9+ITqyuVBQtWrmqERJKMP5tSQC0ysjEVGEkS4ikW3L0eJ5py0hZjrjDeS/ABmmRzqy4q
 y+LJzPjfCT8OJ/wbFvBFCI8ID4+bvMXZwSu1qURAqdue20Ywva0FimD1aBdoXuUU3FRfKovPw
 YceP3CIdicHt7zMw3rbXc0BRCP4ZSQJcPLtt2oHMPtNLfhB75dU4TAzTIFhSZs+Ie50CZNbIJ
 QbrVYQsNw/tpOyj9oe2Jcl1ITZAPVGCwEASC2krFdJqPOwO1jm1QDK7v6IM7vKvY805MVBybF
 rYqObpRVLzcch5lp3CRIkUkW3n2UpVnG1aYsjepmnX8wHJW4VCKEKeFmVVy3MIi2eZY4zaA9b
 ANIgEpR6gKHkEPp4XH4BlJt3YR0EIwkXGZ1S+nl3f/M9QvA8JUzXYFjWlFZ+kGKLGh3VLfkPs
 s4Dy9tNuGZ1dcfFocOaRlMHl3MuvEr3+JUkAHvLOzYH+4qPyShb4IsRf0gblhEZ9U5nQaP8sU
 yp55QKtsWYQe6rEOz
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrzej,

On Wed, 5 May 2021, Andrzej Hunt via GitGitGadget wrote:

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 31b718259a64..b25147ebaf59 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -512,6 +512,7 @@ int init_db(const char *git_dir, const char *real_gi=
t_dir,
>  			       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
>  	}
>
> +	clear_repository_format(&repo_fmt);

I am afraid that this might not be correct, as t0410.27 experienced a
segmentation fault (see
https://github.com/git/git/pull/1018/checks?check_run_id=3D2511749719#step=
:5:2845
for the full details):

=2D- snip --
[...]
 + repack_and_check -a bd6a66906d425462f8fbf1e3a61cda48cc4e456c
3251618c5193c77083052fb7d6ed5e8b0b227a94
+ rm -rf repo2
+ cp -r repo repo2
+ git -C repo2 repack -a -d
warning: reflog of 'HEAD' references pruned commits
warning: reflog of 'refs/heads/master' references pruned commits
Segmentation fault (core dumped)
error: last command exited with $?=3D139
not ok 27 - repack -d does not irreversibly delete promisor objects
=2D- snap --

When I encountered similar problems with my patches in the past, I found
the `--valgrind-only` option incredibly useful, i.e. something like

	cd t && sh t0410-*.sh -i -v -x --valgrind-only=3D27

Maybe you can give it a try?

Ciao,
Dscho

>  	free(original_git_dir);
>  	return 0;
>  }
>
> base-commit: c3901c8daf043cdc16ffb20d3a410f3a2d5494fd
> --
> gitgitgadget
>
>
