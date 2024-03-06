Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE53182C3
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761639; cv=none; b=laXWK0XUA0zWyhps4iSWy/73a1zWlTvtuKoOsjkqzzrJATxhW4yWfSejHYeJosFQOQXXMQqKFz1B0MxWQO3l0Jag1jToX6G/kjOuB8y9ejLI4xI5buCUHhgFK/yVq2Mpp17tlJoNBaHXsirPGX+D3lO3APItZbZnIq8ZL9v8ToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761639; c=relaxed/simple;
	bh=8WIPwbqYmvRWl3pSkUrnsk6k//3BL1PGJc2uHdSJsdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQeS4qcEz+9nbvuBCTrV+/MZqFqVPRjP7g0Nm3EHrFhTTysqkFPFo7JiYMu4aO9RPXqZYtZPgFwiYE1GX2/Tzl3oTTVUPxmTTzOGZLgHfXYrDUr6OLhzZjVvH0PfrWPQjxwcBFP30S43UL7AbEj6foHXKZ2y5KrIQV4ogXDund4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yJrefpMh; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yJrefpMh"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6624728F65;
	Wed,  6 Mar 2024 16:47:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8WIPwbqYmvRWl3pSkUrnsk6k//3BL1PGJc2uHd
	SJsdY=; b=yJrefpMh2YB9WP5+PqAvpJ3LLPCUhUnIoqY7hbzTdqhAoG5PaJn4Oz
	IkeZBQF83P0qdL+tb+YTbS198k/zgrNZkWBxMSs6sdDx5fzImKSdLXj9QaM3AQPb
	UA2bmDTrUABzIf86zH6VJ7GvGigJr0SzV+CMraoUruKHN5WHacQlI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F82C28F64;
	Wed,  6 Mar 2024 16:47:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5D8B28F63;
	Wed,  6 Mar 2024 16:47:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: Todd Zullinger <tmz@pobox.com>,  Beat Bolli <bb@drbeat.li>,
  git@vger.kernel.org
Subject: Re: [PATCH 19/22] t/t8*: merge "grep | sed" pipelines
In-Reply-To: <6571138d-16b0-4c59-b6fe-a256b1c7e37a@drbeat.li> (Beat Bolli's
	message of "Wed, 6 Mar 2024 22:03:16 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-20-dev+git@drbeat.li>
	<xmqq8r2ww4xg.fsf@gitster.g> <ZefSPAiTLrRVeXm6@pobox.com>
	<6571138d-16b0-4c59-b6fe-a256b1c7e37a@drbeat.li>
Date: Wed, 06 Mar 2024 13:47:12 -0800
Message-ID: <xmqq1q8nqbhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 17E452F0-DC03-11EE-AEF8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Beat Bolli <dev+git@drbeat.li> writes:

> On 06.03.24 03:17, Todd Zullinger wrote:
>> Junio C Hamano wrote:
>>> Isn't -E a GNUism?
>>>
>>> At least,
>>>
>>>      https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
>>>
>>> does not seem to have it (we may need to fix t6030 to rid its only
>>> existing use).
>> I _thought_ that -r was the GNUism.  The GNU sed-4.8 manpage
>> says:
>>      -E, -r, --regexp-extended
>>          use extended regular expressions in the script
>>          (for portability use POSIX -E).
>> That doesn't mean the man page is right, of course. :)
>> https://www.austingroupbugs.net/view.php?id=528 suggests
>> that -E has been adopted and, importanly, is more widely
> ...
> At least macOS Ventura and later supports "sed -E". I can't say what
> the more exotic platforms (NonStop?) have.

More exotic platforms may lag behind, and it is a very valid
concern.  Also, the bug #528 does talk about -E being accepted, but
wasn't it accepted for Issue 8, which is not finalized yet, no?

So it seems it may be prudent to stick to BRE if we were to squash
these pipelines into a single sed invocation, at least for a few
years.

Thanks.
