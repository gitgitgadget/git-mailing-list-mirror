Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868C61FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 11:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425774AbdD1LCx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 07:02:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:51719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422810AbdD1LCv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 07:02:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyVcA-1e8nee24jG-015uUu; Fri, 28
 Apr 2017 13:02:34 +0200
Date:   Fri, 28 Apr 2017 13:02:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/26] line-log: avoid memory leak
In-Reply-To: <4ae94881-305f-380b-e786-c7f4ea5735e3@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704281301530.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <0051da81b5cffe53122c036122402418c7f8d55f.1493237937.git.johannes.schindelin@gmx.de> <4ae94881-305f-380b-e786-c7f4ea5735e3@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q2wV3/JflbyeCbz3gIcHmpk/XuMy0O+deRw6AADB0N0aHcR66Wa
 KvRNALvh6vEn7yHNoHwkkEb5trumNwhCPhTS0KXfF0oADCBmnpAOMM5AgGx4OzV5RJ+H8f6
 uGcUuBNd4siXoucMP/zxll374f35K1nBQvWG3wEt6m7PvzRpQghcDX307y+2Yc1oZMtUGO/
 whqeV83WCM4okbKumlR9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bR50MWiUPiA=:6sc/4TV50q4G06no7W3HLZ
 j+RXGGI6H6i8aE/z0VEpkmVGsEAkH/Ma6f01SkLNnWIMN6RYtEYqaCQJXFhj99cmvGaL8H/Ep
 9ijLXYgjHNPR6f1z7IMQx+0b/3nEecYdWEoeXqlAdUmbD0Rf1JZ2Wy/DSeJawdCkp0tGh3rhe
 86SKvKZRQei/M4s28e9TmfsA3sVtG6Qebo+fwuRpfjlzLO6w4jIJJn/fcECyeUrJFdDqpiTX/
 08JLCH9Kl7SMvYjOEnZM50H5tagB3vE1VSeSjli7+5QZ3N9FHPn37kmDuN4UDoFL9IRw5xUCJ
 cajCcZoU8SPUvVZSE93mSrDs6+P62AhIY4txgkvCci2sQRxdLfWbvQof5OwPd357a8hhrQh3u
 MPunLADpNQ3knA9C+LEDLwlcwm9Yk+benA58X6w31vw6zU+bUJLqgSSxZ5du5midsQu+FUfRY
 D8WplcK2eMyJRsa0LeSkp5KHQosXahT5VqoVLNV0TQKWXCx+L7kgG5qA0UNlXBzqrqQSLxlkS
 KcGDguVDXDM283H7VFBNjSwANG7W5RfKS/z4EB6pUeQG27gGje7XvmtS2wmbk31LlJ6HXdCIi
 LKYnXAxamfqlWW51W9ZN2A5wdZVO4AGUbyp9SyGNxDHRUQE0juebej9CnkcIrI/+02VzpKKXp
 7JE2lto/aGjJ4feLF/dvbYXKhQmNgrf4ry1NQKvkGO1JnGGZ3hAOS0Swm+J+iGqy1ojXAJXbf
 UE7x5hh2GbUQQHj67+fQkX0WwYBpbNOA3kQ7JjqaXL0+MZ0Vk6Kak3upAPcYy7tFeZ9WuVYAx
 Cza7y0H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 27 Apr 2017, Johannes Sixt wrote:

> Am 26.04.2017 um 22:21 schrieb Johannes Schindelin:
> > Discovered by Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  line-log.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/line-log.c b/line-log.c
> > index a23b910471b..19d46e9ea2c 100644
> > --- a/line-log.c
> > +++ b/line-log.c
> > @@ -1125,6 +1125,7 @@ static int process_ranges_ordinary_commit(struct
> > rev_info *rev, struct commit *c
> >   changed = process_all_files(&parent_range, rev, &queue, range);
> >   if (parent)
> > 		add_line_range(rev, parent, parent_range);
> > +	free(parent_range);
> >  	return changed;
> >  }
> >
> >
> 
> parent_range is of type struct line_log_data *, which needs more than a mere
> free(). I think it's free_line_log_data(parent_range).

Oh wow, thanks for pointing that out. Will be fixed in the next iteration.

Ciao,
Dscho
