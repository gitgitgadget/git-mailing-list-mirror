Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6F18EAB
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115919; cv=none; b=HE7bl4Cr9+ngYrZkbwZt4g/xQcJCnpvaiS6KvtPUhViNPg1arfPRIuMR9tQWQB4omG33WB7UUvKtGusvLTeqRIKGhRN2mkdiWEwbQvJ1r+encNMkTgt4Da70A4ZE4X0iFU1GOvVXFX0xzrZUWYfcxDaOoOcJxIlVNYkGNRLMPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115919; c=relaxed/simple;
	bh=mgc5ZWrj84srkpP4e/D4gr1qoKK+mIZEimb5h0QYU4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mlh9+MPBQJ6JLQm7RPvnIbQLlEanUR1d3wv5jpPpUcoVFfd78oinU/KS9M2iF1hU8PODyUj/dKXHnJBLSy+3FUyJfyMcPvwaWUBaHQcozKwIsnzR2tzLY04rRlImmcSM3eDoUGwkQ+O8+dq1mOlxTl//GwtpVzf6kQFQe9LMc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dmElRQ1q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fcq1fR/K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dmElRQ1q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fcq1fR/K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dmElRQ1q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fcq1fR/K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dmElRQ1q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fcq1fR/K"
Received: from tenko.suse.cz (unknown [10.100.205.182])
	by smtp-out1.suse.de (Postfix) with ESMTP id BF53B21AB2;
	Fri, 10 Oct 2025 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760115914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+4Ps5kn7cNDCRoCrNz7z+W3ccvTZU8n3z/q837/Z3o=;
	b=dmElRQ1qoVF9vX05GMOnwQ/3kBxP73YF9XMGDU1ybaPnqKAOLA43QD6wTITkgHaoLwA41s
	ltkPT9g8lkamI9howm1dbwrUAamn3WMhE9C3leXngkZNUkPhbEKIgwQ+gTL9dXxRLCB7Gx
	t53zY9qkJIcDKtSTJePQIOV2TYMGbnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760115914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+4Ps5kn7cNDCRoCrNz7z+W3ccvTZU8n3z/q837/Z3o=;
	b=Fcq1fR/KWnoZQgulFGBjgDJQlhd54tHjvBOFqX/Hzzp16AbGmPbbyl3OIvqf7e90MZ88O9
	UhIgTNpksuL/DzAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760115914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+4Ps5kn7cNDCRoCrNz7z+W3ccvTZU8n3z/q837/Z3o=;
	b=dmElRQ1qoVF9vX05GMOnwQ/3kBxP73YF9XMGDU1ybaPnqKAOLA43QD6wTITkgHaoLwA41s
	ltkPT9g8lkamI9howm1dbwrUAamn3WMhE9C3leXngkZNUkPhbEKIgwQ+gTL9dXxRLCB7Gx
	t53zY9qkJIcDKtSTJePQIOV2TYMGbnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760115914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+4Ps5kn7cNDCRoCrNz7z+W3ccvTZU8n3z/q837/Z3o=;
	b=Fcq1fR/KWnoZQgulFGBjgDJQlhd54tHjvBOFqX/Hzzp16AbGmPbbyl3OIvqf7e90MZ88O9
	UhIgTNpksuL/DzAA==
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
Subject: [PATCH v2 1/2] doc: git-worktree: Link to examples
Date: Fri, 10 Oct 2025 19:04:57 +0200
Message-ID: <6477f32e23e732fdcc5a9585cc945db8f13d736e.1760115862.git.msuchanek@suse.de>
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
X-Spam-Level: 
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

Also add advice to put new worktrees outside of existing ones.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Improve formatting
---
 Documentation/git-worktree.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 389e669ac0..a580f4c072 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -79,6 +79,9 @@ with a matching name, treat as equivalent to:
 $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
+For best results it is advised to specify _<path>_ outside of the repository
+and existing worktrees - see <<EXAMPLES,EXAMPLES>>
++
 If the branch exists in multiple remotes and one of them is named by
 the `checkout.defaultRemote` configuration variable, we'll use that
 one for the purposes of disambiguation, even if the `<branch>` isn't
@@ -502,6 +505,7 @@ locked "reason\nwhy is locked"
 ...
 ------------
 
+[[EXAMPLES]]
 EXAMPLES
 --------
 You are in the middle of a refactoring session and your boss comes in and
-- 
2.51.0

