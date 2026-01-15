Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6F38BF8B
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487714; cv=none; b=u+Mr7LpokNAPNWg5w+JNZblaSkh+ObUCnoi+l1V14i8zV+PC+KtUdLboUB1sqQC2Iuz03fG777m9Oz004TdH71GxdNRTLHp9hOG31b9ZS2i3hv4zcHIEOelmGChKZQ4BB0pqboBDj57gTnwq+UCzUHbuHVfq3QuGtWlxQg/jRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487714; c=relaxed/simple;
	bh=wsumUG9TV2f7dPlA86cH+Pj4Jyt8vqDrsxpp8RkProg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oMS3hKh/XgO0jF5FzbvJfjsUcwnzwNydXnJTZCw05tUHG5PhT6e7g9IcwwC0vuKTgHdXWARJmuZSE7bRsboGciLz7BekioV3bQW5VLOaogfLVwGODiU1FFCkT3hizxu+gePR6JwG6vN5smI0Z12WbY+vL/KXzJUIJHV2xERcyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ejXpvjGU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dW03p6b3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ejXpvjGU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dW03p6b3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 42C95EC00FB;
	Thu, 15 Jan 2026 09:35:11 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 15 Jan 2026 09:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768487711;
	 x=1768574111; bh=wsumUG9TV2f7dPlA86cH+Pj4Jyt8vqDrsxpp8RkProg=; b=
	ejXpvjGUWzHDwLY3Tza1vPTF4TA+/PRjsjtqVlfbDYuy0fUlwcv0y/s7nzdm+k6Z
	fP9KzqULuUFi3YDzyzmeRCDvOnv/tTaZciQL98bEWwPHb2flE/eHV4EE7aphfCwp
	jtAbuwYqUQVjsFmPTsMiDrjgdlk2aN3TJBF2RhQKJO9KR59l37Tj/ZrCaOnwQm1R
	ryM1WYguFFj6ctqWzlHHrS709mUmzYFb/eJ5HyrG2NRDcYFADGNC5y2K98CUNPZA
	4hkJ9tZmSJi0RbEWjqFz7/NHe1y+esAWi4G6OfXGxsTGZCjlhDSrSJ+eeXT+hH35
	qh2b5hX6HCoOmazZouBWYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768487711; x=
	1768574111; bh=wsumUG9TV2f7dPlA86cH+Pj4Jyt8vqDrsxpp8RkProg=; b=d
	W03p6b33fHesmEn41CYNTlxElZg2qi1p8hBsXj28S5iosCdvpZCBf2kAjDmD/YkH
	gcBvnu9WaiYgrhrsbhOtIt9BSwW6jr6vG82ShveHkjNYe0gNqWT2BbJjSUGsgJj8
	VLniuzorA033ravyd1UkzWpwpxPV3bX3zRXf/JP96pOdVv/zsRqLIBO/B1ZFByMf
	wkut5mQW3kwpKWJvibNGc/mB2V8e3Ftf71LQX0ZKU3dtb9peveOVjrXwXtpeSOj2
	WQehc5AEUHDMcja29rOxY1w9OHmNoXpNSILgki9kNWxkPZan31b5Uo+ja0FVaVwb
	zMrRYJIk50KM0S/X0lfrQ==
X-ME-Sender: <xms:HvtoaTF9DlvxBIin3vFQIMDjkO1MdMozAuBLsYFUumZPFKowA_GCshM>
    <xme:HvtoabInYIxN6r7-e7ThSXmnxrU84G0wk5Sy41hNohjPzjzFG9hzXq6ZAaIqM5EMZ
    EZ9sGt8kHCbKoEapN-8izkQ-UNjSEhL4amDi07S5PAIIN0jbFLgQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:HvtoaUBlGtf3EeHNqj8O58pQ3Cp4HknMJpWW6EiDugvA11ulvJLqmQ>
    <xmx:HvtoaeQf_wwtjdNZwrIMdU4p7tUSUwyf1z_LeXYo90CqPbgoyJ7G-Q>
    <xmx:Hvtoaarn2EftwOn-PU-NZqwm0HRM9VYWN-HTKrw9eZFtHcxxakGoIw>
    <xmx:HvtoaYzgxn4x9ZQPUQhCaCEHB4hkQ0QzkedRxTEbFmQo2y886ON3YA>
    <xmx:H_toaem569uL282oiExdmkjgaBN7ZrKcPDX_hgwJFuKnlzROXfUn_kha>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ABD471EA006B; Thu, 15 Jan 2026 09:35:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4LhpniH-T5F
Date: Thu, 15 Jan 2026 15:34:50 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Toon Claes" <toon@iotcl.com>
Cc: git@vger.kernel.org
Message-Id: <ca6cfd7a-3392-46ce-99ab-3d93c9ce90dd@app.fastmail.com>
In-Reply-To: <aWjVWC71rFeTsHLP@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
 <aWd2SLrBQRBC1e2S@pks.im> <87jyxjjejz.fsf@iotcl.com>
 <aWjVWC71rFeTsHLP@pks.im>
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more than one
 revision given
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026, at 12:54, Patrick Steinhardt wrote:
> On Thu, Jan 15, 2026 at 12:33:36PM +0100, Toon Claes wrote:
>>[snip]
>> I was thinking about mentioning something like "commit-ish" instead, =
but
>> I felt "commit-ish" isn't a commonly used term toward end-users. Look=
ing
>> at gitglossary(7), it says "revision" is a "synonym for commit". I'm
>> happy to change this message, but I'm not sure s/revision/commit-ish/=
 is
>> the best change for this.
>
> gitglossary(7) also defines commit-ish, but I guess you're right that
> revision is the more common term. I'm a bit surprised that it's defined
> to be a synonym for a commit, but oh, well.

Surprised that =E2=80=9Crevision=E2=80=9D is a synonym for commit? Why i=
s that?
