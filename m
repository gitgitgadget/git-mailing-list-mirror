Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51808C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B7C6103C
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbhKIQ1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:27:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:50411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238397AbhKIQ1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636475090;
        bh=JvwZVaW6kFYZNcJeJEtBKbtF/ft5nLkHrvcPvmeAZE8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OVkbsjvq83M7d1MP7QP1JF04AgdXwYPnEWqMPEAAZX3niRW3GOY2NmOIZ6PlzSFYh
         S1U05W6VXeWWX+pDbAtEkIaQu4LO6pbor0REb63dtz2jSgxdBZqlel68v6Q6CDTYly
         gbD6PyXWPGS5630flcC8vJZcxdvAeb1soPvUjoY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1n6qGG3S89-00MJKJ; Tue, 09
 Nov 2021 17:24:49 +0100
Date:   Tue, 9 Nov 2021 17:24:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anders Kaseorg <andersk@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v4 4/4] branch: Protect branches checked out in all
 worktrees
In-Reply-To: <20211109030028.2196416-4-andersk@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2111091724150.54@tvgsbejvaqbjf.bet>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu> <20211109030028.2196416-1-andersk@mit.edu> <20211109030028.2196416-4-andersk@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qVTelZ8myNl8KUStnxKRqHwo5uk5auwinQzw1BVdiMN7goi3Izz
 TQbI0vON9RMLezjODV0APlB2pXfWbSQZltqjU+AR2ZFnQbPn1R1tHWLAQLPowUxNzdZHaf0
 uQLCjWmWNN6PWa0y9/NSDDSVM0k01EJ0xsE1IdU+3bYbwso1JsG5cuFkKT/A8i83Zp5uVeW
 NrvCzZldzeF1LiPhW3Ovg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7QLMKAbFg5Y=:7eydPBd+ypjFvwiJUOLWaV
 oQWZssTpLe0P6POBOSzLsG3y1PIH2yOkhNfS9u6/+iYzDvZIuVItbI/LxDgmFLhMVc+dK7RVE
 WKFlvtPrQBX4PvwSeXVeIg9ZtjHpHV7k6t+2B02J9Dxf8+7jULP+haoAG+67VESCWb6nUs2CU
 TishZ8olG2fKUhIwjtvW4chzEfKQVG3CC4H8bc9gQ5l9pApoJQTSNvESvuX06GghYlx8VE7Qe
 7qucY/T3SeM6vbtN3yB0rwagKfzUev8Kydex7r6ZVfzeCEIzARyxE7tyZMTxE3VTOaSXid7HX
 73zDSUE4EFNnllM7yt+ILINDcI9mby2F6MfedAhkOsec26G+IAiXwZiMSC7IiyQ6JtnUEI2yN
 GfoeyTYVJ9ByoKa9GuTzPGd7dJrTTHQwHnSq4lAZd/SD6m1msazssnRnr1yNdjgGXgpnxCha2
 uIp6HKFlcytcR+4WXKlTsiydyHAQb7rc4G/ZiPbEMLcYPg8+HsQLmXYAqSmGHbw7ZGH1dGrRk
 JfGkpkEaWc0XGomy+yrdyKu/gGoclQrT5ZZRPeMY/ofBzd6Hj4KuIeuYcWyZpT1SFft8bVjwQ
 xqiLatzlrOECt9eNpew1d/52o67ZoZ2M826Fl6t6eRaWZbnqAgVDB9VLgo9yFri1266yFYjbo
 RAJhNUHtsIYTvqkt8JXaKKjsrk4ZFx3K2sJVGZzwwsJkG7DaLMCWtLyTiCkN95D50tHiLNTYE
 KFXMD77gLilJS6z4SaZ1Cn7tEzJquCKnzPDnnJ9ExpdVZFgnXukrYlxrhe/haqtIfbFb0tTrI
 7zLpqcVoXsS4eHao+UVlV8sf1nibRz6WxwqUa8cEqSFW/4Lbrpfnow/UA1gVf5TEpI76AZM1M
 EeoN8r2PDR5Qwn0Kdx1TsdX0FixJMQy+k7pWCrkbXzZpPr3nFgFRwMoPyQbB75JrNj8NzMteM
 LmXe93c6pPMaf9+k1iHiDd/G86eLrMGii7JRKwffYym7l+IA6+1+Ilt6VKuia+QTG830qD/Pq
 ieGgPqgFZCDjcyjr4EhO6hmmT3mXRRiICPejfXhDHEGHirM+aGxgg32p4V6gok1U8XvQZLRG2
 zrNx7YltX99TDg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Anders,

On Mon, 8 Nov 2021, Anders Kaseorg wrote:

> Refuse to force-move a branch over the currently checked out branch of
> any working tree, not just the current one.

Good catch!

I read through the four patches, offered a couple of suggestions, but
nothing major. Well done!

Thank you,
Dscho

>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  branch.c          | 10 ++++++----
>  t/t3200-branch.sh |  7 +++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 07a46430b3..581f0c02c2 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -199,7 +199,7 @@ int validate_branchname(const char *name, struct str=
buf *ref)
>   */
>  int validate_new_branchname(const char *name, struct strbuf *ref, int f=
orce)
>  {
> -	const char *head;
> +	const struct worktree *wt;
>
>  	if (!validate_branchname(name, ref))
>  		return 0;
> @@ -208,9 +208,11 @@ int validate_new_branchname(const char *name, struc=
t strbuf *ref, int force)
>  		die(_("A branch named '%s' already exists."),
>  		    ref->buf + strlen("refs/heads/"));
>
> -	head =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> -	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
> -		die(_("Cannot force update the current branch."));
> +	wt =3D find_shared_symref("HEAD", ref->buf);
> +	if (wt && !wt->is_bare)
> +		die(_("Cannot force update the branch '%s'"
> +		      "checked out at '%s'."),
> +		    ref->buf + strlen("refs/heads/"), wt->path);
>
>  	return 1;
>  }
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index e575ffb4ff..4c868bf971 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -168,6 +168,13 @@ test_expect_success 'git branch -M foo bar should f=
ail when bar is checked out'
>  	test_must_fail git branch -M bar foo
>  '
>
> +test_expect_success 'git branch -M foo bar should fail when bar is chec=
ked out in worktree' '
> +	git branch -f bar &&
> +	test_when_finished "git worktree remove wt && git branch -D wt" &&
> +	git worktree add wt &&
> +	test_must_fail git branch -M bar wt
> +'
> +
>  test_expect_success 'git branch -M baz bam should succeed when baz is c=
hecked out' '
>  	git checkout -b baz &&
>  	git branch bam &&
> --
> 2.33.1
>
>
