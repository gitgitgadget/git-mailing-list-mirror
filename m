Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDF30C154
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900469; cv=none; b=SGYFzoswEd02qF1PAm2E4Z4sekmPW9PIHhzocfEmN1yJk+llbs1PqezTSSUszfLmlAWioawQ3uPrTABvGW0L5Sb+KIooWEZUSG+36KMe5399A5ljC5mRDl9yL7ISss6shV7bxCkmnR3iCVxPKha7VohuJ2IAbOAB7lrIdhUCfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900469; c=relaxed/simple;
	bh=kY4Hr0mIFDRs5FzJLu6ragzv3Ne8OBX2JsN8jp19dUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLV1MfZcgaFpm2VIBBKxoLPelgZJjwG/BpFNO2LL94JZkPen+ewfP6y6Y+/G9kACKfdcz82TjzgVj2vYziuRy/uKoEFGJw8fVXdgP61ZLm/SGTTgnVRC+gqE8PqmLbCQuUZlBNfeEH0rg56Goy83XthTM7mYeip0j94rMxl4cJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gO5DUipm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWz7msVM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gO5DUipm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWz7msVM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A78F2EC00FD;
	Wed,  1 Jul 2026 06:07:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 06:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782900466; x=1782986866; bh=fjvGu5ABIq
	En5y/RWMbUGgkJOEr36bl7UPo8bfLZ4Hg=; b=gO5DUipm6j/S134TONyw3nKaLz
	9P9CNXpoxBkukDKFoZGJCG991zP1t6+YYjvKHAltdYNKl1hWygFE699QWXgTs2AZ
	SorUVLO/JP5PS7CwYouAq2JnHOS7RZkz7T/nkUE3JO2UjGo7s7XSmC9XBYOH2K1A
	CUrKfIs9JH2Th25DQt9hRnAJ+FFK4kOZFwJO5vXAMyfLHH3Na4jHiGlOkD7QLWRu
	aKhWWfIkcRuLMwT6omUPnYT9j+5klN3y3/BFJ7sNQI8OnQDqg0CiIn7QNV8SeG8a
	IDQ7JXH4AbsQIBKHnrVHglXkisbbKdq6S1jVjzgw6Dvp+PBAYhYLhv2hgqfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782900466; x=1782986866; bh=fjvGu5ABIqEn5y/RWMbUGgkJOEr36bl7UPo
	8bfLZ4Hg=; b=IWz7msVMop7cjSK/isbwzvZ8dodItzMNOiJT0i7IlznNc+wacn8
	NXORiqbi9mZK4GNT8v1Uh1Eg0/TnL6m8fxfes+r7lyIdTQFpHp2NED17Eum18Fwr
	oJy+uSP/HzTx9q11JWQxKG0CTtQemnbaLHFbuIF1Xth14qTnjl6icCJ0Ao5C85bB
	G/vGrIFpIhZydAJR5EnuEl0oN4lEhN3CNlCpJdJSQyFmmDz/o1A/ejKvYrNQ58Y3
	naPDj1U0dZvSPW94Sn6hJjCOKbxMyiOTPfFziFQKn+qIAY63N6uCzD5dPfw38Mim
	0XJ3cFmoINe7QJXGqT3aldEP1cBtK30D/Mg==
X-ME-Sender: <xms:8uZEavitoAIMYqKPz1CMdYBz45xLl6yLdNw1xVtJbK61WnXvsB037A>
    <xme:8uZEai7JgwZ0cnB_bEpNUu0itYYYj8vXTAGp0zW35srnBkMiy9IfJZkH9dgtOth9Z
    ngNKsku7TGLzsn8L49dA32wiUYnltnb5DzIAO3PzArEsSjBwkt0dw>
X-ME-Received: <xmr:8uZEanaPVio1D7kXLdgiSlySo2ARpgd45DfuLnY6wEkxyvrjugmMT5cUR2Q9AzjMWvY-kNBnjjLabOJjjYDFGLucVO1X9Y4gHbiEgkrrTOw>
X-ME-Proxy-Cause: dmFkZTESLDXNx3LTJIqvbCIFD5DELzY1UEELXfDaf1n8SBZ5fS5KujjUMp8JmPWN4cx+lp
    SyVC5c98GE2yGoSktmIPT32we6YHcktiRD2TJ+W70rAjGqJrq+3HHdFaYqPTcB96o6j8qK
    SECM8xgnX4Oz3fQJPPihzXsPaRv0+S4sPnGjQvEC4Oiy2GyFNgF4i6BDPLh13viXKMGa/w
    NXO+P2M3UWdN8WJj8eLGEqjhXwA1ziNA8YbtIVd5a99qaLb1qf61YYebQOLFwDnoKJ3k82
    /kWqQHVDszKIfOg4WghXe66eqyc0NjJYjbqza+q6AUnXs0bYdzRd4PsbwlSv845jw/UnS9
    CVZCk79vX8k0gOYaWnYxVbMEHJJlH28RABOz9pV6Ok3+dS3uQYs//hlp4sQw3oOvX9ZBM4
    /nMlpD4TxTIY0GQj7v1q8PvNy7Qwh17LEfgcFDNaP1VA1nbvDA4rAxb5Gnni7QEjSEIFu8
    iVNxIJtjYILUkNHYe1VW36PtslTfW2LozW/CB6eoAFBC6ks43x4YNUpVvHkYF7Lopoikka
    FOg7iZtfR7A51qq1KXURpaihxRIWw9TG17WELxC8fb6NOFcn/Zo+UglMubZx7dZEJfj5JC
    6dy2pnhn8J1bV9FMwMvUJHY8TFkRZaIe3/XjIRODSGBxD+/JK7CvpJpNyAtA
