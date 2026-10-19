Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70848FF6E
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395993; cv=none; b=cfAuFzs3hKJMDt44H8rA+BsYhh+CBflV1j0uBrUNWSpa4JPSUBZVvQwhqdh02eio5vTT9JLFpxdo3FjDicRfMQ8Yq7qo9Dq5Ql99NiadvWZmpcBrxs5+fK5Ix8/QXojD+7dLq8SQxVH0U1nqDEN0trmhuewWdZxtrT7Z4No6ChM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395993; c=relaxed/simple;
	bh=udUHPdqDwQQCwL3qmxiRwVrBtvgVW6sotct53N5Y/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awIekIDYJZoyrDHqd6yTHMX41u/Lm1TETsi1KLjzA/k6HGr5cFoO4i+Gq+VIDq5oXhbiIUKxOUcXoBec1r5gpPHSqUSppwHH2wvvSNuUKXqIpdSIQOdxusvI48+ftLWZUMyTVNFnNAUpj6eV4sf33104ZwNfi/9pImdAbvIQSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qqtE+FFH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hOW5CYVy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qqtE+FFH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hOW5CYVy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C8B871D000B7
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 03:46:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 03:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792395991; x=1792482391; bh=H7HjliC0rE
	H7IqdAYKMqixQc/To8unxxPjTeXX5LwEU=; b=qqtE+FFHmthXORL5dy1cwIywow
	ZFvn+/uG7hbmL6Dm3D8FpgGRNL1L92R9Y0rsj9FORbyqPfAHtZZWrYIL0hp8R+T9
	hBKu5jjnslHRKVMmxcsu6mCs1ZU/T8SOeaaAQagtwZSfTA8A2BbKiRYu8TqIlG6W
	p2Q1HbVXMrXMl4QHE7STgZ5NhU6R1bKMdCrZvYTGII9XnCT4d4I39z9KXjuSJkBK
	moaGKx0xfVgVwFtLxJYMjtn3xdlzQjZCMj3GWCE59jidoFq6/C6NDaPA10rzZilz
	tRarDtIfJwBxcZuH+SVOhKUrWLZVHRgKoFCjAQbuVZg0fSt+YZiOLTYrjp5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792395991; x=1792482391; bh=H7HjliC0rEH7IqdAYKMqixQc/To8unxxPjT
	eXX5LwEU=; b=hOW5CYVyqmyG3XH+aNLbn2OETFiPq1fuYXeKWTeyUIy7p+XKcMX
	A7lUjZ4/Rxr4bVXLp6X1WKq27yApvZ7SfLdPdBBkI8/zU9n4DyE5g1I7pWRhZm4a
	3spDhwoHq5aUxiYcp0KQrrkA7lXf46sdElqy+oJxJdMJASZCcGY0PgvNNx2NWg7S
	NCYa4FkohPwOxmxL8qs/XxKvY/hBAo+QZIZKuTKJD2M/bFoFRlgleTzVHJIih3Ar
	N2nAJLJ9fT7eJDC5cqPrkCSUXOixdKButzmhhsXFRKYVw9CawnIVviJOZQasOTFF
	Vt0weoSbmqWyOCtEzvE4KrR4j9C3b4sEYyg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792395991; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:roV4jWxaBp7lPNE2HFUMKH9jMcDyzgxknv7HpNghonhJo7P
	Jskk6VgJRs1dGOwIvdBuqL+ssLkqQnV2GB/WudFPQdKcJ5sUgVXGyqio5sqBmW2N
	Z+NrPoupexpMoUJ4SQGq7PKM7qbAXIrG1KnEQQBXhaqZyHzf5bVZvA4SsnjM4Qi5
	1/Zxq6oselD6DHkvdS4zcrIK6HVD4vjd1u5BH3OOkF/8jwscVLIZWRRlkIOleE4c
	GuYgjOUClyol9YdqPK1j2qzUJUftKbWRnbqEi+OFbot+O4xhJVwb5vVewxx1edMc
	m1+1Bzl+QLRggBfPzgGN2NgCTtlE5sNQ9x37M5g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XcfnjL0RhS8+pEJSdN8w41ApFRoJR+SayFmgH16H+Ig=:udUHPdqDwQQCwL3qmxiRwVrBtvgVW6sotct53N5Y/mU=;
X-ME-Sender: <xms:18rVagRktAleFf9rQ71TPqKqMGtDFenItsOZt0zu10TtaXb0UdMVtQ>
    <xme:18rValMlLJGEPY5DPehMi0h-OdWXtljcizo_jfzmQKgBfUiO3crdrr9YfLK5bVywM
    QC60aIGRKsp6CfMlsbkD90SuQ5nDMpLf_UCeHq9lSH5y0aLeTdrcoA>
