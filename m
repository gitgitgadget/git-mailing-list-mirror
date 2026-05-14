Received: from 9.mo575.mail-out.ovh.net (9.mo575.mail-out.ovh.net [46.105.78.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC23955F8
	for <git@vger.kernel.org>; Thu, 14 May 2026 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.78.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750787; cv=none; b=J25A54PD5RZ98aN6vCrVEQEHWIsE3r+hTgVKP5V/fOkqh0KtoJy61RYBeHSMVMx87L8GtBgNFKg2jtLnWwJrQ4F65M2LXH75wfEndooGQHHnn+hC4d48NjtxYZ7GsV0w2Z1y5utMHxMeCjAAVNRiua0d3gqGIVvt6u2ONNgabbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750787; c=relaxed/simple;
	bh=hqSRzJqf7hPkO6cxcm2MVehjkLjhMHsKLT3kuzRUsbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7c8z9u1nsFt/FZZ/zF3aFeCvwe1hnr4X37jQvyyitMePV7WdXs0LVMcOGvLfzVhxQtektFEtcfRYxXUxg3Ri7eStrB6ix51cuXwrIwJjHK5O4y33i0p9HWsj+D322bgWCHzBJfLBIW/ahFLpHr0a5DEa3fA3Id+eALAtDM6il0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=46.105.78.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.249.107])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4gGPbd4gHBz626g
	for <git@vger.kernel.org>; Thu, 14 May 2026 09:07:09 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-d4cxr (unknown [10.110.113.233])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 55FA4C0D24;
	Thu, 14 May 2026 09:07:09 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.114])
	by ghost-submission-7d8d68f679-d4cxr with ESMTPSA
	id kOqGG7yQBWrumSQAmZP82g:T2
	(envelope-from <kernel@schlaraffenlan.de>); Thu, 14 May 2026 09:07:09 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008dac916dc-f9a4-4daa-b3e1-a55dd2a78de8,
                    C39F0B467605CB235B8620DBAA124B5209E80D88) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Thu, 14 May 2026 11:07:04 +0200
Subject: [PATCH v4 1/3] bisect: use selected alternate terms in status
 output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-bisect-terms-v4-1-b3e3cf1b06ce@schlaraffenlan.de>
References: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
In-Reply-To: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 10429492312238687009
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFcOjeNfd26R86/ODmyj5aIGkM2RT+7sDH6zAs5NouMmax32jf8r9BZHnSkO06pjzEa7iyv+AQLSlhEy4AwzQlQT9vxR59c+4GG9yA06dJwDIiKhG06ZkHRRd5NLfA+4vBIMoWcHZVvrEe2rq9Ij2fzHd0SPSwXawvkgNxKIPd7sDmzXcjYHnWCs+nZ5FIW3zRs3NxGQYXkjXWq+z/vIxMqkAnhnPMruSKJHkf5D4cTq7W/MnUotPU12Z0AXyLoE86UmUo6Vnd1JSz8sOc3jxKRE194yjg0FFmTw7+Zd1NbnCWtqxD+tKU/4OoxSqU4BC8UpySOgEbx4VGY5GZPInpkgzPzyj9MrABplP8Csuso10nKmNkzdF/uPiGsW6PyJFgVD6k+XgvSI3sDSISld1KzKEW9qjPSbkqf49hgStyRrl6CqHYazqOyv7QHyNjWdvh++SCdYyZ+4SbIgr0vJfRMP/FezhnmFVGOw7Sr1W6qU7HNqd+749zg2eOgH0mk1cVH26ruOr4bGBaJyKRE7pUMQ2wWm3kEOJ4zsP6lkSy1HLijnf8YssKAvf20cWfQmeIVbD1nxhVIf4vksTGbZHycJvh+wTP3XlDMXG/BlXfjRZ5Hru2smaY40FuvUN2jH+LRNHop6iSg6/oTrXH6oQvrf/uUgZNeAUWimOKmV9DpVw

Alternate bisect terms are helpful when the terms "good" and "bad" are
confusing such as when bisecting for the resolution of an issue (the
first good commit) rather than the introduction of a regression.

