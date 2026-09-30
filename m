Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F54503BD4
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782389; cv=none; b=Op9u5wZeY66nPZ+bCCmBRCIs+zizb4NuHATdzaycz3YhZXDhyNkPwMTDrnjALf33rcLA0k+c8rLBXlnPbKc9doZK8FBtlgJU1Ai1I5CrD7xV7+x0fElZTpq/hY85aOBix/76h6j9d/OLX2danOSQAPKP+H87JRewyikFFBAhCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782389; c=relaxed/simple;
	bh=khnbLvgdzg6dIj75h6DmC8GBE9I4Ky+/t6lqhofFEtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unbDYMz6lJpGZTSuRGBKegqyh6flXHC21/P9N47oH66Hc8/gPFbISlLb+4YTbqSIj+npjxkHTqb9yB4nQZi4zwQJZ6nNxpc4HNWnOXZHKlAE5VY7WtI/BQ9RYejo1WW4itSHx6k+HWaxtLkLhS7KF8ZRoJEWevcVnhUZPur9NgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pyu5gIgO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gWBgYzBK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pyu5gIgO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gWBgYzBK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65D6C140022D;
	Wed, 30 Sep 2026 11:32:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 11:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790782378; x=1790868778; bh=NW39VZ6vhg
	aK2Ixnv+pnRrWt0Ls3kSCY0o7mfuIlTu4=; b=Pyu5gIgOE0pisoAhPa3y10KfVz
	H1LU1zpH0KOssYZCNdBh6KaL1piXmyrnNs1mm0dn4ad4cEaaOfGwMqp395ZTNu3M
	BiMv4qWTxm2pqfVP23r9rMTlbAtx7MTY0rYUnWwLRCwasoGly0QWzvTiegKruWnB
	C4+E1dpusCWNRAziA6li6Bqx36uZg7x0FOQrM6WMnZGsgGW6bQtzh1eoP/XzcFF1
	JBV+9Ys4vHQWcxT/4ATBvPbqbritpgt6f6tbr21L+TL/SYPoH4119xqqUzHeNqm1
	wgwLtFBG6Ynw+9LEZyI8Kd7F3LZI5q52qiA2oKrtZZ3AezPX2Fe4bu0USB+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790782378; x=1790868778; bh=NW39VZ6vhgaK2Ixnv+pnRrWt0Ls3kSCY0o7
	mfuIlTu4=; b=gWBgYzBKaKNNrFzg8+cgF4oXjGneaUXJ3grm9hBdyarrr6tUe0Z
	fSpTPxlWdmy+Z/eiDg2bWeBh/nl0aXBPDbFfGdPpnKz/doqepLUs7SWDoxEUhUWF
	SF0U9TfZcueeklWQPSTuGicyTdcodHYsLE5+JRoDA6UWZRfiI0UdOmooK+KlkImb
	e4QwgFJ/Iw8M4ZaiCJNP++T6P7mzBy6ytC7B9UP47VD/BSjY7dSLyowtnTq28mXl
	k/Wfouecoo/hrr91IpVvffOGxLQ2Gh823J4AjMP1B3LCXST3iwAjfP8fgA2VvxCh
	OD8+xi9Ci7fmn0Xl0RQdoO+614eMvoNAIHw==
X-ME-Sender: <xms:qiu9apLKh-bkL3i-8QcJiTNUtxh2BRflvtnzm5EMEy3RK_76g2oKWw>
    <xme:qiu9asljOjQadc4fhADBYMG4DIFoPAm6j0w5uMJeZOH90EQrvq3XSwk7j-LosdNnb
    QWH7_fDB435GgSGlsIoWq7_1_SZkBxtUTq32tb_5f4cWaNfvJOjEWU>
