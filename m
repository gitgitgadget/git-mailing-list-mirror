Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF3364934
	for <git@vger.kernel.org>; Mon,  4 May 2026 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931779; cv=none; b=VSF85aGjoFvpaDKkFVgcQz6JEQ/b1StDHwvJAQtyXA6Fdzj1Cnv/9lwHYFrrl1H3hJ3RPT/Xkvy9fnZpIL4RqlBnWGHdjHU7bC3f6C58rJxFyX18VAMpvwZxY/M/Hkx1vNU/ojatr6aarOpmSERqtpq3bt9LfrKQoT1jf4fsVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931779; c=relaxed/simple;
	bh=s8gwNks6Odb515jNTTK/LUP8dOnZMZUxytWCCSBglMw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YvicpVOPYz5boouTZ1ZK5MxWTFsa8kf5K9iDHUu8Jt31n6iYoSNv2b+qiPO2zpIZWL08Xfagcs06PzMqy4n9MbcfIw27fzMx/MYpr26UNZOkBSGsx4QAqVTJMn80QFC7TZFsYWDpyRnECJzQR+xEonQrogU7+I91NJE6xd8AZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=O3QnsgQx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QW3hLeSV; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="O3QnsgQx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QW3hLeSV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 642F91D00087;
	Mon,  4 May 2026 17:56:17 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 17:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777931777;
	 x=1778018177; bh=s8gwNks6Odb515jNTTK/LUP8dOnZMZUxytWCCSBglMw=; b=
	O3QnsgQx3XLZxS2NqZd8qNOo4SKQHDxh0lN/AueoHCosT8tf6Q0wRr6BQ7hhjpDX
	fK7uokomhL466D7fbo2PoOG75cvN5mfTgzUQhO10kaXvF1nF+unmUHFinRLKM6BU
	F9gh7hoyTZ+oX/10tDagrefvbXh6id1vqSjh/ijpx4f/FyMYuNfAit0SAaW+DFWf
	Sd2z5b0ET/Ef+JkPoTNmeuX+bbQJKi8YWYQ/t1y/14BP25fJSQSS+IN0GxEoassh
	78vzuYK/TfqJFG2ais24oYHLjNQKz1A2UKAEn8G5gW1atMIbXIS9kktOoiiLwxY+
	OdeGGvhJ5RPPV7sQ0Vaelg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777931777; x=
	1778018177; bh=s8gwNks6Odb515jNTTK/LUP8dOnZMZUxytWCCSBglMw=; b=Q
	W3hLeSVQkRs5a1x3QxZ3m1IPSERO8TVeA/bVvzash9SGPaE24PKIBNR9KHnPVMT8
	kqEZR1yLFmVh2hlj8MzO9kQelcGpCpN0SgSHA8lOpv6RXLsyyv/71EaxBlB9HDaE
	AgRIKF26RUwkoFZ+ghf7MEKcxdeLg649vPrnngTA1TmTg4BIzt6CvAdx0Bph+7iX
	ChWUM6VR2EDNZN7qqDD7aj6sVAr0uQqjCdqp4IBYA24dq0Jk3CaNgHLLGfZ5PeUJ
	8QU0X7+z9mRT/pIlf+5UeWh2EWD8rqWcgQablLrNvBf6zrwdh8k3TstnI16LLmE1
	ixfV0WRQMwqvdcPbZqnxw==
X-ME-Sender: <xms:ARb5aYhAZqgg8ZdglkUOP0opv2ZAzWRBc3aRBO_oKgyRHB99odVquUU>
    <xme:ARb5ab19ctqngLhh64y2kaVWxzvnWRugMIAwmh_CZk1b-RzKocqVn-LsiCv-Orpw4
    w9SIy41r1GNXds-YNIp2ByJft2ydxRu74Mbod44f6xB0JbYSek34MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ARb5aUPSEeNqhV1JXExunlRfqJEHcLMNRECE8pByl8aWsc9uLVifRw>
    <xmx:ARb5aUQoMIUg_ubxgYlo-xIEkJNwNi-5A9KcrQmnwa7eFWnQ2Zavdw>
    <xmx:ARb5aSgM1HYJCNL7Wm6ZeVnZNeFYQuZUz2tfuCApDwUOz4kFhEpdbA>
    <xmx:ARb5ad87RY_i-wiwE8BerWzt_q0VAFpKPJitN5Gy3pb9ghnYMrGGPA>
    <xmx:ARb5aaMfY_C0Yv_XT_RvsE5x-Iu707S8ENo2olz-qeFLwfmA-I-zJNI8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA71BC4006E; Mon,  4 May 2026 17:56:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AF5uq1-vAvqF
Date: Mon, 04 May 2026 23:55:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>,
 "Jeff King" <peff@peff.net>, "Elijah Newren" <newren@gmail.com>
Message-Id: <0b7fbb5f-bfab-44c4-8bb6-11d6f9978779@app.fastmail.com>
In-Reply-To: 
 <e1b7fd3cb2a2bba5f6404ac5f8ac3487a46d51b5.1777853408.git.me@ttaylorr.com>
References: <cover.1777853408.git.me@ttaylorr.com>
 <e1b7fd3cb2a2bba5f6404ac5f8ac3487a46d51b5.1777853408.git.me@ttaylorr.com>
Subject: Re: [RFC PATCH 2/7] path-walk: support `tree:0` filter
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 4, 2026, at 02:11, Taylor Blau wrote:
> The `tree:0` object filter omits all trees and blobs from the result,
> keeping only commits and tags. Consequently, this filter type should
> has a fairly straightforward integration with path-walk, as the decision

s/has a/have a/

> to include an object depends only on its type and does not depend on any
> path-sensitive state.
>
>[snip]
