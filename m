Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7EE27473
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918769; cv=none; b=CIYu4+hpNuezM11s1jYY6mn+eKCmgl78jN2Db6zXdIK1oACKuZPMWEUUU0fbe1HrfM4rib+uexV1G3etjruVrPxLwGW4XF7ReJ7fmSVs0Lyx+KluvIre8gsqBvi+BNCgAmvnrJS/fksgF8Nj88pD6jPk6vUnBSGsUC1htm9BznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918769; c=relaxed/simple;
	bh=/lQYkUI6n9af+ZJEaqRthbuczEeew9jta10L99SgZb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaBneloJU/IeXnG4yP4FYVPImQE1Ibm8dD7tbRMJcxWt1S/1YRzU4xItEMeQDU8Q4OLMBItLbzvUM9O6P/xmghAcud7fvx1J9ZrQIbeBp1yKAf1peGpi2VjDENcgWvcwDRfDA5sWB4I82DL1EfO/GUhiw8aapo0XhKIUc+h9zYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z2Qe10AV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UtjgVlYa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z2Qe10AV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UtjgVlYa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z2Qe10AV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UtjgVlYa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z2Qe10AV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UtjgVlYa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FB721F7FA;
	Thu, 25 Jul 2024 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721918766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OM8XuhLU5mT3NFxM/xnbl1WMLiaKb13+HXohFD/T8T0=;
	b=Z2Qe10AV0DjO3gXXwXVEGYXR77CuAqyTFLQlot0dzrTdkwpq586P3vqJKhihY+TVCGuRiL
	b/rlnjE8s4GSKp006LtY+UBKoyfe7z7dSpYJqnm7/BlWnWI6n5T3hyjZYmE9q88nnUdAh0
	ApPeU3ZKn89Legg41bT8FVbsvJHNUE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721918766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OM8XuhLU5mT3NFxM/xnbl1WMLiaKb13+HXohFD/T8T0=;
	b=UtjgVlYaGfr+HAxwnRfcJNt+zKS8PhbaEFedF0zXV6N7dpmv9LC89aaFO8d/c8K6re+T7o
	/SCY3F1PHWWbVgBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721918766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OM8XuhLU5mT3NFxM/xnbl1WMLiaKb13+HXohFD/T8T0=;
	b=Z2Qe10AV0DjO3gXXwXVEGYXR77CuAqyTFLQlot0dzrTdkwpq586P3vqJKhihY+TVCGuRiL
	b/rlnjE8s4GSKp006LtY+UBKoyfe7z7dSpYJqnm7/BlWnWI6n5T3hyjZYmE9q88nnUdAh0
	ApPeU3ZKn89Legg41bT8FVbsvJHNUE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721918766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OM8XuhLU5mT3NFxM/xnbl1WMLiaKb13+HXohFD/T8T0=;
	b=UtjgVlYaGfr+HAxwnRfcJNt+zKS8PhbaEFedF0zXV6N7dpmv9LC89aaFO8d/c8K6re+T7o
	/SCY3F1PHWWbVgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F4E21368A;
	Thu, 25 Jul 2024 14:46:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UDBLAi5lomYiHAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 25 Jul 2024 14:46:06 +0000
From: David Disseldorp <ddiss@suse.de>
To: git@vger.kernel.org
Cc: Teng Long <dyroneteng@gmail.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] t3301-notes: check editor isn't invoked for empty notes add
Date: Thu, 25 Jul 2024 16:41:06 +0200
Message-ID: <20240725144548.3434-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725144548.3434-1-ddiss@suse.de>
References: <20240725144548.3434-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.60 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.60

90bc19b3ae ("notes.c: introduce '--separator=<paragraph-break>' option")
changed note_data.given logic such that it's no longer set if a zero
length file or blob object is provided.

Add a test for this regression by checking whether GIT_EDITOR is
invoked.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 t/t3301-notes.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 536bd11ff4..c0dbacc161 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1557,4 +1557,9 @@ test_expect_success 'empty notes are displayed by git log' '
 	test_cmp expect actual
 '
 
+test_expect_success 'empty notes do not invoke the editor' '
+	test_commit 18th &&
+	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty
+'
+
 test_done
-- 
2.43.0

