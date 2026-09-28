Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A34C2240
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602753; cv=none; b=sca/gwxTyfVulPPQa+mgrWdoOFU8lLGY8DIYdO32+dBuheSeNW2r8ScWqVX7mx/Hf2YlCH/fXoveAaxZPefulkDsQtgAH55ChLE6WFhYp6/M1Cr2ClYiJkg+ab2yRVVjTN1aqVu8gsqDPu1gvJM4hywsmOg2+yxDcbglmK6WsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602753; c=relaxed/simple;
	bh=3wJ//DB3ylKX1Wo6wntASHty2xnEaipWOCNEaQRKBtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LetAxUiFAVgj0um0UA63Kzyr7ydzbsoQi+z1X9yhM0fL4RsnTsbOq0lgM3zMu4MDcuchOs6jXKBukkbRuELeiJcG40CxZy1OlyUqsIHugMirFAYkBdBlSGPJykcbOX1/AcsBpbCMQzi+1EsCHsZ7DkDeRmQQDPXWzWFhixojTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr4Qw9Op; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr4Qw9Op"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so1929604f8f.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602748; x=1791207548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kD3m5wKVbw+iZDfD33vAaRxefKBs4o6vtdGZ4kcobKM=;
        b=Sr4Qw9OpxZUZb71eWljD7JTR6z8VhlLmwGCtfOZalsfpKdhMoJxxC0T7LS5DcpZGN2
         cj45Ksda5tZ78on76E1YBgR4M92eAE0ryu12S6qFO/A7RA/Ch0yog+Du8QwuSb1dwI/+
         CsmKSZRe17iBKXxhsmv/DgvadBlwUKugc5Uflf4ROFJJa5nETKyHjCF6OdbjJJSXFYQq
         d3S7krr6N+y04ZdUuFEHdAvZiZcodD2B1qePIyZRaOsnZPmXIUzgonmJSYyoePKBG/Gb
         qAS8EYEpKyOcVL7+XvcW8XPStlQ6031O/qLJ1ARE9TVPcZJNz/sBceoaoheqG7hE9tkW
         C0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602748; x=1791207548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kD3m5wKVbw+iZDfD33vAaRxefKBs4o6vtdGZ4kcobKM=;
        b=Rr9rS1w2gyeAITm4viFWEEHMEr30sVR3KM5mAYfDS0NwBP13HoYFkzywzGf7wlBYaM
         xiLThC47dRoLQG7CxHj/oUoeNXtL/KjRLmYPjpvtkQkgnLnGSB6gBPZ1nGt84wRHr/GC
         exFuKflMp9gYPoqvbnsHkXLNbq89elht60nJnF9TRy0FFo9mAK50/FGpKdP7qqMBA8My
         KHkwkiAfBfnJhNExIY2Y0BiDzMIHj+rrYibf6BJBlTc6JYEeafLxglDiHE6MRE1zAQmW
         rkIeuewCC4ULP9T63cPIpAI5KUoQmJ0+HIVlh0GpOKKqfy0Cb6hLaI4EtfI6Y1+sPoWP
         a4yQ==
X-Gm-Message-State: AFuF++nH1zaCoW2s145+aFJPMFX/eboH/O3Rf9LuW8exMIaGZrbZCgio
	ZtTYrHL+NyeKwDty5Gaahfs91eoUZ3zVmrc9euN19IecbCQRYTEelOiva1ANjg==
X-Gm-Gg: AYBFou05aD6uaki1E2R8QkAPNkL257bG67KmQwVLYQcYSHleeIVs3CSE5BS030zGzFH
	tufsS+R5euJyUxK2zBhVwrcfdibt/4A9JXCD5v7yrwb40Mz+p4bpUTmoClB3m7e0lspZ3MaxSUn
	Jflt2lS9pnb4JFhh36jHKYTLZ5o51gGBjCKfuZaykRM5nZtTdBRt0NZnzJnogb3uFFAWAPOwiAr
	9V4/CdDgYcjymGbIe/m6HcXKrq970Zk5WI94ATBZNmQcO9qJKqCN0jSLYhNkPqkXHDkzb2UatwU
	LDckUO/7zow7AMGcimbFnIWGgxcmNGTW+gsdIE9u3H0new8As6f2GmnTHvx+fmkWTD8Qr6eJEYY
	4K+0qSlx7IwrYTQFYtJGccFB4FGGcg8bSV9ZGal7GJD/AAUCve3tTOwnIshGvkkjluLH5qxYQLR
	1QDq7QlxgyciLldY53IxGmJz+z7E7B3YvscbaC8z9LP+r0KARI60v99BJKVFFal7ZHEZjVdbBcc
	TgZg38Fp+m5GNiv96nwJBB4CioeR3qq403X/fu0yLuiKHblxTb18trOjLqUoHrYo09mWIGdM3GM
	f9tp+IcNR/jI1+HznyCqkcXzwnmsPCom611y2c4mCHynNfIo//XpOaX6ntXb/ecBUwWJBekrQai
	xVzDbhnhO
X-Received: by 2002:a05:600c:5494:b0:49f:ff7b:f056 with SMTP id 5b1f17b1804b1-49fffd734bamr86764395e9.9.1790602747913;
        Mon, 28 Sep 2026 06:39:07 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm5554505e9.0.2026.09.28.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:39:07 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 1/5] promisor-remote: factor out lazy_fetch_objects()
Date: Mon, 28 Sep 2026 15:38:42 +0200
Message-ID: <20260928133846.2094261-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20260928133846.2094261-1-christian.couder@gmail.com>
References: <20260908164129.560396-1-christian.couder@gmail.com>
 <20260928133846.2094261-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "promisor-remote.c:fetch_objects()", there is a check to disable
