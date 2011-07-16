From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 19/23] transport-helper: Use capname for refspec capability too
Date: Sat, 16 Jul 2011 15:03:39 +0200
Message-ID: <1310821424-4750-20-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4YY-0005RE-In
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab1GPNFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:05:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37348 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab1GPNFB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:05:01 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996059ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=d+g5vQw6s1AF1M3dEuMvQ6rvNTIOKFekK1IZ8EVNXRs=;
        b=AWmEczDN4Un00bmVxNQlGllfqXKADH3f+DrR+Y5If375teHw9RfxiDnNRZuXVu6HTn
         bXPxkiH0CCwaKAxqR3sXgQ016AH56Y84Q8OW980bAwBpFPWNo3C/0e+WhopNvm9dx7WK
         FN62W5FwFbLzUwSC7H7F2nIDGA4XLYDTvJOSM=
Received: by 10.14.10.14 with SMTP id 14mr1620546eeu.178.1310821500664;
        Sat, 16 Jul 2011 06:05:00 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177269>

Previously the refspec capability could not be listed as
required or their parsing would break.

Most likely the reason the second hunk wasn't caught is because the
series that added 'refspec' as capability, and the one that added
required capabilities were done in parallel.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 transport-helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0c00be9..0cfc9ae 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -181,7 +181,7 @@ static struct child_process *get_helper(struct transport *transport)
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
-			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+			refspecs[refspec_nr++] = strdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
 		} else if (mandatory) {
-- 
1.7.5.1.292.g728120
