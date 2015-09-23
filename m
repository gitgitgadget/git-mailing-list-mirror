From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 10/14] submodule config: keep update strategy around
Date: Tue, 22 Sep 2015 18:45:28 -0700
Message-ID: <1442972732-12118-11-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8b-0007bf-QR
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934624AbbIWBqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:46:15 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35777 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759986AbbIWBpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:49 -0400
Received: by pacfv12 with SMTP id fv12so25541237pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aI9I4eAKsFApXKoQlEKVc6PJny8UVT8Uj8c5d4cnEMM=;
        b=Oyvu8s0w/dzRrsURAeCDoVpQF0Kv8X1zEVpGfDqtzC66tIZ2xcX2GtrdUAZM3YUhBx
         B8hNHx/uFqXy7wDGO0mRFsTiVM3DEESj9V6OG4wn1MYnN3Mitx0bdPb93oKuTtv6Wivj
         1L6HQroL3X/29SuWhZVO/nyqvL+8bKPRq4O8Q7K1314VFPM+VF21D8PCDc3zET1vPTwH
         lgcybU7ToMlWUOxcl+YjIwcBL3W+rJuNdJsZWRnbz29n1H3+4kXEPU8qdVj4sDtrJitV
         pacQNNydZkVEgve+O8DntGl7d1cssPDMRkv46lJHygShfZl/t9eppTK5+0bjeZO7Se3h
         YBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aI9I4eAKsFApXKoQlEKVc6PJny8UVT8Uj8c5d4cnEMM=;
        b=ddsaTwSct6ymJRRX4ixhNdY5AjmLQgddDYXh1ZqQ5J3rs7EWgKwaPDX69UB/FmALoN
         Zmu9UTbGqxTXbfhIZjNzyzvvdt4gxfsQrWXBq9AjP0iYqSvnHbsZYKab+IsJAb8yd2Oh
         LBp7LtrtXx/0J6bONj/5KVP0GiUKj77ZQF98YxePYsILO59XRsJltH1PeiNtEnnuHOk6
         PAWGKUH65SYYuH6fW1TvEl2OLG9EXV+YVh21p1rv2jv6pYSHYXZkKEUEYY5mbFccSlmE
         98b0BiPD+3+pyDrmvdHHe337zbT1tFpiMXcPv2xYJgehQpX//0FpQYngrKpNKPZNvrup
         WJcQ==
X-Gm-Message-State: ALoCoQk2PoKsild5EKC79m6Pck5zUgX7Vuu50KMyjm0GeovmyrwZ5OhUZeDAzwaiqa5zKP60ZMJz
X-Received: by 10.66.235.226 with SMTP id up2mr34768522pac.89.1442972748923;
        Tue, 22 Sep 2015 18:45:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id qe3sm4566147pbc.73.2015.09.22.18.45.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:48 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278467>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.5.0.272.ga84127c.dirty
