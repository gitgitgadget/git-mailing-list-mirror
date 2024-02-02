Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E361799A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894612; cv=none; b=UuMPSdi0feK3f9nn5f/TCBW6dGjh8rrnrryqCDt9R3nFMbwh9+Y4N1jsFF2N6L0IIqNvLXbEbswldDPmbwQlHxhoGcaaNiTrcT51/gNEviS/jPqShc43mYqo7XLmggNkqChNd6uso5Cr5kgTLKJ1CovQfbNP2vkwzuY5U5KGC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894612; c=relaxed/simple;
	bh=PH6bS6/92I3osZfj2pw2CF/9M0AmvtMWXo05ATUITi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Viqjbo/1Y+5nsrXcsnKovTB7bswldUeurYjE+LuKEsVNTrltgSW1s7xxV5IaxKr75PlR4r0wfbD/dlYuhdhowh5ig3gl00hy0V+oxLEcUKrMZqTKsFHa2cK2qxBlflWQdZxIIB/F44lBVqakG6aGOztL5SMNP8S8K19UT0rmjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t5917IAv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0OW86cdi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t5917IAv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0OW86cdi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t5917IAv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0OW86cdi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t5917IAv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0OW86cdi"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BE0E1FD3B;
	Fri,  2 Feb 2024 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706894608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcUbOZQfnQI37R4zl4+l4XfX5EYbhozfSl3r20ce6to=;
	b=t5917IAveOtz0mXl76nzo7HwiyebVFChK095isaA3RjKc6p6cPDmwQHCcU4OVsibKCQgs9
	Ors6M9gec97HwpZWmS7Qby99nZnEYyUR2bTt20/63vpNgKV6qTyLXaKLVRZiDHQsEq3t+5
	nwved08zQ2beUIhkceieY/FKvRsoaY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706894608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcUbOZQfnQI37R4zl4+l4XfX5EYbhozfSl3r20ce6to=;
	b=0OW86cdis9wGRMGOj2GPStoVEVbj0BSwR8cW+0R13XqfeYt0hTnY61yEiM9L6OT7K9TJ0f
	0VsqG/MMhMOgTfDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706894608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcUbOZQfnQI37R4zl4+l4XfX5EYbhozfSl3r20ce6to=;
	b=t5917IAveOtz0mXl76nzo7HwiyebVFChK095isaA3RjKc6p6cPDmwQHCcU4OVsibKCQgs9
	Ors6M9gec97HwpZWmS7Qby99nZnEYyUR2bTt20/63vpNgKV6qTyLXaKLVRZiDHQsEq3t+5
	nwved08zQ2beUIhkceieY/FKvRsoaY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706894608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UcUbOZQfnQI37R4zl4+l4XfX5EYbhozfSl3r20ce6to=;
	b=0OW86cdis9wGRMGOj2GPStoVEVbj0BSwR8cW+0R13XqfeYt0hTnY61yEiM9L6OT7K9TJ0f
	0VsqG/MMhMOgTfDA==
Date: Fri, 2 Feb 2024 18:23:27 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: rsbecker@nexbridge.com, 'Sergey Organov' <sorganov@gmail.com>,
	'Hans Meiser' <brille1@hotmail.com>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <20240202172327.GW9696@kitsune.suse.cz>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <877cjm53bf.fsf@osv.gnss.ru>
 <008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
 <20240202161643.GD119530@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202161643.GD119530@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 URIBL_BLOCKED(0.00)[nexbridge.com:email,gmaine.io:url];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,hotmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 FREEMAIL_CC(0.00)[nexbridge.com,gmail.com,hotmail.com,vger.kernel.org];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Fri, Feb 02, 2024 at 11:16:43AM -0500, Theodore Ts'o wrote:
> On Fri, Feb 02, 2024 at 10:22:18AM -0500, rsbecker@nexbridge.com wrote:
> > >
> > >Did you consider to rather read the list through
> > >gmane.comp.version-control.git nntp newsgroup?
> > >
> > >This way you get only very specific mails in your mail-box, those
> > >where you are explicitly CC'ed, and you usually get more support
> > >for structuring from NNTP readers than from mail clients.
> > 
> > Google is dropping Usenet NNTP updates on 22 Feb 2024. I would love
> > that idea, but it has a limited lifespan.
> 
> Google might be dropping Usenix NNTP updates, but news.gmaine.io and
> nntp.lore.kernel.org are not not run by Google.  So whether or not
> Google groups are supporting NNTP is not really supporting.
> 
> One other thing I would note that is that if someone isn't interested
> in following most of the git mailing list, it's unclear how much they
> can actually contribute.  Maybe they could fix spelling or grammer
> issues in the git man pages, but it's unlikely they could actually
> make code contributions.
> 
> So from an open source project perspective, which is primarily run by
> volunteers, each open source project has to make a cost-benefit
> tradeoff as far as the *project* is concerned.  Individuals do not
> have a fundamental human right to contribute to a project.  Hence, the
> open source project doesn't owe an obligation to spend a huge amount
> of effort supporting some kind of forge web site just because some
> potential contributors are clammoring for it.  Especially if they are
> saying that they can't be bothered to follow the mailing list traffic
> because it's somehow too much.

That's not to say that the mailing list traffic cannot be wrapped in
another interface if somebody has the motivation and spends the effort
to do it.

For example, there used to be (and maybe still is) a bidirectional
gateway that bridged the ruby-talk mailing list into a web forum that was
run by a person who thought it's a good idea, and resolved the problems
that came out of it.

e-mails have pretty good 1:! correspondence to forum posts or forge PR
comments. Some features like post edits or emoji reactions do not
translate, and cannot be provided with e-mail backend.

However, presenting the mailing list through a different interface, and
hosting the application doing the translation is a work that the person
suggesting the change would have to do, or hire someone to do for them,
rather than coming and saying 'Throw away all the tools you have now,
and install and run this thing instead to make it easy for me'.

Thanks

Michal
