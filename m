Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0650EC2BA16
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 12:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC2F206E9
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 12:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Y0xS2aQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgDDMRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 08:17:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:58563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgDDMRY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 08:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586002638;
        bh=ePJO90AK7/6gsKOcv4NSmbx8M/3o/ROws0TK3mMmHXw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y0xS2aQpySjQZvMkwSzlyfotLLpHnKO4KOHKR7RIxYKBJC532vlxl2yfxXYGwObf+
         /Pvdie4okGryb5qV2Zaq1ZnNNuagOsow56IB9tTmTzjd7EmtrXzeZ/YywdH3Az3P1a
         1iyYGyPUWCPszrhxi9JPuNHVK1A47vtptn6d0S48=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.7]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N3siG-1jBwGE2LAm-00zlu1; Sat, 04 Apr 2020 14:17:18 +0200
Date:   Sat, 4 Apr 2020 14:17:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     George Spelvin <lkml@SDF.ORG>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: Feature request: rebase -i inside of rebase -i
In-Reply-To: <20200331000018.GD9199@SDF.ORG>
Message-ID: <nycvar.QRO.7.76.6.2004041414370.46@tvgsbejvaqbjf.bet>
References: <20200320223015.GA19579@SDF.ORG> <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG> <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet> <20200321175612.GC19579@SDF.ORG> <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG> <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet> <20200328163024.GA26885@SDF.ORG> <20200331000018.GD9199@SDF.ORG>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l9BpkKqe+8lAKAdNkD4Y6UvN5qgB6MDmMu6h7dl9I8dsMSaXSDZ
 mi22t5QfLohHhWO3v1gaKu/vjoDS0bqp2xpHbTDkrpyV0ZX5OGbuarGrls7OjpbAQZPO4sM
 EjtAdvQq4jdAojuFXog2bwDVj2SB0Ypv/hLDizpmkr4jHG4X3UnAHNuZHAo0ihSOP7cU04Z
 ZDIoGPeMzpyld/vv3EQlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u1Fnd8uyKgs=:jtxu+nO60p2Q5WFIpHYQpN
 RcI/tTyzkMeAgJdUY+Xq8N1Pqgof8shcR6CIhwYlJr/Sn45Veq+AmFOT6ZtQVhrdRrEYB7z+5
 BthAZvUeP48iVW/WLgOC6W1M5tggYqmWYOPRVZb38leflFMx/aDCRS3FBuqwFEjlJHszcEkyV
 6ohQJHuifYBzg+5WJEq6XuVD5nAEev7PmSi0y/HgUH7K49qJRAL6/O6+sQqr0WDk3q2o633QR
 9mqRvrww2VH9aYlE3FEdLIlk7ntMsxGSr+c7rKQTK+/QWCW1xdmzjBq3EzSDjWRFBM+uW1KU/
 LCUYJu6JTQ8HPBIB8nvLTguz7GymXehI9Gb1k22iCxjgnV/HHflWHoxDKX4dG+keVFW1tXOjP
 9DaWNZ7Z7yd+rrkOHALA84s05hS/vOjMK0gJ2i1Y47a2m222i8kMx0bR6XkxjEDkism2SnMEF
 vGpJ23hJBh3cLqLRsp5wIc8vrI4ULJ0p5z/xFkivdrZa1xCsMdftMmKnCyhrJeBd8FTm0Y2Qb
 Bp9P9rLgS6l8TOoYOnrTq+nZID7GDtU7MOJI5g5+Zqj5aGwfIPTSyLngkz8L6viYV+LZqhQpw
 gIKZHOyPVIgL1Z7i8jexAz5DXwajgr5OPEGbFlI7rrtKnWoPWMYTlHlOt72VVlQHdIeqB7Tzp
 qr1X46D1X8RLGHYvVNwQH9dvGElBV7D45pkmdmj+Zwg5zVIzRQuUuPAxsDFZiIVYqJJrkkeru
 etCIw+ImGMNC145mibABrWbtk/CK+g0Q34TVZwNAfftwX2BFtLNGWeyKh/OWPP6//s/BJ/+iJ
 WTaUGuVNCBlx44CR1Dp4ct9gPAFEVRMSD84aN4TA7/4UswCR8sD08vjja9+mmnMf+jSGhGUGk
 Igu2UKtQsWxrvkrlyaqkVX43F5xU8oquSHNlGZo65sEosW3ZMKdb4df4lI4okcryOHEMa90Sl
 mvDnco0ebM0EPyF15ytwhDowwob6wCv3SYlgXAuiCb75g6sjW+MQcFGY2rJkeY48Tp6jHnA8m
 t8V8qvJUERe2hcRRaNVh7NXs0cL+GFS4aeaCwOC1bKflgY3S0hMa3eJyunBr90K+X5qVkD9Hv
 6fT/Yh222ZlKox6kf111rdU1DDWin33CTiiPaSzBXBJTFzNXfF1HXurjXWyBekVdE/ozUj4ma
 81gJY/E2vpsRPB4sctgoESdbDwL1p5x2lHFNRxS8CgjA+MogaNJLpE/orFRBSsaCvEL9WBgII
 yCLDSuS48G7jbXyjb
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi George,

On Tue, 31 Mar 2020, George Spelvin wrote:

> Thinking about Philip Oakley's suggestion, it dawned on me that
> we can *already* do a nested rebase manually, and having a less
> manual alias for the procedure would be reasonable.
>
> Suppose the last four commits are O-A-B-C, and whether they were created
> by this rebase or existed before is irrelevant.
>
> If I want to rebase --nested -i O, then I --edit-todo and
> prepend the following four lines:
> reset O
> pick A
> pick B
> pick C
>
> If a nested rebase command does just that, I think it would cover my
> use case.  If it adds a comment saying "nested rebase ends here",
> it's easy to cancel the nested rebase if there was a mistake.

FWIW this is precisely what I do in
https://github.com/git-for-windows/build-extra/blob/70d940d1b/ever-green.s=
h#L184-L246

I create a new worktree (without checking out anything), start a rebase
with a custom (fake) editor that simply grabs the todo list and aborts
that rebase. Then I remove that worktree and insert the grabbed todo list
into the current one.

However, I find that it is not at all easy to cancel the nested rebase
because the current `HEAD` is recorded _nowhere_.

Ciao,
Dscho

> A slightly fancier thing a nestrd rebase could do is see if any of the
> newly created picks are also used in merges that were already in the tod=
o
> list.  In that case, follow the pick by a label command and update the
> later merge to refer to the label.
>
