Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406FDF6C
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949969; cv=none; b=Vqr83rFe+pNwPu69rI2rRkRtHbUygqoNneDHzaJfZZHrkZIG8IKeaz5aJEBotaK0xmKEM7ZHgw32KGllfFuzJ1ZMa1KfjevVDuoOKglCoCE0p+rU889wjne1f33T4Zom0Vwxfq7AP27ND4CIzAywb9e0bkjUhZEQJMKV8LHXmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949969; c=relaxed/simple;
	bh=D7qRTu2uGiYfzQyoGhqknZZRqSAJU/9P/0Slz2ezBKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbO5dYliYxCwrX6xF/rGxj4YdacJVpEULe2oWlAnuvhZbI7A5/uqvJu7b8B6qOheAyZF3srDJxbSjsP4NnTjG2q2reXMI2q9GgZDpW5pDToRJI+8IjFhmQScy10OAXEEbdXbseiVDKBPfS6ooSL8PDfJ5acm/Nr1CVyKc5hFVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TfeSMOFc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WHH3tBlz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TfeSMOFc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WHH3tBlz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TfeSMOFc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WHH3tBlz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TfeSMOFc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WHH3tBlz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65FD71F83D;
	Thu, 25 Jul 2024 23:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721949965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP43nzY8450vXF28TFyNmNH93qZaAIJIRl5yMyhZX0k=;
	b=TfeSMOFcbfssISqCmM/TWwoA0l6ikrhlkE5jHSUgL+oN0BZHw45xUe8csR3Wz6GnZnluLR
	ven/K1DHe6E3Mp54efxtKDNubb5E4Mp04WP1Pnmo3Vz0HN3V+aR83YThf5NlX6ZiJN35L/
	iuS9HrutLEYwKyOKkELXFmKo+RFDyNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721949965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP43nzY8450vXF28TFyNmNH93qZaAIJIRl5yMyhZX0k=;
	b=WHH3tBlzBLD9g0bXrKzS055MQxD8bQidX6duI2heCcY8JBelxuAq0bjdQUbY+q5g4EedBZ
	0yD/Fde8HS/feOBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TfeSMOFc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WHH3tBlz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721949965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP43nzY8450vXF28TFyNmNH93qZaAIJIRl5yMyhZX0k=;
	b=TfeSMOFcbfssISqCmM/TWwoA0l6ikrhlkE5jHSUgL+oN0BZHw45xUe8csR3Wz6GnZnluLR
	ven/K1DHe6E3Mp54efxtKDNubb5E4Mp04WP1Pnmo3Vz0HN3V+aR83YThf5NlX6ZiJN35L/
	iuS9HrutLEYwKyOKkELXFmKo+RFDyNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721949965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP43nzY8450vXF28TFyNmNH93qZaAIJIRl5yMyhZX0k=;
	b=WHH3tBlzBLD9g0bXrKzS055MQxD8bQidX6duI2heCcY8JBelxuAq0bjdQUbY+q5g4EedBZ
	0yD/Fde8HS/feOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 343A313874;
	Thu, 25 Jul 2024 23:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5k/OCg3fomZqKwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 25 Jul 2024 23:26:05 +0000
Date: Fri, 26 Jul 2024 01:26:04 +0200
From: David Disseldorp <ddiss@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 2/2] notes: revert note_data.given behavior with empty
 notes add
Message-ID: <20240726012604.057a645a.ddiss@suse.de>
In-Reply-To: <xmqqzfq5flfd.fsf@gitster.g>
References: <20240725144548.3434-1-ddiss@suse.de>
	<20240725144548.3434-3-ddiss@suse.de>
	<xmqqzfq5flfd.fsf@gitster.g>
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
X-Rspamd-Queue-Id: 65FD71F83D
X-Spam-Score: -5.31
X-Spam-Level: 
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]

On Thu, 25 Jul 2024 10:09:26 -0700, Junio C Hamano wrote:

> David Disseldorp <ddiss@suse.de> writes:
> 
> > Subject: Re: [PATCH 2/2] notes: revert note_data.given behavior with empty notes add  
> 
> Maybe it is just me, but "revert" has a specific connotation in the
> context of the command this project develops, and when your patch is
> not doing so, it gets misleading.  If you said you are restoring the
> behaviour, that would be more easily understood.
> 
>     notes: do not trigger editor when adding an empty note
> 
> perhaps?

Sure, sounds good to me.

