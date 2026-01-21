Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20583A89A5
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032509; cv=pass; b=VSxZvZoGy1kix1L6TygJ1yfpZ+tbL211RKPSHaDhDRZzyW6M1gw3bgjh49owdeHvQxm9YOq0p2zgU+J+3CBbZmX1WyaiLxuR8KDA5hKE4ktLRHzPxmYBOUEeW5v6iQslkuDKTHZ7CwhX+hiafqMt4LBrNOme/Xn8O8BCAgafNPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032509; c=relaxed/simple;
	bh=iK/ZQNaaFIdhuLtmj69DSKCqPzjoILUqLIzaJCFNeGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHLowspQvGRJ8o/nOd08XJXnHb/FMxBn+safJmnYVA2VBcmXccTP7VqELPUwGg6tlzrvdHu8gRgjXgpRTJauY1OvfEhZmVRbc4zoPxE6TAkG79zbJ2QEnwTWSKGhb1Oouywl/KqyR0wmXuLu0/1l6P2V0UKZRcQNFdK/WAg+bO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=iP1X7ydW; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="iP1X7ydW"
ARC-Seal: i=1; a=rsa-sha256; t=1769032493; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bLyjiUwOSTqypwhU55yhJWb4OMysu9Iz8cnVGCy2XUosIT/EAer/GtPnNczZ+hoeS6YAHh0mwSCf5hOPPQbBPOhSVNZj9L0VGf2pg0DaH0GLSDqsyy7/IUqZ6DtphdHuif5RJ9C6ssrOXpoIISWtlUwhRKDXHmHbsmyYlx1Ls9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769032493; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i8rNGSFFfADHMv3QgzqTLSLA7VpQ1FaLHAf8jK4pklM=; 
	b=JsiE1wHrANWTRASpTqOReV0sjGlA0iIKBPiHc2tjunQVzOkLpEZb2SOeYrnp06LW9b0+5+kZ5EHzTksQ0yfx+v9upAjnLhvsaNkJh6sWsAqeRi6JnpVqBwEyG2X5FVxp13UzlvHnW+kU1vf8RGF1u9ZTBEO7wT2QUqld+Q0wBmE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769032493;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=i8rNGSFFfADHMv3QgzqTLSLA7VpQ1FaLHAf8jK4pklM=;
	b=iP1X7ydWaRBYzwU622q1D9wKc7iT4cohReEoiK39iGerV7Cglu43M3gfQrEmAoIH
	7Hg1RwNPmjXEdiq6CGmy2gYXPo6ts9SdFqwBs+1xCRW5LNv/0Ui3L6NCCD0kLaopEH/
	VK5t29zLk+I1NfyVwvwVZRn5fL3YfqgXwp9Kk2x8=
Received: by mx.zohomail.com with SMTPS id 1769032491865848.3376151035734;
	Wed, 21 Jan 2026 13:54:51 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 01/12] t1800: add hook output stream tests
Date: Wed, 21 Jan 2026 23:54:25 +0200
Message-ID: <20260121215436.1473800-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260121215436.1473800-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Lack of test coverage in this area led to some regressions while
converting the remaining hooks to the newer hook.[ch] API.

Add some tests to verify hooks write to the expected output streams.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/t1800-hook.sh | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 4feaf0d7be..0e4f93fb31 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -184,4 +184,131 @@ test_expect_success 'stdin to hooks' '
 	test_cmp expect actual
 '
 
