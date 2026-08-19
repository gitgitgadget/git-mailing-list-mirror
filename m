Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B33B8D6D
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161369; cv=none; b=HGqbujqJIcUX5t+uBCx4HM4JnumCiC3Bo3aB7ncfBO9l+yBxfw5aGZYD1Uvf8DU0iKFWRr2Z42vnHRWnzlh7XrHuq/u+KnCyrgkQpUsbcmpaajTDV3OjsenVsJgPowv5hn4InIejKaqsN+zBSQaW5DAv21RtYdzT+hLKz3H++2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161369; c=relaxed/simple;
	bh=VmnSzt7pxYoCgFnHgv4UDRrYWa3X7NCtjIEHglqZFPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sMUBfXdtsarzeFBU4GO4v5hKivKTeN34Bg5E6Ck/GFPHAVtq2rnf6Z+4JB5hRWHDyETYNYwjoDk7nJ6HM2qi92uJ+CMa0yl/E3FcAqhnwntathtf/ZxUJUKAI5GtonR/bLhO0ixEtEDIlCjJpW97eJRmAPIm0ow3qZegEhn8YAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FczGMIsY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/4qwiK8; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FczGMIsY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/4qwiK8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A69351D00101;
	Wed, 19 Aug 2026 13:42:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 19 Aug 2026 13:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787161366; x=1787247766; bh=uBIswMgfNx
	kC109qs+T796RAmxZo2agGilvAGhevAug=; b=FczGMIsYeK9K++cs3w36HY+/z8
	lA+Op+GG3ZXyII6VNMEH4azz270WOVkf6mWHtLDZNMEJHfv1jDekvfIdNGTRtscE
	VE/FnGeIHrmJht6rePjRhfx6z3nw+YOuVS4UhQcEAAFdg4J4X9+WOa7iUP2zIV7f
	2EwK4yaoH2It7NVoS9csXG7BMIzX69eH4nTHi+UTcFAhZsQjWU4APAXQZQAFbTOa
	3CkgSsEgi3YmU7rA/z4Ds2iY262paeXS+W6o9iDib1qIYStHbCLfaXmSBE5+FR26
	+zj8mwvbUc7uIOTzWWer+39cdeHG4KR0MBtDwviZWc+d5e2zql2bcjzr2FvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787161366; x=1787247766; bh=uBIswMgfNxkC109qs+T796RAmxZo2agGilv
	AGhevAug=; b=a/4qwiK8LJBUF/nLuXhb93a17h1OVpf1g5qFsj3iYNv0F+k473h
	giW0vcQiK9o6FhBHPdI0M+U6U9rxIEP9wDOJgoR4fE7gJ4/Yk6nhynIyEflw+oLs
	gSpV8O6dR4MIVd4W8tAPyGVLywMF6y7NqlKTrRK7ziv7iE4pnJgsD7p6vZbPObNy
	zHVqmhtbi8tOf1re6/8Rllbns4P8ickOChW+kqHM8sxcQapZbP8XGfldXYPkHYZK
	BzyC9XzdLAQ2schM3feK/V8plKGlC40QRiUnHR6SAFa2eZvmOkEWnfP1Xyt9eS3y
	MBIfh/KbT7iAegYkUbfF/F+86f5I892g72g==
X-ME-Sender: <xms:FuuFalyUVTrNl_113VY1ZASWcnhEuLQAGcYOevQj-Jesx-qhUoLlxQ>
    <xme:FuuFav3gdLTY0b0TvXK4xmHsXI6fFHczbpVns41XSss3yHbWb8P1adyO4OE_DSnay
    F7QFgQsEAlF_IFLzhP4kGkZ744uU4ezioGuLaxBV49po6ikkb9Mf8s>
