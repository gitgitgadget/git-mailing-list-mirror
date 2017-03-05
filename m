Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA1D20133
	for <e@80x24.org>; Sun,  5 Mar 2017 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbdCELCm (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 06:02:42 -0500
Received: from lang.hm ([66.167.227.134]:53296 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbdCELCl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 06:02:41 -0500
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v25B2PA4017731;
        Sun, 5 Mar 2017 03:02:25 -0800
Date:   Sun, 5 Mar 2017 03:02:25 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org, sbeller@google.com, bmwill@google.com,
        jonathantanmy@google.com, peff@peff.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
In-Reply-To: <20170304011251.GA26789@aiede.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.75.62.1703050258200.6590@qynat-yncgbc>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Translation table
> ~~~~~~~~~~~~~~~~~
> A fast bidirectional mapping between sha1-names and sha256-names of
> all local objects in the repository is kept on disk. The exact format
> of that mapping is to be determined.
>
> All operations that make new objects (e.g., "git commit") add the new
> objects to the translation table.

This seems like a rather nontrival thing to design. It will need to hold 
millions of mappings, and be quickly searchable from either direction (sha1->new 
and new->sha1) while still be fairly fast to insert new records into.

For Linux, just the list of hashes recording the commits is going to be in the 
millions, whiel the list of hashes of individual files for all those commits is 
going to be substantially larger.

David Lang
