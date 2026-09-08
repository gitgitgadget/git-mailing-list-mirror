Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07512582BA4
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885720; cv=none; b=mf11cEHcBZYp7/hyYH46ifWmh+Bi0d7KqAv3MF3vY3dZDHLaCk0Irx3y1JMsrml09a0nshwfvabRAgLAfqZAZCsoSPCmq+sLgcriexq3mjf5xNMKMXFiE78nOycycuooGFeMh5RcrKqCGMB6FHTcX80hLKv4k1PF96NKmugrxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885720; c=relaxed/simple;
	bh=Ba40K3SHWDX9ETtfMo92WyLKkc2pEw2iE8XNuXdtc78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcZG0FhjvYOuBh02ALpkAG2WP86ANuDxlhPalhGkvbdz4onkzhQc8/Rh4K6ZDBShTN9MzjjkY7ZW+bDRoclouuX+UyRhSSjyy8vnIec6dPWdt8+JVrfFq6VTpthxHwbXs3KFqdWbx0EE+ifRiIdZKrgY1WhA+aU0eogiJSEfN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjBIv7Ea; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjBIv7Ea"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso40951635e9.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885716; x=1789490516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amkEuEpFGzGvu0g5RLVAhRi44F2gWF3F8KOangmwVQY=;
        b=bjBIv7EaFQF126vwW+Rb9+M3aJrz3K8HoX8Oy2x1piUuRzuXI1EtAG1MSyH0dDhY+C
         RKEQpPbQxanAUi691sgHpl8d/NSMdItGnppeqRmni8wPAQH1jZZNgxZD5wY+3xYXPrt5
         mwC+mOQexTKEl6J/aIHyebDDV9V9KJjMJX4t3EQNaRsq9RrZIW/AJCKLqmKRSGic7K79
         n2BGYjEEhX7MT4sMewk/Rw2RDMcOMxDOHnbMu7JUR07jCtCrj5ffR3plIo+ShCMSpaV8
         2TBqUYZAju+t0GlIl1aW/dsqD4PEyyfTHo3YpP66YLACLwAFppaaMTWZdklbZbzIXERg
         GGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885716; x=1789490516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=amkEuEpFGzGvu0g5RLVAhRi44F2gWF3F8KOangmwVQY=;
        b=hV0Tt+j02CksfYGZHtfL2THIaXF0DnAvfEmFWlR8V9TYfgHCvZa+NXYMvunfGXkEFF
         p8w9D4iTJ/M8kQwQxv7Ev7ASwTcEAFzkCkmf9no1AgMDs26YKy73lNdyndvmlcIWC9yT
         DtJofSGsBRZgC5lVaeimXpowYZX6kgmqr0iFBMBnmKz0RKkPm2uhKYFV343Gxtz7rB98
         VSj38qWugw1+xYw+2Vd5e4Vk/rNQp5Sp6wFUDFrdqdeRg0g3SSRaWp58kV7uc8gQgomA
         BOr/37kihhPHxj3HwitzIH4eeH+T+/+YcN6bxSHqar5lLkUVc8Fnu9o5GQgLlYiLG/JW
         rn2g==
X-Gm-Message-State: AFuF++mdhgu4gGlQohK2IH1zVEJElS/cyTe2Z3YU2EDn/mx4NMf2B3PC
	iEZlZouWaOP6Kzy3FcNM+gykmZw6qjBm0EX385LpqxeW9qmwbc6V/+MFIOXSB2WO
X-Gm-Gg: AYBFou2tyCcBirxBzHCyIWnI0/Tt3b0o0Zs4AOd1yQltFP91Os5K2m20pa1sxrecx8M
	SRQrfotCCTlwMsnVMzZEU8hVzx5acuaz96m6cx3OmRM/uZha9sFGNlTDZv4jzmzxVc4QdNfAeCO
	f4N5yZurGa6u2v2Ka+Ub4+ZJqsF2F4W1Tem/7Cj25uMdZaJ4FCPcXqj9ke7Pk36bQyeu+s4H7B5
	bujEEFWvN1JfMN6A2yee/M2LgYDrW7BLv1Hq8tGhLvi8KyzGg5D1Ra6vWidfo/XhU1axtCMLHix
	k13y3q8/fJJgGXe0ZVJSxnAJftTfn1GQaLwfXN+r0+MamPDEI70fJn/5orpIV8O1gax6bIwHHrr
	/+ZkzYRzGOFQATSxUI/pSOOWMHJRM3ExobNcIntkF/SjGT/IVH2tdJ/Qi+iEO6XcVLEUfUAoKBC
	2LsSJ/4wJ1WwrNdPMOoR/ItBAnl263Xbktqt6y9zTWAa17JlAt2191wrVueNMCkQS37Avs9TIST
	cGqBg9Duxr0aDEETS9+i+oxBOQICdul/3qdSAY6Yx+B7rHzEKxeupLOTAo8zq2lufUA0ucBvuQI
	0gSlCIjzyjtNUOPg6C43V+TfZ7fE8EYYLCI02O4qTrMUNQft7bp29k1Ne8FV85fYPOmj5HXw6Tg
	=
X-Received: by 2002:a05:600c:c101:b0:49d:1f32:c911 with SMTP id 5b1f17b1804b1-49d1f32c932mr3747725e9.3.1788885715892;
        Tue, 08 Sep 2026 09:41:55 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm24081689f8f.0.2026.09.08.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:41:55 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 1/5] promisor-remote: factor out lazy_fetch_objects()
Date: Tue,  8 Sep 2026 18:41:25 +0200
Message-ID: <20260908164129.560396-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.792.ged91fccac1.dirty
In-Reply-To: <20260908164129.560396-1-christian.couder@gmail.com>
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 promisor-remote.c | 74 +++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 43505d1e1a..df17fec3bb 100644
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
 
@@ -290,9 +286,35 @@ static int try_promisor_remotes(struct repository *repo,
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
+	return try_promisor_remotes(repo, remaining_oids, remaining_nr,
+				    to_free, true) ||
+		try_promisor_remotes(repo, remaining_oids, remaining_nr,
+				     to_free, false);
 }
 
 void promisor_remote_get_direct(struct repository *repo,
@@ -302,28 +324,18 @@ void promisor_remote_get_direct(struct repository *repo,
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
2.55.0.792.ged91fccac1.dirty

