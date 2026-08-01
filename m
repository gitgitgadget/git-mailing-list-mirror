Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A627E076
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785591523; cv=none; b=PdZoSMNz81Mz1IXsF/VtJAAWYH7LmuMaoUCxVzyQlAIEbIpOj/8LWNp07BZZA5nRzmY6ylS/1NXBJCb0PmTJjKieK7qGdFwYDYqWPaKwqzihb2n974/uKmYvgyT9vvv31LTgDnwWco6nY/INlCYaUcEaMSCJxrqLMkZGyq984VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785591523; c=relaxed/simple;
	bh=UeAtPi3DKSdscdZLAsXAeEt7/Up22QnlDVl7bHPeQcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUFhh3RZ3akhN1eSdvnEJCZ9Oz4bHqav3x82lkbEYMLEguX7KjNlm64ho7b6JNn4/jENtaMmAxlW1baII5IEQ2TOHyRwXZifM+ggJXN3m7JduHzeGlLyoWdCgN6YzOEH8b4DcaJepODnZWS50CFdToolqB/UiRL922emiOsH6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i69L+a+w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JaUAWpAT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i69L+a+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JaUAWpAT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 29294EC00DF;
	Sat,  1 Aug 2026 09:38:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 01 Aug 2026 09:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785591520; x=1785677920; bh=hHId1FA9r9
	NjePoxU3LVKjcEyHw8wahbT6Got/R8L5U=; b=i69L+a+wGY89n60ynBaps6/Qmw
	DAx6u87/J2CIht91Clka8Jicv2mdn2Kr4tOrxYUbV/ykrpeRWm0H3VwnB7/oUSp1
	caoJ+XaXnFTaAp/3EVEbpTgvukLjVItqsd+4lXOtdpWCPh4jUWvdZZjVs1NcJ1yD
	E4XRaFssOXmaySCHIsapokbt6+GRGqjD8abDGrR9sgkfKrQH+NS1BiDOc1PcqWvq
	7Ozfw4VpmOOOTSSqiOOFtBYvcW8ti8QBfzvA3j0gVmESnARwBW0xOdw9egOZfl88
	XzdmStFThcXsqSGnaTnx7zw2bytCeJ8i6MUQIQtyqdHPxuLOWXrkQYK7AK8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785591520; x=1785677920; bh=hHId1FA9r9NjePoxU3LVKjcEyHw8wahbT6G
	ot/R8L5U=; b=JaUAWpAToFLhtNIubJClkJ4x+QkOW3DS9Lf+sKYdAfYZA+rLubR
	3wbUWAel0FwwmTtKnTlFIIMtPKk0mQOzY1giKOrYmUydodgosF/Et9BumVeWnH6Z
	XN+qk/yvCzS6+lz+nj/nLedR5ojqhn5aykrmLkwGMbQ0Hge2ijERr4KNb/HE7fjc
	e0G87/dv8wq+83M/RVHBVwa+yAxIEWAzBjCTezbi+M2h3P2S0GDRqcZf0bzMTv9e
	60FvKK4Qb1iIRxxRYiUza/UiCaYFxjlBT/ce4oTTyeM/QMTtg2h1hvFhpqHG1jZ6
	nhkv2eGkur6g27nyQeZy1wa9N2IMgpe3ovw==
X-ME-Sender: <xms:4PZtalmcME658C0f_V1yszEHxa6gqUppAmVzUsdwxHblGBPZcsk06g>
    <xme:4PZtantuY2LHPaPmtfYI6c3rGzo_VaFXnB2QsmEchM7M4dS5bca9beROL8gWJi0aE
    ezcTK1mKlRm9ePFoEr8VK6KaPS_BaJtRBEArYsb7MWwn3SFLkj3_w>
