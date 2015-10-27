From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/9] submodule config: keep update strategy around
Date: Tue, 27 Oct 2015 11:15:46 -0700
Message-ID: <1445969753-418-3-git-send-email-sbeller@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:16:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8n9-00035m-Oo
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbbJ0SQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:16:06 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34038 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965051AbbJ0SQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:04 -0400
Received: by padhk11 with SMTP id hk11so229738488pad.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=itpZRlnJRjZMDORp4ylS440H/QOZthMNu4ozCWQF/xE=;
        b=Z0oFoWToLN3xoSzl3uKA2Zf5wAKUJ+pEs+14efBeG1+3LxQlh2Ve8HgwY73XY1quFv
         6FTpvDicMEXNIsWR2zLg2pUh41EZRthb0s1mn5BnpvK7t1PhQBmejx4SLU5x9naxKwtF
         tdbmb7chX/qzgYXdHD8T1jh6uCiwYj1NZh7txQc6+nLvOAYZi9NEBXM6wX7gYhCbsqlf
         y3zN2giVdcjYZ51Rkm0hVTdlVpaKIMif9LVfhuGqKrMNTdMftHBgwArQVfMARBGE8++u
         4sL/0O9/rWgiB5OLq/ALc/fhknXGP3azOpin+OKjCw+RruSNJLQrIJnV79RzKJYEFBRP
         ejJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=itpZRlnJRjZMDORp4ylS440H/QOZthMNu4ozCWQF/xE=;
        b=b/D/Xi2Hi5ajeJQqM17DcEOnnp3xIw14h23BTtr3paSYm4jYtG8dgaenjXIWnSlyJE
         AFR4GJXbSWmsHBmUfunrZ5MHgYtPA6dPtbV8/hoKlXbBvO4/Pvi/GpafNHIDbETALw3c
         DJRuUhqboGu3G0XPhlNlkrxhmzXAYFZ06Xu2B72kUC8oeSVSclVegUIYicTZCRn3SrtN
         b+yCrKfxhUAoabJsyPoIIIDWiNyrWbRYgFbnkCF10G0QkLdt4B9S+oSMM7SK97icoWe3
         chvv5D3/8Wcj914BagakASWmYsau3j1yt1kuBKs9Ca5LBeNrLywU0E75aULgTzLjZTPj
         +/oA==
X-Gm-Message-State: ALoCoQnJ12AuS8FElJwfp/8Co520ZGKZGV/bMvVU1TZSy1UH8HH0gJJxVDuiOKMSa+QRkxAwVrH2
X-Received: by 10.68.142.129 with SMTP id rw1mr18770241pbb.149.1445969763169;
        Tue, 27 Oct 2015 11:16:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id y5sm40865348pbt.77.2015.10.27.11.16.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280278>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 11 +++++++++++
 submodule-config.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..8b8c7d1 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -311,6 +312,16 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
+	} else if (!strcmp(item.buf, "update")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->update != NULL)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "update");
+		else {
+			free((void *)submodule->update);
+			submodule->update = xstrdup(value);
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..f9e2a29 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -14,6 +14,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	const char *update;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
-- 
2.5.0.283.g1a79c94.dirty
