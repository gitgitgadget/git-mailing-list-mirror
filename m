Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0346446A5
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826410; cv=none; b=uxN/WZ1dSL/tuAhCv1i4sjv1LOyXmSqdmmB8QbGfdZENhCkLshrGqLYaB6OgqFnQzUJW7T+8FAjoZm4T69wCq9yLhCFAqV8R+pKAcpEhf2EUp/tiAVBrpq3Gk9H8rR3Rvj8ZDS2yX2VPQ0AH0mKxx2L9LVAuIE+kKs88OgNUAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826410; c=relaxed/simple;
	bh=mZSoK5Bg6WyjsBf7UUgNGRDGrTUZhBgvc27+3Y0FpbU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o/iw7K7VQCcjxsl7aQ7ltxOTjsTkkdC/SmL/bQ9ZiHRzmOgmd+WCaaMoLmI3sA0IWm6KEVbuZJkrie68Nd7CNnUstbP3xifDi4Mw2X6XnccveKuVTCL/YvfdiZQdUUSwY7qxsM7/ySgaML/o7Fv70jTzsonUv4C0gZBQaiXA5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gfPTbM+V; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gfPTbM+V"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710826405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJBxKZ3s3IAnIweHTJErA/PreKPxsMehW9XMydJ6HFk=;
	b=gfPTbM+V+0S6qzN3aFi8f9tG/5ap12YL0LpBVDpT6b10joNTVnd6hUcEOsRDcR8ABZmVKd
	N1CSfVYi+FHWpJP3RqRW6y1Xy0NqZwiWfRIcxCRB4xdvGJE0Uf94WN7A0Dgtj5FsnZgGhY
	1UV+nSEe+6blWry37Th83Ti2++RxEtBcaypvZ6etYJ17EhXTMzDPlDSJpOjxyb1AaBsuKT
	yGq1pqISypyO/23lshkR5bNFKGDr8uTZ8QltGJrH2ExOW9Fcz1PUixkw3hJK950OOhIRXE
	LoPSBnayNDgiMiM1XJvqOjxMBiS/aQIWWnlnzt+IlOxvQ1dON/ZzXDx9LHh4fQ==
Date: Tue, 19 Mar 2024 06:33:25 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] grep: perform some minor code and comment cleanups
In-Reply-To: <xmqqjzlzt61d.fsf@gitster.g>
References: <cover.1710781235.git.dsimic@manjaro.org>
 <96b81f3573d3f29bb97e77d623be0d53cf8085b0.1710781235.git.dsimic@manjaro.org>
 <CAPig+cQ6Y2oOaPkKFsD41beXLHjhD++nmf59xrcswpb6_Q-sdA@mail.gmail.com>
 <xmqqjzlzt61d.fsf@gitster.g>
Message-ID: <24093dca675c49cfde39f6d6efca2342@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-19 01:32, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> It's entirely subjective, of course, so no right-or-wrong answer, but
>> I personally do not find that this change improves code quality or
>> readability.
> 
> I agree that this is entirely subjective.  To those who wrote these
> variable decls and inits, what they wrote was the most readable,
> wasn't it?  It probably falls into the "to some readers the existing
> code may not be perfect, but once it is written, it is not worth a
> patch noise to fix it" category.

There's no doubt that it was the most readable form to the people who
wrote the code, which was some time ago, but the time inevitably passes
and the surrounding code changes over time, maybe even some new coding
guidelines become introduced, etc.

Things inevitably change, that's all I'm trying to say.

>> With my reviewer hat on, I spent an inordinate amount of time staring
>> at this change trying to locate each variable's new location to verify
>> that no initializers were dropped and that the declared type hadn't
>> changed.
> 
> It is true that "cleaning up, no behaviour changes intended" patches
> are unpleasant to review.  They are boring to read, and the risk of
> breakage due to mistake is unnecessary and severe.
> 
> But if the result is objectively better, such a one-time cost may be
> worth it.  We are investing into the better future.  For example, we
> may have an unsorted mess of an enum definition, and we do
> appreciate in the longer run, such a definition were "more or less"
> sorted within the constraint of some other criteria (like, "errors
> get negative value").  If the enum is a huge one, it may need some
> careful reviewing to verify such a change that turns the unsorted
> mess into a sorted nice list, but the cost of doing so may be
> justified.

I fully agree that reviewing code-cleanup patches it usually boring
and often taxing.  I mean, why change something that has served us
well for years, just to make it look nicer in someone's eyes?  What
does even "nicer" mean to everyone?

Well, I sometimes look at the code as if it were a beautiful painting.
To some people, it doesn't matter if a painting has some rough areas,
as long as it can be hung on a wall.  To them, it's just a square thing.
Though, to some other people, spotting such rough areas is what makes
the painting less beautiful to them.  Paintings usually cannot be fixed
easily, but fixing the code is much easier.

Of course, "nicer" is very hard to define, but I believe that, in the
domain of computing, it could be partially defined as "more consistent
and flowing better".  That's what I tried to achieve with this patch,
and I hope I've managed to convey my viewpoint.

> Does the change in this patch qualify as "objectively better"?  I
> dunno.

I'd say that these changes qualify as "semi-objectively nicer", but
surely not as "objectively better".  For any changes to be objectively
better, they'd need to introduce some functional changes to the code,
while a well-performed code cleanup actually introduces no functional
changes.
