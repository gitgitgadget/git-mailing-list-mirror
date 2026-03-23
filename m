Received: from 20.mo583.mail-out.ovh.net (20.mo583.mail-out.ovh.net [91.121.55.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF24A32
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.55.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310850; cv=none; b=iDUJlqfDnELv6MYHe4Yx0XGi200HTt/S9RLGdpeJ8CDlMnu3jIH2MlQiO37n7CpOfnYyzVYndO+Xb58fegwri1sXR+ANt4Fd8bFheVGewmevBj3PqGf8Jtq62DZBe1mF6W5p9BI3z/IlOxt2EjgNZpmI8h/q3xcLg6BfHF8XUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310850; c=relaxed/simple;
	bh=S81f5qQu/THPR4aSLLEJrf6F9Aak6sD4SEu3brCdGXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cj6dF/aqU8Rq7l7o4CzbY/lb4IsTG7V0DkNHVHUoBk1JKMfoEQ4bsgbmXQkkFx48Iw0sIKCNDNRKKMeBd7tpofKSITkA4LD4wOUpxrajathVrwoASI29XolcPhh7wKWj0E3I4j3mGq8Xz4pSWONkPuyssNRMBxpnLQfcHHeIPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=91.121.55.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director8.ghost.mail-out.ovh.net (unknown [10.110.37.133])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4ffpJ40r84z5vXp
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 22:49:08 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-77wzd (unknown [10.108.54.44])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C3FCCC002A;
	Mon, 23 Mar 2026 22:49:07 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.102])
	by ghost-submission-7d8d68f679-77wzd with ESMTPSA
	id mhIMMGLDwWl78T0AiVxfvA:T2
	(envelope-from <kernel@schlaraffenlan.de>); Mon, 23 Mar 2026 22:49:07 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R004b5a6f568-e6e5-42d1-b678-13712bd7922d,
                    CF5F45155CC526890A7B96C462E82A48810857C8) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Mon, 23 Mar 2026 23:48:59 +0100
Subject: [PATCH v2 1/2] bisect: use selected alternate terms in status
 output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-bisect-terms-v2-1-8d6bdb2c9c7e@schlaraffenlan.de>
References: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
In-Reply-To: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 14079378337067991939
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGCOKmilFZY0xn7KtNqWcWaoSJYVp6S4ux6HgOeCxItNsp96kyGpK21LDFn+9JmIEgIh6fafeLnh/R4zGAxj5p7NraRD3k0iGMP474HvBtQX/T7wWnFUO4Y+ZzbEG3MeATluciy2Z/ouEeZ8uWGITkqKQPA0TpNDFc0pzlwoLaKvosLwKDxhA6JY2QeSZJP0x1z0Cdj3byhh/JVa02fTBsFoqG2jbSzavijyEMzKi8L3WGXbqgzWyv9gI3Dgeh1bEGGTvdgSjaRica1IWYhDuFLI4fNn01O1XE0dwmVy4/L2nVlHBwd0u2H4rHFXddCZm3yK72jtPkpP56cc6Q6k26TpxlIXoFju5bMIG63mYAzIAss26Sg8Mo9Un6wuexbDLl/gvnSDZe4WebRj3xzfKO8a6wqGec/A2l4AravWgNs8Npu1gv26J3kQ/NFy+CgIo6q8rBbPT6U64Mzmyyxh7skAAMqQgXIjCA4JNbJ8KtIJhvUZO2DS50MTqxPdmqhDE5U/QzLQOgw+DBP/LC0goSRFBzFm69wGX2Ms6r1B/XhrlgG5RLaOfu/FdFYSNHy8UGbS4hwRg1dp2Bn7l6pPICrPi5RZTFAh0WDr3gOcUtMeKRFUR04EHfRvqog6/MEMbzbpegDLX+YiEzyjAlev7//4Dy9ZLcoCKAE+td8LQq9+Q

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
2.53.0

