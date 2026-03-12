Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B421FF38
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275618; cv=none; b=e5l+gLZ7WfhVsOVWYmAPvgX09PcMo1tREdUYL5CiWZlY8/JAnDMXsWdqkUk0Gv74tE0d/ldK97Z0IrrVJQlQoMNpc7oLjU0axva0GeITD+IzRqDJcF50sCKQo9tf71O+oBn2epiq2zrGLSfxgtzVBWvJSK4bhEjlfpv/g7pJXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275618; c=relaxed/simple;
	bh=8gwNW4amZRnpupPBTg2S+f1Zo7lAdpMbZhB1zJ2ngOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lhjaEbM2s5T8cJ+Qp/pUlMLSd1kHV7iN0GFVlXWEhefaNE8ZcCxzZl9XA/k5M8z+cqXsH+HGGKDt77aK5tNoUwQBemSGeeSsW2b26JBAJVZYssVpv9VjNUlSFARdUoxZIUv2F9NUfxRqjoFoyIXHl6dN70AZ9mbknu9GsTFwtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CTn/N1Zd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tmTH0qTn; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CTn/N1Zd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tmTH0qTn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A07F81D0012F;
	Wed, 11 Mar 2026 20:33:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 20:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773275616; x=1773362016; bh=95SJdnelq5
	ZB2B3BkBovbjqRgFI0NYp7NoHNrrPAs+4=; b=CTn/N1ZdV5x9IYAyfYfpc+refv
	YzZD7r422+FlZNthc8/4XulF9ZKvsCWkG97V2DG5G/fNqXJxKplTvwe2rYHFvFOC
	VMf3Mhmt0sVxTIKCDVK6JKHyYCb1sNfghVytESaaiL5yA/89BAo9YN0BhPDkfCbT
	DhkPgCKN94ITQ7U/kT0V8t72KQsSCmis1artZ7uyIwwg53Lyc1YPIPJt1ldRFCJ9
	VU99bclQGOooVb9uXRv86cPqwgC/X2MaPXEi9vRywXg0trcyid2WXQcebE8AhdGQ
	P7mxENCaDq+INLsbSwAhdE/dlo2U5mNOulog2Vc+Dh0qqDq7wXnSMl1pfUkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773275616; x=1773362016; bh=95SJdnelq5ZB2B3BkBovbjqRgFI0NYp7NoH
	NrrPAs+4=; b=tmTH0qTnoOw+V/R7EZpaWo3buSnxUBy/xCaKhc2odzDcxv+Twuj
	uvVEuquQl2SltQXl4vYrfKEn1faqE9k4bimuCIKp2SGPtakbxX5jgbnVwlQP/yms
	ZSuGFUWHI8Iuu6QXrE3GdGAN+voCqYM76qkfXRMN9cR97NvezL3JMFrYX2iTvXwl
	+ofAsOLfiHA/QGvgEGsIKHb8ZWKDrpms9efnva+cR9mpAcnvEq7EhfgAc43XJn1h
	tc76w/7K2g+GJHwFib373AUGZiQgYxPXxeyOYPKcW0Kyq5rx+E5XSJcDGsVEoh4D
	5NHuTNnszH0igOo510Dv9VjUnHVGeTmPIjg==
X-ME-Sender: <xms:3wmyacn1bdFXoM5RDMiei37ngbp15xpWlNYbFIn3ldEix6IsOfQ7Dw>
    <xme:3wmyaVKs3b3E_fn4vMirDgSFxPcGhEH9nMdRfVoPOoqYt6Qu0T1TojLdfYWgGgjsa
    xqJPFSB4dpkUIgQwDI23JEgEEKXsQ1E2Gcryti5Iof0zdlyYhKikg>
X-ME-Received: <xmr:3wmyaR7aQV7wrhPxy7c2UTkApR8L56XPJHET0FSRUTtx5ZZ06V6oDBTIs2_CbVHOgUfbDzNJwfmgj4-13cC36fuHn1Sr1zaC6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehsiigvuggvrhdrug
    gvvhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3wmyaZ3x2PI35jdY9AnKG_bHMqBInfG0Yly5VYMmjhsSCEkIs9k8NA>
    <xmx:3wmyaXdkNkCI72c6zUHY5o-LTCDgFyj2N_zlX7rCcO6s7_AxvyhkCw>
    <xmx:3wmyafe07QM4etL13nYvfjr7Lectrw0a3Cp8U569l21JURn--mhGvA>
    <xmx:3wmyaSzTwy3vi5k0uEsLFCME711A3uqvf0hJh_24S1OD02G3885msQ>
    <xmx:4AmyaY6SyVhTBt0lDy4_a7ROh9P7CAbu7OX7QnQB7ggdZmApb3_gvSu7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 20:33:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [RFC] t: allow use of "sed -E"
In-Reply-To: <77fce76d-07e2-4586-bb6c-f0043d171591@ramsayjones.plus.com>
	(Ramsay Jones's message of "Wed, 11 Mar 2026 23:12:19 +0000")
References: <xmqq5x72m4lu.fsf@gitster.g> <xmqq1phqm4ca.fsf@gitster.g>
	<77fce76d-07e2-4586-bb6c-f0043d171591@ramsayjones.plus.com>
Date: Wed, 11 Mar 2026 17:33:34 -0700
Message-ID: <xmqq7brhlwdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>> -	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
>>> +	/\bsed\s+-[^Eefn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
>
> .. and, perhaps, add -E to the error message?

Yes, indeed.  Thanks.
