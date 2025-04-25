Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29AA1A00ED
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598898; cv=none; b=oe4fj4CwBSa9dEF7I4pqd3lk4XeuU0yRz8ZaqkdNbAMa7S/abTYRB63cXZ2X9f17Q0rc1zTryZ19S+RNqR3wFS0vZjxZDAMEHMHZ7wVgH69CQxOW30MyShzDk4URvSvf5mwpyb2kbkKNk1S1vRixrIwlS+2lw6unKbMvesTJ/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598898; c=relaxed/simple;
	bh=NzVwqWcDzRiSUbFMTvDs3moi0pV2vl4lmXvdPPfEafo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Go7nxTY21lMVX4IyMxtraoShEjLUZPLRr9d+mn+NjODafpFQPRDqXvyWHe4cIo5K9mE3+Ipwb1v7NZzIVu0hgqlgrF/+oPxrss/8HqzeRVlYqkGMomR3ReSr9bTsFS0RvLhfb1HNFIadw/2lyq8V09bTlu/VBHzu8KUCp0eQHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EZcMsCGo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FzNk0IUT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EZcMsCGo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FzNk0IUT"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A518011401CA;
	Fri, 25 Apr 2025 12:34:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 25 Apr 2025 12:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745598895; x=1745685295; bh=X4lM8Qkfnu
	QiuV/AJPBB13jdhP3/Uomg+NpvdKFsgkk=; b=EZcMsCGozvaDn6VpxHK8/tA4MT
	7YuG8j7Df76+mSkVpytQ4MXpHhzQQYUWA+rUFhZVVBdAGTDFBYmEHJia8H3U3wiw
	azbt/CQwFv13H06I/+99fvrJSx1GRwBNWbwb9o0F1baqtpQrEhA7r80tLXXZZ6P2
	nM/z/kdAkj1ZFfxy9fLUXLhi8Lu7d/FjB5RyEmkmGvd69YulXCJbW+7CCOGz2fRo
	Ud0MnrmytiWhZ0NqZZwegtmw9CDtXWy//ZG5T6qlMTn5OXZYsIon+Cj0OTd9L4au
	FsuNaZmiel84LW4O2GXusNPeTF5gVCNS1UyjPS0yd7hdM8V3yHDAS3M700lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745598895; x=1745685295; bh=X4lM8QkfnuQiuV/AJPBB13jdhP3/Uomg+Np
	vdKFsgkk=; b=FzNk0IUT2RrMMgxHXfk2JkujBpEnuxTFOHrdY30mTSfru3fDaiF
	2LBGRUA16WYhrcpfqiM7hBRFAX/GD5zajXfrDcssH+f1j2vrpKVIw4hctmgPd3wW
	P4QY2Q6v2BlXgx5hGO7/YgK4S3Luq+uaBJoyn4b/BXCI51DmMTS77qOAIdTcHWN1
	LfoJJ4KxK4q6UGblr/a3Ry8pji/deC8ruajhfP5clMnXnuuUUMzF+KhVYEJno/Se
	Y8JEXuEhOqZvJF8tVYcaAhgOhwZLqgUc3PrWezGhrh6S3yZjuO3rlqDsFujmq92K
	XscRmxDwRN8cqYOPTEpXFOQ/fHQy7OuyfLQ==
X-ME-Sender: <xms:r7kLaMoa_0xcRPgzZniNFHibZ99o6topYHRE7ep1IypGuaM1Cr9RIA>
    <xme:r7kLaCoA3iBinZNq-Z9ItfR7HZKx4kdTNWYZl_fqT7ql-epR4_p09m1svpRcEpvVH
    wg7zzrXzDoypyWwzw>
X-ME-Received: <xmr:r7kLaBMmxPy1MWu7vwiV0wT8mgTVMCjguQICdob6GGMn-J-oyAKi6Fvmi-fDDIejvhpmpUr3eBdao65EzaNovCX1UTn6zXl7FYsC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsrdhrvg
    hpohhrthesghhmgidrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:r7kLaD60ILJ0fz9-mmmo1HQjMpuT7dIqin74Or9bQ_HCsMyxSzCVAA>
    <xmx:r7kLaL42SGNwNVO4CSgbjUthyuqXmJPdK-smuv2DAiYw6nfWSr4FeA>
    <xmx:r7kLaDif_OLXkjQfMuup8dTloY5A01XVPNVVxpi2IQ_XhCN_Osf9oA>
    <xmx:r7kLaF6s2WbU_-IopDthl3fUDjYuyeUnu0AOD1Qy_6I5a7E2oxE1Dg>
    <xmx:r7kLaDAMBetQxMV4CGhH4fdHFITf2P0hOwNJ27p00dmvucGSFbiFLGBy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 12:34:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eli Schwartz <eschwartz@gentoo.org>,  git@vger.kernel.org,  Peter
 Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH 1/2] meson: report detected runtime executable paths
In-Reply-To: <aAsbwvtKTiZFRnXM@pks.im> (Patrick Steinhardt's message of "Fri,
	25 Apr 2025 07:21:06 +0200")
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
	<20250424-pks-meson-posix-shell-v1-1-45e06ee4b6ad@pks.im>
	<43e86c8f-904b-4572-b84d-009c203fda11@gentoo.org>
	<aAsbwvtKTiZFRnXM@pks.im>
Date: Fri, 25 Apr 2025 09:34:53 -0700
Message-ID: <xmqq7c38urma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Apr 24, 2025 at 08:45:44PM -0400, Eli Schwartz wrote:
>> On 4/24/25 9:38 AM, Patrick Steinhardt wrote:
>> > diff --git a/meson.build b/meson.build
>> > index c47cb79af08..8f04534c7ff 100644
>> > --- a/meson.build
>> > +++ b/meson.build
>> > @@ -2080,3 +2080,9 @@ summary({
>> >    'sha256': sha256_backend,
>> >    'zlib': zlib_backend,
>> >  }, section: 'Backends')
>> > +
>> > +summary({
>> > +  'perl': target_perl.found() ? target_perl.full_path() : 'none',
>> > +  'python': target_python.found() ? target_python.full_path() : 'none',
>> > +  'shell': target_shell.full_path(),
>> > +}, section: 'Runtime executable paths')
>> 
>> summary({
>>   'perl': target_perl,
>>   'python': target_python,
>>   'shell': target_shell,
>> }, section: 'Runtime executable paths')
>> 
>> 
>> No need to check if they are found. Meson will print the full_path()
>> already, if it is found, and if it is not found, it will print "NO" in
>> its standard color code (red) for things-that-are-missing.
>
> Oh, that's much nicer indeed. Thanks!

That is a lot more pleasant to the eyes.

Thanks for working well together.