X-ME-Proxy: <xmx:8uZEan5DKOZDHKM0D7fgFUJ6eSmSbEc5BRu4UyXP_uZf5YTkfBVG7A>
    <xmx:8uZEaqCtBd2VBWbiZnGGzIGJhV3vLs3Rfx1Ze-Vgzto1NbIYbR3Cvw>
    <xmx:8uZEatcG5QjaVt-ewQYnhQsnQ0B1GfKHUYQr8uxLoSRcJDfaGvjWaw>
    <xmx:8uZEapJbFqQfZ9XPSga24U9CFaFFRKYzNsTnA4wUyYWkA8Jwo6GvdQ>
    <xmx:8uZEajh_B_E6aqTtfoyW4buh19OdWFmmzEJTYrwcWqM6FOzGSMdhmyZN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 06:07:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73908625 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 10:07:42 +0000 (UTC)
Date: Wed, 1 Jul 2026 12:07:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: weird quadratic reftable behavior, was: Re: [PATCH 3/3] t5551:
 pack refs after creating many tags
Message-ID: <akTm7BDohsy85sN8@pks.im>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net>
 <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net>
 <akOG0oMu2KTqqyW7@pks.im>
 <20260630234702.GA3759976@coredump.intra.peff.net>
 <20260630235850.GB3759976@coredump.intra.peff.net>
 <akSxCUfm2P7ocLJX@pks.im>
 <20260701080014.GA3748390@coredump.intra.peff.net>
 <CAL71e4PfXA-ixKR6r7fu_7_QmdzK+rTRs29mOsUYKaq+_a5q5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4PfXA-ixKR6r7fu_7_QmdzK+rTRs29mOsUYKaq+_a5q5w@mail.gmail.com>

On Wed, Jul 01, 2026 at 11:04:45AM +0200, Kristofer Karlsson wrote:
> On Wed, 1 Jul 2026 at 10:00, Jeff King <peff@peff.net> wrote:
> 
> > Yeah, it is (mostly) the same problem. About half the time is spent in
> > refs_verify_refnames_available().
> >
> > The other half is in reftable_be_transaction_prepare(). Looks like it
> > makes individual calls to prepare_single_update(), which reads each ref.
> > And those reads are expensive because of all of the tombstones. It might
> > be possible to do an iterator merge or similar between the sorted list
> > of transaction refs and the reftable contents.
> 
> Hi, sorry for jumping in -- I found this interesting and started
> poking at the code. I think both halves may share the same root
> cause.
> 
> The merged iterator's suppress_deletions flag filters out tombstones
> internally, which means higher-level code with prefix or refname
> bounds never gets a chance to stop iteration early. By letting
> tombstones pass through and filtering them one layer up in the
> reftable backend, the existing bounds checks can kick in before
> we scan through all the tombstones.

Ah, interesting. This kind of hits int o the direction that I proposed
of stopping iteration once we hit the first reference that has a
lexicographically-larget refname. But I thought about having to solve it
generically in the iterator somehow, and I wasn't really looking forward
to that.

Your solutions works around that issue indeed. It of course doesn't
solve reference iteration, which would still be expensive. But it does
solve the issue where we just want to look up a single reference, which
is what Peff noticed to be slow.

> So instead of doing full scans inside merged_iter_next_void()
> we can just delegate to merged_iter_next_entry() and instead
> add a loop to reftable_be_reflog_exists() that skips
> tombstones (but is amortized O(1)).
> 
> Now multiple call sites would need to add something like this
> to compensate for returning tombstones:
> 
>     if (reftable_log_record_is_deletion(&iter->log))
>         continue;
> 
> but it may be worth it if it reduces cost when there are many refs.

I think it certainly might be.

> The key spot is reftable_ref_iterator_advance(), where the deletion
> skip goes right after the existing prefix check -- so a tombstone
> past the prefix stops iteration immediately instead of being
> silently consumed. The same idea applies to reftable_backend_read_ref()
> and the log iteration paths.

Yup.

> I have a local branch with this attempted fix. Rerunning the
> benchmark:
> 
>   Before:
>     nr=1000  0.306s
>     nr=2000  0.945s
>     nr=4000  3.816s
>     nr=8000  14.93s
> 
>   After:
>     nr=1000   0.020s
>     nr=2000   0.044s
>     nr=4000   0.071s
>     nr=8000   0.145s
>     nr=16000  0.258s
>     nr=32000  0.591s
> 
> I can send a proper patch if needed/wanted, but I might have missed
> something silly here.

Nice gains. I certainly think it would make sense to polish this a bit
and then cast it into a patch.

Patrick
