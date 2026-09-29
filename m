Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92249541E54
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707203; cv=none; b=Sk1NdjymJO624VKzrh7PliN3kOIbH6F7mij6ywcBNFWYFM26LzWajonEvECQV0qcn3e+mD3gcI040yGgbsYcxzYqLT4Gu3hA6DPzRlYSY+oiwIUe7UgLzdpvH6IRWWK8hXr9BlI+nlgflgPYxYRpqPfhAU3LByX1+qypchXQabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707203; c=relaxed/simple;
	bh=PiOrYBUNOCDZTtXW3qUoWEu75YX1/ek1uqyeY4QOFkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V7dWg/A22o6HJMMn5dyMD4MG84BCd31SdipSSBGHrP4R7sMDepqMUeYxgftFFbjHUe2Dn+lGNlwOpwnVVoZGnh9S+rNRvyo+qGfWJOpC7G0SaPbTdH0GVgF/KUaxOdXuwp5mR3HfVyX3S41po4EvBR4XQUpcCoTTSJp/Wv23bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CH9yDBJ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjqbsMxI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CH9yDBJ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjqbsMxI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EC06B1D000B6;
	Tue, 29 Sep 2026 14:40:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 29 Sep 2026 14:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790707200; x=1790793600; bh=PiOrYBUNOC
	DZTtXW3qUoWEu75YX1/ek1uqyeY4QOFkY=; b=CH9yDBJ3ivTacwXv4Y8C4/xMkj
	SDqhi2+xU9vymYQyce4mmLBSeUM820R4D4kL7kjwtuhufKQtfB9pxJNzu+F+Kr2e
	K6Qa6JoysjZPfyiT8f7OPntp9YxkuzD3SHvpLA4vU7chkjgsZUQC3gKVTnCJBWv6
	fAsm14bVTwWRM2BW1hEjK8F9WVjAROiCbYbmU63Vxa/WhLMkYv+pYGs9FAapfywB
	qSeZPrbZoxXuBXVatjBY4rUXVS88ofxN5m803Ul6z+C3qDc9apZxFUPlSb7DuNZv
	Ukx9CWsjBZII7wegBd3XkuCEXoAI2dvf+kP1zvLuTtDdFdW3+kdLdAH+ymuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790707200; x=1790793600; bh=PiOrYBUNOCDZTtXW3qUoWEu75YX1/ek1uqy
	eY4QOFkY=; b=bjqbsMxI3OAc6m3c3Al9wLYg6THV841CSXH1SV641OdjqIjMQgD
	ikQPa45cSu+eZL7cXpWfeIKwVpJIVSTLHio8OSj81TeIKLtARQNDS4tGsXEheqJO
	Y0Oq6l0losQVGdkZHwerfd6mCmcmeOTd63CV/dPciA0OelVzpFs1zS+ntw96eB0V
	o7Z+eSDgFZ4iZr1FXyPN8+OeK4aDXpGV+XYE9c4F0ptyaswJUzDySdvWJeZoN6gb
	SRaIZPW1uVrUVPM+6h8kPtrz+CJXjDAJv2h9iI/lB+tkSHsVMObS8egF8FJjD/zb
	PZJYAp9F5Pi66N5XaQNM7PDkdlmP4BlnYjQ==
X-ME-Sender: <xms:AAa8aiKj09jJLv4Uvbq1Mf7JvGemecZ1Pvx3ytwVn6juUqKkGWxOlQ>
    <xme:AAa8ahLCM7muU-2zOFOjxJvq0sOvIKLuHZy5RRPqz0DZ3meYPhSV6ji-S_6noovGb
    _J24hG6FYr4I4moVDOYDHbRAzYIAxvF01PtgCpucmIqbXtmtM7eX4Y>
