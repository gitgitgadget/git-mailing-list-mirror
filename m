From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 42/48] refs.c: pass NULL as *flags to read_ref_full
Date: Tue, 17 Jun 2014 08:53:56 -0700
Message-ID: <1403020442-31049-43-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvio-0004GL-R0
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbaFQPye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:34 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:45867 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so881706qcv.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kXOY+//8g04MRqxE0GvPosIu2yS0hv2sfyOFzBJhi5w=;
        b=nss4JeUmXd94dBJ6nFapy/KIvHuklGsBl6s9mDRKFj+Hvm7QU3IzRJ0acO9y3NO69U
         K6BlQ/dpW/+XE/Km4tyodIbWBi1/moZt6puWCMp2ZxkqiwJ4d2TdM85RLIgvesjFk/2h
         ZqmXeJwHR82847WsP1N/P/qgVWG7mpgOdEri8yfigRxyfuR8Sgm0YUqUdmGjo6g/yMHj
         ZmV/MhXwlYhMblN3rkmQBjB8my1McWwdATsHKxG0JOMYhh02y8hP3tNNBdXq86u5tWi8
         VXI4ZuNsQ9uTt9sks/iBmQXM1BQ+ag6vnDksqLn6RNVm3mKdzRulBZOExaptEy1h79DF
         YW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kXOY+//8g04MRqxE0GvPosIu2yS0hv2sfyOFzBJhi5w=;
        b=D7Sp92FiDN865Cl/I5gpWDaSZ1lUzTkVuPJWPvz+1IxcByBZgtWE7bXAw0C410RfaV
         PKhHCDwUqWAlkfIispt3Thw6wKDqOxJleuOXZ/iQ12AMbz9sAMa38Ix9HWbyCXdYaKRV
         LK33DSyilR0Ja1Xex6JADGg4oIxwAPunCl8xRnUN/hexzF2e16kjycA3Htgg9RtWDy6S
         auBsK1f8Ye38GVosLNwcJHpnmBPhjlM6Z+k+9keg3pRpaJjeZzgMSdItp84sOP+H73PI
         gzchlAYaH93i97iwr0WKaxiLSlfeeaHUnALag7+bDXmDl+EylKB773lQuBuer57SLLNl
         KrCA==
X-Gm-Message-State: ALoCoQmTryMR5Cs0lCdxyXcS3H8xLnx0GaVAcbplJnrRb71mBWygmYG5PObb5lzm2EZKGm3QLutW
X-Received: by 10.236.189.68 with SMTP id b44mr589912yhn.4.1403020446058;
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si1209468yhg.2.2014.06.17.08.54.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DC6D731C76C;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BA8D1E036B; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251882>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index c501b9e..24c6e8a 100644
--- a/refs.c
+++ b/refs.c
@@ -2689,7 +2689,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.438.gec92e5c
