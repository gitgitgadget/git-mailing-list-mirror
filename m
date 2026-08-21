Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670663B05AD
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325580; cv=none; b=DBTs4ExaTNCm839Nbp7A3Yjy2ypTUea7ii52YqNxxT7h5gMjhYLpOA9fveukQ9lGl6TREbN16QCM3fZpO7Lg0qqhfC/tk8O9FggXe6FMP3AFniTj7NkYC6xmy4kuJemh7nQTASwRhlE4nXXuSSeDduWz8VDivEnC5SuE6Y2Lc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325580; c=relaxed/simple;
	bh=4gH2VXANKQjrOJi7M7o3RsxFeMibmw8Abl56GEhauHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1GI6Av/Vkyr168uGioJCo6sr+XJcLT/x2TR090niv01QOtCUt9++QRH6IPBC5txydpAlZwzV+W6x0WUCzoVpX3T9Hk84a8yQjvA7eqe/nfWMc38cJwZrN8nc73pS02sEgCoJzd8Fg7nwSGDSMhOEPIt/UiYM0pLCUNQV7iDAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TDORzxqV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCmg8fIx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TDORzxqV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCmg8fIx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0A7D7A0156;
	Fri, 21 Aug 2026 11:19:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 21 Aug 2026 11:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787325578; x=1787411978; bh=fTlntbmtBk
	CO4F43GSoT9EAIUq4YxJui1jNeoHDnxhk=; b=TDORzxqVQkWXUn+8rGT+1+11Yk
	BX7vO7jhLD7IhecB/ARMtYb4RPXwQjwoUlCwzO8Q6RcB9zWspPHgDU7MGfuKebP6
	11m6qOdsWtX9a4MMM4bUIeuc/XgQ5JgFXT6p8M38iXja7Z21Hrzrpc6xooo69Rrd
	B38BpB2otPI+Xr3xaaWC42UOHKwb9X0h498Fo8n/Dm1NA08v2s4FKiYJ63XNdOjP
	ZAS1qGt98uls/giHYK+KHLn7deBiPUaVa8MqwZU2uN3ezr8ZOz34KwPQeGdmDTwG
	0KBMBD/APv68u/m/pxcUb24/xG/0Nkgr1IJP4KfN4tOVuSVWnX1vKWaePC9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787325578; x=1787411978; bh=fTlntbmtBkCO4F43GSoT9EAIUq4YxJui1jN
	eoHDnxhk=; b=NCmg8fIx2gkQA2Ch8+gXSROe1mtZgWvQu+nZySP5jT8kBPYu+BI
	C7bJOJTOdc/VjN7wtAXyuUKhDBsBVX3AdwA0LVJvJJ37geno6bbVNgAwt1MQkpTi
	dn+kjhR3EDeFbQCXXZy1V5fsYvuhQbRiKk4X1a56yuTuu4bgas1jmzGF2tQzAkBr
	djexVokN+G0X1y1c5d5sqldato6JQ61TUqMLx3S8SdzaMtJNBkNFzpDIrKKmRrij
	axItUr4oeADefqPGZfxcACM9toDiYZMYkYelLnJBiyi4QmZghU4DjXU8+B+eBCOS
	V6/BM/qXaiu6Cz/5XlKJwB1/zN+XA45H9Kw==
X-ME-Sender: <xms:imyIatNs1dZwq9hERxo6SXz3w4QlDuKk0W4Bc2oUstgR3QoIuYxZQw>
    <xme:imyIam3OVaBte0vSpOz1Zyup2DSzyWW5BRDa1Sqk1LB7TCGIMeX0ylEtpbiPpdgty
    8ahEcKsKRQDUNJsSSZhqgcD7DDWYxt1uSOcZSP0RehcZtYGDtLF-Vs>
X-ME-Received: <xmr:imyIaklljdG_GL3vlXjGP9yxVnnwhijbe2u83P223FHxV2Z7IdWTkZwQFRfKeaqaXX0h-dwmqI6B5iCbD-kXFpfACZlMZkVrmg>
X-ME-Proxy-Cause: dmFkZTF2v+Xx6PkWJs4Q+ui9+6/d3VmUFOivFhbrv9BWqlEE6KzyaqKz38fiq5J9Z03o9q
    PttrC0R0bbwTtSeQj2Ha5g2sCSNTDl7FPbCZtMFlWE839uaUwp0NUrQD0H41LUodvue7hH
    N8n4TjF9NB/+89HSh0+443qgHOUzSIUV3EoiKnDwlsWCWSyVZmiU+tR1/iugdQZe1GZeXb
    N4G23WZ76nMrcLQ9aUMof3OCM0naYiJDfNMmNes6XzatX0DWMyQD9wlN3EfQDNzFybhREr
    xKh34vrlPaEoFLHIpyO7iMudJgjZl8MJenueH7n3bvTtGXJSFgynUCpDbuVH99fvgrYJtH
    U9vn2OO8Q4fOX2Fpei+pYZgZOR4MXCSKlvJV6wMsFhd9V/urGXi6JPP2UI2e7zVFmzVR9Z
    lbHw/hLPvhFSkHTZlLwnH3GE4VTHEsn+Sgg3gSJHVZy0Hdc9oQExyfAJ8tzZwjF6o0OY5j
    L9CUGR/mBbHjk0zIxPYrsYAESfk6dLhKKx1fmebHGcFQRN9tNUr+9LGXI9x82LE7azUp4o
    HE68GSfrouhOioSgjjZixu/AgDLMuI7wvgYsLTmHBLY5GcjBv1IZLDqFx7Ums38OfZE5vg
    DZOyfOs/AO+eE4oSU6C8b6eSa52wzyeexgBpTPnbo/obhe2SvPtymOWQo62w
