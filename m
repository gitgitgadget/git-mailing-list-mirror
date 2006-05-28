From: Seth Falcon <sethfalcon@gmail.com>
Subject: [PATCH 0/1] Tried to fix git-svn's handling of filenames with embedded '@'.
Date: Sun, 28 May 2006 11:15:04 -0700
Message-ID: <m21wuem2xj.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 28 20:15:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkPnL-0002q1-3c
	for gcvg-git@gmane.org; Sun, 28 May 2006 20:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWE1SPL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 14:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWE1SPL
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 14:15:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:62233 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWE1SPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 14:15:10 -0400
Received: by wr-out-0506.google.com with SMTP id i7so741224wra
        for <git@vger.kernel.org>; Sun, 28 May 2006 11:15:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=Xf9NB8/RX2e5TOb6Ay8LpfhNdt9GuHU0XbfehgfEPl2wBUgPbe2FtQhsgE1OTX4GOP/PHZ3zDLIJiPeDy2HyEsnu/XexyJtlTtHjsPST0Yfo7Oy1rNWCdz56UG0m/mn51B/dMZs8H5jS8Hy8oiSSh+0n6ZYXsfYNKGIm3WzOaHo=
Received: by 10.54.105.11 with SMTP id d11mr1367434wrc;
        Sun, 28 May 2006 11:14:44 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id 6sm2970363wrl.2006.05.28.11.15.06;
        Sun, 28 May 2006 11:15:07 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20884>

Hi Eric, all,

I decided to give git-svn a try for a large svn project and during my
first git-svn fetch operation, I'm seeing a failure that seems related
to recent changes in the handling of svn keywords.

Here is the traceback:

svn: Syntax error parsing revision '.R'
256 at /home/sfalcon/util/scm/bin/git-svn line 1124
        main::safe_qx('svn', 'propget', 'svn:keywords', 'Biobase/inst/Code/R/get@PKGNAME@.R') called at /home/sfalcon/util/scm/bin/git-svn line 900
        main::do_update_index('ARRAY(0x8395840)', 'add', 'undef')
        called at /home/sfalcon/util/scm/bin/git-svn line 926

Unfortunately, my project has a file named "get@PKGNAME@.R" and svn
thinks the '@.R' part is specifying a revision.  Here comes a patch
that got me going again.  Not sure it is the right fix, nor whether it
covers all places where some action will be needed.

Best,

+ seth
