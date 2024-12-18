Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590D5FEE6
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536366; cv=none; b=DZC7tUD5IwYql2eu5f9wP6o8FEd2nt9+2HUtEeGk4o73odSkVkPRz9LR2pkyFgfGuEpq77FjPqP88P34ad9d1oqxwS+FTgVi+eu9/kS1qGxpXndoNkkr0L34Qr8sP1zKohUhnXm5d7LAQmHKQsWPzztUoR3ytIioo0R3Sdva3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536366; c=relaxed/simple;
	bh=cF6pWydwXJ02w2vhlxNuiYmrdE1PxJfXhoHwuV+ccjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lnOOXgtobUmBhZq4x/lucZvaorErrmikN7X7r21FVvQW0+k/UC8ncx4N2AQG5oW5uCCT8HAa9RHrOFS8lkR9qv54Si1+kOdj2tNxiS44MNUC6gI7HaQkpRP7pU/DaSBianDLh8jU/zlBl0fFchSzLEb04PgGlJRPJBghhOKCMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p1bK6h+p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nN98fD4Q; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p1bK6h+p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nN98fD4Q"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DE4151140181;
	Wed, 18 Dec 2024 10:39:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 18 Dec 2024 10:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734536362; x=1734622762; bh=EyH4B8GRl1
	TGXXETbu7Zjxc2e1OEM/Ngh1kRaEgbr0M=; b=p1bK6h+pxi8nmQSAcj1zIVNzuQ
	wI6TzCozCRn3W/wWZI+2ofWbqByEZDk73jIKkt8gDT6W6yYcV15zq3VzqCOh5Apv
	Rh9OE8+Yh2YCaIUxCTfUrZmLaesFYdZlY6I9AcC2sVKczrQqcQdpIzCZd2YVrkTQ
	czm4h4Tlc8QoOEWuivWLTlUJl2pOeWN3YlnHb/w0Ns89bs0BSoP2SdbHAZkq6I26
	z7zkCULHdjj8ad+oO9h1WIivwZaRfeFiLnZVOu6SJzWRmxPHYZNyoBE/rBD9f48A
	8WLWf93zMy+Z6Wmu9vMMN8wi+s3193ar+5MuIj+QP7gunBHES3hJjKm0KuMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734536362; x=1734622762; bh=EyH4B8GRl1TGXXETbu7Zjxc2e1OEM/Ngh1k
	RaEgbr0M=; b=nN98fD4QntJVs7XMKMAoGWfd0J581nXoSFphg3QpU0tEt7Y1QDJ
	pctSLRnhp9ZW6h1FnsEccU7EsgftNXVEtre6jgwp3ebNIeB6SxnuGKkqS4FTbEJD
	UnuXCxK8dkOFc54NF4iPDgaarw8RCRPGLdreC8jM0o/r4qnsQN8TV3wsV/LvYNkq
	MvvDd2aGDScNCV4sedWZHCONOTA2JG64u/6f1j841oquNzvwutcavsTWmBZCQvkd
	YCB9tJuj/ZEWxrLMsCfJ9hlVK9J/7Hnyo5OZIngCox5HcXyZGDyIwscQlr6kaRew
	E5Ss5uweRkxQMJXFJioA0TobDQodNFLp8Dw==
X-ME-Sender: <xms:quxiZ2J7B3qw1oS4xyDkVbpIdAt0FOHcJbp0HSbJf_32XmP-M8p09A>
    <xme:quxiZ-KwV7BqLrOv-MSfWQ92gbXjQMsK_3ro19lIpPQQwn-KiknaZlG24QfSk-JVP
    opT1oWL2FVjmnc27A>
X-ME-Received: <xmr:quxiZ2u0-eHZTKnmcCo5xNOag6GUlwfqPqRsVwrsW3Lb8CEVq7_mRJXR2O6Y8-_UWnkmlFoVCW616M26SJT8RWQlDqfDGG4PUcGvPE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhuihhsfihpfhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:quxiZ7Zf8fAMZKVjcpveK8jDQSEMec1SiAekpus9kCfHJIQ4pKkK-g>
    <xmx:quxiZ9YIz75EhICZRtnANePIlhSRJyPgF3TSUYMqxT84VEkjPgrieA>
    <xmx:quxiZ3CjRXrCe_cDCZlKLSpd7LR9aKXh1j4V6QGafT70YfRfyCA2Gw>
    <xmx:quxiZzbIWt49cdp99nVxmcVvM0GphW4F-BHS9G4RtENWA-7s29dsKQ>
    <xmx:quxiZ8XnzNpjB88suk42dwC7D-nq6WpUvJSC7XVt-QFrPG_O2L2OnOie>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 10:39:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wang Bing-hua" <louiswpf@gmail.com>
Cc: "Wang Bing-hua via GitGitGadget" <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>
Subject: Re: [PATCH v2] remote: align --verbose output with spaces
In-Reply-To: <1812389a7b6fe18d.7946240d95ed36ca.1b2132d5c888cc21@host> (Wang
	Bing-hua's message of "Wed, 18 Dec 2024 08:37:22 +0000")
References: <1812389a7b6fe18d.7946240d95ed36ca.1b2132d5c888cc21@host>
Date: Wed, 18 Dec 2024 07:39:20 -0800
Message-ID: <xmqqy10dt2zb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Wang Bing-hua" <louiswpf@gmail.com> writes:

>> Wouldn't it work to just do (totally untested code snippet below;
>> may have off-by-one around maxwidth)
>> 
>> 				printf("%.*s%s", maxwidth, item->string,
>> 					item->util ? "" : item->util);
>> 
>> without using any strbuf operation?
>
> I did try to use printf at first.
>
> 				printf("%-*s %s\n", maxwidth, item->string,
> 				       item->util ? (const char *)item->util :
> 						    "");
>
> But it broke when there are non-ASCII characters. For example:

Ah, of course, I should have double-checked, but it should be more
like

	printf("%.*s%s%s",
	       maxwidth + 1 - utf8_strwidth(item->string), "",
	       item->string,
	       item->util ? item->util : "");

meaning

 (1) the first output field must have maxwidth+1 - the display width
     the second output field takes.  The field's contents is empty, so
     we get enough SP padded to make the total of this first field
     and the second field to make maxwidth+1.

 (2) the second output field is item->string itself.

 (3) the third output field has item->util if exists.

> Thank you for reviewing. I'm also debating. It's great to align
> "remote -v" and make it behave similarly to "branch -v". But it might
> not be worth it to complicate the code and break machine readers.
> Do we continue working on this?

You already know from my initial reaction what my answer would be,
but I am inclined to hear from others before we make a decision.

THanks.
