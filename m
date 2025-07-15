Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FC202C26
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589106; cv=none; b=ELdiSHb9xyjvLa2P36fBRkgs5kB+z+2EL7X6cweDflJfVIEf9nAnb0E8SfWgk8tr34UV63FbIXj/GYG1E8sh+KVVDeqQpm+MwxR7Zov3O/cWl4TXh6ycnXsnmOM7yJ2z/rRZyzthfGroM+M4l6dTRTRf/dp7NrgtUhbX+FYwnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589106; c=relaxed/simple;
	bh=/IKcCJH+enVxTP7DB96MTvJqaEtmc5SnI8gxNQd2w00=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYdi6LYNOOFWhHh/31bBef/SkFMBPrMAmfn7Z2uYcYKdCwrMUmEXb0Wr3STdl+Jqq3I9n827ZGh5WzMYGDs+Wa+Qz7ijdjYj2xCUn+Ey9At8+FW0LOVOL/EwNueFcm8YaXsxX58qz++M6KzxFrt/xIaaB3JEdyWuKNaZorR0Ims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rEflhZuY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yqQB4iMm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rEflhZuY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yqQB4iMm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rEflhZuY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yqQB4iMm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rEflhZuY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yqQB4iMm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72C751F397;
	Tue, 15 Jul 2025 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752589102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tiwIGrWQY4QTMYDC8r0J8nH2Q+7KC45ELOKX/14g7XU=;
	b=rEflhZuYW3eDx9N0GhnIHXaC/Ju0Mctsy890nkTCRICdlfeluol2wdscY5Ge609a8sewsY
	fAjTPQkv2snLv/VySZo5Ad+p4XCT15WM5bY9sKqCV7yF8Bvl579TJIKvAytB1pgvDZaMVY
	KWSxX+SpMH+CakWE6IaTSFeC/WWBRtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752589102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tiwIGrWQY4QTMYDC8r0J8nH2Q+7KC45ELOKX/14g7XU=;
	b=yqQB4iMm/YEvN/0FleQ7LjUq607ANL7V2R4bDlmdHZDrIpnoeUv3Y9K469F9f08yIfidrt
	jsVKhGyQ7jV6V3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752589102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tiwIGrWQY4QTMYDC8r0J8nH2Q+7KC45ELOKX/14g7XU=;
	b=rEflhZuYW3eDx9N0GhnIHXaC/Ju0Mctsy890nkTCRICdlfeluol2wdscY5Ge609a8sewsY
	fAjTPQkv2snLv/VySZo5Ad+p4XCT15WM5bY9sKqCV7yF8Bvl579TJIKvAytB1pgvDZaMVY
	KWSxX+SpMH+CakWE6IaTSFeC/WWBRtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752589102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tiwIGrWQY4QTMYDC8r0J8nH2Q+7KC45ELOKX/14g7XU=;
	b=yqQB4iMm/YEvN/0FleQ7LjUq607ANL7V2R4bDlmdHZDrIpnoeUv3Y9K469F9f08yIfidrt
	jsVKhGyQ7jV6V3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6091213A70;
	Tue, 15 Jul 2025 14:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +VwOFy5jdmjnRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 15 Jul 2025 14:18:22 +0000
Date: Tue, 15 Jul 2025 16:18:22 +0200
Message-ID: <87ecuha66p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] git-gui: Add support of SHA256 repo
In-Reply-To: <b78bad36-d4ae-4d91-a72a-c3446e10d34b@kdbg.org>
References: <20250703120430.17240-1-tiwai@suse.de>
	<b78bad36-d4ae-4d91-a72a-c3446e10d34b@kdbg.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Mon, 14 Jul 2025 18:28:13 +0200,
Johannes Sixt wrote:
> 
> Am 03.07.25 um 14:04 schrieb Takashi Iwai:
> > This patch adds the basic support of SHA256 Git repositories.
> > The needed changes were mostly about adjusting the fixed ID length of
> > SHA1 (40) to be variable depending on the repo type.
> 
> Thank you. Being precise in the commit message would be very
> appreciated. You say "mostly", which makes me wonder what the cases are
> that fall not under "mostly". How about:
> 
>    Determine the hash length on startup, then replace the hard-coded
>    "40" by the variable value. Also fix <foo> to do <bar> so as to
>    account for <baz>.
> 
> Or make a bullet list if there is more to enumerate. Or make a
> multi-patch series where each patch has its own topic if this is warranted.

