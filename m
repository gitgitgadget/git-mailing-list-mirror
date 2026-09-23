Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5E5678F5
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191605; cv=none; b=gG/B9L4bgbmO9tWxFTQZWvg3Jfj7tEKNXsfnNuPsIWPVgo/tJdMzwART9IEFqNQ5HPr/Mh4mv7egl/rjzCuyqHkXorGUmTkl1u+5iQnp30aiULNOkfVebOnlSsFFStHRbZLsjlrQfYj3GZwtHIf3qBuPehQT/vfVDxYW5hHdEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191605; c=relaxed/simple;
	bh=nE8exJyBvJ7hMEQen7ZmZz0MuB4OsPvEQrHH5GB1v44=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rUiQQUjW/SmpFgegxjDlRNNVecfb9Oes+SwXIzjL5sfnukFCjMyCkYhUi8RlZwXTjL7reOdNbDNAv3QYXKRtkRU3lWxnW+2aWUwz50hhdU0xhZjnehSlW/ZxBm3kOnBv7gOTR2N0xZ9/TeCJlxwstiHYX3SspDlSmh16culzeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=egS4oGDB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mTwD3NGB; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="egS4oGDB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mTwD3NGB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 31FD91300BEC;
	Wed, 23 Sep 2026 15:25:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 23 Sep 2026 15:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790191525;
	 x=1790195125; bh=AZfeyOTsr3zjRF6SGdpFyyy193bSCpkUYyMBSRjBWJs=; b=
	egS4oGDBRnnQf+c6sTBu0990jA5pyD1mmywQHZnBDhx0rd+s1InyqU7s1Rh8pPjn
	eMStitpRl5Wdcy3AQ4gA0sW8KkHN436CAW6JMN4EFXZCbJ3PhxoTNrLzTbbFQn1I
	p6OYBu0uBMvJepfrCQwzLcT8uwSefLQethcUfIpVGAY4sK67wQ9oxhXlRVs3pfWW
	6PtAXkeA8mCED/d/oj/JNG5FKVwql2hEhoJ1u2OOB6MbmEoZ+9c3TK3USTq1kJyt
	4TFQI9AIdkh8bjIATs+q865P84DrqpzoYdj/oYJJuvBBQV9UgamVBDLVLPk0RP3G
	UKYYDl5jy3T1Xr0GMfRpkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790191525; x=
	1790195125; bh=AZfeyOTsr3zjRF6SGdpFyyy193bSCpkUYyMBSRjBWJs=; b=m
	TwD3NGBTA9bOy3/01VLB17fcAdjXjqbxnIrZ2OPLjxFbM8kj0MGp9sD3AAfzpuTL
	xqcWatM62Uk0iknKn/4h+3jrxD7mtd6+bOfZROTRzSD732vsEJk+NSdgrHw6F+xz
	uITwDVutYv3Ynzk1BM0qBQDEw2LS4P3c/JGEQwEsv2FejGvPrN2whnBbCv7vBMUd
	Tg+HkEPmZ/BiW2Fwnus5rIAIGOAKvE+i8LVi1WieDy6i4ZECcsfCSFg4fidsZNLY
	eoph+xaVBh8MVHQDRNgotcOyuwk2w1jIePs30WayKO/35S4hP2J2EJPgSxR8hM2Y
	VkJJxCCqZeP+qvla/FDSg==
X-ME-Sender: <xms:pCe0ajf3LPvfitUo5t4azzuZ8I47_bWJrRC7j4WoKi4JYgoxEtUG9g>
    <xme:pCe0as7tZeh-Os_wzLQHVJSXBNXR_kLmXqLqJPwh38XdJlISQOrHICFjPDyHNlW2j
    z8ZaSONu_9XH_tEIn-ZDCdQh6pUNLww_J7un_Fi69qyvvj_vejaULU>
