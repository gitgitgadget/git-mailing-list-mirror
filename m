Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E13250EB
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708773917; cv=none; b=AeKYzi/603lkFylTuaVFJI9UL0Q0NiaD0KXCEm/gBedXqmCzJAkdvtryUI3yBy+FGocoWoCBAD3Y3clHcuO/W1ziXudvgrV+DBTfs70mwuFQL2tiJGPod9x0F/7cNeNPT+Y1IjS4FMs34RXOYlX8+Ew68KJoIjGmT83h8qqO0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708773917; c=relaxed/simple;
	bh=IhXHopy0w4V5W67cs6r5daQJNVXhk6l8CJSOaJBiT3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM/ncUbjDhzzGOmM4cVvfoZrHWsVeU/ZoHFj5GR1/NjeLmv8zNBaPVjeEb342xpRHpFJlxlM/mP5+rElsDkZaqLnvNFYjiFGbucUMejmjrr5rQUonJKFJ7WK6XYCOiVKqJzkBwqznMAtgjYwq7kRXeO9/nYI9WX+o078ZVEEoqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=kARB5434; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="kARB5434"
Received: from localhost (unknown [IPv6:2a01:41e1:2925:e400:c8f3:9e80:357b:9b24])
	by smtp.roethke.info (Postfix) with ESMTPA id ED3771E0004A;
	Sat, 24 Feb 2024 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1708773907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvzoSFe08SRBWf9h16ysQJlaSDzmzyNRGw9nuyo/Tq4=;
	b=kARB5434/dwxF4J2pu+lXVNWJE8zKWu7/px2otcP+VQf7nffGy93XnjYbCWb4f7N2L4JEl
	2EloZEo9Q2o5FDxKOHFMlEfYFjbIKzeFiCxL7wqRQ1oFNr7ph5w9FMYg17xqtZ0GhdXQIx
	sIMv3X8AVD59xLLk9MP9+35zMAP2z3L6l8+QFmJaG1Na7nlQ+IfebXtfYlZ+zUx1g3efKI
	warGhZ1OPW3kcdqPML7n+1oH5LZAxmNoxFmXWPc/slI0onR02bOnSjXD/HGw6J2STVKyNH
	UCsyRa97kuzZhR47COsEK5OWXKq6fYUXRBnRGWwW+orfibP0lLD+TYsx4sVd8b+ELiCla1
	fsBZuBq0aDD2rKVN6aAhRuaRmaWh8mnSUVQmWaD5SAr1ko6GjKwncLErW57Qb8lXmafuze
	ae/D7hmMUCthTyBqHadoyfCUDhhe0Mx0YqdApfz4yNn5LkEeuCMDgZ7HAQUDFN7TsK0J5/
	f8E/Er9eQ3so2EnyWpW5aUSlx9jyTitvKWR5WglE8q1mN60Upo9vofOp3ArWV4XjpkUfvg
	+PyKbfjc9IWbhyc8g6q2B4K1Y9lnH5cF2kMjDoJRqNiKAEkQqyPWjvksjhOskU83VYk5O/
	pz0mEur+CKgmzG8YNuWweyGIUbGr7o6vtVi3emxTY9qKJeyX/9Lnc=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
Date: Sat, 24 Feb 2024 12:25:04 +0100
From: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rerere: fix crash during clear
Message-ID: <ZdnSEFgLdev3L2qs@roethke.info>
References: <20240218114936.1121077-1-marcel@roethke.info>
 <20240218194603.1210895-1-marcel@roethke.info>
 <xmqqplwsx730.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqplwsx730.fsf@gitster.g>

On 2024-02-19 17:22:43, Junio C Hamano wrote:
> Marcel Röthke <marcel@roethke.info> writes:
>
> > When rerere_clear is called, for instance when aborting a rebase, and
> > the current conflict does not have a pre or postimage recorded git
> > crashes with a SEGFAULT in has_rerere_resolution when accessing the
> > status member of struct rerere_dir.
>
> I had to read this twice before realizing the reason why I found it
> hard to grok was because of a missing comma between "recorded" and
> "git".

fixed

> > This happens because scan_rerere_dir
> > only allocates the status field in struct rerere_dir when a post or
> > preimage was found.
>
> But that is not really the root cause, no?  Readers following the
> above text are probably wondering why the preimage was not recorded,
> when a conflict resulted in stopping a mergy-command and invoking
> rerere machinery, before rerere_clear() got called.  Is that
> something that usually happen?  How?  Do we have a reproduction
> sequence of such a state that we can make it into a new test in
> t4200 where we already have tests for "git rerere clear" and its
> friends?

I'm unfortunately not sure how it happened. I do have the initial state
of the repository and I think I know the commands that were executed,
but I could not reproduce it.

I will look into adding a test case though.
