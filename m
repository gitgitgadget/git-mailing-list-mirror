Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AB3BFE41
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509302; cv=none; b=sCCrjSYIvp4NslrvnJop2DZ5aTDhljl0k/NB0wETiXWzpx/S3BY2+3URycqfOcCRU5He73dope+RUUBoQvoP9u1+RZ37VPPIovAqrTFy7OTXuy06da1pC5oiylQWULqQC0miUEad01yXGpGkE9fab2fyjOx8sydqsCUhUifLZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509302; c=relaxed/simple;
	bh=eA8JLedoxNLOqysHTqGf9HM6vqwZ94cWwLgvo/ef4Xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n+/QaBnT6Q5/UvIPVQSSCMueJyA/AJzQbfSXorjLaE2PaqRlbOY1P+m6WjyI/utVpKso5sgz4Qm9LDlGnVLBN/w+IWMvqNqUG1BJ6aqtl36F1ntZJJzyOEdZU8Q1J2o3FgHZzCa8g24NDLKtEWqEvrT5QjOPT7bojhh+Zyyo6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RCz3WCdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d8Ze4tdx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RCz3WCdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8Ze4tdx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D3891D00130;
	Fri, 26 Jun 2026 17:28:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 17:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782509300; x=1782595700; bh=5VoJkbwQmU
	/NM3vT3XWHPbS/KMmtZxbjBnKg+FKPDTA=; b=RCz3WCdqhHXmbFpx/7uDCR7H3W
	yFywW24QvoRNh9aMPzMMWTZt0FH3jSPxr7k8Vt3RslNSYZJjSdf+G8o74+/bKu2H
	cFgIEqveHKxcCVUQwSWwJuMLDahUfeWbdItFwcKt85sN0FicjIfDw6WQayIyr6W/
	Gn8yxYrQ6tZ2bdGLHlS3K8xP8so7icHVTZp69Kxr57yiLsS8CIqKn+fNxTeX4Bxk
	dWw7rNIbPS7Z5mjZPn1o22kvJP8dxCciKEqWdyfLv8kGo1d3dH2iDXB1indrrOnm
	z3dlEez9HrFODNafZhKiD7m5+o5m77t7exEnQVn1uLcbqQ7XIUbqXz4yzMDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782509300; x=1782595700; bh=5VoJkbwQmU/NM3vT3XWHPbS/KMmtZxbjBnK
	g+FKPDTA=; b=d8Ze4tdxqPRy4jj9phXLidRKns1mbzrfKNz8RET5T2mRHbGS6rM
	osbJLIFjToQ9eqAv0mm2sJeK89IH+ygWHPoYw9nu2DS8G/EgrWGhkZGsqDQVLkGL
	MppesSZuoPgw5aC1qw4/2ZCfNPWGeWLArnIa92PvrnV9B0fxiFbYq4r/XAlAHBXA
	nKoCDHzn8e6lIFqd8KESe/j+VNezSPuEPCJoIfvrMCP6gn4Kzp/zM7a7itaOBAl4
	MxoWl+QZJC1O1wzQS9xmDVBa0iSG34ImBtcbTaXMHeHFJXHrJSuIG5Be/U7hzGT6
	5j+AO5vNgfwxHC0bE03XI6AkvmrNkRamKAg==
X-ME-Sender: <xms:9O4-avGyNr4fnGSrnNZpyzvsoSxjKlZmZ5KaBKvQmecA6Tx2T012Zw>
    <xme:9O4-agD4qw0pmUQgICxYHmfL_zVH_FdzUdfjih5ymSNwSoQlsgQWhLpbkpo-BPtkx
    n-Sd4C8mKQsEGFVs0gz4UpSTjRJhAvgUx7rOH1Kox3dyS86UyFpRxE>
X-ME-Received: <xmr:9O4-aq_yyztUU9ThDJbw0cosNipN2aUBAzAwvQeZgN7D5OKFewk3Ae2cMtEhzSTCMLbT4c8dk50tPG0Vv79AHlDHP65J-GEDbhJmEy4>
X-ME-Proxy-Cause: dmFkZTFFRHqjj/8n7ptjtOTVQ2f0oKzHuAPcndG3Rzx/XHnxn+9DASpCUz7zt4brQw9slY
    e9xc85/H1dJCVaZBMen1q4XH0lRtArVyzlfL0rYa/ONPG1G9WLYK68UQrn4NQPuwRBtXQ1
    NqUXInc2nm3yH8iYe4+nVpPVjRIIch6v5+F4Ra4RkbSGRtgVZXxucjJLKv7z3OT4iLPFuO
    75qZFhNrN99aSlTXWVU8No9CQbk2MDqLvTIBE/MOQpJ2l3FHpOmBT+0FqFXayuL34WPood
    QlgxjYQZR0dFKqTEiVb2yCX6mhxUPa4Osi3PqJ3d94FJP4z7F5v4GpjVP4IZaHGLd6lvMc
    uOsqgZpuz9jjC3WIghTU2b9UtrC/vFxIV/wCtQZDEun+SuQ2uINwympkFpRw9r12X5LMjk
    Wci2wYCGWblW1XnSuNFWorRNkkaNjOIb7qgiZNkfqK6MKqNgMGqphYGiCgnfFa0w2jVliq
    QhtLTlc/IPMlhkvdty/ZyIKn22T9YoDDZ0eCCbEO1UwRGwy3WjdlrH7eiVH5wmmPQxjb1R
    5A7ZwRNZa4l2zBL3SwspFk+zwa3mp2TO+wHqewQY7geNIuq5/rUTTSs+c9AnB57pDr4sWn
    i+7ZNTN0YhP4n++uKAHNK9KP6tY0xc19k4pKR3HJuOtQ4G9EJDGy03RLbT5A
