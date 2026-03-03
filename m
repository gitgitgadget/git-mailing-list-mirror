Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FA1D5160
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548444; cv=none; b=CFx53IKmIVdX1SL3cSj91jgA7wC1RmGar2zJvKqUcXzSp2ZYR2gfy/P5vpkmaWu+Sw5JRdCevsbzC3lxSPjV/291SQ1e6biemd6o0fKBPaIJRQ05BQ6yA0y12K6caVybjdj1vU1JrAPnGC8gWO4w9pQIw9GuG3OWBR/0kqHj2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548444; c=relaxed/simple;
	bh=fxZrN995sPU/mU/+rVS2blaln7Ar+TfRjlQsOlT3SjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1Sp8hN+qjnq2mYSAjTTZJxEAA8lDO0gY6gK6CKEEeq0l6vHNMyArts5YdHXZyzXr81SlhuWvgXLOrQEYTEc6tJ2EsXnLyEP4L7mwUkk2f8zlqmEK6EPiz30mPOc0k0JN6F03eZ9igfA16mEyl//RoeBU6O6l/eAkA+7CHOF0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SUink4lL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SUink4lL"
Received: (qmail 49310 invoked by uid 106); 3 Mar 2026 14:34:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=fxZrN995sPU/mU/+rVS2blaln7Ar+TfRjlQsOlT3SjA=; b=SUink4lLOwWku2zHY8lEZhi4vZElPI6VM2FQfFw1ZVbMUd2Ntf4M5yPPLO6lMwIRhkWrZf+PYkunug6SptQ2kNLj/oCe/n2wKlvC685+0N0bBh6Kj2sLuJZiFEuSxoKHuwYWnUCX6VzZYY3L4yP7Qydws/OfLcYSyzDwi2WsNFuB8utt/6n/lV+K0tsGYmsvoe8j0HfqvKx8pvU7ctEQbqR+fB+PYM55hi3+yM6HbzwXdD4BZkgqcICIQ35lPveHvViPFAVDDNeh2Wxj9Y1LFoMVSvCEW2fs2m0K+IHqPsixQ8ryb+Ifm95xiwbUaaAkXa5W/7LvzYg76ce4sHCOKA==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Mar 2026 14:34:01 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 349264 invoked by uid 111); 3 Mar 2026 14:34:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Mar 2026 09:34:01 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Mar 2026 09:34:00 -0500
From: Jeff King <peff@peff.net>
To: Alan Braithwaite <alan@braithwaite.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Message-ID: <20260303143400.GA820518@coredump.intra.peff.net>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
 <aaV6PLJCrpb2mQnq@pks.im>
 <xmqq342i12ky.fsf@gitster.g>
 <a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>

On Mon, Mar 02, 2026 at 01:36:40PM -0800, Alan Braithwaite wrote:

> Peff wrote:
> > We actually can do blob:limit filters with bitmaps. See
> > 84243da129 (pack-bitmap: implement BLOB_LIMIT filtering,
> > 2020-02-14).
> 
> Good to know. I'm not positive, but my understanding is that
> this patch only touches client code, and the server sees an
> identical request to what `git clone --filter=blob:limit=1m`
> already sends today. If that's correct, anyone can already
> impose that cost — this patch just makes it easier to opt in.

Yes, that's correct. The server protects itself by refusing to support
certain filters that are too expensive. Usually by setting
uploadpackfilter.allow to "false", followed by enabling
uploadpackfilter.*.allow for particular filters.

When we added those, we left the defaults as-is (allowing everything).
That's OK for casual use amongst your own repositories, but terrible for
a hosting site. I don't know if it would be worth revisiting the
defaults.

But anyway, all orthogonal to the topic in this thread.

-Peff
