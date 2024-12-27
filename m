Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208231E489
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308399; cv=none; b=lq0aNhhgCQmkrJuPT5GEG5ur09hzUSYneaMrsPHf9P8EF6J4PmZolA9s7DtS/QO9VYm2HdIRBRidKi3uWyE+bLeb14RmMuYL5IcTupV6lkc2OOulzDkuPPrv0csESu8prQJoOPc7ZN0/e2VsNrHnJ7RCCY94A8Ns78gVPe8SWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308399; c=relaxed/simple;
	bh=IRBv1D0EuOwQQEj3TTVg1jqWv/Xl9dVTJ3W2a4eP+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLkLswneBpCCngJGLg2kxFu6+jegTujvSTeTUKRITNYjsig4CsMWG28qn+7CoRI751SCqw+JOrQ6q1HNxKOrrYsBya1ja+ZPKInrCnMe//9YsKmgGd7uX7ZszPVBXFKZ8xIjiQMOM/ozCaKRIDK1we+NSdtaqWudblWDS4FerAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rLWenWxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BGBGBmo0; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rLWenWxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BGBGBmo0"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F071114005D;
	Fri, 27 Dec 2024 09:06:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 09:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735308394; x=1735394794; bh=iu9Q9+1pr5
	w+/o60B86j6sdlnUlQ/Rq2qwWs1/2DqCI=; b=rLWenWxdHw+0C+jypRM+ZlxPbP
	0sLmqKPHPqQwkco4xJmnLv26paJCqcOXgm/P9H3bQHkfeuzQ6cmOzaXj6DVHwAws
	WMOSnLGiVxNv5hDtB0phv9wjvtdiWFHJX8IJGK7sEZqcJDq1xcOQWDUzFvOzqMuy
	KoZQow72Int4iBDAmU8Hy4zEPCDdPrCXgCB9zESJ+dIi8VOOea335c5ppjSNvQeF
	cEZdbhtBliN5mEQV/XVLORvCTULFEt6C4+O3I5w5I/DMFjW34l90Toy0Vh5zFbFj
	hUfSn1AwVrnTjNh/7VMw314b5hIJfbFsJWuJmyO+0o2tQzLyEIx9nCQIKkvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735308394; x=1735394794; bh=iu9Q9+1pr5w+/o60B86j6sdlnUlQ/Rq2qwW
	s1/2DqCI=; b=BGBGBmo01eRN/ZQZExLnxmgfogLjuBanCuoYEo4zMZ+JLOGv96Q
	lA05/+Al6Mr96KvXG/9r7IK1UD33cilS51XAoXSXhNnaa5bNAGqbI5mjNTgm5iRS
	B50xOdelzjl/8aSTPtaD2fOwcFzxVoTy7Yy6X9/3+jakS2ACxn2p7MLFNjCZdGaH
	2srWMWt8Z6qEZTA4Hlucg0ILPKtrzVuZrXrj26yPrCTWa5rgNq5Op9dGBoHTf9on
	RD8AZbJt41qlPeIaSXLZAOOd/XKvOag5/Nn+Znfm/xj+Q8OVTOGNyhr1X3Qj4MmW
	TFWCW2M3MPjb3HPuTY6oJFzseAihQYXiSJg==
X-ME-Sender: <xms:arRuZ7U1usPK1X-KUtlG7LEC96yYeYVJUGjPqPNyAqQleEHPP17VAQ>
    <xme:arRuZzmYW2P7mvP2ktACKmiR_aSQDeJmjNlfzMIwwJKz3gmiIcPtYvMURqBC4tcjQ
    FiOuZurtsckAF5lNw>
X-ME-Received: <xmr:arRuZ3Zer1IgYSfuMzKzwWvQV-uJMapmAn7sXd2tgIshvFp-wiZqFbcU4k8DWytAIdsKaUjUjFrBV0GuX3LvPfypXQrdSlB5VNIFmFVJB1h-iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiteefteeile
    dtgfeklefhieeikeeuudelhfffuedutedufeetgeevtdeuffekkeenucffohhmrghinhep
    shhhohifqdhinhguvgigrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:arRuZ2WoNHFD4A9VK26DnaYRQ9PsyvsuT_mEnuXizuyjI3GR7nyMwA>
    <xmx:arRuZ1k1FpI2LbrW58Ab7SV8455IJyJO3MhZGOq68SygYOa9Jd-HVQ>
    <xmx:arRuZzdJVQR3Z7kNyOAv2GQ_3aQ2D0PnzuOsMoTOzNELAcs-rmwxng>
    <xmx:arRuZ_EnaRusOQUYdP9D50uQC4BqVN0n4YM1u4HRk1ldr9ga-B8K0Q>
    <xmx:arRuZ6w0p1l7U8_8qne5VbAkQ2al8071xUkb0b6rTi7vFw8R1nFnhQsO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:06:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a581337 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 14:04:28 +0000 (UTC)
Date: Fri, 27 Dec 2024 15:06:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] show-index: the short help should say the command reads
 from its input
Message-ID: <Z260VVuIH_-0Ylis@pks.im>
References: <xmqqfrmidyhk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrmidyhk.fsf@gitster.g>

On Fri, Dec 20, 2024 at 10:02:15AM -0800, Junio C Hamano wrote:
> The short help text given by "git show-index -h" says
> 
>     $ git show-index -h
>     usage: git show-index [--object-format=<hash-algorithm>]
> 
>         --[no-]object-format <hash-algorithm>
>                               specify the hash algorithm to use
> 
> 
> The command takes a pack .idx file from its standard input.  The
> user has to _know_ this, as there is no indication from this output.
> 
> Give a hint that the data to work on is fed from its standard input.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Makes sense.

>  * I also found the option description somewhat funny in that
> 
>    (1) it makes it look like "--no-object-format sha256" is
>    accepted, which is not a case, and
> 
>    (2) "git show-index --no-object-format" already is a curious
>    thing to say; the command certainly needs to work in _some_
>    format.
> 
>    But (2) is common to all the usual command line options to allow
>    defeating another instance of the same option that is given
>    positively previously on the command line (i.e. "git show-index
>    --object-format=sha256 --no-object-format" should behave as if no
>    object-format option was given), and (1) is shared by all the
>    other options that allow such override.  So I'll let it pass, but
>    if we really wanted to improve it, the fix should go into how the
>    parse-options subsystem works.

Can't we already fix this via OPT_NONEG? Or is your point rather that it
is awkward in general and choices like this should never have a negated
variant by default?

>  builtin/show-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git c/builtin/show-index.c w/builtin/show-index.c
> index f164c01bbe..8678b741a4 100644
> --- c/builtin/show-index.c
> +++ w/builtin/show-index.c
> @@ -7,7 +7,7 @@
>  #include "parse-options.h"
>  
>  static const char *const show_index_usage[] = {
> -	"git show-index [--object-format=<hash-algorithm>]",
> +	"git show-index [--object-format=<hash-algorithm>] < <pack-idx-file>",
>  	NULL
>  };

I was wondering whether we have any other usage strings that show an
expected stdin like this, and indeed we do. The usage string in
"builtin/mailinfo.c" uses different syntax though without the angular
brackets, but "builtin/pack-objects.c" does use them. I think with the
angular brackets is more idiomatic in our codebase though, so the
addition looks good to me.

Patrick