X-ME-Received: <xmr:FuuFar4nQ4AH1oVmvsOmBKdDwsoyBk_No7mxEcyxRNlZv8D4wTLEZu6-K_6h8DVlS9aJ3ik_gE6XhrGWSHqLf9aGLUsosumqWA>
X-ME-Proxy-Cause: dmFkZTGi8qGOtCEfPj9OSmhvHlK1hRAR082DDHrH0Q2FfCm3xz4X+NhLG1TMLLHnumpphe
    zCPy5ajEo1Jo9UTenHg/pV+i/I0mCfJ+y46Jov03DTBcDWlHIr4NUnrXhlHrbVP3KjTCqO
    2bW2RQAGttvkXUR9NL/W1y8yfELFpQFFWhYziqoUzQRsyTyIuAphl4vHkQs2eBSlC8Fke6
    UbrurPoE5oZuyRt589mlmQfFbbq7h9TCgR3m5U8ZQeraegRLD1tqlkLTst6ASt0k+9vOZe
    7PzHb0cEMX5GZ2Ap6Oy7lBgvDSrt1XKD1ur/8rdvyqQyku2IGjDpglmde/4yOd9wJ4h/Lf
    f2muga6Ra9FnQd6+uV6loWvjDOdJ4WqqBD5a5KmDj2yKu3bIL9dWS4wU+ILEdG2YSG6r5R
    5WG+KC9clPsVsreRotwpVeBPFIaY9BVMbLh2KGmnjc+C++c5zCjvoOvtWqObpE7uScXRUm
    8AcWIGoL0QAGuKtDJDO3WU4c+MTiynPkOGHTfbxkRvKzucmGQWCmR0+n1466yTpDmwmf7P
    e0F+2Yu8EGwX3BsZpvxil2zc0YDlXRJivb4E+ZU27m6shgualRUg5XA7+pImyiNvp9VYLW
    tYyC1LaAyjRhM5Kmf2GiCKEPIFJiRyh05ohU8miwdmMgYm9NYLwBssnqUwYA
X-ME-Proxy: <xmx:FuuFaqXVtQbB_6ywpyG3d5ee7V2ed8wCW6ZHJp7ql2_OftgKMj5iKw>
    <xmx:FuuFaiCDEJIbZcEQFMbznledt5QXD-wq4II6oAKPSoynD8TpF4VgEA>
    <xmx:FuuFah6oQTDc-6JY1Ie5nMxDNlTKcA889aNhnCmiStHX3hFPu8T-sA>
    <xmx:FuuFalxv1KPH_7J04HUnvt4VDNXvWUXtdhyg8YbpFfHNY22unZRY_g>
    <xmx:FuuFaj5YnBwscb3OUvLp-1Kiq5I1mQKzDcJrt-pq9GE3y1Xp1weJyMzu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 13:42:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/7] odb/source-packed: flag known-bad objects as
 corrupt and not missing
In-Reply-To: <aoV--DSQq8-Krg3M@pks.im> (Patrick Steinhardt's message of "Wed,
	19 Aug 2026 12:01:28 +0200")
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
	<20260818-pks-odb-generic-corrupt-objects-v1-3-ec234567510f@pks.im>
	<xmqq5x17z41g.fsf@gitster.g> <aoV--DSQq8-Krg3M@pks.im>
Date: Wed, 19 Aug 2026 10:42:44 -0700
Message-ID: <xmqqpkzeuhuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 18, 2026 at 11:17:47AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > @@ -618,8 +619,11 @@ int fill_midx_entry(struct multi_pack_index *m,
>> >  		return 0;
>> >  
>> >  	if (oidset_size(&p->bad_objects) &&
>> > -	    oidset_contains(&p->bad_objects, oid))
>> > +	    oidset_contains(&p->bad_objects, oid)) {
>> > +		if (bad_pack && !*bad_pack)
>> > +			*bad_pack = p;
>> >  		return 0;
>> > +	}
>> 
>> Hmph, so the idea is that if you have even one bad thing, you are
>> marked as bad, because who knows what other parts of you are broken?
>
> No, not quite. We don't mark the whole pack itself as bad, we only mark
> the objects that's contained in there as bad. The only reason why we
> also bubble up the pack is so that we can provide a better error message
> in a subsequent commit, where we can then tell the user which pack it
> was specifically that contains the bad commit.
>
> That's by itself not visible in this commit yet, but I do mention it as
> part of the commit message.
>
> Patrick

OK.

This is a tangent but the argument heavily relies on the invariant
that a single pack can contain one object at most once.  Once a
corrupt pack that has copies of the same object duplicated in it
comes into the picture, the error message has to say which copy is
bad.

