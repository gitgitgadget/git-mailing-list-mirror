Received: from 3.mo584.mail-out.ovh.net (3.mo584.mail-out.ovh.net [46.105.57.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C077314D2D
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.57.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445570; cv=none; b=TzAaNQfITvDVMWTAXvN/QXHtggyJksSaW4YyvvZFI7rOA4enkTIwB1XcCAPCDx+/HljS6cTip5Bmzx9mHVb1NchICMAHNvWeRX7Uh5ESbm+maTcGEYtu0G8NGwGK1Kigqaus4+qERiLFdbTOzyH2KeK4XNZI+fZtdwNZsmhfuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445570; c=relaxed/simple;
	bh=EYTuUJmDe+7gvMDUii8dEDr0CjqPcbDdOUg8s0r+C8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WddBGHRElEqAJ4uh0DKPYOwTxjQf7TIR5+mw4Hqy01lpUa3sQPEArH8jMTEgJ3bFR07oy4lSgWGza3UaYIzx2GVuxByu21Ax1Krhm8U1GQXSinhwMiMrQmS54RofH8rljuSXu6Ln5t43Gh+dCZfF2GCncOtC92KDI1fJNmBIKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=46.105.57.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director1.ghost.mail-out.ovh.net (unknown [10.110.54.111])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4fy16k2rQXz8JS0
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 16:48:46 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-7kq2m (unknown [10.110.188.214])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id CB01BC0FAA;
	Fri, 17 Apr 2026 16:48:45 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.102])
	by ghost-submission-7d8d68f679-7kq2m with ESMTPSA
	id qjjuJGtk4mn7tAwAN7lZ4w:T2
	(envelope-from <kernel@schlaraffenlan.de>); Fri, 17 Apr 2026 16:48:45 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R0040eead51d-093d-46f6-b924-24759fb7f7af,
                    B7C68D824A8F199700666F34D4E97AF0708B992A) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:185.104.138.163
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Fri, 17 Apr 2026 18:48:30 +0200
Subject: [PATCH v3 1/2] bisect: use selected alternate terms in status
 output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-bisect-terms-v3-1-d659fa547261@schlaraffenlan.de>
References: <20260417-bisect-terms-v3-0-d659fa547261@schlaraffenlan.de>
In-Reply-To: <20260417-bisect-terms-v3-0-d659fa547261@schlaraffenlan.de>
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 7236721655264871391
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFweXHBPRtDYx/VT0BrMxm+tm7ZQPpIojW3v7HNJZLQGBRdwrXP41KUZsOUXQD4+APtvvOKL/N8LnBGLAwFEPNvfuhwjukkAaiIUND9JWnCvQ+W1uUG4KsacJROlTTr2vcLzlLWcwN6aDlDLzA2vT+X5p78bD1x6ucMNjli2yqWpx5p/9PXs2qdah92INfJIRInw/yJxjWEeGOU71/vUj0qapSLyJHH5a6qOJ/F4URtgSK+6gOz4KkF14rMlqKOeOpwRYMUQ/+EA8vWarRM1fgdv5FmC9dWMa8EB8xARjTLqrgFZB9te01ihNL5elukIjmXLkokaVjPt5+fRNtXuY5vVoQuK7+vEmzWoPLzM20l3WFMdjMpv0LG2hPuA7kO166XplW2FwV2J6Wr69ja2w2hq39DTnVVsGQh/gkKnhriRM79t7Q5NPJ1w3cgbtHqCMKgFsvJDjdSNt0CPXrGVWDAgo8I7IAuAuzrHdZU5y9oMEZJzkrRkBFrT4fBlj8rnRW1ooUD4DK1zOYmw8aS+6Jd7JYIajGVFlC3wCzzeYvRiuy/rQAoXIim4/RSbgBiNgjoMaUE19oHDTTf1AA1hdc7843OU19DsDNEgGLvgt/TpVrjdaXH+htpTiTrv5elc2ytaeainJsbTi0Y6EzupE0u1SLcZBuS0y4PZNAEiau3yA

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
  [sha] is the first bad commit

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
 t/t6030-bisect-porcelain.sh | 38 +++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4520e585d0..2b44911c0b 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -465,13 +465,16 @@ static void bisect_print_status(const struct bisect_terms *terms)
 		return;
 
 	if (!state.nr_good && !state.nr_bad)
-		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
+		bisect_log_printf(_("status: waiting for both '%s' and '%s' commits\n"),
+				  terms->term_good, terms->term_bad);
 	else if (state.nr_good)
