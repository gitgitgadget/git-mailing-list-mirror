Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC89288C20
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769398; cv=none; b=bblyPQD5eXk55pqkoZDXyqXvyIeZzD4+IusZpAm5aNEBSLmP6Fh8YxjSi0ZXml8w/teUjCKuBG3W+cyOCSKQTIPZfwRGtB5IPlgHkkmsrrARwxqWwIuAn+IwooOKEEC3gKkuwl11I81izMBsJ0uZeX3HC5M2kc5BlzVRhTJw3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769398; c=relaxed/simple;
	bh=cSzwDxe4O0/5JOxdkwIY4ZCf1R0a52rUI4hD4sZN42w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mha28S8/x+TyNmrPtQ2y/O9UTYvPSuP4Z+XRjoVpxdv8xd1KED7Je8UHgiYj+GiPReTcNOvFxG10WgkdP3knmJX3DOEiMIvoXMzd3ReRtKJGJLkIQkzrXOUVhxfJ3Xb8WCI5/umaDGuK7PXhxsC4jgpJ54BiPj4Z+G+l6A052FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GQfiTbDD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yQrI8t08; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GQfiTbDD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQrI8t08"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E36A7A00F4;
	Mon, 10 Nov 2025 05:09:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 10 Nov 2025 05:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762769396; x=1762855796; bh=LF5mkGvZQR
	XymDPdyeXRToGkgOHQ2pxBaUwQ7jXn0QM=; b=GQfiTbDDlCKFpJbIuUk4V2FLQ5
	PrRdkpJVU3Hez059c9F37BQiGSMvBqDAfUcFqL6ljIz+MZpKgN8JPmSiXtFeg3kj
	9hWwpjUMLBz/vn9+pQNfWtqNqEcGgGJNh7RCnkYJZPcyotiueB3H55sq4XAFrkFi
	sh5MWTPo6pMAb3vQKdvyOj4WIYI/zy8vyQvY/mwXTPk/U4cAEVcVC8n3lCynOikD
	0sgZm3DO+sAHvX7bmxBofXcxmJzjZRtWyb8UVOF388miqjfjUOQ0BwK+P6JzeI1/
	swekBJVfELct9JwGeZMd+zL5nQjk6OTfDYvkjr8cxcji/knbBtiUdKLiSQ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762769396; x=1762855796; bh=LF5mkGvZQRXymDPdyeXRToGkgOHQ2pxBaUw
	Q7jXn0QM=; b=yQrI8t08127WaQ9G3GzjnNnl99SxGsfUt52zpW4uQ52ndvGdV+W
	1UB7YJT9tH3BYsnZIYKR+CrT8GXbEVKpNRy2oL43XdUDU/5I6Yz8VvkjBUeCSdJz
	nlYEI9NjVKqclrYMVizNxte1DaqxYbW2NholMpPUMkiY+3cYFGunfjeLoHi7M1JO
	iuuG9jfB9Dwar/S+wDQh3owVQ+82alIkSZ9U+5XCQi7/QX55P11XA1jrYkLgi5/g
	8W1JdIOBg2CRENwodTJPxJREPQg+eKS1T3PEgaZQFiLT40y7clKoCRBlSMk0fUhG
	SKpGe/aMeLk5Idh9H2QtVL3DXnJPn+KR66w==
X-ME-Sender: <xms:87kRaW2Rc8PMrIhAnxadfmV81h39MzYLMzWN0ppPsQd1Og0FVCIcbQ>
    <xme:87kRafF47Hu95ouSNK5doMLNFu_C3Ikm7m8Bxn44wY2NdGPi2qs5FNTFU9Ix6HJ-b
    QoeuEEWcXxfnzEEW4oI7CDnNA5aYzNX_BYzAj_sKP4V-sAtvzbgKg>
X-ME-Received: <xmr:87kRacj6zOhHHDWJWMloBIUbKNT1bcK3-XwSMTDX-bWI1-fra6_o884TwtS_0IDuD5OI40k_2WZ_4SJGu3IjeF626rblbNCNHm1bP1FAVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:87kRaS_A0BAm14I_ulEI1ekiYTI6-PZGucsz0qX_vEQg77exISjPdA>
    <xmx:87kRabqLpoy_UfSbqjC5psjhI_e492-quecJnZ9phfD-sPB2mxYhmw>
    <xmx:87kRaZ-Fgj2G1wlhG8U8sjCpuVierw9hPyGNrR4-loHMBNjusEUsnA>
    <xmx:87kRaXVxyGCbrte8C9nCTzuEHlgKf5cJeJE2ZriQbX8KqNXVTiZRVQ>
    <xmx:9LkRaSPa1s7qeXxa7p268xzUkXzhi9bNn6s_k8LZdSfIh13HojT9SuQJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 05:09:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d1835ea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 10 Nov 2025 10:09:53 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:09:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Incomplete lines
Message-ID: <aRG57pZ7nDfk78du@pks.im>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>

On Wed, Nov 05, 2025 at 01:30:40PM -0800, Junio C Hamano wrote:
> One of the common kind of whitespace errors is to lack the final
> newline at the end of a file, but so far, neither "git diff" or "git
> apply" did anything about them.
> 
> This series introduces "incomplete-line" whitespace error class,
> that you can add to either the core.whitespace configuration
> variable, or the whitespace attribute in your .gitattributes files.
> 
> The class is disabled by default, so the final step enables it for
> our project by defining it in the .gitattributes file.
> 
> The incomplete line marker that is given for a context line is not
> considered an error.  The reasoning is that your preimage did have
> incomplete line, but you did not touch the contents on that
> incomplete line in your patch, so you left the line intact.  It is
> not a new breakage you are responsible for.
> 
> If the incomplete line marker follows a postimage line, on the other
> hand, it means that you added a new line at the end of the file that
> is incomplete *and* that line did not exist in the preimage.  The
> last line of the preimage may have been incomplete already, but then
> you updated the contents on that line, so you could have easily
> fixed the incompleteness of the line while at it.  Either way, you
> are responsible for the incompleteness of the last ine in the
> resulting file.

I've read through the series and left two comments, but my review
definitely doesn't count as a "qualified" review. I'm way too oblivious
of what's happening in the diff subsystem to really be able to point out
any mistakes. So I hope that somebody more familiar with this code will
chime in.

That being said, I think that the end goal of this series is quite
useful and something that I want to have :)

Thanks!

Patrick
