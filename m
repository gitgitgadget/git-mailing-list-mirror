Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C13C343F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086821; cv=none; b=DuGmFKxm/hYirPmDfPRIrZjTpuI82PiGJ0rHp1V0RDPdDeQdfKaDWOr/MkXZGJAZJjKv1dIpUmjHCgg3pS39dz4Ao3lE8L5nwxKLp4crhX6Vvfkv6xqxQRRjUc5z+wcCh/OZYk5XklL68aeU14LCxmPdAeerh8TuUEnKoYJHQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086821; c=relaxed/simple;
	bh=WdJMTYBCL29dGQMR6fWs2nb2nF5sYou6Gf2kdphCjWM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KozVwnAwNuLh2OkOUWnt/Vvr7bXfRj6fEt3fKTp9lJTliy2k4jjoVsQeJThn2CpKuopu69wrPRunb/q1VHt5GaUlyu9YhkMJIT2T6f7170AEYo1k2t2RJ5XRtoCnff7vPWYWjQ3YCVp8xQnUEFpBkYP4KtMyQzsIyREN+6A1dYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=brWg9Jch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzoIJVsu; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="brWg9Jch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzoIJVsu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A6B36EC0448;
	Mon, 13 Apr 2026 09:26:57 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 09:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776086817;
	 x=1776173217; bh=WdJMTYBCL29dGQMR6fWs2nb2nF5sYou6Gf2kdphCjWM=; b=
	brWg9Jch9AFYKZNn7+TSZU0bL1qRBhJkgye8cSLzhyYiwRI8R6tEcDLuj9HlerOM
	BPgFLUQKWeg5u9iu+IO9QH3S0Hnabfd7uODc7Zx26HNvSrPmKriro9O3ew+Sp5RR
	DJSaRkCPerDLkutWpKdz83kePJc1ymgnOjeY6N2erG2CqudHfPJjTz/XLokjVXMz
	679rC1bOhUFTLkfHVjL1XDe7bozcqZ8IbTFeL+1YQyzKCrSKx2X6WdNZiDf2Rmn4
	iERlBYwk5Q5rZj5UpHGlIo1rsXEWj+cjn1xYRhXpOX0J/QVf/JcR9I4NQlTst0Pp
	NyLhPVOAZh26IxTKXin7dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776086817; x=
	1776173217; bh=WdJMTYBCL29dGQMR6fWs2nb2nF5sYou6Gf2kdphCjWM=; b=j
	zoIJVsuL09JU0p5MFdRXjveEMUOj5brCe6XibpMI3ZvZtC2PXn6U2YBMhJTEWJuM
	7nLefM/SbWgrwSMNwQVDQNSOCntkfOZ8N9zpjVQGos7UxqKe046PZhp7tOUmFT1J
	TNfDOOuTvsAbPWBA9bnolb7JRDnmHvlkxKmCM8lsWVhfYAAc7ppWWat2YGBVJtMo
	MyCJiyaic3Cs45kt+n/bBjsjAvPNBm+NYnXqPloyndTlfpeYuQ0KFwD9oqHe1xto
	K4Csp6e0c8bNd8BLtUSiQupbD1te8r1uu7/MdYmwaYfue7KBYYhVa/rxiJWLz2qG
	KeebcwT/ejOg/PUAXh2NQ==
X-ME-Sender: <xms:Ie_caYMe4PhAWVsxVG4nQ48-5ee8t1UdvyBG-1HaPtE40CmSnbpj6B0>
    <xme:Ie_caZyDKenueBLxYU3lVe-Zih0XEZOIDO99mu9kSbgI9rl3yBmDkv0PlwWb7JvlH
    7VRANY9NcQ4zObpF7mkV5i1IrmKWuwxUdB1sG-zqMypvtW0me-jTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkmhgrnhgssehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehlihhnuhhssehutghlrgdrvgguuhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ie_caX0HmCBX3qIUloyo-oQ2UBmRCe_oFykz0jMKJMhDd8i2km73fQ>
    <xmx:Ie_caT6M0Z2DHD3D1DVyE4sMDFOlyJXtUhRMrOQYrf_Rwq8AU6_6Lw>
    <xmx:Ie_caSWgoTALSwapuBw7sXmJoaBeHrFDtJ2EIvTOGqKKb-CRuEzTaw>
    <xmx:Ie_caaC7ZPGFFGUUO792l2woOHJLEfxnIF5K_AIvclXSoB_TnM11_g>
    <xmx:Ie_cab5Mq58I2OydLhvzwt6RlrfpWXzr1_AcM_G0QTSxDmCHJfBVI2iV>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 35C831EA006B; Mon, 13 Apr 2026 09:26:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUgMtfrvVkyR
Date: Mon, 13 Apr 2026 15:26:36 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Christian Couder" <christian.couder@gmail.com>, jackmanb@google.com,
 "Linus Arver" <linus@ucla.edu>
Message-Id: <5302cfb4-f2a4-48bf-98ce-98b74e7a6568@app.fastmail.com>
In-Reply-To: <V2_trailer_comment_lines.61c@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
 <V2_trailer_comment_lines.61c@msgid.xyz>
Subject: Re: [PATCH v2 9/9] doc: intepret-trailers: document comment line treatment
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> [PATCH v2 9/9] doc: intepret-trailers: document comment line treatment

s/intepret-trailers/interpret-trailers/

Didn=E2=80=99t line up

On Mon, Apr 13, 2026, at 12:21, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>[snip]
