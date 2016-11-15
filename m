Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5DA2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 13:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933995AbcKONKy (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 08:10:54 -0500
Received: from continuum.iocl.org ([217.140.74.2]:33645 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933876AbcKONKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 08:10:50 -0500
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Nov 2016 08:10:50 EST
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uAFD4JS30264;
        Tue, 15 Nov 2016 14:04:19 +0100
Date:   Tue, 15 Nov 2016 14:04:18 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: git shortlog vs. stdin
Message-ID: <20161115130418.GA28847@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I observed a strange an unexpected behaviour in 'git shortlog'.

When in git.git:

$ git shortlog -sn | wc
   1441    4493   31477

but with input redirected:

$ git shortlog -sn </dev/null | wc
      0       0       0

--no-pager expectedly doesn't help.

Observed with 2.6.2 and 2.10.0-rc1.

I originally stumbled over this while trying something like

$ ls z* | while read name rest; do
  echo "$name" ====; git --no-pager shortlog | tail -4; done

where it also essentially terminates the while loop,
presumably by eating the stdin to the loop.

Bug or feature?

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
