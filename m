Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A378C98
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290019; cv=none; b=G5Dvl/lN6mRMN2B1AeLqsJaunNcdDIdGGFqW4L+8oPl7FSiydUlP5EGMxzBLSzgagf1v/o6sWu6+OZR9qyYfncmtKCv/adOHRLUdcqJocWfl+NY1uHdC9OKLCYQL+X6q9dlLeuOid/7AjAcPB3sjqt4aEiEosTutDlxy4Ng8Flc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290019; c=relaxed/simple;
	bh=6y99Jwp20h9ar5NCAbrmmJLKBQBCxjd7KCzO1RLZaU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pijqPAD4bgyxe6Qh/z9liLPNcoHW0faHnlUiHsgYhUOnwWNIYHqqkkU8h+0C/xoMp1wNNckoAb8wcmG1NizEtTE+qGCiHaAQXqigZeI/7TyuwdQR8o8oO0WfcQnt1tKN24ZHeShgGuLhQtBxQInVMsgbpxHtTtEe3dZ/6Jb9sd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cJj/EXYj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nAqJgm3A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cJj/EXYj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nAqJgm3A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cJj/EXYj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nAqJgm3A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cJj/EXYj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nAqJgm3A"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7E5021A7B;
	Mon, 29 Jul 2024 21:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722290015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgxFX1LCZf2x4tkl2D8ODsO86/TdoDnh/FWpEDjy958=;
	b=cJj/EXYjfpcfYeDnux4B4QtxCR+x9WbEPZ/zemSA+BSZ3T+9oMEXIH1JWjrR4nubfD9Mi3
	xmmG61PMYulITzZngW0IVidNx+1ZIXIsZozPVbJgW7mGp1g/Oz8A/SVcWCCLUDZPq2G8Qa
	AMwuzRbfgKi5wZ7KxyJ99MHYgtBqVV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722290015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgxFX1LCZf2x4tkl2D8ODsO86/TdoDnh/FWpEDjy958=;
	b=nAqJgm3A7zL25SkxNKqwzRGRAzO1xnT8PrWdisZS9k+L4zTVIiffBJZji9OX0FXPYViTDb
	N4JJyrfm+z8LL+Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cJj/EXYj";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nAqJgm3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722290015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgxFX1LCZf2x4tkl2D8ODsO86/TdoDnh/FWpEDjy958=;
	b=cJj/EXYjfpcfYeDnux4B4QtxCR+x9WbEPZ/zemSA+BSZ3T+9oMEXIH1JWjrR4nubfD9Mi3
	xmmG61PMYulITzZngW0IVidNx+1ZIXIsZozPVbJgW7mGp1g/Oz8A/SVcWCCLUDZPq2G8Qa
	AMwuzRbfgKi5wZ7KxyJ99MHYgtBqVV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722290015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgxFX1LCZf2x4tkl2D8ODsO86/TdoDnh/FWpEDjy958=;
	b=nAqJgm3A7zL25SkxNKqwzRGRAzO1xnT8PrWdisZS9k+L4zTVIiffBJZji9OX0FXPYViTDb
	N4JJyrfm+z8LL+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 732261368A;
	Mon, 29 Jul 2024 21:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eeqXGl8PqGZBXwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 29 Jul 2024 21:53:35 +0000
Date: Mon, 29 Jul 2024 23:53:33 +0200
From: David Disseldorp <ddiss@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] notes: do not trigger editor when adding an
 empty note
Message-ID: <20240729235333.513eb1d9.ddiss@suse.de>
In-Reply-To: <xmqqed7bhobk.fsf@gitster.g>
References: <20240729151639.19192-1-ddiss@suse.de>
	<20240729151639.19192-2-ddiss@suse.de>
	<xmqqed7bhobk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A7E5021A7B
X-Spam-Score: -3.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]

On Mon, 29 Jul 2024 14:37:35 -0700, Junio C Hamano wrote:
...
> I am tempted to squash in
> 
>         diff --git i/t/t3301-notes.sh w/t/t3301-notes.sh
>         index c0dbacc161..99137fb235 100755
>         --- i/t/t3301-notes.sh
>         +++ w/t/t3301-notes.sh
>         @@ -1559,7 +1559,12 @@ test_expect_success 'empty notes are displayed by git log' '
> 
>          test_expect_success 'empty notes do not invoke the editor' '
>                 test_commit 18th &&
>         -	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty
>         +	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty &&
>         +	git notes remove HEAD &&
>         +	GIT_EDITOR="false" git notes add -m "" --allow-empty &&
>         +	git notes remove HEAD &&
>         +	GIT_EDITOR="false" git notes add -F /dev/null --allow-empty &&
>         +	git notes remove HEAD
>          '
> 
>          test_done
> 
> to make sure that all three options mentioned in the proposed commit
> log message are tested.  It is not too much more effort to do so.

This looks good and works for me - feel free to squash it in.

Thanks, David
