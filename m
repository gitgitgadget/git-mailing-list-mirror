Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20A3B19D2
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673532; cv=none; b=jhG3SHMsBtzQRB1BufCiLXhSUePa459vYBcxBfmiSZoBOiLMeFrD11yg/h36OKMx4zCbRv/9teHcRym0WbzMdIeUDYreu6b233hcjARK2N/ccRKwqXoMDtA7Sebts3NNr5lN98vp8NdfJriIap1oUiCIpCbS0FWKk9SYQTvMyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673532; c=relaxed/simple;
	bh=wVm9X/CN9qrPAdfrz6j6LiXI/sp540koZWqfIL6Xutc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6O/88wx6f4/iDiW8ggqfIJLGuD7b9PQr9eD0VbO9NicxPaYEb0UQr2nJjEAIx81+lDBgqp2A8CdwkQnGaMuFSJPSPaGzrKEWZriw9cDa6gSPiCu5gUQvMQVIOGRm9d7nMiw3FCbOjMVfEpXlPq073CAQwdcZpcqJdI1qyMZLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BigaZv4d; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BigaZv4d"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so84313266b.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673529; x=1784278329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s8T8aQwUfQGTAfTXyd12+mcIExSmoIekscuHrbHJ+wA=;
        b=BigaZv4dp3WS8T4L/hSwgVsTQZgmkjAHakyhe0P03oWTly5VUdKzxaCawdryZAK0ta
         zFU5td1N0vXIh+kFocr4zKQ5/ib2EGwpwPc0voI+/RWfenPBWeciMshLeS0wEeUl4dLb
         vf3KpHXGKuDv99ZymAp8M+27Y/Zd2HUVCBT6VymL8jJ8g8MA2RyC59tWlXbtkJ4NV5tP
         UgYJ2zzoRoNEMi+v8GafgWhAbUiJ9K9+eJiXqyXPvV2C5ehrhmxlx1Ur2ELKMvn0J/wr
         1K1BNtEeFPf4kJJIlwFu+TsZQtJjXzfhMk7f3zNd8hUZ0lRPf1Cq4D99bZxxQVrHRWE7
         b9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673529; x=1784278329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s8T8aQwUfQGTAfTXyd12+mcIExSmoIekscuHrbHJ+wA=;
        b=JHSoJsK0esoWGCtyHsYOwF7ms6Q9Z04BIgNpgAOVAww5U4Gcc4H5eVahpcDcMELUKk
         VF2mw0em09I5u5cBSMVj+PUy+iqw2aHAvTqxzH9Si1X+a67hSs95gQirleFmtEIJclEY
         MdUQIG5CID+pdN4guQgwcsRi2tRl3OEFZrCpo2IQ87vlZyKa1eR2X+mWwiUeQW/RPkOA
         /dMFfhEQV1M7YqF9Z5l3am0GFO/+o4reLuCwPdkaN3FlJsZfC5JWOatESyQ5aietfLmO
         WFbiHtx9TJNdpb+wtKpzMg/PR1rUd5Jn2jx/bUYHGblFrzXeSANa+GMbwbXvaMmu74Sx
         c0Dw==
X-Gm-Message-State: AOJu0YzccrDUQohRFzXJ5a9RZEhfZvVk0JwfkCl4c/pbjwZ/EuGPY7sz
	WAcooVILubdodh9NKJljvjzxZZ6kylQuWtXJehU9FIrZSncKxr/nj6s4C1II64um
X-Gm-Gg: AfdE7clrWDbhsNeI4n3prELKFfyICleRnupyFosPhpUci6VLnrUcVNHxO1EyvhmLrcq
	sxABotsoVGHWEEJrAAKqSkNNOgFqb3eO8q6BRXRdA9/0Te9kPZqOZcJMQQ/XrQJrq6TJSEkBg23
	cBnM4L8XCS8Pp7brO07qaRxe/ZgAVC1xHVrjiiHMoMVdnVnTuSaRPsDIuAePofNqgcl/ubK7ATJ
	ivUHfS0jIs4nBivd70Z6/j0oIOUN2OZZWlyFjOxL0YNXLiNH2febNHHRE/w5HuAIxs7BQieb1P8
	xYn/QRbHHjfiD5zr/MkwfYGuSfl8CzlY07pJXS7VMc5X8alHliIofZ0h+an1HXEzm/A9VxWgkQY
	rgaiEmH8BSwWBVTfdOPSL7d6urXGHYxf/78QoJBPiyjMzidXptbb4hcs7SAaoCTUdO8e7SxNkK6
	RdJ1onyz8ESOsm9ojNjs7ZHsIb1A//ciVVq/uv1BsYNvRzot8bL1lC65hqBYAFyZrEoh0DZR3uD
	6/nrGy2DPoCM2o4CWbCIYsrlswd
