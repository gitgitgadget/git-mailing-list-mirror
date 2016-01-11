From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 1/8] submodule-config: keep update strategy around
Date: Mon, 11 Jan 2016 11:41:54 -0800
Message-ID: <1452541321-27810-2-git-send-email-sbeller@google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 20:42:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiMC-000520-W1
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933751AbcAKTmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:42:16 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36727 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757379AbcAKTmP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:42:15 -0500
Received: by mail-pf0-f174.google.com with SMTP id n128so49340643pfn.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tpyD8HB6GYjkKtDi3AxnlYoloWhupz+ZwBjG9VxDvyU=;
        b=k0Pmy6XDdhhmy6EOiy7EgLlrFr/WNh8oM0y8p60DZxkW6Dc5lsSLmNVrgVM0Mb1pS/
         5vr7NJC/dsBx8J8cs7kRbotMM9x30bSB4awsCxLv+Ql2BiczWdGqZFt/oibh58pUMxIs
         FqKVTOCvKz1oFi1hAMasPG+OTMf7tlwI6G2/U3f7E5jVT6QbzAVvwspuO9E6BgvSZStt
         f1QdHBzPkUHs35GEOZASFrQ/kKQWPCWcBOAYjKCFnszE2P8Ze3dpzadxUNagezRFm6IO
         OQevWlwdeecpimpL0+QGPBu3DqXuQ3YejgM0+5qBtq7bX2bEGQCqNY+tL6z6BPilKDRw
         cIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpyD8HB6GYjkKtDi3AxnlYoloWhupz+ZwBjG9VxDvyU=;
        b=Gus23LC97/U1ZIbzMjBcIiM18tMZbdwLsCrNU7f4QnyEeGIDG65IHWU4g1Kc58jZn8
         v57WHMc5lcb6zIXE0PPwTjerq4jkyirAuHX4zOuO0McoBO5iG0EwpDnZs6Ty9qV8mJZJ
         P7syDoLg3vWEVaH60ZHILv5wNB95qBXuXZp/qIJAKbnWtQAeffYPXmBm3RbxBBW2HK3q
         aYFk0dN8Rx9ngTrzt1zsEqAsEIieknzVdIt0gT4INd3XNS6YMZa2NsjgkJBkFuRjTakP
         ilS8FpR7UYMmp6UaBkqfoHKukD/2DRQywn5BTq7Dv5ncvRj7eTd8owBESooL1kpkBYRZ
         lYDg==
X-Gm-Message-State: ALoCoQkYRPb/D/BkZ9dI2m6E9HiJuuglAidwjVGBX2lebNHiZOaeYZ483NhzxTQ9cHLaoHSbLedIlyw7MdN0xghvsYidzIc0qg==
X-Received: by 10.98.71.211 with SMTP id p80mr28440631pfi.135.1452541334752;
        Mon, 11 Jan 2016 11:42:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8d8c:9316:e7e7:6f4f])
        by smtp.gmail.com with ESMTPSA id m77sm25075535pfi.54.2016.01.11.11.42.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 11:42:13 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.7.gf4541cb.dirty
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283702>

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
2.7.0.rc1.7.gf4541cb.dirty