X-ME-Received: <xmr:pCe0amWvuK0JUXSUySGqNSMHCqUnnPOYJ9fWi27yySkqMYWbV7nl_3Lvk0JdY2dRN-JtLpGbKI8ng3R6x2YN2IMH3Q>
X-ME-Proxy-Cause: dmFkZTFj1hwWrPP9zTAkIFjA4R/VQmk1z1OwtdslB6Q/iUKNaZ/bPxVlzYGH6SATmvU03T
    W6WP+AWs2C8vM+1NBbGxYm06YC+VW92iOM0MQERxuSHcHbm9/UnZE6sZCPKwx5qj8wwjtq
    evROiLeqonTh9F+GLNAcZoYu4fEMGoxJTRfvKafx7+0+lL9UAdoC45+mCfUKGaYs/SfIbt
    FYNCIrdU7Akqb17Lij5DhRsTNuEJuzkOimB9oQK+MdZ5l/2zml8KwwbhPMt98vm1VOpXcc
    VsINupXsanGoGCNtbSvKxfsQ5wcDN96/8677S0H20Ylzqbe1WaNkk0SBalqnr5+60Vqnpd
    qHDWftYuaKlwlxLvKOmWrhS91hQ5BQso7KfNzYm6/Q3J5GppCU5wMITsODkbkltsJjJQDa
    eEEo3pUb2f4/s+X5hIRm3ptDRiDcrKYFmJtLEONkc386ZsTEh/zh7dveOiIOnelPFXPhvS
    4Cb73tOePleLSsWLohEhYLNs8IOn41d5iCUDNsrgnzbZG88oUrQbErMu8dPjCySTPVpHTS
    yAw3BHTKxogk0kU2mFElcoLnlVJBst73TForIgIzClAPp8BCL9BJ45KKJb/Narl9uIWJoO
    m+I4RmD3lPjLAaLL+BSMpVOjfdCWnch9mObTx5aqcF4USGIin8zsUQ7ZIsoA
X-ME-Proxy: <xmx:pCe0ar7bQBDEFnfVf0YNhKu95vod_3yuybH-7Ty4syCMSOSOf-uTkQ>
    <xmx:pCe0ahoTqO6w3gGf-49eLzbzc5OhpGAQ8NxprIgZslPi2Q1rXqn3FQ>
    <xmx:pCe0aumc4VXOga6FkvOhXgFTZ7IekT8FWjn_GsIZwX40dvlYcUNDIg>
    <xmx:pCe0atOb3QaS_6vh21p5pTpXDg1E0cuoAHMJsee_s2JTddhHQkjjUw>
    <xmx:pCe0ajamr6M_6YToZi6peWSBeszh1LUcJrUcieB18r9wq0cLESCU5tzD>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 15:25:24 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 15:25:23 -0400
Message-Id: <DLMXXKPGU78J.2PBDFYJTPFTA4@fastmail.com>
Cc: <gitster@pobox.com>, <peff@peff.net>, <newren@gmail.com>, "Derrick
 Stolee" <stolee@gmail.com>
Subject: Re: [PATCH 1/6] strbuf: add header for 'safe' API
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
 <b1779709120adc9c1df40c7210481d6bed9791c5.1789736540.git.gitgitgadget@gmail.com>
In-Reply-To: <b1779709120adc9c1df40c7210481d6bed9791c5.1789736540.git.gitgitgadget@gmail.com>

General comment: I really like the idea of this. While I haven't
encountered this specific issue with git, I've dealt with similar issues
in other systems, and even if the cascading error case is rare, it's
incredibly frustrating to deal with the loss of error details because
they used unsafe operations to generate their messages!

I'm not really qualified to comment much on the code yet, but there's a=20
couple of small writing style things that I'll nitpick for
clarity/readibilty. Feel free to ignore these if you disagree.

On Fri Sep 18, 2026 at 9:02 AM EDT, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> The strbuf library is an important API used all over the Git codebase.
> Contributors use it in nearly any string-manipulating action. However, th=
e
> implementation uses other helping functions that die() on failure instead=
 of
> returning an error code. Thus, the strbuf API isn't _safe_.
>
> In particular, we cannot include 'banned-die.h' in 'strbuf.c'.

I think we prefer to avoid "we" in these comments; and=20
the "in particular" here feels a little abrupt - maybe "In order to
ensure that strbuf functions can't call die, strbuf.c should not include ..=
."

> To start the creation of a safe strbuf API, move the struct definition in=
to
> a new 'strbuf-safe.h' header file. All consumers of 'strbuf.h' will consu=
me
> that header transitively.
>
> In the future, we will hope to have consumers that need a 'safe' API will
> include 'strbuf-safe.h' instead of 'strbuf.h'.

Again, avoiding we; and I don't think the quotes belong there.=20

Maybe "In the future, consumers that need a safe API will include ..."


> We will see in future changes the inclusion of new implementations that
> return an error code instead of halting.

The structure of this sentence is confusing. I had to read it a couple
of times to figure out how to parse it. Better something like:=20
"Future changes will include new implementations that return an error
code instead of halting."

