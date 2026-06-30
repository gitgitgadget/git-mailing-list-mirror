Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214C38C41B
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818936; cv=none; b=Ll2rrtIttUcTPZ8sbkh6jZn+5G+bFYM3YGLecokCyExlEgn45sqCh0GHBf6vUI+WBKKsX8evTfkk23wyUxQ3v/VEbXRw4DHGgtOVIohDs3cybnwS+5Gcj0Yiu9m+ujwawvsu925m+ptPQxcNBdLdazZqNGwQqIrWhuq5csekeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818936; c=relaxed/simple;
	bh=/24Bgjzs9EAZyOqqUibAV8I0MV8cCHQQVhYq7eOc/Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQOxY5F6hKFgQBrp7pIu3tXh69BT5Pm7e2LCJgnvF0QUcL+7Bc+jH+SMFHltD+RN+daPR7IgyZHfWkJbGiIv1rm8rDcTMFPmr576LMU2+4mL2QBmsUaMmpx5GfFblhbYzlqCy0SFJx+ctlmbXncN/wq2aVMES6A4qDWvA2G2gdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fDUeXnve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aPG8JUXA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDUeXnve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aPG8JUXA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 645491D0010D;
	Tue, 30 Jun 2026 07:28:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Jun 2026 07:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782818934; x=1782905334; bh=cYOil3/MV9
	Gk1BvgISFxOSvInFHIyL3UwQ8pgZ2JmbY=; b=fDUeXnve63F7urK07SqY0BQ0y/
	xbxYyUaIlbP/tUw8DgBUfv3qOMQIOI4GOGUzFer4S9RgKt5hmFOqWxTBGmqBOtGk
	kbXTcBXSCOs4EZX6P9UUVukhGH8aHbkX5fx7s00SU8KzR5MP/Doam0JSflhcOBxF
	Jtn3hGS78Rl7q14SoVFCRsVGWHG8OfLuqN1c9NIbKaGlA0/HUKtQNyYezUEGe6+n
	QH3/5t0aSef55u+e02buMiPfEyk8lkFWKm5ZtVzIxpratkEA+fS8jRnk9uo5dzgM
	cudvJkC7ufiFaZCRI/rc243e134wCwXObMKI9xEHp4mxNubyn4Pbtlytoxug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782818934; x=1782905334; bh=cYOil3/MV9Gk1BvgISFxOSvInFHIyL3UwQ8
	pgZ2JmbY=; b=aPG8JUXAWIyNAvP1BMADgmRIbPT8PNoUtFBSvxuoGIgkYC1Z3sx
	a5WmY+xEMjewFICT/+3otaGyhvRMUNobtc70YWyq0Xz+DjE2MSUnLvO+bh8pcidC
	ryS1kHxigPfIq8Ho2WRsfyo+8Tj2YdfPktrLywxqgpF//eTkhs8+iHS1im0l9qVj
	eXuBwUHy+SBvnSmNCqMvBMt8VkVEURZ1WCNSA672dcgu4T3IBTruHR6zzn8iy61f
	KhgEbgBir+DZQbS+79Opg3rBpAsRD6jBLo90n/imYL0aEiOi2g5rWvAl8J6nfZiT
	HY9HNXcl1bGDWz+ycuy/yokMZN5inBtPFwQ==
X-ME-Sender: <xms:dqhDaqAf8O90dhBhzZyASQ-qgoKgOmmRHPgsy2CX6k73lFNL2FyECw>
    <xme:dqhDaqjWuqWqq5a3TwduH8Yfddje8oUVb0AsgOPcd2U-SIKnD19EqYA6B-cTwUWjz
    betOkzcAjXvjFG_KgASczDnJoufGGJ65mXfLd6LPWdlyqYM2rXn>
