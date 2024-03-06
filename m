Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394B1B59D
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766041; cv=none; b=puEqdl38RafXxKeBXAZg3x48/S8srWtelbeC+gXAcS9KaJryMFyobWUgI/xCOtBhAkBPKRuaWg+NJZ65gsAvkpeMK+OKp2em5v3ZYXlSjYMxvBqcVdgpOGnvDD2Honi51tC8pvgXQ63t8Ud9nu1LRaDvnyc/avcNvRQACOYb9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766041; c=relaxed/simple;
	bh=jcgr6QIAqoX9PwgXmB56/RO1vwMGwJhkpqH7+ZBvzhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGjwANz+xVJxyGxoyRfy1oAQ44JkQMKdqZsgsxsIrEUqS9o9qZb38JiPZ1P7vl6PYkymOGabogKXPGZ3XxocoP/65vQHpd73cKVcmHR2+Gldvww+NH1EPd2SMfiM4FNErICLHyWnVh8oeBary8LJ1wbhFo1u3FjcZtN1TKU1p4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iycB/zsv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iycB/zsv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ECBE1E6C49;
	Wed,  6 Mar 2024 18:00:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jcgr6QIAqoX9PwgXmB56/RO1vwMGwJhkpqH7+Z
	BvzhE=; b=iycB/zsvirMut54cqYbDQ0iUrLgXxktz+UsN9n99vcqLsK8i5o9yJO
	DKougVlMNqpkxszFPrOXEaBQGB4G+u11Gkk0qolfXQVSoX/EO6oMyTOAgB0+cP+F
	LMy2jib+PGS64KjBzHDLBp3+abv0sSCkM39RIYS5KK6TTvcMEa0+c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23E3F1E6C48;
	Wed,  6 Mar 2024 18:00:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 716741E6C47;
	Wed,  6 Mar 2024 18:00:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff Hostetler <git@jeffhostetler.com>
Cc: Josh Steadmon <steadmon@google.com>,  Jeff Hostetler via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Jeff Hostetler
 <jeffhostetler@github.com>
Subject: Re: [PATCH 4/4] trace2: remove unneeded calls to generate
 'def_param' set
In-Reply-To: <f1c1847f-49fa-5573-55f4-7cca401df401@jeffhostetler.com> (Jeff
	Hostetler's message of "Wed, 6 Mar 2024 17:54:36 -0500")
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
	<e8528715ebf97c12622c2e73f914ab4228a0927c.1709566808.git.gitgitgadget@gmail.com>
	<ZejkVOVQBZhLVfHW@google.com> <xmqqwmqfowfo.fsf@gitster.g>
	<f1c1847f-49fa-5573-55f4-7cca401df401@jeffhostetler.com>
Date: Wed, 06 Mar 2024 15:00:37 -0800
Message-ID: <xmqqsf13otii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 593B882C-DC0D-11EE-84B2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff Hostetler <git@jeffhostetler.com> writes:

>>> Reviewed-by: Josh Steadmon <steadmon@google.com>
>> Let's see what JeffH says about this.  I agree with you that making
>> some stuff redundant in [Patch 3/4] and fixing the redundancy in
>> this step does feel somewhat roundabout way of doing this.
>> Thanks.
>> 
>
> Sure we can merge them.  That's fine.  I can send a V4 or if you want
> to just squash them together that's fine.

Let's have a v4 describing the change for combined 3&4 in your
words, with Josh's Reviewed-by: already added to the trailers.

Thanks, both of you.
