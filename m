From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/47] remote-hg: don't push fake 'master' bookmark
Date: Mon, 13 May 2013 23:36:30 -0500
Message-ID: <1368506230-19614-8-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc716-0003uB-Rq
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab3ENEjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:03 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:61499 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3ENEjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:03 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so101795oag.31
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=g4o47Or1l3Y6bNRBQ2UFmtJg56xcn8xIHa1wfpc3KSI=;
        b=Ku1em1n1N22OHAa2yIQCR5ZiX2BcTOnzFCywqm0FqHe1dN76V+DA18HORVD6AikrBy
         w0hWNZreITz68R15Qpr4VSViWLKh9Uo5QHaRLCEmccrRgxwJem/9mfuzaRLtSiuMvUvt
         krC18uN02/BiX4jcsiz3/Vqu/znyyo1N7TyJqSqbAaLTrWNRMSw3350lSmSHovILEwN1
         jPBCzs1DYg/0YW5wYd5oF1LmzqbrI9Zf0DWTsnRXS/+L/M9DStrJcxcPrzhEixBlL81v
         XRqoEjB8k7bWTANlNtpnNfdXV4NHedFUnjLkkneLwOc5+8MV0eehirXx0U/mHmE94Ua6
         BSpw==
X-Received: by 10.60.134.71 with SMTP id pi7mr12449340oeb.107.1368506341727;
        Mon, 13 May 2013 21:39:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm20068534obc.0.2013.05.13.21.38.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224242>

We skip it locally, but not for the remote, so let's do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 53412dd..beb864b 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -873,7 +873,8 @@ def do_export(parser):
 
         if bmark == 'master' and 'master' not in parser.repo._bookmarks:
             # fake bookmark
-            pass
+            print "ok %s" % ref
+            continue
         elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
             # updated locally
             pass
-- 
1.8.3.rc1.579.g184e698
