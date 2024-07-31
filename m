Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053543169
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451865; cv=none; b=HJLK+K+VDafzedSnVms4ioA9a+0hatuw9xfGb2g8OMRsRAg8oX0gTpjucpZpOfkWhe0FkS+wImMW/4NSqhvmlNWKJzv2L/CwTljarWPaJWIXgkBmUrTXACIcAJCSyYekm5bXa/4rMiw98tneoYQYnmheZLBc+yoG5DfyM+fMuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451865; c=relaxed/simple;
	bh=WCExPBk4JHtr6Y5S03X+99vhAtj+tv8CKAxr2XYb/9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qtrJ2ENpMwOY7yKjK6gAv30+FowcffXnVw9YfVw/LUXcffXU6kJDQp46Zq/zVyGtMAdhSfLeVO5ox3KbK4tATd0l1hzg1o99frZuRYIqrALaZdzDah/ZcCFsz3kdRBiBB/lMyxErz/tL4pZN/XmtN1jGuNbJjItvxdzc6D/6fv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ycyYv4aP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ycyYv4aP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C1501E050;
	Wed, 31 Jul 2024 14:51:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WCExPBk4JHtr6Y5S03X+99vhAtj+tv8CKAxr2X
	Yb/9A=; b=ycyYv4aPrz8joILbjFKC+fWYMd0fOyQq91Yr/7rJp4/o3sszmYbv6u
	k8Ie4f4MefIyXGmJCWsBUoeFDv9h1i2fRq/rXhfJplsyulTzot7iTB+wBQcACgXV
	J05/NVM6w1lpnbo8bqnIYQ2uviuBs3myNtxMqhWtyl1mtSlkdsSRI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 038C61E04F;
	Wed, 31 Jul 2024 14:51:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 284D31E04D;
	Wed, 31 Jul 2024 14:50:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: A U Thor <shyamthakkar001@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Josh Steadmon <steadmon@google.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
In-Reply-To: <CAP8UFD04uQbWhY0QDp+nC8VyBvpUs=tBDm=w4CzKK2GcwFZdGQ@mail.gmail.com>
	(Christian Couder's message of "Wed, 31 Jul 2024 19:18:08 +0200")
References: <20240711235159.5320-1-shyamthakkar001@gmail.com>
	<20240730115101.188100-1-author@example.com>
	<CAP8UFD04uQbWhY0QDp+nC8VyBvpUs=tBDm=w4CzKK2GcwFZdGQ@mail.gmail.com>
Date: Wed, 31 Jul 2024 11:50:56 -0700
Message-ID: <xmqq7cd12y5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D3005056-4F6D-11EF-84D4-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>>      +  const char *query[][2] = {
>>      +          { ignore_case ? "Key1" : "key1", "value1" },
>>      +          { ignore_case ? "keY2" : "key2", "value2" },
>>     -+          { ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
>>     ++          { ignore_case ? "FOObarFrotz" : "fooBarFrotz", "value3" },
>>     ++          { ignore_case ? "TENOR" : "tenor",
>>     ++            ignore_case ? "value4" : "value5" }
>>      +  };
>
> I suggested adding the following test case:
>
>                { ignore_case ? "FOOBarFrotZ" : "foobarfrotz",
>                  ignore_case ? : "value3" : "value4" }
>
> to better check that things work well especially when not ignoring the case.
>
> This is because, when not ignoring the case, there used to be a choice
> between { "fooBarFrotz", "value3" } and { "foobarfrotz", "value4" }
> that can be decided only by the case of the key in 'query'. But
> instead you removed that choice from 'key_val'.
>
> And it seems to me that the new test case you added doesn't bring much value.
>
> Maybe there was something wrong in what I suggested, but then please explain it.
>
> The other changes look good to me and seem to address the suggestions
> made by others and me.
>
> Thanks!

Thanks for a careful review, and of course thanks for working on the
patch, A U Thor ;-)
