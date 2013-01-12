From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 3/3] t9604: fixup for new cvsimport
Date: Sat, 12 Jan 2013 00:21:43 -0600
Message-ID: <1357971703-28513-4-git-send-email-chris@rorvick.com>
References: <1357971703-28513-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 07:24:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtuVn-0004UI-IT
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 07:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469Ab3ALGXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 01:23:48 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:53000 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab3ALGXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 01:23:46 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so3170591iea.40
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 22:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=VX3eBWslNSzdRYyO5PYDrarBbOYdcE4e0G+jiGgp9Yg=;
        b=aV2Tvz5cCRcvn5KFBp7ZB2uH8aogvsSKWAVuZG2riynNZWhPIxl0ixB+5p2ayTWaie
         53E9gkEuW+FoJiHz350yyJtJ52RJnc9KLrHvFgmRrXJCEpg7NU+xrnNQyFCeDWML2bBI
         GUTStUJ6eAbDtG3vv49pTgmwZSbvQu2eTnkT3TUVFMCtviC0YhNEWkLZdJeZVH6gOm3i
         e3Wt3dhHogjNNb3NqFhC1v5Asp0hD0IjtPFAynCV9nvIsYL6eMnw+3NKgRO9PzRSgbBb
         nyIrEPkUWXYm4Fd1An9GIdeiv8w1KdJRyGYRYFWIR5krlqC54tq104PLZ+YAsFVLJA4s
         6ItA==
X-Received: by 10.50.184.232 with SMTP id ex8mr1396089igc.30.1357971825753;
        Fri, 11 Jan 2013 22:23:45 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id ww6sm1426280igb.2.2013.01.11.22.23.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 22:23:44 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.335.g88a67d6
In-Reply-To: <1357971703-28513-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213270>

cvsps no longer writes a cache file and therefore no longer can be told
to ignore it with -x.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 t/t9604-cvsimport-timestamps.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 1fd5142..b1629b6 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -7,8 +7,7 @@ setup_cvs_test_repository t9604
 
 test_expect_success 'check timestamps are UTC (TZ=CST6CDT)' '
 
-	TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
-	git cvsimport -p"-x" -C module-1 module &&
+	TZ=CST6CDT git cvsimport -C module-1 module &&
 	(
 		cd module-1 &&
 		git log --format="%s %ai"
@@ -42,7 +41,7 @@ test_expect_success 'check timestamps with author-specific timezones' '
 	user3=User Three <user3@domain.org> EST5EDT
 	user4=User Four <user4@domain.org> MST7MDT
 	EOF
-	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
+	git cvsimport -A cvs-authors -C module-2 module &&
 	(
 		cd module-2 &&
 		git log --format="%s %ai %an"
-- 
1.8.1.rc3.335.g88a67d6
