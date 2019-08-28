Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBAB01F461
	for <e@80x24.org>; Wed, 28 Aug 2019 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfH1M4u (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 08:56:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:40361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfH1M4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 08:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566996963;
        bh=m4GYLN2KtrU81ItH1WYjeJOois5tqXKMWLmNGkJLr4w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aShv0f5lzzV/aFeaMc6FJzm3eC50snpTnKrFvIKVdtrlk6vMFzB3a763wXNtt1JSY
         DEa0lMbIJpifxD0NCsp2wrT5ObqLegaVul4WG5L/p2dj7/7GF8ZDieoPFZ5ooDU7xh
         IFGg0sFT/zkOxQjFAv4ol6GwlpNnG3fxWmVWLkv8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN0jA-1i9X4d2WZk-006j6p; Wed, 28
 Aug 2019 14:56:03 +0200
Date:   Wed, 28 Aug 2019 14:56:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Wijen <ben@wijen.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/1] rebase.c: make sure the active branch isn't moved
 when autostashing
In-Reply-To: <20190826164513.9102-1-ben@wijen.net>
Message-ID: <nycvar.QRO.7.76.6.1908281454070.46@tvgsbejvaqbjf.bet>
References: <20190821182941.12674-1-ben@wijen.net> <20190826164513.9102-1-ben@wijen.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:10q/9Tyx6b+37ZPamQ1Jx4E70ii8frZ2W2ewyVj+HWQ22kuv3jJ
 tza5knVBvvga3D8mP5i9Wm5SGfqji5XWVD5neougq5uIp1Dek/BDm2QToyxKbsApiPq0KpH
 KnPv9oUxNk8edRuCG5PQmDybao9HJl/rFFd2XnmUDl6j51rEfqBWCTGARoTP0tnei7r89pT
 jfFXduqqUzFuxGLhiwqrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZQovCjyBEKo=:ws2yioDNiFaFk7YH4pWLnE
 ZUgHs21ciuuvvOlHU8lBWaiAakQQCPRAK+3KMwXT4pNyIyE1EzNUtnZdGtIYZDtjQNeU0nxi7
 TweBRoXoG1F7wVNESmlcWB9cdHN3C5iMIUsTZuwqbHWmtMnRpd/uyJq9xzzuQCi06Df75USUz
 XTweRyqyeKxpHF277Ij+pT56C2YjNCGsSykUHQ8tU1VW8ZFFNuKmaQH/fHwZDDE/9DC9bmjOJ
 9n9FVSOXPwn3ZazfAwLHkO77jHSuk1g2Hn3lhA64qcXxVmYopc6t5bp033tWr+mQUqU8sHMIx
 XHKqmBRfrMLqNFgbtA+efNz5THilXYUXXffJbN0Mk66/GoWwRnHbWFLCn7LGpo8hBQs5MBx2y
 QXq4v74+nMYMdfk/wFfjivx//dybXORL3oNigkX1OcnzNSj/RIklxbGGybZsVEXAicEyUewut
 4NlFAW8PUhuzTEAtT0tp5FWLq9jRkjTA5IBEUwPCF2YqIKZtYg9wKpdj58JydSPFER2wQtJRs
 qyc4G+dOgyl1Kvfh9KvobidXHX/5gl5H3ZkXWOhfpZ+OqIWIvvG3TOzHEmT5vy4q5dZBgFFh6
 Czln+9sypT1P78R3yVf+yw7jC7MGW8FfXxCtxxkYVegS6BO67VD613SzqqnwIfXap0ypzDaz6
 0lplIKC11l1bavih3KnB+Otb4G/NLRqT0XFTMJNu1MzedJzDdGCc9Wgbzm9zj25fbMEUtmoX5
 9snWUsXLdxqkZrdaio+gcTLHLgEhuyaelg1cmsgRLKi/ZVpZ0MgK+1bQ/7wsQVGOMGiaaPZof
 nkGMk14JD6i/furJhKzTLKWF0IWteUIh0zMtFMZ0Kntt333+67QnQw3eBclfkHSrxyR+oNRTX
 Iiknon+gQ+iIRrMRijMsHGzGVOZsWo3YYyWX0un2Xe/4W7PE+4vYudhkVmEVpdzgXH4tK99jz
 ZMNQOd+sQB9rykFGwPgdbeiQamrFPG8EBprhN0pv0K0c3A44vgErre7iyDyCn7qvnZIP0zHd3
 r/knfO4KsONc+0Z5UiRceR+R4QPunTPdJ1jGAUGuhpJhv7W385EWNwcDkTDNBmkMSp6GWzG/M
 xo4eKii1OdMhhv3755VkHb7ZjZC9SG6mlldAHJ4cdIBVP1emp1bLxOE6TChd0gL6Pxbne0MOo
 YH9o8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Mon, 26 Aug 2019, Ben Wijen wrote:

> Dscho's review got me thinking about the rationale behind the 'HEAD is n=
ow at...'
> message.
>
> A 'stash push' is followed by a 'reset -q' but since 'stash create autos=
tash' is
> not, we must do it ourselves. I guess the legacy implementation could ha=
ve been
> 'reset --hard -q' which would have also prevented the 'HEAD is now at...=
' message.
>
> Ofcourse I'm happy to reinstate the message, but I'm convinced it doesn'=
t add
> information, as with this commit the original branch is no longer moved =
and
> - as before - the autostash is re-applied after the rebase, leaving noth=
ing
> to be guessed about.

FWIW I disagree with the decision to mingle a bug fix with a change of
behavior. Resetting to the correct OID is of course the bug fix.
Dropping the message is a change of behavior.

I would be a lot more comfortable with a bug fix that did *not* change
the behavior, fast-tracking that to even maintenance branches.

And leaving the behavior change to cook in `next` for a while.

Of course, I am not Git's maintainer, if I were, I would insist on this
more careful approach.

Ciao,
Johannes
