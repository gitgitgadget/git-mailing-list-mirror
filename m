Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27219D880
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420314; cv=none; b=ShaNn3cDE+ALw3vemYU02zlsKfYkOtxbyDlBq7Chksfs25i1x2piRO4v188nabU47AFmFeqR3e8CEJiRI0vnZBRzB1N+GV3J14FpOIvjJMujKIGCONU2iMZU536+/t4tmMb+TH+oOmoJ0tHn8aXRO0gk4Nnn5Iy2EqqXKcylPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420314; c=relaxed/simple;
	bh=7Tb2biR5XiOvFSoZ6Sc2/aExNa29lEmsbk2bLgFYepo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXwx+lXycvon+Jmvf597Z2M/n5wnbR/4a+fdg+mGsMqas1T9JaGTlJHVGvLfYLN5sgGgH4m4RYSDtf1F7Jbur0azlvzxBoiN1vCiQUA35P0Nmr4xrM+reUsBlWTsZp2tTePVAxjbLK7IaCVKACoFn0lZH4+/9qA7PisK5FWylQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QOSygC4v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L9jhb+Bk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZKCMdQuK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WK16cCYE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QOSygC4v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L9jhb+Bk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZKCMdQuK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WK16cCYE"
Received: from tenko.suse.cz (unknown [10.100.205.182])
	by smtp-out2.suse.de (Postfix) with ESMTP id C52511F745;
	Thu,  2 Oct 2025 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759420311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUSI1ruT4AXxunFsNxS9zP4cEF6ddIKuQcGjN+/TyVA=;
	b=QOSygC4vI0enBJPWzHOpvWaJcIS8+NPSRsCB2fu7K32iIiIzhnwVIC42dJz9fJN4w7Lx88
	vHlcczIcv89IlbeRK+TyhF3KHQfUE01iM3Bd/vLhMf8QJquXlUOmvU5c0lvB/qWst8n7+r
	lH6KCdNnQhsD4yw9ucY0tQZbni/NyuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759420311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUSI1ruT4AXxunFsNxS9zP4cEF6ddIKuQcGjN+/TyVA=;
	b=L9jhb+BkvmlzVpV8wW0VuQtYmITie+vW9RnTiqmJ6fv/riGszVovAvrTQVhLM/bPqXPLPW
	6w/l+5nvrsG4XhBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759420310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUSI1ruT4AXxunFsNxS9zP4cEF6ddIKuQcGjN+/TyVA=;
	b=ZKCMdQuKCR38UGNpqkrUTQrcA/13Lkap4Wx5wkFja7L7p1BJOrm0H3TqDvgmNKXcgZstv2
	vg85d2SoBVPHI0E2O9zBZP30TCuIfFCQdgSYreMcufppLE0iGrCXR4vWtIXAWgsQPr8T5T
	Jjb45Nsbx7eghRMcd1saAktxhXsyoGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759420310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUSI1ruT4AXxunFsNxS9zP4cEF6ddIKuQcGjN+/TyVA=;
	b=WK16cCYEck3F3xpBaMDmeTs5LY1S1khyVf9Eq0xhzjmGOs7Joo238rmzaIf/vixkCQ1qC4
	syFBk6UOsWyGyNBA==
From: Michal Suchanek <msuchanek@suse.de>
To: git@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: [PATCH 1/2] doc: git-worktree: Link to examples
Date: Thu,  2 Oct 2025 17:51:34 +0200
Message-ID: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <xmqqseg1xwc1.fsf@gitster.g>
References: <xmqqseg1xwc1.fsf@gitster.g>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.de,pobox.com,sunshineco.com,gmail.com,proton.me,jcubic.pl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

Also add advice to put new worktrees outside of existing ones.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Documentation/git-worktree.adoc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 389e669ac0..ec31863aec 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -79,6 +79,9 @@ with a matching name, treat as equivalent to:
 $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
+For best results it is advised to specify <path> outside of the repository and
+existing worktrees - see <<EXAMPLES>>
++
 If the branch exists in multiple remotes and one of them is named by
 the `checkout.defaultRemote` configuration variable, we'll use that
 one for the purposes of disambiguation, even if the `<branch>` isn't
@@ -502,8 +505,8 @@ locked "reason\nwhy is locked"
 ...
 ------------
 
-EXAMPLES
---------
+[[EXAMPLES]]EXAMPLES
+--------------------
 You are in the middle of a refactoring session and your boss comes in and
 demands that you fix something immediately. You might typically use
 linkgit:git-stash[1] to store your changes away temporarily, however, your
-- 
2.51.0

