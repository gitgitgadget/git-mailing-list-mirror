Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E523DC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 13:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiHVNyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiHVNyI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 09:54:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B82FFCF
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661176437;
        bh=ZBU41MvzXDmzh7v8g7cZbf6whvvsCj2ysk5yqYQFCiQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ae5+gUMRcOrtLirgvfKZBs3En8VeCf4wPtT0u6sk8NtwW2gDETYZrusNnzFlzP0Q+
         KG+zRNR1LS7y0KYh5gr6fQ+WUv5vdkuQumGi6IB7Z7LkgNsw34pOE0/S/hQEuu9SvG
         j1eMClA0TF2sN4xrwAlmN1bArmcyU0I20JwkkPqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.137.196] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1pPxxK0GuN-011jYR; Mon, 22
 Aug 2022 15:53:57 +0200
Date:   Mon, 22 Aug 2022 15:53:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] sequencer: do not translate parameters to
 error_resolve_conflict()
In-Reply-To: <xmqqfshsm8z1.fsf@gitster.g>
Message-ID: <oqq42q11-3031-91or-no50-p68q85po1492@tzk.qr>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu> <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu> <220818.86v8qp8uid.gmgdl@evledraar.gmail.com> <06s6r3s7-27nn-1o9s-1n7p-5413284r8740@tzk.qr>
 <xmqqfshsm8z1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pnmWFl9M/Kf2aMNLtj2gMTcorFCWaxSZ4jHcU6gs/6htyExZDP/
 B7xKVuuLhqz0UCIJISQtyeUFc742AJ+s+rgDhDHnhf4c+Kz5xLe3Uod38JxvN1ZzZVpqGOb
 0O3XuQGSRC0mTQGks0roeh+lp/DJZhqf+55on/g7bx8fBu42tDNC8oSpsK3r4o5iveFNlBy
 zgDX55s6w28Y+R21tweZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OEnGZTA5nlg=:6sEEELahs0GZ2Z8VAGMwK3
 7DwC9usXgzxODyAD+lF7LuIkedaCvx/hWZ3VaDSnXMcoqL+F6R3TA5ykMR2YVAEIhXyA0Wc+0
 PQcQbpVqFA5el+qjdIQzmxEAZrM7dWF1ZDIMhNcirXOYj+7iXEIFpXCziP7fgvgjncoNbjtaA
 cmLWjTCvNzgBs+O8S8D2vwEsFcZ8ALRpUMWVG1FzYfQnrlMUgPD1pjHGa+bZePKjJ2J7i+S2s
 KIqtSNHw7H52BcLzmZGP/l6UyLt+PtB1IT+8pkz8+HHWi8qiTH/GzgDXEbgGJZaRrnX7U/YDj
 YGpIvaAXg0Tym4ZRiUzYgmii3xW1z83DRY7JoGJiHwhsG9ioYysj7QnpYzDC9FuKB21G8bZ0s
 Vm/yRJL7ru/htW2thb6/DTQaYzsPMuyXBwVQQw1oF+1Zmmqckbmx9Bre5sl7Fce8FPkJvdORd
 vYobMdJ3YTP4ktUOyWdax0GMy7sp9QATp/mrQ1wooQpyCR5JTxescIEFQ+SjrudKKzOZUoqIW
 zQpgpVyqtfl8gzWTHr1++lpH3vJYMwvjQnE1liypgpBAWfHXnpF5DkyqgW9Mv5OiXHAy1V/XU
 LmyIBCr5fc3W26x6VuZ3+lQ2+kUJakzcZj5z1UJl6kvw8QoDyYiNb3WickDwPXWX2nL1gD4pX
 nczEHXKFkCdmI1qMWfW3lof2X+SbeubdN9zZQGu6jfwra97t2EMgfZRn2QnmIEp9ibD3Vt6LJ
 oheREFvhInFWk1tcZ7SDYD4R8nVztQNc1vSkS3tT4sNhe/ufV6kTvjh0c3U9lqX1upai8lkCo
 xR1ter0RtjsbFQLdvLNZJ9DzKc4pCYczlKmwVobgz4CSPppZtHo5bCxIJynarDXvdU0HXXgs+
 wUG9/OZjdn4VWJqoSU0OH3YgBStGo73wuEJyVNlNvhZVp/L3ycYRXppQdg3m8bajL+ZHi44xS
 a8Q2VJoeepE4yOV8TuTqVU2p6YUBBLW4V5PtLUygEuvs05pwsEBA+j4gyaMKHspHimnF8OXqT
 CI+Yrf8r7zgQ39y0bbowxupxrrktbA9oZ5dkaXHxHMNnfQvWv4aGYp1sO0FSVWG66REWMqn5i
 FnQlsyK+aZWz3U21Ff+0h03VjEaSAyxZM8LVOWdrw+gqzvHSbIbOls4nw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

[Michael, I do not consider what I wrote below relevant for your patch
series, you may ignore it if you want]

On Fri, 19 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Perhaps we should have the error_resolve_conflict() function take a
> >> "enum replay_action" instead?
> >
> > We could do that. We could also just delete the sequencer code. It's j=
ust
> > that both are a bad idea.
>
> Sorry, but I do not quite understand this comment.

I expected a seasoned reviewer to offer such a suggestion only after
looking up (or remembering) how `error_resolve_conflict()` is defined, and
where, and where its callers are.

After all, many suggestions that come to mind during a review turn out to
be a bad idea when considering them carefully, and if that can be
determined before the mail is sent, everybody wins back some time.

In this instance, `error_resolve_conflict()` is declared in `advice.h`.
The suggestion to use a sequencer-specific data type there sounds...
controversial. But okay, maybe there are good reasons to suggest that.

Let's look at the callers. Two callers in `sequencer.c`. Okay, maybe it
makes a bit more sense. But one caller in `advice.c`? Let's dig deeper.

That caller in `advice.c` is `die_resolve_conflict()`, which is called in
the built-ins `commit`, `merge-recursive`, `merge` and `pull`.

Those callers have nothing to do with the sequencer, therefore it is a bad
idea to suggest using a sequencer-specific data type in that call chain.

=46rom my perspective, that is enough to retire the suggestion.

When I wrote what I wrote, I thought that it was a pretty quick thing to
determine, so quick that I really expected to not see such a suggestion on
the mailing list in the first place.

In hindsight, I understand that you would have had to look at the code,
and not just at the patch, to see this. And therefore it is probably not
quite as obvious as I thought. I did not expect new contributors to be
able to analyze this quickly, but a Git mailing list regular, yes.

For my flippant response, I apologize.

As for the suggestion I criticized: I stand by my assessment. It is not a
good idea, and it was not necessary to send it out before doing a cursory
sanity check. We want code contribution to have a high quality, and the
code reviews should meet at least the same bar.

Ciao,
Dscho

