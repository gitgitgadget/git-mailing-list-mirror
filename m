Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790D215077
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047093; cv=none; b=FlLXECiXO2PRSy6PLafEKjCAbbRoVVRFHkH/pY+1uEIoLJeNve4XTIjn9Y70ykaSJcdk9SZLGi9sikiI8PncZrMepasMWZ/dbFB4vcnrRLy6sUwQTQ2hCIJGE3Zjc0BaVxO3Lf5b2vSsByVtm5vA4kkX5bvATvt84WM3CK2oHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047093; c=relaxed/simple;
	bh=8/Om0eXDHFVF4qWjWiEO2N5NbIeOdOeVaW4Utz4KQis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LUd0d9ohjx2u7OK7D/RkLDklgOs882rksEORImJ88xIup7isCOk8lfY1LHNy+cuD/1hO2PXz+gU+Oq+D2wd9cEKMyrYul4dyLHik11tmRbbKKutcyAYmHkon/0RJ+AhgEz9e8cjWImeOcOgT7fWAXNoAvFbhY+mDoWG5yCD0v88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XEwNJcOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r01IFhue; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XEwNJcOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r01IFhue"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 449E214000E6;
	Thu,  9 Oct 2025 17:58:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 09 Oct 2025 17:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760047091;
	 x=1760133491; bh=8/Om0eXDHFVF4qWjWiEO2N5NbIeOdOeVaW4Utz4KQis=; b=
	XEwNJcOw7U9USHjLyNlXOMNx6MBO19wggGuNVtTI3kf7l1IrQlwaW2sa0JHa3QqQ
	saNdWyvJPidxEAFv60cvkzh3KHZHVvo3lYFQZ06Pb3yt3APOotSMS5Hra98hBD4J
	hnJ5XMU9QnpAKi6WFcYqWTpq5yDqXy53rJG3x1kGoYF0gkjKFdDC4bUkEnQbK9Kn
	SXHM0NuBIFIRg01p9tAFqUx9UVIsDL+kwIJMREw0Sgk4ZqFvbs2DbOe1IZl7lsIU
	legMAjBBrDtL/o9cTB3hNL0CZUNNhl5iqGA6Qidk5HiKJuMbmks1NCUvlmyts7sw
	N72+isuwl4udhtyjOwSJFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760047091; x=
	1760133491; bh=8/Om0eXDHFVF4qWjWiEO2N5NbIeOdOeVaW4Utz4KQis=; b=r
	01IFhueFVH1+bfcemNHmGdm62maIZ6RuFZrN2G06Fyal4KD8mZ+w/y7sf4pT+2Io
	PY1DsFmcJkJ15ieh69yLPMphvXd9WnfGcgPqNQlG6OsEz/5Pc1kMRb08rl9lXgfB
	/WLPZ7kQ5RfZJNcCYpPmfwEwvG8N6bGaNYDiC4z92uWNiLt953YFLp7gmH8OEmm7
	8h4R9y5o6etxnhJsDKI6yo6BjExjsxCqSlCHcykqLB6F5q16xXazG+L2v5Dw+9U8
	ZOOfwFdXORy8gjn9P90rvOa4rqCvjMZFwUFzlxXmH26feO5cx67UUjILu61+Ehle
	SMmFm/8qJYZAekby6tl0A==
X-ME-Sender: <xms:8i_oaED7S5xQBrssrcz9OoOOHNtwddyYwId_5JP3Pxifgw9BtF3NkQ>
    <xme:8i_oaP3pAtMBXtFMfeYFAlOvMVlktKzFmwfXTkeUTVEExXvTugdAq-0AF9C5dKNsr
    ZA3qzC7Mrx0mmHA_JhU62BMCVuQixMTV3aOGwNlNKZcQNGxgISBPgE>
X-ME-Received: <xmr:8i_oaO29KPiPbKGyssp0mxyVyJDt3jVYjMLrfT9Yp4SMgr1xhSrPrzNPN4A4pA4WZQ2-fb3V3cu3gG9goUHH9RrVMS3dZh4S-z1O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:8i_oaMDqp2_wYkPzjlyi4xt7cmKYDCv1YrD8o0QH7PQjMo8HMSghow>
    <xmx:8i_oaF7qb17Cna42ax1UYm_P0UuYkseouCQcLfm5gUeIWmemWEAQHg>
    <xmx:8i_oaFJCrVNUEkHuuvKq9wvrDK6b-UmEYln20-991b-JPwDtEpxhXQ>
    <xmx:8i_oaOvENnXKLfe5g_d13jifZaKe1efvS6IVBxlms_l7RKnjM1HNEw>
    <xmx:8y_oaF5p4vcErOHvzUCIjPPo8qP_Cit4DQ7qRWzOyhqBnsI2veLKtc5E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 17:58:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "Phillip
 Wood" <phillip.wood@dunelm.org.uk>,  "Johannes Sixt" <j6t@kdbg.org>,
  git@vger.kernel.org
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
In-Reply-To: <91ddb8c2-ae3a-4b13-a23b-e5cca172ee09@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 09 Oct 2025 22:47:00 +0200")
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
	<d17060d9b72.1759952528.git.code@khaugsbakk.name>
	<3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com>
	<aae39545-461a-44f0-b01f-bb40b53b1858@app.fastmail.com>
	<91ddb8c2-ae3a-4b13-a23b-e5cca172ee09@app.fastmail.com>
Date: Thu, 09 Oct 2025 14:58:09 -0700
Message-ID: <xmqqjz13d9fy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Thu, Oct 9, 2025, at 16:31, Kristoffer Haugsbakk wrote:
>>> We should maybe think about deprecating it for "git rebase" though as it
>>> is a lot less clear that it is sensible there. If you're rebasing a
>>> branch then there is a very high likely hood that the upstream committer
>>> dates of the commits the branch is being rebased onto will be newer that
>>> the author dates of the commits in your branch.
>>
>> That makes sense. If there is no use case then it should be deprecated.
>>
>> I could mark it as such in the next version.
>>
>> Anyone else have an opinion on this?
>>
>
> By the way. I thought of adding a stderr warning when using this option
> on git-rebase(1). But I don’t think I’ve seen that used in this program
> before. If so, why is that? That’s more in your face than just adding it
> to the documentation.
>
> Is it about people parsing stderr, maybe..?

Standard error stream would be buried in other progress things, and
it won't be seen if you are "rebase -i" interactive, in which case
the first thing you see is a full-screen editor with list of
instructions (where we _could_ add new warning text).

