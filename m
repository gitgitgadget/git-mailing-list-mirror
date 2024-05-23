Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B779171C2
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481764; cv=none; b=bUmn4slr1hLS7Sb73WtaqxVmb5e9aEc9sqvUM4NlseaKQEN9NSVaaCIlLJaNJHlorz7ecgKSogMTbtsQY/6BKhxPh6tWBFqvCU4dNXi40MNIqtOVbd0bgRLCF5nZSOv6z4loq7+k0Vj1jVrJ4+FFrmZaCXtfc9Y+XZA2txs4rFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481764; c=relaxed/simple;
	bh=pRSv9Ppy8EIT06xW4pIbC7lHz7etAmXjRT/GEJqgQ+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OUrWi/rNcrZgWfcvCHBm1dHtKid+qKIHmA399eajzUOjygYqZVRfW7OyPT31itRCd6CjE6+yJ3396tGN5Tg8C5QsXj2KPb5c7ObOpkWVjYb/6ieD8vz7zwVm+kMR4qsc6ZGKFstiaSG2UZn34RT89/qigotwNGk/LrLqubZTs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=grQEXOSq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="grQEXOSq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A2AE31E0B;
	Thu, 23 May 2024 12:29:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pRSv9Ppy8EIT06xW4pIbC7lHz7etAmXjRT/GEJ
	qgQ+g=; b=grQEXOSqWuKLTRrCeCneAgzQn0/pEa8GGr/xZcZmnLcX3IJVFkzGyJ
	Qt2sUi1efaaqO7U+rQNJUkSN8LAINf3VRfQDzsVEeKSFDXtbYZvm4oWmT5wcCFkD
	EXRf5shbP2NiXSvwQYnGE3NxZdTtbWzYqu4/EFWFeCloIklYIAUmI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30E0331E0A;
	Thu, 23 May 2024 12:29:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 940A231E09;
	Thu, 23 May 2024 12:29:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
In-Reply-To: <CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 23 May 2024 08:52:32 -0700")
References: <20240514124411.1037019-1-knayak@gitlab.com>
	<20240522090326.1268326-1-knayak@gitlab.com>
	<xmqqbk4wy3ji.fsf@gitster.g>
	<CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
Date: Thu, 23 May 2024 09:29:19 -0700
Message-ID: <xmqqr0dsv6e8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B8F4636-1921-11EF-8ECF-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> The patches 1, 5 fix small issues in the reference backends. The other
>>> patches 2, 3, 4 & 6, each add one of the new sub-commands.
>>>
>>> The series is based off master, with 'kn/ref-transaction-symref' merged
>>> in. There seem to be no conflicts with 'next' or 'seen'.
>>
>> Wait.  There is something fishy going on.
>> ...
>> Is this actually a single patch submission of 9/9 alone?  Patches
>> 1-8/9 are all old ones that are in 'master' already.
>>
>> Puzzled...
>
> I think this is just a mess up in the range diff, I haven't changed
> anything locally. So adding the correct range diff here:

Quite honestly, I care much less about the range-diff that is almost
unintelligible than the actual patches.  Your title line says 0/6,
your updated range-diff presumably have 1: to 6:?  As a sanity check
mechanism, the list of commits and the overall diffstat is a more
useful part in the cover letter message so that I (or any other
recipients) can use to compare against the list of messages that
appeared on the list.

We may want to teach "format-patch --range-diff" to place the output
of range-diff _below_ the list of commits and the overall diffstat
in the cover letter (and at the end of the patch for a single patch
topic).

I'll ignore the range-diff in the original cover letter and see if
the rest makes sense.

Thanks.



