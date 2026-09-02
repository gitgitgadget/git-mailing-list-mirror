Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0514A92F7
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375149; cv=none; b=jbrTeWpfa5SDGAUzGjqcS3vNO9vwyL5GzMJteuw/EH0YdvgSGIVVteYiXo9pb0zv4Y4QrDusP9hkrSU/52xNvlyTaiJ9QLBMiZcbRHl36Q/BNpF411CCHunn1jBOxRiBfcZ/LmuvdIzqqsu40gdEFy9SsxWgfltE5BrRmkQIgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375149; c=relaxed/simple;
	bh=U1cyUOU0Z4ecLp/SKJKIk6D7PlVCKkjC7D/w4A/ZL7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VC1AQQ4veVgA87YYhntdBBVxPg1k4RZi7oWUNUWFC2tOZ3zrcRosaDR+uTjt5mNC3DlrZNE2kX0g2dZZjHMEXw+m7GBqjms96yw99KP1puRO+DAhcorhMy/Hld1F7Fj87QpKMlPQO8uC+EDbjv8vgQ0mOKrCT6mjTOOmsqbHVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gDWQpeRc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFKLzNJo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gDWQpeRc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFKLzNJo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 495351D000A8;
	Wed,  2 Sep 2026 14:52:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 02 Sep 2026 14:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788375146; x=1788461546; bh=5t8+VttYof
	v/LCPnP78AenesFlxIVbfpMK4wDRSxlOw=; b=gDWQpeRcjTDj+efDxOl/gQhgia
	pK+JuES86GQK9a89YuEW6nsQooZxVlyTKpEJTYdk5vJOoUOcUCEVKHlkdbGOc6xg
	IoJbYYvDIViFC9xNLl7EznFV+vS5gRUXd7sGWFFrCDVZscFIBcFQ0ebKlpYqD4q3
	85KA5SzfzlnSBi1C2hk385T3R42PYYNn4xrJfCodu8+QR8zN8mZtBgwaDHRE4fjG
	1JAbk4PVUhxov0g2ElyeFMFuP3NfE8Celx57N6XOv1tDGNByg+kVRApLpZOl7M10
	mOdQEF3QuqK40Vy06O9AHiB6mHcmRwdrTGZFVT+um+X7AD2XSnQiyGJJHX2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788375146; x=1788461546; bh=5t8+VttYofv/LCPnP78AenesFlxIVbfpMK4
	wDRSxlOw=; b=CFKLzNJoiB7MJsHbVRbdcboNMIaxC2VxCIwvppKYVBmxQn0Gti2
	PJUnxmDAlZsqQDuB25chyGAHl0DcP7ITiYWhHmNr5WFoDhZXodoobjH5jVybHwMg
	Vd9h46Q5jcOmciUaXPopscgipYTcH6HbcbSzJUZNA2jVu94nEwKUXtmpoKxDbp+B
	yPE6C8G+L53ur9ifXMlOciwIbKZVb2DNp2aa46fSfynDbfD9w9+flLjMouOOfLfA
	GvAN3uQieUg56/Wg40RG8/NDeSlu03Y7A5D2mBXfQYpRFrWr1TpsqDHp/5kTT2Gh
	W6rre7aGsZP0XUWYVpJlW9k9M+d2jRUdcQA==
X-ME-Sender: <xms:aXCYavmIpXGkZv7CollNpOFef7t_8_uFbxdJYvasIsKxRS2jTiVJDQ>
    <xme:aXCYalboyoKGZdNFd8b6oIZclcgFOW1ZieAtvIDZO0L-q1mthutpctQg8Cldf8ZqC
    Q1A7kOu4nKcM-yWx-1luvohro9KsiDHC1MfqDaIafXWuVhLGLiA4Q>
X-ME-Received: <xmr:aXCYapQFiEe7SFbuMeLaTyqIxIQtARwbrOBS2Fp9SYQuNBqm6yH1qhTgRIT8INa1YQHOSd2-qAXFVxJTLbDC9fBpkVQFqQ9jbw>
X-ME-Proxy-Cause: dmFkZTFu/Hth5+pxyF4PHmKWi9PpspYqA+94uDqxY+E9MfSx+H05VJIzcnlw49l8jaLQUW
    j7M3rPrQfCgN75SVRwX890oRR/WUMe4ELkxI8p0alZYU65PLfAr0J5A21HmA5UjCKmV0pN
    2NjUCmjbegSQAyZOn03qTIHzZYfc5i8kolmz+dArZQdpW5dXkHYvep21Mj2ZdezfBQ15E2
    E+fS0x2tVBWTiJaNlNzeUaKeRyyEfNHpOntfWdptkBSH+UtHeNNOU1qeqy6cbnUgZ0KHKg
    kiwijNSQjWJVYJd8LVpwlmNtPBA7Lkdgk5vYOQamjBuFkU+n1jYgyxCAkpK4UQwEm+s7cK
    GqG/lt8QcYUI0oxjRd9DVd8FtP2iuFr5uupNsRyKXNJUbCjMuo0WIXy81TsN7+L0nmM/Km
    oArrPwog4V2d7xZPEkh9mERzfyGhKGJXuIeCrO9TvCP+DW0NJPfuNvGdsTxQfSmPPAudqv
    ejIdCos+DjW7syTEBE0ohWkUGL/k4mkvxw8dH/b7LFv4LlgGUmwWaQoQxDtxKDmqV13CNu
    YhktGBe+er1mpSx0W7H2SKRfFXl7VXr5Gdr0b6oIS2oIIHLEcELuDfgl+4v9VrmkweFUYe
    KqYBS21ejmyO1Lb3AqYuROCRt0dBnMSyinxTgQPwx4JQo+oGcVDZKGxEIMEg
