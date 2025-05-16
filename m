Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0B230BF9
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389148; cv=none; b=SWFAts8H5NAtOLSPmbP/z32XahIZB/0RZTs4oc28rtfKelvIbq6saBKTzxPUJ2/D2Bxg/RL9BYbsIacfK7k6cjnhP8R7/Uio5oMCqJqvebWfPRwV0ag4X18AFESuWYqYaoN5tux9LokaiqsJ4auNaEBRJ8BRIoUqWY0k1jZiNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389148; c=relaxed/simple;
	bh=LIPLid4F0zocTk2hdje8kcVMRl4aNMeu0ToRDlSZFWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBNj/nYd0a+vi3ZFn6r3opnTmkWYS+VOexzl4ucsqYWm5B/DrWc7MTkYln4pkjBwEI13VyuMg86H+lUY0+TIHiYTDJEFa4XaYcLgafOailk/54Rn3hNbcKtDdeqlCPnkQhlsB87GuHub+A/lgJCs2iLa8CrT30iLIltocNaq5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hTjrq9Hl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJYTPKOv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hTjrq9Hl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJYTPKOv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5725D138020F;
	Fri, 16 May 2025 05:52:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 16 May 2025 05:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747389145; x=1747475545; bh=Ywto3E9cF/
	DvsIZ3fCEN1HvhUCeAKzdevA1lQu2Q2gQ=; b=hTjrq9HlnDrcEk0Qoi2Jq7En1F
	yVCSIcSnol7tTC3Hxf65UXWqveQ9F7X/+PfBQlS3tZSXzmcuaimIQDqRDe+1DjaT
	jIcuj2afKRwrStBc6iu/6A/yMeqUNh+yYdGybaj8bJcHW/Hyhc4Qram7/BUqJpZc
	e2jpr1lqx1aB7c57jU9UD9wMcGnxkxkDBhFdn2kn1iONTic7yJDcWHu+9dKbMt/4
	tSI8wMoPfcBcQ5uPc5PxZPntgHJfruQBdx5wazdXHFLMV3hpL3Xo11hidEDusBRC
	gloWYFxNkYxey6DD4KVb+GRXFC7WcfbAM+0eJyd04AJ2qmjaO+De31myXQFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747389145; x=1747475545; bh=Ywto3E9cF/DvsIZ3fCEN1HvhUCeAKzdevA1
	lQu2Q2gQ=; b=fJYTPKOvMqNVP8xA5N3ZGhfQYbQYiYYSzYO6tBWrtfckw+1gTAQ
	hPYZ81b+fvMeGPMThtNw29eMDMB+4s90xnxTPtQHKcLx+JuoDQd1pVCq+hsr4XPm
	oZHhqDiZ9iWYiXKhWIjiUpW7xf5Bn4rpqDoImhhoVfdxoJv/XM17AK7YLl6izzUF
	mwz2eCh0GL1DO6WwQ4/pGiMM9/JwMS/8R8uDH7dLtnLax3Bu6HkWathXmhTW77iC
	PGKfkFM87Ll2XnOPju3Vj1Wu6muMpiAdZE9+JFvTo3/9haO5+781zysMHEFOuMNs
	fC97RUV7cWIpPmYq47MnshBJF8OpUqCbQOw==
X-ME-Sender: <xms:2QonaDXNifMl0UmeXpRyeLttc50EMfvReeVMs6sS-Mt21QntRHHPBQ>
    <xme:2QonaLkZ3OqHCL3n-vohIhmo_WTuPcRnlPRfk8LyRzOhF-EDCVpl44vSsw1yxacOP
    oDncl91_eI6EIRptQ>