X-ME-Received: <xmr:4PZtaj8fD2A1hbnPGo0oOzUjtFJxF89-aA8-XsyuMI0fwf9naIjNT1k9zOQxwa4rvaUn9kKEL9UYXjCRohRvo_9UhmiuakoWYw>
X-ME-Proxy-Cause: dmFkZTFPky+/dftlyPyVgDUdB3yUndmvZ9Tbp05OjJEMRFDA9tM2UraHRAelSiEyNhoJtq
    tCZfUE5PJgSoRzm/uQs7iWxOPD7MXoiquX8D7tggFOucWqXv7By3G9y3xzthmMld5h2FFc
    FEaHbTrsxVIk6sCaNvz0QpWvKJXayt8pW+OPAnXOS0x/dAkassb3IjdLo9rk+grvmYskll
    K/U315NyXuMeCVA7nJGp/hEYSSuIGnnIqco2VP/l25z8rNofhp0llh/D6EVT8oXPHLQ369
    QDrtVnjgG5FNb2Q0HeZXnD2AvaCgw6TDL9bGpnn8AdXXzsz0HLxmxjBrdCCtC3PHxvYnfS
    e/mrGq6RX3k4i9zmPnOdYdxt+33X1Ra1C/0ba7xo6fRB8EKVpUI9OW9hsX+d7vLrGGafo8
    8Ab7anS8h09UkWAS0VV+QSJw/s1KPPxA44CK1/4qZ/yY7FO9hEaPITQv0GNeOoH/h9Iuab
    GQfS3Mo6oHGqbMl4duE1d2VspmT167VjYlA9ZtLBbIQigLct/EnxJBrlLGK2Cbj7RhsV8I
    0zewTAcAZvh0elvI/yMfSDPDeYeVmXRvixotek7egKHLv82+mLAIbFJQ+Di2gF9xUp4fS1
    nEYqhRqJdTyx/CvFYOJesC1/nSBm6i1OoK/FZxNkSzUGHB+kg5MD3/9XBkng
X-ME-Proxy: <xmx:4PZtahMSOHJZGwJ4tPY1R4k8DRtWdonPlwqddbWgPgYs5Bfn6Hp4FQ>
    <xmx:4PZtahGBtlr0xGdyWYpH36uBabT7Eav7gsiRVMyGD8Lmw0eeIpQDMA>
    <xmx:4PZtavSTUlWv38jYmAyWAfpK2Xuft9T6OvFpLvpCmY4h3tX6pfMNog>
    <xmx:4PZtaut-P9iyI084gsEHuXuFxy10nE6YRcBSivredEabGQxa1CLDJA>
    <xmx:4PZtageqZ3mtxBGaCUE_eeILuMQWPRg-YL5ekhIUIzSY-6U2lE-XJeK5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 09:38:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
In-Reply-To: <xmqq7bmaa0sw.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	31 Jul 2026 22:04:47 -0700")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
	<xmqq7bmaa0sw.fsf@gitster.g>
Date: Sat, 01 Aug 2026 06:38:38 -0700
Message-ID: <xmqqzez67yg1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +		} else if (!strcmp(reader->line, "type")) {
>> +			type_index = (int)i;
>> +			for (size_t j = 0; j < args->oids->nr; j++)
>> +				object_info_data[j].typep =
>> +					xcalloc(1, sizeof(*object_info_data[j].typep));
>
> Do object_info_data[j].typep and object_info_data[k].typep need to
> be independently freeable?  Separate allocations by calling calloc
> args->oids->nr times would allow that, but if there is no such need,
> nr contiguous allocation of them,

Stepping back a bit, the design of "odb.h:struct object_info" look
rather curious.

Why does the struct store scalar values like "enum object_type" and
"size_t" as a pointer to elsewhere, and does not store the values
right there in the structure itself?  By forcing the caller to
allocate an "enum object_type" for each of these object_info[]
elements, the design requires 8-byte for a pointer to the heap and
malloc overhead, probably ~16 bytes or more, in addition to store a
single "enum object_type" that can be stored in a single byte.

We are probably using this pointer indirection to say "ah, typep is
NULL so the caller did not ask for this information and the object
layer does not have to provide one", plus "typep is NULL so the
engine did not give this information for the object".  But we can do
so with two bitfields "unsigned typep_asked:1, typep_valid:1;"
instead of paying ~24-byte or more heap allocation overhead.

Again, this is not something we can change in the middle of this
topic, but since I noticed it and found iffy, I'll leave a note here
to stir the pot anyway.

Stepping back a bit, the design of odb.h:struct object_info looks
rather curious.

Why does the struct store scalar values like enum object_type and
size_t as pointers to elsewhere, rather than storing the values
right there in the structure itself?  By forcing the caller to
allocate an enum object_type for each of these object_info[]
elements, the design requires an 8-byte pointer to the heap and
malloc overhead, probably ~16 bytes or more, to store a single
enum object_type that could fit in a single byte.

We are probably using this pointer indirection to say "ah, '.typep'
is NULL so the caller did not ask for this information and the
object layer does not have to provide it", plus "'.typep' is NULL
so the engine did not give this information for the object".  But we
can do so with two bitfields 

    unsigned type_asked:1,
             type_valid:1;

instead of paying ~24 bytes or more of heap allocation overhead.

Again, this is not something we can change in the middle of this
topic, but since I noticed it and found it iffy, I'll leave a note
here to stir the pot anyway.  It could be something we may want to
clean-up much later after all the dust settles from this year's
GSoC.  I dunno.