lazy fetching when the `GIT_NO_LAZY_FETCH` environment variable is
set. The fetch_objects() function is called once per promisor remote
though. So the check might be performed more times than necessary.

Also promisor_remote_get_direct() mixes up the logic deciding which
promisor remotes to try with the logic checking that the objects
that could not be fetched are promisor objects.

Let's refactor the lazy fetching logic out of these two functions
into a new lazy_fetch_objects() function.

This is a pure refactoring with no intended behavior change. Two
things shift in ways that are observably equivalent though:

  - the `GIT_NO_LAZY_FETCH` check is now performed once up front,
    instead of once per promisor remote, and

  - promisor_remote_init() is no longer called when lazy fetching
    is disabled.

The latter is fine because the convention around promisor_remote_init()
is that whoever needs to access the promisor remote information is
expected to initialize it beforehand, and not that it should be
initialized once at the very beginning before doing random things on
promisor remotes. So moving its call site into lazy_fetch_objects(),
which is the only code that needs the promisor remotes here, follows
that convention. Nothing downstream of it, like is_promisor_object(),
needs it when lazy fetching is disabled.

While at it, let's document try_promisor_remotes() and the new
lazy_fetch_objects() function, especially how their `remaining_oids`,
`remaining_nr` and `to_free` arguments are used, as the ownership
rules around `to_free` are easy to get wrong.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 promisor-remote.c | 83 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 26 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 43505d1e1a..91245fe9a8 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -31,15 +31,6 @@ static int fetch_objects(struct repository *repo,
 	FILE *child_in;
 	int quiet;
 
-	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
-		static int warning_shown;
-		if (!warning_shown) {
-			warning_shown = 1;
-			warning(_("lazy fetching disabled; some objects may not be available"));
-		}
-		return -1;
-	}
-
 	child.git_cmd = 1;
 	child.in = -1;
 	if (repo != the_repository)
@@ -270,9 +261,27 @@ static int remove_fetched_oids(struct repository *repo,
 	return remaining_nr;
 }
 
+/*
+ * Fetch the remaining objects (given in '*remaining_oids', which
+ * contains '*remaining_nr' object ids) from the known promisor
+ * remotes. If 'accepted_only' is true, ignore promisor remotes with
+ * their 'accepted' member unset.
+ *
+ * When a fetch from a remote fails, the objects that are still
+ * missing are computed, and '*remaining_oids' and '*remaining_nr' are
+ * updated accordingly before trying the next remote. In that case
+ * '*remaining_oids' points to a new array that this function
+ * allocated, and '*to_free' is set to 1 to tell the caller that it
+ * owns that array and should free it. '*to_free' should be 0 on the
+ * first call.
+ *
+ * Return 1 when all the requested objects have been fetched, 0
+ * otherwise.
+ */
 static int try_promisor_remotes(struct repository *repo,
 				struct object_id **remaining_oids,
-				int *remaining_nr, int *to_free,
+				int *remaining_nr,
+				int *to_free,
 				bool accepted_only)
 {
 	struct promisor_remote *r = repo->promisor_remote_config->promisors;
@@ -295,6 +304,38 @@ static int try_promisor_remotes(struct repository *repo,
 	return 0;
 }
 
+/*
+ * Lazily fetch the objects given in '*remaining_oids' from the
+ * promisor remotes, trying the accepted ones first. See
+ * try_promisor_remotes() above for how '*remaining_oids',
+ * '*remaining_nr' and '*to_free' are used.
+ *
+ * Return 1 when all the requested objects have been fetched, 0
+ * otherwise.
+ */
+static int lazy_fetch_objects(struct repository *repo,
+			      struct object_id **remaining_oids,
+			      int *remaining_nr,
+			      int *to_free)
+{
+	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
+		static int warning_shown;
+		if (!warning_shown) {
+			warning_shown = 1;
+			warning(_("lazy fetching disabled; some objects may not be available"));
+		}
+		return 0;
+	}
+
+	promisor_remote_init(repo);
+
+	/* Try accepted remotes first (those the server told us to use) */
+	return try_promisor_remotes(repo, remaining_oids, remaining_nr,
+				    to_free, true) ||
+		try_promisor_remotes(repo, remaining_oids, remaining_nr,
+				     to_free, false);
+}
+
 void promisor_remote_get_direct(struct repository *repo,
 				const struct object_id *oids,
 				int oid_nr)
@@ -302,28 +343,18 @@ void promisor_remote_get_direct(struct repository *repo,
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
-	int i;
 
 	if (oid_nr == 0)
 		return;
 
-	promisor_remote_init(repo);
-
-	/* Try accepted remotes first (those the server told us to use) */
-	if (try_promisor_remotes(repo, &remaining_oids, &remaining_nr,
-				 &to_free, true))
-		goto all_fetched;
-	if (try_promisor_remotes(repo, &remaining_oids, &remaining_nr,
-				 &to_free, false))
-		goto all_fetched;
-
-	for (i = 0; i < remaining_nr; i++) {
-		if (is_promisor_object(repo, &remaining_oids[i]))
-			die(_("could not fetch %s from promisor remote"),
-			    oid_to_hex(&remaining_oids[i]));
+	if (!lazy_fetch_objects(repo, &remaining_oids, &remaining_nr, &to_free)) {
+		for (int i = 0; i < remaining_nr; i++) {
+			if (is_promisor_object(repo, &remaining_oids[i]))
+				die(_("could not fetch %s from promisor remote"),
+				    oid_to_hex(&remaining_oids[i]));
+		}
 	}
 
-all_fetched:
 	if (to_free)
 		free(remaining_oids);
 }
-- 
2.56.0.rc2.20.g34f06850c1

