Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22084374A0D
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110940; cv=none; b=A7QU6BMLEsaR2tdD9yH3WiupETzWcOWyvQxmC9TNDZ0k4jP2egjzSEVkLCnd1a92+2aP1oCFYx4BIlPiIItWorQOv+/b0SLtXfx+0MCdEJZ6UFrH8Rxl/AsjJLEXmbsSRMTwiNm07SPM2P/E9vdI0GbezU3FyHNs4D45Ii2Z418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110940; c=relaxed/simple;
	bh=C7EKuR5zSy+q7gyKgHi6FH8bTlUx7mhF0ZC5N5i+9a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm5+F4mnDOqSo3ZfrF9c3D84is8aQcijLXyCzpf8Dt3hX0PW0XQjCPByPDzUFkJJjtS02iuSskhhwJlHKamkPTeR0mlLOcIPXaXiik2idI6P4hbbt6yreMuQQyxN6EPBm1Dtkq6kD/LsPJWoD43SzlGvDEFqit3dNZS7Onk8YK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC1ZAMAx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC1ZAMAx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso25214745e9.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110929; x=1786715729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2ctPqfKLQTRxPuemZ+KqlcO12dmtG1MWe3xp+KwYSs=;
        b=YC1ZAMAxs0UQ5ObEBpx3wP0lpSBTSydA0u9Uc+tPtOcH0mgd2z9deZJoM3iH3tQuUL
         FqMPzOYgiip5m11rz/lLnujM1kQPP5oewquRY/0iWI2dkYlp2sUIBhp1kc8rgFLqRRkS
         whDUVLaoyXOhjJDw856NYiEAZdCMLQQBHG+eOKe9iw2N48iDRisTd7BbHtj3pp2v4Fsz
         zAphwkn5qQXc7UWUkPfoMTe+cd+fIjaJ26MzjvKioUT8DIsrC5HsW0uHf6kTWY/tHHxX
         ZbSHGMzW1aL9I22fK/NM012XrsMTjBXRszphWWacuqfBF5EV5tK9C5S81QVDGRzT0H0P
         KRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110929; x=1786715729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2ctPqfKLQTRxPuemZ+KqlcO12dmtG1MWe3xp+KwYSs=;
        b=QO6ZeLANMJ7upYFMSXGLSyX+YBYVB9A+ABlJAZZdcmpnRzIyRt2WmjE1LGlMOzxenb
         lZIt/cXF09wp57SBPCkzmQEFXjboWsHnG0aAquMFrOXtXfQGy3nxj5aERX48GR3iJvgk
         /1sbnSBT8Vroqx/NEelLVody/EjX6u4rLYXlGYIIEDV38RLzM4sIktjXyX3ip8ueDJHn
         dYWA2E8ZoMotfbKnndSht+rEeIVuFYFdW73Mw1L+XB9f9wWNEvdmoZkgCC2+17b7R586
         45spN7mFcdz9ReisSsLsGsNOyCkIOG+NovXQt9evR3/aWSPJJnHPsubpZKlBC4lagkDT
         SbvQ==
X-Gm-Message-State: AOJu0Yy6z/V9BZRPNToVC4+MiYilBgAAzGkIP100Ui9oiaOPmBJ3WWTW
	gArL9xCpJ18Ft3ZsTYpPoPRVbf4edKmA+Dg94/m07LlDYThTHQgxHVjjCUXUvA==