X-ME-Received: <xmr:AAa8anvb503M6FYzrhuxK_SVUCMRH42YzErh8m7rsrhcquoeaM7xKQ82RyI22gRVKz6qX4TArOceSOrDbX2Xu_7P4eQmay2i5O5c>
X-ME-Proxy-Cause: dmFkZTFqzWnY+NpywGyHGQHCbkPRbIEUtMeL7NgkSLE29ZRAwH3ZjsxSffrihCrq6znPvi
    HFZz2/HwkzZ8nPxw2OtRBqkrTmWiFdjQVNlbVHnaDH+ulz+tXtMxVm+y9Kp6Ue8zzyYs43
    /ymShR4ryBLhTTwJfhKTR7mAoOaHlL4M8+w4mkB3dpcsToRRqQiCw6V6mQIU1k3Mcq4v2F
    zDy6bJQmdbM6V0uvpbEhZ9brzJEkSpNAyogR4t0YE/5iCmuMuFgzu6u+u9ey/AEzYAO1W1
    eKG0wX0Qfdo0fCwd7iwMKEGHFumulDhlegvGltYPwKB616VUJqhjhxgoY1Qmj2av53eOBZ
    j4l5iXYLEk+ZJ2ghMeDHwf83sEZ3qsT+64t03JnrvfFx0jPOheQ5kFL1mXUBsRksWcYeWB
    JAaNgPk6uPh3wA0miFuvMhDV42tCq9nFmIpUY/tgS1LyZaQ3WLfZoyshz8Lb7teKYrd3u3
    25pLW/QnZWeyh9WNYP4xIyw5XS/zhNJxSDzXU9UFJBuNuA7xJmKGZ5shZzlrYfR9gZgM0J
    yfRN+/Tc1oToxkueAgsM52oDYa9Urk6JX80s4yXQdftAcXv/xjPPkQghLfEeqONet4a7LI
    8ANyhPKX94Qb6csURQEaBQlXd2P/s1E2iadd5xCNVTXILzzgbvzk1wcg2dQg
X-ME-Proxy: <xmx:AAa8amQDbVORqXlRQDBlhY6VsQSRf08VsRQk8BLQTDtoymzzO311NQ>
    <xmx:AAa8alN_5_s3kNfNsDOg25Cdkz4xwGP1cmaTqv0LjhDBNn7XkCoIyw>
    <xmx:AAa8ajYWEOcYQxTVCcaM_YpKRYWL9KnB9Sviiayr-TqP427QzAkWtA>
    <xmx:AAa8anwMgasscdmz8jb8l929wjo8xrsl1JSJd9B0zLMx3x8YCjbMgg>
    <xmx:AAa8atoWBMCdO0qsbT4RuTsHSn4Z6qrMJg8-u7Lxm1HG1e6ZDihCgSEy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 14:40:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/5] xdiff: replace mmbuffer_t with mmfile_t
In-Reply-To: <20260929065239.GB1697497@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Sep 2026 02:52:39 -0400")
References: <20260929064935.GA1276867@coredump.intra.peff.net>
	<20260929065239.GB1697497@coredump.intra.peff.net>
Date: Tue, 29 Sep 2026 11:39:59 -0700
Message-ID: <xmqq7bk3hpfk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Our import of xdiff has two identical buffer structures: mmfile_t and
> mmbuffer_t. In upstream xdiff these were actually different, but the
> import in 3443546f6e (Use a *real* built-in diff generator, 2006-03-24)
> simplified mmfile_t to a simple buffer.
>
> In xdiff we usually use mmfile_t for input and mmbuffer_t for output,
> but they are really both just a ptr/len pair. I don't think that having
> different types is buying us anything in terms of type safety or
> semantics, and having two makes it awkward to use the same helpers for
> both. In particular, an external merge driver's output is read from a
> file, but we can't easily use read_mmfile(), since we want the result in
> an mmbuffer_t.
>
> Let's use mmfile_t for both cases and drop mmbuffer_t. The latter is
> probably a more descriptive name, but we have many more uses of
> mmfile_t (and helpers like read_mmfile). So let's consolidate using that
> name; we can always change it to something more sensible later.
>
> There should be no behavior change here; this is just consolidating the
> types.

Obviously good.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I guess this step might be controversial, but I hope not. I think the
> ship has long sailed on trying to pull "upstream" changes from xdiff
> (there haven't been any, and we've hacked it up quite a bit already).

I share your prediction that we will not be "synchronizing" with the
upstream.
