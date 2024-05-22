Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685CE23CB
	for <git@vger.kernel.org>; Wed, 22 May 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403679; cv=none; b=EEq+U3zeLjTXQto/uTjyI1X5k4dzvFpJIgtfMLrGZvDpltdsA2MVj/ZktplAeuwlnj4SPkvAPx6ah4W0MBdDor/Rja3UrO/5s0sGbQuf7vOM7vm+Hq9g5gWDpZ5CCiO1doZGqasiDb99h1hth5sSBlDZr7jRZ0YIIlKe1xmgRWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403679; c=relaxed/simple;
	bh=zLTySfhBl9BA/NddfThl5t46QnnkYMFLfRvHsob50fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZMUDuSSuJ0GKv5H8tJphAknPTf/FJnms2LXbjqNn8E1xD1YZHZEoF1Q6umV+Kb9n94X0JomQfW3TuNM3cygokiaAp6g9i6fM59xsQHz+9em0uGj7VtPOU3nval5BOWqxVoNZf83CzHGOnv3MIrs/O+p0lVpjPgHTOsxt5VJh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KRtCkOJZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KRtCkOJZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EF4C5191C7;
	Wed, 22 May 2024 14:47:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zLTySfhBl9BA/NddfThl5t46QnnkYMFLfRvHso
	b50fk=; b=KRtCkOJZQfS7irGNhOKudVzn9ZBz7xsvp5Mw1y04Fy8jdgZyynMwWP
	ghbSuaMzNDim987PNaxsmsoRRSy0OzFeP6XQphU7M8MD8JoKvqN6JULzqAU1C9x4
	8Wyl3ZnbX2C+Yi/vZ6vThcXa1IKyKn+QSz5Ep2gM1ksGia7MQLdrM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E7688191C6;
	Wed, 22 May 2024 14:47:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07B7B191C5;
	Wed, 22 May 2024 14:47:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] add-patch: render hunks through the pager
In-Reply-To: <1accd0163c96811b7b7f146e477acf89@manjaro.org> (Dragan Simic's
	message of "Wed, 22 May 2024 10:09:25 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<310a2904-681a-4bee-96b9-90a2dc107975@gmail.com>
	<1accd0163c96811b7b7f146e477acf89@manjaro.org>
Date: Wed, 22 May 2024 11:47:53 -0700
Message-ID: <xmqqle414rae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CCEDF51C-186B-11EF-A2ED-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> @@ -1387,7 +1388,7 @@ N_("j - leave this hunk undecided, see next
>> undecided hunk\n"
>>     "/ - search for a hunk matching the given regex\n"
>>     "s - split the current hunk into smaller hunks\n"
>>     "e - manually edit the current hunk\n"
>> -   "p - print the current hunk\n"
>> +   "p - print the current hunk, 'P' to use the pager\n"
>
> I think it would be better to move the description of "P" into
> a separate line after the "p" line, perhaps like this:
>
>   "P - use the pager to print the current hunk\n"

Sounds good to me, too.
