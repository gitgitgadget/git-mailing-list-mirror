Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2B1DD0D0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834667; cv=none; b=UddjHg/N1ROU8MVbfkblAWaiiXNZ09/pBUy4LZW/g8hB1IvOnR2RpNvWlgaQtOo67JZtPKxslry3BgeGfurcUuw0z7cmHpsdrM3kW9WU6oQqYnl+S6QnrmkR7duoIox95WGZ/s6NSqqIf6rSMIaYW8xnCstuLvgGePiFMEjGP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834667; c=relaxed/simple;
	bh=0ofXPlHMgcqG/P/N1e5jFnpc/607bYtQNFN4YjIiJI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YHf+GSuS1Jy7ldQDstob3s1J/OSSeMwDPjbPGK6xVfd51Xk6R0LOqdiAqLhwKE0aM/IOahGwyFn/WTtKXbLGTSIHuiBCEVGEsorrMNEl0atg0VyzkT6LyM5AD0jEdssXfyx/UXDXHYpaHzJKJZevESii9PRD1Hp/u5suhAsVamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qgjKpOQh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgjKpOQh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3705b2883so115375407b3.3
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 11:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730834665; x=1731439465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3BXgvJ9UIKwX0KvUx6c3yo7U1uC1Z8b2AkEsiymCBVE=;
        b=qgjKpOQhWlLxU9vT4Q+38G9TlxH2WJzfaaMt7DITWEZPioYABx1gKb5cXfy1ULHmYW
         im0BhqYdvgHUVV1N4RRH9fSL9F9DXsnOU+9Q6FcmmXKxoiozG2a8aCsud9vpSShjiYb7
         7HUsJvFdE0aEghVDpnk4v0YIVMLcL9F4GBdB4b0BRrcEXVydG9YwAjow7iohYHez8s7X
         TZqGhikT+z415jtVMCPBhBrwRoPsoR10j6XqASYu7zhKs6c6WgWbrdyB56nGWitnmdF+
         yaBGP9N/exz9f0/e0b1ISRyWt+it0yRQgrHsH6p4e+pIPu7/PI8rcYkLTs9bjbUhhm6w
         5GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730834665; x=1731439465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BXgvJ9UIKwX0KvUx6c3yo7U1uC1Z8b2AkEsiymCBVE=;
        b=ke052IfVXCeOGvNsJLGeAadflN1QbiIArgqyvzwV+tC783HDl+GP/rf4dQ5oxPoOIc
         cb4Py1vuQ6jaPWaUBhOAy6u+3emKB2E+8d4ZiVH0KCSvNQMxwSWyK/5cPe3sV8S6pZIk
         0aAuKphjaVAaJjNYYtuBd69J2dmZnJydI5UA3/J/e1oG047SJhuF0ucbpoptXufKOWJu
         I3RmAujmyqqxsEHpXfCaXlXKmPNF2bWrz0ZN/4GIGqLwMbnUXnCDvZOWbWofj9gkENoJ
         V0c4Y0/XkESHE4oXhJupPiehfr28ujCc5gWKfJQEQ2jDxKMJ5rpmzOl3isPtlGJMTW2h
         k21g==
X-Gm-Message-State: AOJu0YzD1O/ferC+dbtxxN5V7EDKDl7vSIrF1Jygb+Kwl2x4oPCbtRRG
	Tgm+OpjZB1P4Jlny7ADgkz6nhCfhGh8VWnR1l3ZVPf2PlxvlZ6njy7FGtFDXrPVkB+chPdrXvu1
	cO0cRHtBRms2WCG1NpSvQGYzCm2PcnWO8BmGi683CMtMrurDkPUha5yfniFsxFYsenOV89v+eex
	CK8u6VIpcspWOoYf4AUtdPSofB3vGZiuuxFbX1JBCBWsNoCiZalvo72MCGLWFJt0iv7w==
X-Google-Smtp-Source: AGHT+IHb4mbeDnP+WWNjfbEK3zcFmKdMmDmjpBw6/5sM6wL0NW88fBA3mFlHd8OL/8QvAWUVQoekk+iMy09FHeQLh22+
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:af5d:b903:295d:2c17])
 (user=jonathantanmy job=sendgmr) by 2002:a25:a291:0:b0:e28:e510:6ab1 with
 SMTP id 3f1490d57ef6-e33026b3c56mr11516276.8.1730834665211; Tue, 05 Nov 2024
 11:24:25 -0800 (PST)
