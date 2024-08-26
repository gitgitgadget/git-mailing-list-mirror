Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B22A1D8
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694534; cv=none; b=lrk/Yq2/Ec/EFZA9/LCawM/5HkOjnIIIbp+YNKlPie4zlWplzIzBSyQ2p80xPDwSYyHoWGIF60NTMU6PlOJKtO65/qy+ylxMHPMS2s9xnYUrDt38UvhslnVfJTZOhrYa6p88X8PstHZlfOwXNsrx8qMFaIRp1xnh3J8EXTRk4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694534; c=relaxed/simple;
	bh=z9KmjmBHhzjiTs+VDUn0c8MH0tz6D1azQ94KlY4Dn54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P5RBSeQ74erQbSgJvGtsK9Gd+YqSRlk2ogP5uzFVxrRcBY1lOhfIjKqkOPSZvpUGinhzCMI+ShiP6WCABj2iluXXUuGnYv9aaG0IFPm/6PEMYJEIwOzsIhiYwvf90zReLjIcveYrPbYrmSzl66did762hYERqDNs9XHI8ta8jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r50Ipo9y; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r50Ipo9y"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 21D0927FC1;
	Mon, 26 Aug 2024 13:48:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z9KmjmBHhzjiTs+VDUn0c8MH0tz6D1azQ94KlY
	4Dn54=; b=r50Ipo9ymjpxdeOd4HypQRWFASykJk9dmNINZBvu1vOHr39DH4F/Z+
	rWaszLNasHNYEFdvtrMm2Km2dsohFh09v/rTyp920ofMKrkmXGjUUnfrFhC21CX0
	tfimMJArifsAcHKoWTO9p0TuigNlq4LmjpLvvT0fR78p25BJgjE9U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 19BCE27FC0;
	Mon, 26 Aug 2024 13:48:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 906C127FBF;
	Mon, 26 Aug 2024 13:48:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v3 0/6] t: port reftable/stack_test.c to the unit
 testing framework
In-Reply-To: <20240826173627.4525-1-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Mon, 26 Aug 2024 22:59:40 +0530")
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
	<20240826173627.4525-1-chandrapratap3519@gmail.com>
Date: Mon, 26 Aug 2024 10:48:46 -0700
Message-ID: <xmqqcylvjhtt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 72BDB18C-63D3-11EF-820D-BF444491E1BC-77302942!pb-smtp20.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> Changes in v2:
> - Use 'size_t' as array index instead of 'int' in a test that is
>   modified in patch 2.
> - Fix a coding style violation in the newly introduced test in
>   patch 6.

If I recall correctly, the first iteration conflicted too badly with
other topics in flight, and kept out of 'seen' so far.  Have you
tested this series, not just standalone, but see how well it works
together with other topics by creating trial merges of it into
'next' and 'seen'?

It some other topics that conflict with what you do in this topic
have advanced (or better yet, graduated to 'master'), it may not be
a bad idea to consider rebasing the topic to more recent 'master',
possibly merging other topics into it first.

Thanks.

