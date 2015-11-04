From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 04/11] submodule-config: keep update strategy around
Date: Tue,  3 Nov 2015 16:37:07 -0800
Message-ID: <1446597434-1740-5-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm5M-00035L-S2
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984AbbKDAhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:52 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36223 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbbKDAhX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:23 -0500
Received: by pacdm15 with SMTP id dm15so9424272pac.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vEvbYWwigK7tGJf/0adP7Q34j0iXNf88kKu0anghpcg=;
        b=JNyuxQ5YeRp1H0aqUxVNrmEb23ytSi+/tU7pcpe1SrPuAUeQ1P5xWMbykc1LzDZGKn
         4IKNuNP/fiXN+iVKuwIUuxwlTpCyH1J13OorYTQ7z0oT3+hPSsXK28vzKVKtQHP1GAqH
         42BsZDKGOl/c3wp/1ma4a3AiOWXZ48jc8ojztgNygzbOANNTEF5dT9FbkE8OP8D6OBFp
         QOAxPmlK/1Uwbx/mON9psxyZ3PE+dRt1S6p2tXaiDsFJvuFt7FaRogL75iQHftGQumeB
         sT4O+Xn+NheKtiWC2jRTP0N9m1ysrgFD+pnd2nwSFaZxDML0XfpU4ul3fNSKFkJ0MVvR
         1qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vEvbYWwigK7tGJf/0adP7Q34j0iXNf88kKu0anghpcg=;
        b=DvFT/SIrDs/IGP11/NwI07KqfMxXWbwKGsn6c220aanlhXDTBcrehQRmqubUwqxQOj
         bDDMkItvI+w3R5fshXp6hJ51EvdAqLMb/H6p+k1167FtTbjudsEKMudapj2gArIlybIM
         DzQe903UcV3vlvLePPP2OpQjx2jpB6JFgYAgagScTAHWxMVlB0qS8UV+0R6LBSCty/sr
         3CIhBDmtPBMocziX2PJ06Y+zJi1o3RqKElHwQ1VmXW8PfNOnU53RjyXUkDQTyZSvSEn6
         FxfxuC/KkO7J1oF7hwdxxBwzuCGnp//WP7TwrrtYIaS9eJNxR7AWZhOJZKxv2c64/ayA
         eFig==
X-Gm-Message-State: ALoCoQkvor6bQ5mctCTLULSrd0AA+MP3pFesPSx3wsxCR1Gf+/kyQR6bhDKrHaG0iT0fMkVxwKzF
X-Received: by 10.68.142.129 with SMTP id rw1mr36741503pbb.149.1446597443123;
        Tue, 03 Nov 2015 16:37:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id sx1sm700814pbc.36.2015.11.03.16.37.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:22 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280841>

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
2.6.1.247.ge8f2a41.dirty
