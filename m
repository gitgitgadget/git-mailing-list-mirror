Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AA4C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbiAEPul (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 10:50:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:56473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241661AbiAEPuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 10:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641397834;
        bh=vJkJeu8yNfwmCvw9Pq+4mEB24SwvG35XaMLh7Bmy4LY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hZDeteJSPAN2d2m0Ho7WcBlwIjP3DfFCtO2sus6l8LRettO7wbNR/ppH8fXk9mwmm
         p2taNVMo++akYznkCcoPrkF1m5ywIYv3YMBePWUgNuX6wcbKf9iu4tiZ1BA3yfAD96
         XqLDCCi9ljLmcmrZ/WYJwK9vV3/Sot/IW3hmp900=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1mr7nB11EN-00WmQX; Wed, 05
 Jan 2022 16:50:34 +0100
Date:   Wed, 5 Jan 2022 16:50:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     John Cai <johncai86@gmail.com>
cc:     git@vger.kernel.org, Tilman Vogel <tilman.vogel@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
In-Reply-To: <20220104214522.10692-2-johncai86@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201051649060.7076@tvgsbejvaqbjf.bet>
References: <20220104214522.10692-1-johncai86@gmail.com> <20220104214522.10692-2-johncai86@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2++6ywUh2XBbVfQET9H55K2x7xM96vcvYbsNpCzHGv2cJKjQvmq
 qp6BrKImMWiErstUIjx4/2BagfrNvrFwL6LqklOu89lMFVgi21bH4Z3/EMgbq4c+hJ/zBhx
 VF9XvaqqCFF3AJ8m0GlBzQ7iLcA3ZetlntQghQMq4jgjRsh1x6KgXayCHs8AYJEDOKbZF4q
 m+swHm0hTKkMMW1XLTSag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D7fYR9mEzVI=:N7fPSRWZli7ZecIAFVwCCj
 XQd9x6oHJXsZnYE6CUs6GUVcD5K57r/7LFN7dMxAtFrT8heaUxLDCkALB+gBvmAMrBQz6biP1
 TXje7dzFhbAu6tk7NEh+qy7dRH38ssfxVi9KvCnL4SL8pDtHwT3m4LXkGghO6d7zxHa0ERLX8
 +vg0phnS7TS1OV1GF4dXLLZKaUoHI738gW0Ni3eelzuE+AguT0ugDmzc7adcqyn9xU57COW1W
 8JFLFqtKFNlSb/OP/h2Mz5VkyKtL5b6uwbhNKGQFgGQWYX/heHwnBequsjHwkbtqwlGv3d5NM
 uKX88vmL3+7uyub7ABaNYXygpu0k//UsjbE51gNmZK1avXZQuYLzjZAGOWKnxNmHEGvlO131r
 eYy0sXH0x4oG+7tYf7iQGjuKid8R11qFtdEEHsHf3dgQ7SIP0VJDGd3Klsp07+B34FEfYdF+p
 Bs3XpRSnAY0sBBXwjb0hUYtSQG5NNaAxO+fJEVHn/0eGvurOg6R0P+Veb4fkxfHkSOg0K0Cav
 nFJX63Cyt7Zi8G0QWnhOmLjBi77wZW4ANtejde6tdsqUyql5+75hdqYl6yOCkYvK4eCstB+S+
 thpF+akegnVuiW1fYC7srhIJrbQRDlKFYADB09jI69tq2XPi90KP116DdBPqPzqyQyEJMiDSZ
 BrIVAsfnPc582VneRgyiGu3k98uqWUaMs6ULSYmet8xQXgqT5QFenw7HL0o8dX2uJ7pQOV1MR
 VOQ1ipsB6CCzDmgUZHAQVexN/7mlRK3U76tXdVH1mlyL3rSN0We14zAR5gyaKFRpLSpFyICcf
 xtSNcNZnUnk5uuxgioHWAlaje+IGK+xDoARzBB6eAF2Wz6jqvde3hpS8aRyl7WR7MufMkB+OA
 N5UpiDfp2I4QZSvNg4kcUGBcPknsn9V/AtpS8o54uhkDAlVB/hwJnJ922l/n+wLOXpLQGmFeb
 pzAIxU0cmkpByzOr79ilg4NsTq2wOvINgP279+gAGccwenS+kQvxFSO9Bf1/4ruVomKOk3xJX
 411fq9gzjAsG+7k2t/gYbJLnMLH1iyTZCqR4xym9Pkq1Fx2Rv9UK6B1E24rX8fb0lRtm3HcWL
 HdBQog9R8fjHB4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

On Tue, 4 Jan 2022, John Cai wrote:

> Reported-by: "Tilman Vogel" <tilman.vogel@web.de>
> Co-authored-by: "Philippe Blain" <levraiphilippeblain@gmail.com>
> Signed-Off-by: "John Cai" <johncai86@gmail.com>

We spell the 'o' in 'Signed-off-by' with a lower-case 'o'. That's what
`git commit -s` does automatically.

Was this the problem why you stopped using GitGitGadget? It would also
have helped you avoid the frowned-upon cover letter for single patch
contributions.

The entire point of GitGitGadget is to _not_ force contributors to know
about all these things.

Ciao,
Dscho
