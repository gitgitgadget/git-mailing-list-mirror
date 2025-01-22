Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95E1DFF0
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737515316; cv=none; b=a1r/KCQ4o5whKW7EZ9o7GVc7iqISgy5TjWaZeHJ8fweR2YUt62+aXMIGnWeEqaTnAbX2Ky5lkXRVHeDbbSve0PoS126WywN1etw6meIjTRcR5Dr/WDl3HZmFVTmtrby9SCj8Y1Qm/f9dAgldhNtz/kk54I2TBDUi74tvDIzUaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737515316; c=relaxed/simple;
	bh=NHoPZ8BOo/xlwLHF2zbPhBXet3SVQnz3KDU+Qx/ozDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMUH55QPsrv0jiXZvbPTKAXuTqrtsPdVfmhMAMpWzYo0Vg/pQcEvZLSukgAXwfaUJYMxlSTblPEogHCBL4YW16/KGIw7PSlvnCDUvx4750hN3ggjEKnw69wvP1/4X+YDGkIqaCsuaRegQuEOUv9V9MNUcSG/0/33MQyYJUIrYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b09NiyD4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b09NiyD4"
Received: (qmail 5008 invoked by uid 109); 22 Jan 2025 03:08:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NHoPZ8BOo/xlwLHF2zbPhBXet3SVQnz3KDU+Qx/ozDk=; b=b09NiyD4uIlKn3hp5i4m4HW6blupnMurXMYEUJZDzTYZVg8DCIY/1n/z5h1KxnlXE8dvjYWBotzwfAZD0kxj0xY0ZhwA60Rg1F1e3b0yUrufz4lTEjCYR75egu//HWNsyuFx6rVc78vYvlH1elv7nRu/mF/ErLWUZ/fObGAR4dSKiSqnfy/yiTiDCpg9X42hxadhnvwqbR/CSFLLgl83BLFd34lRXkanZdpmcJ7CPfVnRmeBQd1w3hqjKBJ6q/jzfIVjJEF04CwqLlwqHpFu2Dg6rScOtorCGri+PxDeVN6Sss8gaKAvoE3B/sUxvUurQ08/HL3Ttyu4VipZJQ5dmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Jan 2025 03:08:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4565 invoked by uid 111); 22 Jan 2025 03:08:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Jan 2025 22:08:35 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 21 Jan 2025 22:08:32 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Christian Fredrik Johnsen <cfj@johnsen.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature Request] Allow batch removal of remotes with 'git
 remote remove'
Message-ID: <20250122030832.GA3322144@coredump.intra.peff.net>
References: <DB9PR05MB110863344D3776D13B436F563C1E72@DB9PR05MB11086.eurprd05.prod.outlook.com>
 <CAJoAoZnecm5y8243R9JsGjRDuv-Mb=UAwa+Hbj5CKDKNPBLB4g@mail.gmail.com>
 <CALnO6CAEaOUNwMpOTF8wKVd7LAv+UiU5W62ZCBc0U-K_JhHU-g@mail.gmail.com>
 <Z5BW5ofJVbM1obb5@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5BW5ofJVbM1obb5@tapette.crustytoothpaste.net>

On Wed, Jan 22, 2025 at 02:24:38AM +0000, brian m. carlson wrote:

> Because `git remote remove` will remove remote-tracking branches and
> their reflogs, we typically will want to do that all at once in a single
> ref transaction, and hence in one command.  Not doing so performs very
> poorly (as does, notably `git remote rename`[0]) when all of the refs are
> packed.  If you have a large number of remotes to delete and a large
> number of total refs, this will perform really badly indeed, since the
> operation of rewriting the packed-refs file becomes quadratic.
> 
> The removal of the remote-tracking branches is also the reason that
> editing the config isn't sufficient, either.

I think the config update is probably quadratic, too (in the number of
remotes). Each one is going to rewrite the whole config file, minus its
matching section. But a "remove" operation that took multiple remotes
could do it all in a single pass.

If somebody does implement "remote remove" that takes multiple names, I
hope they'll refactor to do all of the operations in a single pass, and
not just loop on builtin/remote.c:rm() internally.

Probably git-config could stand to learn similar tricks, too. There is
"--remove-section", but I don't think you can pass multiple sections
(and it's likewise quadratic).

-Peff
