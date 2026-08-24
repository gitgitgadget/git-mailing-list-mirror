Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836549364D
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550031; cv=none; b=s3rEPEHyBwjFI4Of7h8ydXobHOYQr/MsPOKW4785SbsFIUFYh7HlXKcoAeofDAao7NoZiC+Z/5G4UpPg8MoWypd4zyAxkoF1p408MSj77kqtHc96RgT+xMPZp4xOkAaMWx3/JKICwjT3aiR4VFXMMq6RIMGvoEk8e1btM58acbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550031; c=relaxed/simple;
	bh=MNspRV/VQWTKdzWvOMfGLwzoo5fbHNKu0OFbyYAygts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A88ruXal1qjM6sZDeTowwKMjdbf0JofzOGgJxzXpqHNAs+hvkF/iso1zjfiXFR2llcFGm4XmkClv+hZ5GKflpMP+h6xu6ZmkIVKnzCmTdPwWUMifo00rHTJtSyXuSRY5746L09GO1vwLlsV8XH4K06kLPXBTcuehkKbVQQ88G1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HijAcBJA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Myff6lvn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HijAcBJA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Myff6lvn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 945DF7A00A2;
	Mon, 24 Aug 2026 01:40:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 01:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787550029; x=1787636429; bh=iM0eeeQzxu
	pFo1uWgPHmLBFeFdPCOHyeg2sAx7gfjeY=; b=HijAcBJAkLNi5MO5Qt1xYIpgya
	CM2WIf6ZxT3t9lJXRVSTvlDaTYA1HchTFJWeW8LbnwsJ40kz0tHKzVKtY0legT70
	e5kCxifeh7S3vaRdXnGcH4Ar9nm72UxU1Pp61BhYdIKpsm358EiTUHgL0CEcjbNG
	go8w3HC1MYNShOSJjhZuJDbuy77UrgclzxXdGkRD4ZBNsA6NMDoo6dOrjsUP3NAO
	7ckthlQcLCgUrqfizuA/vnmdVg2q1CKZiNb0q5VG/FkHqlJIYHohKUoAhyD+qlnR
	AcU7NLT4aiAH7QkUOJLeV0hUz9fH0H/WWQ3s/PQEvNv0QAxqhgSqVVz9MUhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787550029; x=1787636429; bh=iM0eeeQzxupFo1uWgPHmLBFeFdPCOHyeg2s
	Ax7gfjeY=; b=Myff6lvnruYvv02NX2egs/wVjUMZLOKkITFqRMV9XYpDBErRUaf
	RXiB5R6N41LYyyRDOCbQbt/WwYqNEQjiqhII1ax0n+nN95I5GKpbz1QM3ePgk4fY
	DLPmTrnEMuk3wVNS3lGZC1ff8JUECkYguh82K6bCzi6IbiWMxmZWSzyBIBE0B1gD
	5kuZiNEYCgiO6RWTbjhsh/rIQvhX1qcpxOYDUE69kHmBibBBDkK94w6MMZWEjNXe
	5iiFJahDTbn0cz+uL5vziU4yMdCk1chlyviFvUfoGV3TjJyA23iAN76WHMIjE+Ym
	+cI/lS5MqOLRzWXWUxgkfp0oeBYWwkEhhbg==
X-ME-Sender: <xms:TdmLas27fLsivCpsMabLcmaNa8rzLoNRCAzpNH2GxRFsVefcewWDaQ>
    <xme:TdmLauHkAC8hbwrgMWlf2qChmfTKLF2BSGuhJvhwmM-SmFxOfpVfLFGIB3c-iArIl
    1qkwl52ZiVJ8Pka2CuvpEjbhFbl1yDgd89gZu8uM5i_94ZPKcPjKKY>
