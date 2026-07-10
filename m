Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6831BCAE
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653067; cv=none; b=WUUcPeMiV4nOcVoJZKlqvTLVzBiWFzKRgMjPyr+KuUkSalP47F0FS5sXnMirVLVBlnTiiCIVJ8AAJd+yd4Qa5q7RMeGYRRpXzZKesXp1osg7Dg2Dj1Q9mv8KrbaVD3tySMZ5zw6dlWSFutaa7+36h6qj5nupUvoENJ2rn+PqIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653067; c=relaxed/simple;
	bh=dqzkn9GdhuILT7XIAXVCSE1+Kk5MKBRUi+H96lJHy+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JXeAkGBUldzyIQFevLglItYYeP5511K67/ozk6dQALuO9kG1wJTu8lT8ESPX7Fng+v1vx5Q+E4QmpTq2AYDbl0Fm5CaSICVc5pPlFEXaOQRCIvQzMlIcLQRPlaf48djW5dsbmDCcCnXkYxej+EnX3bFMgW5S8R01ZlVE+DtCBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p+B/cIku; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UArYTLxz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p+B/cIku";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UArYTLxz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 953857A0097;
	Thu,  9 Jul 2026 23:11:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jul 2026 23:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783653064; x=1783739464; bh=JS4fcvRvOe
	M4xZF2JoN3vqb/9EhohmJxStepN96Xoxw=; b=p+B/cIku6Ktaa6TYIwJ1cYJQ7D
	4LcDWlyNDBEpB9hm+rRTEiQZCMf/33keYy/wcV40A0Qm97hEjbVv/0AG/M8c/Unk
	2HCGVPMiLux3HXCrVZUcLm/Ldop07zD1fsGvTXW15/Ht1xJkqjmHF/VzxXJG6JrD
	/JGRI/EgeWAxzUnhkaYEUEPB4hlnUmR5amAH/Rl2wxJQ8DHUL5CWCS1e5Y5MhAI9
	jScV0A6pey/TglgqfIi3eRhNdp8X2tmHaUqCXJImVaB4ljszDLO/A7hexIZKNVVb
	+BGBlVEG3/zwjWvUkMKlUhKOrTpB5mUnLZ50HuYdrni4x0jlJZ9FyxD5Be3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783653064; x=1783739464; bh=JS4fcvRvOeM4xZF2JoN3vqb/9EhohmJxSte
	pN96Xoxw=; b=UArYTLxz/ivTH3CqFneoshrohJe2YoRALjEAhpEmsNaJJH18LpU
	i+8RFr+QTpyZOk5HGEWOsmfO8/poYfVWqwxqTDPqdq1axoPwAIHqy3zTApcEGmMg
	yU1DLT2QRekBYq69euIVaUKxnkDMsNEmJ0Zm0arI6wVNB7rqU2MDpYYc1YTXrlHS
	GUAAEbsKrf97g/IgkMeJDKumUDkhjpwI5eT6mTqsqE2uskinnB+4T8ZJph2Hwv1x
	D04pBGmyqNe+BvXSCqhfypGjMBxYM+Dtzfd2PIsnZv8xA5AH+ts5RetQOtm2c/E3
	Wlzmf2B/Zl2ap4XhZRESgahe3y3GyMlVZwg==
X-ME-Sender: <xms:yGJQap5H3cOZ8BdMP-2lFAEkey8HuSoNNQlLoEgQTtdEwO3NvSqIlA>
    <xme:yGJQat4yZqB896mJDavE0Ems3nU38IUYjUj8PDV7-Zdp0B6Y-fde6BgCtAeMPpLZy
    JJ_-kwr-DjpjxcrZNA3u71yVmqewhO7SfMeplQk1T6Xkjc1naV4bw>
