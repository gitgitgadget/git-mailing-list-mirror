X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 3/3] Deprecate author and committer details in stgitrc
Date: Sun, 12 Nov 2006 00:31:21 +0100
Message-ID: <20061111233121.17760.27045.stgit@localhost>
References: <20061111232322.17760.26214.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 23:31:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061111232322.17760.26214.stgit@localhost>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31251>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj2Jz-0006sG-AW for gcvg-git@gmane.org; Sun, 12 Nov
 2006 00:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947327AbWKKXbb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 18:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947328AbWKKXbb
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 18:31:31 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:62930 "EHLO
 mxfep01.bredband.com") by vger.kernel.org with ESMTP id S1947327AbWKKXbb
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 18:31:31 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84]) by
 mxfep01.bredband.com with ESMTP id
 <20061111233129.YGGA9747.mxfep01.bredband.com@ironport2.bredband.com> for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 00:31:29 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport2.bredband.com with
 ESMTP; 12 Nov 2006 00:31:29 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 4B7D44C04D; Sun, 12 Nov
 2006 00:31:29 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

There are two distinct disadvantages to having author and committer
names in stgitrc:

  * They override GIT_AUTHOR_NAME and friends, not the other way
    around as one might imagine.

  * They cause stgit and plain git to use different names (unless one
    manages to keep them in sync manually), which can't possibly be a
    good idea.

This patch removes the description of these variables in the example
stgitrc, so that new users aren't tempted to use them. They will still
continue to function, however.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 examples/stgitrc |    5 -----
 stgit/git.py     |    3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/examples/stgitrc b/examples/stgitrc
index 45a629b..9cd95e1 100644
--- a/examples/stgitrc
+++ b/examples/stgitrc
@@ -3,11 +3,6 @@
 # the former.
=20
 [stgit]
-# Default author/committer details
-#authname:  Your Name
-#authemail: your.name@yourcompany.com
-#commname:  Your Name
-#commemail: your.name@yourcompany.com
=20
 # Automatically Bcc the address below
 #autobcc: your.name@yourcompany.com
diff --git a/stgit/git.py b/stgit/git.py
index a6e1a63..f654cde 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -452,6 +452,9 @@ def __git_person(p):
=20
 __cached_stgit_persons =3D {}
 def __stgit_person(p, name_key, email_key):
+    """Calls __git_person to get the details for a person, but allows
+    the deprecated author and committer variables in stgitrc override
+    the result."""
     if not p in __cached_stgit_persons:
         person =3D __git_person(p)
