Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AAE273F9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006122; cv=none; b=qX3olsu/f7cFm1dzWSmZy+U+oz49HZi0P4dar4iLHeKZLbAT5+vdqGXQPgjqcmCCMVYWVfRBO9WvMcmCaJsboYow/GZx2YOlg4ZJvSAB/BHgRFccJjkN7F4uY7EaFceKYOlI+BkmBSoEXOa6C5Ns0bonStCNjhwxdfkFMpnnoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006122; c=relaxed/simple;
	bh=FwKoLEDGKnbKLCvDP2NP/InOEvKTjfYdg4QlkEmcFPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7AbFk+ZUXRqXjZCv6kOdxCP75sq0gVl8HcjhyIdy0Yg/4cdiPBZSKUJ6cfl7DuafYZJM/h9OssHyuRlcqali67boEFhLJRtzHNlaoOcbr7xSQdgjW9zegBmvzFVAVk8tb9KfcNjKN9guHK+pA1eCTMhvbu7UTfpul8KOrqahko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hkOreTiT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=shwRwJtN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hkOreTiT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="shwRwJtN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC7A37A01CC;
	Fri, 13 Feb 2026 13:08:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 13 Feb 2026 13:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771006120; x=1771092520; bh=rNEnCirsaU
	t11YelUTGl/DigpSjuKN6rlSWCNE2TalY=; b=hkOreTiT2LdcNt+NjOrsEckliG
	h1trze3SlC4hhqCrdyRR8ueXlZntkUbx1gvS2W4hsaiziVhABs5ODqgXQsDwFW0M
	tetoWOOClx1xhUchVyEnXvkglo7atGD3eOye8mjv3dbdPRfULMc4IU24PujfP6Fa
	jNEpTJ6JPvAHeT/W5YYJ5kYCi3Opoe5icsX9mmoO0PlztCdar6w0DE8og5OFamrc
	8lC9618IsdLQhJlWxSrZd2DCGNokO1pWTT/TuFv0Au5iIpFk2JabfaK9jtT88sGG
	pYxYxpgeeSsKt4pS4xlKS0c2x3W67j5nIZ2wZunR5D59wIHHnQGbS5kFAECQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771006120; x=1771092520; bh=rNEnCirsaUt11YelUTGl/DigpSjuKN6rlSW
	CNE2TalY=; b=shwRwJtNPmb6ZrleI4FLJ4Hj7K/zAdNixlPiLvR2OfVsE1G6Oe7
	aAk8+eO9Iu9gJkqnw4oG1IlcLjKm7UuC7Km+Xolj+YBiBgJmd2mFToOollr+kovS
	MyyWEMgPuDEltjkoWZ7QxfGsXT+5SUtMRDa/tYOLCBkv/qBSW+ldGtv/dqp5Qjyb
	cDQ5Fn1jZJgBKhRH02qkYMjXD0nVk9dM1fRS+xNCBHwXtlIEvSGkT4UuyM3vKYQ1
	DPThZf5PyHmaySZ4y7AHN4m5G6n5cFjOwqWN83bq5NTZc65BAQJfBOwEtBBuigyT
	Xw5XxeiJ/dT2/PF012dP1holhY0QxFXVjEw==
X-ME-Sender: <xms:qGiPaZPRA_jj_hH6mCXCGXk8g7mmMrZVrkuvFJvgpUyuBuP-aQLC1g>
    <xme:qGiPaQ4D-8Kq1jaCUnq4R_LAX5a3dN1v11RLvIv91qOUX9aHyNnO180F7MNd6gHFb
    LxXWUlP6aE1NLPMGlEN1DmvabQLPFpVhIOFry6HgogsV__41SGZPR4>
X-ME-Received: <xmr:qGiPacgQBwDYKRQp8oCk3gCh8PqrIMD67ClPiudGexnm2VxVzJ12RmUiyBfY1OhmgRqAJUb_je0YDCeGiVvHvTNhe8_CAupCvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgrihhl
    segsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehjrggtohgsrdhkvghllh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphihokhgrghgrnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qGiPaVeLF1YJLX8-CQMBemEenbNz8htaTOvIOYgF4LOxe1fr4gAULw>
    <xmx:qGiPaUx6cX7anqu3xi_I8kpgojrdHqyELzMWcEvL1V8YXpNhi54QDg>
    <xmx:qGiPaU1BDejGVDTFR60yooOZVR0bE6wqQPphGf7cNDW4ys6eISfXvA>
    <xmx:qGiPaaw08iL1KAwP6M_JaA6mUPm-F1-JdUFpcuXrQVC5LQdubj5mKA>
    <xmx:qGiPaZrG1gIE1T_4bXQ3HeEIWiF60fIrhs9g4BSsoejaT9At7o8ozePL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 13:08:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,
  "Jeff King" <peff@peff.net>,  "Matthias Beyer" <mail@beyermatthias.de>,
  "Jacob Keller" <jacob.keller@gmail.com>,  pyokagan@gmail.com,  "Phillip
 Wood" <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/2] templates: detect commit messages containing diffs
In-Reply-To: <7bf9cdde-de61-46fd-8730-592f87017a19@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 13 Feb 2026 17:42:41 +0100")
References: <20260206090358.GA2761602@coredump.intra.peff.net>
	<cover.1770993281.git.phillip.wood@dunelm.org.uk>
	<494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
	<7bf9cdde-de61-46fd-8730-592f87017a19@app.fastmail.com>
Date: Fri, 13 Feb 2026 10:08:38 -0800
Message-ID: <xmqq7bsgms7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> This works for me with `git commit --cleanup=scissors --verbose`.

Ahhhh, OK, my previous message was talking aoubt completely
different kind of scissors.  Yes, what we take out of the log
message editor will have these "git commit" generated comments and
crufts, and we do need to strip them out ourselves.

Phillip, sorry for a confused message earlier, and please forget
everything I said about scissors (I may have said worthy-to-listen
things on other things, but I do not offhand recall).

Kristoffer, thanks for a review.