X-ME-Received: <xmr:yGJQalcqyfNqE_3Z64f8LY-ZFCkH-Kk_NM5cUDArPboi-HQUFB4XpPMpZhHnfL3aSi3fP6uTf7HnOxOw918e6kHupl6Xhg-vn-aDk4Y>
X-ME-Proxy-Cause: dmFkZTGQoz0xqwSEdZMt6kNEgq4CGdR7DamQTWd6R3IxYDCw090RtDqoNA7HnrHiI39ZT7
    mtf/P8+vqJIXB3sdVcvRZ6YgpiVqhqDIh88dmDqM9HZIxBp/fvf0i4ZTHAfLr+0vPis2sx
    ctAVIytFoMFPPdc+nEC1SNjgNMsBpW6TAc08meo1ulnQBqXetKC0+AsVMJU6G8DATHDxzc
    ExlHDf03y408OogqKLxvH/revi+3c65xnp5lAnktS50ZgLN4INou//Ovmc7tYllYIO0O3R
    WobxAR9ItoXmEA7q1pA1+aMiaZuifNKQ7pMBGwQwKkyn8LmOl/56WEoOTSEZHnIZdn8jBT
    /+ZBqS9EAZvUMkQG9Q0CuLYb3JfXZpTcsUJ6DItwiG4D0JP9GM4Ko1FicA0pjaZc3HTS8G
    ohkaxjoV6fEf8qkL5/nXVU7qxQTbDFtz+ROlRL/4nWdZfdv7qNUbB2WRskCgLY/gO3zPzm
    gpJsjCKwal67rwSI4XEVOx1fWxEEVWnl7uSRmwDJU/+P0XDFhn3Z8tIKXSgxUe/7/v7kYy
    V23JtFtJUQ91YHG9NE7J3368FCijTGN8IpxONZLd1POxclhHzb4ekDefcB4qt8ojLzfKSM
    CSdqAEb9YJKGM7lXZhS2oZ4aSAVzpeI8WlJanH3GJzTOz4IKM+YgJKYLmU3g
X-ME-Proxy: <xmx:yGJQahA_BdyQSKa0Fms4-SIvfla5WqHJ_oqR84yzoB8J0mZB8QpWyA>
    <xmx:yGJQao9v5RRUQIZ4-FzfVrusJ-jgWSxMP6sAmFWOsvBLSoL25JKhHA>
    <xmx:yGJQasJHVTBBCHKEU-bMM7sw1e-vqDZpog7gphBAHQr138F9og5KNQ>
    <xmx:yGJQahjtih35qCGi-67W8fw3ILu38xa8caYC7lz3n9_zvLzs200MCA>
    <xmx:yGJQaq0PzVCTdm414Xx-aVe9KZ9wJLdZkCxOUSBaXQVV3os8xr5CuZM2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 23:11:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] diffcore-break: guard against NULLed queue
 entries in merge loop
In-Reply-To: <df00334f8b8cb85a928e1ca22aa12dd6b87fb154.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:28 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<df00334f8b8cb85a928e1ca22aa12dd6b87fb154.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 20:11:02 -0700
Message-ID: <xmqqpl0vh73t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The outer loop in `diffcore_merge_broken()` sets `q->queue[j]` to NULL
> when it merges a broken pair back together, and has a NULL check to skip
> such entries on subsequent iterations. The inner loop, however, lacks
> this guard: when it scans forward looking for a matching peer, it can
> encounter a slot that was NULLed by a previous outer-loop iteration and
> dereference it unconditionally.
>
> In practice this requires at least two broken pairs whose peers
> both survive rename/copy detection and appear later in the queue,
> which is rare but not impossible.

Interesting find.  This is an ancient part of the codebase that
nobody has touched in the past 21 years since eeaa460314 ([PATCH]
diff: Update -B heuristics., 2005-06-03) introduced it ;-).

Well spotted.

> Add the same `if (!pp) continue` guard to the inner loop.
>
> Pointed out by Coverity.
>
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diffcore-break.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/diffcore-break.c b/diffcore-break.c
> index 17b5ad1fed..b5bcc956cc 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -289,6 +289,8 @@ void diffcore_merge_broken(void)
>  			 */
>  			for (j = i + 1; j < q->nr; j++) {
>  				struct diff_filepair *pp = q->queue[j];
> +				if (!pp)
> +					continue;
>  				if (pp->broken_pair &&
>  				    !strcmp(pp->one->path, pp->two->path) &&
>  				    !strcmp(p->one->path, pp->two->path)) {
