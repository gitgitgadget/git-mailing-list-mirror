Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65252625
	for <git@vger.kernel.org>; Mon, 18 May 2026 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779064001; cv=none; b=LWDgsn2tY5SYtjVgk52syHVALIzOxL8r83UWHksJ3H57mGCFy+0MSqpbHYrbm9jQ8mUjqkauRu+Iq5eqjl7wgm8m27Y2C9IXQuixYqloI0ggAX4t7fLw6yIc5TmlXJjcjOAuEwV0CPLejYctWUdYkclCiJMoGTVne+bbRk2aKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779064001; c=relaxed/simple;
	bh=gQFY8dO6fyR6jPXUiIPwGeTzLgiqG8oS9cOzr7k8zc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e0gQYxLS8Imj5Jf9O9RmvD0HCPv2xDz1cNf6pq6D8O5Z8IYfRUQhvZGjinNVwqq0r+r8OjGH+0rYfqryS+1gZKVWmuasMKmPBIcW8MHLSnnRT2rEeTxbvMekNwkT2UVTtl4FKt5MEBGW6XAIbziwM8M7xAq5vh1/0c3qeKg5joA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aRPvpUTY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYz4+K26; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aRPvpUTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYz4+K26"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A0A8E14000EA;
	Sun, 17 May 2026 20:26:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 17 May 2026 20:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779063999;
	 x=1779150399; bh=U6HCnwlCWi8Qs9cAvMKLCW2dZkzIhFV7LJn8xj2iecg=; b=
	aRPvpUTY+DG/A+52u18rIaQ+YMx9vJLg/KpAozSAbvDdaN6Sh/nwxU9Ba6wOWTbb
	1WDfeeeqLfir00EX2gTckdeLtNVJL43631j4PHC8CRP1oMTKay/0wyg3Y+x9PYtZ
	yg1qo51TIOZD5bEbWIS+8DKcBDtJPwuTzKF0kORQI/onLI9ZP+Ku10Fvcq815c2S
	oJneT0jBW/6rpBwryF9c6vhiKWGU6cwOCFgLjuPGM9SU7Lbw/dakX7I2kOx+jkJo
	qlFyMEmrkhH3Q90EEa2h2439ZObY1vuUy0hJlnkcj/QUI7BTdil1/pMv2O23KGua
	RwWUc2ruWWxIRUm7ETkFlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779063999; x=
	1779150399; bh=U6HCnwlCWi8Qs9cAvMKLCW2dZkzIhFV7LJn8xj2iecg=; b=e
	Yz4+K26fhqR+eV3D+gQ42dFwgUlojJ2ZvMbGQlc4RZY8X4XEShkKjXxJ+38lMCO0
	/IfXuxBj2jaf5G5t+jcPyTKDTOquELvur4nLmNxg+6Uv4P7KrPa3m/Y1yuQTbnv3
	rOG4MbwKgbnnMRJw+n39KblIgNov870K0ED3YrWhHQSkpG83I6wcRRrLHCD63yNP
	Iugpp4D8Fk1RvEafP1Vm00Guk33EOfC2EGUudDeFUBCE0nG5gRm1TigaEZoqYfsR
	uxr8fYpUv5oFutiwS0fk1cR8eN/nNSC+GE0py8qb6FDMpL5ceHx6n74Yzop27Xj5
	sL/axvpn5RWguXGS43yYQ==
X-ME-Sender: <xms:v1wKarzS-d7uJgF4idqZWDSmBiOHZSS_YEXySzK-p_SJ2SBnONtRxg>
    <xme:v1wKaqRiMhSKIY976GUZ6TveDqoKNbxFecd04RmDUcXD3lcUOEEHGiJvWfJR9-G40
    JKaI6poI11POUyWWe4evE4h7_FXod4-0QMirqYEoKYjuqD9Z0bEtQ>
X-ME-Received: <xmr:v1wKaqVlLXOmi4DWsHlIIP0xWziW7pNa7HJeL1ftj0xOprTp_iNUyLLkU6_ZXdB2TofzcC_mkCyxOcgf_98SMgSiBfyCcp9JSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:v1wKakaT4nZUfwE74oxBQ3XPnPBmj9JbJIC-1RFTtMcPmD2A7nZgiw>
    <xmx:v1wKao3OklT-LtzyfzAdolKZbttlQecwNinAW7Q7SOd_QtI_MbZu4g>
    <xmx:v1wKaujtpub0FBE8IHgciD62Q-eTY4QsCJaVH3pFL-2K_4oGQ7LhSg>
    <xmx:v1wKakbPnDjV21UiupLq-zAlvy9GZW4Fr5oZhN2MaV1QDkxOM9Tqlw>
    <xmx:v1wKapXXHNmhaeCyErz-i3E3A1BA9FLX3_PdVFf7LKN8VqWbffLZdY-5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 May 2026 20:26:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 1/5] doc: convert git-bisect to synopsis style
In-Reply-To: <dca7f192f1e5cdfb57682feace0a4b3a10204376.1779049615.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sun,
 17 May 2026
	20:26:51 +0000")
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
	<dca7f192f1e5cdfb57682feace0a4b3a10204376.1779049615.git.gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 09:26:37 +0900
Message-ID: <xmqq4ik5d0le.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>
> Convert Documentation/git-bisect.adoc to the modern synopsis style.
>
> - Replace [verse] with [synopsis] in the SYNOPSIS block

This was expected.

> - Remove single quotes around command names in the synopsis
> - Use backticks for inline commands, options, refs, and special values
> - Apply [synopsis] attribute to in-body command-form code blocks

This is very much unexpected.  I think everybody thought [synopsis]
was invented to be used for the SYNOPSIS section at the beginning of
each manual page, and ...

>  SYNOPSIS
>  --------
> -[verse]
> -'git bisect' start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
> -		   [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
> ...
> -'git bisect' help
> +[synopsis]
> +git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
> +		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
> ...
> +git bisect help

... a change like this is very much expected and understandable, but
new appearances of [synonsis] in places like:

> +[synopsis]
>  ------------------------------------------------
>  $ git bisect reset <commit>
>  ------------------------------------------------

and

> +[synopsis]
>  ------------------------------------------------
>  git bisect old [<rev>]
>  ------------------------------------------------

were a bit surprising and confusing.  They are not exactly command
syntax definitions (which is the SYNOPSIS section is about), but
examples of usage.  The one with '$' command line prompt feels
particularly confusing, as the prompt is not something that the
end-user gives, unlike what we write in the synopsis section.

Other than that, this is quite exciting.