> > Prior to 90bc19b3ae, note_data.given was set alongside an -m, -C or -F  
> 
> Please make the first mention of a commit using "git show -s --pretty=reference"
> format, i.e.
> 
>     90bc19b3ae (notes.c: introduce '--separator=<paragraph-break>' option, 2023-05-27)
> 
> Using the reference format, besides being consistent, is very much
> preferrable to allow us to tell how old the problem goes back
> immediately by having the datestamp at the end.

Ack, will do.

> more generally, this proposed log message starts with implementation
> details.  When we have a user-visible breakage, please start from
> describing that instead.  The usual way to compose a log message of
> this project is to
> 
>  - Give an observation on how the current system work in the present
>    tense (so no need to say "Currently X is Y", just "X is Y" or "X
>    does Y"), and discuss what you perceive as a problem in it.
> 
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
> 
>  - Give commands to the codebase to "become like so".
> 
> in this order.  So something along this line:
> 
> 	With "git notes add -C $blob", the given blob contents are
> 	to be made into a note without involving an editor.  But
> 	when "--allow-empty" is given, the editor is invoked.
> 
> 	This behaviour started when 90bc19b3 (notes.c: introduce
> 	'--separator=<paragraph-break>' option, 2023-05-27).  Prior
> 	to that commit, we used to do this and that ... describe
> 	implementation details here if you want ...
> 
> 	Restore the original behaviour of "git note" that takes the
> 	contents given via the "-m", "-C", "-F" options without
> 	invoking an editor, by doing ... this and that ... describe
> 	implementation details here if you want ...
> 
> would be more customary.
> 
> This is not a fault of this patch, and certainly not a fault of
> 90bc19b3 (notes.c: introduce '--separator=<paragraph-break>' option,
> 2023-05-27), but unlike "git commit" and "git tag" that can take
> pre-prepared contents from some source and by default use that
> intact without involving an editor, "git notes" seems to lack the
> ability to countermand this default and spawn an editor (e.g., "git
> commit -F myfile -e").  We may want to #leftoverbits fix that.
> 
> > Fixes: 90bc19b3ae ("notes.c: introduce '--separator=<paragraph-break>' option")
> > Link: https://github.com/ddiss/icyci/issues/12  
> 
> We generally refrain from using these two trailers.  Please drop them.
> 
> Especially "Fixes" claim can later prove incorrect (we thought this
> was a good fix when committing, but it later turned out to be a bad
> one), and besides you will be referring to the problematic commit in
> your proposed log message already anyway.

Okay, will drop the Fixes: and go with a footnote for the downstream
issue, as proposed by Kristoffer.

> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  builtin/notes.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index d9c356e354..3ccb3eb602 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -282,6 +282,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
> >  	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
> >  	d->messages[d->msg_nr - 1] = msg;
> >  	msg->stripspace = STRIPSPACE;
> > +	d->given = 1;
> >  	return 0;
> >  }
> >  
> > @@ -302,6 +303,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
> >  	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
> >  	d->messages[d->msg_nr - 1] = msg;
> >  	msg->stripspace = STRIPSPACE;
> > +	d->given = 1;
> >  	return 0;
> >  }
> >  
> > @@ -335,6 +337,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
> >  	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
> >  	d->messages[d->msg_nr - 1] = msg;
> >  	msg->stripspace = NO_STRIPSPACE;
> > +	d->given = 1;
> >  	return 0;
> >  }  
> 
> All the above places that resurrects setting d.given looks OK, but
> it makes me wonder if you need to add them in the first place.
> 
> Wouldn't it be sufficient to see if d->msg_nr is non-zero after all
> the parsing is done?  If any of the message came from "-c", a
> separate flag d->use_editor is set to force you run the editor, and
> otherwise you'd not be using the editor, right?
> 
> > @@ -515,7 +518,6 @@ static int add(int argc, const char **argv, const char *prefix)
> >  
> >  	if (d.msg_nr)
> >  		concat_messages(&d);
> > -	d.given = !!d.buf.len;  
> 
> Here is what I mean.  If you didn't do any of the "d->given = 1"
> above during parsing, and instead say
> 
> 	if (d.msg_nr)
> 		concat_messages(&d);
> 	d.given = d.msg_nr;
> 
> shouldn't it be sufficient to convince prepare_note_data() to do the
> right thing?

Yes, I also noticed that msg_nr could also be used for this, but chose
to revert back to the old given logic for clarity. I'll revisit the
msg_nr approach for v2.

Thanks for the feedback,
David
