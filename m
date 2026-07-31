Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D742E8C0
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512043; cv=none; b=O18rNGYUTSff2Fh72EE3fVT3rYCCkV1SRwOQqZeU24FdxxXA3IV8m787ILpI7m1AFoqlI7GHXGQxQi+Ff1PC/yqudJ0DbxNAJ3RwvpYX218HYLnOQsLjLYVua8uFOWtcrDrNVixRcNaWJpFm9XiGjr8ueiXM8Na4ngODg4zrF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512043; c=relaxed/simple;
	bh=zF6C8cyUUU7ykzwLtOSySkFUHZ7vPRWUuJAJftQCw4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UegRgY6J4qgmL1S8NGulTkw2tQfO3R47K1Kys+G0OB87b3ie2F2yM3wANfucRHj1wlYdr/nYhvIUa9PF7nx+JG6s5y+2qUgACwgTPsX/G9DmDQ1b+8qOdLpPF9GyUuLr3YCEfpbwA0ZBbzIg7qAO0zKM9vt1v4NyHa6zcVhCj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O0ivCYEh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsO7WYre; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O0ivCYEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsO7WYre"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CA6314000FE;
	Fri, 31 Jul 2026 11:34:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jul 2026 11:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785512040; x=1785598440; bh=Vg9m0Xc4Hf
	D9/s/R2OzFrCV54BoHeXa323tOCty3fD4=; b=O0ivCYEhnrPbApbmaFplBbapIj
	iW0vSzIYLbfWFfMUqpzePdAZ6/sCsLkn6TRK3E49mvEUv3309EtEOKV45mHJfgeh
	3xI6NBTZ5V3sW7HZXXYX4VyVPycwr7yivy0EMzJXIjtECZXCAIJxfRar0I5EUizO
	Vn22ByDncnLrK1i2VjaidhzNBhuKvyKPSO8+rKuUqy4aflKO+ro15D+7nL2dR77v
	Z04w3WMgQ7c7yUIdCOaKXXNVpAgMETukLsVGQiDA7kl8U7NtCO66dY3+Dw1jYP1T
	nQn+Vh2rhzFZIGt8DFGQ3cObCgRTLVJOFKTACjnI9d8HrCXPf7px47eOp2iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785512040; x=1785598440; bh=Vg9m0Xc4HfD9/s/R2OzFrCV54BoHeXa323t
	OCty3fD4=; b=JsO7WYregXYM5xkgdBu8eG8u+9R/mmwoKDKQAH7ZgIXnVg/3n0+
	1Sc1BwYT4alZSilwvMVbtzbn5WPdQLCjtnejY1kYcnm3aFga+P0wy6XuXp3NIbmX
	bw2QvB+kNnygX2IUqrSRxbgmeq74Is+Rkf2dGZ4JH+UnWwymPygeT7j9HHS39tpD
	KA0gtB7WQV1RDsekroNpBGLDa5o+QVeKtCSYt89GdO6/qOaQRVkSTfTlZn0Xc38j
	gZX6oR/ngV219zerUPZLx5YFdNxq9lbKttUPdjl+hRjJsrhXDhiFMZxC6WPJOmpG
	1sCXIBsDhii6Kn+G1FojbGA7opxS5+zK7Ag==
X-ME-Sender: <xms:Z8BsavYaYXf9JuxznxBD4438Y9I5hckm_dHbfmvHfM0zw7vmYzGFOA>
    <xme:Z8Bsag9fDXSxKN10x89SrI2F-cos-rEkLOm14d_RXbfrsQpjyisyqTdYTvkTKO65l
    bYz3bm9FxcoaN8jFhkU5usB6XyzAvePoaokAzaXWEz0lNADQM0n0lM>
