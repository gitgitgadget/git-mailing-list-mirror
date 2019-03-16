Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3E020248
	for <e@80x24.org>; Sat, 16 Mar 2019 22:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCPWMl (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 18:12:41 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56460 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfCPWMl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 18:12:41 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1h5HXc-0003df-9V; Sun, 17 Mar 2019 07:12:32 +0900
Date:   Sun, 17 Mar 2019 07:12:32 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Richard Hipp <drh@sqlite.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: git-fast-import yields huge packfile
Message-ID: <20190316221232.m6mphdnwy6mys4j2@glandium.org>
References: <CALwJ=MzrqPUNw=jc0NRtaJaJG+ErXNb577JNSN66GiGY4UFtRw@mail.gmail.com>
 <CAADWXX81agAg1B9+FM5c4JsWzANKochNTcv2ShsRzAsZpHAVWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX81agAg1B9+FM5c4JsWzANKochNTcv2ShsRzAsZpHAVWw@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 16, 2019 at 02:04:33PM -0700, Linus Torvalds wrote:
> On Sat, Mar 16, 2019 at 1:31 PM Richard Hipp <drh@sqlite.org> wrote:
> >
> > Maybe I'm doing something wrong with the fast-import stream that is
> > defeating Git's attempts at delta compression....
> 
> fast-import doesn't do fancy delta compression becayse that would
> defeat the "fast" part of fast-import.

fast-import however does try to do delta compression of blobs against the
last blob that was imported, so if you put your blobs in an order where
they can be delta-ed, you can win without a git repack.

For one-shot conversions, you can just rely on git repack.

Mike