Date: Tue,  5 Nov 2024 11:24:19 -0800
In-Reply-To: <cover.1730833754.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730235646.git.jonathantanmy@google.com> <cover.1730833754.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <c92b2c9e50975cab217a93b3e3a962107d60d0de.1730833754.git.jonathantanmy@google.com>
Subject: [PATCH v3 2/2] fetch-pack: die if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

When fetching, there is a step in which sought objects are first checked
against the local repository; only objects that are not in the local
repository are then fetched. This check first looks up the commit graph
file, and returns "present" if the object is in there.

However, the action of first looking up the commit graph file is not
done everywhere in Git, especially if the type of the object at the time
of lookup is not known. This means that in a repo corruption situation,
a user may encounter an "object missing" error, attempt to fetch it, and
still encounter the same error later when they reattempt their original
action, because the object is present in the commit graph file but not in
the object DB.

Therefore, make it a fatal error when this occurs. (Note that we cannot
proceed to include this object in the list of objects to be fetched
without changing at least the fetch negotiation code: what would happen
is that the client will send "want X" and "have X" and when I tested
at $DAYJOB with a work server that uses JGit, the server reasonably
returned an empty packfile. And changing the fetch negotiation code to
only use the object DB when deciding what to report as "have" would be
an unnecessary slowdown, I think.)

This was discovered when a lazy fetch of a missing commit completed with
nothing actually fetched, and the writing of the commit graph file after
every fetch then attempted to read said missing commit, triggering a
lazy fetch of said missing commit, resulting in an infinite loop with no
user-visible indication (until they check the list of processes running
on their computer). With this fix, there is no infinite loop. Note that
although the repo corruption we discovered was caused by a bug in GC in
a partial clone, the behavior that this patch teaches Git to warn about
applies to any repo with commit graph enabled and with a missing commit,
whether it is a partial clone or not.

t5330, introduced in 3a1ea94a49 (commit-graph.c: no lazy fetch in
lookup_commit_in_graph(), 2022-07-01), tests that an interaction between
fetch and the commit graph does not cause an infinite loop. This patch
changes the exit code in that situation, so that test had to be changed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c                               | 19 ++++++++++++++++---
 t/t5330-no-lazy-fetch-with-commit-graph.sh |  4 ++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6728a0d2f5..fe1fb3c1b7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -122,16 +122,29 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 		cb(negotiator, cache.items[i]);
 }
 
+static void die_in_commit_graph_only(const struct object_id *oid)
+{
+	die(_("You are attempting to fetch %s, which is in the commit graph file but not in the object database.\n"
+	      "This is probably due to repo corruption.\n"
+	      "If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object."),
+	      oid_to_hex(oid));
+}
+
 static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
-					       int mark_tags_complete)
+					       int mark_tags_complete_and_check_obj_db)
 {
 	enum object_type type;
 	struct object_info info = { .typep = &type };
 	struct commit *commit;
 
 	commit = lookup_commit_in_graph(the_repository, oid);
-	if (commit)
+	if (commit) {
+		if (mark_tags_complete_and_check_obj_db) {
+			if (!has_object(the_repository, oid, 0))
+				die_in_commit_graph_only(oid);
+		}
 		return commit;
+	}
 
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
@@ -143,7 +156,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 
 			if (!tag->tagged)
 				return NULL;
-			if (mark_tags_complete)
+			if (mark_tags_complete_and_check_obj_db)
 				tag->object.flags |= COMPLETE;
 			oid = &tag->tagged->oid;
 		} else {
diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
index 5eb28f0512..21f36eb8c3 100755
--- a/t/t5330-no-lazy-fetch-with-commit-graph.sh
+++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
@@ -38,9 +38,9 @@ test_expect_success 'fetch any commit from promisor with the usage of the commit
 	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
 	test_commit -C with-commit any-commit &&
 	anycommit=$(git -C with-commit rev-parse HEAD) &&
-	GIT_TRACE="$(pwd)/trace.txt" \
+	test_must_fail env GIT_TRACE="$(pwd)/trace.txt" \
 		git -C with-commit-graph fetch origin $anycommit 2>err &&
-	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
+	test_grep ! "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
 	grep "git fetch origin" trace.txt >actual &&
 	test_line_count = 1 actual
 '
-- 
2.47.0.277.g8800431eea-goog

