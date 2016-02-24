From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 08/32] refs: reduce the visibility of do_for_each_ref()
Date: Wed, 24 Feb 2016 17:58:40 -0500
Message-ID: <1456354744-8022-9-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPN-0003fn-71
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759161AbcBXW7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:36 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36643 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759070AbcBXW7W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:22 -0500
Received: by mail-qk0-f180.google.com with SMTP id s68so13140426qkh.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=klw6UjEm6ZAVwZOfTmAMx7/HX53iNH0Ip/N5jBQOUtU=;
        b=h/ixG0BBHngQkOrqn9YInPs4QsU0AbPaRYW6s94uqNDdfIqLnASMz1xANYN++CUmfJ
         HXu7M+ICib1YVdG5bLYROqu7NcZ4OhZDkRIjnLjNJkRx4Ltaq5qPBMY4ynQdDI5H/+Kh
         6dvbOLRPL/26F3hbNcbhhi0PKPkek0KwVDqIOeKIsxbE2fEiJP8ZkgaRfTXaNkQ+clxJ
         1bCFB85/bBrnCrFy695fmic8qWWtRm+s6VI1bi5tBccAnMbuo6tJUlMl5aMXj2CkwYEv
         XgV0nvry4WY1ca92dTaH8NBw7QBGaH0y/6P1+kujM+PkEZGvBPE4z5yhaUdcN1yGDdnY
         XGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=klw6UjEm6ZAVwZOfTmAMx7/HX53iNH0Ip/N5jBQOUtU=;
        b=k/dghQaW7cZxraA84NpYzaTjtgl9cD4An0mGRf/vZhlkT91e5PC5g+G2ShwMMz8ZRF
         lkYHjkbydBELY0YYQU6+JaJC09lxy7wx73dEvbYk9Es+5v90RN/CFlTj9he9ChqLbSli
         dX1X8JwFq7cfq4EYsX2t2oB8yH+ib7Z2zLSWrYcQJ4LQRtxu9w/UMw+mgomr27J0mGgY
         98IvNO7RFHaWB4oGDpC4iYMNzv/ZwXk1EzT5CQzkJhF+eDz2+71ffb2buZ7a0BlYiIUd
         WujtG27z9D2j3NQIfJWwJBepVMxy8L/I/ZEgCI9rGluYr9AJbJqah8OI5HmfDri0bItQ
         1p/A==
X-Gm-Message-State: AG10YOSTZddL0ml/zCNMPj8AQGBZJrImU8a44kWsuCqZiQQRooe3jN+Q8gwha8gGKSL8sw==
X-Received: by 10.55.71.146 with SMTP id u140mr50887146qka.14.1456354761469;
        Wed, 24 Feb 2016 14:59:21 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:20 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287250>

From: Ramsay Jones <ramsay@ramsayjones.plus.com>

Now that we have moved do_for_each_ref into refs.c, it no longer needs
to be public.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 refs.c               | 19 +++++++++++--------
 refs/refs-internal.h |  6 ------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index cd06f4b..abc5b0d 100644
--- a/refs.c
+++ b/refs.c
@@ -1139,6 +1139,17 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return head_ref_submodule(NULL, fn, cb_data);
 }
 
+/*
+ * The common backend for the for_each_*ref* functions
+ */
+static int do_for_each_ref(const char *submodule, const char *base,
+		    each_ref_fn fn, int trim, int flags,
+		    void *cb_data)
+{
+	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
+						 flags, cb_data);
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
@@ -1339,11 +1350,3 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
-
-int do_for_each_ref(const char *submodule, const char *base,
-		    each_ref_fn fn, int trim, int flags,
-		    void *cb_data)
-{
-	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
-						 flags, cb_data);
-}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c9b6745..3702737 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -203,12 +203,6 @@ int rename_ref_available(const char *oldname, const char *newname);
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
-/*
- * The common backend for the for_each_*ref* functions
- */
-int do_for_each_ref(const char *submodule, const char *base,
-		    each_ref_fn fn, int trim, int flags, void *cb_data);
-
 /* refs backends */
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
-- 
2.4.2.767.g62658d5-twtrsrc
