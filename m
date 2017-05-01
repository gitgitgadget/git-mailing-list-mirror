Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566921F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbdEATFx (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:05:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:52443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbdEATFw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:05:52 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1dDY7519Gc-009PIY; Mon, 01
 May 2017 21:05:41 +0200
Date:   Mon, 1 May 2017 21:05:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/26] http-backend: avoid memory leaks
In-Reply-To: <xmqqh915jrw2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705011358260.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <366e4d805da9b4b610fe216537de5e4a4c3941ed.1493237937.git.johannes.schindelin@gmx.de> <xmqq4lxao0ds.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704281117040.3480@virtualbox>
 <xmqqh915jrw2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8h2ZagYN82nOD34ja7CwTRmoASqdXLWTRIjP8BoiK8LB6qqXjSb
 Dz+GLV/hIt0LBVFSJfZIeYjFjSmHi2VkU2Dg7SZi8TrHl5FRUaQim9VEba9o4yAK4hHs9w2
 zAVnDx9Ali3zqxrc6GMbWyuWHrCmoUPDy+nFPNcAjl/hCK6zhU0hDgj9qot18xWnNFvHY8x
 p///fQHKZtxmQOViwYATQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cgm40gj80lc=:b9wmp4d2TjWttmKor9wDli
 ZhnjE0bAMmMVw3HN9J4H9MJQfWNTg/hQvpx7NZTO8CGBAhLVGQI16KIPodZooBUuTyi0mICmP
 3zK9cA4nqhqndP0HbMso4xOabjUqN62y3ZMCzO/bQHJKFNmhv4EX50o/TGWAzAfm54doi1Hq1
 GFqu/Evt8DTCkdUhviQLA6kMugi9gcHuu1jrhsg0FaWjdhbKVi1y7Swjw7KNndFiIbPGnPgNe
 3f8gdlL9yADcMGK93wBZ+NWTHARpU4wqvX59inNAkGGkeAGGkeJepE3BMSXY0otA9r9uzXcjS
 v5uEvNe4GYT1ZTL0YIx9oEWMLaVDNmGmF+9Uq4eYlw93KIUs4w/IWOo8fBnWSOT/eA+KcY/5Z
 RnmOTBrDuhw673p9X5Tg2JIk0M2rb92nb0ekcNMyqQBM9b/oB/VBAnJAGk4Wk/pjuC6aT0pce
 1C3lwZQcxnWhOmJxdbbz0SHHNVBAgDQrBUOQrPZehNZc2I3btKcR6lgOr+Mm9+H26TKxRgFZq
 ur9PqYQxtyjJFhBGq4ptnnXSwuukX2slw0JCLQGQ0j/PvmyIlDmtxSXD5B75r70pn5L5sP7TN
 sH6mvL4ChWWBiLjcCZFOZHTHc/4msjaaNOCLTXB5Xm29f58eOzSMlGC3xDL4Bv8Yo3J/PV5QP
 +ayIt7RUuFYAXmEZ9KfJAztVcpB+PoOEJHMs0GNhx/eHs+P///dvEJcEPlqdKoxBDRW+iQl6/
 8S6BlyGNCG8XvXs5UZLr6yKy9ZGvbNeJyPClYCCtRo+j5h4XnlKpDeMXzymWDwBfACACan/KQ
 8It33V+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 30 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Hmph.  I find a "leak" of a resource acquired inside the main
> >> function and not released when the main function leaves a lot less
> >> interesting than the other ones this series covers.
> >
> > Ah, I missed that this falls squarely into the "one-shot programs are
> > allowed to be sloppy in their memory management, essentially using
> > exit() as garbage collector" category.
> 
> I actually think it was a good intention of yours and I would agree
> with the patch.  The automated tools that find and complain about
> these issues do not know about our local house rules like "do not
> bother freeing immediately before exit" and will keep notifying us
> of leaks.

In Coverity, I marked them as "Intentional", so that they can be dropped
from the default view.

Unfortunately, the verdict "Intentional" does not percolate to other
projects, so I will probably have to do the entire shebang in the `git`
project again.

Of course, we could also decide that we want to shut up static analyzers
by actually *not* leaking memory, by *not* using exit() as our garbage
collector in one-shot commands, with the added benefit of making the code
easier to libify/reuse.

But I fear that I distract the discussion away from a more focused
attention to the actual patch series, which is actually still in flight
and in actual need for review, as I actually want to get those patches
integrated into git.git.

Ciao,
Dscho
