Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2C2E762B
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074247; cv=none; b=I/H8aAmBf4B8X/76ZktD5UKq/rVWd8sv2wMDZF2oOdqNC1UlWdLLGEEmC3GzBLMa5itOq7b8Q5S6tlSVWsegOtBDwXpmnFCujQwjt7J8HRmuMeD7zZNovA5YtdDJNAQvFeyJGkyJFkWVsusKvUddBcLsMkLVJMKEbizcB3oQPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074247; c=relaxed/simple;
	bh=f/ZeEdwcC064mDpTfjYMeCTPrwNOAy/izfzn++YWfq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMdnDMIKx3Oo+2iehfCN5LRaar0zgwck2/5kDI78TcL5oXzc0x+cxq6D5RUyUd8Nu3UQlIRvt5PXkyoxZW40cOsIwx0u1732ELEd1Ze6JngI9OpS+UWcOwhu0XEbe7iKFrnR7PhiciGQ7LfJaMj1tvwkdnclCGnAx/aK+3D+j3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PwrJTXMX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBdZP9sK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PwrJTXMX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBdZP9sK"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3EC51EC006E;
	Wed,  9 Jul 2025 11:17:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 11:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752074245; x=1752160645; bh=SacqHw4Dxc
	sbOcA9PClhWhAaRa8hu6GWI39RbJvwKWU=; b=PwrJTXMXoydyE5h2zZUFnV9zcw
	khJxsWfjPkJcf1Xnv5uzaY/zoKdMVZJbsD0COSEWPaoHkohrpM6zMV07fo4CMFYI
	0RfZldXIcwLHwMS6/YEnbtEjPzQmHlpLS/au0zsVoJarLtDb+oMC3cnd8qsXeOPl
	SK5ZmRDvRVOfrczK3QurCta0WaMh7fvli4ui0Pb7077h2MN/Mytx6Zx78kTdgZWf
	qAzisD5aWUCg6tHxafODXvCGNuh1q+Xz1ZGJ0yb50VwngaATQpfBPueZshxbX6pf
	ZEfCU9dRAndJ/HEqtustjKIc9Q+LAT21PXWxKjvW7WHkaLyprjRZ/VRfuxeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752074245; x=1752160645; bh=SacqHw4DxcsbOcA9PClhWhAaRa8hu6GWI39
	RbJvwKWU=; b=TBdZP9sKkGBfoo1KWQ411ZSJwV6+ZIFdt65kgPers2cDs7xAGCi
	7zOt1H4V7pxcYwoSWwOX+n42AVwSjJbeEfDcnG5JZiFEiTNSzjPg7mm4XD151kkg
	iwn1Cf/IIfq6nHCfJC6dasjRtEd1/S++icHp8EPHDF/O867DkVsZ/LedhmoavXxI
	vEJlvWVriNKOWPoTLpNCb6BZf7e/CQoylPow90eFNBwyHQMOkrtELjOx/z/igliQ
	Q3Qqb0ALaETypb7lK1ZAfdxhJPjy8AJzrEIVrTbSCWjLU5SWypc4nR1AFxJD30IA
	bXgRYsnjGHwhyTgWRLfSU2RjwEvhfe9fAGw==
X-ME-Sender: <xms:BIhuaMUQKNvNmNoYyZ6TT2GnIQ-qTZWr6FhIIuTF8bWein136jLvgA>
    <xme:BIhuaFyw-sLOPYRtMm5tdXiDIDLYxn9j0Umi3tbeibJNr4ynD8hFIgKOE0bqx9tYC
    3L40wrbPJ5mZ8aOvQ>
X-ME-Received: <xmr:BIhuaBS9t3wdI3dPI6Ii2LfD5oxYIrttKtXqto47cfr6oBTYAMWIr5n6Cx5WdAgjgdigURMvJ_SbinI10TfArDwCsnbfHXppXZzOCqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgih
    jhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepihhrvggttggrrdhkuhhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:BIhuaBjKTlcbO0ifKIpDrpIjNH1kiKgQSOrDP_LeVWNWCDX9WNBmew>
    <xmx:BIhuaIl88Ua5RXzRiCAsXb4ckeCIqeLK_wh34QE4vruM9tn_cG9bHQ>
    <xmx:BIhuaEvxHk6oMpGAfY356mlPzF1Lo_OWvYENbaAXH_UDsat7rGk06w>
    <xmx:BIhuaGbUpphYuWzI-HKfAhZ2wfV_N7Rq08CwxDZ7eTjfvdNwgLVfow>
    <xmx:BYhuaHtadJdNMIivLpHK0IPbxMDz02qIdXTEtklqxEDQVtiQ7MOjiWKj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:17:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  irecca.kun@gmail.com,  Eli Schwartz <eschwartz@gentoo.org>,  Jeff King
 <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 2/8] meson: stop printing 'https' option twice in our
 summaries
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-2-29ab15b9ab85@pks.im>
	(Patrick Steinhardt's message of "Wed, 09 Jul 2025 08:23:36 +0200")
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
	<20250709-b4-pks-meson-cleanups-v3-2-29ab15b9ab85@pks.im>
Date: Wed, 09 Jul 2025 08:17:23 -0700
Message-ID: <xmqqcya9pf5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The value for the 'https' backend option is printed twice: once via the
> summary of auto-detected features and once via our summary of backends.
> Drop it from the former summary.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 1 -
>  1 file changed, 1 deletion(-)

Good eyes.  To me the distinction between "Auto-detected features"
and "Backends" feel a bit blurry, but most of the things in the
former are what dependency() returned, while https_backend is very
much driven by custom code of ours, so removing from "Auto-detected"
does make senseto me.

Thanks.


> diff --git a/meson.build b/meson.build
> index 4ee1a55b0bb..0ed00254ef3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2200,7 +2200,6 @@ summary({
>    'expat': expat.found(),
>    'gettext': intl.found(),
>    'gitweb': gitweb_option.allowed(),
> -  'https': https_backend,
>    'iconv': iconv.found(),
>    'pcre2': pcre2.found(),
>    'perl': perl_features_enabled,
