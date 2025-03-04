Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F18AD24
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073414; cv=none; b=a20vQ2wcT9BpSw9NKKcSAl4IAJOVoPmUM6q0UvbaXMgDN6Y0cV0Q9ls2B93w1FTa/fUetmmgjsbBwDYrVVK8NwzLS3tRJfCu/rcOcxb9n432cUDzY2Xg3VOxy4cpWoXP/t9T0i65W+HbEHSbSakwP15Xyc3FgE1cXgzyCrttIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073414; c=relaxed/simple;
	bh=QW/fySd1qjUI5XfZWYOPm64ikcrXvEgUvEVFNZivFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCTAW8LGKj/+eBjefSleQeqQhNfBEHkvfBs6cLuZrjPj61VESXVAiJgW4S6uPonVqLX9nA4kiLDS7bBDNfNGU/SKSloZ5c7MeU1x+FyHh6WQAUAsn3vRUUWzG9u3OaqOlxRmHCAiobNf1bXRgtjiFs6+3u+KOy4l5ieHSN7SOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cydfiPaq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cydfiPaq"
Received: (qmail 9332 invoked by uid 109); 4 Mar 2025 07:30:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QW/fySd1qjUI5XfZWYOPm64ikcrXvEgUvEVFNZivFNQ=; b=cydfiPaqQZ9oAIbBMQ9lYO5627h/ulaZz29+qsB9cQleFBDSnaLHLHwDDxHh3e+jxbZwj9KSKGfvoKFtHFW3Mzg+uBB4x0EmWxzowje0VNCZB9y5FLrnZKmdCdKDWntOOb6iOBs04yRIncLppisQJ30ER8hbRL0IJOMglUB5X2kSWJBwFmcXCJNryMIpgJ/G6regxt1qCgyLcJNU/YEbI45XyyoJZAr4i9uRM7K9mZvK+RcCbkbzaAiog0x3ZZUj54cAz8KL7XZ7JRNuq4pyG3fJ4iq2uvL3TjfOTtz3y7E0ehykZf3rRcDUSW/l47NVVdXlV6kZL07E3f4oQJOZvg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Mar 2025 07:30:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22674 invoked by uid 111); 4 Mar 2025 07:30:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Mar 2025 02:30:11 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Mar 2025 02:30:10 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Michael J Gruber <git@grubix.eu>,
	git@vger.kernel.org
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
Message-ID: <20250304073010.GC1283943@coredump.intra.peff.net>
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
 <Z8GVAjwZWOM7c2fR@pks.im>
 <xmqqseny40kx.fsf@gitster.g>
 <Z8WFcaEtMCD5C0EN@pks.im>
 <xmqqzfi2xl5q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfi2xl5q.fsf@gitster.g>

On Mon, Mar 03, 2025 at 06:07:29AM -0800, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Maybe. I guess for unit tests it's a lot less clear cut as most of the
> > tests won't depend on such a controlled environment. So sanitizing the
> > environment would be a good enough first step for me, and if we see
> > demand for making specific information available to lots of tests we
> > could still start to expose those at a later point.
> 
> Fair enough.
> 
> To put it another way, if you write a test and if it gets affected
> by externalities, perhaps you are testing a function that is at too
> high a level that is not a suitable target for unit tested?

I think one problem with this approach is that breakage is likely going
to depend on the user's environment. So something that works just fine
for you, the test author, may introduce a hidden dependency that breaks
for somebody else much later.

Some examples, assuming we just suppress reading Git config:

  - Without an explicit ident, we fall back to constructing one from
    system info. So if a unit test ever creates a commit, it will work
    fine for most people, but not for somebody with a blank GECOS field
    in /etc/passwd. (We do look at that field for reflogs, which current
    unit tests already do, but we are more forgiving there since we
    don't pass IDENT_STRICT).

  - Other programs we call (e.g., imagine gpg or ssh for commit signing
    or verification) may read their own config based on $HOME,
    $XDG_CONFIG_HOME, etc. I don't know if Patrick was including that in
    "sanitizing the environment" or not.

-Peff
