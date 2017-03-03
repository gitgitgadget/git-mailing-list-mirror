Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902C320133
	for <e@80x24.org>; Fri,  3 Mar 2017 14:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbdCCOMT (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 09:12:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:49381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751799AbdCCOMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 09:12:17 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lfolq-1bvpva0lX0-00pLqA; Fri, 03
 Mar 2017 15:11:40 +0100
Date:   Fri, 3 Mar 2017 15:11:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 5/9] Make read_early_config() reusable
In-Reply-To: <20170303044630.tfogzhzbokuoiwh6@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031511200.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <64135c6df520c1ca6a6e667855ac03c14d2dd153.1488506615.git.johannes.schindelin@gmx.de> <20170303044630.tfogzhzbokuoiwh6@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8ltTbt/QfoY/d8au+p/8WfQetKD+sF+xRMxHvXzBGuwePu1VQyy
 fubTA1EkdQmB/5obJoC3b2UN3IFBiFSH4zi6mPl0O0/bTIo09ECP5UGXNJJXAnpE88Yapdu
 tU3wZ5qbuT+sneo1Ck+ZyvtULbxjGsVE6VtojeGVhq+Xzh7Dh+XsmrJB4eCr6GheLFADjW8
 gtrN/Nbw75TlNnx2SnJdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KlHCekteJ14=:BWDyuB6zbp9qfVNIdwi5q4
 ni1dq7zyjnK1bbZpijuklnqeRquMNmiZOREgeXBiJYdk0UVHJwY5LCHg6ZQpEnt9AK49IpLsy
 YXY6qLk2K9cqa9u593cox8QOv7JisK+BdQMXI2n18YESoTCNlC/mU/ozDJrUjaN3tW4zfPHtX
 AKtgjdhza/ppewpgYFy7hgPtqBD//7I0vH5CqE+FMcv26i6tH2HMZxom3972dmh3pGfuyNL4b
 4fiOYjGmWhPCZpRpNvvQhOUiwSrR8nk5C8uTjirIajPMBgCsyTBo/iOiJBzEhvf+nr2vOxMEQ
 dMNwyIF88Ou+sMdy0p3H606/bAiR//kbgJ8AIvyIxeeMKH7T7AWpXZ4k3q2UxTSHGhMSxxFqw
 WuMALHo/6Z/aFHcVSE1MdZsH6azzrFAz8WwxB0JuUByYp4FXYnpdCBgBfmOy/0gd3YmyMTjPY
 PCoCf5DmR9qYDEx2cApHsavjXogR5io6RgP7mD8PPqyqL2f6BmUK81FsaLnYwIJfLgSadYby7
 A72KS/sp0XNaGlBRNyRhaakWDlH8iZ/YdCiXjQtKRmigr7RpmmHuUi/bWe4NVdXbAoMzfvyIm
 X5JLAFKJrRtfd3iiBiCpkDg5RpqpPHzD+9NnHtpHmF13QvQ5S4n/bIpgMYo3c/JL2hrw2PA2V
 6j58LicAvTo2H1mTIb6nH+8nTZznrRUlLs9kMqrSYzc5/Bb9+/PTgUdXc/cCuGZ/avua9R+zG
 Ke2cWwY88nMwAibvzwHavv16IsDO0tloDLXqu8F058D9pmUIuxYdFxtD3qlSeWJmTCm06oNZU
 FQ4beSq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 2 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 03:04:20AM +0100, Johannes Schindelin wrote:
> 
> > The pager configuration needs to be read early, possibly before
> > discovering any .git/ directory.
> > 
> > Let's not hide this function in pager.c, but make it available to other
> > callers.
> > [...]
> > +	 * Note that this is a really dirty hack that does the wrong thing in
> > +	 * many cases. The crux of the problem is that we cannot run
> 
> Makes sense. I'll assume the words "dirty hack" disappear from this
> now-public function as you fix it up in a future patch. :)

Oops. I did not even think about that.

Fixed,
Dscho
