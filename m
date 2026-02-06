Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4A2797B5
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395949; cv=none; b=Myp/UEnL/g+pTgY2LTLD3XsCijH/aRnuLQzF0wyov1hgSoh+WBq6USazQ9jJV7dwQyuRIoBn62TuUeK7KXLb0g8SjKng9Qtkz1YfNm9JZ6qKCgyirNyvhr7bA1cZlCJ5eOV6rBzVYUNMTmG3NtmG8p0DQiFleXoDFFbs3X9kcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395949; c=relaxed/simple;
	bh=gzcdJHzZszuSx+QU8F8Cw5/UqhkMTkDQLzPVxdh+K40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ufkM1zBzyApHm2d87mhLZ7uLUi6cY1Tgk5Plm+Mv9iiRAuBuIqfjhlkWtfjjq+UTRs6oIo7VU8ia3WmhBPNB2XGg9ufGEDmGjIKYH99VziWEJt5BrrVDd3NO8jiNKJ69YrzBCibjDhET4pyJf2t6rNL3r1/bW2HqIz09wG/43hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P81Sl2t5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lu3fReSh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P81Sl2t5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lu3fReSh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 336A114000C9;
	Fri,  6 Feb 2026 11:39:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 11:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770395948; x=1770482348; bh=D3PBjcf+9b
	wUJvmFHudDXmpubNl3bNYHIwVPjHrLjwE=; b=P81Sl2t50eLKJwJR2kVNI3tOlo
	P4pXv0DrEBi5U0g34qZtg380DE4nIvbu4AcTNA4sD4XBxt5OUgDi6vUZbbPRuWwh
	6vaAjbWjT9HHp4u0JCueTZT2QPlCt0zRCF/H8hH4cgLQBoq3CaiUSZI2Imh1HrD/
	TcpG7VV3kg2L923VHNf5lZw4ONz4HUU9JwhRXtb/GQ4AVdKSbKAOQluqwN8NR6sX
	4kbaXYH77qor23xCazN9XY72ZaoT/byWllw7wNgdB5Td+oRq+W9daEFo+biOhFWH
	fclDuor0kJ1NsxcVCN4ylmujAsT0QB2kbmQ8CXnmSXaZSwVMExFmLYZy4KEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770395948; x=1770482348; bh=D3PBjcf+9bwUJvmFHudDXmpubNl3bNYHIwV
	PjHrLjwE=; b=Lu3fReShXLwBlTLUvXQpoVXtoTt/y4BHUFH+jw62IZEuzR4Nfgc
	1oKgEXUFaVK/6IvgjEntKSX+MMZBEgKcETwqUcrd0X9ouH3touwKocJ8y8nibNdo
	5MZiD3v1Wjyves7sXrQ8924r844A+cumS8Lvmzhe9iVK1Pw24XasCWt9ko7eRJHL
	bY6XO7FNf47HgpI+2g3AF/f9xviPoujnPhLCPwD/XmXxtO5HN72EPNyKPw4sCn8X
	jfZSvV/5Pm7IzqK+auv54z+0EJLPr7fFTTkH2DBCkMrpZnqSZhedzW0qRtfPk396
	3N0KsvAxXhtQzX5+kzTxWDdv69gkWD7SQPQ==
X-ME-Sender: <xms:LBmGaY191FAqrueKidg_oUmOZ4qDu-V50N6umHFJ400G0V4Gp2pmGQ>
    <xme:LBmGaaHjcLrwZqCYLgyiNLout2fPgDTnkt1RiNzIbxUYh9sOYkFRzCOqdtF6kyf8P
    0aS2HcEXMaK3Cjz2FeqUopp7ojfnBkPtAPPApuilw9Gd2omf8979A>
X-ME-Received: <xmr:LBmGaV6f6bIqOAlUgVRRsx_6Up4p_0TECHguRcoDIeCEFtc7DB_r9Vp4ciP4r7K2kffj9iOym1GVWju3rOorv2Lqgf6epgBabw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvrghluhhs
    ohhuthhrihhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgtmhhs
    mhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:LBmGaQtdb1oQj2Fxu85btWS4u18LZgGKsPtPFXI0dLSe31xhqRcr7g>
    <xmx:LBmGaW61Z4wan_B2iXGktF8P9_01tHK5B2I3V9Zy14moEZDTpUGaHQ>
    <xmx:LBmGabVhJ-lEvHLjMkoZG8SJG9aQCqeodSjpWAnFd5scAYqOGmVCRQ>
    <xmx:LBmGaY9LVDhDtyGq0CKPvUYksK6UszTkHj5avguJgqCqYE2wWpkRQg>
    <xmx:LBmGaRZn7P-rXs2PSdlrG2EpgL1ZXn5hT2py9ZPNg_N8ON1MV9n04oOG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:39:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: SoutrikDas <valusoutrik@gmail.com>
Cc: git@vger.kernel.org,  shreyanshpaliwalcmsmn@gmail.com
Subject: Re: [GSOC PATCH v2] doc: fix repo_config documentation reference
In-Reply-To: <20260206062108.74072-1-valusoutrik@gmail.com> (SoutrikDas's
	message of "Fri, 6 Feb 2026 11:51:08 +0530")
References: <20260206060156.73753-1-valusoutrik@gmail.com>
	<20260206062108.74072-1-valusoutrik@gmail.com>
Date: Fri, 06 Feb 2026 08:39:06 -0800
Message-ID: <xmqqfr7dhln9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SoutrikDas <valusoutrik@gmail.com> writes:

> In MyFirstContribution.adoc, the link to the repo_config() 
> documentation is invalid because the related documentation was moved 
> to a different file.
>
> Replace the path for the repo_config() documentation from
> 'Documentation/technical/api-config.h' to 'config.h'.

OK.  I eyeballed output from

    $ git grep 'Documentation/technical/.*\.adoc' Documentation/

and everything else mentioned are still there.

Thanks.

>
> Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
> ---
> Changes from v1 : 
> Corrected Documentation Spelling
> Added .h after api-config
> Changed Commit message to suit git's style
> ---
>  Documentation/MyFirstContribution.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index f186dfbc89..92de476a7f 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -351,7 +351,7 @@ function body:
>  apply standard precedence rules. `repo_config_get_string_tmp()` will look up
>  a specific key ("user.name") and give you the value. There are a number of
>  single-key lookup functions like this one; you can see them all (and more info
> -about how to use `repo_config()`) in `Documentation/technical/api-config.adoc`.
> +about how to use `repo_config()`) in `config.h`.
>  
>  You should see that the name printed matches the one you see when you run:
