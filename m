Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE3155757
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765583364; cv=none; b=rY//X0bvkupjdrQLin7IDdnosqY3BiZYR/3EZuXT1KqVct1OLO0WwcK0zSXlPCf9RVtrlTfm1uJwMHpfvscqVDGcfgfP2xZI5i+EZvgMpD1NTDoAyuGW4bDqxKa9DpZ0eicowlVCM8a8H2oTXq48KQkqWxEziysgtPd7WK33xzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765583364; c=relaxed/simple;
	bh=Uncoluf8rMWap4DTE+arUdyJ7SEvR6xRwo8JeL3SDPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VE2kYQy22ZKRkAccFixl1eMT0MSLaWAM6k+90K64FZualtSGaPiL9grCIzC0WaF4+eFcOkQsjc9T/qCJrhl9tePna3cZcE0dVbA+tSeMneBkSofwivOyFTzhugwLzGFlxgUaWdkZoC5/O4QPwiUb/dcPA6lmyiErG1dEvIfxckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ks+DusYc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DKNXvRR8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ks+DusYc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKNXvRR8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 933B21D00109;
	Fri, 12 Dec 2025 18:49:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 12 Dec 2025 18:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765583360; x=1765669760; bh=OLDucw+5z0
	3lXzNl1K5kLFsDiVKUnx9pY9WaFMbK0OI=; b=ks+DusYc1d5hs7qgE7NzpJoOVo
	wloLaAHmuMi/YTbRxnKT4lDb4QLAPtTMD8UZ0GGeO+WzFKMp8+kucMTPRx8/R3bO
	nhGvbUvvPrYzxahH9E1RDlslPWu85URmKv77j4lPeDAjY7MdeV1dhTLBQlgnA25X
	U8AYJef3Pe7/C8hkNN2yom4/BD5eQmJMSDtuR6OYCYM1bt70CDHC6/k4gOsry+ue
	833l24EtQ0W0ssrEP5idx2iyX6vXdr7d2oOEMupQhdyzyfVf51wFYjGB9ny+Fwu9
	pl1DXXP3t9SsrkGkAJocK8p1xsPhVPOwEATv7K5QIfbbpKWG65EidzlrONxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765583360; x=1765669760; bh=OLDucw+5z03lXzNl1K5kLFsDiVKUnx9pY9W
	aFMbK0OI=; b=DKNXvRR8CDtZ/pHNU+CrYLhetz3pj2r9Al5Du/aQorYgCpA8S48
	7fFklp8T7XeQ6WurJMBqrddhGZGJrE2BwVKS1Rxf0daDQiOPThi+GqYANCPRPMJt
	N0erJOI5xx29j+DUHMY4QXcSOGkSaJzbo7akYcRgHSX6DJF1ks6bWY6spzyKYbSl
	u69YLpGRRhKPsMVhtFew97Xmq91E10x7sSXVeqrMufL2e05bo7Xe4i2CHgfTKEbo
	n55H478vpE2oDuDTP3qlW3sPQLBIUTk4Rj3popf8WmKkyJzEgvzlAmYDJJSmdN/U
	G4uzotZfqX6bJCBuOAkeZLAAW7etxGrIsiA==
X-ME-Sender: <xms:AKo8aZZJ_Phzr6TXJ6XUUh15uaD4VVqJj2tcb4cuEn57xvU1FVQqAQ>
    <xme:AKo8aS_5g8rR9v3b_Y0cTJsp1M4bjjExBdG28ngQCT69XNU-NkShJYGPQqnqaZriq
    I1TK9JtpINwEmdRvgVrBa2mH1bSgaB8zjSu42YXs9vBWEk34aeBZw>
X-ME-Received: <xmr:AKo8afkng8xy3itaARj8sx3pJd19EZ5GByO4Ljf9FQ_O1VIj-SIC6PF6Qsx38VfW3I6F2rp7G8uK6A5BmmEJPkhWp6_bn4sFRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopegrthhthhgvfihhuhhghhgvshelfeegsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepmhgrthhthhgvfihhuhhghhgvshelfeegsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohephhhfvghrrhgvihhrohesihhgrghlihgrrdgtohhmpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AKo8aXxw2r7YqyfmL7c5kxaQukq6-baJj2eqjlnhYd4dAUJuPgjKOA>
    <xmx:AKo8aZ584T9Qv3fzgrOfwYoY6zbX0C3oXutbBOPPxirX-ibN3CXMsg>
    <xmx:AKo8aXW5QcCxZaIOJVHMPrI7W3vKKk6vfiFhH3KKKWU7x1iI2dck_A>
    <xmx:AKo8aRIRfh_8FMGX9YRpn264IhdU_ak37Q_tpu1nrrMyNTuFeb74AA>
    <xmx:AKo8aZQTXwPfi0axgLRv_f8AkydNdtfvea42oE6-TV_dJeeeyGlCjCmz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 18:49:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  atthewhughes934@gmail.com,
  johannes.schindelin@gmx.de,  Matthew Hughes <matthewhughes934@gmail.com>,
  Henrique Ferreiro <hferreiro@igalia.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v3 0/5] Audit and document Scalar config
In-Reply-To: <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Fri, 12 Dec 2025 15:15:23
	+0000")
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
	<pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
Date: Sat, 13 Dec 2025 08:49:18 +0900
Message-ID: <xmqqecozb6rl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Updates in V3
> =============
>
>  * Updated method names when setting recommended config.
>  * Updated documentation section title now that nothing is "required".
>  * Made distinction for index.threads=true as explicit setting.
>  * Added documentation for log.exludeDecoration.

Looking good.

>       +index.threads=true::
>       +	This tells Git to automatically detect how many threads it should use
>      -+	when reading the index due to the default value of `core.preloadIndex`,
>      -+	which enables parallel index reads.
>      ++	when reading the index due the default value of	`core.preloadIndex`,
>      ++	which enables parallel index reads. This explicit setting also enables
>      ++	`index.recordOffsetTable=true` to speed up parallel index reads.

I understood the previous "due to" version (from the middle school
English class I took eons ago), but not the updated one.

Other than that, there weren't anything iffy in the new version.
Will replace.  Thanks.

