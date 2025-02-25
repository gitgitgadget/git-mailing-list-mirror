Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7B1422A8
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502603; cv=none; b=AQc0OIk+EmSclN1j2o6CkEjCkeEoVfzHZlTaK56Dk1Ims423DixqgPl3Jdxq031ZnCmmfmNZ7uhCiANATHzTn9YghGZ+oNE3/YIdOpr/NUITN0/vMkFnBWj5G7WXiaut1k0/YhhR+8Z5keLXaCd5G8r2RtO2sVy+tnnFznQddBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502603; c=relaxed/simple;
	bh=yg8Dl4Fr+N4pRg95eH1LyvSwHq2SpDA7C0VYppsIJxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bw+2tUhpqtVuJIiDSWbp8e2w25aMmNa/2CGvQYIlrGzzGp7EwmxWCmIJeMwdIa9aLdIVBu9WDV59y7hsxJr8ovKSgJI2JneP05dlY8azUqCyT4ATlYfw8+labX1RzPrCWvR3qo4NUAPA4XCVh/CDzR23xxOJWxjVxUDpFM0iN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P/oN4wKl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5gTUt74Z; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P/oN4wKl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5gTUt74Z"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4DB551140104;
	Tue, 25 Feb 2025 11:56:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 25 Feb 2025 11:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740502600; x=1740589000; bh=EuZ7SH2Rqy
	8cZ7ck37y0hPQo1Y7r5XjPSKj5FOU3BbU=; b=P/oN4wKldlhoRcoKnKF7Jza/5Y
	Z39nYS28nP1Af5OcUMhsgtM0rIcaoNbgQjyZ76V4Prrm2NqaQ/KhoiOXuZRTW+3v
	YT0zmyaFb7EcQO496yAFHj8gkGNYiJijz5v0v071/RBLQpvtEPf1+r2A3vLJSuTz
	rafmP0qdYZ5LYoi7lWdUo7gnHSka1rTtmGFOuAL5enLBESq+LwADzMqL7RBiVy73
	XDQnbIvFiOWQDj/6OEHvE4z4znXEs5evFdzPa1o31dCM4ma/777E+WZba1+HBErQ
	a65sXZ2yRdCy1nfYBWwa3l+oTQ5aGs0De8Ed00mEnEkw/YI4sJBCRSZghr9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740502600; x=1740589000; bh=EuZ7SH2Rqy8cZ7ck37y0hPQo1Y7r5XjPSKj
	5FOU3BbU=; b=5gTUt74Z8ErmGeDe6baF8TYBEEXpxks1IKc2U6jFeF3Mj6r6bDv
	8rTfwe44kBVD1oWRpjpRryNM/954WWNhdVABSBcC6BzcyQ7m2yzQCN7mNTY2sTXo
	QcEQcxa/ZbWUjaAAzBi+uvs9I29CPJ6TFeyeYtcII7Ver2enYPFylI0imsMB30Y9
	cBL+IHOYMILUESqb1xQCKgY07K8k7MOFerH6v85CudkShAJAsAG8invYO8dOit1t
	INrRZJFf7mQxjuygGZzG1iDx4yDLgWJK0D0ZppUQXGWcJ4UrqW0XfeohhE/wWDaS
	TBY/eeqYNanUppQ1Gu3ezEvdD3g4LxIXB8w==
X-ME-Sender: <xms:R_a9Z-r48AYvjF6CVpSbZyBzPsHQbt615oyyhktU2mfHe93JYBcDFg>
    <xme:R_a9Z8pT6h-zSgBEp73Bi0CmlgoYKRcxcGKkL-BGJCmpARYHh0RNZVJMwB2FuSXHv
    UvWm97IRN98DEcGxw>
X-ME-Received: <xmr:R_a9ZzOBpX_86NprBzPalYDfq64zwXExhqZbXxDH2zDntaU8M5Xg1GMNvl537L32nNzyUPCVOapWq5lWUs25kNWSSA3zUbfuGnHq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgvshhhuheslhhu
    khgvshhhuhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:R_a9Z95Ac6XnUUZ2NYdq_s2j-Cm32WRnYp5ZUQFgFfVjksK1eie0Bw>
    <xmx:R_a9Z97WRYswdiOhhN5cG9JIGTJxnavhaxaVbeZa4zj707q36qdG8Q>
    <xmx:R_a9Z9iMViWQxhUC12mKp2W6lLTRnfdEa-z2D11kxilACzSLvGWdDw>
    <xmx:R_a9Z36ZIUIOmlV_1KNhRTXrkh4OLQHJUjKF5HR0kIaRI0uVu99hDA>
    <xmx:SPa9Z5iFiTheHWQDg4FCz6bqKML3MxMEkGMKZz-hEG0tM0seBCnCUM5A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 11:56:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org,  Luke Shumaker
 <lukeshu@lukeshu.com>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Taylor Blau <me@ttaylorr.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/6] fast-export, fast-import: add support for
 signed-commits
In-Reply-To: <CABPp-BHDx4YAjCqWX_VUjHQQ-r1iDbw7UcUgLXtt1ZAJjNXD-Q@mail.gmail.com>
	(Elijah Newren's message of "Tue, 25 Feb 2025 08:48:31 -0800")
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
	<20250224142744.279643-1-christian.couder@gmail.com>
	<xmqq1pvn6zvg.fsf@gitster.g>
	<CABPp-BHOvCWd6mMg0WdR4O5TfZS7TWtRCQCYPLnGpo5+jNHy5w@mail.gmail.com>
	<Z712Z0zGQD1zkdkZ@pks.im>
	<CABPp-BHDx4YAjCqWX_VUjHQQ-r1iDbw7UcUgLXtt1ZAJjNXD-Q@mail.gmail.com>
Date: Tue, 25 Feb 2025 08:56:38 -0800
Message-ID: <xmqqikoyklo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> This is also exactly the usecase we have been reviving this effort for
>> :) We recently hit such a case where a customer was basically unable to
>> use git-filter-repo(1) due to commit signatures, so we wanted to help
>> out and get this patch series landed so that the issue can ultimately be
>> addressed in git-filter-repo(1).
>
> I'm confused; this patch series doesn't implement the option Junio and
> I were talking about.  It only allows existing signatures to be
> carried as-is, as opposed to resigning all the commits with the
> current user's signature.

I read the "can ultimately be" as "this series lays the groundwork
by upstreaming what the earlier effort started and stops there. a
future follow-up work will build on this to add more".
