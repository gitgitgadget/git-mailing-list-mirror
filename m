Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A741F09A5
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423954; cv=none; b=lwJxTowCw9nqykXWwNpgSXaG15zpVGjvbeIfOP0oL0h0GtXiZi7SDlEmhq1SO9ZKkrLcE8skURmfTqq3QmzkU1Y/d8UJWEJsP+1BxFIVBlZqhJ52xVkwBUJfdhGYoPc13St+woP+ITODM6ygvgpNo82rZQXxAXqV+8K3LpLzSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423954; c=relaxed/simple;
	bh=Y9Cop2S812cUS+evrgj6/+82gNUkSAnfgKH/SwvNm1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=APFbOPl13MpJOps6igv/5NMFlnGHS7PwEGI2ILDK8eMDwds5AUeoWyD+8aklQNAMRzIox8/r9NFWyBO/ZFDfRIEIUsISxN0KDuBYtlq6W34CBd620rONNkh3VKm73Yrxzg7qEESWnNXibhZFkTXSY7eRbCVC49u5FNQT3tD09bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CSwNWQfh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSDnWmWq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CSwNWQfh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSDnWmWq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E3697A0149;
	Thu, 28 Aug 2025 19:32:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 19:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756423952; x=1756510352; bh=ShJjl0w6OH
	E0gpZGsRydrBLTGn3UIKBkdNpjN8IfvEU=; b=CSwNWQfh+Tmnxjw6UhT8Ji0vA+
	UeO95o+KAptUD5c4tlvCvMC/0sFIztpPDL/oRadzHnJbP9hsas9Xg1UEvZRSBdxh
	EpZBs8PKhkz+ENFr69B/qAPeMbJQ8mYNgG2DiGWBMjmQ1pyM1u6K5ynLm4WdLzrN
	zwhP79Q4MwV0i6l9SlkGAsNRSZOjiUVVJUffDYaRIWghsBnDYudBRQxP+Nzvq2+I
	qh2kJzz3UoYtzPzOV9hODvXdDVF8QXGCKVdTZDFTlyw84nN4L6VBkioIAsM3acTp
	qOOJ5QD8+tcMJvjJ5984Lwkbf0NNpPtUHp28hidDO2M8ZI6MR9rcX5BjMeaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756423952; x=1756510352; bh=ShJjl0w6OHE0gpZGsRydrBLTGn3UIKBkdNp
	jN8IfvEU=; b=gSDnWmWqPGAq5IVhmrHyDttDPGU+l9oDJ4rT+VS6WA7HRnUAKX4
	G6e72bEqb7kwjQ06AAhFOk1UDXG7atcYhp+fQfNWKQLSEJES2wVONVjD0zBcHaFx
	JDJzktn3XHU5GDqVQ5gFgE1JXaxjcRMbBfWggrRYjn3JPdHT5Wyk4aDWCNN81jaF
	R5l98CNzyEaUa61VXk6R3grpDgrramsFy2CY/braJExOyaJac1wXtsmRHeRhsWGW
	RuVPzlg4W22m7GioiuvXMHp0nYPyl+6HzvZq3g7q0RcS6fRiIoiAPtwSCy618whN
	6dLe2mGydAny7nPyKTP3bROBW7cOQKqO0/A==
X-ME-Sender: <xms:D-ewaPg0IVv4ezZk_K80RZY6HSmJik0idcyqEjp5YNQWaJxR_Kg6bQ>
    <xme:D-ewaI8b5xpVYG1z53HbgPYJLQa9oenXXVzzNsf8OdvzBf4reMogsZrABB-7iCkBf
    PULZIr0QDdMh1ynWw>
X-ME-Received: <xmr:D-ewaKtT5vVONjBs_QHMuyquBT9Nomi_MqWCNcUNJh2a2cJsB-FmyTs3XeZef8fc6JElytUyCZziPFaVY3MJP0c_HUVJoSQoULhylV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:D-ewaErQHzYfywwdeJLvyRGmmOdgJZWbmCt5TV1UvzWAFLnz3m-iOQ>
    <xmx:D-ewaGopnrGR70kNZj7UXM_MJrbLdTZI25tysWmBQVuS5Gehk84Lzg>
    <xmx:D-ewaLYuCFYtu_AONvcDFt4wbjh2NDz8CqxG9aixN8GIzmg1WX-CJA>
    <xmx:D-ewaM9H7xF6QEZiwcLNMl0NAh4-hwHGZFNsA5Hd470ClyNRQok-lw>
    <xmx:EOewaDNu5d4FeLLy2yj4gAfOZ5ZUsgBrSn_IrLoXIiEp6CEFjBE-UCDU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:32:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Jean-Noel Avila <jn.avila@free.fr>
Subject: Re: [PATCH v7 0/5] Make the "promisor-remote" capability support
 more fields
In-Reply-To: <20250731072401.3817074-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 31 Jul 2025 09:23:52 +0200")
References: <20250721141056.2283349-1-christian.couder@gmail.com>
	<20250731072401.3817074-1-christian.couder@gmail.com>
Date: Thu, 28 Aug 2025 16:32:30 -0700
Message-ID: <xmqqqzwvqay9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Changes since v6
> ----------------
> ...
> Christian Couder (5):
>   promisor-remote: refactor to get rid of 'struct strvec'
>   promisor-remote: allow a server to advertise more fields
>   promisor-remote: refactor how we parse advertised fields
>   promisor-remote: allow a client to check fields
>   promisor-remote: use string constants for 'name' and 'url' too
>
>  Documentation/config/promisor.adoc    |  61 ++++
>  Documentation/gitprotocol-v2.adoc     |  64 +++--
>  promisor-remote.c                     | 398 +++++++++++++++++++++-----
>  t/t5710-promisor-remote-capability.sh |  65 +++++
>  4 files changed, 500 insertions(+), 88 deletions(-)

As I do not want to keep an inactive topic in 'seen' for more than a
month, I was doing my usual "sweep" of the topics, and found this
one.

I think I gave a review on one step that pointed out a few problems
with an outline for a possible solution, but I did not see anybody
else reviewing, and nothing happened since the end of last month.

Since the summer is a slow season, I do not mind keeping it for a
few more weeks in 'seen', but I can simply discard the one I have,
and requeue a new version in 'seen' when it materializes.

Thanks.
