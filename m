Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66345248880
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467285; cv=none; b=YD6icS19phG7PC3UES/cdzie2pdKTYds2kQvIS9+Be/0IwBtD+NUvFznoysv/nvDqlJXBkFZrsTu6wa0+KnDV0I08+eXJjC8US4GimCWj0kDN3o3LN4r3obSaSV/c29gO15R1uZz2GL4BGAur1Wwlc2BqaV+OmeQmVcjLVBu3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467285; c=relaxed/simple;
	bh=dPYgwIhgFAuvTbvnwhQ25UDp/bSK3q5apGGMWm2hS7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgH7J78oICyoTcEYzmNhR0KJCN1sllYlDt1uIeBjXSbGm4MRpdkDGHTQ1dLoTl0RO2otO1NuGxyfT3giXDR1bbf6qcZ793ZDlg2apP6SqcIoCt/qgc2Ohs1cXjLuC890jIBC3gonvsjodWwKJSo1xqdlSRKyo3YEnqG7PHBo99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RvGvGPJS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wsii/JPe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RvGvGPJS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wsii/JPe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RvGvGPJS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsii/JPe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RvGvGPJS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsii/JPe"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0ED7F1FE26;
	Tue, 18 Nov 2025 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763467276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Giwwy2s2LD5PruFfgYUjDvXL8Sxuq5MWK5JNV2MrZnw=;
	b=RvGvGPJSyy52qaGhTfYDB314hUWlyHe3XnWp+1m5emH4jjqQ0dtEk3loFmA1W5UlH3Z8PW
	MF2AetDt6NC3JyhT2z20DWX89eDn/HzXvwjBDUMh4hOJgFzQQ6kIsRdZwz4rtgc45vqlxT
	hdyus82UiGAbh4uTPfEuqDYiEQAE6Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763467276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Giwwy2s2LD5PruFfgYUjDvXL8Sxuq5MWK5JNV2MrZnw=;
	b=wsii/JPe9HcBDL5V+DZCLAv9H5pTvOKFOpYE4F3UkpMDr+SX1VSfGLEzgml7S1JKCvvol4
	BsLBVKyjktpXiXCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763467276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Giwwy2s2LD5PruFfgYUjDvXL8Sxuq5MWK5JNV2MrZnw=;
	b=RvGvGPJSyy52qaGhTfYDB314hUWlyHe3XnWp+1m5emH4jjqQ0dtEk3loFmA1W5UlH3Z8PW
	MF2AetDt6NC3JyhT2z20DWX89eDn/HzXvwjBDUMh4hOJgFzQQ6kIsRdZwz4rtgc45vqlxT
	hdyus82UiGAbh4uTPfEuqDYiEQAE6Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763467276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Giwwy2s2LD5PruFfgYUjDvXL8Sxuq5MWK5JNV2MrZnw=;
	b=wsii/JPe9HcBDL5V+DZCLAv9H5pTvOKFOpYE4F3UkpMDr+SX1VSfGLEzgml7S1JKCvvol4
	BsLBVKyjktpXiXCw==
Date: Tue, 18 Nov 2025 13:01:15 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH v2 2/2] doc: git-worktree: Add side by side branch
 checkout example
Message-ID: <aRxgC7TAopqsrZen@kitsune.suse.cz>
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
 <0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
 <CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com>
 <aPtRzTwVgVfqjaZT@kitsune.suse.cz>
 <CAPig+cQoL_=WdNpcO_9mTLDRRDHCOC1-nYMwUyfaev3BZyzaow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQoL_=WdNpcO_9mTLDRRDHCOC1-nYMwUyfaev3BZyzaow@mail.gmail.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,pobox.com,proton.me,jcubic.pl];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Fri, Oct 24, 2025 at 12:57:42PM -0400, Eric Sunshine wrote:
> On Fri, Oct 24, 2025 at 6:15 AM Michal Suchánek <msuchanek@suse.de> wrote:
> > On Sat, Oct 11, 2025 at 01:17:47AM -0400, Eric Sunshine wrote:
> > > Third, the example seems overly complicated, especially with its use
> > > of `--git-dir`, which feels less discoverable (at least to me) than,
> > > say `-C`. What I have in mind is an example more like this:
> > >
> > >     $ git clone --bare <repository-url> myproj.git
> > >     $ git -C myproj.git worktree add feature-a
> > >     $ git -C myproj.git worktree add feature-b
> > >
> > > That should be more than sufficient to get people up and running with
> > > associating worktrees to a bare repository.
> >
> > That creates a mess. First part is not creating the directory to contain
> > the worktrees related to the repository. Second is creating the
> > worktrees inside the bare repository, contrary to any reasonabe usage
> > advice.
> 
> Sorry, I mistyped that. What I meant was:
> 
>     $ git -C myproj.git worktree add ../feature-a
> 
> which makes the worktrees siblings of the bare repository.

and requires the mental gymnastics of adjusting the paths passed to the
command based on -C argument. Does not sound like a good example how to
use the command.

> As for first creating a directory to contain the repository and the
> worktrees, I purposely omitted that step in the example since I
> assume/hope that we don't need to hand-hold the user to that extent.

Its much easier to reove superluous parts from the example than adding
patrs that were omitted.

Thanks

Michal
