From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 42/48] refs.c: pass NULL as *flags to read_ref_full
Date: Tue, 10 Jun 2014 15:29:30 -0700
Message-ID: <1402439376-25839-43-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaS-0006iS-6g
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbaFJWbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:34 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:46252 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so179266pab.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwKp9Sk1lvb54vJt+P6GwwIvc2hJJ7xBHJYmZjVSd1o=;
        b=Y2hV64/x/yljhJWqU156kTsH+4IrdAf+auc8sxQ80x4VnIFEJ0Q7iBaR3bwtIny/YO
         mwXYAjiAUFJ6Sg/ZMAh9L2aXvX6aIKpLtFfQfFmOH+XRPmEx1sMcGHmDevFr7GNvUL2O
         GG4jTIgq3u9ldueRKlbqXnuAqb2+3GBnVycW6SQhf67VrvvWwGK8nJLKbekYM7YfAOVV
         YH5vYwN011165gkS2e5+EkLIzWgBWXiq5NjW9vdVfxnIL0jQY7+PChJB3lbYjzs+NA9g
         xHbg+hu82eAvq9RbyCQRvNyW7hZ9/iaW5xWtH9mrM/IcNgnj1PFWVuOnLQpKagFqqyt3
         S4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YwKp9Sk1lvb54vJt+P6GwwIvc2hJJ7xBHJYmZjVSd1o=;
        b=ch3Y8HkYMhdKAW/3jYlVCacVpoka1c2Oge25/kB4ibb4p/8ByMq+yjDN8SlMvWL9iO
         fYRs9VHIAYyIDfRmbgK6gJN9AeY1pjh5j109wRbsdGMI74txCSZCcvX1RW4+p+uDKqjo
         jMUKgDWtQh+0ssvfvRqlxlpttIpuwo14sOoGDfQd+cbexVgIcG7Xy86mi6c9ekhj3LOD
         YslWlnLjnGmN5hnkX7jvhw5vz8zl/VK0rTu9Ft/d4wpchly0klLzZ41IPXtAWLX1Dxrn
         Ud4Si7cQHLt8jUTKi8/fizWPdVB4NM5jsJzSYpq597jwyyqbw8oiRv1pPqoKtbAVSDjm
         Y8fg==
X-Gm-Message-State: ALoCoQlaK7uTZOoRQk1RFN4aZ2IT4cdOlwgOlH2jK29tYbheV088IfPWCq+u9cpUaAeaC4w7mEF5
X-Received: by 10.66.231.68 with SMTP id te4mr3800764pac.29.1402439381968;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1395565yhj.5.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C5B2631C746;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A4ACDE0BF1; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251282>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index c93ea95..d1c501e 100644
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
2.0.0.574.g30c2c5e
