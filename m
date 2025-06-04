Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9A433B3
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022570; cv=none; b=lqyQ548COHz/xLOMzsN1E1ueqCVg96mFWEv85Ly/A5k/xpuW0RSXVnt/KQN30Rp5tYQhXJtTTGCmDKQJ1dw/p0rXOTAYDjLVL/SC8AhzrelGdoTq3yzwSIDrsQ7ca3wbxPjbOpRfuJaPsERMfkEzqJ8aIsfVYVy1hYLIaX4cZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022570; c=relaxed/simple;
	bh=0SBMW9gqrzALElqadw4FzOKYvnOvOgq0tAGD+adOnrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et977R4LjY6+GdEa3amk8H88ZIVXIQpAH2C2hmJiexR93f2cHSZUt9FXi0BDoVKQMPw4seR0p2z5iR4O2+q1QRGdjk/Oqt4ISgOjQeXjJkYUBG33ECaAOMTbEkwqgJw//8Q0SdHaimq0PMIURn3wdh4f9ESUBci26q5+SVIJHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqGskci6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9zA3tmd; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqGskci6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9zA3tmd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D55551380408;
	Wed,  4 Jun 2025 03:36:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 04 Jun 2025 03:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749022566;
	 x=1749108966; bh=ZLguOOhFDFNZo9QlAYntsAj/f0jml5nn0buFjWjblS4=; b=
	IqGskci6MJQQxwKj5KjJ1BX8bL6NW7Vq/+0h522RKdNo6JCllmXZHrvXFidzy9P5
	+bhze9xgTrx8X/cMlBjr3H7lzXcY5T3BDB66Ccf0ttef33ZVFUglE0/jVBh+9AkZ
	jiwrCDizbhG1vjo4pp6B99KCb0CqekUFC47D8R6GyTvtV4f/Y0AVVzRxulIRdNhA
	4pYXrc7PLaxF9kvUg7Q3Av+WAW69kHpWtUT7cshJLzMDwBJRPINTYIBOWIR66hgR
	nkHyrdV0nDjd5wFX2KJbCJxXjI/aWu+tL0P8wcTY04K0vftjvIGQ6DxmQAlmxGMP
	Ze++KsXZ5HGPQTnFzS0lFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749022566; x=
	1749108966; bh=ZLguOOhFDFNZo9QlAYntsAj/f0jml5nn0buFjWjblS4=; b=b
	9zA3tmd2y6EfPcGLlzUnFRsG7psomCOJKiPM5q506AZu39pEAuPzq+r2LEfzMiDr
	88rirUy3UpiCzhDZgczVKKqi5r1f0OsmyVsW2NyTd5lyaJaaN1Y6tPu9b2XHDHhR
	UyIqNFvvhWTdNB630RBQB5U+m8B6la0wMW4l6B823kA8+z7BYsxMI5WvhrV9kYgr
	dO3MWhF7ZiQC1GyZwl6VmeaO//K53Ro0xDq7L5Vyy0AOkJqXFuJcMduMWDrB+PEw
	yMBGrVVIbgsk1ldmWHACW4w5+CCubUXR6qYVpbkHVVJdCoqM9gsL+oE2wJLHm4bJ
	PTiS+dJC1Rqri/9RmGyRQ==
X-ME-Sender: <xms:Zvc_aIf5pwua2oXgLnvnUKbPvL-1DtAne3ZZX_DMwqwFvN7DpSyvIA>
    <xme:Zvc_aKOkHkOJ43ePDIqs4qjQFnw0boBr23A_FFUk_7QtTRo4Rafwjd9BbVUe52Cjs
    9lRP0h41Pkxn_GM_Q>
X-ME-Received: <xmr:Zvc_aJjjmjO0lEH7tOe6xFGPYnbyxyo7Qp7Ecc7K-nJdEyuV06xM5-QewlcsCc2PMGzH-MPBRUEHBgSqC2lj68uZ19Mrco4cK5Y9JovLvOl_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhesghhlrghnughiuhhmrdhorhhgpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Zvc_aN_jcAahVhnWELR_kc92YuQ4pkUt0f7A-e_Cc4gt_AUIgUbVNg>
    <xmx:Zvc_aEsko9oQQEv2vpbdLIDQDsrdrOTkmvp5eNa32APseGbpepgnPw>
    <xmx:Zvc_aEFyHKrf4trFEdw6L_gqfMcs7AxM9oknkmN_lz0WGgTz2PjFPA>
    <xmx:Zvc_aDOdTCGu4DeBAZXRy-3WvhnLwUWIZugoSPitEAXjOPNn5yJrHw>
    <xmx:Zvc_aDUsUr8QJusQpWqbWySrpzBSC3X2l1ssK8jcUcdj7zCgh-X_yoD0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:36:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 085fe314 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 07:36:04 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:36:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/4] Fix maybe-uninitialized warning with GCC at -O3
Message-ID: <aD_3Y0PQtfg8Dd9z@pks.im>
References: <20250603230646.2322671-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603230646.2322671-1-mh@glandium.org>

On Wed, Jun 04, 2025 at 08:06:43AM +0900, Mike Hommey wrote:
> ```
> In file included from parse-options.c:1:
> git-compat-util.h: In function ‘get_value’:
> git-compat-util.h:489:21: error: ‘arg’ may be used uninitialized [-Werror=maybe-uninitialized]
>   489 | #define error(...) (error(__VA_ARGS__), const_error())
>       |                     ^~~~~
> parse-options.c:76:21: note: ‘arg’ was declared here
>    76 |         const char *arg;
>       |                     ^~~
> ```

A bit more explanation whether this warning is a false positive or
whether this may be an actual issue would be welcome.

Patrick
