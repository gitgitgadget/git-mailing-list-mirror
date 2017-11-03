Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB9A202A0
	for <e@80x24.org>; Fri,  3 Nov 2017 10:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753876AbdKCKcv (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 06:32:51 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:45643 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdKCKcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 06:32:50 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 03 Nov 2017 11:32:48 +0100
  id 00000000000000A0.0000000059FC45D0.00007570
Date:   Fri, 3 Nov 2017 11:32:48 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171103103248.4p45r4klojk5cf2g@ruderich.org>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 06:16:18PM -0400, Jeff King wrote:
> On Wed, Nov 01, 2017 at 10:46:14PM +0100, Johannes Schindelin wrote:
>> I spent substantial time on making the sequencer code libified (it was far
>> from it). That die() call may look okay now, but it is not at all okay if
>> we want to make Git's source code cleaner and more reusable. And I want
>> to.
>>
>> So my suggestion is to clean up write_file_buf() first, to stop behaving
>> like a drunk lemming, and to return an error value already, and only then
>> use it in sequencer.c.
>
> That would be fine with me, too.

I tried looking into this by adding a new write_file_buf_gently()
(or maybe renaming write_file_buf to write_file_buf_or_die) and
using it from write_file_buf() but I don't know the proper way to
handle the error-case in write_file_buf(). Just calling
die("write_file_buf") feels ugly, as the real error was already
printed on screen by error_errno() and I didn't find any function
to just exit without writing a message (which still respects
die_routine). Suggestions welcome.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