+check_stdout_separate_from_stderr () {
+	for hook in "$@"
+	do
+		test_grep ! "Hook $hook stdout" stderr.actual &&
+		test_grep ! "Hook $hook stderr" stdout.actual &&
+		test_grep "Hook $hook stderr" stderr.actual &&
+		test_grep "Hook $hook stdout" stdout.actual || return 1
+	done
+}
+
+check_stdout_merged_to_stderr () {
+	test_grep ! "Hook .* stdout" stdout.actual &&
+	test_grep ! "Hook .* stderr" stdout.actual &&
+	for hook in "$@"
+	do
+		test_grep "Hook $hook stdout" stderr.actual &&
+		test_grep "Hook $hook stderr" stderr.actual || return 1
+	done
+}
+
+test_expect_success 'client pre-push hook expects separate stdout and stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init --bare remote &&
+	git remote add origin remote &&
+	test_commit A &&
+
+	hook=pre-push &&
+	test_hook $hook <<-EOF &&
+	echo >&1 Hook $hook stdout
+	echo >&2 Hook $hook stderr
+	EOF
+
+	git push origin HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_separate_from_stderr pre-push
+'
+
+test_expect_success 'client hooks expect stdout redirected to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	for hook in pre-commit post-commit post-checkout pre-merge-commit \
+		prepare-commit-msg commit-msg post-merge post-rewrite reference-transaction \
+		applypatch-msg pre-applypatch post-applypatch pre-rebase post-index-change
+	do
+		test_hook $hook <<-EOF || return 1
+		echo >&1 Hook $hook stdout
+		echo >&2 Hook $hook stderr
+		EOF
+	done &&
+
+	git checkout -B main &&
+	git checkout -b branch-a &&
+	test_commit commit-on-branch-a &&
+
+	# Trigger pre-commit, prepare-commit-msg, commit-msg, post-commit, reference-transaction
+	git commit --allow-empty -m "Test" >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-commit prepare-commit-msg commit-msg post-commit reference-transaction &&
+
+	# Trigger post-checkout, reference-transaction
+	git checkout -b new-branch main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-checkout reference-transaction &&
+
+	# Trigger pre-merge-commit, post-merge, reference-transaction
+	test_commit new-branch-commit &&
+	git merge --no-ff branch-a >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-merge-commit post-merge reference-transaction &&
+
+	# Trigger post-rewrite, reference-transaction
+	git commit --amend --allow-empty --no-edit >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-rewrite reference-transaction &&
+
+	# Trigger applypatch-msg, pre-applypatch, post-applypatch
+	git checkout -b branch-b main &&
+	test_commit branch-b &&
+	git format-patch -1 --stdout >patch &&
+	git checkout -b branch-c main &&
+	git am patch >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr applypatch-msg pre-applypatch post-applypatch &&
+
+	# Trigger pre-rebase
+	git checkout -b branch-d main &&
+	test_commit branch-d &&
+	git checkout main &&
+	test_commit diverge-main &&
+	git checkout branch-d &&
+	git rebase main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-rebase &&
+
+	# Trigger post-index-change
+	oid=$(git hash-object -w --stdin </dev/null) &&
+	git update-index --add --cacheinfo 100644 $oid new-file >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-index-change
+'
+
+test_expect_success 'server hooks expect stdout redirected to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init --bare remote-server &&
+	git remote add origin-server remote-server &&
+
+	for hook in pre-receive update post-receive post-update
+	do
+		write_script remote-server/hooks/$hook <<-EOF || return 1
+		echo >&1 Hook $hook stdout
+		echo >&2 Hook $hook stderr
+		EOF
+	done &&
+
+	# Trigger pre-receive update post-receive post-update
+	git push origin-server HEAD:new-branch >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-receive update post-receive post-update
+'
+
+test_expect_success 'server push-to-checkout hook expects stdout redirected to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init server &&
+	git -C server checkout -b main &&
+	test_config -C server receive.denyCurrentBranch updateInstead &&
+	git remote add origin-server-2 server &&
+
+	write_script server/.git/hooks/push-to-checkout <<-EOF &&
+	echo >&1 Hook push-to-checkout stdout
+	echo >&2 Hook push-to-checkout stderr
+	EOF
+
+	# Trigger push-to-checkout
+	git push origin-server-2 HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr push-to-checkout
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

