Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A65F20899
	for <e@80x24.org>; Thu, 17 Aug 2017 19:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbdHQTzf (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 15:55:35 -0400
Received: from continuum.iocl.org ([217.140.74.2]:45165 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdHQTze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 15:55:34 -0400
X-Greylist: delayed 1844 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Aug 2017 15:55:33 EDT
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v7HJOaw05216;
        Thu, 17 Aug 2017 21:24:36 +0200
Date:   Thu, 17 Aug 2017 21:24:36 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: ignoring extra bitmap file?
Message-ID: <20170817192436.GA4782@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I'm seeing the message

   remote: warning: ignoring extra bitmap file: ./objects/pack/pack-2943dc24....pack

and indeed, there is such a thing (two, actually):

   171736188 Aug 17 08:20 pack-2943dc2477026f87b280ebcefa93fe28412688df.idx
    12662268 Aug 17 08:24 pack-2943dc2477026f87b280ebcefa93fe28412688df.bitmap
 12927989355 Aug 17 08:27 pack-2943dc2477026f87b280ebcefa93fe28412688df.pack
   164857412 Aug 17 08:33 pack-8b4a42ca7aa2aca6f354292007910de1110117b2.idx
    13164932 Aug 17 08:49 pack-8b4a42ca7aa2aca6f354292007910de1110117b2.bitmap
      281872 Aug 17 09:40 pack-bddb40f984124ba8c2a4e5c55b0d1b2804fd5817.pack
       13280 Aug 17 09:40 pack-bddb40f984124ba8c2a4e5c55b0d1b2804fd5817.idx
        7904 Aug 17 15:51 pack-0f8b1478e17174c562d9a52cf577e0e050bdb7c5.idx
     2373948 Aug 17 16:09 pack-23253e17510cacaae3bb38fb5429073b3bc59480.pack
        6980 Aug 17 16:09 pack-23253e17510cacaae3bb38fb5429073b3bc59480.idx
      144158 Aug 17 17:03 pack-0f8b1478e17174c562d9a52cf577e0e050bdb7c5.pack
 12927996484 Aug 17 19:19 pack-8b4a42ca7aa2aca6f354292007910de1110117b2.pack
      153332 Aug 17 20:17 pack-65ff13a10c29a6c1604017c50dc9a320044ee605.pack
       14036 Aug 17 20:17 pack-65ff13a10c29a6c1604017c50dc9a320044ee605.idx

But it looks like something went wrong in that repack cycle (that
pack-2943dc247702 is the full repo), and it won't get removed later
in the next repack in the evening.

Question: Can I safely remove the .bitmap file, and repack will then
clean up the .pack and .idx files as will?

(This is still that repo in bitbucket (latest 4.x) server
with git 2.6.2, now with cg.auto=0.)

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
