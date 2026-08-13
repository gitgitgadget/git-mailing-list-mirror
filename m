Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75428372ECF
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636125; cv=none; b=UGyO5djDBoXtpLKDidqKMWWnFjXrVIioecr+iSVORU29+t/Z3ITXyeMlqw3fw9YJcPGEfSZMHI8kZ321JBz6W7bQwihtJEdu1TMwCH7W6q+5pIhFfOravvgfverWWLht9BckgT7V+fu1ivP41pOrIQGdGmWKmGsFpxMjyElXeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636125; c=relaxed/simple;
	bh=iP3TIvbpvKmfTStrq+cksEYlZbaHaXNpH0UcdaCIi9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8jttVr71YNr28AC5jQMUtQRKOMjFnja0eZN2dG19EdPX6Q2CGE1/LxOlEvXNH6BeNZwLajGXGS1oUfD/QnwNSQ7n71qafbsYWDxpF9Q7Ml41BzT+kHrT9xZUTsS8bbQQns/IaGRiJcKvtX2S9CZF8LJHZ4RD81e1cOJzJnn0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVClJLss; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVClJLss"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49978908b35so684325e9.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786636123; x=1787240923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gywZmVLWarkytvUudHPJjT5gGA/hlJmv9H8lDWwsEZ0=;
        b=GVClJLssGRLhNpRZS5nnvL8WMtajUY0N/3GFNYcWdORxxVgElwpMwuNRIfK+dUZ7sx
         ugpSnsr+63+VkrfQwkaf+PtrTnYmYZtz8UyqIVwj6qsvJSXChihroxCwCjRKsTBwFNNz
         kWTXJeSAmAhkFBs0E4vboyH4mJ8ZInBZckjcy//LCWDG4XMYwFe0h3Tbb6m2hskODPdw
         ewi15pXJjZXmv2mXjTv9dtHw1FWd/6Pb0JPZxcVwQMLignuItZofOpnroXrkRDbdtnCQ
         /dYkCSc7+LXzCmrrzIKlxE6yaMRmuqLCkBQ56QrurBjiDhqqnQSJNXMpVim2FPAuTYJA
         hVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636123; x=1787240923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gywZmVLWarkytvUudHPJjT5gGA/hlJmv9H8lDWwsEZ0=;
        b=S+T80nDY2wjnomJQATthsKNx6fho/p6CKX0iGhl8E24ItkfbFf2oHieQsyhr1d6aKG
         aW9dakno9VySmb2PLDc+eEuH+C4DAHWGZ4asPUwEHS8KzkOGymtRvDLu/7mabJpV3iFS
         01qXE+RnH300VM18+YD1i6kN/FCM0et6PccDF/x4/XP69JS1+BnCM+F+T2dR8P52ryK6
         RWfRZbpQ6DtlERtjvJRpakDkpJILWbmzb/m+m9nAvDRzYrO1yKs7E/Zm0tU+WqsC2M7X
         AB2SPzrfJIFLngss982Ax6hh0J2CNJNUKMg1ZAIimDlsQgKnp2sAaRV/+B6x2piC5wEN
         gKjA==
X-Gm-Message-State: AOJu0Ywt+u4vS4hs+eDXW5fHCHgEADrHHnuxK+IhlZfx+pAdjl5tvulB
	Wf+mGJJ1ZbbyxPQcONNxHXUzbglcy+JI88xUnRIU+h9cLySrVBfOj7HUiQjKrA==
X-Gm-Gg: AR+sD11seoxA6pEV6D4aKT1spEwWcTZEMoKL25dWjYknmjTzpt6gzvw4O6Lwg7uwWJZ
	McQkzgabNWdzseQVQ2x3aUfRv9Y9QhMCmZvBOHSpbaUfQ/XnFo8DIAjK9qMDFOp3TBoW9S5DfGI
	HXsUEQrSK42MrJrpMNyQZRuDrklPKZ8BAceZRidSWyzib1nss+3xXmT+BZJaRRDS1Y0jUhTab9X
	mo+zhtavG9yILQ2viMoLDMks/hWiDHd7akq8ui8SA3YfSnYDyhwd6mdlG3xYobFu42UTXDJQTwM
	KJwXess44Tsl4O+cePhDIASoGMbF3a46FrJjGuhGlz0N6pIwV609LXFzy1GeSyJ8asx7injnvBz
	yQmzLxEbTKuEwTPLLzVJWhc36TeCmB7jr6in/piiCOmEs7wvmgSk4h4CXuX1AyLyxKPYSI/d0yb
	clirQRm/0u9W83DujZkORx9Cn9aEl5snrSk2lGJ+YYErsym7TzvKRu5e6DEVRwMi9/iGAULeZP1
	P17Z6kRo0wT018BEdDp42dAg+Vcfvt5frZXbWPX8/GBFQBqG+mXKwGyOqNtlpntzWMJ8IUL2Shv
	OEg=
X-Received: by 2002:a05:600c:8b2f:b0:496:c378:6420 with SMTP id 5b1f17b1804b1-499821a2051mr95940275e9.8.1786636122448;
        Thu, 13 Aug 2026 08:48:42 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c0:e90b:439b:8502:172e:8dcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499821217acsm60633555e9.2.2026.08.13.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:48:41 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/5] promisor-remote: factor out lazy_fetch_objects()
Date: Thu, 13 Aug 2026 17:47:44 +0200
Message-ID: <20260813154748.2378747-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.547.gbb97bea608.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260807135511.1818458-1-christian.couder@gmail.com>
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
2.55.0.565.gc116661202

