Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06437175A8A
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423096; cv=none; b=BDELQzr2Kyhxl2ViM/+FOPQH79m9IhGdVJ2LZsqhZOHu4sW6KR9ZUkEW9uMmzWGEuLsoBfcXSc5V4c/ooY7/YrxZmjqq9vWhTiK0LWnL1jbd7qlVxqDPrd1FTEwhsQ6HlE9dwkJa67DCmQ6rOcQpNW6LHVg9toMJ4u/nk1R4le4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423096; c=relaxed/simple;
	bh=oG0ZxXZ2eu1E6GaUrJ0ZhqTd85YNwgc8QqhsR8EqOX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1jSEKmBkD2MSViPda8eU+sqIIb9I/sgOOYCOV/ARo1Z/8teyj1HyxX9ut7VM159kI48E6qcXPXUWBJ3C0zrhOeKUDSsEyN9yhjzL2smMAgUKzT+TCEkxjQ9N0gVruaXgHCIO676Rt662hOuzkPzVZBfdbqlgkbSbqMYyduFkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iy75SuUF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U3ITugiz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iy75SuUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3ITugiz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 26D61EC010B;
	Sat, 18 Jul 2026 21:04:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 18 Jul 2026 21:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784423094;
	 x=1784509494; bh=HPqGmulWBQoU4JRiuVi0tobFrRNF+w80wAhJa8LwdWI=; b=
	iy75SuUF8lagNvnd1Z4lVeBFuI7pmI3JGhBwuDC/omV14zJZonb8I6bMytGbLam0
	APu+sI7/jpi9OQwyf3sBD5fthgoIIklL4s8IHbYhYZDZD2krN4xvtadNMinuXOO2
	sLwqGVqLad4RgfuuktbXizf06kVvmurmFBdWGUArYcxE8C7TX7JoaeAOWLKByIy4
	U1nyQvZ5Wd2yTR2W8EuLBIUBA+w40WqJfYlVhfjAEkJbNJdfC/y+dbUTtvDbVxIN
	deij96DZMkkPsR4BdDoOAQeHjD/6YNOjMIr3/vjf+TVRNVHc0VdRcflY2xp3+WUK
	sqcaD9hiIJ5PYjXxMt+AXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784423094; x=
	1784509494; bh=HPqGmulWBQoU4JRiuVi0tobFrRNF+w80wAhJa8LwdWI=; b=U
	3ITugizoZWCR83Zq+Cl3MKaxnpd48dk4zsOYdP5MleZbz2Q6+f5VAK8FTTxOJbGM
	X9ey1zhwKR91t/9b9Gd8TwRtDiBHGttykwKmKpv9+a2x8gKqgsyhbPsHMDu2+sHR
	IaWxjNCp4/aUql5m0Oolbvm+1Jzsff5ejzFaCaFGm0FuwkDdeayBKG/zR9b4cOXs
	Y84IaeySR8jbrveNENl0q+s4DQNlk3rzrdvQAHq4iKXqnBfP9rtO1W37JMFV+mZU
	9gMV6B1OM8AlysiLnY05P1SECdzBfiScTLmcRxlgBbQq/RvOeIDRa+oXJXfY42/J
	WOnzmvA68zKtnl6W8EF0w==
X-ME-Sender: <xms:tiJcanXgmAOOG7zKmbNlPdKjJDi2o9nEas69sRF3Um9DCfqyo117zQ>
    <xme:tiJcameWyV7_PAQakgIaimk-2CuiSMUr-kV-6l_O5gtzVgfhizh7y64s29wMbZK66
    i03G_MzzZoY1_C7aIQBsy4t2z2B8lo3vjCoo3s_7wKgtqYvlBCJe0M>
