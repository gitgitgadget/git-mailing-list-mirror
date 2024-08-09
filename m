Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A07C8D1
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242739; cv=none; b=T7AdI6mWAKRl31X1CPzAWzWyWBYMXihjFMHaasn0rrj72TL47s7uGVWPmeKl3HrNQsyUxKSlOs/YPUKHmMYvTZxrq/kUlQicuSa2F4DeaYMobjTuX/IB+IeylShHGos7Wfx+CPTfToo3pm207fhUfdHRqhinIOTf/nSuGHez93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242739; c=relaxed/simple;
	bh=OKhWK7lxlnKzPlasSECRD5fcKal2pNDYm42q+os8+10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JGMm1xdfVwjAmk5K0+gkxdpGki/ZJ719AGiyLLBWFXdGXWquNmztTt3P7uDhYNFKVnpTZF3gVcSQhh365b1HwmBEKR565jNpPZG5MG2RI6fArPW3NQTvpjmyD2yzy8bQAV65Le2YgPrlgx1tGJNuUTINwHcNJryuEj8knVYyPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k839WoZz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k839WoZz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 952EC307A7;
	Fri,  9 Aug 2024 18:32:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OKhWK7lxlnKzPlasSECRD5fcKal2pNDYm42q+o
	s8+10=; b=k839WoZzlITMyf4STkuP7Y6X1XPbU9GZijzB24RXcviNCdEX+h5ulW
	EjUwuANeo5wCmaF4yY8JWg2+J7DXowEhNIP4oaciKx0AMrITjLuK3xbcZ8ybBf8n
	uKhgSwR7RcklHtl11iFF3TSrqaw94s4mZgpnfZGYQemwwkTvGtKoc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D669307A6;
	Fri,  9 Aug 2024 18:32:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9346C307A4;
	Fri,  9 Aug 2024 18:32:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
In-Reply-To: <jennrdjgi76ev4npmklozfpwfijmxttulwsp2h2pwqfuysyjvb@2gw3qyyt3su4>
	(Josh Steadmon's message of "Fri, 9 Aug 2024 15:28:40 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<xmqqbk21cxhn.fsf@gitster.g> <xmqqv809beoe.fsf@gitster.g>
	<jennrdjgi76ev4npmklozfpwfijmxttulwsp2h2pwqfuysyjvb@2gw3qyyt3su4>
Date: Fri, 09 Aug 2024 15:32:13 -0700
Message-ID: <xmqqmsll9vki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3A182B96-569F-11EF-BDF6-BF444491E1BC-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2024.08.09 13:54, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Josh Steadmon <steadmon@google.com> writes:
>> >
>> >> We're sending this series as RFC because there is remaining work
>> >> we'd like to do, but we'd like to get early feedback on this approach,
>> >> and particularly to ask for advice on a few topics:
>> >
>> > I am not sure how much this is reusable, after seeing comments that
>> > "cgit-rs" may not be the best name for this thing and pathnames may
>> > have to change, but I needed the following merge-fix to get this
>> > into "seen" and have the result pass "make", due to interactions
>> > with the ps/config-wo-the-repository topic.
>> >
>> >  contrib/cgit-rs/public_symbol_export.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> There is another thing.
>> 
>> Listing this file in $(OBJECTS) means that you should be able to
>> pass "make sparse" to build contrib/cgit-rs/public_symbol_export.sp
>> but it seems to fail rather miserably.  I am tempted to suggest in
>> the meantime to futz with $(SP_OBJ) to filter it out in the top
>> level Makefile.
>
> I believe that I fixed `make sparse` (at least in GitHub CI, it fails
> for seemingly unrelated reasons on my desktop) by removing some
> unnecessarily exposed symbols in public_symbol_export.c. If it still
> fails for you in V2, please let me know.

Thanks.  Please let me know when you send v2 out ;-)
