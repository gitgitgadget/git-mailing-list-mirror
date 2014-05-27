From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 34/41] refs.c: pass NULL as *flags to read_ref_full
Date: Tue, 27 May 2014 13:25:53 -0700
Message-ID: <1401222360-21175-35-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNx3-00021g-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbaE0U0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:20 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:62723 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so1917182oag.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44THM5v7fBKgHfkoOjzgV6tyslE1fPgQK6ZPBF9cy1E=;
        b=TDwBvlFvZCqmuVu/Q4A6cp6A2rVUIfOc7oexZu8k1tBQiP3FfJn8hgdWMdfevQnPnZ
         fMPIEfbNcOA0Cva4zqt33Yhw7LTC7eI8dQab4x84U19QfU+lYBkq3y+bvBj4q+0TXDaJ
         fB0sJZYU/0rU9MfiaNoqyWtRfudnxwfDPbM/yS7wfLEcsNHzsj/aEiREivky7fra/d+x
         UBTSaHts+/ejkeHizE2ms/VG8WDzkEvkYO2myokxSGXryuITtjC2QRf+5lEg/0t5zY2s
         Y2SUGUNfJ2+hN6kEke6YJTmsZ18yLDgNv7rujJPuVEXiCSB/TNI/5recS0twzzDROzff
         LVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44THM5v7fBKgHfkoOjzgV6tyslE1fPgQK6ZPBF9cy1E=;
        b=Amc4OqDfnvFIvgLFltZdRl7VihKeH6RYDbtVYsG4ZAy8NMBbCzSzWAA1zJQkrx8zRN
         DlfPZQNrPuTPC7lMFhGaIAxaW1ELsUAljnsUETIwC40n14bgpfSwyn2yg38BgwzHmIxI
         plkoMwLfX0rVnIE3fgE7oopU6SE7p9yZgsaJpi1KD+hzGOTemfgtIJqJBAoJMWxFzAwQ
         0/UAq0I44doc8KEQ6jALbmyD6HBn23cGkwMSOR9MKh2whk9pPQdQCUfh0F2MvEoOXHys
         WIyhlLkXr3fROefLaWQYCdK0PMSJ7iYzRVYIhY+GWT8dKebn/ZIgFpVU0EDYFtx6QW0K
         Zljw==
X-Gm-Message-State: ALoCoQlpfB9h/JUmElggboZZd7Bl39VM/oY9/gEK1aQlVJx7xcTKVWzfzJxlONckz/beWDcYyFGb
X-Received: by 10.42.195.66 with SMTP id eb2mr3523667icb.9.1401222365311;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1283655yhg.2.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 24D9A2F4AB9;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 008C8E0DE4; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250200>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e485d2f..3cdfc72 100644
--- a/refs.c
+++ b/refs.c
@@ -2642,7 +2642,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.rc3.474.g0203784
