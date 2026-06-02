Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA173CC7F4
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401222; cv=none; b=R/TUha5pwOS8etCq91fCh+Hi7lfbFrynmuN+b2IOuX6GzButYzJrU9CYY3NktnZI/I9G6N37VWzmar1nEoprh4gitdUKKTatmHSXTj9N1uUjqQGy0grAS84+nguexVcu37tEBLtpvJdaVRvtxE8F2o3ps8B04pcDxFEKk+yHkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401222; c=relaxed/simple;
	bh=yN5HCJzz7xrRwryAsjuZDwZ2BeSL/HO6WvRAJMlWyvE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gz8TI/sn0PVj1fAoifkKtfNmy0IH1MVUJF4TJVKjvwmfuAXitJHGOoADBFs/GK/pp4wtCyWpjcXVVWGwBGelYwJTvd6YVq6qdmSN0E/kyEvXyEp12XcOkyJBTZmhOYS1bgvW/RFv6rc3sGQJWdlIn4HckXdu81jqSk5uBTvv9Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qe/SmK62; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGrhUpi/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qe/SmK62";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGrhUpi/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F76E14002AC;
	Tue,  2 Jun 2026 07:53:38 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 07:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780401218;
	 x=1780487618; bh=c95nw1dAD18/FgeaqYdg/XfCJ6gvIj0sOeG3R5QgBiI=; b=
	qe/SmK62hu51uLSGlaOT6Fsf3/SEpSGh2k1WhmIc3S0wJyD/K8fRH5L2QQGtusda
	gvJ9DDRewbGpy+dd9dUYVsTB5wdbYftHJ3JS7VUHdXEk3caSgbWqkqPalNmB4rOU
	gMZO0WuKiTPPolOXyXnEFdLl/dII2DZXVfgNNJBgX+Muy64qZ3IILlsJ7edCy2cL
	pLlaUWocK4ErXTqo8Pvzg9TblAmcYHtUJfNyJdLpQvnMAvLXScHNzxzNGbhPWU1e
	ZniWVUhTEoVc4yngciN/rdvEzHvamojw2XCFWgKpt7l8hYNBaGmPnGjVdOg6XHFF
	uEluWifbktM6VZzGUCXd2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780401218; x=1780487618; bh=c
	95nw1dAD18/FgeaqYdg/XfCJ6gvIj0sOeG3R5QgBiI=; b=bGrhUpi/OHAHPqFGq
	MZ97epk3dBp7r0/5lFyAI4KxzK+Mn7cMbMdhpB5LCWug36QbJOZes4Zx+N8Qb5k5
	zwWvcATRA0EN3lsCB1OIjZfmVY/+2xNQI8goeYaS3D4xqThtE+HI9kByVYIOp2om
	UQ4qMe1P2GrUGSGDm1iE/VivDO5zOib0dkELY9n+mGci5w8tqf2h4nIEz9x9zr8j
	HEKz0w1oHG79mzpYIPG0tXJPGQDwCzpwlpJ1kck0Rp8hsHwc+iF22Fui9XG+VVE0
	RzgBKTmRmeF+fz7H++5amvdm0FtGcExHETdt7F662eval6eg951hiPUb7uFkamJ+
	wZfAQ==
X-ME-Sender: <xms:QsQeavMrMK2iF1zSoBF9mJr6FTP9RanVWQkmAroK1QdUPo5reiQhjwE>
    <xme:QsQeakzckR6XFAUHGHCas0OpDgoCS1fwiiFF0quvjTsdPaQXOn8oypuK6EDvhfw5Y
    mCLG4_5zIAPMFA3-HoFzszRbly5x0rW82ZOT6fGuIZtlqb3krIKgw>
X-ME-Proxy-Cause: dmFkZTEnFl9/2KqdG+LZk5D0rx5BcluWpADOfYXVRyE8Nna7Lf6W95jjS92TmzOPcR9Npq
    jHIMrVXJoXh9fK6ZExgLiPUi5No7Oe0WAZRSrUx08jZEimGj4gjZyjbtT9Zwc4H77FesOT
    W9IEHaH6MdfQ0OYbEDjUHQuqLDG0c+yLuoDyymDTpPMhDrJMkh/DK3DK+y4LaMfdXzaA5Z
    910vZYpkMgWAeJTSsDCMj3v7ePoM+RH55bYoaFW5TMOYz+8KivfmW+brBy9OntZBcxM1bm
    D9NcV9JVNneWEwGA5P9ze7KI0FfV5jmCHeqdhGvOlXwSCpJ7aAVKtTXVlnLjy/imBCttY+
    oSOo6gXjiksgxf2oeCo0g6MBIUkC9S2oVs6hpBtZubuGmzuOeRGX1LIUY8Yy3flKhGOvsi
    AdnLcIt2nbwwEncqjjQuPiijXmibnb+LGe5kEUGn7S3bP7Et7Ul8BMSSLofhddTEXINtEL
    ZMOiHbQpX1Vhc1j5vjQNiRCtGWlUiM+Ss6ex1Z21fXVpc7xV7sYDKYRy/VrgC3qO9upD0K
    OMoP1M9iODeo/4wqWQxkIxH1vdkq6F93fYTDQZ/qZkglkz2W+ucZRMVAyuqOTLjVqu1hS6
    n93tQpGTKFNkj+2QJgQgRl5xxJuInpAZDrU3WxJvuOYZDGqJQvw3mjJeIatw
X-ME-Proxy: <xmx:QsQeat51-V5vIJqdkWEtOT0oVjkDQREz8ilTslaUP4dPpyJzesdJgw>
    <xmx:QsQeao3snuSqf6YY8nqI2XgTcyVSwvKjjEp68VbPyJbZvh3jzvFS5g>
    <xmx:QsQeasDj82GImlEmg8LnSaXZhkV-7dlgcLoipczy8GBMuYsuBW7ibA>
    <xmx:QsQeai1kDub9F2x3q67uPDeFRPI4vIlG7SOyqhTYopkTgTRS93OahQ>
    <xmx:QsQeaugib2F5lKLw3RIZ9uEBFw6VgjVYWGVaBR68iDEMjErL3aoUizNG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 749EB302008E; Tue,  2 Jun 2026 07:53:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A42lxKde74v-
Date: Tue, 02 Jun 2026 13:53:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <5203b303-e193-40cb-8b2d-3bc74cf77811@app.fastmail.com>
In-Reply-To: <xmqqy0gxw5i9.fsf@gitster.g>
References: <xmqqy0gxw5i9.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Jun 2026, #01)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026, at 13:23, Junio C Hamano wrote:
>[snip]
> * kh/doc-replay-config (2026-05-21) 4 commits
>  - doc: replay: move =E2=80=9Cdefault=E2=80=9D to the right-hand-side
>  - doc: replay: use a nested definition list
>  - doc: replay: simplify replay.refAction description
>  - doc: link to config for git-replay(1)
>
>  Doc update for "git replay" to actually refer to its configuration
>  variables.
>
>  Will merge to 'next'.
>  cf. <xmqqpl2ced7d.fsf@gitster.g>
>  source: <CV_doc_replay_config.709@msgid.xyz>

Sorry, I meant to reply to your review but it fell out of the back of
my mind. I will do that now.

I think making a second version will make sense.

>[snip]
