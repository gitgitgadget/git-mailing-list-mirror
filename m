Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28B18C38
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720887929; cv=none; b=lyI0CqcE1r0L/De5OZ+OyNEcDoKupCmosigyX1TYnDKJXAXQTYw+C+d0He/ri/rXZakg4WoKqh0BAMiTxDB0Ra8ObfOmkt/4sXvZCTHVlz0kVjUMSwV+BW59GOvZQjvrc5qTkwJZbDhTCGFB/I33CxEDT38tDzQk7xyS4+V4r/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720887929; c=relaxed/simple;
	bh=1HtUF8VFw3sE9214ramKqwcGEsQbJOoc5txrHgw7baI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSdIG5LgWL5H2bcVeq3VLQRfu7YuVkCGMEsl430MHzdEjCfj4NQ4IXXGitLEzo4qcIE8jUE2twMvm7yS60mNZCvvhfJO8Ujp8GlLJhrOz/k+e4rQJj1qIvzTdPTZQGDoRgOcpblruP/SDHq9nnZKrPcuJlr5lrTQVe8oFveJhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SgKIkqrk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SgKIkqrk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 552332A6DD;
	Sat, 13 Jul 2024 12:25:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1HtUF8VFw3sE9214ramKqwcGEsQbJOoc5txrHg
	w7baI=; b=SgKIkqrkf47+1ddxYwCXLDAikKMIm5ZQcjGbekDJ2HcdRR+LSBY/Qt
	LhGrubpWLG8qjNYPddECA+hszPhOji4hGd+FbWRvVlmcUgZ5IYBnz6Bq1XKhwWpl
	gxqZLAfDyqxc9S+voVudahmj0s2uqz7QvRRKfoc/bcjjOI95ESDZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DAE12A6DB;
	Sat, 13 Jul 2024 12:25:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B23D72A6DA;
	Sat, 13 Jul 2024 12:25:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Rob Linden <rlinden@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: problem with parsing of patch files for patch-id
In-Reply-To: <CAP0H_AGw2R6JPxd=8gAn0w1Fy6iY71LRkH+F7uHL0PVmE04B_g@mail.gmail.com>
	(Rob Linden's message of "Fri, 21 Jun 2024 20:15:47 +0200")
References: <CAP0H_AEd1jFNB_dO=HRjwEUKzFqnjntss_1wskKU6hE1VmBs+A@mail.gmail.com>
	<xmqqbk3uns4s.fsf@gitster.g>
	<CAP0H_AGw2R6JPxd=8gAn0w1Fy6iY71LRkH+F7uHL0PVmE04B_g@mail.gmail.com>
Date: Sat, 13 Jul 2024 09:25:25 -0700
Message-ID: <xmqqh6ctb6oa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8339940C-4134-11EF-8D48-965B910A682E-77302942!pb-smtp2.pobox.com

Rob Linden <rlinden@redhat.com> writes:

>> Rob Linden <rlinden@redhat.com> writes:
>>
>> > This patch (also attached) fixes it by only considering commit hashes
>> > in a "From xxxxx..." line:
>>
>> If I am not mistaken, "git patch-id" was designed to read from
>>
>>     git rev-list ... commit range ... | git diff-tree --stdin -p
>>
>> where we see
>>
>>     9005149a4a77e2d3409c6127bf4fd1a0893c3495
>>     diff --git a/path b/path
>>     index ...
>>     ... patch text here ...
>>
>> so I would suspect that limiting the commit object names only to
>> those that follow "From " (i.e. the format-patch output or output
>> with the "--format=email" option) would break existing use cases big
>> time.
> ...
> Hello Junio!
> Thanks for the clue, You're right... I only work with the email format
> so I didn't think of that.
> My solution doesn't work then...
> I had a different idea first: to check if we already got an oid and
> only read a new one once
> the current diff is finished (and wasn't empty so far). The other one
> seemed just simpler.
> I will try again...
> Thanks & all the best,
> rob

Since then I sent a series [*] that was designed to address the
issue you raised here, but unfortunately nobody seems to have paid
attention and the patches are left hanging.  It is part of my 'seen'
branch and in the broken-out format parked on the jc/patch-id branch
in the https://github.com/gitster/git/ repository, ending with the
commit 3226bd87 (patch-id: tighten code to detect the patch header,
2024-06-21).

If you can test (and if possible code review) them, that may help
the series to move forward.

Thanks.



[Reference]

 * https://lore.kernel.org/git/20240621231826.3280338-1-gitster@pobox.com/