X-ME-Received: <xmr:qiu9avEaTTJ16Z8uMAZ-cnNMTs9SGO7l6Hi86Fc-vdx2eogtS3XewA>
X-ME-Proxy-Cause: dmFkZTGa8Y2Qcg/BV/xbMY2HiAErV9l9soJz6ZsrijsSNi+3ggOx2QCtQAXEL4JL8tpsvZ
    jqoyJ/2K6+4XijuLEeHkfLr5GrqiVReZaCkpcbT+W83O4eEEWM7LqKA9BTcH0nHB0luYih
    KK5Evl4id9bLYGidVoYO0+3Ip2nQQl7bg0sha32MViSQiIWluS/+81CChnnNpqsBM3hUqx
    Nalbk9W19myc2gpAvAtCvb7LcZdWgvuTN4ocOPswN2vX6b+BCsQ6wduT4YKr7ihysCMItH
    93yYIian88My0Neiv/H4g7ANZTHFJ6r2UcRkftXWmHK0h7QfRLU8Bo6biVe5ez6zah2dnJ
    1iVGv7rwAUdsgCzAobOcIKYmH19uIGLZjnJpmoumf0WrQknLXlPVaEaQSHKfAh/HNY872e
    AhfSYc++3CBz1L6q68jlGwt4yqH7JyraFX3DvKD8/At2PL6JF+km8xxzw/zctBe4Wa2ouI
    uY062pHGq4VO26CzILttfDhyF3N6UXl14HbYhdZwptNvCK8ceBL1GoOudodWhm41jsJAAL
    RA2cJz8WRukmsXA9Zgn6cznONnpdlroOxx/hFDf0bGD9t/mok9p2eJkbEMVpZKPoznRaW5
    D0yWYbMiiInL9eC3fMEf1bkbZ0cZ//wtV2iUlJfZif3lkFMlEe1nqExXwLCQ
X-ME-Proxy: <xmx:qiu9akGC_20AAnl5tV6hJVdEhc49M3S3XqKoXasFYaVJwX5X8xdmKw>
    <xmx:qiu9akNXHkFTp_VRBz7JxmW1zTryN1RBNbjEmp5SmoqE75h_ZjDiQA>
    <xmx:qiu9arHappJJNlqwXBfXXjeaQCaa6p4diiISrlx72EIc4672JBwgOg>
    <xmx:qiu9ajMtheBJ3vKeIHrOAJj6KboWye9DxGlkqKs0X5b_Kb9RmxjxBg>
    <xmx:qiu9apRTcH9JHnMHmzAA18d32MCU-DR22deMDTmkZoby9U8FX138ZQ66>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 11:32:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a3ae429 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 15:32:57 +0000 (UTC)
Date: Wed, 30 Sep 2026 17:32:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] xdiff: NUL-terminate buffers read by read_mmfile()
Message-ID: <ar0rp1cSIKuCMZyQ@pks.im>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
 <20260929065504.GE1697497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929065504.GE1697497@coredump.intra.peff.net>

On Tue, Sep 29, 2026 at 02:55:04AM -0400, Jeff King wrote:
> Since an mmfile_t is a ptr/len pair, our read_mmfile() allocates exactly
> the number of bytes we claim to store. But in many other places in Git,
> we add an extra NUL "just in case", which can help avoid read overruns
> due to off-by-ones or the use of string functions.
> 
> I don't know of any path that would benefit from this, but I noticed it
> while converting ll_ext_merge() to use read_mmfile(), since its original
> code did add a NUL byte (even though I cannot find any case where it
> would have mattered). Let's teach read_mmfile() to add this defensive
> NUL; it probably doesn't help anything, but nor should it hurt.
> 
> Note that the matching read_mmblob() doesn't need the same treatment.
> Its buffers already have a NUL from the object-reading code (which uses
> the same defensive trick).
> 
> As a bonus, we can get rid of the hack in read_mmfile() to handle empty
> files by allocating a single byte.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This one is obviously optional, which is why I put it last.

Hm, I'm somewhat indifferent here. It always feels a bit weird to be
this defensive because "programming errors", as the next question then
is "but what about all the other errors where we're not defensive?" But
the xdiff code is complex enough with a bunch of pointer arithmetics, so
maybe it's not even that bad of an idea.

That being said, I feel like a better course of action could be to use a
fuzzer for this code, because as far as I'm aware we have none yet, and
that would potentially shake out a bunch of bugs. But that still doesn't
really help us to catch platform-specific bugs due to different integer
sizes.

The counterargument is that before your 3/5 we used to use xmallocz, so
you're essentially just reinstating the previous safety guards.

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index bc340d5a8a..b3e9f1952b 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -166,7 +166,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
>  	if (!(f = fopen(filename, "rb")))
>  		return error_errno("Could not open %s", filename);
>  	sz = xsize_t(st.st_size);
> -	ptr->ptr = xmalloc(sz ? sz : 1);
> +	ptr->ptr = xmallocz(sz);

I was staring at this code a while before I noticed the added `z` at the
end of this function.

Patrick
