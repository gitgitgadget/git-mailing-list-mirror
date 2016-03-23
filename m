From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v3/GSoC 3/5] git-credential-cache: put socket to xdg-compatible path
Date: Wed, 23 Mar 2016 18:13:23 +0800
Message-ID: <1458728005-22555-3-git-send-email-huiyiqun@gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Cc: peff@peff.net, pickfire@riseup.net, Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifnV-000210-3R
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbcCWKNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:13:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36776 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbcCWKNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:13:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id q129so2423212pfb.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QrUqux1xveIuQYZvv4Sv4cwGqEsr/GMNnbU524uK2iY=;
        b=fIx94+a4Ybcw6lwBwXWMddtVErv4daNIAYsq4Zub0j7ZNgADaEmA7YD/+Xi/9nsoaV
         IajmWQ+ZV+x4vuh7fu/gLKdW3XjXPKhz8UWjmTZE4x0ew+p1mnIM7mM1ARHDqpIb4BRO
         Lrc9xlOqiqGX6zZGwzJn8d0t2csQzHi3leemNTPJ4J0vV+vhXzOPC5zUmbGUBCvJul8e
         AZTjWsmIbIbYoS8pGBG0GZ4Ci50PAj6ISlMsYuL8hRe2fsnqst+6inGHtLgjq3exfWao
         +sTG0tNqyiTwb8ipHWe2l4++h0RnVYleyID44DweqdJATNILUmwetdRfwa0hUWTazB1/
         KIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QrUqux1xveIuQYZvv4Sv4cwGqEsr/GMNnbU524uK2iY=;
        b=Ul71kztLKdZeSSGbSi6ELMo3VauPMtp8avyLKb9cs4FdjuHiOe/XRMmIXQqtGZCOk4
         KIs05ZsjAX6p5uXoY/XuNLZI4R29yLa2klKvoYw0hLwsCe38oYN0Sk0kHmvnGHN06MrZ
         zih6j6kCj7Z/lCIRWII75FcP8dNOJsontCmeNhT6FtFpMHGciieN6z35VGBSidMCu20t
         GwFjy6xFuvXqt4ps7q8VgiBtNJzJeni1bInj0VQlxbSDSOaxYV3W5zUqgukB7BEJejSX
         4HvHzuNj9N62vtWrDtx/e7nyNKS312rzx+T7FfRxD/BUjiCfCrJkD4sHlI5i3f9P8CRC
         C0wg==
X-Gm-Message-State: AD7BkJJ0IXVdV+QAHAvGqLO2Lh6rsMnhxQcrLZ5/uYaCsR+DdwaJWjee/Vj/XAotxYGqFw==
X-Received: by 10.98.75.157 with SMTP id d29mr2847669pfj.33.1458728016933;
        Wed, 23 Mar 2016 03:13:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:ae9e:17ff:fe87:5adb])
        by smtp.gmail.com with ESMTPSA id x18sm3232325pfi.42.2016.03.23.03.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 03:13:36 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289622>

move .git-credential-cache/socket to xdg_runtime_dir("credential-cache.sock")

Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 credential-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential-cache.c b/credential-cache.c
index f4afdc6..40d838b 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -105,7 +105,7 @@ int main(int argc, const char **argv)
 	op = argv[0];
 
 	if (!socket_path)
-		socket_path = expand_user_path("~/.git-credential-cache/socket");
+		socket_path = xdg_runtime_dir("credential-cache.sock");
 	if (!socket_path)
 		die("unable to find a suitable socket path; use --socket");
 
-- 
2.7.4
