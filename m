Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA0364D4
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258542; cv=none; b=jeHAaiGShXp5PWOt2AiZYwb8X5cFQbEhSLZq4sfTUqFkJzUfOmryBm7RH9AMPEfEXvpugIUIk67JrnYEt3kXCwYQbf22Xzez75fJ+BQze6hVrAhNM85WbYxKeEfUT8amm1JSMvQks2knC1FP5jNcgBO0F5i/fjWsgtir8gESk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258542; c=relaxed/simple;
	bh=aZZMYIpFWQOWvYB2DGfz3PXSZUn8H24oWh+tEpFggv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=igjDY4xzZMY3th44RZSJalvDgGontGEEzwGk3jpYriwX2LPYtS8rP2Vslgbdqgw8pKckJd/WGk7PKiBH0RxvDRIuML6ddoeCimi0NWd7KqUj9PQ+yWGM4nt9YejVzwD8IciPod+IzRZ1M55npkgtGOSbcVLQlEpHYYLsCdEfNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VKQl0Eaf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VKQl0Eaf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E50B1D0F34;
	Thu, 29 Feb 2024 21:02:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aZZMYIpFWQOWvYB2DGfz3PXSZUn8H24oWh+tEp
	Fggv0=; b=VKQl0EafjjJJzH2AM25uCIIiAyAEAxTvsoBXUCNQoTfxAUvjReVzWV
	GMcRJbnVSJoCbKWZgiS0IbbhzqPO9kE96tDUZGyteaBbBdZ+fwTaM+TfN1NfrD2Z
	I/bz2m35ruIrdo4vmK3tGw0b+v7a3HEZ/XCW9p7yQdS3pCEPMg3b8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95C121D0F33;
	Thu, 29 Feb 2024 21:02:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE86D1D0F32;
	Thu, 29 Feb 2024 21:02:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #09; Tue, 27)
In-Reply-To: <owlyil264yew.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 29 Feb 2024 15:56:55 -0800")
References: <xmqqjzmpm9b8.fsf@gitster.g>
	<owlyil264yew.fsf@fine.c.googlers.com>
Date: Thu, 29 Feb 2024 18:02:17 -0800
Message-ID: <xmqq1q8ubtg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BBF6CFC8-D76F-11EE-B729-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> [...]
>> 
>> * la/trailer-api (2024-02-16) 9 commits
>>   (merged to 'next' on 2024-02-21 at 631e28bbbc)
>>  + format_trailers_from_commit(): indirectly call trailer_info_get()
>> ...
>>  Will merge to 'master'.
>>  source: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
>
> Doh, please wait for my v6 reroll (will send to the list in the next
> half hour) to clean up the commit messages. Thanks.

If we had communication gap and the topic was prematurely merged and
was caught within a day or two, I would be a bit more sympathetic,
but given that this was merged more than a week ago, that's totally
unacceptable.

If you have improvements, please do so as incremental patches on
top.  I'll hold the topic in 'next' until we are ready.

Thanks.
