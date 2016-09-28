Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126C11F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 20:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754094AbcI1Uq3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 16:46:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56644 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754061AbcI1Uq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 16:46:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 846EF1F4F8;
        Wed, 28 Sep 2016 20:46:27 +0000 (UTC)
Date:   Wed, 28 Sep 2016 20:46:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] Resumable clone
Message-ID: <20160928204627.GA27878@starla>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <20160927215143.GA32622@starla>
 <xmqqshslkndk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshslkndk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> >> [primeclone]
> >> 	url = http://location/pack-$NAME.pack
> >> 	filetype = pack
> >
> > If unconfigured, I wonder if a primeclone pack can be inferred by
> > the existence of a pack bitmap (or merely being the biggest+oldest
> > pack for dumb HTTP).
> 
> That would probably be a nice heuristics but it is unclear who
> should find that out at runtime.  The downloading side would not
> have a visiblity into directory listing.

I think making a bunch of HEAD requests based on the contents of
$GIT_DIR/objects/info/packs wouldn't be too expensive on either
end, especially when HTTP/1.1 persistent connections + pipelining
may be used.
