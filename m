From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 37/44] refs.c: pass NULL as *flags to read_ref_full
Date: Fri, 16 May 2014 10:37:25 -0700
Message-ID: <1400261852-31303-38-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6F-0001eO-6j
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757717AbaEPRij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:39 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:63299 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so73470igb.0
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lFXie8nvdF6zYAtP6uLQRL3k2qOSVzPJSdZz+OrdRMk=;
        b=OOU4pgBRMfQPpT6IcHDzW1JkzQko6/ze0WP19Gj7r8wg595+gZ+M8X/uMFedHAl1fM
         bv2Sjwp2pPBbjro0ZOAwyhqaPwQr4TgLLSSNnO1G0Rk4W7p7oBEaRDmM1t2DeqAOiAfo
         yoHP7XqVH9aF2tWTdmDbaHgWXirRqNa2lbwgR4peJrPKNrG6EdAooRpqzYENaoIDsIIC
         pEGRomGvspnBsFSFoC5i0XSCNmm4udkg+qXiUnb24DQx/PV/oQI9Fhg+Zhszm91dQytH
         YmkSW9WegqDGlzrPxVfU7xbnME7rTxwDjL052jttDX1O1ubTpWtT/XSnlMKdB3iffQrc
         EUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lFXie8nvdF6zYAtP6uLQRL3k2qOSVzPJSdZz+OrdRMk=;
        b=Gi5eFAYMrXVZ7w610lsI1OZny/4Ak0qW2LgQ46GBe38Ur2MQcuFCDZG4zE+Am2VAux
         +65NyHGN18l4EiRhGAp5YSD/VRoa8HIRBD1viUHylxqD8lQa8vNDbhiJulv+/7TVnMx1
         cPLEVsOTPk4uVVC20aPOrau+WuVvFt609uZNOOBxiFOGxxWlRhnFVxKkQmQq+yVu9mkD
         Tm/kIQy5a9QXA6bGeti/qY+ZTiyQ+IfVwtqbmE5UnY/xgMcpyF3jhPsYADOCBu969tBL
         dTC8ntMlnoBMSsr+SDX2rv0iowpqkVnvfJkZICuaxGXKPiG5FtoNV82cBnX+WC9KyTWW
         pKLw==
X-Gm-Message-State: ALoCoQmoYXnZFg0JFRAX/2+N02aWFq2Ky3tGLvObG8yTCbZ3cSIFQIwEhgs0janTLydV8V+7bSvB
X-Received: by 10.182.79.41 with SMTP id g9mr8922547obx.41.1400261858616;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si442887yhj.2.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7593031C227;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4F9EFE0EC6; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249379>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 98f3c85..1210345 100644
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
2.0.0.rc3.510.g20c254b
