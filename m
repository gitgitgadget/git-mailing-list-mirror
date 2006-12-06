X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: unmark after committing with git.el
Date: Wed, 06 Dec 2006 13:43:55 +0100
Message-ID: <4576BB0B.9010200@xs4all.nl>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:44:23 +0000 (UTC)
Cc: Alexandre Julliard <julliard@winehq.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 40
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33446>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grw8I-0003Yb-KQ for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760563AbWLFMoP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760564AbWLFMoP
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:44:15 -0500
Received: from main.gmane.org ([80.91.229.2]:55876 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760563AbWLFMoO
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:44:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Grw83-0003hs-3i for git@vger.kernel.org; Wed, 06 Dec 2006 13:44:03 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 13:44:03 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006 13:44:03
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Hi,

in the usual workflow, I mark a few files, and then commit, and then
mark another few for commit.

This patch removes the need to unmark between commits. 


From ad694b33e033e3638043cd2d2970e6248beecb91 Mon Sep 17 00:00:00 2001
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Date: Wed, 6 Dec 2006 13:41:09 +0100
Subject: [PATCH] git.el: unmark files in after committing.


Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
---
 contrib/emacs/git.el |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 972c402..642f7bb 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -596,7 +596,8 @@ and returns the process output as a string."
                               (git-run-command nil nil "rerere"))
                             (git-refresh-files)
                             (git-refresh-ewoc-hf git-status)
-                            (message "Committed %s." commit))
+                            (message "Committed %s." commit)
+			    (git-unmark-all))
                         (message "Commit aborted."))))
                 (message "No files to commit.")))
           (delete-file index-file))))))
-- 
1.4.4.1.gc9922-dirty


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
