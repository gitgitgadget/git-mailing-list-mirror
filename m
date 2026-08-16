Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40F282F10
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786908660; cv=none; b=adnJTKlzJR6/pM2ymW5Ul8LQjrIdYIqKwEaQHiQX1NHV2zfIOWIxCoedGmKnnohKCqiu+/6ZARulI0K8RM2NeCnhoXRjGw/oDXwLD/yXI//gc42VXgwgAK27GDDlOGcsRumpc7b1Ww0ySKU27FxMqRv/XPe8n0JdDwgvREodB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786908660; c=relaxed/simple;
	bh=uwt1Gk0w/F32+s31Jw/QoE3jsfI7I84dDPOMxBhicZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNeDoDlm1y5F91l+FBfuScDtJQcQ5sZZyhdNJ8qGlDNy2VyFlR5uAwSlosUGCvb8DUTnpYZXOY2WJ+CKWrW7er4JfptyGOJCpRAORHpQg6qp5/fTEwNyWTs18UP9XuSGw5OSSklc3dlzVs3/UoZQ04XABeXTgCqVbm6l9VXzQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BsuzbHbD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTMxfS41; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BsuzbHbD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTMxfS41"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EF197A010F;
	Sun, 16 Aug 2026 15:30:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 16 Aug 2026 15:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786908657;
	 x=1786995057; bh=gHJFhh4QXL9f14JZlvFM+a3FcEa13aTrUxFh0LV4aVU=; b=
	BsuzbHbDYzsXXmVs0KwOWRVXoMnYXTri99dcd+SAHcvz1Ow+UkvPFI+aGu04I5qO
	q5l15J//lEYTPYNjhkLusAvCHA/bjTcrVHsjsgfXxKFthtXXHF0bYOO4bFsIW/92
	J83DMlERmiwsDfO8UafB6x5tkotbeduOWZ4NQ7yYjnKO6RYhP+mQEAhZBDOwoGov
	0NUpzTAi9k1AvG9/W0/AQj6b7Ocsv9iNj/5bra39S4YVOj+EvzS9UuACb+zT3UJN
	lj9GS0vNkT1e1BDUuS1F1AshDftrzvN8h7dCo85nriC8hqm3wEon8QWLZmhlzNlO
	tgWH1se/b3ABvTiyRkCHRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786908657; x=
	1786995057; bh=gHJFhh4QXL9f14JZlvFM+a3FcEa13aTrUxFh0LV4aVU=; b=J
	TMxfS41AlasjYARb7RcUEJ8/53MRWzHOJEspKumw8QAuuGRFSRnPcQKkz4ZzjCo+
	+KoqBifn7ip9scYxoqUOb8QzL0Kkjd3A00r1f6MFG7q23LS86DUstfZz2DgjyXyE
	ky6+XQFODvB3bqCPkGHmN9Rg/A02s5XCpU71Tczi0bra/SjzNZZ20hiKs6Qc85nT
	XSLYRe8gjxt9886mAis9EheEbUKqY+u7ZcBQQRELixcpnmHhkXt6Pj7lnADYxdr+
	YFNrN/z67n74eQAQL75zDVq8t5tDKqzkKXJutdHc7i7nOWkxYedCYXLVpGbqMrma
	Lz7ru4cSVX/RY1gcrVBig==
X-ME-Sender: <xms:8Q-CalI1r6uuEj25EL3guvmNjGFYUVt8lGk-v4yVlYddShUSFdTG7Q>
    <xme:8Q-CagNbglUFdzs4lxRhMrdvC6vZtJrPoD6yIUzKGNLyrA5XC5cF_ErUtXDC2UJOr
    277J2ZsW-vXT1MnENf5_ycaTbP6OxzLI2OLXXwzkNuamzzkVxzR6qk>
