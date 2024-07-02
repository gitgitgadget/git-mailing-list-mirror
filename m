Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949821BB695
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933276; cv=none; b=M52INlkIzP9I0G/dUz7FOPDZGXiJReCmeG6msBF444xRPqDcShdniLGux38SX/g8rWfToetVutz67Ke323YzMjsxKfki1EhLllbpzfL09qNpIdoaeR5lEXYmxINiSmkmD65Aidr344UUthGgUQNu3pHC9jflvVNQ2/KMwxcBOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933276; c=relaxed/simple;
	bh=wS6OJQ1Wcgp/hltVcJW2uoLm5aEU7V2b2g7B647gAGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d18tI9m4PvStv2xjN0pqMkKY5KWzSSpMGxGGGe1089TgQMj7EG/K4KVpRR853qSvPTKRatHP9w6Qz5pX9uKa0hUrbvC7ukG8Wu1pRQyd1RApQVrHM47av+kjo6lGnLQWfWNPgBJJfdBNxaj4OuKnimTKp8aI/gQnAbx0bPC0qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BA7ggi3B; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BA7ggi3B"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64913216C3;
	Tue,  2 Jul 2024 11:14:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wS6OJQ1Wcgp/hltVcJW2uoLm5aEU7V2b2g7B64
	7gAGo=; b=BA7ggi3BezbvvUYfAUyJXCpDHdncMSLxqayHf9sn/afAxDAZUUXwIX
	QxNvRZ9DYRjFHKUmLcPkTrl69V0njtwn6zvJ1vLbtWDRxzqkaG3kPwyalbGWunsF
	1GouNJ46kohpHoRlwlLUphCTlTF1Y9exABiKlbSbeCkrWUiCcrTFY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CBF3216C2;
	Tue,  2 Jul 2024 11:14:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C460C216C1;
	Tue,  2 Jul 2024 11:14:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v4 0/11] t: port reftable/record_test.c to the
 unit testing framework framework
In-Reply-To: <CAOLa=ZT_x1Kf7EopU+RbBFzX3EPU5NWx6f8L9Uw=sM0MbCXDAQ@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 2 Jul 2024 06:55:56 -0400")
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
	<20240702074906.5587-1-chandrapratap3519@gmail.com>
	<CAOLa=ZT_x1Kf7EopU+RbBFzX3EPU5NWx6f8L9Uw=sM0MbCXDAQ@mail.gmail.com>
Date: Tue, 02 Jul 2024 08:14:31 -0700
Message-ID: <xmqqv81nsu5k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C924DC9A-3885-11EF-AEBD-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Hello,
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
>> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
>> testing framework written entirely in C was introduced to the Git project
>> aimed at simplifying testing and reducing test run times.
>> Currently, tests for the reftable refs-backend are performed by a custom
>> testing framework defined by reftable/test_framework.{c, h}. Port
>> reftable/record_test.c to the unit testing framework and improve upon
>> the ported test.
>>
>> The first patch in the series moves the test to the unit testing framework,
>> and the rest of the patches improve upon the ported test.
>>
>> Mentored-by: Patrick Steinhardt <ps@pks.im>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>>
>> ---
>> Changes in v4:
>> - Rename the tests to follow a 't_foo()' pattern instead
>>   of 'test_foo()'
>> - Use hard-coded test input in the 10th and 11th patch
>>
>
> Nice, I see my comments from the previous versions are addressed. It
> looks good to me now!

Thanks, both.
