Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F33DEAF7
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686435; cv=none; b=tJh6EJmpwiZPpmn6WwqbwhQ/R/C2PL8ZXCMpbfG0gpwsyKJKD4KShdotWwVlhZbSI6DWBPzmqIsXqLyJodeE1Ua+h9tcKMNbGUO3hw7qeE8jbe8kUj5CUrtvdI7DC6mauP3pKuy/Oppz9vrs7FyoIokgjJ1/5ZGt56pN8RBlqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686435; c=relaxed/simple;
	bh=2w9gImTcCMwZbpRGvirKGCKGfcef+2yigZ8BxdlEyN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I64LIWj3fr9IlQnnufn0Lv77YfEk3UDQUw2on/f6fYSZbad6lRS5eHupHtpHV9+pRlKE23UNbKK0dPvkQJo+C48YF+K2b1Yh+8MBXgSK+CHNgNG/IwFFEYrm9ERn6DslSz1OAZN9Qc0WB7cErviGIze2Q75Uo7d68hUZ2SVuso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=brfD/knv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IrN4G1Yg; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="brfD/knv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrN4G1Yg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1242C1D00252;
	Mon, 16 Mar 2026 14:40:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 14:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773686430; x=1773772830; bh=b62Xg4EFWT
	ACO/KgTnoO3QnHGJZT6djMYZ3PE9HtgsU=; b=brfD/knvaTkQ5dw366xEHVJ+oE
	+k2VelZMmAd4uGk3e61pdvlfNQlW/kNrqzDccMtTNLreYKQ3heqcLhKScAYsK0h1
	JmkhNghssN9Ej0dYZE1IHA16crXxEE6rBLrblq+lVfjvITf37iXkHazaZVqTNqb6
	HCBL9myXy2kZQD/dJ27MhZF7+cSC/OsfDDBzrvlfp2kmWLoJYBSlaeALX/VcCq+P
	8ty1Q9VhvcjAAhKF2cJ6jS1ermrkJ2VP9EbRhuOA2RKcoRJ1MOASB6aEzG3vTias
	a3NzJ+uQG0ve/Heup7qtI15KySEt1OYwpIyvyqYQHaagb3v6UGygwI1RCxHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773686430; x=1773772830; bh=b62Xg4EFWTACO/KgTnoO3QnHGJZT6djMYZ3
	PE9HtgsU=; b=IrN4G1YgxQ6/e+nrOYfxixVbQPcs+5d9sy+vfAbr0GhAiaLdvrG
	/EfY3ZgkXlhXAHsKbBelXFe/zy53SgKf2Wz87VOsjlcLEzbmIGaRSYWiG4xol1c8
	jCw4KV5QRF7pisgJ+qtc/AMo/sVkcEFVUg80f7bGUBPyMvrHorrii6UTAi7C/9HS
	2xcDK/sDjttSOpvNypk+2HCwoZLy2F1b9tgGcXaNkBnGyC76nT2R00BpnrAJUiQH
	gmOJ5AAqvC8/rPAjW0jzNrxnbqnteGE3jGPHlQomDjd2ze0DFe8jzzOOnEZyOz6C
	3dpT0nfgNWXvWTyBXxovVMOeIE4PPb4EHqA==
X-ME-Sender: <xms:nk64aax7LxRRMzRnyGncTxkZhl_RJ9tJ_k7W9yuW_IYb1ey_e2GdvA>
    <xme:nk64aY0QmJ7KD0vjcNrCUUYIOO1DQVko4qJSat9S7zLUSoV0ZbW4NsIReN2qKG7rU
    jx-BcEvVc6oQgPjJ2BKNGpFy707Gi0DWkqh3TDCwvCoJK3yEtPBwg>
X-ME-Received: <xmr:nk64af-OtzR3CNXk0YXLzAYbq8p1nNfHBMJLuYNpKcF_BlGcv3xKKjSSuWGIoKTyt7XFSfrDxjUaE4yPsExZbnxG1tr-p2Ybow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeludefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepuedujefgffelfeffgedtueejtdeuveefheevffelhffgfedvheevieeuteej
    keetnecuffhomhgrihhnpehpohhsthdqrhgvtggvihhvvgdrjhhosghspdhmhidqhhhooh
    hkrdhjohgsshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvmhhilhih
    shhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nk64aQqyQV804Sk8nl7LNVHQ59gjytAo3FJa-nBOU_xWfwZMniHsYw>
    <xmx:nk64aRT6peN1NfP9lo7FH1AsLSbjr1m4vZlQ6jQUZD_HSY-lwV-e9g>
    <xmx:nk64abMoawBSgxygH0iVHwz8LwhJyM4yKSM7d_TwPmnxhqbrOakARw>
    <xmx:nk64aXgiPPyI6bdpATdFx2LheQsgBi8TT8w2ujzxbLfIXhofzEmw1Q>
    <xmx:nk64abuWORq97cxRAo562wssP4PsOjaAPjT9ItGqcfW72CxFGZXA176y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 14:40:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 7/9] hook: add per-event jobs config
In-Reply-To: <20260309133739.294555-8-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 15:37:37 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-8-adrian.ratiu@collabora.com>
Date: Mon, 16 Mar 2026 11:40:28 -0700
Message-ID: <xmqq341zpqhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> +hook.<event>.jobs::
> +	Specifies how many hooks can be run simultaneously for the `<event>`
> +	hook event (e.g. `hook.post-receive.jobs = 4`). Overrides `hook.jobs`
> +	for this specific event. The same parallelism restrictions apply: this
> +	setting has no effect unless all configured hooks for the event have
> +	`hook.<friendly-name>.parallel` set to `true`. Must be a positive int,
> +	zero is rejected with a warning. See linkgit:git-hook[1].
> ++
> +Note on naming: although this key resembles `hook.<friendly-name>.*`
> +(a per-hook setting), `<event>` must be the event name, not a hook
> +friendly name. The key component is stored literally and looked up by
> +event name at runtime with no translation between the two namespaces.
> +A key like `hook.my-hook.jobs` is stored under `"my-hook"` but the
> +lookup at runtime uses the event name (e.g. `"post-receive"`), so
> +`hook.my-hook.jobs` is silently ignored even when `my-hook` is
> +registered for that event. Use `hook.post-receive.jobs` or any other
> +valid event name when setting `hook.<event>.jobs`.

This design is unfortunate but cannot be avoided, as we do not want
two hooks (i.e., two different names) that react to a single event
specify .jobs value differently.  Naturally, we need to worry about
what happens when somebody gives the name "foo" to their hook that
reacts to "foo" event, but that would probably be benign if there is
no other hook that reacts to "foo" event.  I also wonder if we want
to sanity check and complain upon seeing hook.foo.jobs set when
"foo" is not a known event type.

Perhaps anything that appears with one of the .command, .event, or
.parallel are likely to be <friendly-name>, so having .jobs under
such configuration key is safe to flag as a mistake, or something?

A careful reader who is reading this message from the sideline may
notice that I specifically omitted .enabled from the above "clues
for friendly-name key".  I think hook.<event>.enabled that acts as a
master switch to prevents all hooks from firing for a particular
event (when set to 'false') may be something people eventually want,
in addition to per-hook command hook.<friendly-name>.enabled switch
that can override it (or do we want to forbid overriding it?  I
dunno)..

Other than that, looking quite well done.

Thanks.
