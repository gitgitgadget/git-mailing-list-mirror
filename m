Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDD4204E
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543377; cv=none; b=LfqHxb6Wap27IGvYq5fvoFmhHZPq+ustgenhF/xtEZSRX0gh9GF51tiBAHbDFDwGc4EgF4Y8AKtEJfcNF5YJxkmRAlEPoNikkwagiRS9usDyFmW++CAaklP6wzS51P+IYXr+DeeS5mKvtQ+wa/Wumt/N63Se3f2ifnapBHR5lr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543377; c=relaxed/simple;
	bh=HJ6pj7+pqnhonWe0IpNrQByTc/3i2zUVMEjK4TTfVKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDuy8JxuusBRXcWtf8M99Bc26WaAH7TfCnBxMk0m1H+DmmeSwmUlcOAeca7xnsWA3bFZklVyyibHR+ZQoFXMCWDQBHBrH4EjXi2/A16XgWnv1tzqT75nuRlx1RtlFIbIUGQqs3yRMhQhxdvWstQ5Ye6ZViQJ5WYEai7Mua87N5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=f+zMfTVH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNLFd6Vp; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="f+zMfTVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNLFd6Vp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 7A4DF1380329;
	Sun,  4 Jan 2026 11:16:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 04 Jan 2026 11:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1767543373; x=1767546973; bh=PgKIK7ovZ70nnB09RnpBY
	V7JWLQrOFmvUyiAf81BEkg=; b=f+zMfTVHY6byFTWcSahRdvek+RA4ITchRBgRL
	uecubmzgKaTS7FiZ5EZ9qiNSDFPoAFjHrBKOv3vfBowY2lUZ1MD1Jd8qKhqWMyQa
	WCiIuLjUTG7exIfrcaYnG+3HTPMZfA3fMqI23+qHZVHMn1ZgG3q231O1VsshN/1r
	452/11xQwb3Qz5LrmsXA/3oyslyVD6pkBRZIAEw3glhGdSl2gCf9iMjooA/ctXd1
	pl23cE8QwAHKbdw6KccV8Dv2oaS9tXUnynC6Gv734yL5Ww0hcqHwvgPeqsyJFEtI
	1P0/76QpdGhq1njZz4toTcL+jQGLXZHUnXYrqDQqWhZlz/8Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767543373; x=1767546973; bh=PgKIK7ovZ70nnB09RnpBYV7JWLQrOFmvUyi
	Af81BEkg=; b=LNLFd6VpRhY1R6rQaeQVKbhsQVs6+xukBFluxrVwL0s+0KCh6dP
	8YxbE9xsxOEaHfTsX6HDSoxpiAUdXRe0vKZuiJ1Zr4oSrOgdUEuqFb3u1TlB1/Ly
	JkgUsxgEp2r2mfdD/k9cQXMtyEVpXv/6gnBKd8NVnsdJ4gmd/EDkI17LXfOxbQd4
	0/jQKLiD6e2a0SKUIRc5s0Xy7LBwB72ngo2jJLCB3Ql8MlM8k8ZzG1/hVNLnSrIw
	MHpa/a5ro9/fSzfx/tmfNiNj1lIxbUJwtQ+2ruYpqm2K2f5LZFAzy9x66LnlGFet
	hX9yVUgRzOsg3KiHECqi3HfCpp8pMcPm2kg==
X-ME-Sender: <xms:TZJaacwVLU9EPHsa-viCjK646gyUexOvF2kGEFkxwDOs1VrfHATbNQ>
    <xme:TZJaaWQvaxA_FkpT4UyNcUl8VMsfhQOJMU9TinWUFuAxBaDJwBg9ix1ZxbAGZXDxK
    GkffSdyD_zfG5TUg9WPF4Kquu0mMVr0X9ZfIWISWXXj9mhcyvll25Ux>
X-ME-Received: <xmr:TZJaab_7r-ZRUzroFHCZw6CSxzoS5laYbPWHOk7X79i1g5n8kq8KUijv31Gb1iXwEuW5wgPasY3wsp9bKIWozFTJ5pQkYgeZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelgeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomheptehnughrvgifucevhhhithgvshhtvghruceorghnuggthhhisehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepleffgeeviedvtdeutdejvedvfe
    efvefftddvlefggfehfedvieefgfegjeetheeknecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghnuggthhhisehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgutghhihesfhgrsh
    htmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TZJaaVoTCjNPkHnItc--GaDqzzUAVkNwLVirZ1LqTO6F1uJWV3jlMQ>
    <xmx:TZJaaQmXa5VeHwCfIn3BEnKNYiSfF2KmwmbWAu1vGvWT0dsy02XqKA>
    <xmx:TZJaaUJQZfBjfuPa_xfLvMhY6cMbSwp6MKKNC3762T86euJ9jjBMLg>
    <xmx:TZJaadwqq3WFoxxAXK37T7b4luxv8yDZzfWgzb6L0oZannqGDDZKlw>
    <xmx:TZJaadtILex3yp9b44oA1XPCtl_-v6ASXXR6vsTCWaq3_EsjIOGv2ubb>
Feedback-ID: i4e2e486a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 11:16:07 -0500 (EST)
From: Andrew Chitester <andchi@fastmail.com>
To: git@vger.kernel.org
Cc: Andrew Chitester <andchi@fastmail.com>
Subject: [GSoC PATCH] t1420-lost-found.sh: use test_path_is_file for error logging
Date: Sun,  4 Jan 2026 11:15:04 -0500
Message-ID: <20260104161536.45384-1-andchi@fastmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test will fail silently without giving any error message. Use
test_path_is_file in place of test -f to ensure this test errors with a
message.

Signed-off-by: Andrew Chitester <andchi@fastmail.com>
---
 t/t1420-lost-found.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index 2fb2f44f02..5fbb1d10ed 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -29,8 +29,8 @@ test_expect_success 'lost and found something' '
 	git reset --hard HEAD^ &&
 	git fsck --lost-found &&
 	test 2 = $(ls .git/lost-found/*/* | wc -l) &&
-	test -f .git/lost-found/commit/$(cat lost-commit) &&
-	test -f .git/lost-found/other/$(cat lost-other)
+	test_path_is_file .git/lost-found/commit/$(cat lost-commit) &&
+	test_path_is_file .git/lost-found/other/$(cat lost-other)
 '
 
 test_done
-- 
2.52.0

