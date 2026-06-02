Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E03C8738
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395631; cv=none; b=PrxMv4ghYQ5X1MY5RTrPvC6MaXrGm8qfNmOALXu0/evOMPi5pPeIMq++eAyY7+fz06fANj88z1wmbvxlIbj6wqt45g1mvvfo9oED5xnTkRHN/llzHKqRlEf7sLHJt05nLjvRHW1KgsLmku/fYe0FdftolqsDiv3i7521rk9CukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395631; c=relaxed/simple;
	bh=IUD5Kvrz+cQTH+prCcMSGQg7iIzWqhspCZcVFUh6rBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXVf0ljZGmigc02CT4e+HRS+72+RrjxOJGD/9llFy9I2mRaqbNWKb5ee0S20iXZfSOF5RzslNjc6+ngcAWPpPtO8HsQo3IZ+3ZihqCia4MgkhPS4EaBqqrGJuZOfp985kyS55h7qbZ7yqqTncnU1OEXugc8Zx2mGR6GEWaZ9lpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pEQOLVpV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVkF7Mhm; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pEQOLVpV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVkF7Mhm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5C767A0108;
	Tue,  2 Jun 2026 06:20:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 06:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780395629; x=1780482029; bh=7tqElkadnb
	P6nbFCXaVOxGHmmUWuhzNJi3b64dYgVI8=; b=pEQOLVpVrLue3eIayIOe8nOE0B
	CRrbxhSFp1x7mPzCT53J1ivXXtgz+PfyvjdBH3XWnTkZ/6b8pV9xD5rWkKeUsK5R
	RnGOnNWOiNtJeZVitmA9Z3y+A+BSsZN+wJ9ICLIJTseu20HOXwqZcX+RjYu6LixO
	UnIGaUkGZ9fFkWgEwFvg6Y9//DOaG+/oofmP1zS62Cjj29zJeNK4H+WTumi9T8IP
	kKUvGkyBTfYQ+VFCJ+r0Od2Sgmce5/PqJxcA2ILsT9NnszxoeYj84etSIhkVtM3d
	2Zhy/vcMzIJk1n0YEIiPCAfTyCZpYdGF9sKlrSBfbNVqB0NbXjV+TMtbsQKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780395629; x=1780482029; bh=7tqElkadnbP6nbFCXaVOxGHmmUWuhzNJi3b
	64dYgVI8=; b=RVkF7Mhmu3GvQ7FHCBwaMgAWPL7/JXtYznJoen4AVmoKR+aldB5
	lNfF/2K4MlHTemO/2Znr3PXKUlgPXjSCbMZNTlYfdvbigwXZrnLrSbbJTtgx9GnR
	m2mVwnK1Rx1MtoLlj5uRmUi862Nb6yFoR2ForGSzJQeKJoqrwEyM4Dyhg7IkWWF3
	gvVpGa0FEx60RFTH12Yuo/MjRMq6xp1NcdIV8CC/CN2uv/0ZzZMmcv794Ft8vKsP
	piC6jSR0Wo+XsWy7ntp2tqnXd16rI/XkoBMn4Ip2Ao0Scuv0tT6CnlTauOwg56Di
	qfqap9wroFEX/qVoAGA3G0CFWOeCvYPKenA==
X-ME-Sender: <xms:ba4eat8viulCZtLwNsKEsFHTmR49KYSkHFqbaCJ-AlgJXm_nJ4mstA>
    <xme:ba4eantbAPN3R_jcuS6sJJxlnSuP_-UcpEQMTmmMnn0FjqSl6hF1sbYTS6lnfyJFw
    thFRRExhlWqtEJPv4ISMHjnDPRyZXedZbnBWTYeTKNvekXd1SB6qg>
