Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498ADC433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1563161077
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 22:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhCaWZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:25:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:45465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhCaWYr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 18:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617229476;
        bh=vj4Q9//ik3SpX1nqAD+AV0PFJiLOYXwhVaQDwSclyQc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LMXfiqf2CebA4n5NxV7jQmisWPXT4dzZGIxLey7wfapEj0QXiKz25I/9YfrtWTFUd
         a/yR3l8rpoaa1NDr91Sn+toRuXUOG0mViASaezJ5U9/O+GJvZBTUZ0T/70Vyd6iLwd
         wdl/KGpcYFvG017ifzMSPN7tWPpQ9nkagsX/Ds7s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.1.223] ([213.196.212.198]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1lyp1Z0FIX-00p5iP; Thu, 01
 Apr 2021 00:24:36 +0200
Date:   Thu, 1 Apr 2021 00:24:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     lilinchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        lilinchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v9] builtin/clone.c: add --reject-shallow option
In-Reply-To: <xmqqim576spj.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2104010021510.54@tvgsbejvaqbjf.bet>
References: <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com> <pull.865.v9.git.1617205915876.gitgitgadget@gmail.com> <xmqqim576spj.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qRTeoJmlIoNgyTBx0pvXmyjjViQGYJAi5wExXfZV4I1WqN35VnH
 YuYmyjEDcjgbBZ9L3CEZUOmpHNzvs82p3ydaqMEAYc5KRPaHBM/Ge04BYRO1NRELM9YdNMA
 eYsJY2+nAeuAOV2PSy0hCNkW2zZyorc9o72KfGMKOwLcqWcptcbSfRzQBGEvsNHBitekTgQ
 /KLtEVdzMeGJvA8z5iGzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wb05w6oXUvU=:WL5gKvtAJYEcLgdk2g+3VT
 MphVNmzmPwUcUSUnDLk14D9e5Xp3Vijurvz7vcaWP4HOfgI0vOxNrjYDEIT6wcAMGtzmDo5oS
 8qrhsYIJI55yBsHPOwEBmG7oYV4/5rPcgRl7HITaitp5AIUZS3LoLu0ZJ9B4ahdipBhZm52O6
 p3hnZFJp1Vz8eMavIwUDd1qKkj3a3qnaJbivj07NoBkszmwHpvz+8oZFDWW+BwaCeKquUDjeL
 Y6kNILQPCHHRnUf/LbUkgwUHJ4AMaTw0WVg7GY68mrh0DlWzq0Q0/cM7YekhAQWXQSD0gKzpQ
 XsvsyyLNG/BCDH+zterIIEcy7ZaclyC0tR0Nre9waANjAF1D+p7kmYaGm0893Zms/ZOGV87zR
 DGLv/2NTFMvKhetqQ9UDBzVJACNyrRFCCUR/3dH1QULbt6vyOL/EGij6NAkVvYeAguRnOZUed
 9bfeJxWTr5aGNSIfV4d44C++evAfXrw/s8fZ4ynJb+e/xTW0RKcVkWvRk1TN5JhHwDS1FT0VH
 7rT+jWyAEekWxRjeqYHWNiBQ7AAzKUkZLD9lw2lxNFYSQudiznMnOmoaXA5XvIg186rR7C4AB
 10pKp37SbkVVG/M1EceJGoxaA3kehmhcETihTmwhHzziGauiy6pcjIL+M/Mcr6f3Q89kc3oFE
 CXUb7uRBiG0VXKlvUNvEU/GOe5Cat0gmKsFWRTz2gMZ+NwSDckw/bwJskrDmpN0v+RKqowgZP
 4r2XG2S5bSn7P+a2PWPxCOU8DBjIqmyrvYJY9AO5KaKhA/LOIeo3aCqpEdHFzv2LoW0wdHNT6
 Wz1Jx4PCBbtVzuM0Eudm0y432U77e1Cz6mCLcp+ML2uXXHJ4dYiQa4HT0iL718HOy3dYesYWI
 ucx2I25HOKWrsjZUANheojsvDvtoS9NhdZyFxSCRexfrKk6+mY1FOdqcbJTFhwGr8B7LXEPoA
 QhnvH1vpYuBOdOwJrAZvyOSEFXAggbqgW4aijU9C3b4WNcOtgKDukuY6/JlReLZgn6yUlzUx4
 F/AoPymdbIecT4DdfBl7sZfui+pznqYMIdZzaYcK7yZo9M44+MBcbwyv6AShvuv2LxJA7fn1T
 l5IkUGhsTxVrhypDRQyXxbx252kfRPklH6XS1vMbOgZw09OvN4pGjBjGNXg8p2FO6c/TkUBrV
 gkMD83n3FjTepSSV/WpDw0IsURazRk5UMm88fYh18LqGTg57rdCGRpbUF9cq2JNH50ooW/FEL
 QnbUlPSawPD2KULjg
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 31 Mar 2021, Junio C Hamano wrote:

> > @@ -858,6 +861,9 @@ static int git_clone_config(const char *k, const c=
har *v, void *cb)
> >  		free(remote_name);
> >  		remote_name =3D xstrdup(v);
> >  	}
> > +	if (!strcmp(k, "clone.rejectshallow") && option_reject_shallow < 0)
> > +		option_reject_shallow =3D git_config_bool(k, v);
>
> Does this "single variable is enough" really work?
>
> Imagine that the first time around we'd read from $HOME/.gitconfig
> that says true (flips the variable from "unspecified").  Further
> imagine that we are running "git clone -c config.rejectShallow=3Dno"
> to countermand the global config.  We call write_config() to write
> the extra configuration value out, and then call git_config() to
> read from the repository configuration again.
>
> Because of the value taken from $HOME/.gitconfig, however, the
> attempt to override is silently ignored, isn't it?

That's my mistake, and you don't even need a second config to see the
problem:

	[clone]
		rejectShallow =3D false
		rejectShallow =3D true

Clearly, the second one should override the first one, but the code I
suggested (and which was integrated into this iteration) simply does not
work correctly.

So yes, I think you're right, and we need to have that second variable,
and then do something like this:

	if (option_reject_shallow < 0)
		option_reject_shallow =3D config_reject_shallow;

Sorry for the trouble!
Dscho
