Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886028468
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918766; cv=none; b=j8F+Y7idvqISf+hfkYGDv+dyxdJaEh79RIjfBEjpI+/Lq0PUhhhStEgSSoqzR02Q4CADtR5nBoX/Wy4VtChE6KbEajiG7XU8S/J7n3J3EVx4QgcY0RN1oHuVf3kMkcZ9jaaMsb0/uGwfTlolU+6RhEPfxC8EmJp2FH1Iwr/cEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918766; c=relaxed/simple;
	bh=f3ahK/m1S7Z1fSBp5e+ln4JRUN+FFDaHYe3KPBGakT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGLiNdwKyz98kCuGqUNG6ARyL1itPjP8Y9lAxGR7ZvaWGrkpKu8SxTpNJSCJxv1j9n8SamfPEGJrPG1u8J2SEsx4NXTIO4qiQiN/UXrpv5Lp8AvxAVo3lPPGInTAEyBAp49wW1R/ljCqQxPRQJb+H+Bk++uc1yyK+RNJSgO5CsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tQzBRRMD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LIPJaxYH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tQzBRRMD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LIPJaxYH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tQzBRRMD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LIPJaxYH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tQzBRRMD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LIPJaxYH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B22D6219E4;
	Thu, 25 Jul 2024 14:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721918762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dGA1bL5qv7iNipF6BzyFMYNJY4xw2h0De5uU8BjyBXg=;
	b=tQzBRRMD04FCHKaJXbLAfm+59swec6I98Ch8btpreQf29N8u7DhV//19vbL4vradkM1EyX
	YTVOs4BkUlrx7p7oWYO1YOo5Dq7XN60GjsGbQY0AZ1H5b1/D5MsloKUoPXARn7kgV1ue+l
	EzOwcVzxz9fntwYSpzK9Ju3NWISeLAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721918762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dGA1bL5qv7iNipF6BzyFMYNJY4xw2h0De5uU8BjyBXg=;
	b=LIPJaxYH7kFBFCQ+pjneqYWEd2WXXRfOV5Kxzib7rA+DwpcPMS120vd1Rv0Je6NKDxdMMg
	7V5n36tmfyQJifCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721918762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dGA1bL5qv7iNipF6BzyFMYNJY4xw2h0De5uU8BjyBXg=;
	b=tQzBRRMD04FCHKaJXbLAfm+59swec6I98Ch8btpreQf29N8u7DhV//19vbL4vradkM1EyX
	YTVOs4BkUlrx7p7oWYO1YOo5Dq7XN60GjsGbQY0AZ1H5b1/D5MsloKUoPXARn7kgV1ue+l
	EzOwcVzxz9fntwYSpzK9Ju3NWISeLAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721918762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dGA1bL5qv7iNipF6BzyFMYNJY4xw2h0De5uU8BjyBXg=;
	b=LIPJaxYH7kFBFCQ+pjneqYWEd2WXXRfOV5Kxzib7rA+DwpcPMS120vd1Rv0Je6NKDxdMMg
	7V5n36tmfyQJifCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95A9A1368A;
	Thu, 25 Jul 2024 14:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OUQLIyplomYiHAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 25 Jul 2024 14:46:02 +0000
From: David Disseldorp <ddiss@suse.de>
To: git@vger.kernel.org
Cc: Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 0/2] notes: fix editor invocation regression
Date: Thu, 25 Jul 2024 16:41:05 +0200
Message-ID: <20240725144548.3434-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.60

This patchset attempts to revert editor invocation behavior for empty
notes, which was inadvertantly changed via 90bc19b3ae ("notes.c:
introduce '--separator=<paragraph-break>' option").
The new test passes prior to 90bc19b3ae and after this fix.

Please cc me in any replies as I'm not subscribed.

Cheers, David

--

The following changes since commit
ad57f148c6b5f8735b62238dda8f571c582e0e54:

  Git 2.46-rc2 (2024-07-23 16:54:35 -0700)

are available in the Git repository at:

  https://github.com/ddiss/git.git notes_empty_editor_add

for you to fetch changes up to fa40003e560348e146f11aa85ac1fc5a3d86e31e:

  notes: revert note_data.given behavior with empty notes add
(2024-07-25 15:41:56 +0200)

----------------------------------------------------------------
David Disseldorp (2):
      t3301-notes: check editor isn't invoked for empty notes add
      notes: revert note_data.given behavior with empty notes add

 builtin/notes.c  | 5 +++--
 t/t3301-notes.sh | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

