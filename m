Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B2C1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 12:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbfKGMlB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 07:41:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:45231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388392AbfKGMlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 07:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573130453;
        bh=LDXDI5XuV5RCXDea7aNsmp0weTbZU7dugy/h9cfMt70=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZuVCA7tNp3qqgnacc+2QpnRVpsfQNzw5GJQZVmu2bZWZvPu+s5tkRvb7jh1fRqO46
         bw2uu5iLxOT3ZMDSa+HzW4u1dbiyj30o3rpDY4GfjbpTcJnhWjLzjMesOuaPh8iv3u
         oWKs35TckJfAcQAqrp+fLRW+VyXnepcEIAPwvZWY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1hb0Vc3PEK-00s41s; Thu, 07
 Nov 2019 13:40:52 +0100
Date:   Thu, 7 Nov 2019 13:40:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
In-Reply-To: <xmqq1ruks0rz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911071338320.46@tvgsbejvaqbjf.bet>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com> <pull.453.v2.git.1573034695.gitgitgadget@gmail.com> <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com> <xmqq7e4dtd9n.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1911062031480.46@tvgsbejvaqbjf.bet> <xmqq1ruks0rz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1048645582-1573130452=:46"
X-Provags-ID: V03:K1:OVyZriQ2M8FWjb7PAjy6keje7i5jB3wfQkTqXB7JtIzgXn43RZm
 Kl8xw1OCTJoQjZ8ML+AiEqfts+mWTMo382/uI9EPolkzCCPopsaOcjOFFb3i8UR2TviO9Fm
 xCTRdeE9LTf33Rp72oalDDHkq1Mrt/O7TY0b2fp4nBVY+/5rgPoI36zzD90pKHLcfr4gYt/
 Gs6W4hxrbWReWPDGSnokw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T2eGS4JH7zo=:XqBWn5bCFwyRs1femh7Q+K
 diRfe2b/DPHPdHfU9Udk8dTNk+W8wbuEL4aOp91OgnybY27wLqM+97fqZe+1kIvY1R8GVJ9Jg
 MO3JIslvNDPUSskHDrARB5kpwxCMI5DIt0bPnsUclcOm902X6Ghg2kotHZpRvdMON6zi6AAgv
 ftuk8ZsJDyIwB7i8eEBIYjWDmwiORFFCxhDf9ZO7PE2K9JaNaz+WooC+2xka31ao6kWAg4rBf
 xhQDmPOZRi7mkU2pNZecD9T2dgTnbkL37Q7VPZQi2Js9P0vFzKuSEifnKmkEEj89g0IB95itB
 SzbxVGH7D9BxqJAiryS3vEseQynr7ZHbrqzCjuZwMeLJsYSjHHa2l7YmkPMuFSp9HJ659ipyw
 b8m1MsUTzcDJQtyXg5psaWjXgFw9h/hxqgiMsvqqW4S02ORre2N4j7DzYupEdyppCTxNrgAmn
 vxZKMk5lmGG7/7+3NMbcV1YdZ//4XOndLiCq0KejN2cZyFIfNrTldh3q1jPpiri180IWK1Hp+
 nsMD3N4Z/UXzKbuoZjVAwnYrXUpCP8h5t5YtpDISZa/ZzVTG6ggmaWuPTCcto+g0L1Mm4jV/5
 7haSqnNcNwPDzytckzbq1f8NJgdwf8UdodMODbn3v3iCvY5Eu614BkF+wIRegIGAILzj4MDQm
 +x0n8rgk+IdEC7LirfFykbwtIuhkyORbuUUh4OF/PHMxZOquqSEZgTN9iZi9Fdg7Q9zp+suym
 RQbvcY5N4h70sWCTLm40U0PHZORlJ7KN2eGmC8lUpkdokz8hmRXAra/uzUKLGQ/Jo9LZy6sBG
 r60p6OXfb1Yo/hg4LjN6vDx8FrktXZ2xYqjcYtAezSLbXGzmC2jF08q7WZfg3Qe3Lqut72UM4
 jmJYgu4GXu5aSlnQxjpNmvXQb8LZFtRTRne9J7CMhXLq04VR55q0X1ynoL5pt1gOXnu0eeNEi
 TZBddTh4U8ooZJ7kjQTX4vc7PaYqYnjz4oeEe/YZi4S3fG1Iq3BYfUndyp7nR70lZDja77nIg
 Cuw2en/2MAfol1rDI2gq4mpieOsWg98TiRtOvOfF6byxiUgRUxtPRKcqQiEKDFJithUVvRqmq
 2pnVSjEuUEDxQjD8PUuiF0BhCUWMgI7ayS8bdYCHMcvDoua69nKu5IcOIil2pzPt2Hp1F1LeJ
 LYsiArSEOz87Z/S1oue9qzwQ3LVx+HuhW18/g5jsHCV0/fTReqRaHAyr0i0lfgjHgeenmVc3v
 ePpODE3P3XOB1QLr6qEWC8rSPHXynNiYpbs20ZmOmt47wz0vKg6oAYZEpVcM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1048645582-1573130452=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 7 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 6 Nov 2019, Junio C Hamano wrote:
> >
> >> > presence of custom allocators, cURL would attempt to use the wrong
> >> > allocator to release the memory.
> >>
> >> s/allocator/de&/; perhaps, even though it is clear enough from the
> >> context, so it is probably OK as is.
> >>
> >> > A na=C3=AFve attempt at fixing this would move the call to
> >> > `curl_global_init()` _before_ the config is parsed (i.e. before tha=
t
> >> > call to `slist_append()`).
> >> >
> >> > However, that does work, as we _also_ parse the config setting
> >>
> >> s/does work/does not work/; presumably?
> >
> > Indeed. Could I ask you to fix up locally, or do you want me to send a
> > new revision of the patch?
>
> You can certainly tell me to locally tweak, but you'd need to be
> more specific when some of my suggestions were "perhaps" (aka "you
> could do it this way, which may be better, but I do not care too
> deeply---I am OK with whichever you chooose after you (re)think
> about it, but I am not choosing for you").

Right, I should have been more specific.

> For now, I'll do the "does not work" thing only.

Thanks!

FWIW I would like to stick with "custom allocator" because even
releasing the memory is the duty of an "allocator", even if that
allocator happens to "deallocate" at that point what it has allocated
before.

Ciao,
Dscho

--8323328-1048645582-1573130452=:46--
