Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2358207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 10:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944395AbdDTKlQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:41:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:51799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942990AbdDTKlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:41:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoJDJ-1cLUAp3bL7-00gEjw; Thu, 20
 Apr 2017 12:40:54 +0200
Date:   Thu, 20 Apr 2017 12:40:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
In-Reply-To: <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704201231350.3480@virtualbox>
References: <20170418194421.22453-1-git@jeffhostetler.com> <20170418194421.22453-2-git@jeffhostetler.com> <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tyTRIZPYalO2N4aW0NG+ACWEQe373/3Vn/Viek8VBSFDiZWen4l
 gudiqPeURFy4NTetz/5XUMyv+j9th5jnR0hDZIfs9FuA59sj29LRrsa4/AHHsgIZwPfffgw
 Iw1Ejmave0A9RjAIUwIa52hz1wxgpJ1ziq/6ec+od3yIWV5v9fdqegy+X2eL+RpdMSWieK0
 f+80cm8yl5zKBEmpvOkhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uW42oNMqWQo=:mnSlMvcaCbAt1jQ+kKG1M7
 5Vf1ggvLBgJkE7W/gJPkzJgUbuBnP5ksJdGwbnahkDYstdOp2hBUZNUWqIxksmiSNMiwmndSV
 NHteN2sNHjGmlMmLwISyer/7xOu5sVvid7t7zK/9/5F2Yxd1gySiNITd1kRgni5FHMJj2iKAK
 xbAS61+NG3UTatk5PFXXAEaMdYv3eREbmW7VTl+c6UpSxK43nXpu1RcojGAhGTrU8GfUux8Kb
 OvGqRA/B0+KzmUig4vW5M8o2Pz8p1EZWGmir71kYZ4dqtHkDRYTIQ2A8DzjJ9DSB9mii5qzBx
 avcgN8JNivZv/vh8Y7DxsTq2Q03Z+0kAcN38yKB1gY3oaKR7nIJSsx8eVzUlJ7Y98fXjQt39Z
 eG55lOvE/eWljQW1Jfy4cC7Co67MnOJEq6bmBBMf3GR4vgMfuxvoP6Lc3VRxPXq/zoA0gxshE
 hytPwSvJA3tQm6OZGWtnQvk182x3DYo9iOse31ZXDDeuwnlHvRc217Ksiwaf95AvL/S5qstdV
 dFM9SyDKAJVU58c4ZAA+D/xAjP4Q3QriL6T4Mim+moHuqjExPuK1WmsWWDWusz1zcvKbhG+kr
 TfSWzwrq1+ioOdbUKd6LaQ1dLviMvnr2vksTGR78SGbNVny+Y/PK2bIWXVXNRU+lwsIezq8Ti
 uVeHv+hfVG41OclY+l0lOdMx76xxw5jX1YlLj8cfDKJEiHMguZQFoE+Swq451JsGdvtw26VcQ
 eGboIafcRK/kjHg0MlIqZkDuWBu41AImPu9x6XgTuAUh0Ynh1qJFyDXhGaUGmoCDqg7HxC5VV
 APCPWig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 18 Apr 2017, Jeff King wrote:

> On Tue, Apr 18, 2017 at 07:44:21PM +0000, git@jeffhostetler.com wrote:
> 
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> > 
> > Teach register_rename_src() to see if new file pair can simply be
> > appended to the rename_src[] array before performing the binary search
> > to find the proper insertion point.
> 
> I guess your perf results show some minor improvement. But I suspect
> this is because your synthetic repo does not resemble the real world
> very much.

Please note that the synthetic test repo was added *after* coming up with
the patch, *after* performance benchmarking on a certain really big
repository (it is not hard to guess what use case we are optimizing,
right?).

In that light, I would like to register the fact that Jeff's performance
work is trying to improve a very real world, that of more than 2,000
developers in our company [*1*].

Ciao,
Johannes

Footnote *1*: https://twitter.com/GabeAul/status/846189637945110528
