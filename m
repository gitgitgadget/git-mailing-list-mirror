Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D413E44E7
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790049664; cv=none; b=Y7G6NeX2YWpcD/Jn3CfsCc1WCvIrd7wnQkQ6eZCDe+wS2ZKcuuZaWjZM3s4mNxVBCypV/lYzcvKapfUaUBUq8kPFbbOISe/YWQukM/Vjt9XscYmCv4K1sUzdl0ZPNGmy2gfJvbFh+AKWMzAltVfJVod8G+a+Yx0/9dBHsw1Udiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790049664; c=relaxed/simple;
	bh=kYaVNSGuzErS6aePytxtHVwPVsfZUcxLPcK6jcN0m4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=du9mn7aRDNbv/p8STuzcJN/ix8lKfTDSs/38W5ZMjIPl7r1sqs5rDPXW2o88A4FEAXjVVt1PCc1gajGPpxmB+KpFtSu43fPvWoE5zmcbHPT3nnK/dAbYthBTr49sbx6oHG5pIhKLps886T6HuNmW0zNg+cthI8tzEMFgg9/D2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzzEmzti; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzzEmzti"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so546387a91.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 21:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790049661; x=1790654461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CldK44tAhMVpEMJQFj5e7wWCZdUe8ntx94XxC+9bzmE=;
        b=WzzEmztis4Ex6/6jcxL2HTxSTztZ3tH28jWapOhGUnfumoildG9XBxAreRQ3wqUFwU
         a8ZB2JIB8x5eLrYBBdCoQMogmK78ncensX2oGQgAJD0LF8ht2pTJB+7pWtXx5/LKVp+w
         BKP3aXX/QcOIIW2pZSMl321zAKuCGEcxXmt+gjsPjy6coKOX4zBxmx4LcBKQI8Af0KKl
         ftTBcloHcoapgxEL6ychZ3jNuEWT2qQW2Z4N0/CASbbs8Jo5EX2OfFOG+Hq7cDhEeqai
         h9T1BfdwAR2bKh+waFYh6e8HgOaj6sM+qBysoppMkYsedwbSL2bdG8nPFJXRXntbKpA8
         hMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790049661; x=1790654461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CldK44tAhMVpEMJQFj5e7wWCZdUe8ntx94XxC+9bzmE=;
        b=apPhAWL3WwEnN82be0aRJg2yJ/DOUCa2m4kpd5tra25eXWpqwRXFdQtL85ogvVWyaP
         4s2tXO8LQa/lp/SpR659Et1Tv7GZek5H1c26cpMMUs6lJiOZrE8PnUJtNNDkUgu4isB1
         fM7D9akQ8TE/fc2iHKreOu5Z5Xv2K7ccl6Uz/Py5ynDk6qh1J6t9tW4/QnIkTJBK6upi
         HhM3mEAlAiauJygr5ZB75k2NExXERtXGhZO3NCc4OlQGhkczqmqfXwJ3FDvRg1OMm4M4
         8HEIPAv8NFVGST9pZDAfCsyNuJK9cqHXE4BnwBxJm6n16T8f+ozwV26nSaPUD/qKal6I
         6B9g==
X-Gm-Message-State: AFuF++kXKhHo0/0PvX7KEhcS+5ORkD2ROpXbkoZB17AjDKgdWjjF8Swj
	CmwQDj5KQaiQ+r6oPes2NbkQyNXiJ063FDCz2d182i5IG2ncYP61AbzRvbrjDA==
X-Gm-Gg: AYBFou16Old8jDvqw43IsBRGr6/N20ZUj3ZiUlrJPEAWynddWLcSuAXtX94GaF73Qt8
	rJrjFckQzsmLJXHSpKtnFTo4fGp7LDlba5G7ljgmfGZNxv2EB7MEZWVSv8TX1odFmzWOvv1PeTx
	Qg1MH1u25BLzGKqXTAGT/66GUVgyqtycK9PMBOeF9iPC6iztgx8QSny2Hdv867p/bcgRx9PCXA9
	TiRmG/YrcZe0kIGTmK4AYict1wq3mwDdGdzAXkF+r96BVjAzUIjiMqnylyy2PbUgUMPvJerpvv2
	+8Lcau7CbVAgdRhYg/2vbSa3oGlhMS2d54EYQza3hPjyst/AiYqQhLb7Zv+Gr8DWfGTQy4iDgIF
	v+lQhzQXTW06LN1f62SwOBS6eA9Jv38UOqQTa/p567R48R3YgZQ+YZbBlQi1SMr9v36lJUObFo3
	wV2asfXfp7tOjjk+qGH+SOQY+GkaXFQPDNdF2j9lZJZ/eaW6wk7HTZCLiN2ju9Vd6mw+c8/g6kW
	5avYEUhQPARSbgiPHJEjw==
