Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5887207A18
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804090; cv=none; b=hK7u8n+PmcLOIPw0asmEA2hI0gPMwYT91Dz/0ddrYRPgCtEqMs2fyouwq4HTscBLd2CGy1KMFcvx8K37OLKc6G/vpiO+VqOSo1xcbORuQqu1AP9EP6ddQ+5D+PXC5FCtfDB//zI06shuqwXJ5CGKN4ZwsIux6Ji4g9/UrlB7bjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804090; c=relaxed/simple;
	bh=IuvrD2yNdsobxXNwjx2rT7tn2roAGQ7YNpxnX22q+MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYgiDZ36yghgnsbEyShNNop93pRhvG/+xsc+oTxYZYL5bujDf4dJrJrp4ts+x/gbzTXKwnLAvjm08BS/knogpL31CnibWLr864pu/57ExRbaAmZAZ0ImxtUUGejKPPqMz1O4YEWsdZfC4JDvYNRvw2omdymfLdAyanJo/y/0YWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dTpG7KJd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eyqN/sMx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dTpG7KJd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eyqN/sMx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E807AEC0457;
	Tue,  2 Sep 2025 05:08:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 02 Sep 2025 05:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756804087;
	 x=1756890487; bh=cMnmku3lz4a5zkCXe0fMzKO69rWRq9a6cR0yKcqkylU=; b=
	dTpG7KJd6KHqPle9AdR9sMwkywzBl9RZhzvgjnAtOkqdpvmaHa7yfGBHB5Kw8om/
	/OyHZdaPh+DY0naBcI9VH4ixvwlUvxNGaSF3lb0JAU6GtkDk/ws2GHULezoOJOS0
	yHMzNLSPZQ/pMcKN01XiktmTpUSy9Ifj+5nbvdxHUeFn8UoM9b9eUARKzBIF5+hW
	ytMFn8Q1Hu8Gn3LHPN/uwOxpOmHA8+2ObhfdXz6lCA2GyshzeHQ1kUTU3hfAj1aJ
	Fk5qKmuKWc8GXx0eI2fDX+Xm7h7HmnfU3QEw4UXSQME6PrG8zi8X/VyEZo/8Vx4T
	joiznPmuYwL3tK1eJIeghQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756804087; x=
	1756890487; bh=cMnmku3lz4a5zkCXe0fMzKO69rWRq9a6cR0yKcqkylU=; b=e
	yqN/sMx0USZPPqh0mo0bJc7bjbUhVueCyEJ0ZKpAvvUH+PvbSHaYouVTPLACQcWB
	Rx/ZKak0VGZkyw/T3gb95bC63mfqIqCaqLnWwTaa+/tCu0221MvjC9154gXa+OPG
	oZx49MO3mlW3mdddeUPswLUYgYg1nNRS5IZwe1LhFnv4Lfn1xlzZFv+hqY7ahpwe
	RD3/5t9MHTpCWbg0Yt2/wb2kXL3SXctMku9NIytgN2qR0/26lyY1BRVw2xvwLG95
	EIY3kSO/agQ7eRGSQOWiZXxU6vnkNtbeySmOKebNBfpXt1sDBmeg/ycqRdofSzbm
	oHPDYaR94LfnzwV5TaWIw==
X-ME-Sender: <xms:97O2aPvDvhiG3eQ7Vav-BuOWOQolaw1Qlhn1FJSLG0rEXeE7l5mrjw>
    <xme:97O2aDv8Lnc2pfv9_OrTR8bHPvidyV4sL1XNmi2cRY0wgllGYWuufKgalfV97pw6x
    NrzqVzaTu3kXcQE2w>
X-ME-Received: <xmr:97O2aMPqzI6BEenq3e-fH29usVZ2_JB_WK4EoQEDc7a25Fixgm5Y2iO8icKzapdOqxl4cV7aN5RFmXZnMA6CT98oEwCwEG-4aFmtBciT3_hxFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsvg
    honhhghhihvghonhgthhholeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:97O2aJ2iUNjYVfpMguEr42XfbEKWkjAdMHN2Sd2U4EevMc5BdUcxmA>
    <xmx:97O2aAPMu6UApKdRWrXB2lIVcTZ6zY6pri5n0Xy66NOizDNlNP0N_Q>
    <xmx:97O2aB2Z12TtbdYKjphs1vzrIb2myg6lXNFjg_8hNw56vUaJmfD3tw>
    <xmx:97O2aPH_RlNn3GG2JkUAan3fEVk8cBEy_5As1i8_FIgrRYj3I4VA7Q>
    <xmx:97O2aBpC-kBfqm0dW4HAvK6OUZPRLL84eQv18qtWZyAmQuRP8dVdw_o5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 05:08:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0f96f76 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 09:08:03 +0000 (UTC)
Date: Tue, 2 Sep 2025 11:07:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seonghyeon Cho =?utf-8?B?KOyhsOyEse2YhCk=?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Seonghyeon Cho =?utf-8?B?KOyhsOyEse2YhCk=?= <seonghyeoncho96@gmail.com>
Subject: Re: [PATCH] add-interactive: reject malformed numerical input
Message-ID: <aLaz7yCXWGG2_oP_@pks.im>
References: <pull.2044.git.git.1756553495661.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2044.git.git.1756553495661.gitgitgadget@gmail.com>

On Sat, Aug 30, 2025 at 11:31:35AM +0000, Seonghyeon Cho (조성현) via GitGitGadget wrote:
> From: Seonghyeon Cho <seonghyeoncho96@gmail.com>
> 
> The list-and-choose interface accepts malformed input such as "2m3" and
> interprets it as "2-", silently selecting a range to the end. This is
> misleading and makes it easy to select unintended items.
> 
> Reject such input by treating it as invalid.

Okay, that does feel fishy indeed. It would be good though to have a
test case that demonstrates the new behaviour and at the same time
ensures that we don't regress in the future. You can have a look at
"t3701-add-interactive.sh", which has a bunch of other tests for this
command, as well.

In general though we're not doing a good job here of error checking. We
don't at all verify whether `strtoul()` returned an error, for example
ERANGE. So if a user passes an integer that exceeds whatever we can
store in an `unsigned long` we'll silently proceed with a bogus result,
won't we?

Ideally, we'd use a saner interface to parse these integers, like for
example our own `git_parse_ulong()`. But unfortunately, that interface
does not handle the case where we only want to parse a substring in a
longer string. Too bad.

> diff --git a/add-interactive.c b/add-interactive.c
> index 3e692b47ec..86ff632288 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -396,6 +396,8 @@ static ssize_t list_and_choose(struct add_i_state *s,
>  					if (endp != p + sep)
>  						from = -1;
>  				}
> +				else
> +					from = -1;
>  			}

Coding style: the `else` should sit on the same line as the closing
curly brace. And furthermore, if one of the branches of an if-else chain
requires curly braces, then all branches should have curly braces.

Patrick
