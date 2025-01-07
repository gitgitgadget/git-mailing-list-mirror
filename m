Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A818E02A
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283811; cv=none; b=a9/VGVtGvWCQIH9BVjC17PksuGwaUqPVT2BgLrmG32Eub4abMxFRy2it7VQ5I3PUVMsho8bS1wd6UhOqOG/TBNvxxPvmyR99TBFeTiII9tAglWq3T87eWvXuATP9vE47HHTUxBcd3FnimcWlnznRdba8tpLZXmfUDgZ2vBTFmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283811; c=relaxed/simple;
	bh=9xirCJTd7f7BS6bjGyDdkEMH2hHxeAyZk+qC333iBRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7NMUYyt6FjRM5HeNxUUoWQfpcGcOGQnsjc8fq4giIgwkOiy1z6FVWI9frhZu2OThv8uB+QSvLqdRPisMTjUbzWhSC6x+N8+AeLIeDNu5IedLyCB7TuA2OLrEmFK9gU3m8IRpyMXu1Rlknn0YbZw3wIT7ejNYv3eJmaWvhMg6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MuxknJVd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJq9x5yF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MuxknJVd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJq9x5yF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 083A6114018E;
	Tue,  7 Jan 2025 16:03:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jan 2025 16:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736283808; x=1736370208; bh=+nCY0/DmFK
	N/CFKm9NRM6nR6V2vfJF4/JW5qVgTK20U=; b=MuxknJVdGAuKFFDzlk2ZMdnaVG
	DFrGDwrD8KU5fBhOVhGKKdfUPJsd0kxlz7ryad2SxDrlyLqjmkI2IHmBIW9Z/COu
	BM15CTfULHBcEbi8tR6N/KxnylvLsBE3F3QJvZRQWRn0C5oSlqbXgMV8fmQWbNQ3
	X6tnTnDU22M+O5ngw7Qx05iXwh4jSMOZlvkiC2w7nogZxMZSXxXp1YeuLE/dJtOu
	j5pBBrp6vkEg5zXYPbj9HUNJRlz+l52TZYROMvFfYtazEZ6wEMkYqt7UgcG0Anwp
	DWjYtcaatjgIABSmW0Tv4eSGNd71ZENA9n++QnBifzFQ2NXMBNXv14QfIEeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736283808; x=1736370208; bh=+nCY0/DmFKN/CFKm9NRM6nR6V2vfJF4/JW5
	qVgTK20U=; b=CJq9x5yFm1cnouRbtXFaBQrIPncRPjVx3dQ6jaqoPiITL5iZed4
	JO4r7wVSBNZfbmWKL/dGqJwIlSaBo1NBYf8aHg6lWnLdEVlthvVA4aD1Jbkql/mL
	YqzIa6e023e50EcqO8dLgVYjZvz0v/YAQ3PAXgomSdEf/nrJcL44cVt3oT8k8RwE
	fmkpMfBW28auIt6sCLUPK/RkhcoUW7Flbe1n5i+tEUbq7u0BiqQId3MgE1SrSwg6
	XoFkU6Vbqn/rUGNAxD1rsSB8dYETV0j7mjmV6awl0M2DShukM67RfQDBzJWlp645
	jQKdBjX0+ksIeACX9Ug9Lxwq8KfCxSeAnsw==
X-ME-Sender: <xms:n5Z9Z175TSqet9OLDLVJqYhzrdsKmFaJMUY3HhWDZWJSZtqpMnQf_Q>
    <xme:n5Z9Zy6927-hJKgrd6M4THO7YoqSPhb3M4ES7QdHQlkgh8N_GQ4iQAoOJBLnsAh7D
    eFlp7IkxyTNp6A_cQ>
X-ME-Received: <xmr:n5Z9Z8c4T164RX5S0vjohaSBv2MHdJXQS9ZbxJ3QpVyE86O2ZxKLBgLK61eBcE4FG_U3t-yk7yO76-IvgTLd4Piq4v9nBPp8YoMN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n5Z9Z-JiFYNeNWs8X8JU7JmmwNnoFT5SBVmS-3VYjW7IXv1VFgfgDQ>
    <xmx:n5Z9Z5LqjWfLAM1-hY1VOIqXmgXLwRbAzfN0f2D6TIi4BYmGaSQL-Q>
    <xmx:n5Z9Z3yoqvPICdMvTjDHT4-NmMl2tCZ5pCK84lHBI0d-Y8_4tiJVJw>
    <xmx:n5Z9Z1K29l-e09Yu8gY7T8UHvERPfDnJdUebAXHX3MT1-Q7y3MIKug>
    <xmx:oJZ9Z2H91Tbgu6T44-3_tzRMXnF8o9_HwCq3eTVW15eZZ73ncVqAvq8A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 16:03:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 2/2] reftable/stack: accept insecure random bytes
In-Reply-To: <xmqqzfk2qr62.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Jan 2025 12:56:21 -0800")
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
	<20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
	<xmqqzfk2qr62.fsf@gitster.g>
Date: Tue, 07 Jan 2025 13:03:26 -0800
Message-ID: <xmqqv7uqqqu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Yet a platform replaces it with a function that returns an error or
> aborts?  What kind of nonsense is that?  Do we really need to cater
> to such an insanity?
>
> Use of git_rand() here goes backwards against the more recent trend
> in reftable/ directory to wean the code off of the rest of Git by
> getting rid of unnecessary dependency, doesn't it?
>
> I think [PATCH 1/2] makes sense regardless, though.  But shouldn't
> we be pushing back this step, with "fix your rand(3)"?
>
> Thanks.

Ah, I misread the patch.  It has two hunks, and what I said applies
to the earlier one, but the later one is already contaminated with
git_rand(), and that is what is failing, i.e. it is not a nonsense
platform replacing rand() with something that can fail.

It may still make sense to drop the first hunk, and consider how to
proceed when you further want to reduce the unnecessary dependencies
for external users of the reftable library, though.  Are there
correctness implications if git_rand() in format_name() yields non
random results (like, always using "rnd = 0" instead of calling
git_rand())?  I seriously hope not.  And if there is no correctness
implications, perhaps we can replace it with rand() or even constant
"0"?

Thanks.

>> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  reftable/stack.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/reftable/stack.c b/reftable/stack.c
>> index 6d0aa774e7e29d5366ed55df19725944f8eef792..572a74e00f9ed6040534e060652e72c26641749d 100644
>> --- a/reftable/stack.c
>> +++ b/reftable/stack.c
>> @@ -493,7 +493,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
>>  		close(fd);
>>  		fd = -1;
>>  
>> -		delay = delay + (delay * rand()) / RAND_MAX + 1;
>> +		delay = delay + (delay * git_rand(CSPRNG_BYTES_INSECURE)) / UINT32_MAX + 1;
>>  		sleep_millisec(delay);
>>  	}
>>  
>> @@ -659,7 +659,7 @@ int reftable_stack_add(struct reftable_stack *st,
>>  static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
>>  {
>>  	char buf[100];
>> -	uint32_t rnd = (uint32_t)git_rand(0);
>> +	uint32_t rnd = git_rand(CSPRNG_BYTES_INSECURE);
>>  	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
>>  		 min, max, rnd);
>>  	reftable_buf_reset(dest);
