Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92B7DA6A
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998520; cv=none; b=UU5gOhMb2v8DnRyFLTBDljYtKHSKfMJpFzlfyaA9bXpSiVwof9lwXEOl/D6++5rs4nlpTMpxe+bD9gG4YF6y6JTFmnDY836ntiv1M2+5ZInPofvaDZzK8u58DvqzgRX7KTwPeEqo5iurnEVujNWlvskneFXAJwlIOD5o0GzgbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998520; c=relaxed/simple;
	bh=RUdZSSw4ByW4It/fIii8vcOBq4irNOCTfWbPG7gCIOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bPfrVfQx73DtpPPp216YNZ1fc7zIKgZnjS3CuvQ5RtvI3+tZ+nfzKGOnY/aYxqx3T6JnjxfJuBK9OGwuCvEh4kQv93f2vkGIM9p86tPEqUkqRVZJDxSjX62FsJS8RoMZvtlQNsoSke0rQwZyXTJOQLa0xbz+F8KAX8BUzX7Rdik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DBbkGvs+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dtrbmhrW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DBbkGvs+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dtrbmhrW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A9E6913801CB;
	Mon, 27 Jan 2025 12:21:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 27 Jan 2025 12:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737998516; x=1738084916; bh=U9SIFqk/Kw
	RMWyAFU1Sp/2/3nlvry/KGoqEUpeigBAI=; b=DBbkGvs+csJlr0LMGFAO1BwLia
	fGA0VFViT0J+klyV5/kTDHFRTa61tGcD5S5rQ9EXWVUn03IJI9M3OWy6t5/Fcgks
	GYVi6g0vRY63WROOWWhfiWiFf6ntBXbqcdnyqJpS40Xo9vOHPKx+QNF6kGlBB8ue
	c+PxwYrCGjzP7bFP4Ja4hhekmFQwERmDH2b2I15tDaQvYg14GECIq/OiQRHWr7oi
	aJAflFAchrq/xZDxyWd2HRPlE2Yo6Xv3FmPdIOkpiacoT41r8DiXO7MrTt5UjKjQ
	K4EYV1YLWsR2wwsK/pLOmDqbqBOBtO3LCG6IpKqy3n2UJOph9jCI9kAb/shQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737998516; x=1738084916; bh=U9SIFqk/KwRMWyAFU1Sp/2/3nlvry/KGoqE
	UpeigBAI=; b=dtrbmhrW3i7Hm7V/zfjNIE4GqMIhQ/8m7D57EGdVbqD8z5I8OCz
	RrYPOEv4f4PTmkW98bKtU7O4AKi7bQrSN94BKDEwNWgEuKTpB4ksYNzr/yy4YsFO
	h6Q2h4qzLVS/pHttiAclZl3qHiSw1tRy2FfYI3ooOuvJ0/APVRpnUHl9bYkuHiOQ
	6mJVym5v4sNhBdwVPabcWbwnPloM4JjQosweNyjyoazVpUeZdw8WKoS+jNlybPca
	2RjzCUqxgxoRUoJKLLVGu+0okDM3EXNYYA9xVv58GAuihLGZl5Wv1orXzEKDONWx
	0qMfrwjBgRt2wtlF+MBQYmq5BGVIFG8sWGA==
X-ME-Sender: <xms:tMCXZ9ChWZCEk0NOLD064BrhUW9NTs4vML9IYrhzRebMaRgGGRqtug>
    <xme:tMCXZ7jhQNHbUAdoGAYLEY6uZPQDwIWh5G4t0t2ob0Fq12apIQJTPMkq1FcMoCnfJ
    3C3eXSDDbREl6i6EA>
X-ME-Received: <xmr:tMCXZ4nDawCM6R6rix7h2OfaTIO_gNLUio1Javdm92UwhCF7AP3OGtHrwmF3wZfw_Bw7jwAR-i3LtzrMWfow7USxVXZxFql35cZR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvggvthhsoh
    hniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgshhgrmhdrkhgrnhhoughirgdutdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehprghvvghlrdhrrghpphhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjrggtoh
    gsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepmhgrthhtrhelgeesghhmrghilhdrtghomhdprhgtphhtthhope
    hjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tMCXZ3zDvlQJRrvYX-ACeImDYX66MFy36EDstOSwtA7QNK_7N8QPXw>
    <xmx:tMCXZyRobnME-ByaROWfEt1fYFIhgIVp4YA8nZAtRZkFNfCKYGX9YA>
    <xmx:tMCXZ6ZLqRGiRtYiHFaWjh7Y93-oINL0jpfXQZgPAzl6I3HSAEIZSw>
    <xmx:tMCXZzTrscIugkQR3fqvc1ijrj-cbcum3w9ey2cdSInZdQ5POdtbdw>
    <xmx:tMCXZ3JLj2woT7ZzRavgeoaDSpdiMkHfn-andnbUD1FKWG5MDVAjEMPu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 12:21:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  shubham.kanodia10@gmail.com,  Pavel Rappo
 <pavel.rappo@gmail.com>,  Jeff King <peff@peff.net>,  Jacob Keller
 <jacob.e.keller@intel.com>,  Patrick Steinhardt <ps@pks.im>,  Matthew
 Rogers <mattr94@gmail.com>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 1/3] refspec: relocate omit_name_by_refspec and
 related functions
