Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31229AB10
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890558; cv=none; b=AFbXBkx7sHGi0TDpu3hDI+oNVojK2yhIK9j9GYE+lgcp1H/Hgd+9S/yQUI9/dGXPVuAQvaCvnpI2LQNcK4eOCdQsBESbA/KEIb1mP8tDNPneyhFzl7ZCp2LC5aA1/fRQG1n3fVRVkpce8boiLicaTZ48egBHH+y94s4eAifya6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890558; c=relaxed/simple;
	bh=+xCWn8kRIaklbwAXIYO/x8imASyNjyJRKttvqbyqlyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwUrTM5EISbYItnYzI6JWHnVuxmrmt3tMYi98NAzkq+7QSeJR5mFSjJ2GQekKEzV7LyBa7TXx4Ofs1Zl2JH2NWUpMK3tjqLlnQcJoxJN/nmZN5I6ujXyWBFH5fymwbE6Xyo8G1xMmg2qTaFoX3mdEFH5G2K5gt+DXWs7M03EfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=df465myu; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="df465myu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751890554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxsoa4gvHQGRaNrWKkpCbiRCOJHgbzyud9gr+yI3vuk=;
	b=df465myuKTT2fJ0IGIpKrGANfbFAh4bVI6yyNDZwz5toawYVpkAgMglFu+Q9EpuaQwRHa5
	+337vWmZWQGAk8TDDc2gaI/NR2pY+f6ydFPWE7x+T83aYnrynMz5YDbVYXMjNwGjFZeBMn
	8HNwEdELD267YW1CTvqyzlKnIHHhMUU=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v3 4/4] apply docs: clarify wording for --intent-to-add
Date: Mon,  7 Jul 2025 08:12:33 -0400
Message-ID: <20250707121534.2933349-5-ray@ameretat.dev>
In-Reply-To: <20250707121534.2933349-1-ray@ameretat.dev>
References: <20250702212814.1923253-1-ray@ameretat.dev>
 <20250707121534.2933349-1-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Avoid using a double negative, and keep in mind that --index and
--cached are distinct modes of operation.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 Documentation/git-apply.adoc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-apply.adoc b/Documentation/git-apply.adoc
index 952518b8af..6c71ee69da 100644
--- a/Documentation/git-apply.adoc
+++ b/Documentation/git-apply.adoc
@@ -75,13 +75,14 @@ OPTIONS
 	tree. If `--check` is in effect, merely check that it would
 	apply cleanly to the index entry.
 
+-N::
 --intent-to-add::
 	When applying the patch only to the working tree, mark new
 	files to be added to the index later (see `--intent-to-add`
-	option in linkgit:git-add[1]). This option is ignored unless
-	running in a Git repository and `--index` is not specified.
-	Note that `--index` could be implied by other options such
-	as `--cached` or `--3way`.
+	option in linkgit:git-add[1]). This option is ignored if
+	`--index` or `--cached` are used, and has no effect outside a Git
+	repository. Note that `--index` could be implied by other options
+	such as `--3way`.
 
 -3::
 --3way::
-- 
2.50.0.229.gc167f4d905

