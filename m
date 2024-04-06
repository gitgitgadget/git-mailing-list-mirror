Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8653032A
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712435310; cv=none; b=t8kM77VtlQTwaVgBlXt8qzEV8tcoHWwGjrlmGsdgGam7RXgeVgIh0NREDC56qCcImqgQc0MUbcHx84D3H0mslrUw8RSyiAKS7A4kCYGFMmulymtjMWS5iG1NzlFN178R1Ey6yla6EuRojIvu1TahXz8865GzvFJ7H1iuDG4Pz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712435310; c=relaxed/simple;
	bh=0ZSKvC89XMPJ18k+ijJbYkyidtl4YZFnuGFXc+Prk1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1zJB/h/neAiVWC5023epjUlITgjJBJrHfwp23jxIEqpspltisw9hYYUuJcx/YzvXCwhC6Z8gN69QIN9uDnrQhw9pow6LOWMHm5TB1SpVZF+Tdi4Eo0MT2Z3pbD19pc6yvt5VEGk9JaFS4ak3QGmcVDwAbv9KV29sb5ZDl0eJO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=GoGTXQ4N; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="GoGTXQ4N"
Received: from localhost (unknown [IPv6:2a01:41e1:2fb4:7500:559e:51ce:db99:6a71])
	by smtp.roethke.info (Postfix) with ESMTPA id 7019A1E0004A;
	Sat,  6 Apr 2024 20:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1712434892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZSKvC89XMPJ18k+ijJbYkyidtl4YZFnuGFXc+Prk1U=;
	b=GoGTXQ4NCnpqWNGl0vcUAIQ1pfvMh+6RaBfRzzv8OJXNvllzr+D/SfvmixhnId1r1LZxdW
	spDy4sm/dl2k3C18m2dDU373MROYgrguWzqVAPEYZldapRyH7VHYzz++YDYE5WJ2aCL6Dm
	IM+v6KUvuoZlsJqKz5BrhxpnBHYck9F8AXS62+cm7vM1ilhxzo42x3+6NlufmZMizmgb+P
	YyXRA6itiAH9UvXUMOkpDBs3N8q4uRvHgOvNrGDB82ZqVl+59IwQkB8wYLI061I/Gmieow
	c8BjjBNswKdTkuYp6a03ua+zxyDW68I6/5PLmrxTo78StN2ZDGALGtReTSaQbsB/uKFb7Q
	d38nKXIr9nxwYBnFAr3CCd6J1FgWfQd2MepMMtedXAaW2X/K8MjIHRaqF7uf0DrmjjlTqa
	Rzy3qZ8NMJN6PX/iyZuqLRNF4hpaNz8g440UKHJ6jt4aGZtJ4hq99mEHfI696EDUB7ccey
	zhjQKAzZGpLJ9A2nGgP+xNnOxTqE/pqBRmUntkkqs2V9X55pfp9KhFvpySyFMKY/pVKeQ3
	PaideZGTTgKNpg/JHJgjpfYSwFTBqLmIpNv/xvKDDPSlc+gRQwsivTDy50EkSALYZHc/dE
	qG/OCKcqCCqVuWzwZ0PHYm+3pWCifyEIkyBjBJCh9qLr64nDt2j8U=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
Date: Sat, 6 Apr 2024 22:21:29 +0200
From: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
To: Junio C Hamano <gitster@pobox.com>
Cc: Wolfgang Rohdewald <wolfgang@rohdewald.de>, git@vger.kernel.org
Subject: Re: segfault with git rebase --abort
Message-ID: <ZhGuyeJp28heaITM@roethke.info>
References: <88a694de4a7f767613475ef1d19292a69eaccb07.camel@rohdewald.de>
 <xmqqle67pa7a.fsf@gitster.g>
 <7df26e3813ef76ee90c1fb02847bbb4b9bad630d.camel@rohdewald.de>
 <xmqqfrwehweg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrwehweg.fsf@gitster.g>

On 2024-03-25 13:46:47, Junio C Hamano wrote:
> Wolfgang Rohdewald <wolfgang@rohdewald.de> writes:
> I think I forgot to remove one line of "<<<<<<< HEAD" before doing the first git add.

This was the missing piece in my reproduction attempts!
When you leave that line in and have another conflict in the same file
later in the rebase, rerere falls on its nose.

I will do some more poking and update my patch accordingly.
