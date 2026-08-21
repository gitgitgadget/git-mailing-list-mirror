Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901B390998
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356178; cv=none; b=Yr5zIjAFJ7/XVdkEKjC8sJ9AOqOb+THr3UiVRTILPvn/qah+Xx+rzP/IjnTUknZYy1a4X74rgdF0hGKWGpu7pfpnQgJlO2CrczacydYxR0LJ7JnL/Vwr1QXYhNOEUJf03YutY5yN9cWrfbvT2HVtO6J7gx7vh8vq+WvbqKVUT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356178; c=relaxed/simple;
	bh=kLYOAM1DQCv27aLUDF0xlMY+YDWZxnXR7wMTftJiJUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cDqzZIgUXq8mBgtMOSmrGyPGX0HQWLGHuRf/h3E/ZetrzoYaqrwPZEb1F9xH4ehOZCWyTOvIeb/v9lo7nhJ+YLgzMQZCSxsfIja1WgwIiiO8fNxKw6wSZLfnNLqcB5HIWflAkqdaKJFZTjBrcY0zTrf1TtmT7I4uOiADWWSjXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q3ld7VMe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y2JU/Dic; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q3ld7VMe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y2JU/Dic"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B82F1D00132;
	Fri, 21 Aug 2026 19:49:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 21 Aug 2026 19:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787356175; x=1787442575; bh=kLYOAM1DQC
	v27aLUDF0xlMY+YDWZxnXR7wMTftJiJUQ=; b=Q3ld7VMeBepN9Pjkh5N99ebi3A
	IDbh2peExJXRZZQk215Oyoe2FZ33IRiXT788QCfEsha9DkZZdP+FmE+Prjd9MXC+
	aYr5Nnp4YlSO5s0eEoN63VvT0CFCH0zYv6nkRm7rWEu6TY7SaS1Ct4AgUgUs+7A8
	/7i5vYOEd4XshyBk19ZQ6BQI3MpWS4+LSPZ/58VhvBMEL5CkFyTc5RpwEbLQ9W16
	q44yoGKDP2iWGpByR3Gcd8MOP8PnuJAMunsl8JbkORoHXtzJW57kM596Ae1vcpgu
	S8CqbHVaNWwYGp62JXzuBfioZfLJbcPDr/t9KxsOeafW7sgwDoGO/py15Ong==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787356175; x=1787442575; bh=kLYOAM1DQCv27aLUDF0xlMY+YDWZxnXR7wM
	TftJiJUQ=; b=Y2JU/Dic9rkoUYf43unJkLawCe0cLTyARnoufwNiGxTQ7H/VTgq
	PTb50c6snKB2CDKUYw3Zud7iyYPMH7E3ig47h1ZAWZUXyeicM6TxT3SqQaO2/W7z
	/U4wi3eRRw1x+Bw2UHEsJvaBvl+sK4onc77W9C9TXXWiXv0qTwHUvpbELH4KTT+j
	kN81hN1BLx/G0aDEc9WDo3ex66WIHct4lTqEmNY9ROIgTrgl0pvNIcYtueuEl1Cz
	fdyLrPbAFxRdM+Ry3UMxcP3DNCx08xuvIixUQpEXFirbuya0TTcN5MHJeVNCpCdR
	dTaNprrbbK9L0qRjunUC3QCLtfkkHOhXWJw==
X-ME-Sender: <xms:D-SIaqrnHtLEJl9ZsbQyxjvmsoi-1upDOIBDAsRt5VmoqtXJNKdQtw>
    <xme:D-SIasWgdC-FcLaGtzK0-q0A1fv31ekB9aUyx_Zky1nauN9rY5dLff4svkCaUULWV
    w24bx6dvXMlr-aBWIi5MbKvy1o7x9wrfpYz-_govAcgODzZbP_xHg0>
