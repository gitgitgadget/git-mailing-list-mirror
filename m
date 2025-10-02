Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0819D880
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420320; cv=none; b=e1x8NMuET07OD1xh9xoYKIeY2gMUFBQzblpqJOJz7ciC8RJRir5uqkuPN9X7e0IIRQkFouek6nWhb/hMvXFcBP4XWWZEiEPCI/0YwLhxeqe5dVkSd6sH/ry06/ATy5emm11P22tre1bVnhhPwUOp2bDNNTcGMMLYeYOZdDAldhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420320; c=relaxed/simple;
	bh=6JDgD8gre55ZtaQw33wH3O7lkOTzAryZtZjQ+P1b6ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcTxEAXZjvKYQ6nDlrYFlMlwH6Fjqa4Fp+0HGrly7aN6UozD2xboxaRqjziuR438Q9STe4Jh2+PuEiPZQCfsOqQkO3ye4BgdFl27glRoqgJkbo9Iw/kru2AhldLl8bxvQ6WiykZeHoWcMNXJC9YrNLMkgRd4k9z4FiCnvuPIy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xMEmSzQb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pQ5Eg8cF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xMEmSzQb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pQ5Eg8cF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xMEmSzQb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pQ5Eg8cF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xMEmSzQb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pQ5Eg8cF"
Received: from tenko.suse.cz (unknown [10.100.205.182])
	by smtp-out2.suse.de (Postfix) with ESMTP id A23AD1F74C;
	Thu,  2 Oct 2025 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759420312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WfgvV9ohOJ/L5u4p/3MCeKOIGTUTUMaDFbQJEHJL2A=;
	b=xMEmSzQbwCN12HLRxf/Z2wv7zAiokpXwFFYkuzI4lKhVTzktwONWtNYepF9sSHa+T+UGe4
	Fdy4+vp0zwkzeAhFlgtWhYL+a1p1N3V2mUS7Jip6JoIyBse0+EO/XGG94Iw9/TG/iuaLyn
	f2tPsZwfb5Kj50jOegHUhDfae2Jtt9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759420312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WfgvV9ohOJ/L5u4p/3MCeKOIGTUTUMaDFbQJEHJL2A=;
	b=pQ5Eg8cFzU6p+R3xu+yYBRFly6jbicdaLx0Gr5bwHj465/utRWZ3U+O/X0+s9yiAMtwQIm
	GjMlkkmrCa4tzyBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759420312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WfgvV9ohOJ/L5u4p/3MCeKOIGTUTUMaDFbQJEHJL2A=;
	b=xMEmSzQbwCN12HLRxf/Z2wv7zAiokpXwFFYkuzI4lKhVTzktwONWtNYepF9sSHa+T+UGe4
	Fdy4+vp0zwkzeAhFlgtWhYL+a1p1N3V2mUS7Jip6JoIyBse0+EO/XGG94Iw9/TG/iuaLyn
	f2tPsZwfb5Kj50jOegHUhDfae2Jtt9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759420312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WfgvV9ohOJ/L5u4p/3MCeKOIGTUTUMaDFbQJEHJL2A=;
	b=pQ5Eg8cFzU6p+R3xu+yYBRFly6jbicdaLx0Gr5bwHj465/utRWZ3U+O/X0+s9yiAMtwQIm
	GjMlkkmrCa4tzyBg==
From: Michal Suchanek <msuchanek@suse.de>
To: git@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: [PATCH 2/2] doc: git-worktree: Add side by side branch checkout example
Date: Thu,  2 Oct 2025 17:51:35 +0200
Message-ID: <1d5b41562937d83be261d054989b04db6cb94a86.1759420102.git.msuchanek@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
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
X-Spam-Score: -1.30

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Documentation/git-worktree.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index ec31863aec..122b191ff9 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -525,6 +525,16 @@ $ popd
 $ git worktree remove ../temp
 ------------
 
+Side by side branch checkouts for a repository using multiple worktrees
+
+------------
+mkdir some-repository
+cd some-repository
+git clone --bare gitforge@someforge.example.com:some-org/some-repository .git
+git --git-dir=.git worktree add some-branch
+git --git-dir=.git worktree add another-branch
+------------
+
 BUGS
 ----
 Multiple checkout in general is still experimental, and the support
-- 
2.51.0

