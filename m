Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEB1FCF73
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493792; cv=none; b=J0P8y1mM2kQOFGlSETIMJPAiDqWSJmjS+8GJ8In1tFQ52keFicRmXZA/pQ1Elu1wiasvJVfpojiPJebWKe0uFlSGQr7uIiMUSxraGua9326LkuweErkhlUZ/OyBQhL+/fx3AgXkaCtIrZlWVQGWOoqTRdZYLHhA1tPH1a8cjVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493792; c=relaxed/simple;
	bh=iufB1IGADaP4fJD4P1Zjxs0UPUGLifbaPZzgwSN84lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlT8jF6v2XGrWgZhu82QoZxzYnmErsHO4XrY3ZhJp/P9CquU5vGgGS67e42zV+qzXNtYVTZU+ICevfwwAwiCzx3WXWklOKyBFFpycFdMfvAKApIMdOj9V+W6mtnOW4g86OkUeKChexaDcM7dHxfvF1KUYJBvf0hcApIehrhtCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nbcvcnVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G+fihUa2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nbcvcnVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G+fihUa2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nbcvcnVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G+fihUa2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nbcvcnVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G+fihUa2"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2082C1F38C;
	Wed, 13 Nov 2024 10:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731493789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XU8wugFhaVZWvRi/AUCMRw+9377BmmeHP9357OfX6aU=;
	b=nbcvcnVWcG9JjUCMzKT5HIGXnFxah4rGdQu0aNI/6dPnWwhnmKBDeNWq/dtnuLLrqCaJmh
	pSyGothZB8Vc4HEpfbElbaVH8M8YfEnh7+2acYelD7ItRX2/Tr4tPeZ77aGcgRy7m+uhU8
	oeOidnP+WDaf+oIyOmsakErnkEsf9+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731493789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XU8wugFhaVZWvRi/AUCMRw+9377BmmeHP9357OfX6aU=;
	b=G+fihUa217ibw8BPoE/D29q/wYoTYjVIU2XUM5n1UXbZDFm/ERLpLdS8SonzODK46gOCqM
	g88idkF8InbbPACw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731493789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XU8wugFhaVZWvRi/AUCMRw+9377BmmeHP9357OfX6aU=;
	b=nbcvcnVWcG9JjUCMzKT5HIGXnFxah4rGdQu0aNI/6dPnWwhnmKBDeNWq/dtnuLLrqCaJmh
	pSyGothZB8Vc4HEpfbElbaVH8M8YfEnh7+2acYelD7ItRX2/Tr4tPeZ77aGcgRy7m+uhU8
	oeOidnP+WDaf+oIyOmsakErnkEsf9+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731493789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XU8wugFhaVZWvRi/AUCMRw+9377BmmeHP9357OfX6aU=;
	b=G+fihUa217ibw8BPoE/D29q/wYoTYjVIU2XUM5n1UXbZDFm/ERLpLdS8SonzODK46gOCqM
	g88idkF8InbbPACw==
Date: Wed, 13 Nov 2024 11:29:48 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: Shallow clone of a specific git revision?
Message-ID: <ZzR_nOqQxfGNPyYV@kitsune.suse.cz>
References: <ZzNJGHMlxGQyFV_c@kitsune.suse.cz>
 <87wmh7ig98.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmh7ig98.fsf@iotcl.com>
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Nov 13, 2024 at 11:23:47AM +0100, Toon Claes wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> 
> > Hello,
> >
> > Looking through clone man page it supports shallow clones of branches
> > and tags only.
> >
> > Would it be possible to do shallow clone of a specific revision,
> > and checkout specific revision on clone?
> 
> Hi Michal,
> 
> I'm working on a patch, and I've submitted a first version [1] a little
> while ago to allow users to pass a reference on git-clone(1). Would this
> change fit your needs, or what else would you like to support?

> [1]: https://lore.kernel.org/git/20240927085438.1010431-1-toon@iotcl.com/

Hello,

that slightly expands the available options but it does not make it
possible to clone an arbitrary revision, ie. specified by a SHA

Thanks

Michal
