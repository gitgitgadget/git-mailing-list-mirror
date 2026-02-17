Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76229BDB4
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361466; cv=none; b=eu13LMptnGVyb2wkTTKKztanOQPxNujR33frP/shWgBSTGXmVD6Bx4eFJ09JsbbzOBNLVqUa5bjqOVdOytVlqlnTBBsDUoAbJ06FMlWxpAm4IQhuPoIyJvr+7LrmdvLCQSNOaY5h/BlZtUHs+n535J8s3EcA8GEU390OSvlYoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361466; c=relaxed/simple;
	bh=+v5j3fz8xYycuIxa0marUWAJtnk1OUq/09msBQJUWsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CMnQaFRoZf3cz2+e+J1bhwWcO2ESIKF3yJkIYXkjnFgBGlyynE7h/jCW7FzrTn7Nn+rP5+vmzdypfbf7RajvnIMACPcjxYs/K3f+Kg1I4JWcmvZMI8DwpIeuyTXw53DaL38a4X0AMgQ6z5fuHI1evGQrPCQGMJTs15qlj9HR544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yrmdaLPt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAo89uDN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yrmdaLPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAo89uDN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3536F7A0136;
	Tue, 17 Feb 2026 15:51:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Feb 2026 15:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771361464; x=1771447864; bh=VruHTQl8kG
	+CmjhXtyIvnOwqB6U24Rr5Z/n7BtUl67s=; b=yrmdaLPta5ZYU27qHViChFeBq6
	Cu9DqSMPX2kULe+OmYuWQOUBfraXu4MJu2khhW17vkNfYhO62E2eVvU+aGnV0bFM
	vnrA7EfUzZC/hN54ZE4pkmgaal7czhqt3Gdz3UIC3DBoQH5ZjwQIqlh4GLZy2M7L
	+cs4qWzFdUL4aIqbmQksNcQGm710VodQhYIM3z/Jxrc/L0qP+Csk/WaPSfs+btjG
	loXVeg7D9h7R7VAGe8NaddLtZ3zfQfQoZho98Mh/4t+7XD1yX3mCoPdQqQq9aiVD
	DkZy9g1ybCX2+/IB130HpAE55dCawOGOqMpaniwuaOMDK2aSNQL20WoRwiHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771361464; x=1771447864; bh=VruHTQl8kG+CmjhXtyIvnOwqB6U24Rr5Z/n
	7BtUl67s=; b=UAo89uDNpRgWLV7Sk8lD4FnEMulqLOC4CkupSwFSnpU2zmKQ1Ms
	6LbZ8SpCg4fWrHCYrHISRmNoTHzgVSKW8x8672r5OKml0W1S9RlT6uIHWBSn1Jd+
	XMEv3q1DRgDpjcvl5EkwyGOa14qqKileLUwF0FYEoXRgGXuECdINCjvhtf/6bGf0
	K9EI1uni33fkqJPrIEKRxtcYEb9/P7Bq/nhxB61yqAnYUn7vGdVcZDk0pMMSRQ2b
	DUIqeIsZipk2QMskOSxtb8fyLU+hs9amn1l0d2558hrcQ04Hjn36UOc2hv40xdvB
	VfoNjB4xTrbdBqHRM5f+kzl7A0jX+jKaBaw==
X-ME-Sender: <xms:t9SUabjbRCttXuYzZ1UB9fC1vYUexbwmtYfAx-Sd5rFWHom-l12-wA>
    <xme:t9SUabseyl4XYChxfVgiTrsS0e2-QydFc4060J6LI3uJHVmc4LZWHq-GvQkYUf_z3
    12tWg6sihAyODZ5QujEfrp7vFvSI2OFV_y9Inp_4e7-wFRpCAjmig>
