From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 35/42] refs.c: pass NULL as *flags to read_ref_full
Date: Wed, 14 May 2014 14:17:09 -0700
Message-ID: <1400102236-30082-36-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:18:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgZJ-0003MV-L6
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbaENVSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:18:25 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:42550 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaENVRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:32 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so36122pbb.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vnj8wUEXT633dJXPLjPu2Pcv937gW9X3XEj7evVIns8=;
        b=eiZscMRmRzlum3KuemXxglcTd86kBAO0So6dTqiSTYnecAJsHpsSDXtzSNCyzw74+G
         KMQb302Fkj6c4fLbychfXzOTjU3rnwHVVzspzC9jm+zET6ww0QtH2A45n4PAJHaOkkCH
         eyNkPCvpFjjttmw/0ivQ5JquLR8Qnl5Uo/wsKsoyPr9rMKO8kueQJe2CdbjCTOihgEbb
         tiElYFPEQweeIwUzagjHG9h/7RyesdasA24xkdolwMRXN8gWmwbvuWncGvXXLyErfsTR
         uzpPEgzIWyp8U/lwFttvYq+yP+DcLWU6G6568FgRyvhlYdAJ5Q0pViPCaExcXtaRrgN6
         JKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vnj8wUEXT633dJXPLjPu2Pcv937gW9X3XEj7evVIns8=;
        b=Jl7ePBC1RX4KNzDbQ+MOwj+uL9QD9mBO+JtnbdQ3KTuqIXGG3zl9V6ieIkcUasDLgc
         /XFtrpyuztyDXfiWCFMcSlfn/2LZBH0b7Xd9H4QFaDeCuzUkl+Jx0TEgYx4xlx7cxM3f
         Zo/NdvB8RQhXzOMI1MYI8ykRhmQf6zgwwcioYfvEIF+BydOCWKwz0jb/n5MPz5OYpghe
         7Sve3bsRvQfi+MS1BHsB7Z4i0aYleUZigeHJ0gTUhV0GmfX+FYoVz73u5nVZB5UAaHaQ
         mrC4LPncE19oFUVICmMTDmh+K5NZOPNdJ7EvsP3AH9BacE9S2XetDhp5nlmqrtb3dxKU
         G5wA==
X-Gm-Message-State: ALoCoQkU8H3IcjLuhn8JGHDfrMAJHDEI6s4VhVkMsvi85Ilyqfuex75s67nvQ5k5B+X1wu9Y14LU
X-Received: by 10.66.65.109 with SMTP id w13mr372894pas.21.1400102251816;
        Wed, 14 May 2014 14:17:31 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si145573yhq.3.2014.05.14.14.17.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:31 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9FDEE5A4345;
	Wed, 14 May 2014 14:17:31 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 63DA7E0973; Wed, 14 May 2014 14:17:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248963>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9ac9f38..cb14420 100644
--- a/refs.c
+++ b/refs.c
@@ -2601,7 +2601,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.rc3.471.g2055d11.dirty
