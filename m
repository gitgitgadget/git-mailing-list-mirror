Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C88F4E2
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560451; cv=none; b=UHqY77UIrTdEHJ3vSpKCYjLWGoP9ZhsQ/5dgxd6qMVonpw7nL6vpN4eRWUJdkDl9auMAXd9q6uX4+VuESlGsEjorLqaCRz8a9w+CoadZiHDZHqFI2fIK/AkNrifEQw4sRMRwlUg+U8S2YghbiJ4Ka+cKDFCIs1Joa67IAoqt1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560451; c=relaxed/simple;
	bh=u4Oj2tqYWEuWNQ/H3ttPUSuFCvPqwiDY2TZBTh0Oox0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXT5KmUZ+rJGen+hUYGrM4CXf3onAgYLLx+1yiGbAyaIPIQae8OWNN9JfNinv/1sIEYb5p91PGg7nMcB/tzXnkA2fogREv0m7+b+N4iMPRfN5SkZf3UgRtcdzc0yBppwuMKg+DMKaEsDPYL/Yrk+2T7hvuGV6f0bn1uifh+yD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F8W5h2+v; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F8W5h2+v"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E690E36DEF;
	Wed, 27 Mar 2024 13:27:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u4Oj2tqYWEuWNQ/H3ttPUSuFCvPqwiDY2TZBTh
	0Oox0=; b=F8W5h2+vBCBOAcLZXd6vT8LMDsEzqcgZFC1sIncM1wPlQj8XfL7nVt
	qhTQ5ip1jKGlqQlB/udr2RDQPrH7z1fmz84Z1xusE/5jKbUrD/nFffLKlUB6tqi2
	IZ2cSjm0VYnNpLgedWQFXtE/4UyVDmFRG0T/LGBd+CXHnMq32CXPA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DF76636DEE;
	Wed, 27 Mar 2024 13:27:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D1B136DEB;
	Wed, 27 Mar 2024 13:27:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ralph Seichter <github@seichter.de>
Cc: rsbecker@nexbridge.com,  Dragan Simic <dsimic@manjaro.org>,  Chris Torek
 <chris.torek@gmail.com>,  git@vger.kernel.org,  Ralph Seichter via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 3/1] config: allow tweaking whitespace between value and
 comment
In-Reply-To: <871q7wv7s1.fsf@ra.horus-it.com> (Ralph Seichter's message of
	"Wed, 27 Mar 2024 01:27:10 +0100")
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
	<xmqq8r2jp2eq.fsf@gitster.g> <xmqq4jd7p1wf.fsf_-_@gitster.g>
	<xmqqcyrg7imy.fsf@gitster.g> <874jcsvccq.fsf@ra.horus-it.com>
	<xmqq4jcs7evl.fsf@gitster.g> <871q7wv7s1.fsf@ra.horus-it.com>
Date: Wed, 27 Mar 2024 10:27:22 -0700
Message-ID: <xmqqwmpn1t6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4681381E-EC5F-11EE-A9DD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ralph Seichter <github@seichter.de> writes:

>>> I thought we already discussed this and unconditional "#comment" has
>>> already been declared a non starter.
>
> This unilateral decision of yours, and the following prolonged debate
> about spaces/tabs (which I clearly stated I consider a waste of time)
> left me with the impression that what I think doesn't matter much
> anyway.

You can call it unilateral or whatever you like, but there are
project principles, e.g., "try to keep things consistent", and
"making unusual things possible is fine, but it shouldn't make the
default thing harder", and they are not negotiable.

When it comes to quality of the end product, it is true that your
considering it a waste of time does not matter.  It is effort needed
to polish your topic to an acceptable level.  Either we do so with
the help of reviewer input, or alternatively we could drop the
topic.

In any case, I'll keep the three patches separate and mark the topic
for 'next'.

Thanks.
