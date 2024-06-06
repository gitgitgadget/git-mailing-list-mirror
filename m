Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF3196D90
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689770; cv=none; b=QShDN0s6pOWrb/Wb8tXhrsVkHhjjfLQQnYROSGcP1SwjtINPmySZDg7zCFoFYNTItg4SJpYkDt22dMe8EFh5dQuUAXbplQYmwe9skHlytQGGWZLK8Yyo1G3qeE1L7Zn3pqQIHUJ2ThVrClGCUwqrPq4BNNDaJQlErf18Yd3H+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689770; c=relaxed/simple;
	bh=Ih8cy8uou/D4k5Qn+H4hll3qyuCaRNwqdB5DedePtW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exd7NH5JbU6cAACQc/ysiFJt05CHask2bi7Mw9j3+yFftPNctJtMskul2JG6WPyfVfHE2qvI5qxkRY/dHEkfvNszhez1u74CowGsbQnxGvT6+Ieqg6/nrU8d0a7vRU6TA5QICs3gprSz1+hnENYMMdz4xCAM7sQLnOHGUT+Gy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ez29MyQl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ez29MyQl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1A42E656;
	Thu,  6 Jun 2024 12:02:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ih8cy8uou/D4k5Qn+H4hll3qyuCaRNwqdB5Ded
	ePtW8=; b=ez29MyQlWUziVHym0mLHj/7e/cQf2plZoYjvNdr0257zY/arE0BmKW
	UGqzVKbZwEmKVCQC8lodjFObEwT5QUX5QhzKPnEIFqlLbRWl0Om5dKWHUJdN/9xj
	KtEqxtU5ediaSrLu1kYb2OnMgXf3kAHR/vAH1pqr3SXAR5qNxiY+A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81D632E655;
	Thu,  6 Jun 2024 12:02:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6F152E651;
	Thu,  6 Jun 2024 12:02:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Taylor
 Blau <me@ttaylorr.com>,  John Cai <johncai86@gmail.com>,  Dhruva
 Krishnamurthy <dhruvakm@gmail.com>
Subject: Re: [PATCH] attr.tree: HEAD:.gitattributes is no longer the default
 in a bare repo
In-Reply-To: <20240606083216.GE658959@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Jun 2024 04:32:16 -0400")
References: <20240501220030.GA1442509@coredump.intra.peff.net>
	<ZjLfcCxjLq4o7hpw@nand.local> <ZjPOd83r+tkmsv3o@nand.local>
	<xmqqfrv0ds7f.fsf@gitster.g> <ZjPTlrMdpI+jXxyW@nand.local>
	<CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
	<xmqqbk5ndiqk.fsf@gitster.g>
	<CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
	<xmqqzft6aozg.fsf_-_@gitster.g> <xmqqa5jzqd5k.fsf_-_@gitster.g>
	<20240606083216.GE658959@coredump.intra.peff.net>
Date: Thu, 06 Jun 2024 09:02:44 -0700
Message-ID: <xmqqle3injob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36D9CCEA-241E-11EF-83EB-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I think 51441e64 is essentially a revert of 2386535511 (attr: read
> attributes from HEAD when bare repo, 2023-10-13). I don't know how you
> prepared it, but I'd probably have started with "cherry-pick -n". But
> that wouldn't help, because the documentation didn't come until after
> that in 9f9c40cf34 (attr: add attr.tree for setting the treeish to read
> attributes from, 2023-10-13).

"revert -m 1" followed by "commit --amend" might have worked well in
this case to get rid of the code that came from one and doc update
that came from the other in a two patch series, but in general, that
would be too much noise to wade through in general.

> Not that it really matters much now, but always just curious about how
> we can avoid missing stuff like this next time.

The series first did "HEAD tree is used in bare" without doc, and
followed up with "configuration can be used to name any tree" with
doc that mentions the behaviour of the first step as a special case
of default value for the configuration variable.  The only way it
could have been made easier to spot is to introduce the variable
with documentation first, and then do the "bare repo uses HEAD as
the default" thing on top.

