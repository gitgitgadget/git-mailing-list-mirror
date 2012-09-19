From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 06/16] Add documentation for the 'bidi-import' capability of remote-helpers
Date: Wed, 19 Sep 2012 17:21:20 +0200
Message-ID: <1348068090-31988-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:22:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM6w-0005ul-D0
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab2ISPWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:22:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64575 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab2ISPWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:22:36 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so596995bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0UfOhTXpHQa2Wn+14r4bO+8EguLPyYXzt9pway0URLU=;
        b=r1p6hTVDfVqm3sT79Md+3OUx1FmlT2CTf7K7o24huI241hqcgCaMdd33EdlXFyICAg
         PGLoG3A3jGodw9Tgw4t1Gu28Ezer4q5JKEfZCg/SKgrSVImCrldA9TjPJHX+1WDEQgHZ
         DDmx32yzwmokVB095cO5vuOSO5l1uz8D0w3PIU//yh3DT/9FpyJs+g7bj5TZ53VUNshx
         tkn3Y+L2uaadZyOM1JhAEBH++Y1A8hDMowMCnmhW+aDMfMGGR8IXT//9fbRKLrgerXum
         K1qBqvENoSpJyttKQTzDsSFk4ahbBV3sPWJWBbQMVr6YxzajNRDRApPStnZ0iHvSilot
         cbpA==
Received: by 10.204.132.80 with SMTP id a16mr1464765bkt.82.1348068155508;
        Wed, 19 Sep 2012 08:22:35 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.33
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205932>

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
no diff

 Documentation/git-remote-helpers.txt |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index f5836e4..5ce4cda 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -98,6 +98,20 @@ advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
 there is an implied `refspec *:*`.
 
+'bidi-import'::
+	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
+	to retrieve information about blobs and trees that already exist in
+	fast-import's memory. This requires a channel from fast-import to the
+	remote-helper.
+	If it is advertised in addition to "import", git establishes a pipe from
+	fast-import to the remote-helper's stdin.
+	It follows that git and fast-import are both connected to the
+	remote-helper's stdin. Because git can send multiple commands to
+	the remote-helper it is required that helpers that use 'bidi-import'
+	buffer all 'import' commands of a batch before sending data to fast-import.
+	This is to prevent mixing commands and fast-import responses on the
+	helper's stdin.
+
 Capabilities for Pushing
 ~~~~~~~~~~~~~~~~~~~~~~~~
 'connect'::
@@ -286,7 +300,12 @@ terminated with a blank line. For each batch of 'import', the remote
 helper should produce a fast-import stream terminated by a 'done'
 command.
 +
-Supported if the helper has the "import" capability.
+Note that if the 'bidi-import' capability is used the complete batch
+sequence has to be buffered before starting to send data to fast-import
+to prevent mixing of commands and fast-import responses on the helper's
+stdin.
++
+Supported if the helper has the 'import' capability.
 
 'connect' <service>::
 	Connects to given service. Standard input and standard output
-- 
1.7.9.5
