Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66053314D1D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382762; cv=none; b=SbzXp1j7x3WcqSJGQI2o0NUT0tzJmBcWqv9XbLO1jaiQm28XbESL4mSzAQWpCsCVrChrhmaZElBkg+1hLWOmDij22lcNs11Q+gBlQcN6JHGkhTIqjlPlMSsBvlXG+mHYe10oAuCKxSAH86qnggC03VgpEdg07T2GIREAQQOj3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382762; c=relaxed/simple;
	bh=K9WrJeX3Q+N51UPKshpYuz2aPQUXtjZYxu2I/yrH4Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+sc/w84d1rAiw6Qk0E21oR/QbMsVbpyuUL8YxeCSc2qWI4FHNGqUXmnXEjGBam8nPtt0sUwOW2Yi1Grx8aYaQMA67KUw96PPfYjs8P/tV5FsdOJX7f3jfgs3J/ffKuA4pspx49yQMzRAvGGSmgSSS0dn/ngrdm9AZyaa+Rzq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I5K146VW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8TyIy+0; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I5K146VW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8TyIy+0"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7848C1D000AC;
	Tue,  2 Jun 2026 02:45:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 02 Jun 2026 02:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780382759;
	 x=1780469159; bh=/WFlnzleiuAz2Ji1SUxmKY7UKZhQZKRQc8hIwKrsrWo=; b=
	I5K146VWrB2Lns9Wq8xmNgQbLQvemK/3hB380fKPUqzfLwa80OSQdZlxJCPZZPsx
	HJgVKsNEbcGRMI7zh9Gb/HhN5chNrlnTIMJ2cF4Za+zZtNidIc4EFbzAIAZwZj9P
	/1RDR/tqGq6lsFCASSOQ//8YCbpNnxnAAj+LH40SVZlZ0OCGIS0Owh3uMq7nKVJH
	qgRA8pMPzmEAMmmpQzirN4YJis6oIDvbI+vKvhGIMfH8s+FKTleA574b1KmpV+Bo
	Zy6J5VBmHqraagbEqyEl+j/fOsqVztyTTk00iR5NcNV4/MxWbmXloFbost70Gh1l
	bBJ8RPyEcy8rk5mZ+7xLRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780382759; x=
	1780469159; bh=/WFlnzleiuAz2Ji1SUxmKY7UKZhQZKRQc8hIwKrsrWo=; b=C
	8TyIy+0oK1QAjYG8UzWc+sfzkotSzy+EGOzYD64a8OA/wWXtnmK9l1kXPg5zGPn0
	sFUXFWY0OkeYTJ2i7wBA7SmMXX9bO8I0W1EmL80rSzlHlVcbuEK6ODmWmSUl8D0d
	fWrLkwYOM5IA/ITkQ2IMjHSGFCh3JOKquRGsjvdedF5QDEPUDHFL8yk//VzJINzb
	qiUTHpHM+N1TpyuF0pF3O7C5lCkv41TLGDAe/vh4tZfqO3HLP1JxrbIyKe76DUEI
	79sGkbEogUBqVrVrXW+ybsbqA7XUxVFVtT3rsEVqcFx72h50aYvpU1AGsRmH16De
	afpOIyVw2Mkn8NxsR/vpA==
X-ME-Sender: <xms:JnweagN0Q9qCRJhO-PXcvsPf2vWvXnrM13fMyP6b97Tv6j0MnJNf4Q>
    <xme:Jnweakwl1-6CLKqZt1E-Lzq4-Rbvc9dUQ0TjwcfHfkfXhjDPB4ysAdrENpW7JpaHR
    ZOQrSRckgVJRJDSFus75x_Mk9ZbJGs6p5pU2a1qneRVeORyOl1V>
