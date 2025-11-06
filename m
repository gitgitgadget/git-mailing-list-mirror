Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DA274B2B
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413733; cv=none; b=kiXjLoBu1BKgt5Tx1BPPkYGGV/dTqv2wHIQtiqQSsNPusBeGvBer/ngi+M85zeNmNnNilYhYAclxZDFCbefIU6/Xupu0xqQXVkoZoabn4ksjg7rsDQIkI8Cbxpcbb2vbplpAjah4njK9CD01J6VgPotxei73/AjaK/L0+X7+Z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413733; c=relaxed/simple;
	bh=BHWdpYTClnSrxXhNAOnKPC73GQWz5JO0sqr8jVx0Klw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kl0h4vjVbbQKCir/4BBVWi5i3efl2i5/2PGb4neFsTzZlxRuVWS0OV+aaHKJAbVwW9HtsHredJ9EQkKp7JLf2hadg2kYWlgS7wk8N1IrzgsVL2pS07tnbZQw0fIohKYeZj+43Pa0inQiAe0ABH8sLa3t09C4WtHbYQtg2b+QwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bJzFNUgX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWqfq9cM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bJzFNUgX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWqfq9cM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6631714000B8;
	Thu,  6 Nov 2025 02:22:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Nov 2025 02:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762413728; x=1762500128; bh=FfZc0eZqbN
	44DyffoYbd+9mM/n2aOBWRTJ+pAsklS40=; b=bJzFNUgXaX6YiIZZeno/TmFMmX
	1kARfSqXKgfuYoBw9HyjjrJ27kMxIcvcikBvWGZid63/h4F3RTw4YYU9H63IjLlC
	g7mXKhxhlEyLY5O7/g7W/wJ7Cb9uIrPtsfvDP7/TIQBV5kXcMDirFRdfpwns/456
	almdVawYx9LJYY9I/IGxBia5zLiaOjhma7JQlwMlZfVMo5GdIJeH75EzaYuvohGE
	oBJaQb/2d3nAmvNwMIeg+mnfp/ZL6ISD7VI+jZblNTSeuk0Oxjc3VruCWy41/AFf
	RoHA6yZ4iX9yl3X20NGRGvVszKsFml+lHgiW9OE/ghP9cI+iT/lrE8mmLo6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762413728; x=1762500128; bh=FfZc0eZqbN44DyffoYbd+9mM/n2aOBWRTJ+
	pAsklS40=; b=kWqfq9cMDHwx0kLWB2nqMBfCYy+jSEbvL9TUNGfwRikdcSVSCRF
	aeUX73t/f9kL74VZc/tk3AAR5JrB8oIUDIXYa4wcOosqIoJGLjfitbB7j3eYC6u8
	OBjjNBPYRkfGlqaLqavjdnB/0Fi47G34CaBazdPNqOnbcFHM5F0yR+TpBbEIW1w+
	8MXxRiVSpSu4b+fqiZb5csLtX2qNrP7ZirX8isXqTyNO1ClP8CCzPQ1k1p33KHjb
	vw8gqjB5PxtJM56LkUeWeRCnMx3hbyRht8IheAoRdSLOBXh3lBFu00Kv7f8dvxmT
	QxyjeFqZ6q6pgDswi9mXj8iq701pBqPZ3rg==
X-ME-Sender: <xms:oEwMacKVWNPQldrJ5OoycC6ZOXfhN3HeQPgrFBazN_WmVgNUheMdaQ>
    <xme:oEwMaTkH7o8mO-acpy0mNTXQuEpq3YAlcCY-RAFyM3RQdKaXGw7pTA30WIHfcUPhr
    D_zsbj5-9imvz0sqwQ1rnL57I4nnYo4lhRDPz4TtPMJthxkOnrTkQ>
X-ME-Received: <xmr:oEwMaaFR4G2CqJJlcuZnFS76Ozrd8TkqKZELXrJIfdaGaojO-CMSOFH_jZPhYHbvdjR_b84sINs46Uo1m2szF1msCZMnSaK49CwS3hNSODz_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeekheeujeffteefuddvleekveeggfdtgefgtd
    ffkeegtefhudeuffffueetkedvvdenucffohhmrghinhepphgvrhhlrdhinhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvod
    hgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oEwMaTHrDxnvGpVwfQabu1lAAasMdj2efWXJ0rCcmZ4QLNWh_abs_g>
    <xmx:oEwMaXOlorIFJ3YsrSsr5ApbY_CkFCRaza6E0Ql1cFH3XQKjnVUQ5g>
    <xmx:oEwMaSFFe3pZD0_uGQ3WaBGKKDnLI2POEiDJrNs1IpZ6r-8DpZ5F6Q>
    <xmx:oEwMaeMe16wKMbW2hN9I7KvzMdUjkucxVZILRa2x93XIzhYMrYXFfQ>
    <xmx:oEwMabmSXvhJhuGWxW-JHVBH2lc08jDWIczK-uCjK_INAHOt2WLAGvsu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 02:22:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8fd6cd59 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 07:22:06 +0000 (UTC)
Date: Thu, 6 Nov 2025 08:22:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl: also mark git-contacts executable
Message-ID: <aQxMmnzPR6swvG-d@pks.im>
References: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>

On Tue, Nov 04, 2025 at 01:14:57PM -0500, D. Ben Knoble wrote:
> When install git-contacts with Meson via -Dcontrib=contacts, the default

s/install/installing/

> Perl generation fails to mark it executable. As a result, "git contacts"
> reports "'contacts' is not a git command."
> 
> Unlike generate-script.sh, we aren't testing the basename here; so, glob
> the script name in the case arm to match wherever the input comes from.

Yeah, that feels sensibel to me.

> diff --git a/generate-perl.sh b/generate-perl.sh
> index 65f122ebfc..796d835932 100755
> --- a/generate-perl.sh
> +++ b/generate-perl.sh
> @@ -30,7 +30,7 @@
>      "$INPUT" >"$OUTPUT"
>  
>  case "$INPUT" in
> -*.perl)
> +*.perl|*git-contacts)
>  	chmod a+x "$OUTPUT";;
>  *)
>  	;;

And the change looks as expected. An alternative could of course be to
rename the file in-tree to "git-contacts.perl". In that case we wouldn't
require this special case at all. But I guess that this here is good
enough, and there might be other consequences if we renamed the script.

Thanks!

Patrick
