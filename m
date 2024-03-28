Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59013328D
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642753; cv=none; b=U+H6j4cuqMl8+883HfFPKGERLZLqth8Tjggn0Rz/Y5dYNZRbl2/LOH+2BSLsjXfKMafvaseZkqYiYpkObiv9N2/czlFoXgmLf53ZZ3u0PUveRuXLx+DJpPTmaFeLUyXOsEz3luWGLWVDwptjXTdT/suV96nQDPV0vDoeF9teHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642753; c=relaxed/simple;
	bh=tR4oQ+DpaqMb/y+3t9ey1H6Z923XoBADSmgY2Shv9ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kId+yAcuRueSmF+KdI8I5D4hUto7HCE5JcceheooIhzswH8wM7d0Yg2nMabLzccJt9yB/WCpYWX9a6lNPcSO52ag62+lfFL3lSTbTuIdoZd74pMLooKWWTJmyIUDqdUcM0kDtHYo9ORiC8xVcw3zl8+NBGlTytFVMXRe6TXLj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DbThy713; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DbThy713"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 737FC1EB393;
	Thu, 28 Mar 2024 12:19:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tR4oQ+DpaqMb/y+3t9ey1H6Z923XoBADSmgY2S
	hv9ZQ=; b=DbThy713Za/W1LdAZ9lPqKUTkD4u4iYoiSuVP6rRyuoULdKZoUP8c1
	hHQdaYKqRy+4JkWeC73zL0GkfRRjmDoAFt32WBz9uyczDqigKFaRnNH9vEekG855
	7sO4zuNd4npAcv0b79d5KFdgLSYdWQ9icsp/ocylr1Mwn/9aX21w8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67FAF1EB392;
	Thu, 28 Mar 2024 12:19:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB06B1EB391;
	Thu, 28 Mar 2024 12:19:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Han Young <hanyang.tony@bytedance.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] quote: quote space
In-Reply-To: <20240328103254.GA898963@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 28 Mar 2024 06:32:54 -0400")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
Date: Thu, 28 Mar 2024 09:19:08 -0700
Message-ID: <xmqq34sawcqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E84BFCE6-ED1E-11EE-8509-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

>> With the following band-aid, we can skip the test and the output
>> from "sh t4126-*.sh -i -v -x" might give us a clue that explains how
>> such a failure happens.  Unfortunately GitHub CI's win test does not
>> give us insight into a test that did not fail, so I did not get
>> anything useful from the "ls -l" down there (I already knew that
>> sample patches are empty files).
>
> We package up the failed test output and trash directories for each run.
> You can find the one for this case here:
>
>   https://github.com/git/git/actions/runs/8458842054/artifacts/1364695605

What I meant was that with the band-aid that (1) sets prerequisite
so that Windows would not fail and (2) has some diagnostic in the
code that sets prerequisite, because the overall test does not fail,
we do not package up that diagnostic output.

> On the plus side, while trying to find the failing CI job, I ran across
> and diagnosed two other unrelated failures in "seen". ;)

Thanks.
