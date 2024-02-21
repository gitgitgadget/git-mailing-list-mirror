Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41E42A8E
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540223; cv=none; b=kXVFcuBnC7AszdOsv9Emdx8G35XoH61Yg8d79nb8zUWcjj1qpy+VMo8xXkn2TAuTS2hkIsoy/lfzwnWeb7mFlWAbjvbZVzAstHPUb1t3rV7QP7vcYIIAVgg7oObTwh9IVseKi4f1Qx02BlmZ663hHtnRlwtl4Xe3DlMkFQgPc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540223; c=relaxed/simple;
	bh=91CoCH2pqLgf9NBEKGdoXA4+KXOJx+rkJdyXY9BnxpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+v8FVC+ZWccz6fXvWBWC1nFHeKrkvLblZKLn5DxUfKBUiy7dOLwAhBATHX2Kkixm79leFn23XV2XXo/CI+koFN5vRDkQtn+WLm6Y0897EOc6pwI1s21q9f+OpvyZKdg834O0BsH4YIafwR6Gd2FuO+Co/iad5GbaNdKavfM0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mWYzFqGg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0ivxPR5T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mWYzFqGg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0ivxPR5T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mWYzFqGg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0ivxPR5T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mWYzFqGg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0ivxPR5T"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 317B021DE1;
	Wed, 21 Feb 2024 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708540219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7Hvn+tOmEhpXJ3N/pGQ8Vm/6xc6qJvYXNUMTetCWzA=;
	b=mWYzFqGgFeShtYfzYDQ/wHkMjiFgiYh+1Ju1NsUK/MFHArMUdgavvYDtO4TjbASuSbT6Mj
	3t2T1a3TEtD52ap3TEHNIMWjSzJoVmuq/guPH8ASpgtnOZ7Q9lhxdifXFboDhLKK8uEodU
	FGwNOjUsHKDhrGtz3uMu/7orDvctbpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708540219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7Hvn+tOmEhpXJ3N/pGQ8Vm/6xc6qJvYXNUMTetCWzA=;
	b=0ivxPR5TLJnP8UjApaQnYnWQVcHiCbQm2WxMFp5eZlKm2q05lnHRwEdcKXvSwcT4BcGVFX
	R7CTd28109YORFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708540219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7Hvn+tOmEhpXJ3N/pGQ8Vm/6xc6qJvYXNUMTetCWzA=;
	b=mWYzFqGgFeShtYfzYDQ/wHkMjiFgiYh+1Ju1NsUK/MFHArMUdgavvYDtO4TjbASuSbT6Mj
	3t2T1a3TEtD52ap3TEHNIMWjSzJoVmuq/guPH8ASpgtnOZ7Q9lhxdifXFboDhLKK8uEodU
	FGwNOjUsHKDhrGtz3uMu/7orDvctbpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708540219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7Hvn+tOmEhpXJ3N/pGQ8Vm/6xc6qJvYXNUMTetCWzA=;
	b=0ivxPR5TLJnP8UjApaQnYnWQVcHiCbQm2WxMFp5eZlKm2q05lnHRwEdcKXvSwcT4BcGVFX
	R7CTd28109YORFBQ==
Date: Wed, 21 Feb 2024 19:30:18 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
Message-ID: <20240221183018.GB9696@kitsune.suse.cz>
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
 <xmqqv86jqc2e.fsf@gitster.g>
 <20240221173822.GA9696@kitsune.suse.cz>
 <xmqqr0h5og57.fsf@gitster.g>
 <xmqqjzmxofvn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqjzmxofvn.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.11 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,harmenstoppels.nl];
	 BAYES_HAM(-0.01)[47.71%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.11

On Wed, Feb 21, 2024 at 10:02:04AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Michal Suchánek <msuchanek@suse.de> writes:
> >
> >> Or if it does touch the po files it could as well update the
> >> translations.
> >>
> >> There are changes that can be trivially translated without any knowledge
> >> of the target language.
> >
> > You need to know the target language before deciding it is OK and
> > sufficient to just remove ̉¿? from around a sentence to make it from
> > a question to a statement of a fact.  You may know enough, but
> > reviewers may not be.  In addition, it would allow bypassing the
> > language teams, which is the most serious problem I see in such an
> > attitude.
> 
> Oops, "attitude" -> "approach".

That's certainly true that even if you know how to remove a question
mark you may not find a reviewer who knows how to remove one.

Nonetheless, if you do find both a patch author and a reviewer that know
how to remove a question mark what is the problem with not involving
several language teams to remove a question mark?

Thanks

Michal
