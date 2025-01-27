Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1694192B65
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006742; cv=none; b=jZ0pLT8mJnInJNRAhW3UMddUFXjUvajk8MuCj9lyZLGKXLdQWNM2JasAV635HtVXDHUzPwwuHUgrs0M3DhIHNQDHUhN4XUXB5te4jzqK72IHSQ+xNC6tHrGw6QNuM/+yX7MrcCA2ctFFPGtT6dzsUxn760/0CKM0ig1jhaIefSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006742; c=relaxed/simple;
	bh=oPCqYhxd+fMlFptYyMXo3Iw5gk+O8C1rqTJrt3hI02g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WAcjKlrqyDoqoYxwycN3l9xYMSIFXGns0zS/gkJt/yT1IdvbjW8dRA0ehgJui/BSgqXqS7u2jw1OLT6RordtzoLBKz3pP6DqUyorGPxuX/tDKlPo2l6HdcuwBqrZwSviKrmOeywWSJA6JeOvr2PJ4FWcXu97KOhAwyrQSBrzO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gp/PWpgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZYcZPdK8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gp/PWpgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZYcZPdK8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C52B025401C9;
	Mon, 27 Jan 2025 14:38:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jan 2025 14:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738006738; x=1738093138; bh=VM6p+2yEp8
	KcVqfM0W+1VHbAsub6NI9EGyaQ9R1Gbbc=; b=Gp/PWpgyAZ/XiRgbpuYiThLUTK
	HGxqZ3Kx2+M600RJgDX1ai8W8uczFTwHVOpvSZhsjTwiwWBi2EAEKzoSK6cxsNn9
	ljEceZU0iYyoWtwKPE43YAkK7lP2V9IgIyhTZSy8wKZEM0blOnubfDEOBKS2ZTHc
	E/0LJcjWx6KvNbyCm0NdligUrvQn0LpofXOD4rPA12OYbwdvhYoZKzJMOSW4bmJZ
	wLa9bNoKlNsfpyHOGG0lZ3YdK87lsnKdnlLvNvtai5Ujh1aWIvzctEw+KR74IUC+
	0LR6TOYR860ncuezqmtVRctDSluXim9oAIGWncelHM/kvjlDgLC4mUOuOxDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738006738; x=1738093138; bh=VM6p+2yEp8KcVqfM0W+1VHbAsub6NI9EGya
	Q9R1Gbbc=; b=ZYcZPdK8YR+i9GUIH6awGlAULacIzMKtMeURej8MMNFVCjobnol
	CS2xj9i6sCcslb1hxLKPKqbJzV29qGgwSbZ1B15a5AChdGHHC9WMtkA9Fprk4hU6
	R/p2tRpt7eqcdMY2OaZpykDaMovVuJ+6Tuz4E3hOleNtCJ9WniBNgdIrOCl30uM/
	mUpnZJtECdyNMW3sxbpxqmbFAjuyDqT53LbdhVuHqHmI9afAqZ7LIwXjAVLwpqRc
	nZCTp1E6eeqpHdt+vujadZJe7wToOXcp9CNUZXZhpHYc3gCYLtnGFeYfC5FJk/ex
	2AJf7UnixeJ9Df2PpJo3uvQYgGse0IZrYNw==
X-ME-Sender: <xms:0uCXZwIihCsr7dx17PBMy0YGvLK0zeWBV-Ef--hMNZ_PnfBf2B_LJQ>
    <xme:0uCXZwJjnpvdoje_ACa6-Vs34DBJwshc99kbTPdZCBcna-bRSDzNrnOFogSKFvRM6
    Qbeyf81bpQaPFPCAw>
X-ME-Received: <xmr:0uCXZwtMnIgS1ZDgyPkdDRvuAa9kWF0oVI2aYTRWVOiTfj8A6U5Q_UKqw-G9gUCti_oUp_OGZtyKnOC3u3v7DeFfc9MYWp14WT8C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0uCXZ9au5X_LldUsQyFRwSluY9ulUszy56gGTRKlBACR9ZzL8VUngQ>
    <xmx:0uCXZ3Z5a81GEQ7BR8xPSg6DQII_gzUQn0gQSR6tfdyxnauFbeCtRQ>
    <xmx:0uCXZ5BXkdNo1Gqh9odLvqimeGSDgCXqgVqaWxkk8JZx5y-bfwD4gA>
    <xmx:0uCXZ9Y567Twwd6w3Gum6JlP30vIvU-HR5MkQJkIgF6HdqyTn_mOIQ>
    <xmx:0uCXZ76xTk9smGGFhMlcjR14kRuGgE-HxxFEqB0nZr4RUKusmvPDRpSe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 14:38:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,
  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/5] Introduce a "promisor-remote" capability
In-Reply-To: <CAP8UFD2BSy5dL4r4LhuYgc7uvkVoL4uemuwzYXv-XrCKScpnwQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 27 Jan 2025 16:05:40 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
	<xmqqikrtnuyp.fsf@gitster.g>
	<CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com>
	<xmqqed2go40d.fsf@gitster.g>
	<CAP8UFD2BSy5dL4r4LhuYgc7uvkVoL4uemuwzYXv-XrCKScpnwQ@mail.gmail.com>
Date: Mon, 27 Jan 2025 11:38:56 -0800
Message-ID: <xmqq1pworqr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> or is it merely
>> because the way the feature is verified assumes that the multi-pack
>> index is not used, even though the protocol exchange, capability
>> selection, and the actual behaviour adjustment for the capability
>> are all working just fine?  I am assuming it is the latter, but just
>> to make sure we know where we stand...
>
> Let me know if you need more than the above,

Hard to say if I got a test script when I asked for a simple yes-or-no
question.

> but I think it's fair for
> now to just use:
>
> GIT_TEST_MULTI_PACK_INDEX=0
> GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
>
> at the top of the tests, like it's done in the version 4 of this
> series I will send soon.

Doesn't it mean that people should not use multi-pack-index or
incremental writing with this feature?  If we cannot make both of
them work together even in our controlled testing environment, how
would the users know what combinations of features are safe to use
and what are incompatible?  That sounds far from fair at least to me.

I see Taylor is included in the Cc: list, so hopefully, we'll get
the anomalies you found in the multi-pack stuff resolved and see how
well these two things would work together.

Thanks.

