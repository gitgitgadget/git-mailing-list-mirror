Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4BF22333D
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026245; cv=none; b=qMvtS4eVjjZmAogVJbrsb39WuW0e2xVRaJHsQ7QCqhr4N97CgPk7DBGZvI6av3IZ4sdtNwUVQCc1vWcXQQA6n6YcIx/nTNGLdmGNGL8SBgqu0I2K/O6j7O7/LIBYKZQlgFWpUNjoqSFbxp1wbXn+AKLPz3A4fxsm3sTV67ueZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026245; c=relaxed/simple;
	bh=2mvmUCmsFLt6Lkn2Wb53m3pxll13H1QgqTU0tChMxAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bB7Sxb+W7KJRyX7BKoGWKffAKfliYZ8mPr3vqpCVOkynsoBYV8gzQePYCK8jsnaQ6SJcCf4TmH8SA8zgzBuIeGrHFoBzdJ/YFI4fyXD3GsFjuc/7HlUeT/4gCjI+bmmBDU1BlizazC8BG5QVJba+xJSSSECkQQnhzzsKzVbExdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X6Rx/Aq/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=osco1zcn; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X6Rx/Aq/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="osco1zcn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4669F1140263;
	Mon,  3 Mar 2025 13:24:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 03 Mar 2025 13:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741026242;
	 x=1741112642; bh=O4vDNPQwKT6ysaeRsOCHu5IhAI16BKGzJe4nP4nFVG8=; b=
	X6Rx/Aq/tlG+DEsqB4Q8JJijya+v4YEQ3PBr6FuVqGf3TDVf9zgbdZb6dNBksY4a
	o4RP7rPvu9P1w6AkdfWaGPrB/ktWH+O8WuixNTW6BO99LFcZTDiacITP2lC6UP3n
	RHdXHfunkNDBivyh1MPP2j6zcSvQCWmflLLKO86q/omGpLHYF9tgwOdxS8Laoe/g
	Q2uphaZiKxNVeZwfspvn2MOb1FVP/bbzRC/t9docgGy78Dve8mpcH50vw2B386UR
	lOF6Hc7YRcNW+3K1OYLgnQwPaR0WbeRgdbZ9EVtnAd8YYUpVgzio8Ye8o1+KsQSi
	sC5G49XEZ2lpTSMFwEuPew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741026242; x=
	1741112642; bh=O4vDNPQwKT6ysaeRsOCHu5IhAI16BKGzJe4nP4nFVG8=; b=o
	sco1zcnVJQav0yJoau7cdodirvuY/aJilX6T3H1iaga+jfBBnGi+3N57lx7iUXJa
	MOH4lDIvB5EBOuA9KEciyyBlwlw3ex11+kOZLGY0B778QWdE6LwsTKVMHTop6wtH
	VtVXh9/vB+jWvkiakCENcHqYZ764oeQ0PYeb62s65G5OQcEheEZPyyaMx6aLSYh/
	7r2Ev/M2Iix1qQ6I9sJCexiBX77/3D1Yu9F77tUwTWR49I56HNeRcmKxMEtfIUzX
	vX/a/iDm/ThMdHcmBnMBrAaEM4iHk3W1QdnHA64NjFiFh5CB1xni+2F5ObwEhs8Z
	M2daHVfQmrj1BKxbAEzSA==
X-ME-Sender: <xms:wfPFZ5ZMoH4QIvLpgXJZgE7RXi2HIlv4dMN8c7OoFAJob-UjviGpOg>
    <xme:wfPFZwZ8TeWZk-PSm8_ixEOAHCT4qB8wFc0k9uk824SmuXMVjjLWnnV9qI_QDFzrL
    u7g6nZgNI4QJIp02A>
X-ME-Received: <xmr:wfPFZ7-KU8CO_NMMy3F4PImOr9roh9FmNubNSfR9YGBaJx4U3BirpN-lGRBwv8v9pPEev2lUIBZNutYsGvOtrWbXm4ncRLy1kVpu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehshh
    gvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekiees
    ghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wfPFZ3oZMcG9FX3tEGIkS6FPUpWVvxwGD11n7XUTYKARfWrUYrXtbA>
    <xmx:wfPFZ0o5h-OtBWzVt1o1eaMO3FQR16oALSOUqhemR9D9dU7gCeNDqQ>
    <xmx:wfPFZ9R8Kttm8gwvOftOuvHIoWyueLLSMfY9SIJpnrypOqgkObKq2Q>
    <xmx:wfPFZ8ovS9tBot8QVv6cbcFLOP9GsiRdYE1cVt7Luy3ef3Nsk1sgUQ>
    <xmx:wvPFZ72MB9i-Y6VLugq5fCv57P7OKmoobxPd3tSq2cS40nt6MQesBOAE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 13:24:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  shejialuo@gmail.com,
  johncai86@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be
 NULL
In-Reply-To: <CAPSxiM9x=3WTmH-NSuV7Z1FtXMJ6v5B0R-zB3DOKcyiLKXy2rg@mail.gmail.com>
	(Usman Akinyemi's message of "Mon, 3 Mar 2025 23:07:36 +0530")
References: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
	<4e21312d-0d9a-404a-a2e0-0e2fcc681ad6@gmail.com>
	<xmqqbjum2ayc.fsf@gitster.g>
	<CAPSxiM-fzKUtvvf-DB2=VaGznr9utyb6zaKU5onxpy49KPChUA@mail.gmail.com>
	<xmqq7c58zg9w.fsf@gitster.g>
	<CAPSxiM9x=3WTmH-NSuV7Z1FtXMJ6v5B0R-zB3DOKcyiLKXy2rg@mail.gmail.com>
Date: Mon, 03 Mar 2025 10:24:00 -0800
Message-ID: <xmqq1pvevupr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> On Sun, Mar 2, 2025 at 1:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>>
>> > Also, about the testing, I was thinking of using the clar framework or the
>> > test-tool, do you have any in mind ?
>>
>> Neither of them seems a good fit for the task to me.
>>
>> Once you rewrite one of the built-in commands using this and run
>> "git $cmd -h" under "nongit" helper, wouldn't that be a good enough
>> test to future-proof the codepath?
> Thanks for this.
>
> To confirm, You meant using the "nonigt" functions in test files
> inside the "t/" directory?

Sorry, but I do not quite understand the question.

What I meant was to peek at existing practice in

	$ git grep '	nongit ' 't/t[0-9][0-9][0-9][0-9]-*.sh'

for inspirations, like

t/t4203-mailmap.sh:	nongit git shortlog -s <input >actual &&

where a command pretends to be run "outside" a repository.

