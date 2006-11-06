X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Add a MIME-Version header to e-mails
Date: Mon, 06 Nov 2006 08:45:32 +0100
Message-ID: <20061106074532.10376.60478.stgit@localhost>
References: <eile19$p7r$1@sea.gmane.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
NNTP-Posting-Date: Mon, 6 Nov 2006 07:48:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eile19$p7r$1@sea.gmane.org>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30999>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgzDc-0002dT-W7 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 08:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030257AbWKFHs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 02:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWKFHs2
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 02:48:28 -0500
Received: from mxfep04.bredband.com ([195.54.107.79]:5504 "EHLO
 mxfep04.bredband.com") by vger.kernel.org with ESMTP id S932789AbWKFHs0
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 02:48:26 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84]) by
 mxfep04.bredband.com with ESMTP id
 <20061106074800.WAKP15709.mxfep04.bredband.com@ironport2.bredband.com> for
 <git@vger.kernel.org>; Mon, 6 Nov 2006 08:48:00 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport2.bredband.com with
 ESMTP; 06 Nov 2006 08:47:55 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 5BB834C04D; Mon,  6 Nov
 2006 08:47:19 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

This is required by some mail servers that want to change the transfer
encoding of the mail.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

OK, this is a test to see if adding MIME-Version makes the problem go
away. I don't have any other way to test this than sending a patch to
the list. :-)

 stgit/commands/mail.py |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 45f7438..c428d67 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -271,13 +271,11 @@ def __get_signers_list(msg):
     return addr_list
=20
 def __build_extra_headers():
-    """Build extra headers like content-type etc.
-    """
-    headers  =3D 'Content-Type: text/plain; charset=3Dutf-8; format=3Dfixe=
d\n'
-    headers +=3D 'Content-Transfer-Encoding: 8bit\n'
-    headers +=3D 'User-Agent: StGIT/%s\n' % version.version
-
-    return headers
+    """Build extra headers like content-type etc."""
+    return ('MIME-Version: 1.0\n'
+            'Content-Type: text/plain; charset=3Dutf-8; format=3Dfixed\n'
+            'Content-Transfer-Encoding: 8bit\n'
+            'User-Agent: StGIT/%s\n' % version.version)
=20
 def edit_message(msg):
