Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDA2F5A13
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321062; cv=none; b=TZ7+T7ay0nMQb0SkBmi80W5eIAGONboHTHp6iGfWBAqu3sBd70MnS2roKuIm9/61zVQAGXLE4/aOPZILpd5CetHe+gopvgkRow6eC5rhcLnIHkOkkaTM/ymfByY5LY4msg5/Bk8wFyt/E8hwZVL45IuhyHi/1vE3JWOxNzJMW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321062; c=relaxed/simple;
	bh=frRhN+ePgqKQdLOft4sel/u21vnEg9EoHh6aaLAwjSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bLkK24AD5Dp3YcDtv8RYkHynzpejHty91mi5nK6SF8giqwI6A/zV0VL/Tve7oIssW2g3JykzlsNZQrAexzxQS7Rmig1jov6uzujj737MASAyj45x3s52KWdCPv1krEaPLdOFbTqSQaY8fHmuMtICIOgRNPJS6n/VVXbTblH/Ft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NtIcflXg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PW3OUEwW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NtIcflXg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PW3OUEwW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA1147A00A7;
	Tue,  9 Dec 2025 17:57:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 09 Dec 2025 17:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765321059;
	 x=1765407459; bh=V+uLCtvLKG0tqPUDv1iV1XJrvQ1Z4DBKzT20d3MS3Eo=; b=
	NtIcflXglXc5nLCO/IrglDdUygXMCNcnWNoTaydEyu+6hBw2j+v5r/gey5v7tYbG
	+omvdxYrvA4FD1O4qQJiJNMs6/Wbf/2HuQ4tyAGLxQQ9FeVgDz3H/NyKHbfkva49
	G5eG0Pa4B6xJ1rGlCl/TBFMXJpbpbSIsYwhcG7aUWiAVrrnYgR+H+mbDtR0R0hF5
	cP7X2Ck7BWCxKfVrFZq84Vb6dpRWo5pqKQ/vZm1GDGlXKAbmgg0TAEjr18HsD6z9
	3s5A8lsqDvoLAflq0I68HgjXlldFSswWSqs0xtsSPIBWyJIp+MQ+g8JMA0r0JChF
	ElCNbQFqbEh1+IRWp6V+hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765321059; x=
	1765407459; bh=V+uLCtvLKG0tqPUDv1iV1XJrvQ1Z4DBKzT20d3MS3Eo=; b=P
	W3OUEwWRj2+Dw6pIfIgAYIibwwJnrGhV2Vb77+m62tt0YWP+a1VGM3ENVehWH8cp
	WFwKFfDQWtvVUBKAmdsuq1Pc9N1y3gerEaTGbJ+gqGGh1lfAcyeCw8LX1+meC7wn
	/jMqP+UlNZmd1xfkCRca8qUSXjrRzb+v8fNZS6d1uD4FPyvyHBLacYyyruMSqrVl
	mh3BvksH1pv7/nXUXpZFtT4sjL0PpjLi5gVnvND+Ym1WqhqAOVKfR5qfgPxhmP7p
	MhRN9y1jzj3MW2BGL0ZRXrbUT7IGSBjBpNxB4pMDyzGIUjOnj/ZYVyO7/Trxs+7D
	jLked6ZLebyGbxzNHBYhA==
X-ME-Sender: <xms:Yqk4aRTOJOnnBESrsLy5fBFC9o_UG7UsvK6mhdBPBHC7pxue2vKBYA>
    <xme:Yqk4aftrzrVqB6O8CbJB8JLscRXH9KOv3XJ-xz6WVzBOex6jXcVkSCAg4KMk64x2Y
    i7iSeaGRh60a61bp3jmpoXP-O99CvbYLyX12Bn_nIjQ7mFQkwE0Mw>
X-ME-Received: <xmr:Yqk4abGry5Qz1pzpTVVp2XN6AZHqsG1qPVFWSN59ntq5W1axRvIpU_I4GtPjEsJoCUZd1v_kFaK1ZM16X8-0lBk1sRWFVEnYLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhh
    rghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Yqk4aYzWxi1LNXY1pia_BT0QznQdpkzPrWk3GcK_BAdGy6L19XLDKg>
    <xmx:Yqk4ad0dghyhhaYnhkyjQad4G2peHnybVqYnTrJ2G0CBO36zedl0Ug>
    <xmx:Yqk4aQosw68-ZAaPN6YSvajPTJivJV8f2tBk2TjvUz0KOUdFHeCccw>
    <xmx:Yqk4aSX1iOi5CJHK-OTyRumKXecuDk6T4CF4hL4CY8D3wONGWLEneA>
    <xmx:Y6k4aSqQF4egqet5rewjvvSK6ot-3cl8SOh0v2gTvhE7_oIRDkKrHJg8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 17:57:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  "Christian
 Couder" <christian.couder@gmail.com>,  "Elijah Newren" <newren@gmail.com>,
  "Siddharth Asthana" <siddharthasthana31@gmail.com>,  "Toon Claes"
 <toon@iotcl.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output
 on conflicts"
In-Reply-To: <202f7015-1e7f-493e-bd82-474e5cefdf01@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 09 Dec 2025 19:03:51 +0100")
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
	<d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
	<7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
	<202f7015-1e7f-493e-bd82-474e5cefdf01@app.fastmail.com>
Date: Wed, 10 Dec 2025 07:57:36 +0900
Message-ID: <xmqqzf7ri7q7.fsf@gitster.g>
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

> On Mon, Dec 8, 2025, at 17:00, Phillip Wood wrote:
> ...
>> Maybe something like
>>
>>      Update all branches whose head commits are replayed. Requires
>>      --onto.
>
> Thanks for the suggestion, and nice catch with the `--onto`. Very
> personally I don’t like involving “head” terminology. Both because of
> personal biases[1] as well as introducing “head” as a noun in the doc
> (now it just talks about `refs/heads/`).

Yeah, I do not recall calling commit at the tip of a branch a "head
commit".