X-ME-Received: <xmr:t9SUaU5y0rpM8Fv4q2aRLk_xNpHXuhLr7lz8wCDK053gXLrnRaPl02UFU6MQPYlLOTRZHYfDQEhf0A3ymExZ-OeL6nvwn4oTXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehvrghiuggrshdrphhilhhkrghushhkrghssehshhhophhifhih
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:t9SUafMuIoZB8jZDiYSReXP2EcAYgXRa6o36osk2dyh6dybgOngXgQ>
    <xmx:uNSUaaseNjsFDC0y-eAaD2OgGjwQgQd_f7s2M0u_dUFhO0SpfdRqqA>
    <xmx:uNSUaabPbPRVjivXAwbhEWY_YtCPWJD1b1TWL0-0n94jgYzgUZCxag>
    <xmx:uNSUaUwE9EMdhz3uxHWu2X-E68vP-k3zd125BR4NaV0I5vfCclBKpg>
    <xmx:uNSUaQbOgZjO3ZX00X_uEJhf9ek7dYjj9z_GvM7aYAGJkcZkDW2YDNtX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 15:51:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v3 1/3] strbuf: fix incorrect alloc size in
 strbuf_reencode()
In-Reply-To: <821043c664e41d8e395e944df3ada8f697a69d0b.1771326521.git.gitgitgadget@gmail.com>
	(Vaidas Pilkauskas via GitGitGadget's message of "Tue, 17 Feb 2026
	11:08:38 +0000")
References: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
	<pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
	<821043c664e41d8e395e944df3ada8f697a69d0b.1771326521.git.gitgitgadget@gmail.com>
Date: Tue, 17 Feb 2026 12:51:02 -0800
Message-ID: <xmqqseaz9jrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
>
> The strbuf_reencode() function incorrectly passes the string length
> as the allocation size to strbuf_attach(), when it should pass
> length + 1 to account for the null terminator.
>
> The reencode_string_len() function allocates len + 1 bytes (including
> the null terminator) and returns the string length (excluding the null
> terminator) via the len parameter. However, strbuf_reencode() then
> calls strbuf_attach() with this length value as both the len and alloc
> parameters:
>
>     strbuf_attach(sb, out, len, len);
>
> This is incorrect because strbuf_attach()'s alloc parameter should
> reflect the actual allocated buffer size, which includes space for the
> null terminator. This could lead to incorrect memory management in code
> that relies on sb->alloc being accurate.

I do agree that setting the correct number to .alloc member is a
good thing to do, but I am afraid that the above characterization of
a potential problem is incorrect.

If we were to extend the resulting strbuf further (by e.g.,
appending to it), we might end up reallocating the buffer a bit
prematurely by one byte before it actually fills up, but the
reallocation would be done by giving the piece of memory pointed at
by "out" here to realloc(3), so the wrong value of "alloc" would not
lead to incorrect memory management at all.

Upon further inspection, we see something else interesting.  The
strbuf_attach() function, immediately after initializing sb with the
new values of buf/len/alloc, calls strbuf_grow(sb, 0) and triggers
the ALLOC_GROW() growth thanks to this under specification.  By the
time the control returns to the caller, the sb->alloc would be
(((len)+16)*3/2), not (len+1), and it records the actual allocation
size.  So there is no "could lead to incorrect memory management" at
all, but this incorrect number forces us to always reallocate
immediately after the strbuf_attach() call, which is a waste when we
are not going to further extend the strbuf returned by this function.

And that is a very good reason to make this fix worth doing.


> Fix by passing len + 1 as the alloc parameter:
>
>     strbuf_attach(sb, out, len, len + 1);

I wonder how widespread this off-by-one error is.  Shouldn't
strbuf_attach() be doing some sanity checking of its parameters?

        void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
        {

                strbuf_release(sb);
                sb->buf   = buf;
                sb->len   = len;
                sb->alloc = alloc;
                strbuf_grow(sb, 0);
                sb->buf[sb->len] = '\0';
        }

Given the above code, it is clear that alloc must be at least as big
as (len + 1), and the strbuf_grow(sb, 0) in between is papering over
problems (at least it is doing so here for the caller you corrected).

Perhaps we want to replace the call to strbuf_grow(sb, 0) with
something like

		if (alloc <= len)
			BUG("alloc must be larger than len");

instead?  The log message of 917c9a71 (New strbuf APIs: splice and
attach., 2007-09-15) is worth reading, but it is an iffy logic that
depends too much (at least for my taste) on what strbuf_grow(sb, 0)
actually does ;-).




> Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
> ---
>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 3939863cf3..3e04addc22 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -168,7 +168,7 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
>  	if (!out)
>  		return -1;
>  
> -	strbuf_attach(sb, out, len, len);
> +	strbuf_attach(sb, out, len, len + 1);
>  	return 0;
>  }