Thanks for the review!
Sure, will add more descriptions in the next respin.

> BTW, there is a case
> 
>       if {[regexp {^[0-9a-f]{1,39}$} $head]}
> 
> around line 3217 in git-gui.sh.

Obviously I didn't look for numbers less than 40 :)
I'll replace it, too.

But I don't understand why it matches up to only 39, not 40 in the
code above.
It seems trying to get the proper hash id if it's no full length id?
If so, the check should be rather like
	if {![regexp {^[0-9a-f]{40}$} $head]}
??  It makes the conversion a bit simpler.

> > @@ -436,7 +437,7 @@ method _load {jump} {
> >  			$i conf -state normal
> >  			$i delete 0.0 end
> >  			foreach g [$i tag names] {
> > -				if {[regexp {^g[0-9a-f]{40}$} $g]} {
> > +				if {[regexp [string map "@@ $hashlength" {^g[0-9a-f]{@@}$}] $g]} {
> 
> Github copilot insist that using 'string map' to replace parts of a
> regular expression is idiomatic. However, I could not find a single
> reference that it cited. Tsk, tsk, AI, what were you smoking today?
> 
> The alternatives that I tried could come up with were not any better, so
> this is good.

To be honest, my knowledge of Tcl/Tk is decades old (and only casually
revisiting right now), so let me know if there is a better
expression.

> > @@ -648,7 +652,7 @@ method _read_blame {fd cur_w cur_d} {
> >  			set oln  $r_orig_line
> >  			set cmit $r_commit
> >  
> > -			if {[regexp {^0{40}$} $cmit]} {
> > +			if {[regexp [string map "@@ $hashlength" {^0{@@}$}] $cmit]} {
> 
> This is a roundabout way to say 'if {$cmit eq $nullid}'.

OK, noted.

While we're at it, I found that $null_sha1 is identical with $nullid.
I'll prepare a cleanup patch as preliminary.

> > @@ -879,7 +881,7 @@ method _do_clone_full_end {ok} {
> >  		if {[file exists [gitdir FETCH_HEAD]]} {
> >  			set fd [open [gitdir FETCH_HEAD] r]
> >  			while {[gets $fd line] >= 0} {
> > -				if {[regexp "^(.{40})\t\t" $line line HEAD]} {
> > +				if {[regexp [string map "@@ $hashlength" "^(.{@@})\t\t"] $line line HEAD]} {
> >  					break
> >  				}
> >  			}
> 
> The repository picker dialog runs before $hashlength is set. Therefore,
> at the time that this function is executed, $hashlength is not available.
> 
> This procedure can depend on the file format, which is to have \t\t
> after the hash regardless of its length.

Oh that's bad.  I'll rewrite without the reference to $hashlength.
I guess we can simply replace the above with a range check {40,64}.

> > @@ -965,6 +967,8 @@ method _do_clone_checkout {HEAD} {
> >  }
> >  
> >  method _readtree_wait {fd} {
> > +	global hashlength
> > +
> >  	set buf [read $fd]
> >  	$o_status_op update_meter $buf
> >  	append readtree_err $buf
> > @@ -986,7 +990,7 @@ method _readtree_wait {fd} {
> >  
> >  	# -- Run the post-checkout hook.
> >  	#
> > -	set fd_ph [githook_read post-checkout [string repeat 0 40] \
> > +	set fd_ph [githook_read post-checkout [string repeat 0 $hashlength] \
> 
> Yet another case where $nullid can be used.

But it's also in repo picker code, so we don't have $nullid yet?
I'll rewrite somehow without $hashlength reference here, too.
(e.g. use the length of "git-rev-parse HEAD" output that is called
below)

> >  		[git rev-parse HEAD] 1]


thanks,

Takashi
