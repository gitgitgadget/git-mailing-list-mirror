Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D28284B3E
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666738; cv=none; b=cTIHSAnvcMkNNvFZFhDHKwPbAHCqcOvGeQDhQhiaZxrhSCEkJCjIcDHJIU7xgLfSuR3phQ+Ux3cLjwOl4OuXVHG6dHwvv+v5KKz8s8cBfy0bW6C3yXSgp3g6rzXQFDYqdaY3Bn6eqmlu8XRAvCFiBsR7VQ8QhMX3FNHNEttEBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666738; c=relaxed/simple;
	bh=N2H7bUf97952Tp7xPfWOfrIHdnkoMvaAO1XVKqa9T0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ICaKSs4WttUVJgU/teWLNb2p2oAapUYezcDnDcrnuqI2iOD4sHSgCvJ+IrfqcaQW0WGufKJZqCrC8c4HAH9US+koRrPt8I9MMFau1OT9DkfNOEW3qyWAtp3G+FReScFKGfVv738l2mlWdVby19CRl6ltI9igHOpnn+szOPhnXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UwtxZBv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=byUGEED6; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UwtxZBv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="byUGEED6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 07ABE1140136;
	Mon, 19 May 2025 10:58:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 10:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747666734; x=1747753134; bh=7GTWkUc0aU
	Z6OIHN3nItw/CX8tNV+UYU7lq1y5MNad4=; b=UwtxZBv39KNLidoEao2JtWHNOe
	Kk5YZwBpyHJvj3BgbpRHIsB9upG5jBx/zAzQ9qZ/4wV96kTI0TK8rhElZe5QKW6K
	Ll2ckThOMhmmyH/JDBJSvvjlyOs+kZlVTwq1YKFEXeKpALBoUmvWilNAoI9jgPyb
	x3MYqv0JHRY562/EprcYYSZXj9R1GlLXvv2Upfu/epVGpPtpNgYLNS/+YbN9/fJ2
	IKFCXJXCWXsR4iIAmDnHRGrlmCkEt/z/px6yKNZqetkAjakGrDn4ApgSPAdYWtfo
	ZDt7apUIMVrnnABSJxv00YSLWiVpRzdRDRYFYw4wFB9U8SYBAtxfidWRDomQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747666734; x=1747753134; bh=7GTWkUc0aUZ6OIHN3nItw/CX8tNV+UYU7lq
	1y5MNad4=; b=byUGEED6+CHXwZd12yT2cax9vAOYAHqWuRzlDaazVlnb2jfdKoW
	glGGYXzXASpG9FR8Gy7j8Jzcn1+ix6nnN63bawD9IAls7Sl4UmBqJUQWlu4rjC6I
	P0AIlTmWwxgd2fJgra4gJyubrLPStWIirkL5k0arDnd4Z35WlBJY5B8Ow7Tif4rS
	s5n0nlcDXntH7ocM8tUX+HWUq1ZRJoweX7c8EoUEY+uva7ADVhxHiKWqeybJhrFv
	1i6RHwMjBpyJVSIcH2xQQ6cveVdzYgFjvQcRN8UBlyxRTk3NL/6JK06bIcfoDqzZ
	3XvgNi3rDuB+zz1AzbfoEENw6xH9cNSAyXw==
X-ME-Sender: <xms:LkcraId6lxgfzihkorKXVGuawcpBEaKES8CL8e4fiC8DWQUjYrxUKA>
    <xme:LkcraKOR_t5OIApEtiJ2brluZJcxHOvPgd2fjDtlk6SZ-STyW7DN8PSzyQCVzQEOB
    VxsuS-ciU3whtbuBw>
X-ME-Received: <xmr:LkcraJjM4Dwd7UhiqbWX7YnIctCQt3G9fCXAnR0zBOcPVe40du6GmOme2rVZ-LsxW9mmEZ7lk2Ibz1ly7b1vY7CQR991CtFFltUZ-Z0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:LkcraN8Yi5Q7QiYtYdZYthiYztEs2xo32CVPtTjbhybECOakjfk8Uw>
    <xmx:LkcraEu1acO6c6hby4ffZ2DBqTACG_PawFB6m2E5NSlehXbwi9dJGQ>
    <xmx:LkcraEEv7thMGTSey7UtRD3wPe5cYGqQ9v-Xsq_LwVJyzg55ti6PCA>
    <xmx:LkcraDMWaLyEIclUjSCu6z1t793-SlJ6cOZrZkYWdAMVzJko9H6LnQ>
    <xmx:LkcraGpx1_zAiY4i2CNWUXvJEkCsIfBJLRWO03D9Uy1uN_h4TKAOV5fQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 10:58:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/13] oid_object_info(): drop type_name strbuf
In-Reply-To: <20250516044956.GG22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:49:56 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516044956.GG22242@coredump.intra.peff.net>
Date: Mon, 19 May 2025 07:58:52 -0700
Message-ID: <xmqqtt5gpryr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We provide a mechanism for callers to get the object type as a raw
> string, rather than an object_type enum. This was in theory useful for
> returning types that are not representable in the enum, but we consider
> any such type to be an error, and there are no callers that use the
> strbuf anymore.
>
> Let's drop support to simplify the code a bit.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object-file.c  | 4 +---
>  object-store.c | 2 --
>  object-store.h | 1 -
>  packfile.c     | 7 +------
>  4 files changed, 2 insertions(+), 12 deletions(-)

Yup, now we have fixed vocabulary, we can pass around the enum and
map them into fixed strings on demand.  Nice.
