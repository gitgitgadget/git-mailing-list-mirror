From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 37/44] refs.c: pass NULL as *flags to read_ref_full
Date: Thu, 15 May 2014 16:15:34 -0700
Message-ID: <1400195741-22996-38-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tI-0005pX-2R
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbaEOXQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:21 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:34856 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbaEOXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:47 -0400
Received: by mail-qc0-f201.google.com with SMTP id l6so325358qcy.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JlXkwpbKBlpWMROMkv6B87VdG0WhlJH6oTema8RuZS8=;
        b=IF1Dedir0cCO3ri3ZbJVE9wkkjcHuIzXlbdfasw+aHzaB1V0pVxgRqFmbyiTuHqxUD
         oo4WUP45/GmXgPXsiK+JOc/W9jmO044I+zO/DF4DarYfsF5f9agezmkvynV1rTWdyWJp
         adNuHnZxBvl6Gk/M8ImiibvG9CQ/76NFtEOR2ErS/bRpLSaiag3iWZ/8yCqqvc7rAlDH
         4dQCKL1uyT5VODZu3Fk2vZuEF5l9dBgoDmd5GTBge525E4ugvGEu24GdaUK5u3Hx+5e9
         SEzizBuHCwGj5hpg49MvaWpyLYZIeWO4q9N45OwvBaY7hBpkkwl4pAiTTs06xWt1A0i8
         gFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JlXkwpbKBlpWMROMkv6B87VdG0WhlJH6oTema8RuZS8=;
        b=Nyky36xVRHagNVCvL/VMFxAj9UeCIrku59sBMO4/104p4ShY39VdWWfz0cP94P+KXb
         G0drp/XM8QdShMzP1pcz5rWX14KIVylNGuVQ79nzvMmlGktSLc1IBTZegTWaf/mY/YxR
         2qoRkUsGrhbQi2ARMPGjfcHwJzUfngdxmWDUHBebYyp+bOCuiiSrF8hwYTCTzQdzltsK
         7mf5DV2tywnmH9+bE2d3PueI/wNAynyPtHZiVdz3Vt5S3MARiAZmfLkcSrJa77rGT1Tq
         bamqQMjFypuZNQx5DnULwumTXVZGWOcwCFjUvXpUMLa4Y18MU8qeJxmwldbmQHxFplPu
         zzxg==
X-Gm-Message-State: ALoCoQlfl1Xz3W2hjGp8nYDETighZMwTvt68jTBiMK0fRdtpFk5hVq0q0tS2ZNJbTDJTgkIa2h6E
X-Received: by 10.52.61.197 with SMTP id s5mr5794245vdr.8.1400195746200;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si318644yhk.4.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1231531C318;
	Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E2408E0D39; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249238>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 5369a39..e25345c 100644
--- a/refs.c
+++ b/refs.c
@@ -2640,7 +2640,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.rc3.477.gffe78a2
