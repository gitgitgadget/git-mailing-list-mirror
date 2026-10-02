Received: from mail-wr2-f31.google.com (mail-wr2-f31.google.com [74.125.225.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673C448D1A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929426; cv=none; b=raYydqmOWloArbNnh+17nGWz97nf+GBlpHj/NGQDJkzkpCrsVGvRsE/tIi0gv81ZSrAe584yODm48VuXXiAyScFhtuRuWXYSldbe0eJH1yrg+JJTPRHv5fHaOyYo8YCY8qWSFNdEBkvBRFKfwNnR5hqPhbO8P0AHUkkHRCML3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929426; c=relaxed/simple;
	bh=3wJ//DB3ylKX1Wo6wntASHty2xnEaipWOCNEaQRKBtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdQyfG/Cc6jJmeBeIURerQv1VjCwmqkW5e+pLr/0TCUc0vVAcvhAZHoACmK3P11gS2WUSPJsNOKf8mhXx8KrROlK+3yMuN5WQdRdz6McN8cc+uKO/IxCVRtoVoqCPtukWNc5Edfbrot6pcLczPQ6FqtIrHl0H4M1I3ZraBUpfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMyh0OQB; arc=none smtp.client-ip=74.125.225.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMyh0OQB"
Received: by mail-wr2-f31.google.com with SMTP id ffacd0b85a97d-488811c9ebaso3911611f8f.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790929423; x=1791534223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kD3m5wKVbw+iZDfD33vAaRxefKBs4o6vtdGZ4kcobKM=;
        b=oMyh0OQB3lPez1iWajCPp+UWOSG64GiJhoySrsEfEQ+DJcuu/jbvxHI/TS2jlwHZMf
         FdI86kjb1F8moJsOJsoKPgtHBkKmSVO9OdSiwr8ftr+RHKE/xCpme9JRNN8KSfxX+z0d
         v9qz3FUg51eJgiLyBySxGdSgjPLTmMe/hEm/DA4dFokTVhM5Z3Nm7qXO7XWqM6ZcT4Ed
         qT7U0kFiWXipSZly69pNGWqZjDCLj+EYGGZZ08nGNnMbjoJMowItJ4LXQOnKSOlp0r0z
         jpbq4iqEDx5EVt1XplkPaBKBB5sBQEwGzHJr/c00bCfGhQ+vOZqyCqJIKwgkEcnkX6dZ
         6hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929423; x=1791534223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kD3m5wKVbw+iZDfD33vAaRxefKBs4o6vtdGZ4kcobKM=;
        b=BfkO/QCYELkPKxqqCJOn9rjzfEYZ+uN1wQmSxTkIGoEcifqe6HsbZ6Z0y9m6tRsdWS
         gnoR0IrOwosNs+OfHngkGgorGfNOOKgFwDcNQKFveUBfmZRuh8B7A1SvL/TYVlrueAx+
         d+ThQ/Qvd1TBrFD9N8Stz55FoiU+VHlXKZJNG95gf8enEzxDvI0ZuC67H7mLHp3dyi+C
         Hjt/kFGtjZDaIozKgvM1+6tdl2AUPOA4qs6/gCI0oOHYYNEZm3I5TiPVs00kBdQXIw4K
         /e1b9Onwc/ZLxQKW6ujDExFs6vWxfezAzU6ipyP64aOgG7k63Qf7yc1yOMMFkzje/FVG
         3SJA==
X-Gm-Message-State: AFq9FYJCV2fJZAybrN0XNk2MhuLOk4MtAxNo5FWk9CNhMLtvE80HPoxY
	HOlxAIw7Fg0PcIVs/X8SKiJVBqCurXgEi6v8PeI16yo9rH4LS9lBNNsAPcM6PQ==
X-Gm-Gg: AYBFou3dPAuJo9QfwWShlJhmHXL3oA2sNpYjW5w2XM4Twz7oGmNAIW2EFHW1Fug+/4l
	cpmMdDqMST8S0hBTITpLlybKBTVsreBGscNctDc2jn8FT6ADbV86IJDcGebQPVPMnB9CiY7qC8G
	HWBZvCRV49IXi1/PauAxHlTrl8iM7Pztymv4GDXRBEz59r+6cnXbBLKtIeq77ajaE7Z/6nXcRoX
	HQoPMqiAwkwdQpTZ4xR2uXcpXwKMVaeqfvWi8XFLSlt0wNZicuYAGH3u0ii3iVzSN871ud2MRlS
	QJ4k/CQolsugAyaOTFe3cqnW8FQoDM1BcMZVNwVBmUom1Rm+cWp5WfiedSKQlaDSIiiiUo3Am68
	oARF30rYI+FRoDvQPRfR07ZHLpdDyFAVCgiHEBWYF5YMSatbeya6fLKgiu1896XB9NKBqlHCW/k
	DMMedyh4op7SIqxLSvacZO9YlWq0wGp2d9+I3Rl/+F0awKuzy9TtvS24UxraO623kpyZOE1ZO1S
	rRBiKVEhL+tuo0tdvHNE6CMg8VaDtofeqSLRFbLrAwf+Gkdgk07sQtrueMCDFDDeJL1FSl1tMxc
	QhhasAVTTFxTfr2lCg8HWuhfF1GwIz1mwuIbDNaJR0rNYJnQ/QL4YJCLbsh6KawX9jYbWKpObHl
	Umw8iAPOm
X-Received: by 2002:a05:6000:4a1b:b0:487:6f6:29a6 with SMTP id ffacd0b85a97d-48b1273e788mr3341246f8f.35.1790929422712;
        Fri, 02 Oct 2026 01:23:42 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm3905817f8f.35.2026.10.02.01.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:23:42 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 1/5] promisor-remote: factor out lazy_fetch_objects()
Date: Fri,  2 Oct 2026 10:23:18 +0200
Message-ID: <20261002082322.2682869-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20261002082322.2682869-1-christian.couder@gmail.com>
References: <20260928133846.2094261-1-christian.couder@gmail.com>
 <20261002082322.2682869-1-christian.couder@gmail.com>
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

