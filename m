Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D62036FF
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973335; cv=none; b=OIPOtJgjhWaQF9yocgJeJOInD79RVVRXHMbSzcMhkZwrocrX9C5lNVqAt/rpgXlkdLEIM5EI3vMWLvRO2e4f07gVHLf4xvyWZvK7DT5iidoesooJl/0PDEn8PyjOFZDd3nBrGVr2W+bfUDw9Fmg9XCVwVg2TLjWSs/mQs5fQUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973335; c=relaxed/simple;
	bh=K/vK/lsFghk+563VmuRiblK6Fnr+ueqjCYgc8lDbHJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jCmS8WK7yWVzKRrUmyhgVSHU5+8DrxQmZQ9vjw4EArU1Ov4blRW2HocpO4TlFBMHuoY0bbsRsb6l2NeZkUrYNwPsFZiYFdk6Yg9Ne5SSJbAPSlXAsSwXqHKoAMkXzU2Hd3kg0gAOA1V3Kj7z1HJiFLM7YUrbY7+/AXjzdGBtyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S6ChaO9G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fhA9IU8g; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6ChaO9G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fhA9IU8g"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EB2261382D9E;
	Fri, 14 Mar 2025 13:28:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 14 Mar 2025 13:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741973332; x=1742059732; bh=z/e9XNLNca
	Mrf7CkBKDKkKnGTui53ZVtlyUvtCsxtDo=; b=S6ChaO9G66SMLsocl0lndED+kG
	9a1QvxJ5URjG1quCptsWq1euJ7tmRlwIYVPItKoygg5tlRr4B3zr8Q531/Z5OsPC
	1QY223eDz6TbVyB6Z7d1misqVUuQf4wUtjXiCeWThFdODJmu+Fah6pBhQBPz76qb
	Afj5UrmpJnsH9pt83STzmu9TV5RJctIDHwidiJ/HunGCSRw4dcvvsgItpsYRYe/T
	G421KIJO12jTeutni2JIVDX8LXPI8kJLLgwPhfxRlC6KWIzTYCtapvfMQzVTsUeG
	/rWitTe4rBwSgWLAg/G3/QTQ6AdPjYWHVtZiCJtktuRYaAAaPAMIcgkgx6Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741973332; x=1742059732; bh=z/e9XNLNcaMrf7CkBKDKkKnGTui53ZVtlyU
	vtCsxtDo=; b=fhA9IU8gH6GQorC3GQHpkZYVLXEnAcjAYMqTApFqj63amEiN4WX
	Xqq/Q7vRDkK19RNFO+wkLH96dwJVzNHqClz3U7IcuBHpgCIuF78UMlNlgqEJDbpB
	JOzX5SWng6IsXD3J0tUw9PLvTAkN6KMm4R3UmpNv90LUPBlokwCTOZ9pfFefhQ0d
	9hXNRvF8WGwKH7WfIQS3nfv8Ge8azVYej2KDRvIBhp2I+buqanfpDb9zNQUt/vcZ
	z6KlIr0zbkpkNiKGZn43WYckHZTNbJoPC5RLunAPUDoH/fCMJqEwyH73UpjzehbZ
	w831wIlYp62M8RWENcLmbTps+1oKzWbHMgw==
X-ME-Sender: <xms:VGfUZ1Kp9OUcH2Md7_p2dk0Cc-fF3eQ9VgbFajq-ciS9joSVRx7SeQ>
    <xme:VGfUZxLg2TTkYOoM9nSeNEfaTExuVHklWRt9c-nRRY_VGxqLPIubG-_KtG7wKYOGn
    NNlnTDsL-_aXo8bRw>
X-ME-Received: <xmr:VGfUZ9vrDGT31xUbhUXXbzRd3Mf6hGMMy34ev1kkTFvoXS9Mj75pCZk93vYpEMgHm_5VSrmClvBGfOje6SPjbY5JE_1B9eRhKiU89iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:VGfUZ2aaLtLJhyJhUPmpO2DLi-G_DgvQKpwK2M5gnyDdh3cyJgQ4ew>
    <xmx:VGfUZ8Yl22J2RRRvuIiCwoQokvba_yjnIDk8UiErvjiqZx7kieeQPw>
    <xmx:VGfUZ6CVrQL30wM5n0s2ldqf4_H-ERFOA5yZG1uUGxSHOvtxb4pNeA>
    <xmx:VGfUZ6YGdDq6C4Ff4G6nfMYYU7JpiyiH3J_Io8L3zUNMB7mTUCxTkA>
    <xmx:VGfUZ4T8ZqkZ3VZ4-7ZGRsHOKPx6RIb6m9zM_GVRm6V5hz70yc0E0pbM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:28:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <CAP8UFD3HtG0QSZ+89K79ZKxfFkdDUjfbTbF8zTvquwRWU8c9Vw@mail.gmail.com>
	(Christian Couder's message of "Fri, 14 Mar 2025 15:09:50 +0100")
References: <20250311152413.1059343-1-christian.couder@gmail.com>
	<20250312114628.2744747-1-christian.couder@gmail.com>
	<xmqqecz2yyg2.fsf@gitster.g>
	<CAP8UFD0QqUG5Gu-XxKi58sEA7VfSJk4gy9hb_93dCw+2QMABYA@mail.gmail.com>
	<xmqqfrjgq3ye.fsf@gitster.g>
	<CAP8UFD3HtG0QSZ+89K79ZKxfFkdDUjfbTbF8zTvquwRWU8c9Vw@mail.gmail.com>
Date: Fri, 14 Mar 2025 10:28:51 -0700
Message-ID: <xmqqh63vh67g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> is relative to the current working directory, and because the server
>> and these clients must refer to the same repository using this
>> mechanism, this in turn means that the server and all the clients
>> share the same current working directory?
>
> Maybe they don't share the same directory but there is a symlink
> to or a mount of the remote directory.  I agree it's a rare case,
> but the case with no URL is a rare case too.

The meaning of the two instances of the word "rare" is different in
the above sentence, no?

The first one, the setting somebody could use if they really wanted
to is "if you re really pressed to choose between possible and
impossible, you cannot say it is impossible".

It is dubious how such a set-up is useful.  The server is telling
that the other side should now use this new thing (perhaps locally
reachable) so that "a symlink to or a mount of" must be prepared
beforehand in order to use the "the user is told ../foo as a new
lop, and at ../foo there is already usable (remote) object store
available over the network filesystem".  Wouldn't such a $CORP
sysadmin who can prepare "../foo" on the client machines for their
client repositories be able to instead prepare ".git/config" for
them with the same labor?  IOW, the "is dubious how such a set up is
useful" I said is not questioning if it works.  It questions if that
is the way how people _want_ their system to work.

The latter "rare" is "when there is no URL (i.e. r->name fallback
needs to be taken), it would be much more common that the command
'git fetch ../foo main' was given without configuring ../foo remote
(hence URL is missing, but so is fetch refspec), than somebody added
remote."../foo".fetch refspec but choose not to add URL".  There is
absolutely no reason a user would deliberately do so, unless the
only thing they are interested in saying is "hey this works because
of r->name fallback", without considering how much time of others
(e.g. who read their config when they have problem with Git to help
diagnose the problem for them, and then notice and wonder why .URL
is missing there) doing so would waste.

So whichever "rare" we are talking about, ...

>> It may be possible, but would that make _any_ practical sense?  I
>> doubt it.  I would understand perfectly well that the local single
>> machine situation as a good justification to use file:// URL in such
>> a setting, but not for the r->name fallback.

... this point still stands.
