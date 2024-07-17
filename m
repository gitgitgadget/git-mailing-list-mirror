Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296C1878
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721259628; cv=none; b=QkRFiGqyNOxyHHusUyU1PWiZC1AlF1AqyODabRZxixm0Q0qt5Eq6x2TSPsEAFHdfAOVkebNzKVUz9AQCZnpbiXwnzvZ6qnE6yY7XMA1I6MGUtBSMgGHKclF43T1Qt2PyBkOVRiM8zJ2mJdcLQF6NGf++aTMMNIo/q0YuWabwHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721259628; c=relaxed/simple;
	bh=Gow2WnfcY5JlffbYntuZ9uH/XLt6inSFTUquIO69bAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oj9lhi2y4Ae5Rp3+o8v/t834F4sQ6xWQGrzU8xgC4QTA9HfUbikHLiT3oZiVSpIbxOC5LAAr4/1vHRF8u9h3bUXHQ1tpueklUutA6otn24lrXdmIoXBZLvfz/oQzWL3RT4vl6/ZVFtLbyfHNwbVc2LBOE3XYyFiW/1LxZDCCwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bx4y/D/q; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bx4y/D/q"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A966C383F7;
	Wed, 17 Jul 2024 19:38:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Gow2WnfcY5JlffbYntuZ9uH/XLt6inSFTUquIO
	69bAg=; b=bx4y/D/qVwudlR81rKRQiw7iLGmdT+OhOYFRFstTb4jJLQ4i7mOtyY
	Ej4LMeIP4wo8sBL6JlCYiFezwVGsQY4nL2dOgpm3sdwNOYBImbKJddQFB862d4sy
	pdDWa89+dSSAs4Cyu0bkCkqCb7Cm6uBMZRy+XjR4VBMQ/VazwgvK0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A1D92383F6;
	Wed, 17 Jul 2024 19:38:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 365C5383F5;
	Wed, 17 Jul 2024 19:38:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] checkout: special case error messages during noop
 switching
In-Reply-To: <CANiSa6hs1AEp1e+o0hT55DvCwPe2EUyU1EXg1E4BKCkeuEOPvw@mail.gmail.com>
	(Martin von Zweigbergk's message of "Wed, 17 Jul 2024 18:05:13 +0200")
References: <xmqqikxnqzz4.fsf@gitster.g>
	<CANiSa6hs1AEp1e+o0hT55DvCwPe2EUyU1EXg1E4BKCkeuEOPvw@mail.gmail.com>
Date: Wed, 17 Jul 2024 16:38:22 -0700
Message-ID: <xmqqwmlj1te9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A8AB046E-4495-11EF-9557-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Thanks! (This is a fix for a bug I reported internally at work.)

Glad if this worked for you.

I'll mark the topic for 'next', but being so late in the cycle, one
day before 2.46-rc1 gets tagged, it is unlikely that it will become
a part of the upcoming release.

Thanks.