X-ME-Received: <xmr:8Q-Caj4wlpq-TSPFAMx15sJnKX7pisaibxwJ3geO0rUQdCo5yO8O07pRQl_ZvfYKdQwCx4EwjDcSgN9XUJtQPkHPnk6mazb0xw>
X-ME-Proxy-Cause: dmFkZTFFdMhFu0Ynx9YUiZ4VbXMg8KTur8M7aslbgepzt7fGS0e1BhILpGTUCeumHEhUmR
    T+xlEsP9FfYwjFMXcEbptrmmU9zS/jjENb++rZ4uqmv5/t+Zh+a/OmAm0aNpyiIzulE23l
    ClvRBsK7oSp9NjN5W3Z6rsqmAz6BLYswKYjWDJS9cG9Hqja8JTxSVjA3xLYhv3swmOxCIp
    F6a33f/uK8S+j2VSsM10NISySTjE4B8XL5/zNSMfO1FaoOSBMmEbctZDMF/ffIwLOt50va
    xTJBrxr8Sy0xWJzFJKimhsE1ixB8mS6xbwRo/f2bwPf8y0CMSEY5yun26kyKNj+Dl32UmW
    22W4nXAQabRcnpCwYJGBTtspsI7dhnP4osiEd+pbuDnVyZnr2suLbOsaCd+cXf2fWcoFS1
    uv3S0C4WqC5aBu+RnyyfZ4Mv/LbJqCDpDIrufzWeF470ws8EIVB1ayg3r75JQgq5/b2vfq
    mO++62LUR4xL646z+3WNYJ89SWrpsPZk4tMieFL9sAmkYnNESTuSUnwCBDQc5sbSp797Wz
    rilJ49znB1OdOaaUJQR7Tfwc+j0PFcJLczoZTAP/NL1rX8DwFMwr1kkD8IZ/Q8fRP0X9sd
    AOUF64KCpefbP4kq+TX/3wuk2fkSEcJ6oCeJpi80E4Q4WXlaXk4dUPd9u4Tg
X-ME-Proxy: <xmx:8Q-Cai5cW3PJR5KFJ9MC44omgRSIYk9mqgQeUbmxRtRADA0schC2KA>
    <xmx:8Q-CahEiXjkliGQtLRJZW-IwCXgeXR2MpQwkSgZ-FOZUtVWXaXmKZw>
    <xmx:8Q-CaiXFEwbm6VQWuqjidXLhZc_xGnO3K8ZpKHEYleDDYtKLhmdrjw>
    <xmx:8Q-CalV_abAZE90EuUSU_vuzt4ITjHz3ML26tBZ1nbvKkKzOn9oV8Q>
    <xmx:8Q-CahoLEtd_EQSU4MXEdx3FYnKAVeHvk8tg-gcGfQ5WadeLKZLyksSm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 15:30:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Marc Branchaud <marcnarc@xiplink.com>,
  =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,
  Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH v1.5] worktree: Fix out of bounds read that causes data
 loss and reject invalid empty input in worktree add
In-Reply-To: <17e8c4e6-9eeb-4c71-9297-d8d5771217d8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 16 Aug 2026 19:51:32 +0200")
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
	<52ee6501-24ac-402b-b650-92a829030380@web.de>
	<xmqqwltwz36a.fsf@gitster.g>
	<17e8c4e6-9eeb-4c71-9297-d8d5771217d8@web.de>
Date: Sun, 16 Aug 2026 12:30:55 -0700
Message-ID: <xmqqik599828.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 8/12/26 12:46 AM, Junio C Hamano wrote:
>> René Scharfe <l.s.r@web.de> writes:
>> 
>>> From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
>>>
>>> `worktree_basename` tries to read from memory before the passed `path`
>>> string, if `path` is empty (or only consists of directory separators).
>>> That results in unexpected nonsense data being returned to the caller,
>>> which can lead to issues, such as `git worktree add ""` recursively
>>> deleting the current working directory, including `.git`.
>>>
>>> Stop reading out of bounds in these cases to avoid that behaviour.
>>>
>>> This leads to `git worktree add ""` consistently exiting with the
>>> message `BUG: How come '' becomes empty after sanitization?`, which is
>>> still undesirable, but at least it doesn't result in data loss anymore.
>>>
>>> This fixes https://github.com/git-for-windows/git/issues/6346
>>>
>>> Signed-off-by: René Scharfe <l.s.r@web.de>
>>> ---
>>> How about this while we're waiting for a reroll?  It implements what the
>>> commit message says, nothing more.  Follows the style of the first loop.
>> 
>> This one I think is obvious and clear.  Why not take the authorship
>> too so that we do not have to worry about DCO?
>
> That feels unfair: Matthias did most of the work by identifying the bug
> and removing the premature subtraction from the loop doesn't seem very
> original to me.  Ultimately my main concern is getting this surprisingly
> impactful bug fixed in a reasonable amount of time, though..
>
> René

If we can get Matthias sign this patch off, that would work for me,
too.