X-ME-Received: <xmr:Z8BsalnICpihcMK5ZYdIZ7UgeQfjM7HUl__x2tuwLl7lgUDRtck7-kjCJtWQdhwOvR6zJD0lTnjAgQBBpQhCaLp4HoVEowHkqw>
X-ME-Proxy-Cause: dmFkZTEGbMsiiZmAgmYeoPNoPEi5x2vL/vusXCas4wzvSkRsbSmKCUKqDrNDqGwoSgGanK
    41sFanJHsCcnRCJ3DT1VN3dw6OuhtaYFs291NsFk1bxtRzobgjkRvG/u10uTKvLIOfakoC
    N4i5W7xIl4AheNrX2slXJE1HbZPMy/h05RoNbDdzdZZ4i1ayHRJiG6I0oAeZxoSV2AA7Hb
    RKIcALu+P5HVyt9Y1y1ezANJWbAWBGWszR15+GDPjTzMXnqbOxiKRb8hQpF+COkiJQPxnF
    0UWg6BDw655o0/6A9ta46zFgatNFMoPxxt/0FoCgWYELz7QUNYh32JkYR9uUGka1x6ypmq
    eH0Qr9Jf33qKU5H2O8a0f2r2rYh7XVOvTm+1LoXnHj/MbUmV/hOmD09H7yAjgGsW/6uMFV
    hnCmsNgwNB8epiIP++hgnqM5WCIZVo94Fmo4v5pdZE7CE74+YAwgSdoWYkePryGy9jp2n/
    zrGLdoy722kEo6lwdo68L0Oau8X6kYv7Tu4RwF1iBZl9yePJU9NeKl35onjCyQSgPZ/cGG
    xSoegD1idvjo/4y5UETNmZI5n9vApV+fZdUriomxdU6eG/KdN6DACA3uzJhDZCO+WNZM3R
    uSQEe1geu4U9vmWVuhhePchb1ZS94NjBg/Un2a4OPU8biHpSiAkeuWmHb3iw
X-ME-Proxy: <xmx:aMBsalz5L1rI_N4XEeSgQ0LNozzM943M2Jyr8Kas8-giiLr7ykIAYQ>
    <xmx:aMBsav4DxqoMCpMYTKkOe9ANDJC0HsnAC3jQbqguKeIGzbiGz2HH_Q>
    <xmx:aMBsalWdr6F9vSyD40WBgiEDyBVQHcJLsxTwD9Z2eSY6ZnnvA_XnSw>
    <xmx:aMBsanJXgyhi_JBjPx5JCaRzB0tJ-fIkf5T6uuu4JS1avswit8nEfA>
    <xmx:aMBsasEVZXot0SLhEE75W0ABm8Hx1FPWprKO3mFcnZ1V7PYcbNjEnyer>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 11:33:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  me@ttaylorr.com,  ps@pks.im,
  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [GSoC PATCH v2 0/7] repack: add --drop-filtered to reclaim
 space in partial clones
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com> (Siddharth
	Shrimali's message of "Thu, 30 Jul 2026 23:11:46 +0530")
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
	<20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
Date: Fri, 31 Jul 2026 08:33:58 -0700
Message-ID: <xmqqcxw3dvh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> How it works:
>   * Enumerate promisor objects directly (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)
>     and select the blobs exceeding the filter threshold. Every enumerated
>     object is a promisor object by construction, so it is guaranteed
>     recoverable and locally-created objects are never candidates.

By 'by construction', do you mean 'It is guaranteed recoverable, as
long as ODB_FOR_EACH_OBJECT_PROMISOR_ONLY is working correctly'?
Since I do not use it, I do not personally trust promisor-based
traversal all that much, and it would be great if we could hear from
other practitioners that this really works well.

>   * Rebuild the promisor pack without the selected blobs, reusing the
>     existing repack machinery, so the drop is crash-safe (write, fsync,
>     install, then delete the old pack).

This is sensible, as long as this repacking is done only with
locally available data, without dynamically pulling in lazy objects
from the promisor (which would defeat the whole point ;-)).
Presumably, this rebuilding is done without an extra traversal,
driven instead by the list of enumerated promisor objects we
constructed above (excluding the unwanted ones)?

>   * --dry-run lists the candidates and changes nothing.

I wonder whether size is the only criterion we would want to use
when choosing what to discard among objects we know the promisor can
give us on-demand.  It is, of course, perfectly fine to make it the
only condition in this first effort, but it would help to imagine
what other criteria we might want in the future and how they would
fit into the framework you establish with this series.  Ensuring
that the framework is easily extensible with a future set of rules
will keep us from painting ourselves into a corner.

> Safety guards refuse to run while a merge, rebase, am, cherry-pick,
> revert, or bisect is in progress, and refuse to drop a blob referenced
> by the current index (it would only be lazily re-fetched by the next
> worktree command). Both are skipped for bare repositories.

I assume you do not mean a race where an operation wants to write a
blob, finds that an identical one that came from the promisor remote
already exists locally, refrains from writing another copy, and the
drop-filtered operation removes the blob at the right moment.
Rather, you likely have in mind an operation that stops, gives
control back to the user, and, while the user ponders the situation,
the drop-filtered operation kicks in and removes the blobs involved
in the operation in progress.  Am I reading you correctly?

Even in either of these situations, I do not quite see why the
safeguards are necessary.  The operation completes, or stays stopped
in the middle.  The user's next move (whether they issue a new
command after completion or resume the interrupted operation) will
automatically lazy-refetch what the drop-filtered operation
discarded as needed, will it not?
