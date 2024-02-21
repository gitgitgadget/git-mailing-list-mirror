Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360682D8D
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533865; cv=none; b=h9btZOZ8ZzE43TGDb9jB97w4Mlv71dipV+EEYJkCNHFQ0SrhpscuLrPYHoVbt5UzOiRFjydwU+j8JzyzS5afPzVr4T/KPg2nu5h2TdEhuGshYeSndT5L0X1ZdJxoSGQpEdNc4N8brxQCxV3TOk6wG/VWUB3TDQdvsByOxvvyNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533865; c=relaxed/simple;
	bh=vmki06YuGcrLxlsAxlbjiFxL5311FAw4nnwpUTvacuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ILf7UEP1VGcz5ouL/Dxaj9ayZrLJrSR5sGVDEdQe3uIG/BiPOMBWujna1XSqHnFE7ijgBKiUZYljIKaOa8V0quPKXMTWe36Hf7gtSOmvY08i+VSSnGFJ/+FN5TAlyhBMpMm5c3+SAnhYUW2oPElyALpthleAzyVG9ypJeh8/RCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W0pxueev; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W0pxueev"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D601310C7;
	Wed, 21 Feb 2024 11:44:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vmki06YuGcrLxlsAxlbjiFxL5311FAw4nnwpUT
	vacuQ=; b=W0pxueev5X1blStJKHobzUFkFgJ22FP6wqzQuikjcPpN5G6gtpi9wf
	/SBLBg3f5gSUkPijA81ZnV8dUbuqa7fV90j48bxWoyfEqq24JPIk7tg/vDAOwzvC
	alS0gzJy+ZYEqM87JIjD+6sJHwBmvGBYJ1dYA1KKVCJCoyc+qbZZ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 55C8C310C6;
	Wed, 21 Feb 2024 11:44:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EAAC5310C5;
	Wed, 21 Feb 2024 11:44:19 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #07; Tue, 20)
In-Reply-To: <CAOLa=ZQOtDgyWxmV+C9r_wfqo-KdJ5uqW4KwJKD8WdT9qM0t2Q@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 21 Feb 2024 10:04:06 +0100")
References: <xmqqplwrqbd2.fsf@gitster.g>
	<CAOLa=ZQOtDgyWxmV+C9r_wfqo-KdJ5uqW4KwJKD8WdT9qM0t2Q@mail.gmail.com>
Date: Wed, 21 Feb 2024 08:44:18 -0800
Message-ID: <xmqqle7drcm5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 759C9424-D0D8-11EE-923F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> * kn/for-all-refs (2024-02-12) 6 commits
>>  - for-each-ref: add new option to include root refs
>>  - ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
>>  - refs: introduce `refs_for_each_include_root_refs()`
>>  - refs: extract out `loose_fill_ref_dir_regular_file()`
>>  - refs: introduce `is_pseudoref()` and `is_headref()`
>>  - Merge branch 'ps/reftable-backend' into kn/for-all-refs
>>  (this branch uses ps/reftable-backend.)
>>
>>  "git for-each-ref" filters its output with prefixes given from the
>>  command line, but it did not honor an empty string to mean "pass
>>  everything", which has been corrected.
>>
>>  Will merge to 'next'?
>>  source: <20240211183923.131278-1-karthik.188@gmail.com>
>
> Let me know if there's something more I could do here.

Hmph, I do not recall what the plan for this thing was.  Wasn't it
ejected from 'next' so that its UI can be rethought?  Or did that
happen already and what is in 'seen' already with a new UI?

Thanks.
