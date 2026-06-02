Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C630148A
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403691; cv=none; b=sc2hDslnRaQpCEY97Psdn7gI2MKskmPnSV6f4F5hosouf/NGPgK6vi3+tcXMdbstdeJKYwyM6AtJSRq/sa7YjutDA993z7uQUJZeAAeGKUaxvUePZfNuN2IUNIGu+9ngbQ3/kzaET1VDEyAgiEwobVOv1LpbfqLCv1RCW6HAwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403691; c=relaxed/simple;
	bh=tDewNAtPBjUWvhygOyYOiQWHIuIwsZpCPSn4Zxs8Zis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evFfzgaaVSe8HAurigfY6pHi8Y5+HW4bvu18R1ihqCWjJmvqfGY8G7exF/9AL2/Y2ieegwAZ619w8R5KVj60kbnoPwybGfYdCwbPw7wRxnIwm95NNk2HNX/zRrPuu3wU5am8qI3zpkxfZnNqvHIFVLOr8w9YRHd5w7WEAge6ryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=drOsKuHU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QwzgYEV0; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="drOsKuHU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwzgYEV0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7CEF7A0136;
	Tue,  2 Jun 2026 08:34:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 02 Jun 2026 08:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780403689; x=1780490089; bh=qi9fUdyA8X
	OEarH4SU5EKITQOod390UVOxh6msS4pt0=; b=drOsKuHUF9nZxtUaqUsaxjQTl9
	9kTQ8kkpSMrEcdufLsoRLg/rfMdwRN/QOsIO1NGUfg5zUoBIsaNhALJvNe07zryP
	tIvlh4miNwNoHW/0iLie8jKIWejS4eQyVvAc2lqI80hF5VjWy8oiJ/XOFkQ9750M
	DHDKj93DTZiDdEftdPWojKfytLU7ilResQ8yaKcnWvwbjWa35WdoZRYmw0L9Jij5
	mL/FOj04+8a+onLDxJ5n0FYiz4noEh3p9KdMkkY7mh3viYIUIukYH4KiRHeeJfQ/
	a6oVkCKnqxqxUdZr2hdJ6KUbzObchriGy534y9ePq3ck4umpgPDrpU6/clPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780403689; x=1780490089; bh=qi9fUdyA8XOEarH4SU5EKITQOod390UVOxh
	6msS4pt0=; b=QwzgYEV0BtbrfKpNS+QCGyUrI4m4RRnvVHbekc/SqR8bK/XVOvu
	bgQBp6xl16BLLi5Nxrobpmaj1tOY30SlaGzy46s03dHdFCh7ogJxxptkVAkZqswO
	e25sUXcb6nrPeTyp6wa9V3kAlLv9ahS3jKNrC+P5hyZ9QXjTsEdPje0inQ24A5HC
	sxmhqcHUFPp3Boxnyv6MYx1wSuJpTSwnuTAU+/j/8F2U4SKEAIfbO0jbb/JTMRum
	dX2VbRBWGmbfQk88zaMvwh+6/NV74icOwYBukgKE1q/6r1kDBV+xtDRTrkL4ediz
	di4qrFRIsXKQlB/nMFUAU8T/vGgKAavgYbw==
X-ME-Sender: <xms:6c0ear0Tsq-GOHYfV1BFXYIgGeslqON3q7dGVAwQGxxTO37iPyvrgg>
    <xme:6c0ean5D6r3FiyF8Kt_fqOGDokVNsOtgt4zhg3I7_rg8AzDNyvreczzVkdOUYs0xu
    tM_bc6T-Zp9m_nBZxdXKF8DPfxdl7i0FpZX1yNWmXBeNij6ZdZCIsM>
