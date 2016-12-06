Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08041FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 14:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbcLFO50 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 09:57:26 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:38138 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbcLFO5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 09:57:25 -0500
X-Greylist: delayed 2333 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Dec 2016 09:57:25 EST
Received: from hopa.kiewit.dartmouth.edu ([129.170.31.49] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1cEGZb-00087d-7S; Tue, 06 Dec 2016 09:18:30 -0500
Date:   Tue, 6 Dec 2016 09:18:18 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git@vger.kernel.org
Cc:     Benjamin Poldrack <benjaminpoldrack@gmail.com>
Message-ID: <20161206141818.g5qxjt5wq2xbpkth@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20161104 (1.7.1)
X-SA-Exim-Connect-IP: 129.170.31.49
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: inconsistent output from git add about ignored files
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git gurus,

It seems that there is some inconsistency in output of git while it is
ignoring files:  

if a single path within ignored directory is provided  -- git outputs
the file path.  If multiple files are provided (some of which aren't
ignored) -- git outputs only the ignored directory name:

% git --version
git version 2.10.2
% git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	bu

nothing added to commit but untracked files present (use "git add" to track)
% cat .gitignore
*.me
% git add blah.me/bu
The following paths are ignored by one of your .gitignore files:
blah.me/bu
Use -f if you really want to add them.
% git add blah.me/bu bu
The following paths are ignored by one of your .gitignore files:
blah.me
Use -f if you really want to add them.
% git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   bu



So note that in the first case it reports "blah.me/bu" whenever in the
second -- only "blah.me".

P.S. Please CC us in your replies.

With best regards,
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
