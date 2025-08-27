Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940F2E2EF9
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320958; cv=none; b=E0awuTUBxa7RTxUpdOGq3yKJcjb8jPz7TsrmBRzOcIpcZL/w+gZwpnarp+3JQ/weza4rGp7Dsoxi2aj4HPH/H3lrl+oHKcZOQ6XlO8IUpgiYYL9viAd2Sly7OfXYyPx0//F4BoFzmFfw3kKGTew4/w4I3noxr3Q8punggPHxWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320958; c=relaxed/simple;
	bh=SemNQ9seMJEe1+tbPfHn6prXTqR4OzEAobCMYVNHJYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqSv0EK236y2TOhABU/RCd+Q5+GLnrklPzq6T85KOxuDEnA9rGTObU9zLV9KQoDverHsWDTLDBACChWMr+/xgOCkZ5/mQUED3aUO050dyTSug8BZCnwdtPET23B/ZUtGaqr1xD0Rw5WyeOg2kEBAEek6GJ5t4u/nl5co23AuV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JpNYN+s6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMiLFpUh; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JpNYN+s6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMiLFpUh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B56DE7A0183;
	Wed, 27 Aug 2025 14:55:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 27 Aug 2025 14:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756320955; x=1756407355; bh=jiNEXExEpt
	S0wApWeE7uJKVn8CbpLc/DE4pFggl2d7s=; b=JpNYN+s6gEIy3Qy9nU+PwMjdfW
	QvWJjk7Z1m2mWlEOE/McXIB8E4j7gnen88I65d837L39v66IgDWf7ricjov5ynkf
	SIXeHi/hxdQSrRe5ShBkjapWVTKvfTv6yMXsRkXmv7P1jiQ6UY7kiFGZ2tMXdW5c
	MAoJj+HRCLOdRPrtobXqN3GfvxZEZKSAUVTTRq4genZp+eJR2pZzun/Kh1+zlD/a
	Dtw+JEIJgc1uPuOKlXPGDAy21Z8spP+W6ozTjblYuXPINDGiESJ8R/xyFoQOyTWT
	Zdn1ww6lAbsZyZcUOGXzLAQxHVFBKsAKbf3+OTngzVE+l3A5dB5fhcgcjOXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756320955; x=1756407355; bh=jiNEXExEptS0wApWeE7uJKVn8CbpLc/DE4p
	Fggl2d7s=; b=mMiLFpUhVZ4xi7p7w0JAiznp92CkMjxHM9jHSXYPEIYzCxkvY3S
	TDLHZpZ6V/TTto1UyR05CFgeAhSFCM+aWCmyWZbDbW75hn9PQ3Ud1jGpvAdOQRtR
	UdfQXMjUVKDsgzE5YZ8i+kpsDOo+eyo9CJZJplxHpDw8sbtDdkIkKqFSgEfuNaep
	1AFe++L+VjbJLi23fv6qWAHoA/CHFo9OKhKuo+sx0LmM3/WkG5yKARENSW4i7l2l
	zdRV+hgSQjSpksNdK1ZmUviiSVFeQNO7LG/zbH+FY+GsluGo2/nULkmvLOqtPpUY
	VgmQHf59nckRPpGJmZxAsTFuwm82f9lDw1Q==
X-ME-Sender: <xms:u1SvaMzt2zEVy3qzSiSQlMZzFFJgM9e-ZJ3R38DR67uLKDbiah1klg>
    <xme:u1SvaN1jnd0P21jUqkCZ5E0LH7D0B2xJD21W8MeiA0o1nQ0yezwZrU3fIjrFj4vAo
    txc_AwFhiMkW93OgA>
X-ME-Received: <xmr:u1SvaEyBJwjAX2890-bf04DofWE-AQHnzK1kUZOuzq27kEqa4ykPu9Hqi2rzdUtbtE_3wHYgBsYS9DcqnQvczaIKWEWqJRtlZFtGruM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:u1SvaMEpwVjfn__WDeHkFQGp2P_GynTWnuDDQ4NH11PX7MiSdy736w>
    <xmx:u1SvaPaM-4MhzpUeP1rZfMRvN1ilXekHS_3f4ejWjpxW6peh-XfLdg>
    <xmx:u1SvaGBkYu1727rtlesEb01xArkX6gshLAz27v8tlP7tPKmrUknFzg>
    <xmx:u1SvaPn3-88pfUiSAP_QqId4aC7-dditeJoP-CI0r-C9y7kbi0mMGA>
    <xmx:u1SvaFVbY1sL5Jv2zsVRS39zO-7rqZjgXLCjQ6rd6SLYlmUdEwwap728>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 14:55:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 2/3] config: warn on core.commentString=auto
In-Reply-To: <90a1f901-fcce-4275-b1a5-8ed50620f50d@gmail.com> (Phillip Wood's
	message of "Wed, 27 Aug 2025 16:29:35 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<cover.1756215326.git.phillip.wood@dunelm.org.uk>
	<5dd897c95e680c4e3f26ec3945fe649b4b61681a.1756215326.git.phillip.wood@dunelm.org.uk>
	<xmqqldn6krmi.fsf@gitster.g>
	<90a1f901-fcce-4275-b1a5-8ed50620f50d@gmail.com>
Date: Wed, 27 Aug 2025 11:55:53 -0700
Message-ID: <xmqqldn4zj9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 26/08/2025 16:52, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> As support for this setting was deprecated in the last commit print a
>>> warning (or die when WITH_BREAKING_CHANGES is enabled) if it is set.
>>> Avoid bombarding the user with warnings by only printing it (a) when
>>> running commands commands that call "git commit" and (b) only once
>> "commands commands" -> "commands".
>
> Sigh, I removed "only only" which Oswald had pointed out only to add
> another repeated word. I've just sent V4 with the typo fixed.

Heh, I've locally amended so no need to resend.  I'd rather see the
"what degree of help would our users need, and is it worth trying to
find the (impossible) definition of being 'good enough for most
people'" resolved soon so that we can move forward.  I'll read the
series again, especially the recovery recipe the topic would give
our users, to see if my stance would change from my previous one.

Thanks.

