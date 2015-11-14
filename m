From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/9] submodule-config: keep update strategy around
Date: Fri, 13 Nov 2015 17:06:55 -0800
Message-ID: <1447463222-12589-3-git-send-email-sbeller@google.com>
References: <1447463222-12589-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:07:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPJo-0003wG-M0
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbbKNBHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 20:07:47 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34886 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbbKNBHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:16 -0500
Received: by pacej9 with SMTP id ej9so8886259pac.2
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 17:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9NlLAW5o5XF06C/oRBekEjzmMyCd7NW5jngt7fXNGUg=;
        b=D+hMdOh7MTmzX0q0/saWLx/ge58KivJDyoXEcrdyemif40oX/GXRF0onG94nxj4GgU
         tolA2akX++xRAxr4Jn1ponrJvZJ6hqcKbtwJ0BIRlr8rDexQfR76vf0jttGljRd47EBh
         it0kC4DTQRdbMh7L6qLN1zZuBET6F6Ir3gj6Ss+GBO9s/BFUrRssAf5cQjgCbJS+dsye
         yxfNEKYIE+QNDrKhC0bOV4Khm2KIx7JUG0aVklyUUgdCZFQ9v3d6wFOlZ/AHPCH9cyXI
         CvPIiLKglJZgopnZIRMrfftFiDBfHxIVQHP0YgaYEqx0FYYkC6no3XS3WNA3rmHVwP8H
         FtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9NlLAW5o5XF06C/oRBekEjzmMyCd7NW5jngt7fXNGUg=;
        b=C+acF+JJkLs3bIy1HYNMl9tQQwpw9HqI2rwoRLElgSWthLgCm1spPpf2h4ZkFth3cG
         BPz8nU9iA5hOApak+o0WO6VPQenoa1ngkjTREZPgzah8QJLOLSmb1VLXObsHu41fi933
         SkE4AaD7zTVVnJC/m8NQ1HsAwvOv+XQzfhUbLQh+N2iGyeEzBrwTvc1OqH0zcjxJyQQk
         TZkKzYOYH2UsUcPe6JlPvyEYsoDiFGHscxV2IdKOgAqDnNjOvjajUeKVV49GO5jKYmKQ
         zuxoW6MCYCYTKuvR/8hldDx8emiWM4JUDwXH9dIraMKDiH1dgCtg7KUD/GKcR8ImFy3T
         +3cg==
X-Gm-Message-State: ALoCoQl1ZCngAG/SrUgtvAtpkP2Z3X1H8nOZ+uGM1ymnfO2qZvgRORyqxW2SfBlrFb6XubcI3ejr
X-Received: by 10.66.102.74 with SMTP id fm10mr36730040pab.33.1447463236298;
        Fri, 13 Nov 2015 17:07:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f5eb:b7b9:3afa:a95c])
        by smtp.gmail.com with ESMTPSA id dd4sm22631487pbb.52.2015.11.13.17.07.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 17:07:15 -0800 (PST)
X-Mailer: git-send-email 2.6.3.369.gea52ac0
In-Reply-To: <1447463222-12589-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281296>

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
2.6.3.369.gea52ac0