X-ME-Received: <xmr:D-SIapDMeFFoRpZeiS26wJMgR5viXlPBigoIBt1fE4RrPZPSWdMRRTNwzSOnmXbnDLgdjnAeu1P5PqxRmKIdvI5z2zIHAp0uqQ>
X-ME-Proxy-Cause: dmFkZTGQluhLwrEBbbdDzkFrlogHTk5B4tDcyTWc7o2heJH/IpYfmaGgDoI+C9o0fu28A7
    JVM7knkA4LJRKr4EZswVqYxVwtdUqL6leFd2fWx8VHPC5mQaVyI3Rp9W15CVRrM5u+bJ3w
    YAL410GuvCR7mqLlpmt0I/dgQ/CV9JAhtZML+T+RtbHrYVwn3Vq540+mb1AY2S20jg9aZA
    GBWyukNeK0iZy/9sk4cxDtdEo5KYPkOuFd1Qw0CaStH6KwHmqgucl1P3YOoQqBv3Ry9cXO
    CWGLzAF8nd5qgSJJ75NtjXVJ4b8vY0HnFZ/bqfWoIcW4vICy96sLgrIvg2WthsI/o2b0fL
    LZ40GfpKBrE8ObmbzZFxH4VFSwwxpDo1nE6R0+TrOfSDXBEaMa5yO9g0tIY5CGpqSy7mme
    ernIr3MOFG0XPrF+HCkzy0q333X/cF85BcQ9+NT2VwRfIGrpFwSU39ozdR53fQzLERYkRu
    bBIKJvFoKLHCIeJO2M7qXjPDhrtOHK+6iJB/HOCfD5pubBQsHoOHwR32oozTM8JY9mhdE5
    D3Hn9ej6EJ+lrBbXZdYYXHiSc7fQHZSvh/fAkoF5Ha49MC8298i9RALKQaRY+xSb7xzeRJ
    INV3x8f5LCpjqb1WbW1+Bn9sI28kt2WrZYMNZzS/tPgoABh4mGr2oX4WJzrw
X-ME-Proxy: <xmx:D-SIag3p5ZDc671z5q44GYLWKTRhtJCPBZYMSiYwjs-fiFgvLQc-YA>
    <xmx:D-SIar23t8XuIKiipNOTAP6rI8t8FvwzQQ-XYa8pnSuYwAhDmOentA>
    <xmx:D-SIalAouRXIPVzXNLLxTO0AT0-5lDs3aVOVz_TD0RJ9gkYA2CPY2Q>
    <xmx:D-SIaq6A1jG4ND2ebgBuB2YlFPI6tN0Swx7p5sIMX93VJT6cW6hNzA>
    <xmx:D-SIaiOKkAARcqi-_Kh_NlDTBRUWJZJYljFkYnkhuoV0QiaSsThfhvRw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 19:49:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 3/3] worktree add: improve message for ambiguous
 remote branch name
In-Reply-To: <CAF5D8-vDzp9xhu96Tu0ScmWRHvVyi74MD0NhPMnQ9ayoy6h+wQ@mail.gmail.com>
	(Yoichi Nakayama's message of "Sat, 22 Aug 2026 08:15:49 +0900")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
	<dcb84a69a6a65085d468a0a212cea0281605c5d0.1787259838.git.gitgitgadget@gmail.com>
	<xmqqa4qgruvj.fsf@gitster.g>
	<CAF5D8-vDzp9xhu96Tu0ScmWRHvVyi74MD0NhPMnQ9ayoy6h+wQ@mail.gmail.com>
Date: Fri, 21 Aug 2026 16:49:33 -0700
Message-ID: <xmqqzeyfxcdu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:

> My initial patch included a warning and advice here,
> but now I don't think they are necessary.
>
> Even if multiple remotes match here, the command completes
> successfully. This could well be the intended behavior
> (just as when there is no match). In that case, a warning
> or advice might be superfluous.

In other words, there is no point in calling dwim_branch() from that
code path, as the end result is exactly the same whether no remotes
match, exactly one remote matches, or two or more remotes match?
Would it then make sense to leave a note there to consider later if
the dwim_branch() call can be removed?

It is a bit hard to believe that is the intended behavior, but OK.
It does not regress the current behavior in any way.

Thanks.