X-ME-Received: <xmr:18rVarN-VhD1cworPIMxakPljVJt7EajyKlfsO6INJPWUaI0Pbl44g>
X-ME-Proxy-Cause: dmFkZTGC33ECSe056BYKuC8IKMrvDBP0Ma05zw1s2JJV3nn0qjUsi8oEG3qM167FjBn3zG
    oDAkRbtW59vxun3l4XMAPMv6kkOv6UV4xFZ+9k4u2SB1hojz5oJmHC//oEe5kEmKHnRE6H
    tRAHSaFASs1aZQeixdb7C2vi8ZE710eUVbD7n1WMjNjjy6qTTExlmCW/d9jZ52SRxPKmXl
    ZnDaERdoV/9K4Gq3FiKQpsIp7FjhLtnQoS14uuBqYwHv3nSN03SkL8Zq/Z5fIJ/jyYB5q2
    rxPNf1q6lxZmAVAa3O3nyrKff5M/vzImxQhdgYaKMZLUIQ55BU/vrNMetUS+3lvwST8te0
    QQ9Iaj7q4Ma+P5IIBaRyTBBOIyFvH/VCOtHDxnidBFF79Bb7x/6SJJ80zQSkF/Txd0HLMI
    aEKtdnpKsXLXFNCqaPjX+H/u0Vl1rtsFp2yph9nJ8LinhQo/YinN8iKr2N9M4UikbBlsZm
    KzuzsLAnpMtvHE+GnoZLZH9fgqvisj7j1HykjYSdmGZfMi0T/4jtv5MtdCQ2GNhH1Fod54
    ijXQB+EfzWwsLdOKdPKiZfPZGNbgxs5CCVHe9dQ1Wh1ihDgdmH2VmGHYmGR4FYICNDhwlc
    6MUyP6cH9W1rYAfROJGf6Qi76garNizNRZ/CH6lfo4gFI+KF4i5yRUYEoCeA
X-ME-Proxy: <xmx:18rVattHd5pO_xZsX7xchXNQoom3LhDp9h8t3SWnEKSRtXrBTXWN4A>
    <xmx:18rVatXVnYHVjTThDBJyLpp__5-_dDu0M0sXImTifftfYTEw2nTvZQ>
    <xmx:18rVatvqPt_a6Rb242xAC4nYb8NaEht30LLqvmPZOdIYzjpu9El1vQ>
    <xmx:18rVahXLgW51Z4YWZDF7mfEcaiNFBZQJmcc95A6u9iaN2VYJllUV6w>
    <xmx:18rValOVy8asx1bOapPMjeMbrOSLpOFQJOz0tJgGsU5cWQXVIibkc3MB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 03:46:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b186f1d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 07:46:29 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:46:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Matthew Suozzo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Matthew Suozzo <m@suozzo.co>
Subject: Re: [PATCH] reftable/record: bound an object record's offset count
 by its length
Message-ID: <atXK0ska_v2rFn8W@pks.im>
References: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>

On Wed, Oct 14, 2026 at 02:58:03PM +0000, Matthew Suozzo via GitGitGadget wrote:
> From: Matthew Suozzo <m@suozzo.co>
> 
> An object record's count of offsets is a 64-bit varint from the table,
> and reftable_obj_record_decode() allocates the offsets array from it
> through REFTABLE_ALLOC_ARRAY(), which takes a size_t. Where size_t is
> 32 bits, a count of 2^32 + 1 allocates room for one offset, and the
> loop, which runs to the full count, writes an offset from the table
> for each varint left in the block past the end of the array. Where
> size_t is 64 bits, a large count only makes a large allocation that
> the decode then fails to fill.
> 
> Nothing in Git reaches this decoder from a repository: a block of a
> type other than the one wanted is refused before its records are
> decoded, and the object index, the only reader of object blocks, is
> used only by the unit tests. The decoder is still wrong.
> 
> Each offset takes at least a byte, so refuse a count larger than what
> is left of the record.

Sorry, but this whole commit message reads very AI-generated to me, as
it is both overly verbose and hard to parse. I would welcome it if you
could maybe touch up the message for normal human beings.

> diff --git a/Makefile b/Makefile
> index a96be506b5..66b7270fc0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1551,6 +1551,7 @@ CLAR_TEST_SUITES += u-reftable-block
>  CLAR_TEST_SUITES += u-reftable-merged
>  CLAR_TEST_SUITES += u-reftable-pq
>  CLAR_TEST_SUITES += u-reftable-readwrite
> +CLAR_TEST_SUITES += u-reftable-record
>  CLAR_TEST_SUITES += u-reftable-stack
>  CLAR_TEST_SUITES += u-reftable-table
>  CLAR_TEST_SUITES += u-reftable-tree

Makes sense, even though this should probably have been in its own
patch.

> diff --git a/reftable/record.c b/reftable/record.c
> index 1fce441930..96eceddca7 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -589,6 +589,10 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
>  	if (count == 0)
>  		return start.len - in.len;
>  
> +	/* each offset takes at least a byte */
> +	if (count > in.len)
> +		return REFTABLE_FORMAT_ERROR;

This check doesn't really seem to match what you're describing. What you
describe is an integer overflow, but you only check for a very specific
edge ecase here. I would have expected for example that...

>  	REFTABLE_ALLOC_ARRAY(r->offsets, count);

... this line already detects the overflow and then refuses the
operation. Because `REFTABLE_ALLOC_ARRAY()` itself already tries to
check for overflows.

That being said, if you take a look at `reftable_alloc_size()` you can
see that the input is both of type `size_t`. And _that_ is indeed broken
on platforms where `size_t` is 32 bits, as we'd potentially wrap. But
that fact is not even mentioned as part of the commit message at all.

So overall I'm not convinced that this fix makes sense, we should rather
fix the source of the problem, which is `reftable_alloc_size()`.

Thanks!

Patrick
