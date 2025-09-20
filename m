Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA851CD15
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758387888; cv=none; b=Iy8PrPa8iXuGCM3T16dO5tMhh2Sprqwf5DWzkzoIMrus/KSvGGiAGud9+zeFq5uF+QHlrWkSpNLNMXGwfveZRKtRJruxVvYGltOnj8rLWdE0vtTcxh0HXF4/pj/sD09pW+ou58kJ5cxlhjd5zcQg2/d6ltEFZ/BB2njhQNQsUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758387888; c=relaxed/simple;
	bh=vGFizS0ie/xEmcIEee5GjwTxyJP0Vzu7RBLQNeTlS5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G+Icy6YIvnu35xSfF9qe7b8kiV6wOd+39YWh8w/+5KUBwq3Stcup7rmQlzd25/pmNupwdW+z2gFlYjcQXuGSGkx3l3etWuX+vwXvylvz/WiqpL37PdIHUPjVn9mts9ncpAOT+mJnOHIAvEYTX52prVCqzitS8seN0rMvNXHg7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qgb7tP0q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+GIn6zn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qgb7tP0q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+GIn6zn"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B524EC012B;
	Sat, 20 Sep 2025 13:04:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 20 Sep 2025 13:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758387885; x=1758474285; bh=A/Ko/7pfHI
	7XW+cKtwig64cueywvh4kkGVjutdT9/MM=; b=qgb7tP0qZ/iv5XfyyJkAEB3TNv
	sKkE2OvpOzzUsjEH1xIAb8dzZd3+Gt9yT3Lc9u0yeuvHr7EnulX8bIe7BxIOoJ5x
	egUo8pQYGp7TdAM06ElrpmCdL8KyDvvsY7y16d7WE1fperEDahsndLth0RyNEjV3
	QisKcVTOFEDJTUIuLqlX158DaQgq/XpBt1qNS/tq0EosLeJ7xfUxo6GWb/SF0FPP
	+72bLZuhIijggTmZ9LqdNkovb2ZYZOITd49nc/vo5Ye7TeXzW+/IZVAGIDz/QMuv
	ulaMyURBh6pD6swFhZNmBdekmhFmrEsRCBSyoKxp2wwN0qcbFByWin6LmjiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758387885; x=1758474285; bh=A/Ko/7pfHI7XW+cKtwig64cueywvh4kkGVj
	utdT9/MM=; b=C+GIn6znFVTcc53f7XodWEeCjoQYiugRCSgFD5qHUQjZdmu2UbY
	LML+YmBtmKhe0ZRquXMw7JbV69rAcUPBHo9orDVYrfnoTb+hsIJJTPWpHKSLBgit
	aMOehfRd7XXw9LfhKsIvzMsmnz9Cf3haqjT+auD9fBu8E31szbrJMBUcwRY94ABH
	izNk6U2JfL2MtPAo8ZQ3WdDK2IpEUYt8vo9CpBLBeK670oz2NuKDQYMhhmYRbAuw
	EBvx8dQukM0b/ISWV7093JTHwpYEbERuymNPo5ic8YhrBSCyU2BavWZBzkOBISte
	v3Xd0dN+f+MufUS7cptUXRjFsp5nVQRi5xA==
X-ME-Sender: <xms:rN7OaLTSgAT4AtSvYmAiN5ZkNHYbsbmaMmXqN2OunQxCXn7-2Ie8-g>
    <xme:rN7OaIQBKqFpM_kvVGC60nPk8OPa8jk8mj59JEAxfw-n5ussGVdhzvqKDhLOh0NYY
    G_wXwYuq8ieKFjiWw>
X-ME-Received: <xmr:rN7OaHRnkL9wm7feOTc9hvHL13Nbh-HgDZNijAUGMFI8hSSVEM4NjQKDhwmt8XqdxJGZPRrDI1n_jiK36BCU7TsdPDWij5ED0tN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehvdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rN7OaF4BdHkO5Ilt8XqC2707CYsTNKwAZAprXV7H8_VfpHQyP276Xw>
    <xmx:rN7OaL1iQ7rpbCQRYGflRleiGe7jd4b9B1KVoKBZztPLSVKj9jq_pw>
    <xmx:rN7OaIAg3BveeGwLQQ9QHH2hfHxAZ-tsx2ZxKUfjuDs5jLNzxz_Fyw>
    <xmx:rN7OaOMXXo_xUO0JNLZO11hyMO3TCHUZK94vMEks5SxZpsgWxT0ytg>
    <xmx:rd7OaPwUifqtEU70KeFsPfp76_94ebsnp9lvS1jLhoOiaibrPz1U2Ceh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 13:04:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 3/9] docs: reflect actual double signature for tags
In-Reply-To: <aM7IQibwwKFJZcYE@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sat, 20 Sep 2025 15:29:06 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-4-sandals@crustytoothpaste.net>
	<xmqq348i138l.fsf@gitster.g>
	<aM7IQibwwKFJZcYE@fruit.crustytoothpaste.net>
Date: Sat, 20 Sep 2025 10:04:43 -0700
Message-ID: <xmqqms6pxdg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-09-19 at 22:34:02, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> >  Signed Tags
>> >  ~~~~~~~~~~~
>> > +We add new fields "gpgsig" and "gpgsig-sha256" to the tag object format to
>> > +allow signing tags in both formats.  The in-body signature is used for the
>> > +signature in the current hash algorithm and the header is used for the
>> > +signature in the other algorithm.  Thus, a dual-signature tag will contain both
>> 
>> Not suggesting a change in the text, but to make sure I am reading
>> the new text correctly.  Does "the other algorithm" refer to the
>> compatibility hash algorithm specified by the compatObjectFormat
>> extension and the "current" algorithm refers to the objectFormat
>> extension?
>
> The "current algorithm" is usually the main algorithm (that is, SHA-256
> where `extensions.objectformat` is `sha256`) and the "other algorithm"
> is the compatibility algorithm (SHA-1 in that case).  However, when you
> convert that object to SHA-1 to hash it in SHA-1, the "current
> algorithm" becomes SHA-1 and the "other algorithm" is SHA-256.
>
> Does that make sense?

Let me see if I got it right by trying to paraphrase the above.

For any object that is suitable to be stored in a repository with
objectFormat and compatObjectFormat set, "current" is the former,
and "the other" is the latter.

Your goal is not educating me, though.  I wanted to make sure that
the text would be understood by the target audience of this document
in a way you intended it to be.

Thanks.
