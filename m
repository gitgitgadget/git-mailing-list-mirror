Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CD288C12
	for <git@vger.kernel.org>; Wed,  7 May 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624527; cv=none; b=qGN74wMNCnMfyW+GyKHUYpkQDM4EEAd2aJMxmdY8uKWv5+kWO22EtZRWAjgBNbFMmUku/QvavBNRWHEnY3aDOvk95E1MNpbikhs7Jj7BW8KJFUUIoX3PWYFRGoGvWoCxxCjbBfZO/Y4InMqGNY17fGUeGVx36Rg1pcTphvuPKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624527; c=relaxed/simple;
	bh=2Ecs0r6YHBcoY4ZAh92QtlM527X5X0QNXD11myxioAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9R8v9TxKUjbrqZQQ1prK9wEsNARgZoqm/om1x07kgYjXGewUjXll0EFVIULFNtokxClvv/tTdHz7y/wiux1NiUDpFFtXnakDlPwQzmLe99AlZRnzpe5sOC0iVfj7Q0JpsGYbr+jWPiJnZX3ZGlhPmVsYZPHR2bIh3tQHaveUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=do+z7+lG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QOvFyirh; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="do+z7+lG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QOvFyirh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A07825400C8;
	Wed,  7 May 2025 09:28:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 09:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746624521; x=1746710921; bh=jr6+pqj1HJ
	siENoRK3uuw1Q0acL+afSjezRlecdwgGQ=; b=do+z7+lGnpPavTb3xX4EDyke7C
	uvTnJbqWmSHZKLEj80cGlHv+Gz/M5kLFjfUjDSlmy1XITAaRzrPFeicVkncw0cbA
	tdTWqipgssHY0/KzpVLN5dTm5nOtJhJBRjSoSMSSdnBfGI348Z3yzzaU0OHv4iq/
	Qy8OM73Y/QNMDy4lsvkZOS4pfmR/pZbuWTDspnH1RMGfEKAYUtkTxt8izS2i7DR+
	rYonAMRN36xg3VO1K8JyC1D7ZS3NI4P5UpglIN2oxK9WaOiSv92vLxNxMEjjf4c6
	TFv0oX8qd1i0DK7b/VhGSy3wQzgAG1P4fZ/XBQLJOb0WPfLXGBXpelTNnK1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746624521; x=1746710921; bh=jr6+pqj1HJsiENoRK3uuw1Q0acL+afSjezR
	lecdwgGQ=; b=QOvFyirhy2OOHyGCJn8/pAUyQLvUzYA6C/8jIuqSYPVttpgx7ml
	yWV7D9y7lruUA1MhvZLj9NCjty8bi87I/ePtge2yUTk6jBrGcSbQIszuopxFmHLO
	unIe6y4e0G0gMU1S/HNF59AE8UDNjZ8CXr7Uohs+o5xvu5dujqo4I/e48yQI9udw
	M30VG31yVNFbbyz/z1n7batFWEH627EgNFZzQ79eFoC/+R0xQ8I845hHRD8tW2Ap
	pAGRztWSAyR41rG9bRjYS9e0A/dBA0l6EZutmQRK0Q5l+Q4+f6KStEt+OCKzsy+V
	4cSqEs+s9NvUOcC2EuiKChXLiKTdk0ObxCw==
X-ME-Sender: <xms:CWAbaOg_JH8TUbOm83Ra3ngep0QwECm5RjMje6c3Nrv23TRUaxA9sw>
    <xme:CWAbaPDBrxVw3txiGd5WuayZdBxWFDM2ZFw6iS_c3_XJJg5te8HDQHGl3QdldimB0
    DolkL63SSiLNY7UmQ>
X-ME-Received: <xmr:CWAbaGGLswQdalvJKvBocsP8UcUIhqkB20-lSUQi6OzAVQesE4G0H6edXWSdgJCr8iSDVwdsPhpufClkBPmmkgDWeEb82lKBEaOrlkVh1JMahA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeffffevheetudekgeejtdeuhfejgeehtdfftefg
    geefleejfefhgfeuheejhfdvnecuffhomhgrihhnpehpkhhsrdhimhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CWAbaHTq-i89gdJf7lB2kT92yGh4yp0yBwu1UJKnAeu8uTFsQMGYhQ>
    <xmx:CWAbaLzPrdPI_D-k3FCeCP6McwSPjwBu6n_ti402MIBmUjOsY1_w_Q>
    <xmx:CWAbaF732lOGo4OEehEwdDBBmdlHArtfSncQL2TDu6b_u29C2Nm6Sw>
    <xmx:CWAbaIxYv2_G3KTIcgHHW_aN76pzNXv14Eo9AlHjFRzfr8KeTnOC2Q>
    <xmx:CWAbaNrtq_4Vs5v3dIGYJ4Z4IOsy1DafCDwvHsaT4EWJDSRO-H5-lzCF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 09:28:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0fbe861b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 13:28:34 +0000 (UTC)
Date: Wed, 7 May 2025 15:28:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [RFC PATCH 2/2] builtin/receive-pack: add option to skip
 connectivity check
Message-ID: <aBtgBQxv4_NanE-r@pks.im>
References: <20250507030249.4802-1-jltobler@gmail.com>
 <20250507030249.4802-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507030249.4802-3-jltobler@gmail.com>

On Tue, May 06, 2025 at 10:02:49PM -0500, Justin Tobler wrote:
> During git-receive-pack(1), connectivity of the object graph is
> validated to ensure that the received packfile does not leave the
> repository in a broken state.
> 
> Generally, this check is critical to avoid an incomplete receieved

s/receieved/received/

> packfile from corrupting a repository. In situations where server
> operators validate the connectivity of incoming objects outside of Git,
> such a check may be redundant.

This is a bit handwavy. _I_ know why we at GitLab are doing this, but
other readers won't have the necessary context to be able to judge
whether this really is a good idea. I think the important question to
answer is: why does the server side want to perform the check if Git
already does it anyway? Why is it in a better position to do so? And why
can't we instead have Git itself perform it in the same "better" way?

Ultimately it boils down to having more knowledge around exactly how Git
is being used on the server side. With the additional information we can
make better decisions and we can make assumptions that a general user of
the connectivity check cannot do.

Most importantly, we know that all objects in the repository will always
be fully connected. Received packfiles get filtered, so we won't ever
accept an object that isn't fully connected. Neither will Gitaly write
such an object.

So what we can do in Gitaly specifically is similar to what I proposed
in [1] a while ago: we simply walk all received objects and then verify
that the edges resolve to objects in the existing repository. The idea
was rightfully shot down because we cannot assume in general that a mere
object walk in the quarantine directory really means that all objects
are fully connected. But with the extra knowledge we have in Gitaly we
can do this optimization indeed.

Patrick

[1]: <cover.1621451532.git.ps@pks.im>
