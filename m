Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080F4C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 19:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615E720BED
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 19:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CFUp+DP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWTHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 15:07:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:43263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWTHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 15:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600888056;
        bh=bHYSuHxbyMYffPwRKyy3UnIkQUIKUgtOOYHdgvfT5GQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CFUp+DP+TRAYtkl10Y6ODzDaPM9MmVJuSV2HMyt5s8NMqvNIWYhU5TKkEULdSWmB9
         Teao+9unaOOJVvUHwe+3Y2zq2dP+TWDTi5ZNpfzvOe0EuqH4hvhTChQ5SDR+AcA+gV
         8tIwf4TmusRnMiFI4VxveCC13F+7IXqhOL8iWjNI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1kLA762bpY-0007VL; Wed, 23
 Sep 2020 21:07:36 +0200
Date:   Wed, 23 Sep 2020 17:05:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
In-Reply-To: <20200918172747.GD183026@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2009231702160.5061@tvgsbejvaqbjf.bet>
References: <20200918113256.8699-1-tguyot@gmail.com> <20200918113256.8699-2-tguyot@gmail.com> <20200918172747.GD183026@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hUHY5IOsXgUkGExAKqP0sCWDempaiDHfeovGLk0uArRT0AV4S5V
 p8bSHVEmEicgKV70PxoTVOVOgfobzLz5k5tSl94O1wb72stUiF1JVP5FJZ04HycKjvggKB9
 BwZQWgFvetxti81d264PD2YkDYFBbyocsdNkBoLMWVg2K2R8uzwK+bwAkKpbdBBNnrg7kci
 /6mezir7/w616rRUNNncg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CfDvFjoBGqI=:19Ass2tomwuGOAIW57WB3/
 G6smGqU5g80rQvoIhpBCbNUE3KUyhiH9Mld3Coamb3s6wSIWVH6W3xqj5mM5cotJuHF/Lex63
 oZ1amhiQJhxkS2XM5CQh3bQnEoeK/kdAJE1Yy0Gd+5qpcvz+PYwp8U16A1jtYovIQpE49XlZN
 R2fDaJKJ05K52znA49r/K9HWorigsego/vNGI+nlQWmNbNOJQIqoeQb0+MAk24qz6NhQKb49+
 byCEquxS6jq5aKMYti6tJkhEukNJYRR2q8J21RuuR2j3MZeRRp/oD6ESV6F0OQkdnrFA0+s9u
 ZnkBngnN1g/uTMStqOw5MR9cVVrs1MQMM7fvRY2+waH+zE7mJGWcS9nd81NsX9Rw7vbZiEJNg
 zA+YKLq0H0btICJW4ql+g3VO04xrNqJaQX29EMLGqALv0G/jCB7roP4FWKgN9ViIIj50hgvwJ
 Qpy8edGhR/U1b8aR8XvklNtoN6D9nmO+Td3SkOXg2a9gQ6yWc6aQSYDUp1gUW3BSpxhQ5GqSa
 a1YiDhtiB701RdX8zJTW+6T3JzB8VZApDeOPLkOZA38bp+YUn8JYMx4f7qIkFJFlY88ORKgVS
 o95rpr/QnxAL8FHiJuRO6eDZOaWnbAKyVOQPi+p3W7PUkzpiFNI4py1m6dvBDbanExrHRGE3X
 v8sYXFoiIVujkR5URDIL2hNgbbASyjBRo5LCVQrhPSgxAhP0FBBYe42VQNXnz595j+AFM+UZB
 4ENl6ZFZzWfaPp7X5DR33Yzp73Epqm+Fl6RtpqQOg6NwUFBp7TuHiU4Ww5jUefbfz9dR84Tj+
 JOHLobc75IWs7a+cBlKLpYjqy8WiVRNVKzmXGrDzO48lFLZd95GhzUiihnm61gZzFzdneuRCH
 s/OuhqEc/SAiCC33nL0bGlI+sEzjy0zzv1fQG4+P4woUYh3fqwuVW+ylxoeFNryiyv8XQWMn7
 sRB6J2a0jc+ZuKllLizTyFmVR/bNOC2qwflxKeC0wb7zirb285ZmtiDXz0jyyDzCYvlFvxufe
 RwMrsDm907/Mh39qWubeL5hwhUMDL72ru81nWRv36NiwuNrAFRc8gqNiPpsUepgrZ1swQFZrG
 zUQEhueBx1hkpfa+pgTAkeGvO9LJFcWAf6WYkOpU//TdxYAPxXE7II5iGOaA35CuWEAPgG8Id
 kDyiZpfhq6eSTU657GJpVwwRO2N6X7blfEgZle+qVCuUh/Rj56lHQYDBWIRDSrl+5yho12sTY
 x4o0BSV8Hu3sY/Al3v6X10+LnWuILSJiY58RSGA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 18 Sep 2020, Jeff King wrote:

> I also wonder whether range-diff ought to be using that flag
> [`oid_valid`] instead of is_stdin.

From `diffcore.h`:

        unsigned oid_valid : 1;  /* if true, use oid and trust mode;
                                  * if false, use the name and read from
                                  * the filesystem.
                                  */

That description leads me to believe that `oid_valid` cannot be used here:
we do _not_ want to read any data from the file system in `range-diff.c`'s
`get_filespec()` function; Instead, we want to use the data provided via
the function parameter `p`.

Ciao,
Dscho
