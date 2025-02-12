Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276B25B668
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380107; cv=none; b=Nx1JiYkZhYRz/nJSZ4qAKDwE6mSDiPkleOoiPiuaGXH4dCWz6w1zUfqkuXvJ/IorDiHjEvMBP2F9NFEP9kGOwjwOzc5y+M0u0qJw5ybBPYrKf0GVxYIl210HvOPjp3Uhpy5B8uw4H8Sk5B8E2IdJyE1pRAHK3Dp/FDnEPPASIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380107; c=relaxed/simple;
	bh=tDx4bAhx+rE1VpWu3NFGhATLhCdpWzF0FwQSpD189s0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2RnBE0zlKMwHI5p6Kal52yb+gEnORZXcWiNFCeZqzEsKzTc46g5+jaYUYtkZVcPWlXSzyTYJlYMgxkbyGPxEK6rJVYhT8fEYuWp7r17i4H58PyHwb3BqXCW7rmcwWgSvEW7aVpzF1MzRW428KK1k3CQRL/8q/aos46ICk9WeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ei8X+213; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNxkyUtY; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ei8X+213";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNxkyUtY"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3BB6613801B3;
	Wed, 12 Feb 2025 12:08:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 12 Feb 2025 12:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739380104;
	 x=1739466504; bh=yb+LSoSKN3+ssz246nxHjCHs67QbqGSsPZKeIY1YwBI=; b=
	Ei8X+213pE5/Y5i/TPqpt3oEVx7kLINNibDFYeDlzyPwHjEKJ0MpGzjA7tDawGY2
	pakPVJcgNvglswMjCEQn28PD2ajAANZ1AMYIIgfjZZb+q4tHztPECyJ0LGRNRI5t
	6gt4yLyyNugyWQZZ/RokPwsonNJDK6LTkSXQCi41hYqfARsoOrpgFtUSJHC/8XhS
	6fZCCjs3qabv/z3DVBo1sc+ygmsfkuUIHGY1rINvDOuiGeBN5MCjeofu7TxpULEw
	dRbcDnoXzi824JlWtyOrcrd032lP3HrYF8ZXUdOxQQzDOMswObMGruJhHBxcCbpw
	WOImIzwpQtb9YrHt1bylNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739380104; x=
	1739466504; bh=yb+LSoSKN3+ssz246nxHjCHs67QbqGSsPZKeIY1YwBI=; b=R
	NxkyUtYBRiJPdH9ecClhJt1FUJxq2Qk9gHsE+aqOxmooijVMEOx9OqeWCsLqplYl
	OhyTsA9WxUpNbDvCYj7lt/yncVEvJuxs5zz6eoGvpP4XhUQgVIzn5xxk3ziBfpQV
	qCHHJRi8Yl+/g4B/s/GyEc+mxgp1AnQt55qrDK2N49vsUplx7LG1d8Xg4ERmpvQH
	CuDyazZ8EB/Wb38eCDbk21ZChT4Lkq/5vSmmG98GtYVpe/0CNSjKVQElvmn5y5ZE
	Hi038TNb0u+87V8g603wdjaXCMCafk6uuoMCoQuXtQV4CQ5wokxKfhL/cUs8iFNo
	D1891CiY9OZck1LHw5KNg==
X-ME-Sender: <xms:h9WsZ61wp84dlAtz5fALbj2ExPQStXD_yu3jJ5kDCWm6thmca7Dsvg>
    <xme:h9WsZ9GD-JmcNo9Z4kRKHLsT3hrXtXbj0mACzriUnucJ1xwBd9gx_PSIkGc6pzR8d
    de3IZdzFeBbM4m-_g>
X-ME-Received: <xmr:h9WsZy4-So8btEvxjPJf4RDOFnoAq8SM7xJqeZoEzjgi0cIMuVbSSWxC2JtuJAo7lfygAQ9u08uzRMBsv4xQDySb42GAzzMAye5yVrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhllhhirgdrsg
    hosgihrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:h9WsZ705xTEIFYm4Sr7Y_BpRK2_r6lz2Ku_bVtd9bFXnjOyq379SqQ>
    <xmx:h9WsZ9EnWb8SHo2WaWEBiDVeg51VvS0I7deN3aAfGIftF6o1VKpIZA>
    <xmx:h9WsZ09WTgYXU3jEj930L-go4lcSG92gcyHcPE9RmujFROFQr2qkbA>
    <xmx:h9WsZylLV5baRCDSnrG4uNKA-AHFGLxiOO46Xp42Jb0q2p974MxwEA>
    <xmx:iNWsZ2MOmbg6N3wCe14KgLIZSZ7F_0ARHq6X3H34nYA8y_ROMxpSviRU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 12:08:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: Jeff King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] diff: --patch-{modifies,grep} arg names for -S
 and -G
In-Reply-To: <081272b5-b035-47a6-a951-eb923a9a5833@gmail.com> (Illia Bobyr's
	message of "Tue, 11 Feb 2025 19:26:29 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250206014324.1839232-2-illia.bobyr@gmail.com>
	<xmqqseoqiybi.fsf@gitster.g>
	<081272b5-b035-47a6-a951-eb923a9a5833@gmail.com>
Date: Wed, 12 Feb 2025 09:08:22 -0800
Message-ID: <xmqq8qqbum49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Illia Bobyr <illia.bobyr@gmail.com> writes:

> My thinking is that as long version names improve readability, it also
> applies
> to the test code.  When I see a short option, I often have to check
> the manual
> to remember what exactly does it do.

But by now due to enough exposure, you have committed them in your
memory, no? ;-)

> But, I think, I understand your point of view as well.

Yup, if the options were introduced with long and short forms at the
same time and the tests were written at the same time or shortly
after their introduction, I'd agree that using longer form more may
be beneficial, since there is nobody who is already familier with
either of the forms.  But at this point after 20 years, swapping one
for the other is mostly unnecessary churn, I would have to say (and
I do not particularly want to having to repeat saying the same thing
again).

>> OK.  NOte that this says <regex>.  We may want to have a separate
>   clean-up
>> patch so that Documentation/gitdifcore.txt that used <regular-expression>
>> and the placeholder used here match.
>
> Makes sense.
> I've added this fix as patch 5 in v5.

I'd rather see these "fixes to existing anomalies" done totally
outside of this series.  IOW, I'd prefer to either (1) get the
series done with the minimally necessary changes first and then
after the dust settles from merging that to 'master', see these "oh
we noticed these issues while working on the other series that has
now completed" issues addressed, or (2) do the clean-up of existing
anomalies first as a separate series, and then after the dust
settles for the clean-up, do the proposed addition of longform as a
separate series.  I have slight preference to (1), simply because
nobody complained on these small anomalies for the past 20 years ;-)
but I can also go with "preliminary clean-up first" route.

>> This is an unrelated change that should not be in this patch.  If
>> you want to modify it, please do it in a separate clean-up patch,
>> just like the above <regex> vs <regular-expression> change.
>
> Split it into patch 2 in v5.

Again, when I said "unrelated", I meant that I want them to be
treated as unrelated changes, addressed outside of this series,
either in a preliminary clean-up, or after-the-dust-settles
clean-up.

Thanks.