X-ME-Received: <xmr:2QonaPaBv9o2XYquOmZAASDVzqFwe0NF6VFGkW5C2hPbiIeKZkEkWeTK00IXJNl0QwROpshi_91XvD2IpkO5F5l6Hez63vo3928kZmbd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:2QonaOXF-JnVQhvrK5pNLMycbzCvbKRrQdGzOIy0dE9BAaCS0-lljw>
    <xmx:2QonaNnEF1KZkh9E7XhLiQTSRh7jEFssJs1gpAYeFfc0rfKpacdufg>
    <xmx:2QonaLdi7HV2ar4vimnRxgfzUSLp8Futz2tgo3XoIFZ81JmAlN4t_A>
    <xmx:2QonaHEDqLvimngsvOJAHwJxtKEAWqPZ_VmyaqzsBXBLGx3_Ks3e7w>
    <xmx:2QonaMcW_vHuUaWI5JCJ8YRjm-MhUCsleYNZ_poif5pYwwTVyiXhB-Xd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 05:52:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2bf6812d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 09:52:22 +0000 (UTC)
Date: Fri, 16 May 2025 11:52:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] cat-file: make --allow-unknown-type a noop
Message-ID: <aCcK0p7wMURHppe7@pks.im>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516044935.GB22242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516044935.GB22242@coredump.intra.peff.net>

On Fri, May 16, 2025 at 12:49:35AM -0400, Jeff King wrote:
> The cat-file command has some minor support for handling objects with
> "unknown" types. I.e., strings that are not "blob", "commit", "tree", or
> "tag".
> 
> In theory this could be used for debugging or experimenting with
> extensions to Git. But in practice this support is not very useful:
> 
>   1. You can get the type and size of such objects, but nothing else.
>      Not even the contents!
> 
>   2. Only loose objects are supported, since packfiles use numeric ids
>      for the types, rather than strings.
> 
>   3. Likewise you cannot ever transfer objects between repositories,
>      because they cannot be represented in the packfiles used for the
>      on-the-wire protocol.

All of these are good reasons. To add one more: they would probably
prove to be a pain for pluggable object databases, too. No need to add
that to the list here though given that there isn't even a design doc
for those yet.

> The support for these unknown types complicates the object-parsing code,
> and has led to bugs such as b748ddb7a4 (unpack_loose_header(): fix
> infinite loop on broken zlib input, 2025-02-25). So let's drop it.
> 
> The first step is to remove the user-facing parts, which are accessible
> only via cat-file. This is technically backwards-incompatible, but given
> the limitations listed above, these objects couldn't possibly be useful
> in any workflow.

I agree.

> However, we can't just rip out the option entirely. That would hurt a
> caller who ran:
> 
>   git cat-file -t --allow-unknown-object <oid>
> 
> and fed it normal, well-formed objects. There --allow-unknown-type was
> doing nothing, but we wouldn't want to start bailing with an error. So
> to protect any such callers, we'll retain --allow-unknown-type as a
> noop.

Okay, that sounds reasonable to me.

> The code change is fairly small (but we'll able to clean up more code in
> follow-on patches). The test updates drop any use of the option. We
> still retain tests that feed the broken objects to cat-file without
> --allow-unknown-type, as we should continue to confirm that those
> objects are rejected. Note that in one spot we can drop a layer of loop,
> re-indenting the body; viewing the diff with "-w" helps there.

Shouldn't we have a test though that the option is still accepted, even
though it doesn't do anything?

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-cat-file.adoc |   6 +-
>  builtin/cat-file.c              |  18 +--
>  t/t1006-cat-file.sh             | 211 ++++++++------------------------
>  3 files changed, 56 insertions(+), 179 deletions(-)
> 
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index fc4b92f104..cde79ad242 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -9,8 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git cat-file' <type> <object>
> -'git cat-file' (-e | -p) <object>
> -'git cat-file' (-t | -s) [--allow-unknown-type] <object>
> +'git cat-file' (-e | -p | -t | -s) <object>
>  'git cat-file' (--textconv | --filters)
>  	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
>  'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
> @@ -202,9 +201,6 @@ flush::
>  	only once, even if it is stored multiple times in the
>  	repository.
>  
> ---allow-unknown-type::
> -	Allow `-s` or `-t` to query broken/corrupt objects of unknown type.
> -

Should we maybe introduce a "deprecated" section and spell out that this
option is a no-op nowadays that will be removed for example in Git 3.0?

Patrick