X-ME-Proxy: <xmx:9O4-akD-IBEkj4udp1_MNchhzCKHDUgrF6X2cYRUqe-OrWCsHLHm2Q>
    <xmx:9O4-anSQ7zj8Wgwpfc5Ut2kSTl5iquuzEXULLyCgyMTVUcUsJCvwUQ>
    <xmx:9O4-ajvY6Ms3_xk4guE7BFNTnFW3pFQiOuJ54g3XTQ0A1iDr1ZRcGA>
    <xmx:9O4-ar2J1ZJ4wLlM2N_jGffO8gWzBzERIShDD-5DAHdmEetHcL-A7Q>
    <xmx:9O4-aliCs5dX9DkBGZDN8hl-Ww_XOWD_6--ymiHcfwStSMdWWj98GVaK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 17:28:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 04/10] repack: teach MIDX retention about geometric
 rollups
In-Reply-To: <ad76f06fc7ed304af97c73a5931e1ebc5f2d3895.1782500507.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 26 Jun 2026 15:02:23 -0400")
References: <cover.1782500507.git.me@ttaylorr.com>
	<ad76f06fc7ed304af97c73a5931e1ebc5f2d3895.1782500507.git.me@ttaylorr.com>
Date: Fri, 26 Jun 2026 14:28:18 -0700
Message-ID: <xmqqwlvl56vh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> +static int pack_geometry_contains_pack(struct packed_git **packs,
> +				       uint32_t packs_nr,
> +				       const char *base)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	uint32_t i;
> +
> +	for (i = 0; i < packs_nr; i++) {
> +		strbuf_reset(&buf);
> +		strbuf_addstr(&buf, pack_basename(packs[i]));
> +		strbuf_strip_suffix(&buf, ".pack");
> +
> +		if (!strcmp(buf.buf, base)) {
> +			strbuf_release(&buf);
> +			return 1;
> +		}
> +	}
> +
> +	strbuf_release(&buf);
> +	return 0;
> +}

It feels slightly inefficient to repeatedly strbuf_reset(),
strbuf_addstr(), and strbuf_strip_suffix() in the loop.  I do not
know if my understanding of what existing_packs_retain_midx_packs()
passes down in buf.buf as base is correct or not, but if so,
wouldn't it equivalent to

	for (uint32_t i = 0; i < packs_nr; i++) {
                const char *pack_name = pack_basename(packs[i]);
                const char *suffix;

                if (skip_prefix(pack_name, base, &suffix) &&
                    !strcmp(suffix, ".pack"))
                        return 1;
	}

perhaps?

Starting from "/path/to/objects/pack/pack-deadbeef.pack", you take
the basename of it to have "pack-deadbeef.pack" in buf, strip out
the ".pack" suffix to get "pack-deadbeef" in buf and then compare it
with the base.

Instead, pack_name in the rewitten one becomes the basename of the
packfile path, i.e., "pack-deadbeef.pack", then we see if it begins
with base and take the remainder in suffix, and finally we check if
that remaining suffix is ".pack".

Which should be equivalent.

> + * freshly-written pack supersedes them. When doing a geometric repack,
> + * packs below the split are rewritten into the new MIDX tip and should
> + * remain eligible for deletion.
>   */
> -void existing_packs_retain_midx_packs(struct existing_packs *existing)
> +void existing_packs_retain_midx_packs(struct existing_packs *existing,
> +				      const struct pack_geometry *geometry)
>  {
>  	struct string_list_item *item;
>  	struct strbuf buf = STRBUF_INIT;
> @@ -315,6 +351,9 @@ void existing_packs_retain_midx_packs(struct existing_packs *existing)
>  		strbuf_strip_suffix(&buf, ".pack");
>  		strbuf_strip_suffix(&buf, ".idx");

Not a fault of this patch, but it makes the hairs on the back of my
head tingle to see that a bogus input like "pack-foobar.idx.pack"
happily is taken, while "pack-foobar.pack.idx", an equally bogus
input, is not.

> +		if (pack_geometry_contains_rollup(geometry, buf.buf))
> +			continue;
