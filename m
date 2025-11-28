Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E292882AF
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348188; cv=none; b=k8tnEsMo9bO9+wtKcq3q1pQ2yIW8fVrNrurcTyECAhuGwi+KyWa8IQD9JQXUFet3rdXOIGWLbMTAJbHrArvquWv1JIwCvDLwfmt3CriM6mxnu8NLH37n81qPe5+KVmbFZLl929IJ7R78WkPwPsQemfM/qVHtx/kelSlDIhpojwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348188; c=relaxed/simple;
	bh=CVzfLrKO4wkW6QWAK7rWWb0WU9EpvG2LXxQGp6LgMZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qRb/9JVvCl5eEHpK3YG0jqtrF0eRiCNC2wtRJAWAjFNopJcRYNapJiarwpcWDu9jj/uAIXuw6zMsqDKxibK93mFoK/OJNhaPGXTnc+qjX89K/yYlHRv8u9aWkGas3e0FQBOKXEeu1LUwKcwJv5uIxwJTMIGaDiOK2s19I8GSN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GnwAJ40L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m0mzRBGG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GnwAJ40L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m0mzRBGG"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C789EC04C0;
	Fri, 28 Nov 2025 11:43:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 28 Nov 2025 11:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764348186;
	 x=1764434586; bh=NdKCKpja9ZiCMy0jPcnNnnj2y52rlfLzOmlshytbMoI=; b=
	GnwAJ40LiDWzqKY5jlW2lM+9WBRUtRk4HEqqhCCzwi2f2yI2CCSU29+NWFjbeJs7
	MvQvoerFvJzk05uGxocsbx+PM7/H7MhY6QK0+N+Z+UzlREKeLTkFTGKZMtcv4jce
	0E1R6eVhiuQiZKcdkk5PSPs66+nplAyQaLFRuEWp/r3PwHzygf6/TBQV82+RZTCs
	BwzvAnPq+fhinEgzXGRLe3BHBFLs6ptrhtGAGAIUaEw6n+mZwi9YC8mQN2ICg0hJ
	nZc9zuJz0LhRP36EjTHG9i+2UZh4kDlfC0lZADrtLEYJDKU0N+rgEfGSKSetfGGY
	eHMxHru9+ZU8OAFQ8rBRog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764348186; x=
	1764434586; bh=NdKCKpja9ZiCMy0jPcnNnnj2y52rlfLzOmlshytbMoI=; b=m
	0mzRBGGRrM8DRRVNu0ayfl9GLcg4deHZ+z5Tdx3iLsW0V1aLbQRHGDdkb16XueG2
	xOgFK9Sy7WD8bNulm74TbrrAIFLPBPVmp3RFyCqo+nbZR4HDAkTsuPa0V6QEFXRE
	YOIcLh9Yhdogk6GPWdOqoJkMXT6ryT0ktLvHK4ZM0PuTcQaIWYy78ioIV31dnT9x
	1dyjUBBDgb+16mnvB9VOU9JGXDInpNV73KPTx5fNtKLHU0Ah9k8vzzQFpwcqPTu/
	jv8YVwBLLo+ih6j/N0C8+ExFKH7YwZeIGmOAz862gvJBzeFLxHDJOv+VbytDbhgL
	AIskL5FQ7j+67eUL38RPw==
X-ME-Sender: <xms:GdEpaQ7JrUwI7J57qOn72TPYcrMb4EPuYtm3KZEJ7I-6Njv1slZ4NQ>
    <xme:GdEpadbBm-i0aCQxxIAVnVJK83GObgj9n5Gqi-G23wlGbFe0YOOg1J09u1y28QGr6
    90LrD8EO701Mz8BFcoJhVB3Nwy87rbcg9K1biN53olk9M6QuWdz6Q>
X-ME-Received: <xmr:GdEpaV72YMVhSofpA83_D2uSpSAGnFHOFfOWwHCoXqO2LBoAPrIWtmCRSfTFCQ1o-TM11M6LdPDDc_pBF1sBjILP1EDNmKTNgddL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhtvghfrghnrhhivggthhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GdEpaQAXX__3fe-ImfhBb5UE5wJxvmRSOCIe6yONTeZUsrB7F_PGNA>
    <xmx:GdEpabckI2JIRN4vKXf0xw4HFrlthOPYZ6pgEFnQHDW8HT2akv1xSQ>
    <xmx:GdEpafJT4Dxy6Vmei2lNNnn1svqlsxxQugs_LqpAC6WlFIC3Bs2j9w>
    <xmx:GdEpaW1reK0hKt2f7eE1skFYU8B5A6GDNaCnC4TpxBRVjpj0iM2J2Q>
    <xmx:GtEpaXYY0LzacsnoVUXk4oDmpWMyBWR6XPmrg8uRXrxEI33imr8gjmKq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 11:43:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Stefan
 Rieche" <stefanrieche@gmail.com>
Subject: Re: [PATCH] docs(git-pull.adoc): fix man page typo
In-Reply-To: <f66c3b5a-6126-4fec-9c13-e4cdd3043fa0@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 28 Nov 2025 14:34:39 +0100")
References: <pull.2111.git.git.1764335780515.gitgitgadget@gmail.com>
	<f66c3b5a-6126-4fec-9c13-e4cdd3043fa0@app.fastmail.com>
Date: Fri, 28 Nov 2025 08:43:04 -0800
Message-ID: <xmqqy0nqhzvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Nice fix.
>
>> docs(git-pull.adoc): fix man page typo
>
> Correct, you need an “area” in front of the message. But if you want
> something like “docs” it would be more typical/conventional with
> something like this:
>
>     doc: pull:
>
> or:
>
>     doc: git-pull:

or

	doc: fix typo in git-pull.adoc

>> Fix typo in man page from "git --rebase abort"
>> to "git rebase --abort"
>>
>> Signed-off-by: Stefan Rieche <stefanrieche@gmail.com>
>
> The `From:` (author) and signoff line should match. See `real-name` in
> `Documentation/SubmittingPatches`. Either a pseudonym or real/preferred
> name. But it looks like you want to use your real name.
>
> I see on the PR that you have used `snowdroppe <stefanrieche@gmail.com>`
> as the author on the commit. You can change your config for the project
> to use the same name and email as the signoff line. Then
>
>     git commit --amend --reset-author
>
> And force push to the branch on the remote.

Great.  Which would mean that the in-body From: line early in the
message will also say Stefan Rieche, not snowdroppe.

Thanks for a review.