X-ME-Received: <xmr:tiJcarsm_BQG-UF9Ilu-ukwYXASJPNhYHByTUYJs3wZ4c99v-cTamxtCyNDQl1qFbvqTpuAb5kci2sFBn4x8_9gEPTDcy0wVtg>
X-ME-Proxy-Cause: dmFkZTGz/o0oKgKOYBjnPDN+6SEaDJZS7yxAWcFS7LjugyFA/Ud/s/4QI0ZVkTNF5j4WRs
    FUvJnpohh15+3uVrxKvAzbw+5s1T0lPHxjhXuNL4anRhcCS/M3feXTJaxGoQfWkRWZUY27
    ahAA+FDcVM8Ozxx+Xfjs4SW3tZWI7cWLwyjKL/Q5i9heDgEs2KZDnsShF8CGqLNkTBdTFe
    GC+dJ+meF5nJXGnuuqz/51fYMsDPIznu2DVF001aUqG9GIacP2d4YlO4tjDVOvMhDduBvD
    /6O/37Bkpuiqo7MRFK8YJIG5vjzckQZ4fJGMNyK4J/XeTMYKeobR6BZu6yNdbkgfJ/q5Va
    dACHiHcmIRkMCm4raNY31lscbeqrJmUuVEoL0MyPXapnb9at5PN46UPVBn98ZQigklzlLk
    FzCa3Y5rJ6pUqBV8FyQrjO03DDta4LybMcovF+v6VEnmNnwcK8Lg7nLrmjz0Cu5SrliAjD
    /mDbGGu8pzmA7laXkfr8g80tkavXo6RxYiLVxVBmmw5dau0IuGP8KaK5YiA1TeTpAVn3gp
    uxB/op1CSyYUuktLZ0aUw9zdptQDwlXNZKpLu7WgSHx8KvTOnnTTZwtJ+22+wEQduELh4D
    0hjEUACGaPe2Lp2c7LOIBih42KAiLYExF8rFldQSFHr3qpzdAyeV9H434sLA
X-ME-Proxy: <xmx:tiJcat-pLd5SRM_rUOsbfVMIGlb1_S1oidRAe_nvI76NmrDdfFUsuQ>
    <xmx:tiJcau1qudAwfao5-O7KWJIMsG8fTlJwVlphfVaN_XDN-A3y07J1Yg>
    <xmx:tiJcaqDOe5FgtsPOGmWdXFGuhubmVsuMmDzHo1tsF7wtUUh0wB-n9Q>
    <xmx:tiJcaicCFL_ub1KF_r1ZiZLTBXK4Dw7wVHJnR4exE4_y3DiAU-jQ0w>
    <xmx:tiJcatN4EMh4n43PEs6Cp1xtxsXF10JV3Xcy6xrX-f2xzEp8DA5KUG-R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 21:04:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH 0/9] object-file: move writing of loose objects into
 "loose" source
In-Reply-To: <alvWfOJb6vAsusai@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Sat,
	18 Jul 2026 21:39:40 +0200")
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
	<alvWfOJb6vAsusai@szeder.dev>
Date: Sat, 18 Jul 2026 18:04:52 -0700
Message-ID: <xmqq5x2brdqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Hi Junio,
> ...
>> Note that jt/receive-pack-use-odb-transaction requires an evil merge:
>> 
>> diff --git a/odb/source-packed.c b/odb/source-packed.c
>> index 06b31dd743..cbb06da038 100644
>> --- a/odb/source-packed.c
>> +++ b/odb/source-packed.c
>> @@ -545,7 +545,8 @@ static int odb_source_packed_write_object_stream(struct odb_source *source UNUSE
>>  }
>> 
>>  static int odb_source_packed_begin_transaction(struct odb_source *source UNUSED,
>> -                                              struct odb_transaction **out UNUSED)
>> +                                              struct odb_transaction **out UNUSED,
>> +                                              enum odb_transaction_flags flags UNUSED)
>>  {
>>         return error("packed backend cannot begin transactions");
>>  }
>
> It seems that you performed this evil merge when merging the topic
> jt/receive-pack-use-odb-transaction into jch as 9727bd8447 (Merge
> branch 'jt/receive-pack-use-odb-transactions' into jch, 2026-07-17),
> but forgot to do so when creating the base for this patch series as
> 1d64e64326 (Merge branch 'jt/receive-pack-use-odb-transactions' into
> ps/odb-move-loose-object-writing, 2026-07-17).  Consequently, neither
> 1d64e64326 nor any of the the commits of this patch series can be
> built because of the mismatching function signature:

Thanks for noticing.
Very much appreciated.

Will fix-up.
