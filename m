Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD11494DB
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220077; cv=none; b=IWL0v752sdS21un+bXhoEJzhkzgDuvClkKkfBUyWVVccFYG3Pvg6dBbEQGFT3NKxOZSv5i5pSMw5IObUlegxqCB+My6HRkh+KDbTKDzO+e+4QcJNG1IjyA0qqDPcLR/SULo8hOLiz6Xio80INUBPZPqgmw695QmKXfDCI88Vs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220077; c=relaxed/simple;
	bh=9UWBJOicQXwF+IhGGq2Y+bWt98wDV3OTTRfGVOnY4E8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ijztjIZTHitcIjOf04xF5f10KDDg1jG2kMDWAVGeU9VTX9YcuAsImpnR/TBeJUK9ynZ0EfVqtg3FuQW9Hkn775jTwxvfLh2rTlmG0V62R55V7rG9U7CGgJcFzcxMQQkbtc9ubpmkxU88Q0+RycO4RaVMv9OKVwmxw9/N5chPa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EB0dg49q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNy0mdls; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EB0dg49q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNy0mdls"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DF06A11400B5;
	Fri,  6 Jun 2025 10:27:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 06 Jun 2025 10:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749220074;
	 x=1749306474; bh=yQgN2T0hR1zf5Afv8SAKc6J7df8CusLUpze/LWF/Jms=; b=
	EB0dg49qNN+pHbfgQexSp8ikDACeOZIkk086pIyiqjaI+SrVxQUj28hoFo/GoRGY
	cNrbpRhUHvL8l58jrYfDRVGkTqEVhxVLbrsi1eu1hojMwY3kRr+Flj6yhMb5tu3i
	/cvjXnwia6qUHaxFbtgcBLZnB7LgD+o9tfZOuIyzDm22e1DDDB7nDB74s9Oetnpw
	GJrl+kDzFdG1TjI6vOMc4UO3bSdT6bH7/H7aEowIHCWkmv+DW4Zwc5R9hQTK+L3Q
	AnTdhRpTmL1Ukhhzf8YB1Ev/BEro9gGbPvI3Lw26Zhxex+lJubtdhQaaOq1auW2+
	ltW/G+bigHYr6K4yeVfRjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749220074; x=
	1749306474; bh=yQgN2T0hR1zf5Afv8SAKc6J7df8CusLUpze/LWF/Jms=; b=c
	Ny0mdlsxDGDawLOoxExRtMcE3V/DnqzamMurZh2dEfnMntr90AqNFv/1nLNLdnVx
	Jk1O7VDGvGqYu8GuaRh6DMsqlku9VSheQERk2QKjNsLPH6rvtyaBUA9XqAonyun3
	r6W/w9qOcdrl0SNkfnGQoy1xaqhwAga4q/EGVnF78U/LTXSxDG8fYy5n8PjpQ16n
	eSPLySefaLphuLtV5NKzzga72HeH08CDiK4uT3wg7bpwHy/uYMONWM7x5RgocyaD
	SlCYV/AxF1bE/7CrKAeJHUE78WJz8hzF6U0C7zcrxSAdzvxaOhl6Sim9v9oiN4uJ
	NivuaXwvt68elH9lkPwgw==
X-ME-Sender: <xms:6vpCaOpZrX4-ghm_u3vnvrj-5JguScEJWDb9Y38uJrE0n7G2HsC8F3A>
    <xme:6vpCaMqgRcaRLUDkg6eBwT6GcKrvj3mTH0l8xyqufKZpkF91bvhCT9ypsIfqbxPXd
    VCLHy2-iuHE3cpzoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6vpCaDNKs1cG9yfifx0hBztaaD10GgFNxqmiUpUefPf1DvR_RYhL2w>
    <xmx:6vpCaN7V51FG6n7nXVmNSAG02TOF_5H0RMIxKp2XXDbwwCAZiaiyTg>
    <xmx:6vpCaN5HxxJDsb4M_GE_4XJEgLqIM7URLJvW2Y2BxSrKVDBXzP3iEw>
    <xmx:6vpCaNip-U4wcXbFFjRALMljAEVp7cs8GI3VHrMt0DNPKFLkgxmebA>
    <xmx:6vpCaOXq_SbfRNe6agPBV0RTeoTbBrZQwIiOuBEwxw7QnWNqf93nYdrz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76D0A1EA0060; Fri,  6 Jun 2025 10:27:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3e5cd85e357bf448
Date: Fri, 06 Jun 2025 16:27:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <bf919293-562f-4572-bc0a-aad7f22d1013@app.fastmail.com>
In-Reply-To: <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
 <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/4] curl: pass long values where expected
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025, at 11:29, Johannes Schindelin via GitGitGadget wrot=
e:
>        ## http.c ##
>      -@@ http.c: static CURL *get_curl_handle(void)
>      - 		die("curl_easy_init failed");
>      -
>      - 	if (!curl_ssl_verify) {
>      --		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
>      --		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
>      -+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0l);
>      -+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0l);

Maybe I don=E2=80=99t understand range-diffs enough but it looked like t=
his was
using `0l` instead of `0L`.[1]  However the patches do use `<num>L` inst=
ead
of `<num>l` throughout.  Which I like

=E2=80=A0 1: Or rather I don=E2=80=99t understand that this is showing `=
0l`