>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  strbuf-safe.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  strbuf.h      | 74 +++----------------------------------------
>  2 files changed, 92 insertions(+), 70 deletions(-)
>  create mode 100644 strbuf-safe.h
>
> diff --git a/strbuf-safe.h b/strbuf-safe.h
> new file mode 100644
> index 0000000000..3cf14545bb
> --- /dev/null
> +++ b/strbuf-safe.h
> @@ -0,0 +1,88 @@
> +#ifndef STRBUF_SAFE_H
> +#define STRBUF_SAFE_H
> +
> +/*
> + * NOTE FOR STRBUF DEVELOPERS
> + *
> + * strbuf is a low-level primitive; as such it should interact only
> + * with other low-level primitives. Do not introduce new functions
> + * which interact with higher-level APIs.
> + *
> + * This header file specifically conatins the "safe" API surface for
> + * working with strbufs. The implementations of these methods avoid
> + * using die() and other exits. Thus, these methods are appropriate
> + * for use within lower-level APIs such as trace2.
> + */=20

As with the prose comments above, safe shouldn't be in quotes.

> +
> +struct string_list;
> +
> +/**
> + * strbufs are meant to be used with all the usual C string and memory
> + * APIs. Given that the length of the buffer is known, it's often better=
 to
> + * use the mem* functions than a str* one (e.g., memchr vs. strchr).
> + * Though, one has to be careful about the fact that str* functions ofte=
n
> + * stop on NULs and that strbufs may have embedded NULs.
> + *
> + * A strbuf is NUL terminated for convenience, but no function in the
> + * strbuf API actually relies on the string being free of NULs.
> + *
> + * strbufs have some invariants that are very important to keep in mind:

I think this should be stronger - they shouldn't just be kept in mind, they=
=20
should be strictly enforced: "strbufs have some invariants that _must_
be maintained".

> + *
> + *  - The `buf` member is never NULL, so it can be used in any usual C
> + *    string operations safely. strbufs _have_ to be initialized either =
by
> + *    `strbuf_init()` or by `=3D STRBUF_INIT` before the invariants, tho=
ugh.

I think "must" is better that "have to" here; I know some non-native
english speakers get confused by that.

> + *
> + *    Do *not* assume anything on what `buf` really is (e.g. if it is
> + *    allocated memory or not), use `strbuf_detach()` to unwrap a memory
> + *    buffer from its strbuf shell in a safe way. That is the sole suppo=
rted
> + *    way. This will give you a malloced buffer that you can later `free=
()`.
> + *
> + *    However, it is totally safe to modify anything in the string point=
ed by
> + *    the `buf` member, between the indices `0` and `len-1` (inclusive).
> + *
> + *  - The `buf` member is a byte array that has at least `len + 1` bytes
> + *    allocated. The extra byte is used to store a `'\0'`, allowing the
> + *    `buf` member to be a valid C-string. All strbuf functions ensure t=
his
> + *    invariant is preserved.

I think there should be a "must" before ensure".

> + *
> + *    NOTE: It is OK to "play" with the buffer directly if you work it t=
his
> + *    way:

I don't think "play" is good, and in any case it shouldn't be in quotes.=20
Maybe "It is OK to manipulate the buffer directly..."

> + *
> + *        strbuf_grow(sb, SOME_SIZE); <1>
> + *        strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
> + *
> + *    <1> Here, the memory array starting at `sb->buf`, and of length
> + *    `strbuf_avail(sb)` is all yours, and you can be sure that
> + *    `strbuf_avail(sb)` is at least `SOME_SIZE`.
> + *
> + *    NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(=
sb)`.
> + *
> + *    Doing so is safe, though if it has to be done in many places, addi=
ng the
> + *    missing API to the strbuf module is the way to go.
> + *
> + *    WARNING: Do _not_ assume that the area that is yours is of size `a=
lloc
> + *    - 1` even if it's true in the current implementation. Alloc is som=
ehow a
> + *    "private" member that should not be messed with. Use `strbuf_avail=
()`
> + *    instead.

Again, the quote around private. (I had an undergrad advisor who was a
stickler about the right way to use quotes, and he pounded into me so that
now I die a little bit every time I see them used as emphasis or as a marke=
r=20
of "not really".)

> +*/
> +
> +/**
> + * Data Structures
> + * ---------------
> + */
> +
> +/**
> + * This is the string buffer structure. The `len` member can be used to
> + * determine the current length of the string, and `buf` member provides
> + * access to the string itself.
> + */
> +struct strbuf {
> +	size_t alloc;
> +	size_t len;
> +	char *buf;
> +};
> +
> +extern char strbuf_slopbuf[];
> +#define STRBUF_INIT  { .buf =3D strbuf_slopbuf }
> +
> +#endif /* STRBUF_SAFE_H */=20

Repeat comments above for the repetitions in the other file.


--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

