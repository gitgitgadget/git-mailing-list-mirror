From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/8] submodule-config: keep update strategy around
Date: Mon, 14 Dec 2015 14:54:18 -0800
Message-ID: <1450133665-3783-2-git-send-email-sbeller@google.com>
References: <1450133665-3783-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, j6t@kdbg.org
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 14 23:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c1n-000154-4m
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbbLNWzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:55:02 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34238 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbbLNWy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:54:57 -0500
Received: by pfbo64 with SMTP id o64so34313843pfb.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uwCzYbZDIe6R8HbIgwTSRg5Cwv8+gPKSZsLIm2vBeAM=;
        b=GucTgVH3pQjFtJrozu4iDMnWSLy96yvPvU07mT2VSFnjrjPjJtGJHgg6xXRUrtmGuQ
         xgGOXN/KIW2F4Mcyw9IX3OInVPAcpGhZI/BXSjLq7kHpQfz2qc/KWUpiDWI5JsX2HfJs
         oc/YV5M8suHHRDfkunwfl5WzoNUDFF/npAf2K9uzqpFE/oF1GVOn+O1VKoUqO0GAr6yN
         f/JBR/ac842jpwd89CZe06pfj6zTrUqzHRsBzqM0GVZr6nqC4KJifD2w2P3OprYy/hts
         NYE2bwbHVc4WJNj3aY+MYP2rW3f7HisOZ6U87FYe9WZQDKIOABJOnKgvyvNQ5KU1ysWi
         T/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uwCzYbZDIe6R8HbIgwTSRg5Cwv8+gPKSZsLIm2vBeAM=;
        b=TJLCiCSY3PyYcHPWzcnCLxMxJcX0hiTx4KyFhRcKyt1mv6HeSrDpiki+6wQ/719MsA
         U0FIAdOmZYBSEAQXnC4d4o4Ql+T7yLI3ii4OT3P/CxUmYCylvq+mgZeE4VxH+Y6hXFqL
         Q7cmIRCenreQmgbB2Pg+oV7wa/Pq+i7B7R+ghWuO/CChjtCyDnYT68bgYEuC9KZFLKE4
         k2CXQnR/IFySx91UqfXeQqRqVF+DwZKlxPjHk6X0TpeMsMd7QYCfBMnp0flaF14y0bsJ
         jVfWA/4qRtBlMVAPQK9xDKK3kscQsANl0bMbt7d+9yp+DTS4MunbvOVMsZU4O983uU3t
         Gwkg==
X-Gm-Message-State: ALoCoQn9YR9nEk5EJRd6ZzOaxM8iQxXXDZ3K1G4LZo2vnH/18PkKXSRyIXpTVTZfSh41RJ4y1SaciXh58lHAxUN384tuYz7Uzg==
X-Received: by 10.98.42.148 with SMTP id q142mr40591738pfq.0.1450133697344;
        Mon, 14 Dec 2015 14:54:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e502:49aa:9791:cefa])
        by smtp.gmail.com with ESMTPSA id c14sm44523641pfd.38.2015.12.14.14.54.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 14:54:56 -0800 (PST)
X-Mailer: git-send-email 2.6.4.443.ge094245.dirty
In-Reply-To: <1450133665-3783-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282434>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 11 +++++++++++
 submodule-config.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..4239b0e 100644
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
+			free((void *) submodule->update);
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
2.6.4.443.ge094245.dirty
