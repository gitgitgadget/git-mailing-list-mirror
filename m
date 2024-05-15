Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736113F430
	for <git@vger.kernel.org>; Wed, 15 May 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782556; cv=none; b=dyIKvNHSjWi6086gktZ/Yg/LI+82t5RG1T1Ny8baXtGEGFdL3bFmuEog/vedzZy0uI0tkTgEwAXolz6CLQsU9cuZUl6weGQ2te/pFAEh9FUZRyj7BNOCvbbXb7Kokg5M121Ru25TN9YmGObrzuRhjewDS2GXbuqT95BXohYKqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782556; c=relaxed/simple;
	bh=Ayce2dCFGdA6g2Yf42MocdNQJA3pUI2rt7FuMPx500s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dup6TBqsiDWDN2NexCYVyHZoTIYBh++iASUgvQPHrwcFmWeDosyfTmsRTwDloSUpyDnRQxEqA7nvKwyaA0QyHWNJzK3de/DXuzApLIdeIaoLwj+oEXo4Jzi6QO/+VnbODRyddPpeFKpHXDOlagIDTMy/dgNrVKubLWFYevqfbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QQeCeIUC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QQeCeIUC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 762691D81E;
	Wed, 15 May 2024 10:15:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ayce2dCFGdA6g2Yf42MocdNQJA3pUI2rt7FuMP
	x500s=; b=QQeCeIUCRlVaqXohEuvihs9FnzWHhN6/VgK/U6kU3P7MJVHuKPGnt6
	4J5VRTKXI2vZ20nldBPFSXJh4K6IuuALOhWdzfi9ux+N1okopxnaHsxynqRJx9s2
	/tkPwIR3q7KdQD5HdaV+iVktFy/B3gkC/rzS0nqZA+evWsRIPEJlg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E7521D81D;
	Wed, 15 May 2024 10:15:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE8921D81C;
	Wed, 15 May 2024 10:15:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 2/5] t1517: test commands that are designed to be run
 outside repository
In-Reply-To: <ZkSpk3v2kRsdOcbQ@tanuki> (Patrick Steinhardt's message of "Wed,
	15 May 2024 14:24:51 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-3-gitster@pobox.com> <ZkLpTwNgFGFyC4_N@tanuki>
	<xmqqo79877oc.fsf@gitster.g> <ZkSpk3v2kRsdOcbQ@tanuki>
Date: Wed, 15 May 2024 07:15:49 -0700
Message-ID: <xmqq4jaz2may.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A224571E-12C5-11EF-A251-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 14, 2024 at 08:08:19AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > Is there a specific reason why this needs a whole patch suite, as
>> > opposed to adding the tests to the respective test suites of the
>> > commands?
>> 
>> Yes, testing out-of-repository operations needs certain trick and
>> people forget to write such tests using the GIT_CEILING_DIRECTORIES
>> mechanism.  Having one place where we have an enumeration of
>> commands that are designed to be usable outside repository is a
>> handy way to make sure that we have enough test coverage.  It would
>> make it easy to control how GIT_DEFAULT_HASH environment is set
>> during these tests to have them in all one place.
>
> We already have the "nogit" command that neatly encapsulates all of this
> logic, so the trickery is contained in a single spot in practice.

Heh, you asked for "a" specific reason, and I listed three.  The
tests that are spread across many scripts make it harder to see if
we have enough coverage for the out-of-repository operations, and
the use of "nongit" helper does not change the equation, does it?