X-ME-Proxy: <xmx:aXCYansN6jNhptqIkKl3QeGqJr55BD5lm7VcnvzX3SMyZVshrNh55A>
    <xmx:aXCYajFvqPvTTVVKXwqTAUZbfZAp5WkQVIIvK9xAGQaF_SY709oB6A>
    <xmx:aXCYagwUa4uC7GCO7I-4iWus3UIwnn8NEmrfx3X8rnilXRv54RsNVA>
    <xmx:aXCYal1NsTy6-RkvtUapolWljIbk4aE0wGx3FtgnwJQyT-tndBAjLg>
    <xmx:anCYahbQyqF0JCo8kZatqSNsKrVK3hWogtEB4A5-9OZKdn-4fdvjeIaz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 14:52:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 0/6] Standardize early option scanning to fix argument
 parsing bugs
In-Reply-To: <20260902161047.476753-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 2 Sep 2026 18:10:41 +0200")
References: <20260902161047.476753-1-christian.couder@gmail.com>
Date: Wed, 02 Sep 2026 11:52:23 -0700
Message-ID: <xmqqpkyviizc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A number of commands perform an early scan of their arguments to look
> for specific flags or structural separators (like `--`).
>
> These hand-rolled early scans are often fragile. They especially fail
> to account for options that take their value as a separate
> argument. This leads to disagreements between the early scan and the
> actual parse_options() pass. For example, the early scanner might miss
> a special option entirely, or mistakenly treat an option's value as
> the `--` path separator.
>
> To allow these commands to safely skip option values during their
> early scans, this series introduces a new "early-scan" sub-API into
> the existing "parse-options" API.

Yay.

> This is deliberately implemented as a new simple and fast scan, which
> has some limitations, instead of a full refactor and reuse of the
> parse_options() code,

Sigh.  In other words, we hate these ad-hoc prescan that are buggy
badly enough to replace them all with yet another ad-hoc prescan
that is know to behave differently from the real thing?

>  - `git bisect start --term-good -- <not-a-rev>` mistook the term name
>    `--` for the revision/path separator, so <not-a-rev> was rejected
>    as an invalid revision instead of being treated as a path.

Sorry, I fail to see much practical value in this.

>  - `git rev-parse --default -- <not-a-rev>` did the same, reporting
>    "bad revision <notarev>" while any other default value gives the
>    usual more helpful "ambiguous argument" error.

Neither in this one.

>  - `git fast-import --depth 5 --allow-unsafe-features` silently
>    ignored `--allow-unsafe-features`, refusing unsafe features from
>    the stream.

On the other hand, this may be a very good thing.

Is the reason why the ad-hoc pre-scan failed to see it was because
it did not realize 5 is a value to the --depth option?

> All of these commands call parse_options(), but for `git bisect` and
> `git rev-parse`, the specific functions doing the early scan
> (bisect_start() and cmd_rev_parse()'s main loop) parse their own
> options by hand after the early scan and have no `struct option` array
> for those options.
>
> If bisect_start() and cmd_rev_parse() were converted to use
> `struct option`, they could use early_scan_options_from_options() and
> would not be affected by limitations 1), 2) and 3) above, as both use
> the early scan only to locate `--`.

I imagine that in the long term we would rather see a properly
refactored parse-options machinery perform the prescan (perhaps with
some kind of "dry-run" option given to the machinery) than yet
another ad-hoc parser like this topic introduces.  It would be very
good if this interim solution at least took the same 'options[]'
array so that when we have the real thing in the future we do not
have to redo the conversion effort.

By the way, how does this interact with your other topic that has
been stalled for quite some time?  Would moving this one forward
help the other, or do they not have much relevance to each other?  I
would rather not see two topics of non-trivial size stalled on a
single author at the same time, so ...

Thanks.
