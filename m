Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03763D965
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520748; cv=none; b=GNNEYtGGf9RI28DWdb7X0HC6+Y3FjWSd7BXABHWDw7GcZ3iUXFNf9EB5uIzGgy3SqORpgKJihH9Ihdzp39z/s01PzqwAyzIHRdW+UrRxqQ88sVaIUR23aL8f3zB5zkdE8hAMzUGQkvQpCnY4+YVmrheoGwPWLbacqxS5I7h6dwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520748; c=relaxed/simple;
	bh=6yLkq+Ck42PztWpJrqfec60vWHiemiPR4BWeO3skeuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzoLN7LM68zyoUP8AZRXv3yBBPG+mTad/B1f7s1Q4p9pJeuQAqCc5ts7vQD1CaJuGMW7CQp1vDt68u4oqc9LBpbQO1oFmUdQvURcrMA3hVv11869wX1XeneZr2zXdfQD7h67FtVYLhrcjlO0C9SKckncCY5j6iW+JfCks5BRve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=rzRh/93A; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="rzRh/93A"
Received: from localhost (unknown [IPv6:2a01:41e1:14ab:6800:1ddb:707f:23eb:2a8f])
	by smtp.roethke.info (Postfix) with ESMTPA id 84A0B1E0004A;
	Sun,  7 Apr 2024 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1712520743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yLkq+Ck42PztWpJrqfec60vWHiemiPR4BWeO3skeuc=;
	b=rzRh/93AT6jLe18W68JaTY4/+aNBeI2QcgD13t+1zwhaCFiF5Lh/e5ZBvzRR4P4oS3HQc0
	QZoPMZR3mreVBTzy+R1XLs8Tp1jxsHtP2VHBnsi6PLOW+Ntlys6EzqxmWh8JXKgpbt6BHH
	DTjpegUZBlIuysBZdm9ZoPKAs4aTFswDk/+D8C5+ApwzPvqdydsYxf5R4/6y/622xhNxVq
	lzQN9RAdjOuyKKMUBixJDlepggVSLYOBFceweQ4VmtMMmXg5WSK2SdNGbqTAieipo02mTg
	JY243EPR2rD2lfR1NPNQ6RLnrVeia9WmFpdItl2lNJDy9FkQRbBIDk0hvecfahIP6PI3IQ
	doc/5gMxzwBlNtyFNp7zCIvl0bygQCHjvUxGV4/Q4CR5rxJzHrIGzUfk1xZC9imHPQa0+f
	4locc8tFPK7FfChBuocn6ZLDUjPz5ZIglK6tCMBBHlMXDZO0EdthsgYtdpIZ6ifecIXYHA
	Xt6spmYBAHHTyuUvJuGEkY4kgoI71hH6UbU8BZ6uTCHwLs6CEKtay8DVbDFqymZVpSo6xd
	ryosXXYPr1D7iWu5IyCvknn440U9jMtMHhan2ChNCvbz/Hw0mFrSlEj6HEPMfJzmQ9Zpzr
	aQ7wPZZsQ7nhXB/H1YSAq6SG8jiqBjJ+/0aTEovnUqlBLi3PSuyhg=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
Date: Sun, 7 Apr 2024 22:12:22 +0200
From: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rerere: fix crash during clear
Message-ID: <ZhL-Jt_Nb5egpKfx@roethke.info>
References: <xmqqplvjpacq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplvjpacq.fsf@gitster.g>

After reproducing this without manually corrupting the database, I
noticed that the summary line is no longer accurate. Because it fixes
two SEGFAULTs and one of them does not happen during clear. Can I change this
in v3 or should I start a new thread?
