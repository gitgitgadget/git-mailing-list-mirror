Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745091A285
	for <git@vger.kernel.org>; Sun, 11 May 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924054; cv=none; b=IK8IrLC8XAX3DbrTKDIPh5rA7pd8hCrcW/TOs9fpNAC7VmOCHQ6quk+B+O4Iz1LDsFR0AkhWzLRfwqJBgycOB5Jzh2J6zievrd+33jh5Ce0Q7CDiwc7XZaOM1SjjibZznOW9E5HuEl3J+mL1EJE+U2crIDgNJzmjcjS2J10pIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924054; c=relaxed/simple;
	bh=sCadEswu2JkyAMkcSPdqvz4apxw7PtGXGRxay8JSsSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyZ5EjRNMRCOmS0WDPPEWVVnPRmp0gICzwOHGRulHUFzFupxbp4o9mzwsVuEBD7dMe/lyOWHlKfbUZe2JI6MIBTUHTCk9JC0dT/CU2edArIurKqGk9H3yLoKT+Z1PvF0cQewlCkrSW4dueb+BO/GHDTqFJU/oMoo/60ErfkejGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=UbzdJaP+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="UbzdJaP+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1746924050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbqPRqwbka3XIv+Gm49bPFR3aRPQ0NQbT57YbdhGCjk=;
	b=UbzdJaP+0VrBC5RgHOasLhC2MKtCmtqml2q1FTbxCddJSdOkqOPJ8UvKPuQ/kjDiv7vDF6
	dhvUWMr2Icc69FE+oqwIpswtGiWplKeyQYYtvVsk0aD4V+N3A5MNWSSVQp7dcYa5JDwW3v
	OHYJaEgn/kDAo17SwIbVazaH/3SD/Ns=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"aclopte@gmail.com" <aclopte@gmail.com>,
	Ryan Hodges <rhodges@cisco.com>,
	"Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 5/5] apply docs: clarify wording for --intent-to-add
Date: Sat, 10 May 2025 20:36:48 -0400
Message-ID: <20250511003955.242889-6-ray@ameretat.dev>
In-Reply-To: <20250511003955.242889-1-ray@ameretat.dev>
References: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
 <20250511003955.242889-1-ray@ameretat.dev>
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
 Documentation/git-apply.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-apply.adoc b/Documentation/git-apply.adoc
index 952518b8af..a41069c0ab 100644
--- a/Documentation/git-apply.adoc
+++ b/Documentation/git-apply.adoc
@@ -75,13 +75,13 @@ OPTIONS
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
+	`--index` or `--cached` are used. Note that `--index` could
+	be implied by other options such as `--3way`.
 
 -3::
 --3way::
-- 
2.49.0.1106.gc0efa3ba58

