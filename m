Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B138827
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653461; cv=none; b=IJ1ovX3FxVli2DpGWWFeahX2ac4aBeYBTaWCmhFyLLmxIWZzCOzkan8SeXMnaKVs3Jius1g4+qBxME0TEhUVNZfAF1ZuG+H+Gq7hZSIl2ktu3joDyCgEjieSsdfwv2CvHWL/lYf9djflYB5aYAiPdg5ttIRYqk0nExTdpi91GZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653461; c=relaxed/simple;
	bh=b5cPnB9ITqornumXzpNx+Tyn8TyQUgq0gWN6Co/JAts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOFxFRcYhh3s4nXmh551YcYamPLQZmpsZEUelBkhbGhPLmb4/eOeA/bRxAa2htlqUC2V5OeMalWEwnM1SRv45OZjLdML0ahKcPbEqk4Jv/gpZrvSQQQ3pEcN2Mm8iJNMl/VnDMh4JsFMdzBKXBaGEE3HzRGCjfmYXks84oDLW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B2EPhTpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jx3h27c6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B2EPhTpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jx3h27c6"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id F2F7A13909E9;
	Mon, 26 Aug 2024 02:24:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 02:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724653457; x=1724739857; bh=Apr5Ql9WxN
	dhWMHWc8h26NmZvq2jRo/GbpBR3Yc00WE=; b=B2EPhTpr70DnL4on1A+VstroWO
	fi2XI0oRPUPynU9RLRIYFD5FUfx3PF8OePyaYhHY2IGpZ8yBiv7wSlRdK1qF92yW
	1rc+pncYd/pfvngAP31qD5NNzeopUqtm6B+Djpj+nHX8yUV9JtYcfvxZ5Gci7Dbo
	rjGqVQjB4BUuR4cZ5uFTHLWI6JMgH7L+Iy2fuhPpWihFVGNZ/THSk/iUy5QzADA7
	qOBvTnKN6nfK0jrcYsoaZwkoz1uRSSuducUpOit9S0fP8DysUM8+M/cpTbYCOZmb
	OCmDgJvFNMGW99F4q4E3je4FgFVlQOZXWlmYKOpQLi34yua35AG4Yp5LdVhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724653457; x=1724739857; bh=Apr5Ql9WxNdhWMHWc8h26NmZvq2j
	Ro/GbpBR3Yc00WE=; b=jx3h27c6T2wx47ai98ZiCiiaxAWn+z4tdmEBn7lkmVEI
	kHeQ87HsCPAXTjSaKGKfGqmb3s0fPbjr16rkNw0wD+2ksC9ZebBZ6BxWIbCQJ+p/
	J9x+PYQd4/3hs7EsIXSqfR43UQTA4W3pGfLHG6B874OCzKX6IeLLOOlzRbJQSdmQ
	rbHGXK2SQvCCSaOQAVuUXhCK9Kk9QLl44M2IEglbo9lRMIFblK+nsLlEKAOcQzX8
	jj8BrjBwiZGxEDSM5W9NedZIdhYiUFjRMwEKuF883e5Y29x+DW9NmmUJIFlmqDf9
	6K40ljNUhCWWIIswAk6xaU2GfG5tV5q1ymlMMj9uFg==
X-ME-Sender: <xms:kR_MZi29Caey_vCYCJtKBM-tujqLr9RDsimCSJOojnVxCnAlOuq70w>
    <xme:kR_MZlEWjpK_8pv263IvI69rs3o_x-zk-oA7aauk5sQ_4lKi8xRgtM5CMfeTn5vsT
    TbXom33LV8owEVSJQ>
X-ME-Received: <xmr:kR_MZq6emNYRSFOezz93yRasrUh-7vRCmHDiVEx1MzckbNwCIccsm4YUdPGLYB4C34vHt66S8_paVGDu0UCgyH1yb5LA2J7Pl5j_IShWJjlu1JI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohgvlhgrtggrnhhthhhushhhvg
    igsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:kR_MZj1Q1-5AVxiGAele6J2N6gRm2nnnnHICBWy-FfSFxFkS17F5Eg>
    <xmx:kR_MZlG8Qz7JDihuwFgeMJw1DlasyhxVV5xlz8-2T-xBloeT-lMuDw>
    <xmx:kR_MZs-QmrduRwEMf3m4qOCTfbmU8yzulAsba2CRS31Z4437JznQfQ>
    <xmx:kR_MZqkzW34V68aBXNIHcDZiG439eYQJf0dO1NjuStFmbBi2PfxXDA>
    <xmx:kR_MZlChcA-FbZjej3DVU4ZO3sSmQ8YYyk9XJatTltPpYlufktYDv9iC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 02:24:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08ee4395 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 06:24:13 +0000 (UTC)
Date: Mon, 26 Aug 2024 08:24:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
Message-ID: <ZswfgYsZrzY6kc1E@tanuki>
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
 <Zsgh4LacdOt8N69o@tanuki>
 <6c9f666e-12ad-4b67-a44a-3111686454f3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c9f666e-12ad-4b67-a44a-3111686454f3@gmail.com>

On Fri, Aug 23, 2024 at 04:21:15PM +0800, Celeste Liu wrote:
> 
> On 2024-08-23 13:45, Patrick Steinhardt wrote:
> > On Fri, Aug 23, 2024 at 01:20:41AM +0800, Celeste Liu wrote:
> >> Commit 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
> >> introduced this typo.
> > 
> > We typically do not word the commit message as a continuation of the
> > subject. The subject often becomes invisible in many contexts, so it is
> > helpful if it can be read standalone while providing all of the context
> > necessary. So mentioning what is wrong would be welcome here.
> > 
> >> Fixes: 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
> > 
> > We do not use Fixes tags in the Git project.
> > 
> >> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> >> ---
> >>  Documentation/git-config.txt | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> >> index 65c645d461..79360328aa 100644
> >> --- a/Documentation/git-config.txt
> >> +++ b/Documentation/git-config.txt
> >> @@ -130,7 +130,7 @@ OPTIONS
> >>  --all::
> >>  	With `get`, return all values for a multi-valued key.
> >>  
> >> ----regexp::
> >> +--regexp::
> >>  	With `get`, interpret the name as a regular expression. Regular
> >>  	expression matching is currently case-sensitive and done against a
> >>  	canonicalized version of the key in which section and variable names
> > 
> > This looks obviously correct to me.
> > 
> > There's one more thing I noticed: the synopsis for `git config get` says
> > `--regrexp=<regexp>`, which is clearly wrong. As you're already at it,
> > would you mind including a second patch that corrects this?
> 
> I couldn't find this typo. Did I miss something? If something missed, please 
> tell me. I will include it in v3.
> v2 has been sent.

It's in line 13 in Documentation/git-config.txt. Seeing that your v2 is
already out and queued for `next` by Junio I wouldn't fix that in a v3
resend though. If you want to fix that as well, I'd just send a separate
patch.

Also fine if you just ignore this, I can also fix this myself. Just let
me know your preference :)

Patrick