In-Reply-To: <20250127103644.36627-2-meetsoni3017@gmail.com> (Meet Soni's
	message of "Mon, 27 Jan 2025 16:06:42 +0530")
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
	<20250127103644.36627-2-meetsoni3017@gmail.com>
Date: Mon, 27 Jan 2025 09:21:54 -0800
Message-ID: <xmqqa5bctbnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Move the functions `omit_name_by_refspec()`, `refspec_match()`, and
> `match_name_with_pattern()` from `remote.c` to `refspec.c`. These
> functions focus on refspec matching, so placing them in `refspec.c`
> aligns with the separation of concerns. Keep refspec-related logic in
> `refspec.c` and remote-specific logic in `remote.c` for better code
> organization.
>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
> ...
> diff --git a/refspec.h b/refspec.h
> index 69d693c87d..891d50b159 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -71,4 +71,17 @@ struct strvec;
>  void refspec_ref_prefixes(const struct refspec *rs,
>  			  struct strvec *ref_prefixes);

Back when these functions were mere local helper functions in
remote.c, their name being less descriptive of what they do may have
been OK (because readers have more context to understand them), but
when we make it a part of a public API, we should re-evaluate if
their names are good enough.

> +/*
> + * Check whether a name matches any negative refspec in rs. Returns 1 if the
> + * name matches at least one negative refspec, and 0 otherwise.
> + */
> +int omit_name_by_refspec(const char *name, struct refspec *rs);

Imagine you found this description in the header file and are trying
to figure out if it helps you writing the feature you are adding to
Git.  Are the above description and the name of the function useful
enough to you?

The first question that came to my mind was "what is exactly a 'name'?"

In the context of the original, the caller iterates over a list of
"struct ref" and feeds the "name" member of the struct, but this
caller does not even have to know it is getting a part of "struct
ref"; it only cares about its parameter being a character string.

In that context, is "name" the best identifer you can give to this
parameter?  At least calling it "refname" might boost the signal the
name gives to the reader a bit better (and it is in line with how
refs.h calls these things).

Another thing to consider is if the comment describes the purpose of
the function well, instead of just rephrasing what its
implementation does.  What does it mean to return true iff there is
even one negative refspec that matches?  What is the conceivable use
a caller would want to use such a function?

As I said, calling it "omit" was probably OK in the context of the
original file, but it was already sloppy.  This function merely
provides one bit of information (i.e. "does it match any nagative
refspec---Yes or No?"), and it is up to its caller how to use that
piece of information form.

One of its callers, apply_negative_refspecs(), happens to use it to
filter a list of "struct ref" it received from its caller to drop
the refs from the list that match any negative refspec, but the
other existing caller does not even filter or omit anything from a
collection it has.

My personal preference is to do this kind of change in two separate
patches:

 (1) as a preliminary clean-up, we rename functions and their
     parameters in the original place; if needed, add clarifying
     comments.

 (2) move the resulting functions with the comments to their new
     home.

If these two step conversions results in

extern int refname_matches_negative_refspec_item
	(const char *refname, struct refspec *refspec);

I suspect that it is clear enough that there is no need for any
extra comment to explain what it does.

> +/*
> + * Checks whether a name matches a pattern and optionally generates a result.
> + * Returns 1 if the name matches the pattern, 0 otherwise.
> + */
> +int match_name_with_pattern(const char *key, const char *name,
> +				   const char *value, char **result);
> +

As this is merely moved from an existing header, I am tempted to say
I'll leave it as an exercise to the readers to improve this one, as
improving it is outside the scope of this work.

Some hints for those who want to tackle the clean-up for extra
points, perhaps after the dust settles from this series.

The "pattern" in the name refers to the src side of a globbing
refspec and is passed in the parameter "key", so we are calling the
same thing in three different names, which is already triply bad.

"optionally generates a result" does not convey any meaning outside
the context of the original, as it does not even talk about what
computation is creating the result.  It does not even say what
controls the optionality---without reading the implementation, it is
likely your readers would assume passing NULL to result is all it
takes to skip that optional feature, but that is not the case.

If I understand correctly, here is what this one does.

   It takes the source side of a globbing refspec item (e.g.
   "refs/heads/*" in "refs/heads/*:refs/remotes/origin/*"), a
   refname that might match the glob pattern, the destination side
   of the refspec item (e.g. "refs/remotes/origin/*" in the same
   example), and a pointer that points at a variable to receive the
   result.  If the source pattern matches the given refname, apply
   the source-to-destination mapping rule to compute the resulting
   destination refname and store it in the result.

   The destination side is optional; if you do not need to map the
   refname to another refname, but are merely interested if the
   refname matches the glob pattern, you can pass NULL and result
   location is not touched.

   In either case, returns true iff the source side of the globbing
   refspec item matches the given refname.

So "name" in the function name should probably become a bit
narrower, like "refname".  Also the names of its parameters need to
be better thought out.
