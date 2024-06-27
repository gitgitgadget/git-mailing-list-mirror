Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3340198A2E
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501190; cv=none; b=MaWhtgpcOahxLxqhq/mkBvh7vRLRXg8k3mEXVfGB/JtVUj6MTdjlUvphbUTg0zW2c5XlhXYX9+VV0AX8OzfMkEG4Jy4UaXYJ0MU23aBGPtzbAU9CJzS0dOfKnxGZuMDcCwcilIt08N8SL4anRWAH4GrpiK/Mkj5Yp88ElLn61BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501190; c=relaxed/simple;
	bh=RTqiPnxywsUyIdghyVHF5hRKhzUpLCWlKayt8SVcRHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4p0eODZJVRwXopJeLKIv3mRODGrCf7vb1ADLktUdCmzxJjbnDXKTpN8IYPNkIYLw0bfsjqaFTVV9OrsNv6OXCwBSd9wPeFjS255cNyuYPEAx3H7l3V/Ol45GMjeBQcNrGDwV4G7BEtK5ZTmWXsm+RwkRw7mAIiGWDyS7uhpUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOTP02q/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOTP02q/"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-707f9c3bd02so349897b3a.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501187; x=1720105987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pq6SCM1rjT/Vc0WW6DOriW1hZ8h0R5z5wRIJH2w85dM=;
        b=NOTP02q/VSEi4HSywD5jE3+wrvf1wDSYS1bVsLXDGnLSXdqvOI6tDMqbK2ZhZKDneP
         3OfBC48ywlo2RtE1xhcGuoOafcap6eQPfEXp/ex0hhhawdCvg5439MUBc395RaLrjX+y
         IPwTwuqEp6CQdUNrAGBFyOUs1YOrbP5VnOOHjnuH0Z5blJ8alAuDqV8qhpg0YEY4MGvn
         XIy7reD5AybFDqet13Cuoxs3MvyzTskIse6Z19F8EY0rZW+H32xYzY6LzVrdP+/mCS59
         n+X9DTS89dkW1qiclYNJj9OM7i8Jr5H0eH+RklQI7Rq5orBUPOhvJ5ARZI8tNcVXhbAN
         9IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501187; x=1720105987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq6SCM1rjT/Vc0WW6DOriW1hZ8h0R5z5wRIJH2w85dM=;
        b=oKv/P1r4jwUJeIGyeiief1rpFWLFX8KSeVMW85majiklpOLIX5Wf4O6Tcs3t2oOSMn
         bv+skw8Svt92dRHLtTcjBiAFIqXwd2lhyazQVBXcXIhwyfrN2zonmZBC/Lj2s0t+HZSm
         5ZFH7kU1BHRo59F9nufN5TVNlgPjbSjb7srQEOA3LSkj+uCKbgwPdagRoRviJsd+WDXT
         Qgmxu3SY21DK80Ts1woCk7LfA6p7ftNkN5Eh4Cjwpc514bAw5jQJyM6WSsuVlMTf7mwj
         Ajr6a/3DdKDEGmzXnNLrEnp2ZCkNbJMVLwrKoxK9Z9pHAL97jGrGUfBLO7YRF9Bf5xpT
         EDag==
X-Gm-Message-State: AOJu0YyNKQkiN6Cfcv6eI5luwKYYdhfJ9qZyShQrp+1cwuhiAuH8FoaJ
	j4Thun9Ewx77er3xlOPmwZ1xi0vGY6+CZuNR/W4HBcBaIQOdamEmkG4/zg==
X-Google-Smtp-Source: AGHT+IGirkj5rKtiTu4f1qhbQzunQnv52knQsuYgIVQWWMgDdQqpuxZajdyiLp323ZdfebwMCbihpg==
X-Received: by 2002:a05:6a00:1715:b0:706:6bf8:bd2 with SMTP id d2e1a72fcca58-706746b5c30mr12608251b3a.21.1719501187354;
        Thu, 27 Jun 2024 08:13:07 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b49104acsm1473115b3a.46.2024.06.27.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:13:06 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:13:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 02/12] fsck: use "fsck_configs" to set up configs
