Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80414A82
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949013; cv=none; b=tGB8SyoN4cBu7sWGw4SglUaFeXImVS9n9Wbkv/brM95nWIls9DPXPBmg3k47PzoPtIjcZQVdDy/3VeG//7GqPizIg2xYbdwnbw1spXrGdz6dGwTc5mW+5v4oIIfNQYlNOWWA2Y6g6TZW0mL9WR1b+PV5MmySb7vzCdx1qGF2UQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949013; c=relaxed/simple;
	bh=HvF5PQ+OUy1NoI7LSA4AwK1/u61N0m45Oe5ZDftEHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=innUmLc6Lmla/hSq7SqdfbQ5tgRuI06HYHRecn8QUk4XRx6BUxOmnwTB9AAX+B94M/DeyMdbKMmUvVCK1RRsigB2Q/H15ShTgeTKepjDKnNP7g4Ofq1eJEeDHegO/6yDH/yUjy3iGlHH3cmOyyS5xeB51SGrvbI8I2nPbXJIE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DxlfQUIh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NLqvivN+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QsrusG6n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vuJvM1vg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DxlfQUIh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NLqvivN+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QsrusG6n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vuJvM1vg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DE4E1F83B;
	Thu, 25 Jul 2024 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721949007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RC6Gh9KUDOYDrRhBtgzx7e1h9JEaGxVMq+p5h2TczSQ=;
	b=DxlfQUIhm2LjeylY/dOoOolnOEVyAfFNdPm2kqVecdVLKRrkFahx0PpCo7b8obyjLWU56E
	iRS84TOO3uWSfGkvH8tStrR7P29cT/szMfK6rnzAIQY9Up16bzQ24QYjX3D9DacRvFko3i
	Cz3fk9wTlKv3R8RA2VFVo2pdQbUXUts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721949007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RC6Gh9KUDOYDrRhBtgzx7e1h9JEaGxVMq+p5h2TczSQ=;
	b=NLqvivN+xYmOCgz1IUJjaNdWtt2wZ7SGvUJNtq68vZSzq4+Ix2ZspwsYefh2y7y2g+3Ps6
	CemVC1Raspm6iaAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QsrusG6n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vuJvM1vg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721949006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RC6Gh9KUDOYDrRhBtgzx7e1h9JEaGxVMq+p5h2TczSQ=;
	b=QsrusG6nhnVT6qju5qwfJAvWah1mpZEIXtRbVJtaas3qrfyTVJ6FlmehVkzYF+wEWjrSrS
	Kc84pbnFQeey0s1+623JQhnCmb6R06toR/7/xWQf7fPWNS4XT1DIfUPKUSiaF0iRriCQhB
	XcrfQN5tH1wX7/4yOJ4iJi6H0Hhumww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721949006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RC6Gh9KUDOYDrRhBtgzx7e1h9JEaGxVMq+p5h2TczSQ=;
	b=vuJvM1vgumJSd9WUg2nqKXNmH/CCCu1fI6K6LUcUKdMUyMFgMwk8fSheypfiu92vmdoMLP
	cVnm/O8UrR+530BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B8A313874;
	Thu, 25 Jul 2024 23:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FDCmBE7bombKJwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 25 Jul 2024 23:10:06 +0000
Date: Fri, 26 Jul 2024 01:10:04 +0200
From: David Disseldorp <ddiss@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 1/2] t3301-notes: check editor isn't invoked for empty
 notes add
Message-ID: <20240726011004.6bde3938.ddiss@suse.de>
In-Reply-To: <xmqqle1pigbk.fsf@gitster.g>
References: <20240725144548.3434-1-ddiss@suse.de>
	<20240725144548.3434-2-ddiss@suse.de>
	<xmqqle1pigbk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -5.31
X-Rspamd-Queue-Id: 4DE4E1F83B

On Thu, 25 Jul 2024 09:31:27 -0700, Junio C Hamano wrote:

> David Disseldorp <ddiss@suse.de> writes:
> 
> > 90bc19b3ae ("notes.c: introduce '--separator=<paragraph-break>' option")
> > changed note_data.given logic such that it's no longer set if a zero
> > length file or blob object is provided.
> >
> > Add a test for this regression by checking whether GIT_EDITOR is
> > invoked.
> >
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  t/t3301-notes.sh | 5 +++++
> >  1 file changed, 5 insertions(+)  
> 
> Having this test separate from 2/2 breaks bisectability.  For a
> small test like this, it is often a lot more preferrable to squash
> it into the patch that updates the behaviour.  It is easy to apply
> the whole thing, and when the reviewer/tester is curious, it is easy
> to tentatively "revert" only the behaviour changes out of the
> working tree to see how the original code behaved against the test
> to verify the alleged breakages were indeed there in the original.

Understood. In that case I'll squash both patches together in the next
version.

> > diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> > index 536bd11ff4..c0dbacc161 100755
> > --- a/t/t3301-notes.sh
> > +++ b/t/t3301-notes.sh
> > @@ -1557,4 +1557,9 @@ test_expect_success 'empty notes are displayed by git log' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'empty notes do not invoke the editor' '
> > +	test_commit 18th &&
> > +	GIT_EDITOR="false" git notes add -C "$empty_blob" --allow-empty
> > +'  
> 
> Clever.  By setting the editor to something that always fails, we
> will notice if the command invoked it, when we do not expect the
> editor to be used.
> 
> Not questioning the usefulness of this fix, and not suggesting to
> remove the "--allow-empty" support out of the "git notes" command,
> but out of curiosity, what are these empty notes used for?

icyci (https://github.com/ddiss/icyci) attaches test-suite stderr and
stdout notes following test completion. There's no real value in
attaching empty e.g. stderr notes, but tests can also provide their own
arbitrary notes files and may wish to use (empty) note existence as a
flag in results reporting.
