Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291E2356C7
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034699; cv=none; b=LLCXlQCLisj0UcqUUGjWDiRhynoTcNpe4McZwHfdF25n4QB55n7VspcWHggY9yTHUilYLkHqJ635n9VoQBPtMKUX1ieSpS0mc0ZwvZwTEpgJmLyPrsWxbltNBXKM9EWAawvXkL89v9lWPiYcKqIbyQLX153Vv7Xhvcdgeyjr8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034699; c=relaxed/simple;
	bh=qQrJ1dctvidyGrPnzCk3UvDwTYMUrHFD5U5y+haxabw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzAW0suzd0EdOroLfnS7ZiNkE1KD0Kadl+xgFm2U2UKn4UP732fjCo3bSNd0shlK6BXxUTbYknRLduemZdw+VVbOrGG1PUjz9Rvs1v8gfrpdzA2YJNH3aUrVz2BOO88E49inBRSrfx7hhxZVZejvEjxC0ehLDpnBb6bGglVzW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mKrlZaR2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fUBIploj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mKrlZaR2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fUBIploj"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 886091382C5A;
	Mon,  3 Mar 2025 15:44:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 03 Mar 2025 15:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034696; x=
	1741121096; bh=vntIEUuoN/UlTETMjyRMnb/B8AU19p8t8GV2eF53bJo=; b=m
	KrlZaR2q6XF9LYpjkZ76qIAU9rPeyD7Y1MgLlOn6pBRu2nMf6+FOy2nGOdg2WRBD
	6GIkYJUk4X7kywAk/dSyi+7nu2tuo4A+I4reSazychLjBdI5W8LMj77cFmQ+26kn
	ulke8qWRyje+Ri77oH+dmy2vHrjwr86SVNMvcNhW46X4SsnQXMa4LRikRpkhSXCS
	QI08W+OIVqtWwi+Wf9Du6rYevvB0xPnOgwt88BbVKVQo4cp0rO9uRhKQbZx2LcwL
	i5RSXtzDy7Ns3w/SPPPPoNHYS2gcx0Y2GENceBATRn1LXfzpospjTQsWUdcFatVy
	XzYrQivY1Zr2e1OkPDoLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034696; x=1741121096; bh=v
	ntIEUuoN/UlTETMjyRMnb/B8AU19p8t8GV2eF53bJo=; b=fUBIploj8pNLN3wQ+
	T5ThflJ0LocrwdxLGK2PtNBAWRM5Kg7jYxAvZ/XhKlTqK9Eqe3a9VChQ4ieImiYe
	Bvzicoi36w0y9tjnZQuAwO7f5qTWY3VSKHjoRQ1VAoJEAqqFIMBklVLb76dNP76i
	XlGiU0PV/sUj4WtOsQQ90+nKGtN42dpS+hOQacH2WDXAB0dTZ2LWdqyDHVNOMJvy
	zkJ8vaA6zWgwZ+GcN7ZmtuPfcIbdmiGfVYNfZm3tMJ+qLsRAikRnNa2LcAFHGj/e
	KPL8ctVQeXJRDtIlJEaa0eEeRGLPSe8leeiCGMM57e96VCV4/SGsNkIPCJscL8v/
	/fxZQ==
X-ME-Sender: <xms:yBTGZyAFLitp12aLW2T5rLhj7EUgmC073VL9t6lxO8LCIH0YfsjQbw>
    <xme:yBTGZ8gKqXzsMvTkrP5xuI7C7oEnTwqiGYFKIjdTg-ps9zZZyp_OJhwzspH6a_OpU
    1RXpMd4gK9z2kYfEQ>
X-ME-Received: <xmr:yBTGZ1mfaUv79-1Bp28v351FkvdY6XOy6BhO_JMlxFymuiDyta1rpZZ31VuJPQK3kR73lbg2UVO_RdESDnXWm4OnLEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:yBTGZww7ElqRSrx4UZBGJq6EXYZIkw2JZnD-JleY1PoX7isXZhieXg>
    <xmx:yBTGZ3SwI84aWNX1-uHRApmKjaymsBBoU3G9cz5xxw0_Ymq3Zl3dEQ>
    <xmx:yBTGZ7b1kJk60bxAJndKi1X4h_XaqZzS9-Sw8tfJk9LI2S0nuKvxwA>
    <xmx:yBTGZwS032nNFO393Q0dafYY4LC4nRtX3SBnBGbgBphXCOReZeIvqg>
    <xmx:yBTGZxccQkeLCp3Xfg4xFsGNJ0Edg_nmQeQ5gmhberln9Y8jEz0qLMvu>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:55 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 04/34] Makefile: update reference to technical/racy-git.adoc
Date: Mon,  3 Mar 2025 15:44:02 -0500
Message-ID: <20250303204443.360595-5-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a9b2de0692..a8012569da 100644
--- a/Makefile
+++ b/Makefile
@@ -194,7 +194,7 @@ include shared.mak
 # Linux, kernel 2.6.11 or newer is required for reliable sub-second file times
 # on file systems with exactly 1 ns or 1 s resolution. If you intend to use Git
 # on other file systems (e.g. CEPH, CIFS, NTFS, UDF), don't enable USE_NSEC. See
-# Documentation/technical/racy-git.txt for details.
+# Documentation/technical/racy-git.adoc for details.
 #
 # Define USE_ST_TIMESPEC if your "struct stat" uses "st_ctimespec" instead of
 # "st_ctim"
-- 
2.49.0.rc0

