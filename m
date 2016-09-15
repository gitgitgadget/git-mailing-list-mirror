Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF702070F
	for <e@80x24.org>; Thu, 15 Sep 2016 13:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934811AbcIONCn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 09:02:43 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:37198 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934411AbcIONCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 09:02:36 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
        by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1bkWJG-0002w2-1K
        for git@vger.kernel.org; Thu, 15 Sep 2016 09:02:34 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
        (envelope-from <yoh@onerussian.com>)
        id 1bkWJF-0002vx-OO
        for git@vger.kernel.org; Thu, 15 Sep 2016 09:02:33 -0400
Date:   Thu, 15 Sep 2016 09:02:33 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git@vger.kernel.org
Subject: [wishlist?] make submodule commands robust to having non-submodule
 Subprojects
Message-ID: <20160915130233.GC9833@onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NB echos some questions of mine a few days back on IRC about Subprojects
and submodules 

If e.g. you just 'git add' a subdirectory which is a git repository, git
adds it as a subproject but doesn't initiate any entry in .gitmodules
since it is the job done by submodule and git core itself is
agnostic of those beasts.

But having then this "Subproject"s which aren't registered as submodules
(and I haven't found any other use for them besides being a submodule)
brakes "git submodule" commands, e.g.

$> git submodule
 cc6a09ac06c13cf06b4f4c8b54cda9a535e4e385 ds000001 (2.0.0+4)
 0a9f3b66e06a2137311a537b7377c336f1fb30ad ds000002 (1.0.0-3-g0a9f3b6)
 9da7e4f4221699915645ac2003298c6aba2db109 ds000003 (1.1.0+4)
 fe16cacb5cb9b4d53c50e498298fab182500e147 ds000005 (2.0.0+3)
 6898d99ff3ba26880183ed3672a458a7fcde1737 ds000006 (2.0.0+2)
 bbd10f634fe87e9d5853df3a891edbdb18cda7f9 ds000007 (2.0.0+3)
 138e6730193c0585a69b8baf5b9d7a4439e83ecc ds000008 (2.0.0+2)
 ddf3a4cf7ce51a01a664e6faff4b8334b8414b1f ds000009 (2.0.1+1)
 7fa73b4df8166dba950c7dc07c3f8cdd50fca313 ds000011 (1.0.0-5-g7fa73b4)
fatal: no submodule mapping found in .gitmodules for path 'ds000017

which then stops without even looking at other submodules.

I think it would be more logical to make it a 'warning:' not a 'fatal:' and
proceed.

Thank you for consideration
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
