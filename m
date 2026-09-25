Received: from mail-dy2-f32.google.com (mail-dy2-f32.google.com [74.125.229.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8C4CC62D
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364441; cv=none; b=gFXn3mRm9qeLzDqZr0dI/5zCHX3hUfEKpEY1aa3+03QHfWIboM61GAgDGBgq3S3ejy7GA407CBYsK0Ar4CNecOwjF/K7oETaRfnTtqg8fM26PUpGO634YkXeA4HHVE2Cu71nJiL4s/8Lkdi2ervVcwWvYboZzhAz0xA3HA3G5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364441; c=relaxed/simple;
	bh=t141+g+nj2vuwXH7mjzwr99YcYBUP72iHGO5aAHCgOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmIgHkuZI+9iORd02RpIf15VMQFzLQehhHOFq93ZqVB4e2vWoQF/B4L73r5kuUl0qqyfDH+VOsjLc3KSmNyTNrQrsN2XM47Lwd42v6R0AO4c75vF7JBGs2IYvJMZ5P9PWvW+wS6j+YRpIq+++YAFKl8HPvVPiG7+EtWt90K+fGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCcBAZQw; arc=none smtp.client-ip=74.125.229.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCcBAZQw"
Received: by mail-dy2-f32.google.com with SMTP id 5a478bee46e88-33b9e805130so834045eec.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364433; x=1790969233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mb5wpahfzEEjGLOYesT1NxSehl1liQSi/G+aXLWB/F8=;
        b=pCcBAZQwPXhrQQOfydDmIY903BgE1ZcCW1FkGDIAiS/R4hQxQpB92d7Q4PgtRhHm0V
         I9KHR2fEWyZMKd4pITRXSpApaogPlCkpPptdFT82MmX39lCjnZXloJPxB8rZBgujOrSC
         Uv3LQo8MHrDcb7FTe5VjK/SxGMZEuiVWFgBQIcvKoMT4Fe2lFfcuUKNTxLGzMpGVR4yF
         8t6RXdp2oHMIH0w22Q7JYvlkA+3qRvztAyDR7wAtFyX14HZKyrH0DmzrFQELfIUT0FES
         f9KN9w3PLzNUGYx/Qb3VypzehQ9NWpORoknYnZhEn/mD3fbg48mB99Rx+2Bd5aXG63TI
         5ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364433; x=1790969233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mb5wpahfzEEjGLOYesT1NxSehl1liQSi/G+aXLWB/F8=;
        b=L369J5Baf8NsnI5Xc68TLi6+2jJaJgx3o+i5zoAi1xkYd+fY9SrUR9QZSDImbz49o2
         0oCFoQ4k7POEOWDABSztks9Slk45B76Tj3xzfS3MI8gZSCgUWVO71RtEYaBmwc5Fh5uB
         WeCTbNkCOkeBblH/VmLo2Ah40cyn3FCWSlkH+N+uFYlq06HX1PFbi10gW/Og9gUucSYq
         4W8OuMvC7+cEEWrVAXrhTk30ZqCE/O7t9Ex1CieyxJhkB3YFVHTvCiC1pXjhuPa+RCCQ
         7VHwMSBXDlnOTI7NQjx7OweVAIeRwq/5jasF1CA30BdSvCTfdyfe6sITV3lztwY6kNtH
         8lhw==
X-Gm-Message-State: AFuF++nk2Q9D4RRtnIe9Yw+ebN11V0eDEFxPoBEtXA0MhH9D4+IE4PAc
	C+6GO3nobrs/E2gOc8kV9ocw/QamztW8rHjP6hk9iWzS5zOwvv+OhuM7DrN8qKuZ
X-Gm-Gg: AYBFou1DfT+shf5cXnrapjzPgBd+s6irNNmiBAeYfwuwXXrTzYmqmkqbjqqOH6bFCuY
	g3rMGtvCWkE00UrVNeJ4mDCmq+Iw2Hm5p3BZR6jW9PM/71WwJjmN8VqNraisinyPtE85dkUh263
	HjdenD7O2EoUsQrS2uXtMnMVFd5dluqtt0dIJkpBGrbr3By2MXzcOJmaD51gYhVojN54kQpxqt6
	O6sV8ElSXn+Y916p9zmo/NLxS1jGmbUB63+nsPqU7T2iBDqzMEEtOVFmG3mZ6UW8K19Qam0S2Kg
	NwhbK9j/RlEVwvwQeaN5LjpcHjiJw1P8qFOkfqxkXX63O12aAkqVT/G+Eby4KEB6V5QKyWKxpRJ
	CFkFE1/6v+tKswY1dgTcDTP+m16C9BWCRQSXfLHnvDWa5xi2aMhUG4UBpbQjdMEza1vdFsn0P2Z
	OhPxQANJNc+Uk9xYWjzpfr0P/Z7HSuAmWgq3t8Li7r3ldC3lFnDqm2c4iMIb+bf7H7U7rp7UZbZ
	7cR6JMFmruexexfxJSqgw==
X-Received: by 2002:a05:7301:1448:b0:342:6595:d750 with SMTP id 5a478bee46e88-342711aadcdmr1028348eec.2.1790364432374;
        Fri, 25 Sep 2026 12:27:12 -0700 (PDT)
Received: from Velociraptor ([172.88.119.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757f31sm12487875eec.14.2026.09.25.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:27:11 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: m@lfurio.us,
	gitster@pobox.com,
	Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH v2] fetch.c: defer fetch.followRemoteHEAD validation
Date: Fri, 25 Sep 2026 12:26:58 -0700
Message-ID: <20260925192658.1166-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260922040047.2567-1-colinlewishinton@gmail.com>
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of the fetch.followRemoteHEAD configuration variable is
validated while the configuration file is being parsed, which
produces a warning even when this particular "git fetch" invocation
will never consult it

Store the raw config string instead, and resolve/validate it lazily
at the one place in do_fetch() that actually uses it, so a stale or
mistyped fetch.followRemoteHEAD value only produces a warning when
this fetch would have consulted it.

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 builtin/fetch.c | 67 +++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab7db2be06..6a5254a9bc 100644
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
@@ -176,24 +176,31 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "fetch.followremotehead")) {
-		if (!v)
-			return config_error_nonbool(k);
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
+	if (!setting)
+		die(_("missing value for 'fetch.followRemoteHEAD'"));
+	else if (!strcmp(setting, "never"))
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
@@ -1918,11 +1925,10 @@ static int do_fetch(struct transport *transport,
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
-	int do_set_head = 0;
 	struct ref_update_display_info_array display_array = { 0 };
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
-	int follow_remote_head;
+	int follow_remote_head = FOLLOW_REMOTE_NEVER;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1938,22 +1944,6 @@ static int do_fetch(struct transport *transport,
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
@@ -1962,8 +1952,13 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
-				do_set_head = 1;
+
+			if (transport->remote->follow_remote_head)
+				follow_remote_head = transport->remote->follow_remote_head;
+			else if (config->follow_remote_head_raw)
+				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
+			else
+				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		}
 		if (branch && branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
@@ -1987,7 +1982,7 @@ static int do_fetch(struct transport *transport,
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
 
-	if (do_set_head)
+	if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "HEAD");
 
@@ -2164,7 +2159,7 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (do_set_head) {
+	if (follow_remote_head != FOLLOW_REMOTE_NEVER) {
 		/*
 		 * Way too many cases where this can go wrong so let's just
 		 * ignore errors and fail silently for now.
@@ -2509,7 +2504,7 @@ int cmd_fetch(int argc,
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

