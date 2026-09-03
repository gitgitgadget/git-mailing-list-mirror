Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E94E80B3
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470008; cv=none; b=VLudwWSu1bNbkS+XwHxO9lypV9UfQGk68iXSuGidlypBWLVFRuWiSXqWyBzf2oMwjmdtLLrj6vkiMrdzXhELTM2ZsGRAJUrJVa9nIYO53H0dh35Y7WTT1pq0EkoCOf7tsxC1OI5gia9JvLRFU3Q9W1tneeMhatosH1tdx6l1mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470008; c=relaxed/simple;
	bh=H7x5u9/EczmnvK15iMspbYKMz6KzIzSDJ+fDiCLjfnY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=EIK3+mNqGm15skD0QLjirpAnMe+vS+QjQYbT8D4qrQQkMjT1m2HXq90F4mwhaVCW/YUxuZBv3Xa44r75y2GGVBdOKqErqv5jNbkzE44ZOqIKNM5snYPZa1Q6Ebjbr/lh0FvTxLtKQXGXFNZSeY5q/sl1fean5NasNXxtpukJsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=VcNtHhqb; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="VcNtHhqb"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbXPq2wflzMlGW;
	Thu, 03 Sep 2026 23:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788469999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7x5u9/EczmnvK15iMspbYKMz6KzIzSDJ+fDiCLjfnY=;
	b=VcNtHhqbDLJXjXJj+ubS7wgGYcN0tMmwOcy7mw6ZmyM/cnn/lZkClYeEaIyg/ltA+a+Dz8
	aGosd+9vJtGJT8a/avhcEnoLzddgDXLyfrci5glf8ejP19N4YdAhoWCQ4xRJEMoHPxCh4t
	zR0PQ3k5jGpu52xigdvbrpyY5NBsdZZ/lU7iFeZdbOqi6/0QvBc6SOpsyZs5sdGxhoxjCH
	cvYMpJszaUwx8T76pBY+HQARzYJVdz/1rmEMJzmhBDboBMyg4LsdTpxTa67hpQhNOQMkQq
	GAbDP6IAsgQtTi+3i+EwGb42dwlEbAksrGvGHD89KocO7zmpldjQUfAc9Ggg3Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=dev@ytausch.de
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: pathspec: match and original in pathspec_item are const
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <xmqqa4py9har.fsf@gitster.g>
Cc: git@vger.kernel.org, dc@diogocastro.com
Date: Thu, 3 Sep 2026 23:13:07 +0200
Message-Id: <8D0EAE11-B582-4C0E-9195-486FABF83FE3@ytausch.de>
References: <xmqqa4py9har.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Rspamd-Queue-Id: 4hbXPq2wflzMlGW

> If [v3 2/3] and [v3 3/3] are identical to v2, just telling me to
> ignore v3 would be sufficient.

Please ignore v3 then.

> If you need to make further changes, a two-patch series v4 on top of
> d66ac2af30 (Merge branch 'jc/pathspec-match-const' into
> yt/pathspec-negative-prefix, 2026-09-03) would be great.

Many thanks, I=E2=80=98ll use that if further changes become necessary in th=
e review.=
