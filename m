Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB73B27FA
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405530; cv=none; b=N9/4QRqJNBnuxmR+jhA3FuZFrELOgJ+IyMNt/L5PZ8wnv3kByDfeRJDikTdw+idqQTOZIu/3BtogRdLD+bZvy9+UnWj9ipxiVsSJZ/THW6DJjDOqWYWoOjhnJn9IDEn+eV1QyAs/O+/uRoS4hi3VEsL0lt2r1fTw2uVWDDjWuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405530; c=relaxed/simple;
	bh=097IOzSh8Jm1KtjSvOR1A++CDnU+YBzZ7gsqmCk4E4o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Lz+4h0OQaIdmR5IifDkzpENTs26bYuSOqxmY93SWd6W/nRe/eXZLqhPmKaCk7lku1HzLbVgyJ5QfJA+n2vQXG5kZS6jSrFgibsHfXdfoQoZBoBgSUDbyfobX6NdduF+WxCIK3rD6LzpBr4xSb1rFJ/UK2w+xKJjraVs/zd7xkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DwOhqvpC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVulUFHS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DwOhqvpC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVulUFHS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 420DE1D00136;
	Thu, 30 Jul 2026 05:58:48 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 05:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785405528;
	 x=1785491928; bh=/Ai/zdzBDNcAd+c6UQ42XQ8abWX5T4ZKx9k0xZcchbE=; b=
	DwOhqvpCrvsjj9s8sAuCCSbTHtaDtnFu3sSuc2u+CjDWCmFtTilJpJIxK2GjKNAB
	px/5T5jHAimw+kJ/vlZq46rELXdDVet6Gj5tX5GoIprl906lssKyZVQ8ztbrzM8D
	J7k6R26ATpRXKkzXlnuV7kzRioihd12Bm28kxdHI9p++4qz5MXYTexYdxDYAGZ9i
	fz/fM1Yes7TSJFNLRGyeu71R/eHvWWv6B5iNe/auyTC+bZS7IuHUr9MHoaMiW8N8
	wZqctMH9ezh2m7nsiTBQhIW0043CyRrGTJWJhHJVBNk20WFa1cZoTJsDllaHwvn4
	juC5OPFO5MWn7OZXntfGeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785405528; x=
	1785491928; bh=/Ai/zdzBDNcAd+c6UQ42XQ8abWX5T4ZKx9k0xZcchbE=; b=C
	VulUFHSaJ0pv48FmLnB7rDvd7yljXb2i3UD6u4tERvDz0+5MqtfS0bsfQZxnJeZ5
	U9OXI0ogd2YXInGLJD21O9LzIfaNR20X/YqOyE3pYb886nO+O0QElPnrTBUZah1D
	ObQYxBNNtYsXMXV34mYJ1zHoklYAVQexjawWrHvbI589dDVSfOdWa5ILiHwBhY9J
	AQS0fCpdaH8H2mGaG7xPlEUW/3DtnvhpTVwAvF97kahg8h8uvDq+6gr0mv05W/ai
	zO0bvJbaSyX7fFXQ4ij6SlmR7GNdPHw+Bj2CEYglZzl+GlrTIm4KCYZ9Nn35bacz
	QZH5cMndBErqLD86alysw==
X-ME-Sender: <xms:WCBrarySfK0K2sAfJ9ScUdhSbK_J6TMKCYi7qkb3_ot2sGqhdn8a2aU>
    <xme:WCBrauE1vvIbZux7DB1zvgyIP8dyIcffhWo3xaOGW8CRYO3rRWVOEK2NAQTaXgEWP
    AKnQOJauU5AI8MdcppNAQulxhD--KujYOweWXh0d60AB9eBRBe4>
X-ME-Proxy-Cause: dmFkZTEFsKVvYhEK/usVC4fHhIbsHjYCEx5m7vMTL+ev8kFWKuFrHx4sH2wjqlcjTL4WlD
    Rjt4igTc7upShh2h1MzvflxAKfowLp0/D80jQsVo5ah92k3v3W4JFvvFNTvwfdpvcSPncL
    DTbeS8ueQ+MRUwL4unO5yLlr4CtaPLKQ5nRT+VK8OOe4qmvAcNWSOHk0oZrTcHgd5y3L7/
    rp7KYfKR+uFsEEP8X10mLVRjv8VcLrNwQS94mYSDFGGDGP27hclqUkb27qcIqyjvyd7Wv+
    71ixH+n/2Uy5Lkb4aWn66+FxBkY+U5yer47ZQCyvvjec2r/UwDqkifqaNylIVitr/hZ7Hm
    lMeyZvBRsCrSVUnflPKGkZOBA2S8beB/XJEw4smXjhLzB0QsuOXo0Igg9BhVcaa1mp34od
    apF992MogaX1C43uu4iFx0uQJPacj2MyftKgXdvp8fAnyo2vF7+uhNungnYBMxnTiY6ibC
    WmWlofRWU+bw0V11J3+PthTmsPsuJ4XC+NGP0cLfkcBw7/VWIaXmnN42nGRjVnVTcu4gVV
    VY/r3JHu6w9kA/LtnFxmkEP0330QJWTi+zomwPQ3qrhEd3DGol1CD6GY+HwDupLe5EM4XV
    Nbs6CpVGNBJi/MgghN58XG0YeIDYcvNG0dJVzij/wvXkJTjkY93+W0mFl7uA
X-ME-Proxy: <xmx:WCBram3B8cdkfDay9uQMlALDMtv7IkSbPUCYG9TCFSKVy5iU_mN1yA>
    <xmx:WCBraqlz1LFGjrltXO0II-tawM--aZ3am2s-GZnhJ0uxWlakRfmuYg>
    <xmx:WCBrau_RQPpZMdCGb4EM0CBMwuXIzuB1AwkGyCxPfXgIOp3N2UgJxA>
    <xmx:WCBranp2hpgavfvHC3S-Gg4GhFAqQydYLlARnXW2FfWGSmdeu8gRCQ>
    <xmx:WCBrajJN_oJ3SZWi3DbDS1vC660NGx0acs1RUpu423dGqbcq0hDNQjV7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EB7883020073; Thu, 30 Jul 2026 05:58:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A24SwMDxPVBs
Date: Thu, 30 Jul 2026 11:58:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <06dacc74-82d9-415a-a5bd-ce6bd824ec0d@app.fastmail.com>
In-Reply-To: <xmqqv7a5b6n7.fsf@gitster.g>
References: <V2_CV_doc_replay_config.767@msgid.xyz>
 <V3_CV_doc_replay_config.780@msgid.xyz> <xmqqv7a5b6n7.fsf@gitster.g>
Subject: Re: [PATCH v3 0/4] doc: replay: fix config link
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 24, 2026, at 01:58, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Topic name (applied): kh/doc-replay-config
>>
>> Topic summary: link to the config for git-replay(1) (one variable) in
>> git-replay(1) and git-config(1). Also improve the doc for that config
>> variable and `--ref-action`.
>
> I was reviewing the draft of the What's Cooking report and noticed  
> that this topic is among a handful of stalled efforts going nowhere.
>
> It has been more than a month since this thread got a few good
> comments by Toon Claes.  Would we see an update anytime soon?  If
> not, let me mark the topic to be discarded in my draft of the
> whats-cooking report.
>
> Thanks.

I have posted a new version now.