X-ME-Received: <xmr:ba4eaoprBP3dCGqzDCHX86jkF90Y9a-W-tasYd99PK8PVNwg6GV74uzatPpdJIQeLbpaxhUzFJiU7K_I2I2StxG6pZ7iCEvYWYz633QomQ>
X-ME-Proxy-Cause: dmFkZTFoTvmAo31qfhrzCmy1fsfgg2jpREthgk0XdheUjdj+xdC8QHOOIZppES0Oa4xaCe
    Q+obQisL9x9ioSYCKlS8+0pvhwFuzDp2HfTG7xcuKpC29lsoSnV1aI0ywlxa/pE2uvLwpf
    csQqEq7lGrD7reiEYUaDjWMhzvo7L5pFvsHMJNxMMXyA8DQ7M2KuFqzc0FVpUsjwwSqwco
    K8ybqSRK3L7MQPtktdvQapdtEOqSZ+HswTpJuJdlFgvPObbWcVEXSYJEwn1RXUMHZ/8jqi
    KHkIyI1cWErasEvLQ2yOO2IECKCjTHDEIC2X3B4xXe12kRafSshB5kjLpjIc3UFuL1mJfO
    jibMAXdFaHiKUd4jOt3dgwrcr7mLAsnFxuxK+TBKLsISoKlunPbmMI943eNgcpcnKcaOJl
    j/fFk+px2SG/PPJliU9AX+qfHF2PQA3/CsZ9WKYRAeLNzEYC5e31HT9gwALiP1kf8QxFHt
    9HoQGg1naNCoFlIdaUZYoVcAfGYcyCSmQocq3+OfzAmcqiYA+kVIXUndcGZdZTkwrYRwXT
    L4BGHV/140nmNcXF2pH29yl/5G6rDzX6A4sXqcWWg08QDIFYyC57d9FQwYfvsiyMS5kCfT
    DNPpT/iTuLpXNu6L5EHPdykaIKn+SMzM8/6z5pwbzDjBTlXJci08fJJDCSew
X-ME-Proxy: <xmx:ba4easkOkqo0A5SLFFPZoT1borPRHTUNZM8m39Q3o9ejT-GIwAdw4w>
    <xmx:ba4eakxfi7KJ8brR7cngX9gddKarbrP4id0wKUfBSRQB6ejBrWSueg>
    <xmx:ba4easnGnZxLs6csICYd-WzU7J5xyvHZDcupvJGiNHlF-k85OeZ9pA>
    <xmx:ba4ealfsptqIsmYsmhD9KrEv8UoNUfsAiiCnEgkdKr7GvIS--MpzwA>
    <xmx:ba4eapWZJ2iz0wh2NPeOcfSX2KPWBpqiyxF-IENeoB3-6deKCpLJun49>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 06:20:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a3527d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 10:20:26 +0000 (UTC)
Date: Tue, 2 Jun 2026 12:20:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] t/lib-git-p4: silence output when killing p4d and
 its watchdog
Message-ID: <ah6uZ6tdIh38X2uZ@pks.im>
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
 <20260602-pks-t7527-fix-tap-output-v1-3-db3da2a1b137@pks.im>
 <xmqqecipxp6g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecipxp6g.fsf@gitster.g>

On Tue, Jun 02, 2026 at 06:32:55PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >  stop_p4d_and_watchdog () {
> >  	kill -9 $p4d_pid $watchdog_pid
> > +	wait $p4d $watchdog_pid 2>/dev/null
> >  }
> 
> Shoudln't we be waiting on $p4d_pid (not $p4d)...
> 
> > @@ -175,7 +176,7 @@ retry_until_success () {
> >  
> >  stop_and_cleanup_p4d () {
> >  	kill -9 $p4d_pid $watchdog_pid
> > -	wait $p4d_pid
> > +	wait $p4d_pid $watchdog_pid 2>/dev/null
> >  	rm -rf "$db" "$cli" "$pidfile"
> >  }
> 
> ... like we do here?

Oh, good catch. The statement basically doesn't do anything, which isn't
much of a problem because we really only care about silencing the error
message when the watchdog is being terminated. Will fix.

Patrick
