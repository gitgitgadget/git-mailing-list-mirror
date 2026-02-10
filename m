Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48C32E745
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766675; cv=none; b=G/QL8Q4+a12jXULFIz9OZQJLnohCV2k/KtBRG4BYLiE17hHHpkQGS+wIt9IlR67TeR4UXOZpSlhiDXBtgU7KoXSy2LJd5A6ZtpPXnUDyoGyooJir6RqgH8CR95JkOgbc3Oew1SDsvQ7LGjZGuhbbVuffPRu2OM3NIxCGHWyLEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766675; c=relaxed/simple;
	bh=NHo7aOyIhkspIWkmBcGkJkhKJoRVbx4q2yyL7j8n+Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/2yMS+A7C9xBMHPeYwj++MLEWgndKSYUKcjefufscu7uP3ZJVFvEfSRKBJ9A8hOefcsMWjCcqjw7s15hkxhUQHyeWQtRoyOAMxy3K0ZXkByD8BNLc7SUG/ZixojXsN2fH6TkGjYkIsfmMrK5pGzC5eURe/gXsrtCiuQHJQVbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UV0hDX/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VO8KbtA7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UV0hDX/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VO8KbtA7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AC4301D0005E;
	Tue, 10 Feb 2026 18:37:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 18:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770766673;
	 x=1770853073; bh=LiXVhJQ12yH1iDqqXSS9sEsUoxcKjVleOk06sty4MDc=; b=
	UV0hDX/63dNuOeNXCQl74GHe6LdIqMroM5DGQ+tRd61eUkA1aO9ZxRFjAWj9N/1M
	LC1zNAmSX2pCZH3o3yPapXElLGn4wG7bbfOCKBLNLFdVXm0kZvVeZquZSYpozKUL
	T7GDQQ7iG2N6W6+fILebJNemD9U1D4I+aryjXC54+Z9N2N2mU1r3WW4HK5r0Ed1J
	DAM6mTgPcMoII70eYoiKLWUO37s+EKCAbbj4aLMy8p75EtA3C5T5TC+fEEd/duSH
	wIeUQxHEWesMXnRIXVOPwc9bxk4LchSNYPIp7oWIKgKwESLQj0LNlrVoxHDtst0D
	Y5jEhp5S9mjZIYeeqZ+bkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770766673; x=
	1770853073; bh=LiXVhJQ12yH1iDqqXSS9sEsUoxcKjVleOk06sty4MDc=; b=V
	O8KbtA78Yg+7r66N+CKM0KDjcocqDaIMj4caryTwaVdr21jl5ipFC2Q2QOx/XANT
	pDQvjmiOlbgFEKvbGwPcBZ4nQYUmbMkHff20aZHtjBSxM6tMqGaoKsgnpKHkGibq
	cdD15+ycrAd6cx0E7JxlOnfa9x1jmiecl9J0dQl6/Kjakt0gHlQTP6MeWznW/GGa
	sAg/mR0+I3n+0ANb0Rqbu0dN0gVt/jRzwy9BWxeEGs2B6e4Dqw+hWVYy2FBWMAl+
	7ybTPZyxpElY4N1KOFgqNyPpP7eK1gwwJkJ6oa5Fm9Ayjl2zenbbID3ihJDj+TLe
	BJSFJtJQT5CP+d7whSgKw==
X-ME-Sender: <xms:UcGLaRSNVCS55mvP4fQVjwGNkBPddY4fnBefrzPMsvjBmbJt9hsoUQ>
    <xme:UcGLaXXw-0wcWlcUE7TPOJImVWSVrVl4e1RYjSvgHOxmXYnq65q1XcjhOkYqeMd2L
    CW_ejbRiK-SMKyl_JOuI7EnmY7YAy2aBxclf2jrWgHbr9IZLtjMCA>
X-ME-Received: <xmr:UcGLabS40LboDJWpGakfVGulmyVxPDHePFN6tQ1T0NsI91oJlwaOfUsqBSlejYcE3Tp_DVnhGTdDPYi2Bazo9BsI3YYWx2np1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtg
    homhdprhgtphhtthhopehkuhhmrghrrgihuhhshhhjhhgruddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfeduse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UcGLaf1dNeuM3CRSFfmVXHDONMVaiGBaX-HSU-KpfWpN9uS1I4rpCA>
    <xmx:UcGLabcqhH_1lZCMS1nhU5gOeaIozVG81NmVZLJ4SKkwxbBqrFo8GQ>
    <xmx:UcGLaXMRXfWB99NybSgd7hfVlz3jf5ufd47ifnKekBK21UlNbDhBwg>
    <xmx:UcGLafUoEnpW3mC3aksp7w1Nysasef3fnEuuC_ekL3q3F_quJtDKGQ>
    <xmx:UcGLaQ5rsLvPzXBn-kfqIyPXJD2kJ_fFqk5yqEpSxW4g3-AmBQUMNe8l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 18:37:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Ayush Jha <kumarayushjha123@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <christian.couder@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in
 read_attr
In-Reply-To: <96329bc6-0490-454b-a21b-babb85c98bc9@gmail.com> (Tian Yuchen's
	message of "Sun, 8 Feb 2026 12:42:07 +0800")
References: <20260207114007.40-1-kumarayushjha123@gmail.com>
	<96329bc6-0490-454b-a21b-babb85c98bc9@gmail.com>
Date: Tue, 10 Feb 2026 15:37:51 -0800
Message-ID: <xmqqqzqsw4og.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <a3205153416@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>  >The codepath read_attr() is in is usually not that hot but it is not
>  >cheap.
>
> I'm a bit curious—under what circumstances would calling this method 
> result in significant performance regression?

Significant?  I dunno.

And quite honestly, I do not care about significance very much in a
case like this.  Doing things that do not make sense, like checking
the same configuration variable again and again when you _know_ that
you never switched to a different repository since you last checked,
is simply wrong.  It burdens the readers with unnecessary cognitive
load by making them wonder why you do such a nonsensical thing.

The read_attr() is called during an attr stack construction, which
traverses the directory hierarchy of a single repositry's working
tree (we do not traverse across submodule boundaries), and the same
istate (i.e., index contents) structure is passed around throughout
the callchain.  The repository instance at istate->repo may be a
good place to store "am I bare?" bit that is computed just once and
reused whenever we need to know, like in the funcion under
discussion.
