X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Uninstall rule for top level Makefile
Date: Mon, 11 Dec 2006 22:14:09 +0000
Message-ID: <200612112214.09735.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 22:17:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=AdrdtxOUK+g4nef564n9pnvOOZ5dUQ19lSTq7hPaFhdFbACRibbX+IxAVxIMTBpVg6/qPrEBXw/ePIo8GGmQJ+njK0y+GKfw/Dx9rQGVjj+s/dG+aSrR7ebZy+FMtOw9GUQvnX8Rk8pPb2syNqWSNOudL/MOglSdyGl3CQ7wCvo=
X-TUID: 270ffe52aa52b548
X-UID: 188
X-Length: 1092
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34046>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GttSP-0000hS-HM for gcvg-git@gmane.org; Mon, 11 Dec
 2006 23:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937608AbWLKWRG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 17:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937678AbWLKWRG
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 17:17:06 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:7069 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937608AbWLKWRE (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 17:17:04 -0500
Received: by an-out-0708.google.com with SMTP id b33so336972ana for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 14:17:03 -0800 (PST)
Received: by 10.78.201.10 with SMTP id y10mr1714477huf.1165875422213; Mon, 11
 Dec 2006 14:17:02 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id y1sm2913365hua.2006.12.11.14.17.01; Mon, 11 Dec
 2006 14:17:01 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Makefile |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index a1861de..51c1747 100644
--- a/Makefile
+++ b/Makefile
@@ -821,6 +821,20 @@ install-doc:
 	$(MAKE) -C Documentation install
 
 
+### Uninstallation rules
+
+uninstall:
+	rm -f $(subst %,$(DESTDIR_SQ)$(gitexecdir_SQ)/%,$(ALL_PROGRAMS))
+	rm -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X'
+	rm -f '$(DESTDIR_SQ)$(bindir_SQ)/gitk'
+	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' uninstall
+	$(MAKE) -C perl uninstall
+	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
+	then \
+		rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
+		rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
+	fi
+	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 
 
 ### Maintainer's dist rules
-- 
1.4.4.1.geeee8
