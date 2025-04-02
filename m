Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A3234987
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592393; cv=none; b=QWuJPmyVP8iiHqi5OPdJB3nlS7CrWYrWdnAr9KR91CvUwJQRDUsD/UWfbRuZJgtiVsgdK+6nd77kjosBO6SPKHcoJ4zlPJRdPDK33E7QAmPcNZCTCK0e83LGLmJZx6wdPCwqaFHrSEHJtDYh6i+bd/7PtarC1cunOL0iXgSFfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592393; c=relaxed/simple;
	bh=zQgiNhtEEfvkEXTCwnFCSUVRcPYu6E/9uUJvUMNUyQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwhrcdKky3WnTKvdXHsvhQTuESNGX9/JTXvcPkUIiqo42d6lTmKTx7sd7fj26ix8xIhM+CFCBobHBJoIPOPKaEw/cKsMv/GZshT4Ko2KgykEW0asxnyI8EkwsN7qvp7b5zXVzKmqgimhQK7yuAyKbdJX9PU72oCkgYzRgQSAt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fvDLtQ8c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hy13AEZW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fvDLtQ8c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hy13AEZW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 77FEB11401F7;
	Wed,  2 Apr 2025 07:13:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 02 Apr 2025 07:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743592390; x=1743678790; bh=7SSAaknUb5
	penE5L7N9xD3vWCr2y4OH8NMYMc7wm3aE=; b=fvDLtQ8cIxr9pFjJiHdP+GyOrW
	7RjPHLUeIge7kn56fqYm0zgJcUykmKu6Eh1WTkVSrEh/j+7yQRgVeCT1tx5edeCY
	JJ6wFfk35715YHBc08KxVvEcE9c3Kee11KJLV0rlierD8NiUfpUZCNNuYaEi1Pzk
	FQUj24cDVSC9+bFFqTUMLe6/CrHkKVkE34DUs/QgPc0SG5f/qyn2pHQMmSfhTGY+
	1nQgPgAFVu49PEXu84g7gL2uVIxz2/e12TVADp3jSDObG3Z0bVxIS4oUvBG4hqiE
	2tVZEmXTbtLf2XBNGVjKW/8H0yrKrdXENh/pS2kxIJy7SyOfcnyBSDMKPOeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743592390; x=1743678790; bh=7SSAaknUb5penE5L7N9xD3vWCr2y4OH8NMY
	Mc7wm3aE=; b=hy13AEZWRJVjXLjpExUFHMhuvmsuMySUR8ZB3j4y7Qx4+2nbns7
	Um3KbqBmUZAOQ8fGbv18dxiq3co+/T82SfrWq6hht46+bTALNmb0NF+Iw+CnFFFQ
	lnfFf79d+pticb35Y4oc62neGpsO85FZq8CvspZzJALOB3f4qEIX9+JvIN94D9fl
	Ewm4f2R8jXwbgBNkOJeAh4Us07d1ttJjbHgsbQiGtXVqc7VW/gQK1fXZQSxiiRBr
	DBktpdG8WDysFLVY35TDew8lcQFZYGYPaO95QbB3hu96HZ4osi5/cZrJaiqj+tXv
	oRTEDeGwCkTLJdh/A1lzJ8BuQUmr421XZlw==
X-ME-Sender: <xms:xRvtZ_D8nOZpy1UcVHfNz6hkU9JwbhjOc9vOORjZxUK83T5jjbF97w>
    <xme:xRvtZ1huTdF2FcycEgYukhZSW2Ctpbm6iKo-3xtQZLwEi-DHC5RNUQhwygXe2sL3P
    ln5EF-i12o5uO2pFw>
X-ME-Received: <xmr:xRvtZ6ljm6_qX3aEYOMsNG62D285Ucahyu7LvrHx8FA8hsEj8fcqv8oEwwOIYXY-AX2WXl1tZnJLVUpZ9jM8iTlNY3T5jlbrzJNlnWGI9RJ_NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:xRvtZxyxYhPx-1pg6CYPpRyXeKjJ9rQrTG0wjltPcZNKfUFNfGRj_A>
    <xmx:xRvtZ0RVOLaIiXM-uwwYwdYs9d6hanQHrtX6rQkT0x62aSo1SmymZg>
    <xmx:xRvtZ0YCLkaaA-2LeRhbiCCDTAozw7uElMPEZOuBTQVJ-_uVpKPJ-g>
    <xmx:xRvtZ1Rtx3aX0Tc5xGlnnIBewQbJbJYCdlQJsGsOBG1yFsFEX3rMkQ>
    <xmx:xhvtZ7DS2C5Bl2pqRN7kMbKDvyrH-Z0aWfwOZRTQwe4PmyGa5AeBvaBx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ab2259a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:05 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:13:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] builtin/cat-file: rename variable that tracks
 usage
Message-ID: <Z-0bwFewNxUM7HUe@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-1-4bbc7085d7c5@pks.im>
 <CAOLa=ZTukdPiciDSyH1oGwYN_bdCw+vYjsHaV9AwHEpxJ5hBgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTukdPiciDSyH1oGwYN_bdCw+vYjsHaV9AwHEpxJ5hBgQ@mail.gmail.com>

On Tue, Apr 01, 2025 at 02:51:01AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The usage strings for git-cat-file(1) that we pass to `parse_options()`
> > and `usage_msg_optf()` are stored in a variable called `usage`. This
> > variable shadows the declaration of `usage()`, which we'll want to use
> > in a subsequent commit.
> >
> > Rename the variable to `builtin_catfile_usage`, which is in line with
> > how the variable is typically called in other builtins.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/cat-file.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index b13561cf73b..8e40016dd24 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -941,7 +941,7 @@ int cmd_cat_file(int argc,
> >  	int input_nul_terminated = 0;
> >  	int nul_terminated = 0;
> >
> > -	const char * const usage[] = {
> > +	const char * const builtin_catfile_usage[] = {
> 
> Nit: Style: we use a right pointer alignment, while it is not part of
> your code change, would be nice to fix.

Not in this case though:

 $ git grep 'const char \*const' | wc -l
 85
 $ git grep 'const char \* const' | wc -l
 180

It's mixed, but we do have more cases of the latter.

Patrick