Message-ID: <Zn2BgEw0geZwvr3_@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

Some fields such as "msg_type" and "skiplist" in "fsck_objects_options"
are not options, these fields are related to "git-config(1)" which are
initialized using "git_fsck_config" function.  Create a static variable
named "fsck_configs" in "fsck.c" which aims at handling configs. Thus we
don't need to reply on the "fsck_objects_options" to set up the fsck
error message severity.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 29 ++++++++++++++++++-----------
 fsck.h |  3 ---
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fsck.c b/fsck.c
index c24a0f9fae..81b93f02fc 100644
--- a/fsck.c
+++ b/fsck.c
@@ -24,6 +24,14 @@
 
 static ssize_t max_tree_entry_len = 4096;
 
+static struct {
+	enum fsck_msg_type *msg_type;
+	struct oidset oid_skiplist;
+} fsck_configs = {
+	.msg_type = NULL,
+	.oid_skiplist = OIDSET_INIT
+};
+
 #define STR(x) #x
 #define MSG_ID(id, msg_type) { STR(id), NULL, NULL, FSCK_##msg_type },
 static struct {
@@ -103,7 +111,7 @@ static enum fsck_msg_type fsck_msg_type(enum fsck_msg_id msg_id,
 {
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
-	if (!options->msg_type) {
+	if (!fsck_configs.msg_type) {
 		enum fsck_msg_type msg_type = msg_id_info[msg_id].msg_type;
 
 		if (options->strict && msg_type == FSCK_WARN)
@@ -111,7 +119,7 @@ static enum fsck_msg_type fsck_msg_type(enum fsck_msg_id msg_id,
 		return msg_type;
 	}
 
-	return options->msg_type[msg_id];
+	return fsck_configs.msg_type[msg_id];
 }
 
 static enum fsck_msg_type parse_msg_type(const char *str)
@@ -138,16 +146,16 @@ void fsck_set_msg_type_from_ids(struct fsck_objects_options *options,
 				enum fsck_msg_id msg_id,
 				enum fsck_msg_type msg_type)
 {
-	if (!options->msg_type) {
+	if (!fsck_configs.msg_type) {
 		int i;
 		enum fsck_msg_type *severity;
 		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
 			severity[i] = fsck_msg_type(i, options);
-		options->msg_type = severity;
+		fsck_configs.msg_type = severity;
 	}
 
-	options->msg_type[msg_id] = msg_type;
+	fsck_configs.msg_type[msg_id] = msg_type;
 }
 
 void fsck_set_msg_type(struct fsck_objects_options *options,
@@ -203,7 +211,7 @@ void fsck_set_msg_types(struct fsck_objects_options *options, const char *values
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1);
+			oidset_parse_file(&fsck_configs.oid_skiplist, buf + equal + 1);
 			buf += len + 1;
 			continue;
 		}
@@ -217,10 +225,9 @@ void fsck_set_msg_types(struct fsck_objects_options *options, const char *values
 	free(to_free);
 }
 
-static int object_on_skiplist(struct fsck_objects_options *opts,
-			      const struct object_id *oid)
+static int object_on_skiplist(const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return oid && oidset_contains(&fsck_configs.oid_skiplist, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
@@ -236,7 +243,7 @@ static int report(struct fsck_objects_options *options,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
-	if (object_on_skiplist(options, oid))
+	if (object_on_skiplist(oid))
 		return 0;
 
 	if (msg_type == FSCK_FATAL)
@@ -1109,7 +1116,7 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 {
 	int ret = 0;
 
-	if (object_on_skiplist(options, oid))
+	if (object_on_skiplist(oid))
 		return 0;
 
 	if (oidset_contains(&options->gitmodules_found, oid)) {
diff --git a/fsck.h b/fsck.h
index b64164db17..37deadc4bd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -135,8 +135,6 @@ struct fsck_objects_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
-	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -145,7 +143,6 @@ struct fsck_objects_options {
 };
 
 #define FSCK_OBJECTS_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
-- 
2.45.2