These terms must be used when marking a commit (e.g. `git bisect new`),
they will be used in reference names (e.g. refs/bisect/new) and they are
used in parts of git's log output such as "<sha> was both old and new"
in git bisect skip's output.

However, hardcoded "good"/"bad" terms are still used in a few status
messages and can cause confusion about the status of the bisect such as:

  $ git bisect old
  [sha] is the first new commit

or about the required action such as:

  status: waiting for bad commit, 1 good commit known
  $ git bisect bad
  error: Invalid command: you're currently in a new/old bisect
  fatal: unknown command: 'bad'

This commit updates all remaining output messages which use hardcoded
"good" and "bad" terms to use the selected terms consistently across the
bisect output and adds tests.

Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
 builtin/bisect.c            | 23 +++++++++++++----------
 t/t6030-bisect-porcelain.sh | 16 ++++++++++++++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4520e585d0..ee6a2c83b8 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -465,13 +465,16 @@ static void bisect_print_status(const struct bisect_terms *terms)
 		return;
 
 	if (!state.nr_good && !state.nr_bad)
-		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
+		bisect_log_printf(_("status: waiting for both %s and %s commits\n"),
+				  terms->term_good, terms->term_bad);
 	else if (state.nr_good)
-		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
-				     "status: waiting for bad commit, %d good commits known\n",
-				     state.nr_good), state.nr_good);
+		bisect_log_printf(Q_("status: waiting for %s commit, %d %s commit known\n",
+				     "status: waiting for %s commit, %d %s commits known\n",
+				     state.nr_good),
+				  terms->term_bad, state.nr_good, terms->term_good);
 	else
-		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
+		bisect_log_printf(_("status: waiting for %s commit(s), %s commit known\n"),
+				  terms->term_good, terms->term_bad);
 }
 
 static int bisect_next_check(const struct bisect_terms *terms,
@@ -1262,14 +1265,14 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			int rc = verify_good(terms, command.buf);
 			is_first_run = 0;
 			if (rc < 0 || 128 <= rc) {
-				error(_("unable to verify %s on good"
-					" revision"), command.buf);
+				error(_("unable to verify %s on %s"
+					" revision"), command.buf, terms->term_good);
 				res = BISECT_FAILED;
 				break;
 			}
 			if (rc == res) {
-				error(_("bogus exit code %d for good revision"),
-				      rc);
+				error(_("bogus exit code %d for %s revision"),
+				      rc, terms->term_good);
 				res = BISECT_FAILED;
 				break;
 			}
@@ -1314,7 +1317,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-			puts(_("bisect found first bad commit"));
+			printf(_("bisect found first %s commit\n"), terms->term_bad);
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect %s'"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 1ba9ca219e..9d28d1eedb 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1077,8 +1077,10 @@ test_expect_success 'bisect terms shows good/bad after start' '
 
 test_expect_success 'bisect start with one term1 and term2' '
 	git bisect reset &&
-	git bisect start --term-old term2 --term-new term1 &&
-	git bisect term2 $HASH1 &&
+	git bisect start --term-old term2 --term-new term1 >bisect_result &&
+	grep "status: waiting for both term2 and term1 commits" bisect_result &&
+	git bisect term2 $HASH1 >bisect_result &&
+	grep "status: waiting for term1 commit, 1 term2 commit known" bisect_result &&
 	git bisect term1 $HASH4 &&
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
@@ -1103,6 +1105,16 @@ test_expect_success 'bisect replay with term1 and term2' '
 	git bisect reset
 '
 
+test_expect_success 'bisect run term1 term2' '
+	git bisect reset &&
+	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
+	git bisect term1 &&
+	git bisect run false >bisect_result &&
+	grep "bisect found first term1 commit" bisect_result &&
+	git bisect log >log_to_replay.txt &&
+	git bisect reset
+'
+
 test_expect_success 'bisect start term1 term2' '
 	git bisect reset &&
 	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&

-- 
2.54.0

