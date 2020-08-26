Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B43C433E3
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 14:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640E6214F1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kwVkE6zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHZOzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:55:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:39513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgHZOz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 10:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598453722;
        bh=+/wVZoQ6dZClHzt8+O6wsguCgu4OSYIQ5J1+lqEfSu0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kwVkE6zG8Ovnpl9BiWVJE/y8mQCXIACvSZbou388Pm+eRq5uALo5aL1bwA2dp2DYI
         KKf8P8zLGRNHSSfmkCyHKnHaJ8SJLdyR84pd1luRa9/TebTKRbWDG4FpFslF6yOdXW
         srUDkH6wOpPDzQQtacxxU0UoLXd0EckEkIW+xo2w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.212.143]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1kEE5F44Xc-005XQU; Wed, 26
 Aug 2020 16:55:22 +0200
Date:   Wed, 26 Aug 2020 09:55:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] transport-helper: do not run git-remote-ext etc.
 in dashed form
In-Reply-To: <CAPig+cTvLaOD1idfB2M0-QSfXXKBe5-FnWSU9E0PaUMHAoGj1w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008260954430.56@tvgsbejvaqbjf.bet>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com> <20200826011718.3186597-2-gitster@pobox.com> <CAPig+cTvLaOD1idfB2M0-QSfXXKBe5-FnWSU9E0PaUMHAoGj1w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v4VnfPwkl4PZ2nhgQCIIvym1l2j4ugoN1tKahNOuCYy61GC9yeo
 PxhDeg4vCjFVwOshCw01aaSuqqzvIXQvCaQnU5VaDxI8bfblYEITWpTVqSMpWCCxpPsXexI
 LbiKw5KFXV7IbhMV6ELPTbv5CP53q14KJ/uPYmnaxvinPEqb9NqFzsYwmRmDa33PftEiRLe
 EhabsDss5bwCvZv/75KsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GHE2qqMBsdo=:y1ENzuY+8SZHldLB6mlhnh
 zeKr9D3P5HW5Q/ZcaCz2sEdsdgaXKkx+2iEQqHRG4YdwRICs7TBPK+QDwPbonkap/3NO0TQ87
 lv8PsWTKuKHNHYlJNOWpWJBxRaFY6/8aFtjIZYKNI/VlzG9MltlXhCbacQpsF9yO1OoOlXxwf
 T3zwdtC2DJDcY7Pq9XjKh93QuMQItov40ntaTNjtmaxYsPQm/L+ZMFZxdXnVhQTW+iIXZneKA
 YY5JuiyrV/G056Mp+/iNnjwyC7VMewUSb+tDbYxQIOqRAtEMKiUs0BoUnNi7Z/hBunrhBzGo6
 r3xoU0gPd5ODC/xJB1cD7bLYIgVFaHj8TbvWQPN0TmzBxtGgFmC6WulqhZQ08WDtoUC8Qa1q+
 AQzKd1HO8E1pG4oyMbk1N0pI9aQ4hAT18euA7ume+uIXU8s3+EpmDFcZAWnp1GMc+Gk/gMe+P
 KRcbuUC/+Zk2dU8QD8mb24yzyFYjm4w6FMzQmbiP2qlxOoMX5OvTGVfZC4TGWc5o0Soqh0cog
 ZIPea+6ACRfaEcvGdmtTBIw/OusBFQdMi9jUkKkzx5wuDTb7OApxwQOaWiCxnz69u//L7cBlV
 VrUTyGCGfpCl601hYS63MugzJfwRoMAMudxc7d1nqo2fK3MMava8jHA2TT7J8rjQoPOw9HiIq
 WVXdkQ3qg6AncNPlXoisVQuzmTkxixvWsgLDH6xovNh8zETv9ZvC2Ovn3XfIdk5jKQOGKOcJr
 jJ1B3PE34y4J+1W33f3y7Zg/B7NFOeR8HJEyvfTy056fvJe5EPkqNg94XVOmBKBGf5E7HDk8i
 VToFADMckaWHb1Di0s2cEPL9DWFgDdnOAV8Qp/IXUI1axZiW1FDwoLyDRgHG/RZhZAx2fJ/3l
 Mv7io3mpez3WpWd1SVHjiF1L0A2ITu5v42ug4J6J/PyLm+iIhG1RByXqhsgHSSymsL2QzCu+o
 0ZRHqowIH9qpQGv6x/stoy9JaDzq/5UWcQqltLugfNAAHET6kFkmqPuU1+nTAkZrh/5N9p932
 Lo2YBQ/LiAXGsdT+h5k02FhQG71rzBW339rCCkd/9tkY7oGwjBXtmjBAy4W7g7eZjeqUp8jq1
 Cgjs+/dGAp1MhYaygFBR+0Enba4qA9JqDxyGfWeAb5h7RbpqB2IuWVXSmNO2yE585uVdHkfcN
 auWMnXSDKDYAgOyW7JaCRYuoWgud185GHu/biaGtcw/IdJQ2+nv3xhNrPpDxYPyjE29Ovei3s
 FJjAeEWY/+Y/Srt2HSDEtt45IP5oOdxgqlbv+TQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 25 Aug 2020, Eric Sunshine wrote:

> On Tue, Aug 25, 2020 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> > Runing them as "git remote-ext" and letting "git" dispatch to
>
> s/Runing/Running/
> s/them/it/
>
> > "remote-ext" would just be fine and is more idiomatic.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> > diff --git a/transport-helper.c b/transport-helper.c
> > @@ -128,7 +128,8 @@ static struct child_process *get_helper(struct tra=
nsport *transport)
> > -       strvec_pushf(&helper->args, "git-remote-%s", data->name);
> > +       strvec_push(&helper->args, "git");
> > +       strvec_pushf(&helper->args, "remote-%s", data->name);
>
> Rather than pushing "git" as the first argument, would it instead be
> more idiomatic to set `helper->git_cmd =3D 1` (or would that not work
> correctly for some reason)?

That is precisely what I did in Git for Windows:

=2D- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] transport-helper: prefer Git's builtins over dashed form

This helps with minimal installations such as MinGit that refuse to
waste .zip real estate by shipping identical copies of builtins (.zip
files do not support hard links).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 transport-helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 35d6437b557..2c4b7a023db 100644
=2D-- a/transport-helper.c
+++ b/transport-helper.c
@@ -130,10 +130,10 @@ static struct child_process *get_helper(struct trans=
port *transport)
 	helper->in =3D -1;
 	helper->out =3D -1;
 	helper->err =3D 0;
-	argv_array_pushf(&helper->args, "git-remote-%s", data->name);
+	argv_array_pushf(&helper->args, "remote-%s", data->name);
 	argv_array_push(&helper->args, transport->remote->name);
 	argv_array_push(&helper->args, remove_ext_force(transport->url));
-	helper->git_cmd =3D 0;
+	helper->git_cmd =3D 1;
 	helper->silent_exec_failure =3D 1;

 	if (have_git_dir())
=2D-
2.28.0.windows.1.18.g5300e52e185

