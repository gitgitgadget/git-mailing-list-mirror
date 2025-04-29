Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE822594
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940338; cv=none; b=u2HifOwvf0jLR9XGqUB2vDhu37FDP6alIcYTGokq1iOLLqH+zkWhSYPV08Q16LCtlS6E8rokWuWiBmPdYBYOKpqlwKb5ym+hTnStU2OniqUZh+4z1T3pXtAxv7LB3Fp4mbIvV+7WDETm/Q3w02Vm5kiFbJOpEX1nmol/HVg+uOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940338; c=relaxed/simple;
	bh=e4XsNxoMNRnL6fk156y71LDl6zUi8Xv5XfcCpwB/i9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZ77n0nYePwWz9FKXuehw++nxtYYEK5xJA90ISdEWFFC2Gmm7UrZfHp2+g9HXqOr9Shn9dTN8fwrVQRxswc/9QxnioxMflC2DBN5u8Xhv+G2VkOly4JpTLWGlrj3yWraT66mDo7numn8WzJJP4ypJuz+WnX2phgQshUZuYEAdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jq4kXZ1z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t09RZVhe; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jq4kXZ1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t09RZVhe"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1289913801C8;
	Tue, 29 Apr 2025 11:25:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 29 Apr 2025 11:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745940334; x=1746026734; bh=E1Gsg3LmuK
	4HwB+h/6MEcO1Ym4QdmGYedzb5BNk++T4=; b=jq4kXZ1zGmR1ZreLkMfA/gfSn3
	JifzHy2bFRMv6oW1Pac3bSVfMJPWeyYLeAbu9sF06qBv5RuOp7tu7xoZfjjkIjAR
	tgLYU4kaB1M93/PuQAHr03WszWDz0bkDz435o87hLd7s4i3dioO7pBZkYK177y0M
	9HWkVbiQ5C3mJujKqKwCJi8z2W+7vyFDDkI8pneGoshdoC5uB8uS8BxVmWIVUrNn
	1T9OMvrdDUoG68U8ajFvPzsWUUzVNROXtYYgxyYCqWVtcqQikqgH03fuWr+7Xe4g
	4psLGwfhhZn+u6wGczpq4CyTpaY+mDFOQHatglBdo6HBrHo8R3PBkO09Rk4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745940334; x=1746026734; bh=E1Gsg3LmuK4HwB+h/6MEcO1Ym4QdmGYedzb
	5BNk++T4=; b=t09RZVhev//mXP0FUUh17yAaB1DcLk3SIR1Vw1B7yRpUSQ1P/Xz
	WQbekL4qV4F7mJdS9yTNXFBkBfw+gtAsIe/6PMPR0IuAwk0AYk2ZOgpOaTi+mK9D
	ic/N9NGt5P9LjwTeA2RDDgYn0Aj4lfQTZlMarAk7xD32KOCtfExGKw6oNHf6vDN7
	aUMkV3a+sB50vA9ADg74VWmRQAzO0ydcvEHJHmnQyqo3ACjtMezGeba2cA6HiHPx
	JNXMCTeeqsvV5pU1IoVKkD33jY/vwlVah5VCDLSHJTgpOQS1q+GDE9QjNaw6g4WK
	ulDyMPJ3Ni3lPUUTXHQOKqYWvhgwklUVNrA==
X-ME-Sender: <xms:be8QaGw-0DjUHJYpET43Aqj58V-5uHraMEKsVXiQXVexNiSvYe6s6Q>
    <xme:be8QaCS4RcQmf42r_eAMWbIQjq5vpiOS-lHYZri-0jFGr0e5pkWzUvKsBPEvfi7uL
    y5q4dKM5EKYc18jdA>
X-ME-Received: <xmr:be8QaIUXsCWl23K4fPnVmO4lJ-LyYfhdcTDSjmL9mxjSwaw_eit18arnILyB-hz7gimx6HJt39ctDmq7c19CJPBMOCTEhm4dfkLF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:be8QaMjtmoqqhut0UtH9Ns14cKhjlzmsBkT88TF-e8tKHucaws9B_w>
    <xmx:be8QaICyPBYMhdUZZCJrOjK2ymQsfC6l1gN2rQEUAGQZpG6CFj7Etw>
    <xmx:be8QaNKcHQ-ljYoEyooHbAnbL-0Ysz_8ZeUhuD7Fd-_Vk77adHeVgQ>
    <xmx:be8QaPACtiqiC5-xQicyl49I2YKvJlQu9haJ-bwKM28Bwt2uynaFHQ>
    <xmx:bu8QaIMwHf4jxaow3UR0PZnzZQz6UuhMg2t6jC5A1_bdSj6-TLqK_V0g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 11:25:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 12/13] bulk-checkin: don't fetch promised objects on
 write
In-Reply-To: <aBBukgbWZRRLgnLl@pks.im> (Patrick Steinhardt's message of "Tue,
	29 Apr 2025 08:15:46 +0200")
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
	<20250425-pks-object-store-cleanups-v2-12-63f1695b7700@pks.im>
	<xmqqikmo9bzc.fsf@gitster.g> <aBBukgbWZRRLgnLl@pks.im>
Date: Tue, 29 Apr 2025 08:25:31 -0700
Message-ID: <xmqq5xin9ehg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, to be honest I wasn't totally sure whether to include these steps
> myself as I anticipated that they will lead to discussions that derail
> my original goal, which is to clean up the interfaces in the object
> subsystem. I decided to go with these where I thought that my train of
> thought is reasonable, but given your comments I'll probably just drop
> those patches.
>
> We can still adapt these callsites in the future as needed.

It is probably why among our past rewrites and refactors, successful
ones started with a rewrite faithful to the original, treating
semantic improvements as a set of separate topics on top.  I think
some semantic-improvement steps like the http walker one make sense,
but even for them, others may give us some reasons why it is not a
good idea to cause me change my mind.  On the other hand, steps I
thought whose semantic changes were undesirable may turn out to be
benign (they unquestionably will improve the performance of the call
path; it was quesitonable to me if they still gave us correct
results).  So let's give people some time to evaluate.  I'd consider
these "improved behaviour" changes as "to be discarded by default,
unless there are strong supporting arguments why the specific
semantic changes are good" material.

Thanks.

