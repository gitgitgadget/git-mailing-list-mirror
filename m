Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565242913
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525922; cv=none; b=uk0da06nPlozT/ezjHh2hVb477TlYk/JeNEEBCzEQmYF/5OnnmE+g1GiEX9RvoAvwSqF3TmyfjSyk6h+SazKIx6et53YWSdlKH9dfanrNMqD5Uq5Giqytq9gx0ThvpLGBf+UtHKvI3q7k+2QjzQBbGBatjK8gaVUeZ+YfLonIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525922; c=relaxed/simple;
	bh=odW1DmHqPqU3Uit7pclcO9TnqQsooSoceqO5oRLaypE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AzEeVJzJtmvVbb5sztCl6Lr4oKLGlYin2yznlizmSWFg3AT+D8cU/msbNcBUEFAEOzTOXI0Ks/WJL5BWhg8lco4sf+BTViPwgq+Z7qoCWcojTgGKSzYI9tzbcN8aUbQPR8hItuWbxCGxWSv7duuK+GerBkBeC42zTZVteSq4DmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=upn821j9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="upn821j9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 39AC43607B;
	Tue,  4 Jun 2024 14:32:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=odW1DmHqPqU3Uit7pclcO9TnqQsooSoceqO5oR
	LaypE=; b=upn821j9jkoh9jf2aPrXNWJTSl7EmDHyx1KDi6Gyqm/baMDkS6ocDk
	3Ni9mTtuSr5blZlBj2lHwmgqAw1b7C5QznjkDxyA/Szkz1hNWg6/xkjuu66tYDhf
	qC1h9TRi4DR/LizQwTzDubdSwELT6Qk1Ic6BRF3NI0iN0/x4MGV9A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30B503607A;
	Tue,  4 Jun 2024 14:32:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A00536079;
	Tue,  4 Jun 2024 14:31:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #01; Mon, 3)
In-Reply-To: <CAOLa=ZRzR1Nfqa1KA04W2EzAq0nM5Fr1p7PEfsukidL0-RsWGQ@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 4 Jun 2024 08:07:01 +0000")
References: <xmqqo78h1bdg.fsf@gitster.g>
	<CAOLa=ZRzR1Nfqa1KA04W2EzAq0nM5Fr1p7PEfsukidL0-RsWGQ@mail.gmail.com>
Date: Tue, 04 Jun 2024 11:31:58 -0700
Message-ID: <xmqqa5k0v9sx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BAD598DC-22A0-11EF-A77B-6488940A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Hello Junio,
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> [snip]
>
>> * kn/update-ref-symref (2024-05-30) 7 commits
>>  - update-ref: add support for 'symref-update' command
>>  - reftable: pick either 'oid' or 'target' for new updates
>>  - update-ref: add support for 'symref-create' command
>>  - update-ref: add support for 'symref-delete' command
>>  - update-ref: add support for 'symref-verify' command
>>  - refs: create and use `ref_update_expects_existing_old_ref()`
>>  - Merge branch 'kn/ref-transaction-symref' into kn/update-ref-symref
>>
>>  "git update-ref --stdin" learned to handle transactional updates of
>>  symbolic-refs.
>>
>>  Expecting a (hopefully minor and final) reroll.
>>  source: <20240514124411.1037019-1-knayak@gitlab.com>
>
> I did send in a v3 recently:

The above is the v3 on May 30th.  I do not know offhand if all the
review comments on the previous round have been addressed in this
iteration?  Perhaps this needs to be marked as "Needs review" to
make sure, but I forgot to update it.

Thanks.