X-Received: by 2002:a17:90b:58cc:b0:3a0:2904:f034 with SMTP id 98e67ed59e1d1-3a066b3b3e7mr1342422a91.39.1790049661347;
        Mon, 21 Sep 2026 21:01:01 -0700 (PDT)
Received: from Velociraptor ([172.88.119.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e61316b92sm1662126eec.26.2026.09.21.21.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:01:00 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH] fetch.c: defer fetch.followRemoteHEAD validation
Date: Mon, 21 Sep 2026 21:00:47 -0700
Message-ID: <20260922040047.2567-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, fetch.followRemoteHEAD was validated and any invalid
value was warned about unconditionally during config parsing.

Now store the raw config string instead, and resolve/validate it lazily
at the one call in do_fetch(), so an irrelevant fetch no longer warns about an unrelated
config value it never needed.

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 builtin/fetch.c | 57 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab7db2be06..64ad26f5d4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -103,7 +103,7 @@ static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
-	enum follow_remote_head_settings follow_remote_head;
+	char *follow_remote_head_raw;
 	int all;
 	int prune;
 	int prune_tags;
@@ -178,22 +178,29 @@ static int git_fetch_config(const char *k, const char *v,
 	if (!strcmp(k, "fetch.followremotehead")) {
 		if (!v)
 			return config_error_nonbool(k);
-		else if (!strcmp(v, "never"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
-		else if (!strcmp(v, "create"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
-		else if (!strcmp(v, "warn"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
-		else if (!strcmp(v, "always"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
-		else
-			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), v);
+		free(fetch_config->follow_remote_head_raw);
+		fetch_config->follow_remote_head_raw = xstrdup(v);
+		
 		return 0;
 	}
 
 	return git_default_config(k, v, ctx, cb);
 }
 
+static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
+{
+	if (!strcmp(setting, "never"))
+		return FOLLOW_REMOTE_NEVER;
+	else if (!strcmp(setting, "create"))
+		return FOLLOW_REMOTE_CREATE;
+	else if (!strcmp(setting, "warn"))
+		return FOLLOW_REMOTE_WARN;
+	else if (!strcmp(setting, "always"))
+		return FOLLOW_REMOTE_ALWAYS;
+	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
+	return FOLLOW_REMOTE_UNCONFIGURED;
+}
+
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
 	BUG_ON_OPT_NEG(unset);
@@ -1922,7 +1929,7 @@ static int do_fetch(struct transport *transport,
 	struct ref_update_display_info_array display_array = { 0 };
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
-	int follow_remote_head;
+	int follow_remote_head = 0;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1938,22 +1945,6 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	/*
-	 * NEEDSWORK: By the time this function executes, we have already parsed
-	 * all such followRemoteHEAD values from the external configuration,
-	 * potentially emitting warning messages for bogus values.  Ideally, if
-	 * this fetch ends up not needing to consult these values, then git would
-	 * not ever output a value warning. (eg: when pulling from a URL directly -
-	 * rather than a configured remote, or when a remote's followRemoteHEAD
-	 * overrides the fallback fetch setting)
-	 */
-	if (transport->remote->follow_remote_head)
-		follow_remote_head = transport->remote->follow_remote_head;
-	else if (config->follow_remote_head)
-		follow_remote_head = config->follow_remote_head;
-	else
-		follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
-
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
@@ -1962,6 +1953,14 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
+
+			if (transport->remote->follow_remote_head)
+				follow_remote_head = transport->remote->follow_remote_head;
+			else if (config->follow_remote_head_raw)
+				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
+			else
+				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+			
 			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 				do_set_head = 1;
 		}
@@ -2509,7 +2508,7 @@ int cmd_fetch(int argc,
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
-		.follow_remote_head = FOLLOW_REMOTE_UNCONFIGURED,
+		.follow_remote_head_raw = NULL,
 		.prune = -1,
 		.prune_tags = -1,
 		.show_forced_updates = 1,
-- 
2.55.0.windows.3