X-Gm-Gg: AR+sD12hD1DK8CQw1WixBwA/rNqPrMfMFH6XeORVgyIzj4IooxJWPL4doTq29g62OzP
	vjXSYQTiuwe9eoT222mR5dRPLT1NgXohO4N2eq2MwU9bR2Zs4P2c1DvbtdopwTadxk31SRfFObO
	tZcmrAu7TUu18bLXjz3YvZ4f1YlgAolL7ltJ9MflmmCzcJyZTBE3749mq6WCgkuah0SP2JMy02F
	CMxYzrhU0Q45bSGW0X12Jb8JNKDZOk0t/bjfCMJMrjJDblsLtRY/wtw6x+EUbgUoN2EtIUhkHMX
	YsNg4aTjacEzWKCwAEbotYtOituOIpEZ0ufelEhzcakmaKqYUrx27oXlEBQbn+hNLaoMxLfX0wE
	Jo5vzfRZN1X2RVRmmuTtppC4dW3JUkf0bXg295gL9UVbM+pVzMmqAmczwZWzxNKKashDX70bVkl
	emN6eYTM5ejYsSAfDIp7rVCN+Om/p10bbqroTohnfb5ZPxTwpwEwSLMlOqFPhuOc9nYz9enEOGV
	NXnfnhlhQnfmrYuUfYcgGJXvhO4EnqyxLEamDM3YpULj+JoW+Dr6L/azYgxcbH45QAc4Go7c3Rc
X-Received: by 2002:a05:600c:474f:b0:499:5210:c537 with SMTP id 5b1f17b1804b1-4995210c57fmr198343235e9.1.1786110929298;
        Fri, 07 Aug 2026 06:55:29 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm6094207f8f.22.2026.08.07.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:55:28 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] promisor-remote: factor out lazy_fetch_objects()
Date: Fri,  7 Aug 2026 15:55:07 +0200
Message-ID: <20260807135511.1818458-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260710085137.4171240-1-christian.couder@gmail.com>
 <20260807135511.1818458-1-christian.couder@gmail.com>
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
    is disabled, which is fine as nothing downstream of it, like
    is_promisor_object(), needs it in that case.

While at it, let's also convert try_promisor_remotes() to return
'bool' instead of 'int', as it just returns whether all the objects
could be fetched, and document its return value.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 76 ++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 43505d1e1a..65496c69cf 100644
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
@@ -270,10 +261,15 @@ static int remove_fetched_oids(struct repository *repo,
 	return remaining_nr;
 }
 
-static int try_promisor_remotes(struct repository *repo,
-				struct object_id **remaining_oids,
-				int *remaining_nr, int *to_free,
-				bool accepted_only)
+/*
+ * Return 'true' if all the objects could be fetched from the
+ * (non-)accepted remotes, 'false' otherwise.
+ */
+static bool try_promisor_remotes(struct repository *repo,
+				 struct object_id **remaining_oids,
+				 int *remaining_nr,
+				 int *to_free,
+				 bool accepted_only)
 {
 	struct promisor_remote *r = repo->promisor_remote_config->promisors;
 
@@ -290,9 +286,37 @@ static int try_promisor_remotes(struct repository *repo,
 				continue;
 			}
 		}
-		return 1; /* all fetched */
+		return true; /* all fetched */
 	}
-	return 0;
+	return false;
+}
+
+/*
+ * Return 'true' if all the objects could be fetched, 'false' otherwise.
+ */
+static bool lazy_fetch_objects(struct repository *repo,
+			       struct object_id **remaining_oids,
+			       int *remaining_nr,
+			       int *to_free)
+{
+	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
+		static int warning_shown;
+		if (!warning_shown) {
+			warning_shown = 1;
+			warning(_("lazy fetching disabled; some objects may not be available"));
+		}
+		return false;
+	}
+
+	promisor_remote_init(repo);
+
+	/* Try accepted remotes first (those the server told us to use) */
+	if (try_promisor_remotes(repo, remaining_oids, remaining_nr,
+				 to_free, true))
+		return true;
+
+	return try_promisor_remotes(repo, remaining_oids, remaining_nr,
+				    to_free, false);
 }
 
 void promisor_remote_get_direct(struct repository *repo,
@@ -302,28 +326,18 @@ void promisor_remote_get_direct(struct repository *repo,
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
2.55.0.530.gdb3615d990.dirty

