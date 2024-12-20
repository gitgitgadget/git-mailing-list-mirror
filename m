Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82621A425
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711913; cv=none; b=U18lny3k+afgOD9bvL0KmVgQR7mFEFqoPlrEODoSNID994n02ek3pnlEfJvhotqtqbOTzwh8LtV6CFfxaT3uvl/NBsGXw0VfQqOnmG9twOYxPG4nrOXlHg3LRwxE5FQrOSG/CP7Gjb7/vIlcwNnxEftEnGn4bvOO6ZVAhjldFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711913; c=relaxed/simple;
	bh=+FxcafmjMbUTtIaPw+lAFNlDgi/LPPJr+ae5n0A0ROQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAxfqOTxqwl4LpuQFkesKpKh9wiyEEJWPaTI94Xcv60MffAmvqTJVpWAbFsNA6YPALn7LK85Ve3RTCJ8XVYHA51ddxrXlsVkMLHocaH5MNBsDf7vva/sumJqmgGNASPnDE+COE1PVLN1CPjpCYxIOsFHMKhvk73wIACZPuu1KBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKTszV9z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XX7qXzzW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKTszV9z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XX7qXzzW"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ED2DB1380228;
	Fri, 20 Dec 2024 11:25:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 20 Dec 2024 11:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734711909; x=1734798309; bh=dwxWRUJv5/
	WFcOLRj37VxJTEGV2L6w6MxX77VZ1L0kY=; b=kKTszV9zccVW4kvLPqPEQauCfA
	YhzB0rqcCSkOJjBs8WA/zpWB493D2x5MFHRAd6RnL0uXaCU6/sJI/i/JwcEpEfJ+
	g0ZBdgkRpm5YeunlAQFfQ+bIAVvtLxmQslhkzKL7GH5xpzL1dEV3sMnBxEC8pyl8
	C74GYHpdnvfV3msYAqUvUlH3tQWMtBOm3w2USSyWAaF/38VKtjpZZOtwzLC4w8Bj
	WLyUs520e7JQ6z82+ur5eZEjUEG7py+HWJPUgPHukToJ0Qbr172m9ret+HzpWmaC
	/fT3DOROup+dLf8fsn4dFonFGo8tkoCqbsvKAXPLEivxpJwpixq7hJYZkbGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734711909; x=1734798309; bh=dwxWRUJv5/WFcOLRj37VxJTEGV2L6w6MxX7
	7VZ1L0kY=; b=XX7qXzzWCAA1lWAYI3fxpGrMRccRHzSrnaCiPktiRGeP9sTt3Jx
	ytiVvse6m5+qF0d67tT8u3tnJIeiGP+thx8lcjxqgcfEIqRDjARokWocbnQPoMtU
	Y2lfHQIzx8Iq3gvNdyK7wPOkAfZgd3sANKla2quPJEqsJSLem60bbip3bx684Gp/
	cmStUNhC1IWfYvMZMR7p3t2IMtw0NCLVwe2zXy8IE4D/MRqpHdig9nI++fRs6oio
	czTLGsuJ5wFh38v3RpxucHJOerz6ykZ0RnWwpZjcs2aHjZrsYYX3W5v1kKlrQkYx
	JZ3pcIGedB2gHeztAxlJvdeb8VfsrBCVdXw==
X-ME-Sender: <xms:ZZplZ3lfeFefTHBoV17vVB4VihPuIGGMH6YciQf7G8muv4WywQ0tfw>
    <xme:ZZplZ614iZ2ypf4Z7_PMrua5fLeCdRG_i4mfLnHUW6XHwKZ2ZZIYK3yNPRYgGK-26
    PjPhs6nt2VEKTZXaA>
X-ME-Received: <xmr:ZZplZ9on0NJw5mgYR8_yxPURwsWv2zofqf15f0GLlVoKOYWmVBgcZ8eiNofVkZXqDCxzstChotkO1GmQDZN7ZyPpuFUvHTKUR1PWMfzx7coPghw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:ZZplZ_k_StT6Klo0sSJRGSlcns8pfMsE4bioBBjJCHLscvbRZ_CpJg>
    <xmx:ZZplZ1235jy_0w02uXpRlqvhfRFbip4GmC0jiEILPFaKmjKoNeTsjA>
    <xmx:ZZplZ-s8nGc8lw93u-eCyW7EmypPyErsXY3kMYtkBcZrvEoqk2PeNA>
    <xmx:ZZplZ5WjguG4VH57wxy30ZZtoMqoZv8zWWfEqSBkm1YOu2jdB-kHRw>
    <xmx:ZZplZwQw67k6MQtRw4MFpBYaTBatUM_8CcYCiRvfc9Zc89GRAiDJRf1N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 11:25:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61b981c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 16:23:12 +0000 (UTC)
Date: Fri, 20 Dec 2024 17:23:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 1/5] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <Z2WZ_6auUm0mVIqr@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-1-f1457a5e8c38@pks.im>
 <20241220155223.GA152570@coredump.intra.peff.net>
 <xmqqpllme3cl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpllme3cl.fsf@gitster.g>

On Fri, Dec 20, 2024 at 08:17:14AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > So I dunno. I like keeping things simple, but I also like skipping
> > unnecessary code, too. Maybe if the top hunk were:
> >
> >   if test -n "$GIT_VERSION"
> >   then
> >     : do nothing, we will use this value verbatim
> >   elif ...
> >
> > that would make the intended flow more obvious.
> 
> True.
> 
> > There are probably other ways to structure it, too. The whole $VN thing
> > could be inside the:
> >
> >   if test -z "$GIT_VERSION"
> >
> > block. Or alternatively, if each block of the if/else just ran expr and
> > set $GIT_VERSION itself (perhaps with a one-liner helper function) then
> > we wouldn't need $VN at all.
> 
> True again.  It has been quite a while since I wrote the original
> before the meson topic came up and the script hasn't changed for a
> long time (other than DEF_VER line for obvious reasons), but I think
> in that ancient version, $VN _was_ the variable to be looked at and
> GIT_VERSION did not even exist as a shell variable at all.
> 
> If $GIT_VERSION is serving the same role as old $VN in the
> mesonified version, perhaps we should get rid of the $VN variable to
> clarify the new world order.

I think for now I'll keep $VN, if even just to discern the intermediate
value without the leading "v" stripped from the final version that we
have in "$GIT_VERSION". But I'll send a revised version where I make the
control flow a bit more obvious.

Thanks!

Patrick
