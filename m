Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690D127E36
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264636; cv=none; b=cuI/s50Rm1fGLJLb1O/8iWxk8P4VH68cHBwp4hf8W4ze+dyUs1yiHD0tMT57lJyt9MfJyUxp3DGvrNcEnE+YAnbPAEqKr56ozW+C6AcSh10bPsROj04fyJHBghV/TnshgNbELvFtR81IObNgRqJfgsWxA2zdr4K7JKpRVleSaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264636; c=relaxed/simple;
	bh=gagVaBKiVKATsepIzvd+Z3bsAH3ggQlAtNNItfAMgT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCdpewmgjSX+ZabhfXy8itHbNBiiu2ER88ktNfOcwPYchemKX62ixu6c7zdRvDZEfW3CcTtHpGvN5b9231WSUjqtru3tSbkfigVZO/ardU1TWT0KwauKJ/HxpWphvVJGPdKXfbatMekseYwTcH6Bk5QDvisSu/NPyYDjflUD0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=mfHrLkmY; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="mfHrLkmY"
Received: from localhost (unknown [IPv6:2a01:41e1:2136:c500:8b0:fa85:2e1e:5dda])
	by smtp.roethke.info (Postfix) with ESMTPA id 795F51E0004A;
	Tue, 16 Apr 2024 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1713264625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDgvr5F8V9PfKCHZBRlL3R/TI1Vv+F0IHzna+zbC3Eo=;
	b=mfHrLkmY4RDHsEd2ytCFF1NSSK1jCXEymvDjkR9Or1wcsJRkzhmzvrpdE9yX0H+kZBk/8I
	amv+o/QxLRzGM56C9wRLQtievJQB/S5BrWldgjDy79SIuCkwlNZLx1I6kjoXLhK4wh6uaP
	ZQMdaAT8/v/hv9Th+YKiKU+I73v6eOBWRCAAVUWcYI+Ay7cXT20+pNQkQzYHuP7pwElBZd
	Q8YByoxy5/O8WiVVdOKE+OyllXlmSpmGhsYqnvqOMY+Brs+EjWkDi0Lx7EIIAxnSv07/I7
	wZYGZWwVGv0VRT3hgxTIQiDsn9kof2teY6ut2cOZo/BuVfH4pphNpUWYstKnN1SXwjcC4+
	V2dUjiFvlZk86ctY4eWbk7RomiSjsdPe9RZsidpTHD+MzXkcCXAaDw8Bj5ru3RiGH9YsPb
	5Xa3cs+qC8SyuIhiCHT4vCoIJZaOW4fNVp8GZ6uNOElAsbnbXDk0gnwBRFWSP+988VxsZH
	XPjM1TSH3FQJUmNRzglcbY0lJeZJxMlZz6+frcSYXH+6dCP9luGw4ZAHAB6HkHunJqb8KP
	TNeh7g/FOFzE6dcvYazXpBVSqtVwYT0XHm+/64SKjzbCbkx/vV7g8Wq2/DvJZxb8aBRZJR
	cD9TCqtlyDXEOs8ZTymQ6x/PW98u95eB3pjGFQNcB4v5xGZRAgx3U=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
Date: Tue, 16 Apr 2024 12:50:22 +0200
From: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] rerere: fix crashes due to unmatched opening conflict
 markers
Message-ID: <Zh5X7rKXCkDdNqgO@roethke.info>
References: <20240218194603.1210895-1-marcel@roethke.info>
 <20240409121708.131542-2-marcel@roethke.info>
 <xmqq7cgymlg8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7cgymlg8.fsf@gitster.g>

On 2024-04-15 13:15:35, Junio C Hamano wrote:
> Marcel Röthke <marcel@roethke.info> writes:
>
> > +test_expect_success 'rerere does not crash with unmatched conflict marker' '
> > +	git config rerere.enabled true &&
> > ...
> > +	git rebase --continue
> > +'
> > +
>
> This one fails, either standalone or when merged to 'seen'.
>
> A sample CI run that failed can be seen here (you probably need to
> be logged in to view it):
>
> https://github.com/git/git/actions/runs/8694652245/job/23844028985#step:5:1894

Yes, sorry that I missed that. The last git rebase command in that test needs
a test_must_fail because we expect a merge conflict.
Will be fixed in v4.
