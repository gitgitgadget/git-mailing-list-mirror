Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753A346FA4
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664758; cv=pass; b=fB5k50K6v+M+N4sC4qnPI8XfvGJqsEmxgqauXVMMbOxIwHR4OTViskpaPcROB4vmvXELg5tNDiMagbvXb3xqfcBpq99kvn/P8AKqRD+E4kKGKLRq1FTLig+rPGFtE3mhtw5tFnxrsYiRO7QjD4TFdVxqhBvchHxpFWebXaF6PLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664758; c=relaxed/simple;
	bh=ANcht5Nur3VkqPIcmchS2yJwgZuKaKe902CB/WmIPt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fR67f4jhgcYV5FEcP2v145zSnHulM4BSc7uGAgKgp3Dl5DQgFLJ0hbI8qtMmWfNboTNHoXz+vYyHsBlFHYKtP6jC4KezbxrZ1xQoA9wmq5EG4oRPVIOBxNlQ0iLbHFxzksMbR+6W0uhkVDVWZJCW2KzE23tB6B9HA1p4ffbgQlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=UIOryzoJ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="UIOryzoJ"
ARC-Seal: i=1; a=rsa-sha256; t=1775664750; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WuyTN4lvr0JsMJkrRRYmHik7ZGVXtPw8+8ylm7I2yLFRz9uakKVY9aJ6I9eFJq69f2Cjd9A3vOjEAe4VPqhvzmoTaCLN/IebfF52ydQuPHbFPqwemejgeZQdfaDhbBjs+MpohAWLbN+gFsUnItZMuEA8NuM2kq6gzToEZrSgcdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775664750; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2sNbqB2bc+f2/aa/6zS1FOnrt41aZu6UVdbF9mQ2dwk=; 
	b=cr3AO43kCOS7pq/wyICyG/RVQAiqykltTimao+Z0Mtgw6Dm4uLgCD5EUx3I9I8YGg/GV0Yn/2OIYwPYHUK03k4QUS+1VraCgcVTwya8LkR59YfCwvgWW9j4pOO3D9lUHGmLDikSWgKYVU6N04brf0zR3H1+ZNb1ePjoYK0poQxI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775664750;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2sNbqB2bc+f2/aa/6zS1FOnrt41aZu6UVdbF9mQ2dwk=;
	b=UIOryzoJKH/PZPKr1XdNDedmIuI149EpUZwymnu9fDzw1a1LEcpFRkaYthzihpOr
	0FnUHfVSUXx+5f3OHVazFyZqaLr04xvYNVPLdU4Z+27PapnLv7RydhK0tJH/pGWkgfC
	DG4son5+jTwcX2HNlq0WcDcif0NdMY4/TIdgWoiQ=
Received: by mx.zohomail.com with SMTPS id 1775664748783483.9610036800681;
	Wed, 8 Apr 2026 09:12:28 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t1800: add &&-chains to test helper functions
Date: Wed,  8 Apr 2026 19:11:48 +0300
Message-ID: <20260408161148.2064854-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add the missing &&'s so we properly propagate failures
between commands in the hook helper functions.

Also add a missing mkdir -p arg (found by adding the &&).

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
This is a small fix reported by Szeder, based on the master branch
GitHub branch: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/tests-add-missing-and-chains
Clean CI run: https://github.com/10ne1/git/actions/runs/24137982261
---
 t/t1800-hook.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 96749fc06d..33decc66c0 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -6,16 +6,16 @@ test_description='git-hook command and config-managed multihooks'
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 setup_hooks () {
-	test_config hook.ghi.command "/path/ghi"
-	test_config hook.ghi.event pre-commit --add
-	test_config hook.ghi.event test-hook --add
-	test_config_global hook.def.command "/path/def"
+	test_config hook.ghi.command "/path/ghi" &&
+	test_config hook.ghi.event pre-commit --add &&
+	test_config hook.ghi.event test-hook --add &&
+	test_config_global hook.def.command "/path/def" &&
 	test_config_global hook.def.event pre-commit --add
 }
 
 setup_hookdir () {
-	mkdir .git/hooks
-	write_script .git/hooks/pre-commit <<-EOF
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/pre-commit <<-EOF &&
 	echo \"Legacy Hook\"
 	EOF
 	test_when_finished rm -rf .git/hooks
-- 
2.52.0

