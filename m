Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D91E51ED
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905667; cv=none; b=pHv1kkn19ecV+sD+e6+J0CCAdu7pBWvQhg70zR54F4N/RyEJ+7gPvCb3lK+otCHK3yXtXP4jox3lBKQc9hyJirMwrMt9LhJfhnZTX/VZ65qlqIUEJnLJlq/7agQ3iZJ/BXAQYNv0hyvdlbiuzN6GXGNZzmJZP5398HEeclDhst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905667; c=relaxed/simple;
	bh=vimcdZdOjeAdS/L8ojbWfh84t+A4aKAnEaoftP6BHto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RRYKDKIxtGf8qQkVdObpEPKgi1CYVCcgq2CY8CJfloQXWCKrrNbx/oCe4FaNYIxTqFwAGnZKWv80iRqKcP80uDf2oohsw+fCd2biXZfhMp3UzhGYPDtJy3OTRkU2nHUc5HRbUI+js9hyl6Xsw81FTt5SBsLfxSlw7+ksiaIcDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UX0SW/4j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uq4Ko1vt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UX0SW/4j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uq4Ko1vt"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB088254015B;
	Tue, 18 Feb 2025 14:07:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 18 Feb 2025 14:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739905664; x=1739992064; bh=ktlcpxzv99
	bW4GNUrjaHoDruQBHU0xOU3kyOkrIhqQ4=; b=UX0SW/4j1YDPucri+FgDpU44O8
	W7bG+bgTtSk2jUa67V5TwLKcE/yapcV2fnq1MVG8m0oENZs9+wx0nj9FuuYd1MDX
	AhA1BoWDSYGvYBHzoAEzx0SZpYgyN7T05t+lZZ1dm09Gd9bIawrGoYg3UNtuxC8J
	TElmXR9FhI9a9/XVP/tQA3+EYkQX8YkcVdQvWEKzTN83A9YaE+uSDnOROQSzXsfi
	FPhFSsdL+nkUj82XMqay/mTWt6OXs4l94+4a+u7ubdsXNfSM1kP95uqOVylDxorj
	YmSEedmaS9ToNJvtsM9UNUFcB7GT7xgLGqTGctn753xI3+fqUttdoLEJv1Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739905664; x=1739992064; bh=ktlcpxzv99bW4GNUrjaHoDruQBHU0xOU3ky
	OkrIhqQ4=; b=Uq4Ko1vt8yQMEiGNg0BfGQ7cqm4sK6hROzlASG0lIDZqBGusMOr
	nV/+uLmat5lJxx+fVxT2arOl8Hbt924STHRIA0DL6EWny88iR13pZrM7bkPr1ZQ4
	X+SaB/LCSMMXkg0O/voug6p4aA7Be+8Y81mDIU9en7V69yvX4Vbu80qRiHmgh/vS
	ODESHBBd+fPCSzXqJTBbyvYopgBH9oudjKvvN5ImzFszmDJmjvXSgERYZv3w3UqI
	seEsW9eTcomQugVG0ZNhyjjiHGsUMRj7PHHDN55o8H5SSonLd/A924GcyRtlUJeQ
	VKE5/mMIpo+z6VlU/BqyzKehmVF31JdTdIg==
X-ME-Sender: <xms:gNq0Z522x1KmgId6ZZ01XoLpM6PBtjeKU9937_U4XUPXMyqAlIzIYQ>
    <xme:gNq0ZwHry3O8jJ2dXutfqeRrDcNmAYwNprrN7vWRwiSWVHhHvOWCBSe-EiIU9_KPX
    DOFruDpkaP_yW7CSA>
X-ME-Received: <xmr:gNq0Z55NQv1Cg3RkY9cU7ovZW-Pyh1xKlE9OabET2PJ4rocFII1sKSkvAPRFVflcgD21IkMkWiO54neUxIjBw4Iz8BRrv1jb_kpWZpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhi
    ughgvgdrtghomh
X-ME-Proxy: <xmx:gNq0Z21sgj0DF6D248HXVtdBiif0fl6s3YL7VDU3aQ4k6os3mtRb1w>
    <xmx:gNq0Z8HcsRQ8Jag2HvK25Lsu30zLGoiW3-4ji7JRMD96YbDO4OQ5Lw>
    <xmx:gNq0Z38A4_wqPTIaUmjE_v55ENb12WmcsIXe-ENy7DL01wfzZ_GNpQ>
    <xmx:gNq0Z5nhyqjST09LzSED15wPHtt1D9K-FZJ7tujwdKFT3u9DOLo22A>
    <xmx:gNq0Z08hvZwcRLMRcmW08gO1LuDq_u1EJSZbEwK92z_jby-PuTc4_25p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 14:07:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v5 0/3] Introduce a "promisor-remote" capability
In-Reply-To: <20250218113204.2847463-1-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 18 Feb 2025 12:32:01 +0100")
References: <20250127151701.2321341-1-christian.couder@gmail.com>
	<20250218113204.2847463-1-christian.couder@gmail.com>
Date: Tue, 18 Feb 2025 11:07:42 -0800
Message-ID: <xmqqcyffkr5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Changes compared to version 4
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>   - The series is rebased on top 0394451348 (The eleventh batch,
>     2025-02-14). This is to take into account some recent changes like
>     some documentation files using the ".adoc" extension instead of
>     ".txt".

That would make it easier to work for you and anybody who wants to
improve on these changes, which is very much welcome.  The topic is
not a maint material to fix anything, so the rebase is pretty much
welcome.

>   - Patches 1/6, 2/6 and 3/6 from version 4 have been removed, as it
>     looks like using redact_non_printables() is not necessary after
>     all.

That would make my work a lot simpler ;-)  I had to juggle the two
topics every time one of them changed.

Will queue.
