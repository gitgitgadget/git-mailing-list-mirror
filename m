Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C748A2C2
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377590; cv=none; b=ipTegaU2Sp2ENeg1uDyyj0msSI/v7YRBFq2Quybq5mnoBDiiFX1n9e/d6biX+rIiyrGCNsrppsbGOMaNc/jJFL0KHYEd945uPXE7VZQdOREg65ZsGmZluIb0d+xWWXS6ZOc3pKQB0xszlVNJEq/Dqa3CSxNB9NM2u4+oiVLTFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377590; c=relaxed/simple;
	bh=WDkWeAxk74CZw2+ugCGwLZbQn7NydGPo7+F9p2lHnbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxkLhXF/X+qQ9E8bk3W3bI5qNZdG3RU3/hdogIoXMjYyS0pJinMIPUuynXaUGISUGr4vyG1TCnmJ8I+QkTVk7Wj9NEkQqXTwOLuFCUkQ2ONPd7H+8qJ3M/QgBQ0ZPTCva9HTIN2SIlYIzP7lEPwdX2FVSJpIQB7TbZU+FjqS4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUrMV/pe; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUrMV/pe"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33b9e805130so948445eec.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790377587; x=1790982387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ByEFYipSo2vWwlG4Kwo3MRs93vlSoU015nH0zDIRxkk=;
        b=AUrMV/peJxzQzN+gLuP/GDmJhIGD7StI549F2qg4iHjEseugMrxTtIop43CCyC6RnK
         f0OB7IevyN5Fbx88VaMEToNkK5NxXWvxgOjAhyfaKFexwl24QQFfUsmbmO1kWZ8wCMev
         IxDknmiidt0Hjw/voM33ok3kkxfjS0YHxrnlpjQ771hUud0NGMIu2A7EYsCcL/I1tYuh
         rx5Z6foHCuCoAp7mgkQxZs8ibEHEvqL9bMAdeawXKskS4S2kchBrBhEbm9Pm5wCsX2Kc
         /p1zM2cDE3OHMZ3S2JTzvdNqKZJXOiaMc390CA/IxH1jxPkaHGcevqSfukIdaX1NtBV7
         nC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377587; x=1790982387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ByEFYipSo2vWwlG4Kwo3MRs93vlSoU015nH0zDIRxkk=;
        b=FeWb0+pEFs6Ye1GPLm5Eow0xJM8JfNkfRKxm9CVvEjUXULyXsoN3eLo6Z/YI3wLFD7
         8eXqyvNQZ3WnoVxWD5fWhJpOOHdXYOaeItYknfpmEnbgffL8uw5j+tAlrE75F2XNwbGa
         72mx1Krpf/CXxQynjnn6gKEmYKbwNL/PpyQYu2zdYVitcIQljPbLp89G6R6Yyi1fEJEC
         Q9vC0sbcJOum3QmQ0OtbBbamcu3xCDcau6otnaOCYBM7ZvdX2FwoYv2axhMj7PFhl0Xj
         YMbLTlDRj9JSs47gQVBu3zVNq3garaOqDVGYkv87X6tTBoG8JO2o5+a/kEPIFL59gOXM
         5wOA==
X-Gm-Message-State: AFuF++mH+k3OEWAgOiwmLAjfZ6n/9tXDRHBtk6B/O0ZxPuXrniLAnaWH
	8dZ8dkt1Wj3la9wuw2iIZzb/Hm3pKGD3i4wdoejoxsp1LoKt1iwHuAQiHV8//K4v
X-Gm-Gg: AYBFou3f0BF5MKy7Kqa0VR3ZGAosn1C1kvFsS2ACnXifCNcjzfDcsWfRrw0Oqiz0kog
	04KbzVYuGBxMDjTdh+eFSLsPpdiz6MEeI60cgFwnB5JnNPVtmC5xHJk39wbvaIbCYc/Z2rQ5e1E
	uascyW0Ziu/pLduPZfgDMBY9Y8dzp1SWHChpILToALFCw1TEaERcFbBJlbr3j7cbtqRkWClIFhm
	Ddh2mPERsPpMmqHoomNxjO6Beb/wqPjK9s2OGJFSDh9LI19dyS5myIdQh2+ADHmQC9w/2LWNCTG
	If9XiCb9/Bc5peTCUUBK8f0egjX1yfHNpFQUJnOp3O7gUGcgzPEq/mTnvYM+glxr1UjR08BAeBW
	DFkNLDyuYlQo5ozn4B2rdm5oPD9bS74AYZROIsWn4eDdMbsGg5Tc0OvqsQjQt0qQXMOkgtymC4h
	3wzdVTC5RLR1Gx5GOY/zKdvLAyETLYXy2fb9VNANQX0WY+K1kPkgzn1gaWXkVE49kWBVLBJYX+h
	JhRTVnCtnww/yJRo0h1oXQ=
X-Received: by 2002:a05:7300:c8cb:b0:33e:d4ae:e10e with SMTP id 5a478bee46e88-342746276b6mr1413163eec.40.1790377586526;
        Fri, 25 Sep 2026 16:06:26 -0700 (PDT)
Received: from Velociraptor ([172.88.119.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343025a591csm491707eec.12.2026.09.25.16.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:06:25 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: m@lfurio.us,
	gitster@pobox.com,
	Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH v3] fetch.c: defer fetch.followRemoteHEAD validation
Date: Fri, 25 Sep 2026 16:06:21 -0700
Message-ID: <20260925230621.179649-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260925192658.1166-1-colinlewishinton@gmail.com>
References: <20260925192658.1166-1-colinlewishinton@gmail.com>
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
index ab7db2be06..85e3d1ca4b 100644
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
+		fetch_config->follow_remote_head_raw = xstrdup_or_null(v);
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

