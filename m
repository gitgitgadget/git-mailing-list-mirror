Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF111CCB39
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804085; cv=none; b=MB98yGMLSE/vy9tczhh0RBYPblfOwHj8dmfMQAXRmo1ttBMs0OUT5VWH6o83DURPsIX7irlL8ai0uWMI+vRrHrslbJrLHMi8XHKhpzOopuS35bPgSwGMoFbSqqdp39YVxgE7BnK6bKEwJgMRLk4TtWjYpufFKruw0VfqioeWHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804085; c=relaxed/simple;
	bh=BZEZ4cSM934CCveLiCcUOwokIkvmrapkTg3E5tWUG9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BLQSDy4yTj9KHL9lxLa0fqPGq07M+1sRKttY6yseY4bkLHEuj2qsCHfWqbuFC8rr1KWSVGGjGNbBG3eTu6sMFBuV03ZI/b9VlDjDJEboSz+hpS192Iouuf1G3SZzyGcNvf0txNE9SP/JtussTv0S1QKyJcP31xdqa9cJo8OTJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i6Yn73tU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A79yQ2VJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i6Yn73tU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A79yQ2VJ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 610951140C00;
	Tue,  1 Oct 2024 13:34:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 01 Oct 2024 13:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727804083; x=1727890483; bh=nRcArctblu
	yQm1GpBqr/f7TAWSeE9hEL6EoV2XU4/0E=; b=i6Yn73tU98wEHeLICMb1HOulQv
	wf5chQIsCaOXC6UOGbQNZL/w7JPiacwjS6iugKTH+bAIczoiXGbaPKgK+DNbsqp4
	Ic7XiOXAqbGvnc3Xmz60gZ+O4OBwI7ItcZi31DJQp3S97rigq2kJoKfz+f2s+7B8
	0IH7Rfk8M+Tx3VmylWXVmOjfcP1F3Khn07u9cfzQK/NlhFhIMaaj/1sGYTzm/ciA
	SJ7d9FKrdfLyufCoUNUcIUs64MPZSrO5SZr+8101Axb3m012rpyByJhOvA5rXIdH
	Y6GhJ+qgixFZi3W9rnG3RMLOiNM1UwRzKONitMJFp5+HlbXdR7dTsbml7cAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727804083; x=1727890483; bh=nRcArctbluyQm1GpBqr/f7TAWSeE
	9hEL6EoV2XU4/0E=; b=A79yQ2VJv0ff+PdGiFaSLIAZYjWjskJfKEL7YPkzzkdk
	YuBbQONp8DDC5WjT/+HWvKfLzIFQ7d76BRRoq6y/cLR2Z8nDMBumIJuzbSrd0MUn
	KGln3LosidMwoin0FBG+RG2tKJ1WBq5Z3ZTWFVp/N/ONyg67nUYWQlFJvziD2iPE
	R1gesxq04a/14N6oZOn/jMpEZ+gcsWGeC3fxojqGjhSntcsME8baXem/QCisvCs2
	ifZJCoyCu6n6GNBEqW0Dmjm1jqP9Af6YuuC0GLkfUbCy6JX5lWIv7tP0C4/6XuH7
	CAuz55FcLVPQgBZnBDwJ+X5Ln2eRJcJuRw1AD3jSFw==
X-ME-Sender: <xms:szL8Zr6NxG1cbs46AvnZ44N4H4SSKMpXG4Q67YT2VVkbSbcqrjLPjg>
    <xme:szL8Zg4qJwvRlWLlBUMrVEVPMLHtE06qKmdOfcNK1xK3GjUKHSPsZVaA5vtljx0vG
    8lBmYTlDexz1-LItg>
X-ME-Received: <xmr:szL8ZifUvc_2qjN_2JJZsN9dK1nvd_YIpHFoTe7A80cmBOPKGnUxNqOej_Ka9mu4u9DuBZhUbRYzQqx3VaKRVjjEB1ewbQYxMinHjpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhesmh
    grrhhirggusgdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:szL8ZsLKRauGsFKqUg2dViqVV14lH9M4GG1AeSctTicS_09U6i2NWQ>
    <xmx:szL8ZvJk_QMmn8GvsnaDb7Jo8lSnjElJO4Aa3i9xBdq19lXxXe6Ykg>
    <xmx:szL8ZlwDlMcgOJHVDYoFZdXz6_6M1byq7j03Ltn7nshjoB29v2sTBA>
    <xmx:szL8ZrKnd0hZewGUyWURK4j9hq9TinXNgCpMIBnwfdaNWJdX1g__Nw>
    <xmx:szL8Zn34Hi7uwLjdxoSaJoQdSuoOPGZan4Qk9EIm6PJair6S3HXRzxCb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 13:34:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniel Black <daniel@mariadb.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] submodule: correct remote name with fetch
In-Reply-To: <xmqqed4zzqbg.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	01 Oct 2024 10:27:31 -0700")
References: <ZJQr0_aC-NlLXDgj@pweza>
	<20241001072423.1165932-1-daniel@mariadb.org>
	<xmqqed4zzqbg.fsf@gitster.g>
Date: Tue, 01 Oct 2024 10:34:41 -0700
Message-ID: <xmqq7carzpzi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

Sorry, forgot to say one more thing before pressing [SEND].

>>  builtin/submodule--helper.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)

Please add a test or two, that fail without this change (to
demonstrate the existing bug) and succeed with this change (to make
sure if somebody breaks the code you fixed again in the future, such
a breakage is caught).

Thanks.
