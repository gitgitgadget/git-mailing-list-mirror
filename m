Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94EBC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA10861100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhIIKyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:54:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:34201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234438AbhIIKye (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631184797;
        bh=Y4f/6nNFAo24g7qkntwA7X9f6iKg5Vn9XkKzDhxRjO8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LC8Pr2u750ccVAhanz/jzXTE/rSjMYrBiFbMNuDGzP3yVo4P7tPOzjVWtIpK7Q2Ay
         6f5YsrS0RI0ADBZ+tb6BYi83ZRFYsBEdLkcTOMJfHyXLIHanB6hZ7vfCAXh3n8hCPI
         TLQ+1kCmBK0lmjovpnwzJwqQbqQMPmbwLlpxNQRs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKyI-1mUn1332xk-00Sf8N; Thu, 09
 Sep 2021 12:53:17 +0200
Date:   Thu, 9 Sep 2021 12:53:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
In-Reply-To: <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109091250540.59@tvgsbejvaqbjf.bet>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com> <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com> <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-716942689-1631184798=:59"
X-Provags-ID: V03:K1:k8qb/nyBSFBCkxW/Px6hHEH0VMZgzp6aVTtmIIarv2/iMuPckhY
 AjZgxhk6KWdN49f+0+kE10TjNzopI+Cgl9uFXOrf8tefeDEKztYQBd5PJUUScsj+iiPAbPq
 gxDWeVKF8FX4TY5WKS2fdCWugJVGb3dwYNEV66rsmSRU9Wc6Rtvbotthludc0o137+d43I5
 7qcZ0cp0IAVGUGfcr2lbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Aaj57qif48=:Lhp29pf8qpm5o3PhEQ5sue
 lpU5qYh4f/VNRvrWPF8FQfeBQMF35E42NSGZttIXGu1oZA5Fvlc9HThKgviDIXVpfZaqgwnrq
 VVhaVDFQquRKxZCTJIyv9w/h5MCM/heZbfqXFBZyoJ894XPCDyAoNKCTZ+RfoNnvdGBULB5we
 kdrEVcOEDYJ8d1JrLX8XZoJcceu2aXyM1KdXArk/ENjiLHEJMenLcrdq6R3TVsjDBHGLO1+cO
 GwhQnQSTE4pKD5095z/DggwFkTpRloQz5+KjNYgqGVMevLdk/kJngi1BKMkpjCSGyoYfDK59i
 UV8ua8Tejd3B9OodpNaPZ/qCRFdSq3SXo9nEfMdnC4p1Jz/CXdtkOnB6uSu/II+oBEfaW/ftP
 UVhq0hxbjRzR5h78kOZu3Sa7oLh2KhbvJxS7b2/heyVIXO7vXtlFRjafb6q2VBJpZgJ60xGba
 krHobrEB9JL0yBNFWNji/QnXXASNeFPpL7efDaKiGfJcpAS06iZIRBRKY1YXzO6OdB/YZXIQy
 31NErALOe838wgMOVpN47FuXme2djL8KNOx/g8oBG6w05lsFtsF2toOoHnwrh5NHfZ5sR7iPX
 PVpkNep8Xpkrh2N121gk3hzPTIxD743UYOS3LghEg3GUgGnj5mtt7wshD+KKZ6YW430aM1Kf0
 CvkOuuEG5PoiMozjGaZlENE12VjdSvfVPMigc443bvqkgFr4I/Tl3ba8vnwDziYpsthhh9+EP
 FXBjOHykEUbEKzOxwtMQ9NOndCAbofJNClK4biZdFNozCQDCelBDDT5fn0AHP2F044QzpkxCJ
 zee+CtWnLYSPaqkaMbejw2KPQusRFTVsgINmfwwqBCaZObf/33oGDKRizl+WyuZbIRWy11HS3
 2b9q4O5fPwOBHxPgoWEmkrBLuQocqf4j+epQ4Q8VPuh/Ge5niZ1jj6wh+DHHibfV6t93e2oUl
 c5jpo/LKd3HHZ7PJfSVjY5Ig09AkjVqgNExPTjMizCp6psU13ooJ9ErLpled47Q+ha2f+1+O+
 9cSZidPKTF/T3VjNCw/8ztzCfRCLk+UP+sfl8HasBwCuA2ZZDfGkUEIurYoLd3rFJbszIZZX5
 s8OqWTQIq7rob4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-716942689-1631184798=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Wed, 8 Sep 2021, Philippe Blain wrote:

> Hi Phillip,
>
> Le 2021-09-08 =C3=A0 09:41, Phillip Wood via GitGitGadget a =C3=A9crit=
=C2=A0:
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > The "apply" based rebase has avoided forking git checkout since
> > ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
> > 2018-08-07). The code that handles the checkout was moved into libgit
> > by b309a97108 ("reset: extract reset_head() from rebase", 2020-04-07)
> > so lets start using it for the "merge" based rebase as well. This
> > opens the way for us to stop calling the post-checkout hook in the
> > future.
> >
>
> While in general I think it's a good thing to avoid forking, this change
> might result in behavioral differences. Any config that affects
> 'git checkout' but not the internal 'reset.c::reset_head' function might
> play a role in the rebase UX.
>
> One that immediately came to mind is 'submodule.recurse'. This initial
> 'onto' checkout was pretty much the only part of 'git rebase' that did
> something useful for submodules, so it's kind of sad to see it regress.
> [That is, until someone takes the time to implement 'git rebase
> --recurse-submodules' and makes sure *all* code paths that touch the
> working tree pay attention to this flag, and that will probably
> necessitate 'git merge --recurse-submodules' first because of the
> 'merge' backend... as far as I'm aware it's on Emily's list [1], it's
> also on mine but I don't know when I'll get the time.]

Good point, there is more in the `git_checkout_config()` function (which
is `static` in `builtin/checkout.c`, and could easily be moved to
`checkout.[ch]`). We should probably fall back to calling that function
rather than `git_default_config()` in `rebase_config()`.

> Anyway, I'm not saying that we should not do what this patch is
> proposing, but I think caveats such as that should be documented in the
> commit message, and maybe an audit of other configs that might results
> in behavioural differences should be done.

Since this is already a bug in the `apply` backend, it would be even
better to follow-up with a fix, hint, hint, nudge, nudge ;-)

Ciao,
Dscho

--8323328-716942689-1631184798=:59--
