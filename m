Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6BAF20A40
	for <e@80x24.org>; Tue, 28 Nov 2017 11:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbdK1L1s (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 06:27:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:50058 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbdK1L1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 06:27:35 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lk8CY-1erKAZ0Isk-00cCbu; Tue, 28
 Nov 2017 12:27:25 +0100
Date:   Tue, 28 Nov 2017 12:27:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Takuto Ikuta <tikuta@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
In-Reply-To: <CALNjmMpc2F4OSrQPBtRGwu6RM=V81PXJxOrP2w9dLdtL1=F+kw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711281226490.6482@virtualbox>
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com> <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com> <20171127043740.GA5994@sigill> <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
 <CALNjmMo3KH4QXY00ViVaiHdy=pSZ5j0BWRueO1T=sC_r0=3c3g@mail.gmail.com> <alpine.DEB.2.21.1.1711272222100.6482@virtualbox> <xmqqbmjn9t48.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711280132480.6482@virtualbox>
 <CALNjmMpc2F4OSrQPBtRGwu6RM=V81PXJxOrP2w9dLdtL1=F+kw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3i1Xq7QtZ6r+kNLHMrbWt4z39KYz85Hb04R/8RMUulYXxrkdKFm
 2NFlK6UCO9gAzWGCkLHoThwwLBublkIOZOT2wYhA2ZFti4vaQwKcx7WlMsotYBtiYQSYYmh
 UCne6WKGZzsoMEddLT2zpKeCFbW6ue6exQ+c0/+MWWz0L5GUIsd5nDtv9gh1UF2wH6LT/0E
 vfHrZdvs7MrorPZjxA+sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IMQWlZayUW4=:LGJBQCntgeglJKME9k4nmm
 6V86wxg5zB1EDMmuLrnLNhDZvQJ5uejbRrqQjMLuIfgpxfFv+uhQvFS1cOjHRgUW7XyQCgw5A
 yF3zHD9zb9lavMdm5Jw20Vn9X+nsipUfaQ+u3i/GyhvQwF/9iRBZSL4fN/yjTXBxJHv1krLbB
 mDtWo03ud+CJKbu+wKo6mSGem5XlWeEyA+87438f0vc+yJWngNQooUjqaeTcR09ylHQPPZQYh
 ppPHq7eWauQ2za7Uy38ff9GM38sDGZkYCR7ylQ3khgarYBBSK2lvzLSq8TPMKaeAap2ASCIfo
 En7UgJ7fHI2XTy/tsVF4mkQ+eO40NiiYQf2GzrkNjLLL8kvq8CPpK7HUvtJUlp0OpOv5DDatY
 8+S8IXhWCqX2eubdsE9SHQqVokQuGaKE1LmbSnw8GBISrT4saI+R82gCOS0hUpeqqPRqSUUED
 rd3H/XCaqH+9doY1sCGjb041WdLlfwHr1NbCiQer7E5pEB0DdM2QZMh+Lc2hoTNnvjyodnhAe
 v+ibsVdZbtzg7IMb3zbRyv+h93AYkcuz/0tDQf4AIweMEvZv83EoNN0WdGxxhSc3Jj5ycF5Yc
 hXi26S+rOM76Q3+MXtMx2ww0+LYV2mDrxdWCUi223OqaFrFrckgxaCgrvW6Pu94XLFCqWlyS8
 wiCIm+yYCTpMima2IB/B7PmLr8FM85gzS6ALqZG+eN0+3X6BcujTzz7uQcPvAKCDSWtgF2sGX
 1V9GE6iD/PaBkzLAeVljz1GVRXSfwnURnjl7cZTvvpZAqT9rC+wZsws3RWYlMEjQjw2k3LvYs
 V1rr/1PFl+2uSOKYs1jrcxe72gUx7wSsWErkmMMhYJJKXrlrNo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 28 Nov 2017, Takuto Ikuta wrote:

> As long as this PR is included in next Git for Windows release, I
> won't suffer from slow git fetch.
> https://github.com/git-for-windows/git/pull/1372
> 
> But I sent you 2 PRs to follow right way.
> https://github.com/git-for-windows/git/pull/1379
> https://github.com/git-for-windows/git/pull/1380
> Feel free to merge these PRs.

I amended them slightly, and merged them.

Thank you,
Dscho