X-ME-Received: <xmr:dqhDarNLkTRMSv1Pi4j872GRuffDcQH6_ifMz5iO2GxfXvPrdWHPgtpORrHpmYN6m8HFUYkBV-DP_v4U-0Eu0gU_gwl3kdeJfUFBvzHCvL7-Mg>
X-ME-Proxy-Cause: dmFkZTEP8gyq1rVzNUn/0HjzBgz/9Moq2/c6+W0mF9K0Ur2/hwLPheqCVQEu5fgPUN4FUv
    KL9FS2wCbLmGf3oA7V9vdLYWMhI2ns7FXSZcBmZKBSC57HkBMlLb3tLo3UyLnkeELt8E4U
    7Llf9equv2aBCztzVBoZccck+q6kuD5Zbp+HYjJXvwHnwYNLkEf7ffSaIaALO1PcneiGxm
    TVYdFmNxbtxftw6FevYNH0+s27rskKY6UD314Q3eHcZWTHlugfW/L2NOxqKFOUAggwBC8f
    oE+0u/5jMDTyE6Jah3UOv7BkNTE/wsSTDSV/6ccYOyAL1lRC+ISqV8SogYASQzydVjJGld
    yGrjnnbMlKxlZQsyLZYmyJff5rVMJq/m4ZJJ4lZg9gonx+eNwZ9zl2LDvLI6Dt4Y0+R1lL
    E261wPinLLJXdiEfZRBhL8tFtLjMMUk/QxYaOKzXCApooOXvMdKAqoIokJyAHgM7TZYjNK
    T8fh5m1q9ZUPLxU+tgXGHkuxdiDXcd/CwfowRqZqrIcaW/43KfBNk77jUstBCC0TyPHISr
    ER35LGR7ZqeBprtUGhqezCRYOagJ55ykPh16uqAJK9Ialt3VN9RL9+tRkod846YlYN6nW6
    mIn+pQ9ubKD0BC++8bXpquTaMwESo+dQnA86pl0//qfhFPiSySngroJseeIQ
X-ME-Proxy: <xmx:dqhDaj5WvhbN1SJE-olM-PUPa6JNnDE_H2o9hLKMs9lnvNggklhKbw>
    <xmx:dqhDah3qdN-IIBY2KRYs7q4a3Gg5B5WbtfdgekdwHqA2VwUQEPbbEg>
    <xmx:dqhDasanccU8FWzTZRnfkgIUVPaA4fF6208vT8gvDW6uUA3NKDmCkA>
    <xmx:dqhDahAGPWg6wicDZNOg5Hhsbk10w6qpo4laxmI7LVGWcN8WmcI6Ng>
    <xmx:dqhDapwU6FFNviD1IB6jg9E0e_IxncTPQm2aC5HTKydJurqiBQGzmSy4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:28:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36acf6b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:28:52 +0000 (UTC)
Date: Tue, 30 Jun 2026 13:28:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] packfile: thread odb_source_packed through
 packed_object_info()
Message-ID: <akOocmBK61006i-p@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
 <20260624-b4-pks-odb-drop-whence-v1-1-8d1877b790ac@pks.im>
 <akKge0zmT3WSfdyz@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKge0zmT3WSfdyz@denethor>

On Mon, Jun 29, 2026 at 12:01:47PM -0500, Justin Tobler wrote:
> On 26/06/24 02:19PM, Patrick Steinhardt wrote:
> > Add an optional `struct odb_source_packed *source` parameter to
> > `packed_object_info()` and `packed_object_info_with_index_pos()`. This
> > parameter is unused at this point in time, but it will be used in a
> > follow-up commit so that we can record the source of a specific object.
> 
> Ok so `packed_object_info()` is responsible for populating `struct
> object_info` from the provided packfile and object offset. By
> additionally providing the object source, the ultimate goal is to store
> the this information in `struct object_info` or some equivalent
> structure.
> 
> At first, I wondered if it would make more sense for `struct packed_git`
> to record the `struct odb_source_packed` it comes from, but maybe that
> wouldn't be the best layer to handle this bookkeeping?

Yeah, I was thinking about that, too. But I feel like that would be a
layering violation: a packfile can in theory live standalone without a
source. So tracking that information as part of the packfile itself just
feels wrong to me.

We could in theory adapt all callers of `packed_object_info()` to track
the origin of the packfiles. I _think_ that should be feasible at almost
all sites. But I'm just not sure myself whether that really buys us much
in the first place, because...

> > Note that callers in "odb/source-packed.c" pass the already-available
> > source, but all other callers pass `NULL` instead. This is fine though,
> > as we only care about populating this info when called via the packed
> > store.
> 
> Hmmm, is this because knowing the ODB source the object comes from is
> only useful for callers from in "odb/source-packed.c"? Maybe this will
> become a bit more clear to me in subsequent patches.

... right now none none of the callers that call `packed_object_info()`
directly care about the source information at all. It's really only
callers of `odb_read_object_info()` that do.

So I understand that this feels a bit iffy. But arguably, the right way
to fix this is to stop using `packed_object_info()` altogether. It is an
internal implementation detail of the object source backend, and ideally
we shouldn't need to care about it.

I already have a patch series that fixes git-cat-file(1). The
commit-graph is a bigger building site, as I'm still not a 100% decided
on how to represent such auxiliary data structures with pluggable object
backends. And for the other commands I don't yet have a good answer.

Patrick