-		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
-				     "status: waiting for bad commit, %d good commits known\n",
-				     state.nr_good), state.nr_good);
+		bisect_log_printf(Q_("status: waiting for '%s' commit, %d '%s' commit known\n",
+				     "status: waiting for '%s' commit, %d '%s' commits known\n",
+				     state.nr_good),
+				  terms->term_bad, state.nr_good, terms->term_good);
 	else
-		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
+		bisect_log_printf(_("status: waiting for '%s' commit(s), '%s' commit known\n"),
+				  terms->term_good, terms->term_bad);
 }
 
 static int bisect_next_check(const struct bisect_terms *terms,
@@ -1262,14 +1265,14 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			int rc = verify_good(terms, command.buf);
 			is_first_run = 0;
 			if (rc < 0 || 128 <= rc) {
-				error(_("unable to verify %s on good"
-					" revision"), command.buf);
+				error(_("unable to verify %s on %s revision"),
+				      command.buf, terms->term_good);
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
index 1ba9ca219e..3751e5cc8b 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1077,12 +1077,14 @@ test_expect_success 'bisect terms shows good/bad after start' '
 
 test_expect_success 'bisect start with one term1 and term2' '
 	git bisect reset &&
-	git bisect start --term-old term2 --term-new term1 &&
-	git bisect term2 $HASH1 &&
+	git bisect start --term-old term2 --term-new term1 >bisect_result &&
+	test_grep "status: waiting for both '\''term2'\'' and '\''term1'\'' commits" bisect_result &&
+	git bisect term2 $HASH1 >bisect_result &&
+	test_grep "status: waiting for '\''term1'\'' commit, 1 '\''term2'\'' commit known" bisect_result &&
 	git bisect term1 $HASH4 &&
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
-	grep "$HASH2 is the first term1 commit" bisect_result &&
+	test_grep "$HASH2 is the first term1 commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
@@ -1103,6 +1105,16 @@ test_expect_success 'bisect replay with term1 and term2' '
 	git bisect reset
 '
 
+test_expect_success 'bisect run term1 term2' '
+	git bisect reset &&
+	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
+	git bisect term1 &&
+	git bisect run false >bisect_result &&
+	test_grep "bisect found first term1 commit" bisect_result &&
+	git bisect log >log_to_replay.txt &&
+	git bisect reset
+'
+
 test_expect_success 'bisect start term1 term2' '
 	git bisect reset &&
 	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
@@ -1224,29 +1236,29 @@ test_expect_success 'bisect visualize with a filename with dash and space' '
 test_expect_success 'bisect state output with multiple good commits' '
 	git bisect reset &&
 	git bisect start >output &&
-	grep "waiting for both good and bad commits" output &&
+	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect log >output &&
-	grep "waiting for both good and bad commits" output &&
+	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect good "$HASH1" >output &&
-	grep "waiting for bad commit, 1 good commit known" output &&
+	grep "waiting for '\''bad'\'' commit, 1 '\''good'\'' commit known" output &&
 	git bisect log >output &&
-	grep "waiting for bad commit, 1 good commit known" output &&
+	grep "waiting for '\''bad'\'' commit, 1 '\''good'\'' commit known" output &&
 	git bisect good "$HASH2" >output &&
-	grep "waiting for bad commit, 2 good commits known" output &&
+	grep "waiting for '\''bad'\'' commit, 2 '\''good'\'' commits known" output &&
 	git bisect log >output &&
-	grep "waiting for bad commit, 2 good commits known" output
+	grep "waiting for '\''bad'\'' commit, 2 '\''good'\'' commits known" output
 '
 
 test_expect_success 'bisect state output with bad commit' '
 	git bisect reset &&
 	git bisect start >output &&
-	grep "waiting for both good and bad commits" output &&
+	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect log >output &&
-	grep "waiting for both good and bad commits" output &&
+	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect bad "$HASH4" >output &&
-	grep -F "waiting for good commit(s), bad commit known" output &&
+	grep -F "waiting for '\''good'\'' commit(s), '\''bad'\'' commit known" output &&
 	git bisect log >output &&
-	grep -F "waiting for good commit(s), bad commit known" output
+	grep -F "waiting for '\''good'\'' commit(s), '\''bad'\'' commit known" output
 '
 
 test_expect_success 'verify correct error message' '

-- 
2.53.0

