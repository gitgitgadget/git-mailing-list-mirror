Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9A2905
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352936; cv=none; b=eFuO/7vl1M4WsDeZFdcBVUmDUDdWZmhWUVFq03iIFFMFre1qssJ4FcsLW8040sRHKnKEguVCi6yFrtn5Pi2rkQuyoW8FHI3FogNSNozxDs32rQ7ciiMCgVy7VEIy6rbSsLqhb7mzlPLOCGpcddZYc6xY8wlU7SBbxZxMAfPZueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352936; c=relaxed/simple;
	bh=rGKTNdK2Ajn6KQm3wHkhKEa8dOmmcLKQ/E/QpyxEs6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+FA+OmNNfgcwkcSVJGi4J97FVupHd/ft3DFsO7zf1d2WnDNePhF8gPBMtOemNfc8GO+eiSr7cLHhmpFZfkDH0HCQ5CVor6uJhsJIvqTrGdRGySY6WsKeEYA3Dhq0ZmYycnsE4ZYdsg6Towst7pvaErLXzGooCjMiIwmZBrh1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wZ4xIax9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GPP8rFYN; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wZ4xIax9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GPP8rFYN"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id CE213114010C;
	Wed,  8 Jan 2025 11:15:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 08 Jan 2025 11:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736352933; x=1736439333; bh=+Swdguks0J
	d3SDagXePik9R+8Gt32qSzyLCp2qz9h4E=; b=wZ4xIax9LlUaCvGVhYotOJppZ9
	lWL0bwCYo0RC3e7POHDaZ1kCG3h6+V7P9/+fVHSmU80LRKIU/xKNh3uE8H6MSGsu
	qI2D/re/e5lew3iho6ASXlIgAcDGC/F8aKVjM4fyZiYQV2zQqLf5JIaAZulo88Ms
	SHIglE1Wxx+w/t+xlzZi2chg9v/ZmKKIO1URWv3G3z0LTUE6pPdUWf+MWC62Ijm8
	pJLFNEhCsfV/6+nyzYYPzksrEAbpL4EdHAGT5iIQX5gptjwiupJByIv3jeJMyjXC
	9TEmZYX6gV/qLPqto1y1dqQ749ZjZmEqkwR1ZQ85VcHuyNmxqQezZL/iEEIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736352933; x=1736439333; bh=+Swdguks0Jd3SDagXePik9R+8Gt32qSzyLC
	p2qz9h4E=; b=GPP8rFYNr+bstn6C2IwKJF8MLLTU7oYn1aDCq2EuqqZG7QRdp8G
	CFeohn+4fbddZOmSQ52Z2gk5V1JE3FJHhHRQOOcKN8immhfkCWrlxUXyUaLXaqml
	1NBp+KPGQQ9lHMEueSZBRPmAM/V5GgO+QbDVQMjb5zsVrVAtwyJBBdOGjxfvsjyi
	xu6WY3RqJWuiRp2lJxtojupkSvrcK80p+S28ph4EkIWiKA7PIgZFyOHPt6BFPUzK
	rm2EG4Iq7gzWd5YbgzSfzxRITYosskgL7gC+i7yj3k8zeTGrFbLnZ0Gyh0WFit8b
	xpL36HKY17e/XEohIk1M04p9gEhUBFq+rMQ==
X-ME-Sender: <xms:pKR-ZwEYqMNEhimEBBNOTDOOqX5433f1s8Sf-TMblEr8l9M9lpOPBQ>
    <xme:pKR-Z5U6BZscziBOW0tgARTobfetNfq9JgXvjn2Txr3U9P4yh3U2cwS4rHpvDOCd7
    dmcyK5hCklSN7kFHQ>
X-ME-Received: <xmr:pKR-Z6InmOIxgqV2ICSoJt6S9vk7v5SGidt8-Odm_WS2Kae2M_vPQKnhkfbroUV8nrEl4vuk-miq6dCkp4i60x0W-2K7-MeNKaAP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:pKR-ZyHYn3hUk9SwQ7Z8RINj5my5Ncp82lBxOS7LmJaojT6z_1pe5w>
    <xmx:pKR-Z2Vw7BDIHQoCv8UI_Rl99cnazIBqzalx2U5qRBQ2qL6ICtQoYA>
    <xmx:pKR-Z1M1qVXDaf07b7KE-eGIMojsrpn3ah1C0eh1H14NKaqOLn6ZWw>
    <xmx:pKR-Z93XFRTYzTsy_7rmmS5aPGkqs9edj0ltpDrAL10EsEUhBdVgzg>
    <xmx:paR-Z_PlE4OTsw28uZbLp5pXqyTdPXKmjmgCtu1DWagdFrYQYxldyUBJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 11:15:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] connect: advertise OS version
In-Reply-To: <CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
	(Usman Akinyemi's message of "Wed, 8 Jan 2025 18:36:28 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250106103713.1452035-4-usmanakinyemi202@gmail.com>
	<xmqqfrlvzzcd.fsf@gitster.g>
	<CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
Date: Wed, 08 Jan 2025 08:15:31 -0800
Message-ID: <xmqq1pxdnuxo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> Is there a need for a registry of canonical os-version strings?  One
>> reason why you would want this user-settable (as opposed to being
>> derived from "uname -s") is that a system that is presumably the
>> same in end-user perception can call itself in different names (your
>> Windows/MINGW64 example) and having the users set it to a string
>> chosen from a small repertoire, the other end would be able to
>> identify them more easily.  I do not think it is a necessarily a
>> good idea to limit what value the users can set to this
>> configuration variable, but at least with a published guideline on
>> calling various types of systems (and an explanation on the reason
>> why we publish such a guideline), users would make an informed
>> decision when picking what string to send.
>
> We plan to implement another config option `osVersion.format`, which
> allow users to fully customize the string sent to the other side using
> placeholders,

Sorry, you lost me.

I was wondering if we want to (informally at first) make it _less_
flexible, so that we can prevent people from being "creative" when
the value of being creative is negative.  Adding even more ways to
customize the string to subject the receiving/inspecting end to more
unnecessary variations to call the same thing in different names is
the last thing we want to see in that context, isn't it?

If you have "any random string goes" configuration mechanism, it is
pretty much game over.  You do not need to add an elaborate .format
mechanism to let users throw random garbage at the other side of the
connection.

>> > +# Trim and replace each character with ascii code below 32 or above
>> > +# 127 (included) using a dot '.' character.
>> > +# Octal intervals \001-\040 and \177-\377
>> > +# corresponds to decimal intervals 1-32 and 127-255
>> > +test_redact_non_printables () {
>> > +    tr -d "\n" | tr "[\001-\040][\177-\377]" "."
>> > +}
>>
>> Just being curious.  Do we need to worry about carriage-returns not
>> just line-feeds, and if not why?
> The function `tr "[\001-\040][\177-\377]" "."` already replace the
> carriage-returns with "."

That is exactly my point.  LF are stripped; I do not see a sensible
reason why shouldn't CR be removed the same way.

Thanks.
