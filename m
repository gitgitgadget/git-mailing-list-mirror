Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CE2C0276
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891140; cv=none; b=e3ZOWCiBR8LizfwrSlOqXz7cwnUsvyWyjUyyGqk1kKn0SqQ2SjVx6Tsf86lURMmHB6uKIfbfoAaXrvKDiAUEn63Zdbu/UYZGDGNcn1f7pdu0/2Ywt6+EAxtkUsRWFdiQIkKtyC/TLF3D2GkD+ApG3OuFy8/05Ft/1rxX4qOKRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891140; c=relaxed/simple;
	bh=vtSKJp9eRj/xciJx6hv6DzlW90HsST9d1BUOD8yTpfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M73/yDEhn6XScwrnuGbruyKtN6rbUImhpjR1AldEtt/ykbWEmjpmjLAGz8wP954Fwr8ViT39qLcDM9dwX0LYorzAPhsMgdk5+3lImVZt181gdBYBp+s/Fj363n2uJiullBbZauI5DFnlA5S4xj0k4rOEnefLnJiwohLTBKXs+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FAueKsyN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vcih59ZJ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FAueKsyN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vcih59ZJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDF157A0162;
	Tue, 11 Nov 2025 14:58:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 14:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762891137; x=
	1762977537; bh=M/aKqxtZCTMnMC8Cy4QKnZ12N9neywA1Fqkufo3wja8=; b=F
	AueKsyNOoGXKKftrfHxpqidI32b7ikI1Llg6YXIeBieUt2rcEwk5Pr1Rloec4nLF
	y4qnNNS5A6VWn6aK6BoTgEY7RRVCF/2ctIbJ/7pnulWg66ae44P3LPDhYH4McLEw
	ISxi5kgIvTkR2rYHR5m7VqzvrBB7je4+Q7rREe0Xu4lX3VmQhz6FSHeZWxKZ4J6+
	sKgyDS5tKJ6oWYE7CDHrOFZVc2d4Z7IEhEBzmP7wym66EDQVIk77lLrRUWvswDCu
	NKQB9jHogkYmFKLwycwUfkBIJDiwiHuLsI/iLhLb8HnDk6EBb0r0LBicWVDaWx98
	Jr5biCd48dYPE9iE69GMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762891137; x=1762977537; bh=M/aKqxtZCTMnMC8Cy4QKnZ12N9ne
	ywA1Fqkufo3wja8=; b=Vcih59ZJWrVkUwDP0RSqwbsv9HPtkWGxQ6I1QV48RFmf
	eH75QBRrw+rRsAo4s4FnjWcVJdTHZ9m2+KxJvFRlI4tjKirnIE5YCWKfuXlQEqcP
	NYfxjcqMQtL0lRia7YNxGyOKoH7ZiPetwOXfcgtfQiFAVO3vNtFDV6uUaV+2V2p6
	639dMmGTCbVgdmyoFoIcN0wIKMmyLq973zPYLeglkq7i2C7tZ1OX284XLBwpgBeO
	kGC7P/S6OpxITN3AFw2nmygxfqXgSPOzh6WFEZSryB4HSeYIqxQ+2xoAKpTbJHQh
	p+w4THlRtesdeHwFWSyTYmgJvFvT9d8XZ8yyLTd/wA==
X-ME-Sender: <xms:gZUTaTue-6IV7rO7oYpx1gj8zfU7jdVlLnY4eRc7YtNneH7bxFjAgQ>
    <xme:gZUTaacAQ1arqdAuuQJrgodQF2dDf9dcNZg4jpHx5iTiJ8wMpniPgBQarOTfEGJew
    HZKB6UEX5Rr3Ep-2U_p0pDPRSticKd1fTJ4lwf52F_ukGHNBCHpkQ>
X-ME-Received: <xmr:gZUTaUZHWo26VKR9DS_aer1USZP3omtgHfltJaCNCe-lNTBVpUHup_vONZsqqhCDLa01BM2nOTef6dxrC4Vl9AfwR5aV31u1-cuq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:gZUTadWF29t0whTABohxR3uJMU1bvvj_tk-GuPVzjzSKR4zRYGbN-A>
    <xmx:gZUTaWjX19ZKwctgFOBQeOS3ZQ__c6W8IMVCswHrRMak9msoU5y6eA>
    <xmx:gZUTabUS5sZEq_LVSInTl4V_2bE01nA1tZoUg-wg55U59akrnjWA-A>
    <xmx:gZUTadNHNXXYwtR7INXk5Od15YyMFHJBsAPzPS8yc0PW9Cf43SfSmA>
    <xmx:gZUTafFlG3pYYSQN2nOnYHkrFOlGhv8EGhbhjReCp8XWPGGkoTifSbf5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 14:58:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 1/3] notes doc: call NOTES_MERGE_WORKTREE a "worktree", not "work tree"
Date: Tue, 11 Nov 2025 11:58:51 -0800
Message-ID: <20251111195853.2511146-2-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111195853.2511146-1-gitster@pobox.com>
References: <20251111195853.2511146-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As "git help glossary" says, there is "working tree" that is a
directory that holds a checkout, and there is "worktree" (one word)
that is a working tree plus repository metadata.  There is no "work
tree".

The NOTES_MERGE_WORKTREE thing used by the "git notes merge" is the
latter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-notes.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 46a232ca71..8f176f9e10 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -282,9 +282,9 @@ NOTES MERGE STRATEGIES
 ----------------------
 
 The default notes merge strategy is `manual`, which checks out
-conflicting notes in a special work tree for resolving notes conflicts
+conflicting notes in a special worktree for resolving notes conflicts
 (`.git/NOTES_MERGE_WORKTREE`), and instructs the user to resolve the
-conflicts in that work tree.
+conflicts in that worktree.
 When done, the user can either finalize the merge with
 `git notes merge --commit`, or abort the merge with
 `git notes merge --abort`.
-- 
2.52.0-rc1-455-g30608eb744

