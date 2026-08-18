Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F712FF69
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076045; cv=none; b=tfsMCoYcUVAa3YQs0d3nHrsGEqrBUGZ4mY9n2LuQsp14BkG1H17yjPRi0rl25JIFxpPsc0OnpiitZfS4+PMulFG1uqNp3BdjjjX2KRrmjbiVW+oedmMZ6cj9BXLL+tZNYvJScjAxpAz8PDGw9SasU2vOUgRL7TUfAe+YHW3gIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076045; c=relaxed/simple;
	bh=Wm3ho/Oan1RGDh1IhU1If7URD8vgCExuZM8k+OwAEQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lqg9iVdy5PfBUrtLIWsPfiX5zv4m4CqMDKSss9c6duImX9jQG0S2g4VrTp7IjmDISRUKYCOhpnlF/eZKO8X36zIuQnMdh2WGhxOq20TcqQMLM3mn9zYmSlCUEIHejNJ/HaaoqgqFIfJRZV6PfvfBCnB37xMXSHe6zqEGDgL+I0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aoQFawB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBlKq01O; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aoQFawB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBlKq01O"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB82D140017C;
	Tue, 18 Aug 2026 14:00:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 18 Aug 2026 14:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787076042; x=1787162442; bh=Xmjbwk5ObJ
	ka0VePHN+uWM1oVxVBhMwuRGuQgM0EjVE=; b=aoQFawB8grav3u2GyWbBgp+Lih
	Xf1cXhs//b1qnPnjEeu1zynaxHsXnmR1Y8tCDzgioxObgju4IFdsTg0Ldx6TXH0j
	jEuwX/TP+s/mA2UwbZjOf6uSMsxSw7iHVCAaMRxI/JfI9ELOnej4ap20GQ55Ac50
	LGLgmEAzkhr3TKMkDpPaKRIxWI77QsaHBTmx2WapZ9caVFGzFhkP6WN0yWCjZOuE
	Ox4iIJbzEDAla1pY9XubtEps850JgIQx3wT4fAmVHSlEcQOObOKuTudqK4vaHSc0
	Lr3GnWXuRDFYzMgihKmtbrrqazvHfZKx0Xj0ZfteasQ74cYqlXqDT1nHIErA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787076042; x=1787162442; bh=Xmjbwk5ObJka0VePHN+uWM1oVxVBhMwuRGu
	QgM0EjVE=; b=aBlKq01OJMmfL8JkSuq80HWAg9xhrA4BWaMHy5V4UmnCcuR1rp1
	vgKjOjmRiRwWvKvouXKRFN+PNxR/BPgByXiNrqKxCkCWjIlOh5rvdwzpAPkszlKd
	Z1i1uvZXR+tYuxc6U7h0pBn3z0TZh0TgC0PtxZkbQKCJyd9AH6Euf/iY6slf6J8r
	3YTsXEGzaOddgFKA+Q/gMy9Gae4OIGf+ISnZGRNDWUSbBclMah0fdKRuy9Rw+lct
	zUeoCE7R8NV7fyxxBe8LFH0QyPkhg1OvJWypUJmjCduNOlTmS6zhYucY+SXS8Yqb
	x/h8aVkoizYoZfjRDgAr0LVyUf1KjrMYm5g==
X-ME-Sender: <xms:yp2EapE-yZ_j4Gy5ApyUPU-FK3mVsxtH98uO088n8ZnraxxZtI6_ZA>
    <xme:yp2EalzhY_Qm5OmuUquUv47oKWBjw67CEYsrDBQFOtpg8HyYY_qNdRS5lHaXCtX4-
    VxfvFWEUQkxlfxO1wU39gPw8sHfIuLITmAz33ETf0osmkGTSaUC>
X-ME-Received: <xmr:yp2EaoikTYgmh6UE-C5UOvBBhYZtvN4wbEhueVtIkQERuPVeLrOTeli6T69-W_a2nXUDuKnkOX0n5aBOme30H6w083laci4D5Q>
X-ME-Proxy-Cause: dmFkZTEfAJi2dlQanPrXsYATiyNw5K+tIOzeHTvVEs66y5MPTeIYrvKFTf10CEP1wfFPQQ
    4LZSr7/XBUpBJmSG4m0rzNh35fzPQrppMbeYFOG4lH+9of/oWwMomts4l6A5rB/fffufof
    srNuOD7JRWDFbUQ85q3nSE/7ttxcGcQ6/Ux4CcXnX6nZlbs+Zibrh9B1zxnGAluUgXpz3t
    Gjni2kF8ZlHEep2AvzjtCq0bFHjPTb10JE2gkuhqe0oWZ09Yz32ei7UllCg883wUnYsU/X
    JZ0X9w7+FZD+2MEIUGCArlRTEhFFTlOLBHofwJFl5KD8qqlUFNTTsCeezZgWbJT/0wrJOR
    HVgW1EVl+6IIuxsd8QNGaX/GtmBh+Jk3oPE75gj7Xs+/LsTWZfW2I9HQTMQdP0Me41b+L7
    cHbpxzxJV467awfWJsN9sfDdTVUOO3a1b37JOawOOcgGZMASArwgjORvRfUhWj7+d0cmrH
    /ueGFP9sHf1vSw2l2PoiVduNk9NUxyy0GeL4GrqV8FZpcp0o4mU29aViDG+Co22lsLv3jE
    yvca63Wh7+lhlC4HYaeYpDR/SXEwq/WgkE6IdQ/TFGOVJtYpW6RJ/Vid6e4qCzA/pmoJgv
    BgqYl3MIEXObDY8pdrqd1Fy211cgSbfaE0AoqGTqrp9l/GtZODMpWwl+vbtw
