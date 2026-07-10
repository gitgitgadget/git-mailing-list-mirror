Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36274396588
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673530; cv=none; b=VWXrx4Mcb80jMUciJ0L4ibB3bw+OOvWhKOVgbiqY3mIaP54l/SMPQyQpAfU8oy46qUPBbGdac1j9CWGQsx0u2BwCXkCzfofwtUn3uCBEMZW6UuB6zXTN+TiZ0KzK7NPkOqP/o4xOFbCpwpgXvoNBFxyx25B32UCaRXGf1CmNC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673530; c=relaxed/simple;
	bh=PBrKE1ZU6pQhE/FwlZBobstP1yX+iQKa6Ao23WCBewo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkEG3eoD6DnskpWsgokaeS653N+y4rDVsEnF9bhgb3YuJ8pL9Dmqw1xxHLLtxDSteJo5Kc5PTZDiu/hojo7RO4dhwwy/RugZPJU4oiH/YW/8qC6YjhV52F275MN/3RJ1ZDTaBXm0PWolD3AaF6zEY2RVRogUex/hrU3bWhRUxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjo/clqt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjo/clqt"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15f47e6297so88522366b.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673528; x=1784278328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwZhE/G00cvchAc8qCHpgBRsoysmNtbhMx/XXMT8Kik=;
        b=Vjo/clqt5OzP9Mex38u9HWhX7FsYWwm9DvTlw7hqwwyGy1qOyHENuA+9YmeiKT0smh
         KXuAbJt7ltG/rGCRbbeZHCJdhLkwEDzQ5lNTNqZH6B5SSVq+phTZ+UFR9tBROvoRViY2
         w/8GLJNj6sTwf+1WyGRFS4nXLDdDef/SRWKLZMmkhbTpi4gV9ZfehsqiJ80qa+nbAvLC
         A91nfzpLDPTCwNe8iDvF90lNkbK6Xe49y02r28ydBJwtMvgM0/xWDhhWZTDmPee5TGzU
         kRZYtmSwDjfWTZ51cRXH8ZIPX7iDRiuwK/be6LYIkVZoN+obo0KJ8+k+H+OCiRC1jPxU
         5M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673528; x=1784278328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HwZhE/G00cvchAc8qCHpgBRsoysmNtbhMx/XXMT8Kik=;
        b=D57ZR1kPZHStt0luzFmBNJWvgWzpSoQqbJLOiuqpEhf3iy+YvaoiZ8BeAAFB1m/p3M
         ESyOMQktzeYhr42OripyUAz35FKekKk34DlvJVbpt0Sm4cbWWBG+zC095+N5Okr8qEBw
         ixVHIHlxT+AIuvm10FV2ImWYhSUvJPwUKmCyhFLJM7hCzAkmtF55pSrXPzAJqOWkx98X
         aYEo2P1sSL0Q3MOkJDUwWqfF9AemfJ+uzJIn3C3SLq54jh/GD7M24dY2K5PSewssH38Z
         nDl7AX4D3Jkxs+KiKIQUk9GIEoJavF8MCGvKOMsrTuuHQPjPUwv8HqqvP8G4n15sBa1i
         M8Ig==
X-Gm-Message-State: AOJu0YwNQavMPrHlaqmDC/lovRxlrU1r9huxe26pT/TrODKHzxpw504h
	k9VKjEEMIObEqhwWQUTXPIHhUi1DPXXeu48juBtApQNkuvfAYnVT4NOs4TbedjrW
X-Gm-Gg: AfdE7cmNbXxpoeAgU7FyDuAY13IR+AQ6AcRP+atHgxz70smSL88ikch8s1miPa0vh1z
	OYrocbNSsLyCFooAuoKwl782Ic31rt8dF/FLqky8RRK8Iy2T7+GdlV9JfNHUG1O2qqMpvLynKAg
	xwhFDkdrfWNj5+sidvS00e8axC9Is/r1l1oP1n+eS3eYuN+jZXOfsexsFNH5mal+xXnzizqr5iX
	W+CQtVpphs9pdl4+m58Bqtw4SvCcvV3C3bwV9zLGp+Pn571JpULpmO60GvtO98FbkUi4FlIaU0f
	9EI+nvfzWMUPpJ2edLCyMzhHXslKW+ocu+LZ9Fqd5FdBJVTWwEzqxCpuysKMU5wlyJDT6i6Tg/2
	4ivQbSCpc272LdhFL0fcvGwU6hXoSzNj7PgDhfNkJS3Rgn8sDkaTuNTRdyVTBPH/FG7q/dy4lZH
	aNiV6KAjPODiKM5QqDePuDctMSx227byN8oQKOD9urp5jdpXWKJIYLstOTsAM2yzJUDNh9iOX2j
	1ALwsNd2CfBoF2R4npPfLfKrTvh
X-Received: by 2002:a17:907:1c0c:b0:c15:d84e:4bc4 with SMTP id a640c23a62f3a-c15d84e5e92mr413317266b.8.1783673527423;
        Fri, 10 Jul 2026 01:52:07 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15eb1dbdc9sm199561166b.10.2026.07.10.01.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:52:06 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] promisor-remote: factor out lazy_fetch_objects()
Date: Fri, 10 Jul 2026 10:51:35 +0200
Message-ID: <20260710085137.4171240-2-christian.couder@gmail.com>
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

In "promisor-remote.c:fetch_objects()", there is a check to disable
lazy fetching when the `GIT_NO_LAZY_FETCH` environment variable is
set. The fetch_objects() function is called once per promisor remote
though. So the check might be performed more times than necessary.

Also promisor_remote_get_direct() mixes up the logic deciding which
promisor remotes to try with the logic checking that the objects
that could not be fetched are promisor objects.

Let's refactor the lazy fetching logic out of these two functions
into a new lazy_fetch_objects() function. This will make it easier
to extend the lazy fetching logic in following commits.

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
2.55.0.125.g395cd2c8ec.dirty

