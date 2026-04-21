Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E5332ED3
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764492; cv=none; b=r9odHUJtJ6DBiMrVp9VdH/7QGj7RCaelsMBIW88UnYEFeLYFfTMp4kj7EA8ZdWl1qhDXtvrG8ho8hs1Jh38hdMb7p0t6+0G+IPCnC0OgLZYVNLfw2oT49469Mdvsi3YD7ICO0BrJ16X56rVLiMUPsiRqo8RQDFSRhuapkyHqYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764492; c=relaxed/simple;
	bh=RhlNph5SjtW1QYV4/jymZw3v4fw63+jKmm1UXjPP8PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgkFQiBEx1UOynddiXoB1ZbfhEIpcSvO8U/sEoum5htLBGTMyzTI7lDygkAYxdWPNfP0+l9aM4dmL5tR56CcgENBThVNDqUYKXx9FHJD8OKpiWJPQVMAFqt7oAyOQE9NpfP0u2mINXQVKGA2AjG4hZdOAXOxngds1g2ZZKOxxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cxcZ1k6G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=co70/GED; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cxcZ1k6G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="co70/GED"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 17968EC0092;
	Tue, 21 Apr 2026 05:41:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Apr 2026 05:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776764489; x=1776850889; bh=IDP63MyX+4
	RdIKF4Mz1P/FshjAPLq9N6RgqpkYN4pvY=; b=cxcZ1k6G1ati0+yJu+2RALnH35
	1PvCjYmodawHpJG+vpWJcGsmk46dwo6lWuRL9fPZnnDIVgSWeV1CNNsRXXJV+eDh
	vvdhBpX2LYLAh/qqApE5c2E3dFVmuOJZsWR4cKIb7ooDmTQLTT0l7FDNd4mFNW/R
	6FgMuA4oZg/3pn17NeLw+P3WxB2TFikjXjNBZBQVsNle19SNKuWCjdX9qMUxsjuK
	I+yu6UfzKbaazXsQY+2AlwvVGp+Z+DaaqfPzas+Oc93wuEr+35HxYlRznH9/6QV3
	SovjPK0vBBc4nM+RDMKxV3Gtv6hYuF6tzfgybPF62X0ugIREsKjiijfkDaoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776764489; x=1776850889; bh=IDP63MyX+4RdIKF4Mz1P/FshjAPLq9N6Rgq
	pkYN4pvY=; b=co70/GEDrOho4pQ56Tir6FsiA2DfqYujkqixDQqiBiLgLHBwXz9
	H/iFTFjwxOI52zSC2bRxXKZkMX5n2nEN5WTwc3ErU3PTxDW10AwVVlwBb5/jKWBq
	z6tisIBVnaunwI1qVvFN+XQ6iOxJvY7plNHpT4TsBb+uHndEQfcLhxJzpclsHuhc
	VDgaxNm0ydVUTqKriOfxwiX+yRP87kV03wnNp7630pscKCmQfZgbeQ056MFUJ7iO
	DU7kfkfZYjfl9RgpF77TsFPxIY2HEwC8OkaPU/2CNgLQ4VWXoVsOo597SsSsP3Xa
	s4TrSJWXz7X9RVeG6UT5xZ8/stj2rstj7lQ==
X-ME-Sender: <xms:SEbnaSYIb4QGvDGK0EoelsX7xpKGJQ1vQPXnjyHpaQgsMuSbWZw4uQ>
    <xme:SEbnacZcz_5FJEJx6JVMvnHSxHv0Gb3VAe5s9BqkPI3N5ynJvkEGXsVk3_kiv81EH
    7o03cH7_lF36BilBXspgXUF48v2hjUca5bjKDq0OwpK3NcjR_-r>
X-ME-Received: <xmr:SEbnaR9yFnSTQ2Rv-ivXnx63imhNS7PY55UJ01ZFCCR3C9fO3-mgi7Ev8ZezC5fM1IRz6GqrO7lU53S7yt2psDZlhMqtfLZFQA_aG2wkgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiuddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SEbnaTh_yoeWmK5EWUH5E7B0GwpRMxMu6SzP_DVppsA7NHxncyFkhA>
    <xmx:SEbnaZewZUSEY3Uy1VEKGsSOGPEQN0vM97c9sIhY-XPc7KumYXpckQ>
    <xmx:SEbnaSoovodTlxeHYfLqLzg-5WM76VtDzBXpGVuixvioZ6pY3xeSuQ>
    <xmx:SEbnaWDpr55q2XidFmcvL8xCbANSS_Fi2JfgHz1pQxMdqOUT2NiTjw>
    <xmx:SUbnaQLjQz5LaosBJaP8_86EU13R07YZj-d9jex3d41bsTmsUYMicMbE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 05:41:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0761585d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 09:41:25 +0000 (UTC)
Date: Tue, 21 Apr 2026 11:41:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] setup: drop uses of `the_repository`
Message-ID: <aedGO_FGV94tMvu6@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
 <CABPp-BHOVhQPL4ScA+sJCvE2OYXjLJSyDim5AocbcqoxzObGxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHOVhQPL4ScA+sJCvE2OYXjLJSyDim5AocbcqoxzObGxQ@mail.gmail.com>

On Mon, Apr 20, 2026 at 08:50:45AM -0700, Elijah Newren wrote:
> Thanks, I would have preferred this series to have used the "PATCH v2"
> prefix and for its cover letter to be sent in-response-to the cover
> letter of v1, but those are nitpicks that don't affect the overall
> series.

Yeah, true. I noticed that b4 didn't quite do its thing, but too late. I
think this happens when b4 is still busy sending out mails from the
preceding version, but I already switch branches.

> I thought to check one additional thing I didn't check when reviewing
> v1.  I looked for all cases where this series added "the_repository"
> to some function between the beginning and end of the series, and for
> which the function where the code was found already had a
> repo/repository parameter.  There were several of these in builtins,
> but those are already littered with cases where cmd_foo() has a
> repository parameter declared UNUSED and where we use the_repository
> anyway.  Those should be cleaned up, but that's outside the scope of
> this series.  However, I did spot one non-builtin case: in patch 16,
> repo_migrate_ref_storage_format() already has a repo parameter, so
> your call to initialize_repository_version() can use it instead of
> the_repository.

This is something I'm always torn on. The problem here is that more
often than not, series like this end up touching lots and lots of places
throughout the code base.

On the one hand this means that I'd have to reason through every
callsite to figure out whether any repo that is available in the
caller's context is the correct repository to use, or if it's even set
at all (e.g. in the case of `cmd_foo()`). On the other hand, even if I
do so, I cannot trivially prove that the refactoring is equivalent, and
the refactoring may introduce bugs at the callsites I'm adapting because
of it.

So that's why I typically lean towards fixing the subsystem itself, but
doing the trivial swap for callers so that we only have to worry about
one part. The only exception is callers where we don't have
USE_THE_REPOSITORY_VARIABLE defined anymore.

Patrick