X-ME-Proxy: <xmx:yp2EaozBC1GMx5F2-e6qKvcs2bqmTjbo_vSsYm3lzYizMxFf_V1Eug>
    <xmx:yp2EajKsVlEj3XB58IVNlvAwiJzk3n8S5OwLYqkpoR7k13RKBIdeoA>
    <xmx:yp2EanS-RaVrWi88P0p-ikfvICZkZhBNEeiYYDwfLIuR8r5Uyu1V3w>
    <xmx:yp2EajpZkaDLQWa4At38oJKJAg7Ci5r0EaCGNgWdJgJZWCVWx6epcQ>
    <xmx:yp2Eal4tV9L_95_PJshgG8hAxxpLD0V6SySZLnV9vkCtJRwa7-UzK_yu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 14:00:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] odb/source: discern missing and corrupt objects
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-1-ec234567510f@pks.im>
	(Patrick Steinhardt's message of "Tue, 18 Aug 2026 16:19:28 +0200")
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
	<20260818-pks-odb-generic-corrupt-objects-v1-1-ec234567510f@pks.im>
Date: Tue, 18 Aug 2026 11:00:40 -0700
Message-ID: <xmqqh5krz4tz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The `read_object_info()` callback of `struct odb_source` is documented
> to return a negative error code in case reading the object has failed,
> and zero otherwise. This is overly broad though, as there are two very
> different kinds of failures:
>
>   - The object may not exist in the source at all.
>
>   - The object exists, but reading it has failed, for example because
>     its on-disk state is corrupt.
>
> This distinction matters to callers: when an object is corrupt in one
> source we may still find a good copy of it in another source, so we may
> still be able to proceed with a given operation.
>
> The "packed" source already distinguishes these cases by returning a
> positive value for missing objects and a negative value in case reading
> the object has failed. But all the other sources conflate them into a
> single negative return value.

In other words, "packed" did not honor the documented contract with
the callers and nobody noticed?  It gives us a usable escape hatch ;-)

Do we need to support many other "it is an error but we treat as non
error in some context" values, like the "does not exist"?  If so, it
does make sense to say 0 is absolute success, positive values are
such half-errors, and negative values are absolute failures.  If
not, it would have been much nicer if "you asked me about this
information but there is no such object" were still signalled as an
error (i.e., negative return value) that is distinct from other
kinds of errors like I/O error (which also should be signalled by a
negative return value), instead of a positive value whose meanings
were not defined, though.

> Adapt the documentation to explicitly require the semantics of the
> "packed" backend, where we return a positive value for missing objects
> and a negative value for corrupt ones. Subsequent commits will adapt all
> the other implementations to respect those new semantics.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/odb/source.h b/odb/source.h
> index d69f8e2d1c..4ae6cc160e 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -110,8 +110,17 @@ struct odb_source {
>  	 *     second read in case they know that the first read would have
>  	 *     already surfaced the object without reloading any on-disk state.
>  	 *
> -	 * The callback is expected to return a negative error code in case
> -	 * reading the object has failed, 0 otherwise.
> +	 * The callback is expected to return one of the following values:
> +	 *
> +	 *   - Zero in case the object has been found and its object info has
> +	 *     been read successfully.
> +	 *
> +	 *   - A positive value in case the object does not exist in this
> +	 *     source.
> +	 *
> +	 *   - A negative value in case the object exists in this source, but
> +	 *     reading its object info has failed, for example because its
> +	 *     on-disk state is corrupt.
>  	 */
>  	int (*read_object_info)(struct odb_source *source,
>  				const struct object_id *oid,
> @@ -340,7 +349,9 @@ static inline void odb_source_prepare(struct odb_source *source,
>  
>  /*
>   * Read an object from the object database source identified by its object ID.
> - * Returns 0 on success, a negative error code otherwise.
> + * Returns 0 on success, a positive value in case the object is missing in the
> + * source and a negative value in case the object exists, but reading it has
> + * failed.
>   */
>  static inline int odb_source_read_object_info(struct odb_source *source,
>  					      const struct object_id *oid,
