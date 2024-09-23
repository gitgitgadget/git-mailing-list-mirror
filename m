Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB617BCC
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118828; cv=none; b=M7LwimSlbso4LTu1bDqczmTgxmFRvSw+ubFoLYbrWG2TXd40eg8wPzrrbK919+KlH/1zuWG48iBd2Nfuj8hBoFPpkmSGlrhsaKu9rpDaZOzyTWe73lznXIlW9bURsD0g+KC3SiS0wOXxU+kHOcH188zWxDjxdQug5hJja9Y15dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118828; c=relaxed/simple;
	bh=xmMREw7zFt70q74qnUc5e439TzRC4OfNG6SPoD6z7K8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IwEl9frYdiY+aznK6tajoDayQpQp1EJBP43qB5r9lPk+OxkP7NcvGI6ukdggJopg3/uQCoTfeSdiGCFIKlPrRgCxrOZPqw20WWxT0dS1MuFHlzkRL7vXfpijwJMxMLrD/yb8MPMHSWH5DI9NOWh/SR7N6WqG5ES0lWvFvj5yom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sKjdBSQw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/DQehth; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sKjdBSQw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/DQehth"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E5321140259;
	Mon, 23 Sep 2024 15:13:46 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 23 Sep 2024 15:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727118826;
	 x=1727205226; bh=eHfRufnlOv/36zPAni1+gyU93DbGxRdXGeoNb4smp0o=; b=
	sKjdBSQwR8wvFXS9tbR4CZo3fFqF319sFu8r8YKJaRLNQgHXMbV27Qyx1CvEZpID
	KnNujMGf1SdnSoS5jqXHpVF88sbfO+gS0eZeNtOVaxxegAtd9jksKeBRshILZULs
	NlQGsbVryAAndEZhkg2bHwx91tnMIRuU/83K9TQhDVNVfN8fr/m+fGZoPGtFv5wB
	JooAQjwtr6ffo+CyJQQgJfTDGozTHjYlwkRf9aknPTJNG33+5d8rMJsih9VG15JQ
	fwt4XMbLVEN+WmN9UbOZafGl/f4q3tG6QBZAsVcPlqpf+pPuyigOkyJgmIszKval
	20iLdWlVW2wky4lrUIBC/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727118826; x=
	1727205226; bh=eHfRufnlOv/36zPAni1+gyU93DbGxRdXGeoNb4smp0o=; b=E
	/DQehth5JwjwlyPLP2FUAaGOzo8xtjtLieSPz9oersg9bjpNSNaeGXCpaxvmi1ku
	eXGdCQyr1ve5gFBTHaem2zd+Qg3IjkpkkhFdIAi7/KtQ2y8RmZaxpd3bipAyNQZN
	cMz74FeULP7DrYk8S/KPleQBfh6VRgVmorhd6kKp6kBKp0VKLBc7NYM7ZIQrfvdy
	cc7A1dOw42Xu8QlwZdn3ONs+9ixgGFi8tp2DQTeKLdCZcOKs9GtRTpNuoiWCnb7c
	mqY+VBvWmMUptp0FrCW3qR6TTLAKJUR/e5EtWwA2bTdDBHRnHaZSvR800ehJnZ39
	PeauN6n+MkWfyME8FCJ+Q==
X-ME-Sender: <xms:6b3xZkwihL0XXYD6YpwiXaXFPeknY4HloLmzfYbbBrOEbrr509TBmXE>
    <xme:6b3xZoT-GDZaO2blM6Y9pi5Lnx7yuRmPTqITZiEfAZeEfkliASUVNvOQ2DrSsrSLp
    GIXnDYH1Tq6HbJL7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlghho
    nhgvlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:6b3xZmVOX44LRMqXKFFYb0Q2R4gq_P6ZlVBt-DY1Vr-CD_s4KmKMLA>
    <xmx:6b3xZiiLAl_u_yxdXIWkHrk09DJy2F82501fPtWe1rVNXwncM-FikQ>
    <xmx:6b3xZmD0PvLBHzjpsknj3dVkDNrbSqjFEbRQ3VqB6bYqyp1VlZXQHw>
    <xmx:6b3xZjLpwr3230DyzIi6SExT-d5D5ynpRXY67ymAwbAwN690NuW1IA>
    <xmx:6r3xZpMtkALPZGKXjjK1-KLIuvQaAwetc0lKVxNgbVzD7k4bqFpj6a5Y>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C9B6D780067; Mon, 23 Sep 2024 15:13:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 21:13:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
Cc: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Message-Id: <7944f06f-33d9-4988-85ab-c1cf563615f3@app.fastmail.com>
In-Reply-To: 
 <CAPig+cSErj4ZB9bHB8mZfzNkiaN_EpjT6b4b=cfsf_+KMqytiA@mail.gmail.com>
References: <20240923110343.12388-1-algonell@gmail.com>
 <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
 <85ed3ec6-fa4e-4ab8-872f-6bd500b2bb66@app.fastmail.com>
 <CAPig+cSErj4ZB9bHB8mZfzNkiaN_EpjT6b4b=cfsf_+KMqytiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/config: fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024, at 21:05, Eric Sunshine wrote:
> On Mon, Sep 23, 2024 at 2:44=E2=80=AFPM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>> On Mon, Sep 23, 2024, at 19:51, Eric Sunshine wrote:
>> > Depending upon how dramatically the patch series changes from one
>> > version to the next, the range-diff may end up being unreadable
>> > gobbledygook, in which case you may instead want to include an
>> > interdiff ("git format-patch --interdiff").
>>
>> What=E2=80=99s the benefit of interdiff in that case? Neither
>> git-format-patch(1) nor git-range-diff(1) seems to discuss what the
>> differences between these two are.
>
> An interdiff is just a plain diff. If you have branch (or tag) "v1"
> which is the original version of a patch series, and "v2" which is the
> reroll of the series, then interdiff is simply:
>
>     git diff v1 v2
>
> Thus, it shows the difference between the final state of the code at
> v1 and the state at v2. Interdiffs are easy to read because they are
> just diffs. However, because they are only showing differences in file
> content, they don't show changes to commit messages or new or removed
> or reordered patches in a series.
>
> A range-diff is a diff-of-diffs. It is very, very roughly similar to t=
his:
>
>     git format-patch -o v1-patches <common-base>..v1
>     git format-patch -o v2-patches <common-base>..v2
>     some-diff-dir-command v1-patches v2-patches
>
> It shows the diff of the patches themselves, including changes to
> commit messages and changes to changes, as well as inserted and
> removed and reordered patches.
>
> Range-diffs tend to be a good deal more difficult to read (at least at
> first) but help show the evolution of the _patch series_ itself
> between versions, whereas interdiffs show only the evolution of the
> _code_ between versions. As a reviewer, if you're primarily interested
> in how the code evolved, then interdiffs are much more easily
> digested, but most reviewers are also interested in the holistic
> aspects of a patch series for which range-diffs are more helpful. I
> periodically include both range-diff and interdiffs in my rerolls.

Thanks for that.  I love when a good range-diff falls out of a
reroll=E2=80=94and I love the tool=E2=80=94but of course that can=E2=80=99=
t be expected out of
every reroll.

--=20
Kristoffer Haugsbakk

