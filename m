Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F42E36FA
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754200593; cv=none; b=hVxXpWD9QTeX4AEJk3kGu2V0znJ6EMa65CUjAaDIfVmPaLHZDjfxACXmKYh6rzkBIHz7TMd7j9TGmGTpv6XQxZL+fjJMNwAmL6eqYRy4v3tGD5ofDpyDVYjidiYbpp65sAfaNgDqROMRfDYze6jpU8JAZ/mAW8NYpWG2E9B+2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754200593; c=relaxed/simple;
	bh=6TWDzbW6LDfwANgZcxZBrZiaZZiluD/lyLYcgWtwIQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FkQJrsLtPCbInYUOr/qtiV71njlmAfBaIPCeBlJ5HdModsCKpbXbGBw1A10GGfR7RhI+ZThmon/KjT4Qb2NRdOZN3jdZBbNGVBzVnHWrQDW1gzAzZthaTzcXrgWSVkjCL3929gIiNsqs+DdbSp8UpLWyJNUPHwpdqdxkpTHanOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bIbG2LsY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6l6W80o; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bIbG2LsY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6l6W80o"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7588F1D002EC;
	Sun,  3 Aug 2025 01:56:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 03 Aug 2025 01:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754200590; x=1754286990; bh=z9ydizFO3z
	zlvgM74CzMZEbefpOS2Gi/Cnnyl0CRTgo=; b=bIbG2LsY6iDExzrR6KMc70d3PN
	FO6X/Op7zyB1KOQrlUeqewmHYxHv/zPjkwUeHfMyTWG4WoAlCgnO4phns/D6dW/q
	82mmSdSt3y3y/Ulz/yqMvFEAY/gyrFXHARduOQb9V967SO8fGv1lbNdFZDndct0o
	IY1rekQEUkLYCBCjUMzIWt0WW5DzE8Xu6CwJ27531079nQxppE9a6LJS+kBHbmsh
	jqw/QpE2gWw3BHmyz/rlSBflQAGlNrLlcVyXpAL25PmPPLeFMjHpt8nF5Ngmjlsa
	FZBNvIGkHTdbDeehcjueZcIAAJOWkQUlQ4cnRTjPIXgtf7hcOp5DJEgnC8Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754200590; x=1754286990; bh=z9ydizFO3zzlvgM74CzMZEbefpOS2Gi/Cnn
	yl0CRTgo=; b=b6l6W80oZMzWVIsa7xP1+/MHzra86P63mjIKKhRNoi88QSbNX5p
	YwSu/hovrwB+77zTsiUO+m4daibodo8MHWRDc/s227SdoS/rhbW/7nxCedMzMVx0
	m4BlUzZNfV9IHMtNLjPnD/KfUvGt6FkZ3jxW2vpGAgAv8tKM7e4D31VnkLJwHyOY
	K44dhGTQZjbEmmgbQ8tLwOjIhqf83NPYELJxFqA98TMdyL3hZRpJ9m/jyzpIksTe
	vOWQr3n1X8zKXxaIOtznmrWqkHzFcGbOk+ETpOn5b1FlNS5uCG62bcLC3IZ9dWum
	z/04Keha0SV6+h4tGYMv5K5PHDsCji9SxLg==
X-ME-Sender: <xms:DvqOaIeP1_HslJpJyRGubESC_uCfoPqLZ_I4jtuelgcChT5j5BZiAA>
    <xme:DvqOaEx0GXQOpk6jM3FqWe_N8jUviMXsMFvEx9B2KOw0MFmD4A_cK0zBJp2t1XYdN
    -ggt9uDbzR6EY6O1g>
X-ME-Received: <xmr:DvqOaGHagkRRBYdhD579rbys7P--OMZu5zyvxZfS4UrviJHDyYTzTeUJ7xK1WuKZnQ1Vv-Om8zxl0UcdH4gvv5WrEmYcB4W8KVJBF98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgefgtdfggffhheegieegtdefuedvuedvheejveekieevteekfeekgefgueef
    ieegnecuffhomhgrihhnpehtgihtrdhinhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DvqOaAxXl9ibbk22dGUqlx5cRDN8xSMgga8ibYugzSvX6XN_fJN3Og>
    <xmx:DvqOaPslSybZSAzEVHcRFdFl36-Nmw6CIbK8xGLzXlm961JN-aRzxg>
    <xmx:DvqOaF3BbQeqVx4ophZKGrm_SuyhQX0HbUM80j-1tulGIS7YtUWSNQ>
    <xmx:DvqOaC_JXcihMbkAR_0SqwOo6s_naCHCiog2KL6K0h5tfJR4KfgK5Q>
    <xmx:DvqOaGNShzbKaXhLNsJ0WEARe44gluQQ3V1HK1-EyJBY5aWr9EyFVeOx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 01:56:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
In-Reply-To: <20250802185238.GE1773585@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Aug 2025 14:52:38 -0400")
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
	<xmqqv7nezdw2.fsf@gitster.g>
	<CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
	<20250802094657.GG3711639@coredump.intra.peff.net>
	<CALnO6CALb-_RjNZw9u-0R33O+KfccfZK0+mF-W7G659wc4PW7Q@mail.gmail.com>
	<20250802185238.GE1773585@coredump.intra.peff.net>
Date: Sat, 02 Aug 2025 22:56:28 -0700
Message-ID: <xmqqbjoxgd83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But here's the interesting part: it breaks a bunch of tests. They all
> seem to be doing things like ":file.txt". In check_filename() right now
> we treat that literally. But as a pathspec, it is technically "colon
> followed by zero or more magic signature letters", and it is eaten.

Hmph.  Shouldn't the definition be "colon and then one or more magic
signature letters", then?  ":file.txt" to name the blob object at
path file.txt in the index is fairly common "rev" and it is a shame
that it has to become ambiguous with a pathspec element.

> So I wonder if we have painted ourselves into a compatibility corner a
> bit, if we have two conflicting expectations. We might be better off
> just teaching check_filename() to parse multiple of [^/!] and the
> trailing colon. It's horrible and not great for maintainability, but
> this syntax is not something that changes often.

Ah, OK.

So the idea is that when given _as_ a pathspec element (e.g., after
an explicit "--" separator), we do want to interpret ":file.txt" as
the same as "file.txt", but when dwimming to sift revs and pathspec
elements apart, prefer to take it as a blob object name in the
index?

I guess that would work better than the current code (or straight
"use the full pathspec parser" approach) from the compatibility
viewpoint.

Thanks.
