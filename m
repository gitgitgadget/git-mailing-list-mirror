Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B92AECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 12:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiH2MhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiH2Mgt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 08:36:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B58578AA
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661775606;
        bh=V7OoNYRYi3SeS3Bcm5nI3+Xopm3wc9xWzLD8qoHDDpM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U4XAu39dObVUnZ1q5b59/xn3oBRXRX8KnSh0/8hiDYsLyVGL2Cix9mtPwHN/PLLGz
         No+4tF2httYdhYPC1aqGd2EuSAqXIVZCHCY8yZVRDTqkbH1XR4sadnN/sM8M3jAy1v
         FAn+yiuuQCURGVm0CoZRBCnIbcmSXazhHWI8+6V0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1p6fG01hWk-00eMfr; Mon, 29
 Aug 2022 14:20:06 +0200
Date:   Mon, 29 Aug 2022 14:20:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 09/16] bisect run: fix the error message
In-Reply-To: <xmqq8rn8voh2.fsf@gitster.g>
Message-ID: <06q285oq-np8q-qpo1-s470-74q5s3s3478o@tzk.qr>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>        <409492ad830828f2b5f341706ad9ad1c64f66d6e.1661604264.git.gitgitgadget@gmail.com> <xmqq8rn8voh2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qzxqwGwpJiaJJlafKPBKH+4fJ8lD28OAhCZFh0GI+Gl5hHTgAQf
 h8HnHqKRH4Q56kZIgWIFKg5G2NmlmH/aTdTekQQ0ZMmlczPG5YHs6KyQPqvhIZH5uz4NPeX
 CZQF92LWtdBf1gIKYnY69gj22IwT0D5ZZF6a5GsIYgKjhFr+Qz6ibD5eZdoDMsLPHuUjlVO
 vNKOgtCoB4ip2J0+Z5rTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Eqc2l0WNjiA=:pcRZfVHbPfJAacFSiS7K1t
 mmkk2TszTwU5RMRBkYzCT45QEBR10DeWZnqKuZScwDdjQjGDhaxD5U5KqkJFfJRqH7r7OiqEH
 sWccEXyQHCTqEbfjb+LPG94g7/UnNIOe8TJFMQ368YAHIlch9T+Mbl2+pqpr+AqsaRUjtNDnA
 vpewxu1zkcA4SXi5zKdN8xnifXviTT5TjuqVgd/LneVuDBm8E+IWAC21d/yuVWWBqVBXZlmZ9
 TzMksAq1P4YR+16Ns31qBv+Qro0HJ9lmWwPDSadn5IKs5LjVfGgGVMKy070lF8ZrQDK6pvOOI
 WxRCCdDu9eLvLuqkb9Zkv64YDXK8j1XqwpoXWXm60DxDv3He1z/THVRQTLD8E2O0Wy7TR5o2b
 4IplJuJl8bB4JSDS3qnxyl3qFXxE2wFX4OYumJw+ykXghAqWkNPPSmIJBSImZT2Q3C02cK2yH
 zx/iPdqNTg8S86rFWFV3l5Co9wahQpkd5uEHGqjtqmJVVHm8SRDeRguCkUwWs4Qs0mxZadE7R
 2xHD3Gwe53MDDw30oGRo4KaPmu+n0LQgF3zl+3zdy6ZbmfXu49VjCi4QNNExBc5hFqJSJO7WA
 +hssSzanBwfNYOSNOqtZxQ88ea9xSC+kxRx5ehLpZu0xVzJL7ti4E4ZvwTTd6Z73XMIPXPxQH
 nVOdSZ/fSM2HWoEa5e4c6rQs7H7x1RzLVbV3Lgvx7O/JC30+a0ZBDtdunIDYUBOOJHMN1vc32
 34qfs913fI/OVaqOsYJ/sCjhuujhZWL9wOOmUTKIFw0V6x2y2NHOQr27j+5U0Ex2NmvYhRELJ
 8rQzIoulhIw/PvDQxuXVKP5k3HotolkMXzLpsagKhxn9p4b8KZW5i2XB2qZ22DX7wrtAOsNT5
 s+uyadwAZyid5RuArw93i82A2mOmSJbCM4OsJSD1GUocGkH7j/IX9Xd9Gm9l2HZnz+e0tqSaJ
 S5KpX6x937jVBHQa7FES+4mFEs6zdQHnz+KE8WpSCemtHowJEYGcqEkSQ1aaY1G5tM9y1b7Xy
 AWiIbI2Gi4GbtA3i+/MciQyYVreYNKz+u9Xf7YVhwddOQIsW7pCFgjzVUxxS5zUGzwvq1KtL8
 g5FYj2yxn4Ev3ci03y2cFmn9a1b1Wv5svcn9PyUkVrNUexMkVblFmugag==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 28 Aug 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell functio=
n
> > in C, 2021-09-13), we ported the `bisect run` subcommand to C, includi=
ng
> > the part that prints out an error message when the implicit `git bisec=
t
> > bad` or `git bisect good` failed.
> >
> > However, the error message was supposed to print out whether the state
> > was "good" or "bad", but used a bogus (because non-populated) `args`
> > variable for it.
> >
> > Helped-by: Elijah Newren <newren@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/bisect--helper.c    |  2 +-
> >  t/t6030-bisect-porcelain.sh | 10 ++++++++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index d797cd1cef8..a00167f1373 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -1430,7 +1430,7 @@ static int cmd_bisect_run(int argc, const char *=
*argv, const char *prefix)
> >  			printf(_("bisect found first bad commit"));
> >  			res =3D BISECT_OK;
> >  		} else if (res) {
> > -			error(_("bisect run failed: 'git bisect--helper --bisect-state"
> > +			error(_("bisect run failed: 'git bisect"
> >  			" %s' exited with error code %d"), new_state, res);
> >  		} else {
> >  			continue;
>
> The change to retire "bisect--helper" from the end-user facing error
> message makes tons of sense, but I am not quite sure if the proposed
> log message describes the change correctly.  Or is this a fallout of
> some "rebase -i" gotcha that a log message meant for one commit was
> applied to a different commit, or something?

This is indeed a fall-out from some interactive rebase. Thank you for
catching it.

You can actually see it in the thread history: v2 still had a diff that
was aligned with the commit message, but
<46fe0774-66e7-8947-cd79-d35229eec25a@web.de> graduated between v2 and v3
and partially addressed the issue fixed by this here patch.

I'm glad that we caught this in time for v6. This is the commit message I
plan on using:

=2D- snip --
    bisect run: fix the error message

    In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell functio=
n
    in C, 2021-09-13), we ported the `bisect run` subcommand to C, includi=
ng
    the part that prints out an error message when the implicit `git bisec=
t
    bad` or `git bisect good` failed.

    However, the error message was supposed to print out whether the state
    was "good" or "bad", but used a bogus (because non-populated) `args`
    variable for it. This was fixed in 80c2e9657f2 (bisect--helper: report
    actual bisect_state() argument on error, 2022-01-18), but the error
    message still talks about `bisect--helper`, which is an implementation
    detail that should not concern end users.

    Fix that, and add a regression test to ensure that the intended form o=
f
    the error message.
=2D- snap --

Ciao,
Dscho
