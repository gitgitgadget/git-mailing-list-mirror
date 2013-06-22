From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 00/14] Classify {branches,remotes}-file as fringe features
Date: Sat, 22 Jun 2013 13:28:07 +0530
Message-ID: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIlX-0007o7-29
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab3FVIBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:01:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:47824 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab3FVIBl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:41 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so8874821pad.4
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RbP3PMY9ZEjxmbCzn61iAPmx58sxDRoL3TPD13eWVHQ=;
        b=MNfoGfZ/R6pLfDDyamZXUxYXPYcs2cLrXVNw3kW9Fo4809Tr0a3UxIzGnSCpDFpP7J
         2hKwiQsiN8uxGx4RF9VpA1vmZj2ile6q3EZRTUKgjd+0ThfqQAp2r6BX5kHX09pq/BA4
         sjKdYFWSigdwmOa5BvjO8wKr8C+5R0etxWCxER8mip0lfDH+rMvAxGkUSRhXIOBegoZC
         qbi5d5xnP+4LUqy+KQ9tYTOTxY0a444HKENkSlFmJHUZaFQpvd4xCD22Xp6KJBC/Ii1Z
         iK79qFxmRmJI1Sjx3t2c5jqm3EgYNbY1iRQyla+ia5aifoPKVNVVR7diizNEO482M343
         O1BA==
X-Received: by 10.68.25.102 with SMTP id b6mr15737047pbg.105.1371888101062;
        Sat, 22 Jun 2013 01:01:41 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228677>

Hi,

Since I didn't explain the series properly last time: this series
reduces the burden of the branches-file/remotes-file cruft.  It does
not argue for deprecation, because it is still useful to some people
and harms nobody.  It removes dead code, tests the feature properly,
and doesn't mention it in obscure places.

In this iteration, [1/14] does a file-wide style cleanup (wasn't as
painful as I thought).  Also, one s/git config/test_config/ patch has
been dropped because it adds no value.  This time, I actually ran all
the tests to make sure that I made no silly mistakes (there were quite
a few last time).

Thanks to Junio and Eric Sunshine for reviews.

Ramkumar Ramachandra (14):
  t/t5505-remote: modernize style
  t/t5505-remote: test push-refspec in branches-file
  t/t5505-remote: use test_path_is_missing
  t/t5505-remote: remove dependency on $origin_url
  remote: remove dead code in read_branches_file()
  t/t5505-remote: test url-with-# in branches-file
  t/t5516-fetch-push: don't use branches-file
  ls-remote doc: fix example invocation on git.git
  ls-remote doc: rewrite <repository> paragraph
  ls-remote doc: don't encourage use of branches-file
  t/t5505-remote: test multiple push/pull in remotes-file
  t/t5510-fetch: don't use remotes-file
  t/t5515-fetch-merge-logic: don't use {branches,remotes}-file
  remote: add comment about read_{branches,remotes}_file

 Documentation/git-ls-remote.txt |  11 +-
 remote.c                        |  34 +-
 t/t5505-remote.sh               | 852 ++++++++++++++++++++++------------------
 t/t5510-fetch.sh                |   9 +-
 t/t5515-fetch-merge-logic.sh    |  28 +-
 t/t5516-fetch-push.sh           |  16 +-
 6 files changed, 516 insertions(+), 434 deletions(-)

-- 
1.8.3.1.498.gacf2885
