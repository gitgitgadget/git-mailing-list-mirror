From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/7] submodule-config: keep labels around
Date: Tue, 10 May 2016 17:59:53 -0700
Message-ID: <1462928397-1708-4-git-send-email-sbeller@google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed May 11 03:00:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IVt-00028Y-7f
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbcEKBAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:00:17 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33672 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbcEKBAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:00:11 -0400
Received: by mail-pa0-f49.google.com with SMTP id xk12so11296355pac.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lPMdXIc2F8eEmZaklLK2y5mj9F031vUNP88Dp7jQpFQ=;
        b=PICvPWNoHmB0yoJLUGwpMK47DlWJ5ovKV6ylWwrssis3QCcOsxk7tFk4lY00qsqU3y
         r05kWcuzlX2Zy3e2yT1RnD4BRyZidkzndP/d/UXpCxXJzkt0wjgAnGYqtdMyPNoxUHtp
         dUHnfbSoRHO4WOT1iMyUdBoRpMI7Xa6XK8kZV+Bd6pX8AICSbszovGeQIBOQNwBr4yfD
         ysh2KRbeY5821cBuHO6/fWmZoft6rcA0XGrZDV6pQ+Qp+D0/GtAv44UKNdy8oGrsqVrK
         xPn5fMBFLL2LArTxHu5pvojvWBrj3J418CndbL0OorX4+LopQsLb7ZCTqlloZqVAYYay
         9WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lPMdXIc2F8eEmZaklLK2y5mj9F031vUNP88Dp7jQpFQ=;
        b=PQ03Z1nOJDszoFF8hWdklsixIDFsEnYCjDsdVRIKNg9hJ9nD9aphlDVRrDdXozgrPi
         77me3Gj9+xk/gB4Q8Y6eUgjiAV4A6JDTAeeW5Fdkd+OSHAUwaPw25hjcGIv5APSI/iH8
         mfxB6v/RmZuRr0vwSubPddRJTtog22J6yiBiNAnjAENsNKR+uMfAX2WR2cPmfC71RyO6
         wNy3LtvVx+Uc9kToCggueWCvun0SRXwL4csKoC9KRHtYxJVLa/ykEHNwREzGdvrGOvwq
         dMUxL++uxciGkpYGAdScEb9IrAeneZxHlbMB9NO3rUYTVbJ+KStLZuR0X9Lma1diYLSr
         io6g==
X-Gm-Message-State: AOPr4FUvh1kX2MjujEE2+SyJC/KvPyXj5xCDUO4CQ40GedU1RLxEODPX2FfX7mBRzIKSRpgy
X-Received: by 10.66.164.165 with SMTP id yr5mr674703pab.133.1462928410151;
        Tue, 10 May 2016 18:00:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69ac:db78:a0d1:60da])
        by smtp.gmail.com with ESMTPSA id b19sm7240959pfj.41.2016.05.10.18.00.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 May 2016 18:00:09 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.35.g58985d9.dirty
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294211>

We need the submodule labels in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 16 ++++++++++++++++
 submodule-config.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index b82d1fb..0cdb47e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -60,6 +60,10 @@ static void free_one_config(struct submodule_entry *entry)
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
 	free((void *) entry->config->update_strategy.command);
+	if (entry->config->labels) {
+		string_list_clear(entry->config->labels, 0);
+		free(entry->config->labels);
+	}
 	free(entry->config);
 }
 
@@ -199,6 +203,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
+	submodule->labels = NULL;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
@@ -353,6 +358,17 @@ static int parse_config(const char *var, const char *value, void *data)
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
+	} else if (!strcmp(item.buf, "label")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else {
+			if (!submodule->labels) {
+				submodule->labels =
+					xmalloc(sizeof(*submodule->labels));
+				string_list_init(submodule->labels, 1);
+			}
+			string_list_insert(submodule->labels, value);
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index e4857f5..d57da59 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -18,6 +18,8 @@ struct submodule {
 	struct submodule_update_strategy update_strategy;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
+	/* sorted, not as on disk */
+	struct string_list *labels;
 };
 
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-- 
2.8.0.35.g58985d9.dirty