X-ME-Received: <xmr:6c0eamUmy37DkLbYXPiyrPrfsECN0lsT7odubAqzWp-HhGqB16Awm5JQzzLTmGrC8WBKJrCAqFmJ5UgS9nH8u3Tl4t8mb-H9fCdh5i3yMQ>
X-ME-Proxy-Cause: dmFkZTF+YNcjZsoyG3EwJ+F6yk4hRKmAHugNq3ZxGbHWmo2CoiP6nlorVlLhHiJlmmLjA3
    VVZP9PYFsjJjbWWYRVgUqI++LwJqu6+zqglyIn7sCQXYKcFBg5h1NLXKdWSN6bZS9STX51
    tqnIu1rdV1fVjAgDlUQUddyA2nEpC5+IhdlJ5NBMpSoOTB0uyjYI1rzLXF/JQ0gpwaOvK8
    UTar1+Qc1/SSoVpeN5h4fnpM2TBSD1pn2Kn45V/to5imElB6cMdggJEQ0SNXF9WuLGlWxd
    XXMVL/Tmc5Yi4L81QWfPLJsPRCCbig5Z6j2ay+XTwPXBOdNpoXUfxAJHmdBoKFVQRZZ0r0
    tuyGuVkfcXrF7YoVfAdhQ6hNBadp9fSiZuprGzMD6qownuP11bBsQ0gghHDpeQqwaI4Y3M
    AsdAbtrv57KUzN0c21VM1/tZjrTRC08j4MRgcB+GVSfwJf9bFxnztqwKIruRlDGHyDBp6i
    zv2r4EKe3k4VW2ZoCalRWG6R6u1heQvDq+H6vKeD3YZMrgRSncXe5xdqs/6u2iTmffZo7t
    VAsy82nT1ViSKFsYvufq6PQKX8q8gCgJGbloCiSTR0lJdwyZbfwI0rHCPE4nruBu7ytJak
    LrQO2K2DE5PJ516a/oYbImXuwn3yWbJDFyvklvURzcvd2RVlJt64Oz/PZU/g
X-ME-Proxy: <xmx:6c0eauBksMqqnITYw7xKs10xo4H60cJ2Mg21-ODN6fGHAMnwEQl_7g>
    <xmx:6c0eat5GJ46-kN9uBPwdVqYAg3ncrZ3WVYCweAoxVgzM6jJJml9IVA>
    <xmx:6c0eahyHOcRc3Pu0RpScziW796Kr8w1A-xVVKfO9-lzevRKyfmZVqA>
    <xmx:6c0easxBxLTIwQvEkMMJgD8Aq0hoXr8OQVy6e8tXtmdSAklkvSudpA>
    <xmx:6c0eao_U9noQTS4fJJWIWbNDBL5pdpd4VbehuFvFCmJzsOfWpRgiWIiR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 08:34:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 14a4653f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 12:34:48 +0000 (UTC)
Date: Tue, 2 Jun 2026 14:34:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Message-ID: <ah7N5bKAiAORtNkp@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im>
 <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
 <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
 <xmqqcxy93nph.fsf@gitster.g>
 <ah58IJ8DgSZYRjMM@pks.im>
 <xmqqv7c1xs76.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7c1xs76.fsf@gitster.g>

On Tue, Jun 02, 2026 at 05:27:41PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I wouldn't mind that outcome much, either. What triggered this series is
> > that I'm always annoyed that it's "builtin/init-db.c" instead of
> > "builtin/init.c", and the same for `cmd_init_db()`. But I intentionally
> > constructed the series in a way that the first commit can be picked
> > as-is, so that we can adjust our code to the modern world while not
> > doing the deprecation dance.
> >
> > So I'd be equally happy if we just drop the second commit in this
> > series.
> 
> I'd actually find myself annoyed by such a rename when looking for
> builtin/init-db.c only to find it gone---much like how a previous
> rename made ll-merge difficult to locate.
> 
> My point is that while static names may annoy some, renaming them
> does not resolve the annoyance; it merely shifts it to someone else.
> 
> So, if the primary motivation is just the first patch, I would be
> less inclined to support this series.

That's entirely fair. My take on this is a bit different, as I think
it's beneficial to accept a short-term adjustment for core contributors
in favor of making stuff easier to discover/maintain going forward.

A new contributor would probably be quick to learn that every
`cmd_foo()` entry point is named exactly the same as the subcommand
name, but they will then eventually trip over the few exceptions like
`cmd_init_db()` where that assumption doesn't hold.

But I can see that this is not always clear-cut.

Patrick
