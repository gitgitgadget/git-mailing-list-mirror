From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 42/48] refs.c: pass NULL as *flags to read_ref_full
Date: Mon, 16 Jun 2014 11:04:13 -0700
Message-ID: <1402941859-29354-43-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbH7-0003dl-UX
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbaFPSEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:04:46 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:49737 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so684424qcv.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Vfo9GWGgvexlKkqxpl7I2HrRB/NJ59+5TevD+FWa0o=;
        b=ZelCLbsNfLuf8upl5SpqA9KM50ouD6FHE2YcJoq+OqsY+VQngAazH5wtzz+pQ37ngi
         bN241nyOBqpXFDgBC8++NSJpeOgDAdGXNbWdscPAhmpm38t3mzwz8HW0mXYou+hVSK6z
         xqkyy7dcFEjYV7r1qlxdGxI/If9s1h2C7kIwsXclKv4cwdcTR535uTgusXRqi2I7sWLm
         FA3TUlNd9mv08/mDP0gOh1wjrFmlMoydGTymMV5eISdNU8NkAkWo2or4FyCotWtj7Hyt
         U5gqH4wuBynG48eOH1EUJXb2QZMGwC24wnCOD7NZDk+Bd4/uPcwAxUqVF3f1qs3sqmgm
         a7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Vfo9GWGgvexlKkqxpl7I2HrRB/NJ59+5TevD+FWa0o=;
        b=DZeLbAisHge6uOzzEB2+ki5Xs+j0driargvkqTP6Xao59Gxo0tX2tYjFPJDtT/5xLK
         bRw/hMGA7iSUrfh6KWbHVgAVy3iGXeKy9r62FKja2tsO57+pLHA2/W4/EEVAgmUsvMJv
         vyU6qWBvUywSmpOrD17R2OrWWhnoGMKYdb0E3F3tQOyfVeGpw5dZo164gXdMtXJxcye4
         unRT7HU9TWrJ4kZrHHHuB4CM1qtx0pyXVB6DTurpJGgw+5pCEea3MCIqMJ4q9suJbrZM
         4WrCqTcOCUdBzzsw1ByMf90UnfFYtS4Ch81IRO8h7Uj0AJqKd2oZlcjyzZmop7uO/kqu
         NUdw==
X-Gm-Message-State: ALoCoQnFeo/uj/6ClWN0GbQFBtPiCnL0hHSIjEwkAHmMPp5xsMjgZ7Gl4CAXqt7BVSZRy0cvmDA+
X-Received: by 10.58.48.233 with SMTP id p9mr168383ven.31.1402941864123;
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si996139yhl.7.2014.06.16.11.04.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DBBE231C8AC;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B7FB8E05A0; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251745>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 58c9df4..7b80bb3 100644
--- a/refs.c
+++ b/refs.c
@@ -2662,7 +2662,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.282.g3799eda.dirty