X-Received: by 2002:a17:907:c13:b0:c15:e956:f529 with SMTP id a640c23a62f3a-c15e957138bmr244376466b.8.1783673528809;
        Fri, 10 Jul 2026 01:52:08 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15eb1dbdc9sm199561166b.10.2026.07.10.01.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:52:07 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] promisor-remote: introduce enum allow_lazy_fetch
Date: Fri, 10 Jul 2026 10:51:36 +0200
Message-ID: <20260710085137.4171240-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.125.g395cd2c8ec.dirty
In-Reply-To: <20260710085137.4171240-1-christian.couder@gmail.com>
References: <20260710085137.4171240-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `GIT_NO_LAZY_FETCH` environment variable is currently parsed as
a Boolean, using git_env_bool(), in both "setup.c" and
"promisor-remote.c".

In a following commit, we are going to allow a third value for this
variable, on top of 'true' and 'false'.

To prepare for that, let's introduce an `enum allow_lazy_fetch` with
the possible results of parsing the variable, along with a
parse_allow_lazy_fetch_env() function to parse it, and let's use them
everywhere the variable is parsed.

Note that, as before, an invalid value makes us die(), only the error
message changes from "bad boolean environment value ..." to "bad
environment value ...".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 24 +++++++++++++++++++++++-
 promisor-remote.h | 13 +++++++++++++
 setup.c           |  5 ++++-
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 65496c69cf..56f57c5267 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -21,6 +21,26 @@ struct promisor_remote_config {
 	struct promisor_remote **promisors_tail;
 };
 
+enum allow_lazy_fetch parse_allow_lazy_fetch_env(void)
+{
+	const char *v = getenv(NO_LAZY_FETCH_ENVIRONMENT);
+	int val;
+
+	if (!v)
+		return LAZY_FETCH_ALL;
+
+	val = git_parse_maybe_bool(v);
+
+	if (!val)
+		return LAZY_FETCH_ALL;
+	if (val > 0)
+		return LAZY_FETCH_NONE;
+
+	die(_("bad environment value '%s' for '%s'; "
+	      "only 'false/0' and 'true/1' are valid"),
+	    v, NO_LAZY_FETCH_ENVIRONMENT);
+}
+
 static int fetch_objects(struct repository *repo,
 			 const char *remote_name,
 			 const struct object_id *oids,
@@ -299,7 +319,9 @@ static bool lazy_fetch_objects(struct repository *repo,
 			       int *remaining_nr,
 			       int *to_free)
 {
-	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
+	enum allow_lazy_fetch lf = parse_allow_lazy_fetch_env();
+
+	if (lf == LAZY_FETCH_NONE) {
 		static int warning_shown;
 		if (!warning_shown) {
 			warning_shown = 1;
diff --git a/promisor-remote.h b/promisor-remote.h
index 301f5ac5cb..87fc24c9eb 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -25,6 +25,19 @@ void promisor_remote_clear(struct promisor_remote_config *config);
 struct promisor_remote *repo_promisor_remote_find(struct repository *r, const char *remote_name);
 int repo_has_promisor_remote(struct repository *r);
 
+/* Enum for lazy fetching parsing */
+enum allow_lazy_fetch {
+	LAZY_FETCH_NONE    = 0,  /* No lazy fetching */
+	LAZY_FETCH_ALL           /* Lazy fetch from any promisor remotes */
+};
+
+/*
+ * Parse the NO_LAZY_FETCH_ENVIRONMENT env variable into an
+ * `enum allow_lazy_fetch`.
+ * If parsing fails, then die().
+ */
+enum allow_lazy_fetch parse_allow_lazy_fetch_env(void);
+
 /*
  * Fetches all requested objects from all promisor remotes, trying them one at
  * a time until all objects are fetched.
diff --git a/setup.c b/setup.c
index 0de56a074f..0a81d9f045 100644
--- a/setup.c
+++ b/setup.c
@@ -24,6 +24,7 @@
 #include "trace.h"
 #include "trace2.h"
 #include "worktree.h"
+#include "promisor-remote.h"
 
 enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_EXPLICIT = 0,
@@ -1051,6 +1052,7 @@ static void setup_git_env_internal(struct repository *repo,
 	const char *replace_ref_base;
 	struct set_gitdir_args args = { NULL };
 	struct strvec to_free = STRVEC_INIT;
+	enum allow_lazy_fetch lf;
 
 	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
@@ -1072,7 +1074,8 @@ static void setup_git_env_internal(struct repository *repo,
 	if (shallow_file)
 		set_alternate_shallow_file(repo, shallow_file, 0);
 
-	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
+	lf = parse_allow_lazy_fetch_env();
+	if (lf == LAZY_FETCH_NONE)
 		fetch_if_missing = 0;
 }
 
-- 
2.55.0.125.g395cd2c8ec.dirty

