From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 14/43] refs.c: move is_branch to the common code
Date: Mon, 28 Sep 2015 18:01:49 -0400
Message-ID: <1443477738-32023-15-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXX-0002gh-JF
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbbI1WEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:52 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34995 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbbI1WDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:11 -0400
Received: by qkap81 with SMTP id p81so74441194qka.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gKv3mpgyx5u7PWUd1qlXM79CHyzamyrpDvY3z+L5rVs=;
        b=TwxD9FV2vvROn1h/Ge+JFebp3JHCQojsVS8NHSOonoMWFxr5c0fo1HvDRaIv/bHSxc
         k7wKXfNWMHq8YoZ9bjad953a1HTbfRMW6XSj1BAbA93yXj1jlULUz6uD5gjj/+WbYCaL
         NPU0IycXTdY9x4RL8Hdn96cHaEIA2Toij52zRpxKazT+JK6DY4tVFONcKlrSHqeMz3JX
         /Hhsv0CRpGLE+Uwrhat48d2uWwoIQmJsaOxEBbyyn79YHOC6x9wGdSdADR0TaTtEQ3ab
         PsyOnN3ptVaztVNUA2+vRumeGmur94uUhSZQ9Mh2tHQWV3qfujmEteiZiCzigPYtkZzc
         DcEA==
X-Gm-Message-State: ALoCoQmbhIeyQer0ppdzNwGniTD0slyQstBtUzl3kCpyNDKMY01FC8GcyDvQfK2nvOA+1uhp4HA3
X-Received: by 10.55.212.217 with SMTP id s86mr20536010qks.77.1443477790861;
        Mon, 28 Sep 2015 15:03:10 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278791>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 5 -----
 refs.c          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index f920b65..58ff453 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2969,11 +2969,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return ret;
 }
 
-int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 /*
  * Write sha1 into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and
diff --git a/refs.c b/refs.c
index e9cc2d4..bc8750c 100644
--- a/refs.c
+++ b/refs.c
@@ -767,3 +767,8 @@ int check_refname_format(const char *refname, int flags)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
+
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
-- 
2.4.2.644.g97b850b-twtrsrc