X-ME-Received: <xmr:TdmLap6nWVwKMdu0ZEJm-y9o9OqIoFOYrAsnnMSEvjFxrlDaTQJlKGAz9l_ndN8lOM5OE02N9OaLw4g3188m2b1bqcvdAwojyW46Zgs7RQ>
X-ME-Proxy-Cause: dmFkZTFaaY8C7eJnTl0U5KJtfwv+JsAc57ME7moRWGdYMQ0YaSJDZ5iwt9qDvK7Go2Yp6j
    M9zQZeSA+qExiu9ujMc8iscNjSQZfJM2JpT+9+UzW1G0PSVo7YWcfdvZ3vzKZ2HiF8fNOj
    fn+kX7xZYLi6kJp7SH2hB56b10tU0usP1jmHHnQU18tqAQvGHuMBcmOk8UQ9mi/X277soZ
    7Ii8JFRA6vYMWHsY5mOK8nS4sFW/EDrtINE7nZPbmMe4xQENY/EykN1mfk68ltDisKLe4E
    xEipCVQr3LEK72uQWwuSG366LMYelYRhUgPjThypsUssQJye6DOKPdr/1kgfw+EggLinpD
    MkrgIO6wsNCLZzr3u5Ruo4PoAn0rkcbQdDUG9t1JaLDWEeuhZVpInmbgRag9tQAJRCBk6v
    I7tzdEC5w/zsrUZ5RyONqHEOmpqPEM4q/NhwrpSK/rGJ1Wl2tP6EKR7+fOp4w7XhNXZ8aP
    wjLfKp+iK3fPFyBUDbE4YZyVb/NxDuO3+wLi+vOgGb7w8x2DtdJ8ZdowDSYXZ69R6Qph/z
    JcZV7drwIoKGkT921CFO6FLCeIC3K51Ws6kRroaFQc95MZKOmNMSyUBbnIFdIwuTdFS8fO
    98vU/9KKezRK7dnOUXzymLu+ZCTHc8Re9w57RryTIaSnmnVxueLUf5XzsGMQ
X-ME-Proxy: <xmx:TdmLaktgjEEUWGlKLMKQwPwkR38L8BxuE1BJdCa_BINIVm9KGkuQDQ>
    <xmx:TdmLaq6XrYOJyMVCdY1rwYzudEl6cCooqFSC1DwcJENRWqXnS8HulQ>
    <xmx:TdmLavU2Lg6X-nSmIVHOQ4Chif-BsiRocdQ78aWXUH-EhcFYcC6cSg>
    <xmx:TdmLas-X1DakQgMYX2a4IrU0tT_87fGqrfXRjKHXMg0Ido2Qyse_Jg>
    <xmx:TdmLao9bTzlavJDGsNUZqdZlD1Z9LP9-qBe6xn1RIB_b63E5111s8Eot>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 01:40:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5272e73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Aug 2026 05:40:26 +0000 (UTC)
Date: Mon, 24 Aug 2026 07:40:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <aovZRjcIbAUqswFT@pks.im>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <20260824045529.GB142844@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045529.GB142844@coredump.intra.peff.net>

On Mon, Aug 24, 2026 at 12:55:29AM -0400, Jeff King wrote:
> On Tue, Aug 18, 2026 at 10:34:06PM +0000, Elijah Newren via GitGitGadget wrote:
> 
> > Teach find_pack_entry() to recover.  After the normal multi-pack-index
> > lookup and the regular pack fallback both miss, check whether the object
> > is nonetheless present in a covered multi-pack-index (bsearch_midx()).
> > If it is, its recorded owner must have become unavailable, so scan that
> > index's packs directly for a surviving copy.  The bsearch gate keeps
> > genuine misses (i.e. objects absent from the index) on the fast path, and
> > because the recovery lives in find_pack_entry() itself it also fixes the
> > OBJECT_INFO_QUICK callers that never reprepare.
> 
> You don't even have to pay the bsearch() again. We'd already have looked
> in the midx earlier in the function. We just need to distinguish three
> cases:
> 
>   1. it was not in the midx (or there is no midx)
> 
>   2. it was in the midx but we could not load it (pack invalid, or
>      object in the bad_objects list)
> 
>   3. it was in the midx and is available
> 
> In fill_midx_entry() we return a boolean that lumps cases 1+2 together,
> versus case 3. It could return a tri-state that would let us distinguish
> all three. And then your fallback would kick in only for case 2 (case 3
> already returned with success, and case 1 means the midx does not even
> mention the object).
> 
> This is all assuming the fallback is worth pursuing. I'm still puzzled
> why this specific case would matter when we have the same (already
> solved) problem of reading a regular .idx whose .pack has gone away.

I've tried to clarify in a parallel message already, but the issue is
that we skip over any packfiles that covered by a MIDX when doing the
lookup. So any secondary packfiles that contain the object would be
completely ignored, and that's why we don't find the object there.

But this mail here suggests an alternative fix: instead of re-scanning
all packfiles like the patch proposes, wouldn't the proper fix be to not
ignore _all_ MIDX'd packs, but only the pack that _should_ have
contained the object?

Ultimately though, this would be equivalent to turning the function's
return value into a tri-state as suggested by Peff here. The only case
where the issue can occur is in case (2), and in that case we should not
skip MIDX'd packs at all as the MIDX'd pack that should've contained the
pack does not exist anyway.

Patrick
