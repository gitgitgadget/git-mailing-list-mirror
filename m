Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E218EAB
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115925; cv=none; b=BToKZf87Ra5P6X0GiaBlzwnCqOp4bIN/xZlXmn8thFjA14EuxQo0iTgzp40+Kn5OIZwFqA3L0q5YoywJ1IWmUJO4kFSU11SNsSbbRJnWU2bcFGjenXPrs7sr5VHGLdEGK8/EByQMVTLOHV/TckBWxok5Du9/XnZzzZs14uqdm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115925; c=relaxed/simple;
	bh=qb/PUv/BAFhfufm4GkL9w6fYMrEvQfEMQthubbufZoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9VKSdigfVnFjFI2r+p3+N8jgp1I3K6qKNOwS+tdmut0HxFpZsi/p9tq3QO1xPvZkBb0kGfnIS+JWxAaJHAzJelX/2SHC2iI6dwuvBOzpWGaWBwAm5zS9fvQGCE2NBcsWkwQgnuDRkyaY2PjpMlblneEpbPOVC0zU9hpHZ6xfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mFhxpD8G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gbdI0WTU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mFhxpD8G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gbdI0WTU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mFhxpD8G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gbdI0WTU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mFhxpD8G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gbdI0WTU"
Received: from tenko.suse.cz (unknown [10.100.205.182])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2404821B27;
	Fri, 10 Oct 2025 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760115916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYrqxuyHayZRc5b3YhrryrYAuevhj/2d9t0mvqkRPm8=;
	b=mFhxpD8GBidz6RjuiY83/5eiHp5eAHSzD+548PQkKvBwQJ4wSR3E6lYQoeG2ngE9KML4j1
	eWtikI6+8qdIA/L0R2xfaL+AcKVvwqA/SBZrOejthEx/fWQCoUpcqe4J0uGfucKVLiHjdR
	Hl7BvZ+w5cTqhN7wXD2qFSz7xDv8wNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760115916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYrqxuyHayZRc5b3YhrryrYAuevhj/2d9t0mvqkRPm8=;
	b=gbdI0WTUYjKWO9ShG9MlAaZeg4h8c1VwmnYH44hnhLXB74htJU+C/oLro+kkrRQ+Y/Ba6p
	C7iY0/kWDgsSNfBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760115916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYrqxuyHayZRc5b3YhrryrYAuevhj/2d9t0mvqkRPm8=;
	b=mFhxpD8GBidz6RjuiY83/5eiHp5eAHSzD+548PQkKvBwQJ4wSR3E6lYQoeG2ngE9KML4j1
	eWtikI6+8qdIA/L0R2xfaL+AcKVvwqA/SBZrOejthEx/fWQCoUpcqe4J0uGfucKVLiHjdR
	Hl7BvZ+w5cTqhN7wXD2qFSz7xDv8wNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760115916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYrqxuyHayZRc5b3YhrryrYAuevhj/2d9t0mvqkRPm8=;
	b=gbdI0WTUYjKWO9ShG9MlAaZeg4h8c1VwmnYH44hnhLXB74htJU+C/oLro+kkrRQ+Y/Ba6p
	C7iY0/kWDgsSNfBA==
From: Michal Suchanek <msuchanek@suse.de>
To: git@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <avila.jn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: [PATCH v2 2/2] doc: git-worktree: Add side by side branch checkout example
Date: Fri, 10 Oct 2025 19:04:58 +0200
Message-ID: <0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,pobox.com,sunshineco.com,proton.me,jcubic.pl];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Do not make the checked out repository hidden
---
 Documentation/git-worktree.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index a580f4c072..e7bf0ea8e0 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -526,6 +526,16 @@ $ popd
 $ git worktree remove ../temp
 ------------
 
+Side by side branch checkouts for a repository using multiple worktrees
+
+------------
+mkdir some-repository
+cd some-repository
+git clone --bare gitforge@someforge.example.com:some-org/some-repository some-repository.git
+git --git-dir=some-repository.git worktree add some-branch
+git --git-dir=some-repository.git worktree add another-branch
+------------
+
 BUGS
 ----
 Multiple checkout in general is still experimental, and the support
-- 
2.51.0

