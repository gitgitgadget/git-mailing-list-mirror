Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539E2236E8
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774110774; cv=none; b=caqXb+NoyVOM784TabsZ37PJ16Luaiw3FunD4EWpxVihDGtrNOGqGCBLWJCwOb3SMLx5oGwmgGB6HanBfAKEMemoMJqOEmkReWGGqeJ6W+M3k2AzYPcoQF36yvEktnc1oPkpapUJpK6I7ZVd5NjP1NGKnsowuF23jQdb+Ejaz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774110774; c=relaxed/simple;
	bh=xnB8IK0waJ0fELA0SvxpgU5yVTvsYytP815qecwOqck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JeyXX3fI0T2rQ7GxXXAtieWTub4QJey/ZLIi/CKkPINSE2/lx4c0dEG9xvlaqtPuUr0EPPzjlyqELHu2k3LEa1y2YHsRY+FCJ4nRH2YIqOF1BjiOa5QoLKnV1bzRIbiF/fn2VeNGJb5OQxWeTjLpOgTKcRzleHsH/FhIRdC/Ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qr5vskJB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9UIps/Y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qr5vskJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9UIps/Y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 604867A0011;
	Sat, 21 Mar 2026 12:32:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 21 Mar 2026 12:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774110772; x=1774197172; bh=xQN174N/UB
	hJnmW4cAyYsiJWewlr6fghnd61X16v86w=; b=Qr5vskJBrvW69lc4/GERAfFm8p
	BND0ZRmge2tMf3bID7Dg00EalJT/fRBushq/96d8e9qWlJ7a8Ypp/DOH6+iHw//B
	G4oylf1H3Xg3QXGbbqTUqMD/yMKgSFWIlGDcTyvc5fO/niHarPlRKnaJtYY3Ojcc
	DDLwUgIY1aahUDfTDgETmLl/mGuTl1rUlmAekNA7ssllje12vYMnTnKdURLvdM/5
	SY6lWbCTJ31OaIZi3lWWSBxCM4TWUCdQzRE8OeOr/QiIgTKlnL/Jbu7DzINjIdOL
	cRH3F9WSVfmGwNt3Q4bmWmn2ZaBMTkiq0jyBDtkHdrFfWWzTbcT/YxMuGAGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774110772; x=1774197172; bh=xQN174N/UBhJnmW4cAyYsiJWewlr6fghnd6
	1X16v86w=; b=J9UIps/YKL4PazVmCi0rIrZFzi6yEnyRYYwHVcGJjZiYlrqgr3j
	5TKVOlCHi0olCmA5LDDPyF8cj97gbc0Rs5dlVk/vOAnI/AOn4Lirzl85iXY8N/x2
	coYNWmXbvpODGtD65KvtNXKuA2wLSA9oBrwjrwhxhuHJgeT1/v9CA3rXBr4CWZCu
	QD7bHXMKDWkJSCsmXZ2O+JAP1aMPMSR7l5nuYFagoUqc5QezuqjTy9/TrXERKWC4
	oT75+ZrwfB+PaKs0SNVIlchVtLGmTf6qFkP6A17I/LVc9krNpw7hdUcJlQKukFZ/
	Dkz7QLZXV0uH1bW6lrSnHrudS5ep5HFIOFw==
X-ME-Sender: <xms:NMi-aS-QcMzOXHiqpV-ne7O7KRP5ZcJge-sTSNVfp-l10uAT4gRc5A>
    <xme:NMi-aRyZNGn0BG4CyU9xF4z5c5vIP8S_L_eQ7Ge-n38baPDiHfCPL0-iKftH-yixb
    Kw4NIXu6eLVDR76SYn3MUdIjY08Mw2XMhq0OE4_xhYGiF1KJDk>
X-ME-Received: <xmr:NMi-aeMWUQ6PZO4Fmz1g6ztBpTrV-e62oje-Ef-i0sUeOAAfLHJcuv2sFR6YDgkWjPSGw3rAZrUmfbfZPVBwg6C58zvfPq69cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeffeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehfrhgr
    nhgtvghstghophgrphgrrhgrthhtohesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgihuhdrtghhrghnuggv
    khgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NMi-aW_OQ1vDkbJ2cZUM5Ug2GLJzKelKSd0pNovhDy5jurRZIA0cYg>
    <xmx:NMi-ab4t6X8mLymeJnzHSuPz5CM3fj7QgcWTixemFjJO6Uq3Uph-Gg>
    <xmx:NMi-ac4rQcWOz7YaNOvAbunz99bdzljJb6kVDQWZwNN26ttdUVI-6Q>
    <xmx:NMi-aUoLxhIEt5EQFYO2RgBsfVpnoGg7qMwlVw6QX8i6ZUdPcOxLng>
    <xmx:NMi-aXjjcbg2S3zHQ8DLKVoojVZ9ULKH-yd5OUtt6mRSb72rT1Zcsey1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 12:32:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Francesco Paparatto <francescopaparatto@gmail.com>,
  git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  jltobler@gmail.com,  Siddharth Asthana <siddharthasthana31@gmail.com>,
  karthik nayak <karthik.188@gmail.com>
Subject: Re: [GSoC Proposal] Refactoring in order to reduce Git's global state
In-Reply-To: <CAP8UFD1H8ZsxfGSnnvX9xkKLSSpDjA3e3KNZ7eHN3ruq-sC7fw@mail.gmail.com>
	(Christian Couder's message of "Sat, 21 Mar 2026 14:36:01 +0100")
References: <CAEaT9_9jAoXkxKn+2+q654aKybC1=bk6p7xiVHmcy+YDDe7GXw@mail.gmail.com>
	<CAP8UFD1H8ZsxfGSnnvX9xkKLSSpDjA3e3KNZ7eHN3ruq-sC7fw@mail.gmail.com>
Date: Sat, 21 Mar 2026 09:32:50 -0700
Message-ID: <xmqq5x6pb0st.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> * [GSoC PATCH v2] t3310: replace test -f/-d with
>>   test_path_is_file/test_path_is_dir
>>   Link: https://lore.kernel.org/git/20260228005939.9012-1-francescopaparatto@gmail.com/
>>   Status: Graduated to 'master'.
>
> For commits which graduated to master, please give the commit ID of
> either the commits you authored or the merge commit that merged your
> commit(s) into master.

This might be way offtopic, I know, but the success criteria of
microproject being that the candidate has learned to effectively
communicate what they did and interact with others on the list,
it might be less work for both of you to drop "Status".  Whether
the resulting commit is in my tree or not is of much lessor
importance than what we can see in the exchange in the discussion
thread.