X-ME-Received: <xmr:JnweahtfbvQeYS4KqSY5yQkuKARkf033cjtWt8uKXaJss5pZO_ru5ak1C5gC_mlZ8luIERS0DO7dbiyS8zIIYD4mc4ddtnAsXH9sa8LKZw>
X-ME-Proxy-Cause: dmFkZTFnw0GnJ4ajDcEPYFmjaytYUcdAABSDwDbMXoZZ26rFYpNc9Ou0pyUECqcnUtKMtk
    yFFpnC5F9/nm/YvRS/9lkuZSvPkbQRC3qwObtimAITdvzAuJHXg9t8gB3wWGmzgjg+59fj
    dLKG13KZ3sphwWVZYqzPyvSYE2Ia15EkAlLCCNxDjOcAn8qsoK1HkMnK9M3Wfv/R+/ng/r
    WuhDQQbfWaK58rODoPjnoGMH+HuOKRiIE7RwRFu0UcRuRNhtLb1uEPn8XEZjNM6+SsgwtK
    UDzcmh2z0XXQqQho5hLuH12cPXuQXXAgphJ6pSJVEJH+SJEvT2He4gaBki2Jjo996F/vaM
    9vSH5AUt28ozzLoXi0WPL6TTixZeNb3pvKff1H8yYmrDZwWHWQqE5l9LT7UD2DDpC4j/yp
    O+SEpDHP38FWYpYYv3SnxjiEcE9/K3+oFvKjnzwg3TdAGHKJA+lMCVPGD/f2SthMy/pCx7
    XU4mOkvS1nFGkawKZs1r6eE0l3W+7b4R0IOLAwzQX2XBqCItUaa9tgxmE9XeaOPE80oHfY
    wzx+SnDPv2HxWBou4FCtgL81cNY4j+F8tNjmGol7iq8VDlCiWig+/w+eBAlU6d2RyDQ557
    i+Ss/jISKq65DzI36QmEOBVlRUpTG3yEqRUFJhpFGlMXH/W/pY8p7J0UYgew
X-ME-Proxy: <xmx:Jnweal4O66FqvapltAV2Yc8GoYddYhdr5PllwpFBZdLKik-pemU8hA>
    <xmx:JnweaoSlkGplCf31CSlUEItCmiYF1LiDDlKf1z9iFaMAmgm5ZUbmGg>
    <xmx:Jnweasr3J32YSSUolkonvubq38bCd2fJVCI_xW-H1LiseDnovqm4yw>
    <xmx:JnweauKP7m_L-WoWLEhh0P2GpN6jScE0wRWkcYqyl2chXyjCAVaYgg>
    <xmx:J3weaiVXHoJ2F-59HvQfr43m-AFska0hXQf_TcgKFGnAyFSoP_vxeZq0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 02:45:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ad23f66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 06:45:55 +0000 (UTC)
Date: Tue, 2 Jun 2026 08:45:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Message-ID: <ah58IJ8DgSZYRjMM@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im>
 <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
 <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
 <xmqqcxy93nph.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqcxy93nph.fsf@gitster.g>

On Tue, Jun 02, 2026 at 07:22:50AM +0900, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> 
> >> I found it to be a bit heavy-handed as it's so trivial to replace with
> >> git-init(1), but on the other hand it's a trivial thing to do.
> >
> > I imagine that most potential git-init-db(1) uses will be buried in some
> > scripts that haven’t been touched in years. Then the Git init might
> > fail, you get errors about git-commit(1) or something not being a thing
> > you can run without a repository, and it ends up being a headscratcher
> > since the original failure gets lost.
> >
> > All to say I think a simple warning would be nice. ;)
> 
> Or just leave it without deprecation.  It does not cost much to keep
> "init-db", and because we expanded what "git database" means in
> later versions of Git since its invention, the name still makes
> sense.  Thank Linus for not naming it "init-odb"---that might have
> been a valid excuse to rename it because it does not cover the ref
> database and config database and others.

I wouldn't mind that outcome much, either. What triggered this series is
that I'm always annoyed that it's "builtin/init-db.c" instead of
"builtin/init.c", and the same for `cmd_init_db()`. But I intentionally
constructed the series in a way that the first commit can be picked
as-is, so that we can adjust our code to the modern world while not
doing the deprecation dance.

So I'd be equally happy if we just drop the second commit in this
series.

Patrick
