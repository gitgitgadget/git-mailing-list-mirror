Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047405695
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079623; cv=none; b=Xpwya7eqHUpseX8fsiQxcbS3qtfM5T7byYmlSvm6ihrjXsxJbWunqJyvgCdWP9P7nx0NTceuSuWstPLHg2/Wk6CYkjYdtHqp/ElwJjQSEfjUmC4QdFQEr8g5qPchu2krLHv7No7rTvjNzKd/ovvPyR5HJei1VeYWJLA1NznbkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079623; c=relaxed/simple;
	bh=TStb76rZKpqdrQdBqku/DipV5bkW6P8znbliGiEt7NI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CiS7k/kCTNERzZ71uFNMoFFewLHJYRzri/EJMgTWiWo0mPZAdSnKz8ybewp0b9VMf3v1DZIGeiPPiuxr7nY22jO6TA7Sx6WOsw/tGMTP0/ZKuiW1snxTC9roIUjNdP4H0uPup7vDxtcKXKt2zyg+ynpdDsSN5A3UxO3gr9E7tUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R/iE9u78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWFYluZT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/iE9u78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWFYluZT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2518D14001CA;
	Wed,  9 Jul 2025 12:47:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 09 Jul 2025 12:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752079620; x=1752166020; bh=mA6iv+fqW+
	y4RWwtRel07kkbt6e4w9G6/rmerYf1mOk=; b=R/iE9u78ApyZwRG0p248SqBu7m
	OiWgqEQAqgzXXRLGbCpLzgxo9YQr7JeWTQoywT9u+GlwyXlwNZvIHUxz+YoDzkku
	QhNW7jcYUTWse0BT9sU7b95QO+V1pxGcRx+HT24jkfCEOKP+oSVh9ywH8AZ37iwg
	6FYeo2qI09mk36v5LENsXcIX+l2pYJzpeOJRTbGH08cde0HAdaDmaqprSDVEA6mU
	2FSDa6h45Qs7xLLMIHP4l0NI61nC7RtlLveNZ86KeGliDmbNJLju618jUHlQJLJT
	HOagwQk5zUwfA/cJ76Md6lctPUM/k58RasDU69E1CBth8pxXX3ARXwjRHmIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752079620; x=1752166020; bh=mA6iv+fqW+y4RWwtRel07kkbt6e4w9G6/rm
	erYf1mOk=; b=eWFYluZT7W4IolmktMjphm3PdTjdLKpIppw/fxwqANmx6CyrikB
	pbKwK2lV9BxLL03XiIF5h7yRacJxlVSngAktyvyJedFxaU1H+AAqxbFbzD4mzE2d
	MewK0tjRWXtViYEKrYKWeq+CidvWCKEeIx9j8f885PdbE3DfD94xvVrZD9btU3wP
	rXoKtdk69Ei7QrK4z1hD15zxYKvx1Ey6XOURLEwHXRGzhr0xy5OwPOmixBM5eS+t
	5CArl5VvDb4gAntO0+MmkbtiMeN+IelHaL59hMgM4lI/rLWxEl9w4ZS3ZzZXpOfo
	MyTAm7oQF7qAyk9ZtalK4Vhh9tYoVyYuGXg==
X-ME-Sender: <xms:A51uaOhfm7j1seJOeDB81BxcKYV27iUw3FxvZ0isO_zCiM19NDBgzA>
    <xme:A51uaKjYRG92tZeLVY99_RjmOD41l0yB4KYPgvT0Ed0hoMxGTXXsa2xYO1W7y3-wL
    gIpkD0ptNnlmFjniw>
X-ME-Received: <xmr:A51uaMhZeCukfspY7kuDN_COlVxPGeY6ZEfiFeOQj53qtGthnUghtFIgviHZONsIrwJNbKFmzH6OF1EKyVVm1-Tg_GGR7SgQcrIH4dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:A51uaCKnXQxuNGFCzdrLg7Xc-JZ4f5cuxdOqS1mYoRBg6xIzFH0e7A>
    <xmx:A51uaDEPXft5s7FrTw5zhO93Vsj1roVn_oaBNZA5-LH5H1gAyGsNdA>
    <xmx:A51uaOTFqncZ4Vg-zslpxSG3OqR6yWXkbhS-LSWpKbcXeXgtD2I5dg>
    <xmx:A51uaHdbIn8RPV0oKe_VzvM23QQgC2PrfMT588tP8fN3v6_yFIh1Eg>
    <xmx:BJ1uaBhnNdpkK9nxJufo8JNLJlOFESvk70Jvqb7HDXeylWIPGdpk3h56>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 12:46:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  newren@gmail.com
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
In-Reply-To: <2503c79c-68f3-4ed5-bbfd-3a7af07a89cc@gmail.com> (Derrick
	Stolee's message of "Wed, 9 Jul 2025 10:39:29 -0400")
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
	<xmqqa55etm5g.fsf@gitster.g>
	<2503c79c-68f3-4ed5-bbfd-3a7af07a89cc@gmail.com>
Date: Wed, 09 Jul 2025 09:46:58 -0700
Message-ID: <xmqq5xg1cnwd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> A curious user may want to know "why are these directories still
> around?" and the more verbose output would assist.

Understood.  That one is what I was primarily after, as opposed to
"These directories will be gone, as there is nothing interesting or
worth saving", which I find much less interesting (and perhaps
should only be shown with --verbose, as opposed to "this will be
kept even though it is out of cone, as it contains these things that
may worth saving", which I think is something the user would care
more).

>> I wonder if we need "-x" and/or "-X" options "clean" has (and
>> perhaps "-d" that is a no-op, as the whole point of this subcommand
>> is about removing directories from the working tree) to control its
>> operation a bit finer-grained way.
> I'm of two minds here.

Same here, and that is why I said "I wonder" ;-)