X-ME-Proxy: <xmx:imyIalXgIHVPrcw5j2r6bk5W3N8xUOsYKU_Ora9FcH-2-i4cL-LdhA>
    <xmx:imyIaiuf_SGJ-w5FwcIVnsZMNz7qCp3XSsLfNnYM5bZH5vAs9wkTNQ>
    <xmx:imyIagbBnV8cJepp63TQX7Y4_6UJIHY05YaX4Wonaht1Uz3v5B7RjA>
    <xmx:imyIapXbV-0JukrncxF0OmBU1wrDDk9CTAQKoOUNYHS7_gmtmwOyjw>
    <xmx:imyIaj0UUfhIzM0IkFfrhYjVSiCaBBowKItI369ACMnYZmM0XevFqjep>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 11:19:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 2/5] odb: decouple source path comparisons from
 `the_repository`
In-Reply-To: <aof-t_bRzC0u1hHj@pks.im> (Patrick Steinhardt's message of "Fri,
	21 Aug 2026 09:31:03 +0200")
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
	<20260817-pks-odb-eagerly-prepare-alternates-v3-2-1115a7e02467@pks.im>
	<xmqqmrugsryl.fsf@gitster.g> <aof-t_bRzC0u1hHj@pks.im>
Date: Fri, 21 Aug 2026 08:19:36 -0700
Message-ID: <xmqqik53qz5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I don't feel comfortable removing that mechanism though. There's always
> that one person relying on those weird edge cases.

I do not, either, and more importantly, removing the hashing
mechanism does not help an iota here to deal with case insensitive
filesystems.

>> ... an easy way out may be to tell users "don't
>> spell the pathnames inconsistently" or its equivalent, "do spell
>> them exactly the way readdir() would report on your system", with "if
>> you fail to do so, bad things will happen".  I suspect that the bad
>> thing in this particular case is merely that a search in the
>> alternates is made unnecessarily inefficient due to duplicates, so it
>> may be a reasonable alternative.
>
> Yeah. All of this is really just caused by the fact that there is no
> platform-agnostic way to check whether two directories are the same
> thing. Which is kind of surprising, if you ask me.
>
>> Alternatively, we can even say "your repository cannot span
>> filesystems with different case sensitivities"; I am sure there
>> would be some users affected by such a declaration, but I do not
>> know how much we should care.
>
> I'm hesitant to go there, as that would retroactively introduce
> limitations that could break ...

Yup.  Which means the simplest way out would be to do a "best
effort" case-insensitive match when there is a hint that the
platform might be using a case insensitive filesystem.

And that in turn gives us a direction to solve this part ...

>> > +/*
>> > + * NEEDSWORK: we're using "core.ignoreCase" to deduplicate alternates that
>> > + * _may_ be the same. This requires quite a bit of boilerplate for dubious
>> > ...
>> > +static int odb_source_paths_cmp(struct object_database *o,
>> > +				const char *a, const char *b)
>> > +{
>> > +	if (o->source_paths_icase < 0) {
>> > +		int icase = 0;
>> > +		repo_config_get_bool(o->repo, "core.ignorecase", &icase);
>> 
>> I suspect accessing o->repo should be safe even in the
>> initialization sequence, simply because "o->repo = repo" is done as
>> the first thing in odb_new(), but do we know o->repo->initialized is
>> true in this code path?  Refraining from making that call and
>> assuming a case senstivie comparison may be necessary when o->repo
>> is not yet initialized.

...which is that, since case-insensitivity support is at most best
effort, we do not really care if o->repo is not initialized.  The
code can stay as-is, and if the user spelled the path to a single
alternate object store using two different cases in two places,
causing the code to treat them as two different entities, the effect
is merely an extra search of the "second copy" (which is guaranteed
to find nothing, after a search in the first copy finds no object
they are looking for)s, a minor performance penalty
