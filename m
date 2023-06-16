Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD25AEB64D8
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 11:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbjFPLuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbjFPLua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 07:50:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA0273F
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 04:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1686916224; x=1687521024; i=johannes.schindelin@gmx.de;
 bh=Z2h1Bier13p3l6BQdouPIAxI19zeG+7WpRypr4yXTh0=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=gzY5ELUAPrTyySkXuowLCk6okHfNruRduuyCRbIdJV0E1WgTApNgyO4n8dFvfDwiBdRUMnV
 vKucY173f7jiYk3zv+qofYyzOV3uAMpsheK472Hjb23RqgvbRLttBY6pxJkBin9jVp6gBisUR
 D0vuG9k/AUNuYLFjjDAVwueXn5KIZ+yArfIXLUmb6+IuJ54QScQ+Wp7mGjr1l19AO/Jtcme/B
 YGKTWQSI6GywwejEe3rUEOo0zpm80oHbGU2zdOo0MbNd2nni555toBSNZeiOcAxu0UFeQe2sm
 UN99nMQWgCptmdQIaI7Gwad+RCMjzXYqnnqnivBX+Y1iYUTANLYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.149]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1puo2J4C7M-00xcOC; Fri, 16
 Jun 2023 13:50:24 +0200
Date:   Fri, 16 Jun 2023 13:50:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] setup.c: don't setup in discover_git_directory()
In-Reply-To: <pull.1526.git.git.1686771358484.gitgitgadget@gmail.com>
Message-ID: <9a7602ba-6903-a94a-3bb5-e51c76f08058@gmx.de>
References: <pull.1526.git.git.1686771358484.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hPnMcxKr2Vg9Lo19jxUS2aykXsoBR7gMxeb34t6hBH1AmBw4zLS
 YEOcRKprnbRpErVfaprbr0LepASEoVmh2jQCABVblhiDKKT9TXFFx6eshdOcOzChbtldJtc
 Yv7VkQk/k/VM4eCTIpqV8IGZKYSKTxgT0f31rz/GNAJU6+YspjTTkS8nWV1H40Ii2gj1MeY
 FkKcaL4ux0lImC4btYmSA==
UI-OutboundReport: notjunk:1;M01:P0:HGUDfTYSCHw=;fXlRTK7SfO3DNK0R7kdcqoaYQKU
 /XrDMprt7Np0MWPFlT5rw+3fLvAC80R4+Tq4anw9JMxEfr163QBZDjs066OOo20aVo0HTZH72
 Kxwngs9Ns6eHZHtyfiSzN3RFeTVkuCi7nANKxtDbRr5cucVztJc3DoAHnKvnMA2Yskg50Fz/Y
 pc8DvClSEESjkT2gWYjJ45Pu2JYr4e0utci+KcO3nHzknhFOfcn+o7V3sNSxZOeq1IFrHsR3G
 XMf2dB2aeyG2eE/72ZUHVGs0eQRzHK8J2+fqUChK26D8kdGS6vX4xx7sNW2xidg2TsUBcb2zu
 LdGp3+NXPGzY0NyT/NXG8x5IWm2wvQ5/WdaT/0Ue6Tnf4d6ZkyoJvoN8GAFHp+kul0rS55F5/
 MXXJY+DuZydznaNqGEjKB9OaC5JaqYN5iM/Jt81/PECxFcw0MHaguZKIjObzsRQoz+jwQ6+31
 +SeCt4xLwUeneVyshp12TyOznhZcOpfmEkzRwx5PVo4bahQRxvOlgIJ7iaXAKwIILSisV7SQ9
 M5sZgBwkP62Qwij6vxSCfKPkaxEVnvrvIq2Bs6sHym3zCMFC3en6CzjNkZFUTJe5aYU7d8g+y
 Ma7MHuioA2bgd4ROyonIkELNFhs/yrdor1azWGrPk94JFIRrIvHDx6221bqBVRELRzXa/EtZN
 YlOc21MOXo1CWngWRLl4mPo7cfdJjuMKihpG+uY6VwTr7oLfiH/mQjUIg6w3O5UplSdmEtGXL
 3yHt71FMCR+/V+iaNaNQE5/MAA33IUI2uU74Xxa13BJWYyWoGpC/4q1XoP8ahwtNTbTv+IkVJ
 6b6rn8EHD8CkOEC8ItMjr9bWT0JXEqXM4+u7M33ZjjY/rfr/AX1et+8sDcLnh/8BFMKX2lxq3
 +QQXbQ8YUE5bF91ixT+u5r/Egf7cOb8DS1/6tNYq8RHsDA9PjZCg1dWsq6DVqv08a0u91MY9T
 pHG+Jns/l3T3dtBd3iay7PnzlIE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

On Wed, 14 Jun 2023, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> discover_git_directory() started modifying the_repository in ebaf3bcf1ae
> (repository: move global r_f_p_c to repo struct, 2021-06-17), when, in
> the repository setup process, we started copying members from the
> "struct repository_format" we're inspecting to the appropriate "struct
> repository". However, discover_git_directory() isn't actually used in
> the setup process (its only caller in the Git binary is
> read_early_config()), so it shouldn't be doing this setup at all!
>
> As explained by 16ac8b8db6 (setup: introduce the
> discover_git_directory() function, 2017-03-13) and the comment on its
> declaration, discover_git_directory() is intended to be an entrypoint
> into setup.c machinery that allows the Git directory to be discovered
> without side effects, e.g. so that read_early_config() can read
> ".git/config" before the_repository has been set up.
>
> Fortunately, we didn't start to rely on this unintended behavior between
> then and now, so we let's just remove it. It isn't harming anyone, but
> it's confusing.
>
> Signed-off-by: Glen Choo <chooglen@google.com>

As the author of the commit whose rationale was quoted above, I am
delighted to provide my ACK to both commit message and diff.

Thanks,
Johannes

> ---
>     setup.c: don't setup in discover_git_directory()
>
>     This is the scissors patch I sent on Victoria's series [1], but reba=
sed
>     onto "master" since that series hasn't been merged yet. The merge
>     conflict resolution is to delete all of the conflicting lines:
>
>     -	the_repository->repository_format_worktree_config =3D
>     -		candidate.worktree_config;
>     -
>
>
>     IOW it's the original scissors patch if queued on top of Victoria's
>     series, but it might be cleaner to invert that, i.e. if we pretended
>     that this was in "master" already, there wouldn't be reason to add t=
hose
>     lines to begin with.
>
>     [1]
>     https://lore.kernel.org/git/kl6llegnfccw.fsf@chooglen-macbookpro.roa=
m.corp.google.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-15=
26%2Fchooglen%2Fpush-nknkwmnkxolv-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1526/=
chooglen/push-nknkwmnkxolv-v1
> Pull-Request: https://github.com/git/git/pull/1526
>
>  setup.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 458582207ea..bbd95f52c0f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1423,11 +1423,6 @@ int discover_git_directory(struct strbuf *commond=
ir,
>  		return -1;
>  	}
>
> -	/* take ownership of candidate.partial_clone */
> -	the_repository->repository_format_partial_clone =3D
> -		candidate.partial_clone;
> -	candidate.partial_clone =3D NULL;
> -
>  	clear_repository_format(&candidate);
>  	return 0;
>  }
>
> base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
> --
> gitgitgadget
>
