From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 42/48] refs.c: pass NULL as *flags to read_ref_full
Date: Fri, 20 Jun 2014 07:43:23 -0700
Message-ID: <1403275409-28173-43-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy03F-0001eH-Hy
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbaFTOoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:18 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:34279 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so980886oac.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UJImE0fuWUWQ0gh6NqI6yo8Xg52cDyMVNmSZnHsjhO0=;
        b=kb5KqZWuGT+5EYJCc7ZYsmpHYIi3IYvR2M7TEYBHQ5Z01hb2+UeuSCCg7CiHHTQWdr
         q7tiOvG6W32y9Gxzh4bYz/7ot8IeQNRuwXlfnvuLEjZjXEkOQ6+V++q+1nhJEmOf/mz2
         ChTVsolx8RvikMZRfVLzROIzl6ZPIJRU/YQdvdxiBQK5rPzQGZ5VLPg9GsdVFGIDpJ5M
         lmJ2uOwIzkd7WS0yPQH5RT6rf+Hr0GJ6iJekybzAnQPzBnjCVPO6w8tB/zXfIYiRlwkc
         liQo6JSdNSP+9p09n1FnhgbFfSpFtWUPOE52pBFdjtCk+GgVMKc1G9zVaeze6DxUBsm9
         ZLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UJImE0fuWUWQ0gh6NqI6yo8Xg52cDyMVNmSZnHsjhO0=;
        b=RCINhxRmaYyWhiMw/Ikr+xokz/rq0igcRZwnI9v/wzg+pAZ0GKKJM0xtAvxn10i8IQ
         6B1Yy9jlQEVmHu6xca+aBlRa+tyhphD91xVgw9etT0T5IEjPUJ6iY9tULyXhr0Yeb2Dw
         X+fZgeYnWOeYZ4JBnAwYJsQiRid0POYh30sTpnjpNf0H/JTYe6PU7PRp/quQ8jGtlHJB
         Z3SzytTVL7zlE3ZpX7FfpcmHLz+8aveZqK4DpeVKB1C+YTCknVc+FpVQYqt3D+TG5wlk
         PJhl0NjE9TvOLxg6IEZUEEvWDAjQ09G5Bvqxa1hDJU4BDcdQqdao6DfSa8x7P3DbdE3N
         qcmg==
X-Gm-Message-State: ALoCoQlWMzmkVHrKwxf8BRtQU7UGSTQAJdOvlm0eSwy1gqOl8+x2fX4b8Uk0/jMHHpsltW5N++tT
X-Received: by 10.182.166.36 with SMTP id zd4mr1530539obb.43.1403275414028;
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si591927yhe.2.2014.06.20.07.43.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DBED131C6B4;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B7ED3E08AF; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252241>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1f17a13..389a55f 100644
--- a/refs.c
+++ b/refs.c
@@ -2688,7 +2688,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.420.g181e020.dirty
