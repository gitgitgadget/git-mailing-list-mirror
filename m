Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669451F4CB3
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626253; cv=none; b=WZvjCiZy/iKOhjswi4ptBEayMShlkbgmYZpdBup9kpUyzYfDpEkfAgj+e1OLQq5NkR6aoHYGZqGoyBBeZvfmdikOyWVJGSXuN0QkBYHWUZWV9C0duTxisRn8uT+dgJ7gWwVaBvrvedWkxHTKINteSgRH4kykR0fGxkgm4iZuydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626253; c=relaxed/simple;
	bh=6RtP8MPQgDQtL9KBSKkZCQglklHx3qFwMHRWkt+yhhA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xv+CJjXNqEbPGpTKfkvJB9fkl4UWR2HMWUw/uzOaBNaGBbPg/r10v7UwtGox3j5QAVHrtN+w05g4kE+uPoj3aU7rKRVEUr1sauHoP376ZGvIqbpah1rTYtvLz4eKdGNHRoU6mSKx4aP/7yvAS/93ibnUYlLCg1x8m/GMKHdzwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IhPn6k+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zyd7Jjex; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IhPn6k+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zyd7Jjex"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DAF614000D3;
	Mon,  5 Jan 2026 10:17:30 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 05 Jan 2026 10:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767626250;
	 x=1767712650; bh=Rp0jf+dPOj9ll3S07tt24R9QuXmdj9bHzaIor3lsUIM=; b=
	IhPn6k+I85QqIwrkkpc9VU4FP0qHoTbGfE46FSS6N7qD3zP4TC+YlKfftvAh5yLW
	I5dbTGZrIiDrNjYy+A1wufU6/NtK6LC2CG/uZAHgAZDBU3G4Mmsabdyby9JDnO7u
	AleIUGkiOpGlen2Iydb3ihpXyAjh7ROK4f9GP1A68OUJxNFiuYjkrRzgsagQFWnt
	7e6qqgGruTngJJqIwyY8vQy0nbWgHhZKnSBBPG3u1JuZrGkbyZ5K1LgxXA0Ha87M
	JFNApggR2Jo8gwgDRLcMsWcPMKa2B6Dh/2XQOshQoipG9MYifvpLYnYkMWkq9dYW
	5RL9Hb94PSGMZmlw9jpo/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767626250; x=
	1767712650; bh=Rp0jf+dPOj9ll3S07tt24R9QuXmdj9bHzaIor3lsUIM=; b=Z
	yd7JjexHdpH29N2ji48dyBdnbZ0chXsBd7V5Tgp2z9PlEiO+UQ0Eu0bRQ5DtWOeq
	7fFYUdMk4O6xCiUdYzrkuBwquLAOqBfAgUr/BG8ycWFO6lo9+RfRk1zBlLscsYLZ
	flAZYrlRCQNlyPH5vl5MDF0CKueXvxmAmIuh2fWRNWjZDmqNZXwazkGTKcGElK0q
	kaQl54/bZbyPgNIWyK5zFCUl1LcsANDvo76ZCDmXYKQ10lb7Z5AzQhdX0f8GK8QK
	mQTmTIjcskDSzcT/FnCFGf2+1KdPwP8aYWZmL/ei5DQsWKusgT32sG5hbRfLOR6M
	Qp0JaqYkRJlxxB6n+2AZA==
X-ME-Sender: <xms:CtZbaY8LMBHAmOAbQQsz5GVlvHmyq3mTJTL7acXrzbnnm6d8KFpYOCs>
    <xme:CtZbabg5OgEcwLNA8FeNRt_Pc97KT_uDp5zlpDW0toplhoFhCrNCSj8upYOJp7kUc
    6FTrYTkuBTiF-BAXgZzBpgvVmBI2D09wzYFhLa7Pr_XvckHleuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeiuefgueefhfet
    hfehtefguddttdegkeevkeekgeduheegvdduffelhffhveekgfenucffohhmrghinheptg
    houggvsggvrhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehguhhsthgvugestghouggvsggvrhhgrdhorhhgpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CtZbacmRVI-Vu4PsFHVbkhpMe41SopxsWbGo9IKJj9b3JMmsEHJLHQ>
    <xmx:CtZbaZq2aI54vF3rfG3UQXI35AZNKbN4Tva6Cu8VSjLULx9K0IdWEw>
    <xmx:CtZbaVFR3UUpTedNgKaDVM4-5My7Lx6JWdgu8VoB2JjVN4Wi6FqPwQ>
    <xmx:CtZbaVyzjBnViDua956cog7Tm6bRtB4mT62G6Ej4vwoSw-nHWM2EWw>
    <xmx:CtZbaYlbVu4FQHi5X5FjasQs8JIsT5mD_B5PvdKqSr3WXCwDhdeeVZT9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 540B91EA0066; Mon,  5 Jan 2026 10:17:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6Y4akRbTe2J
Date: Mon, 05 Jan 2026 16:17:09 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, Gusted <gusted@codeberg.org>
Cc: git@vger.kernel.org, "Toon Claes" <toon@iotcl.com>
Message-Id: <f9449d2c-cbfd-46b0-a961-5c668b895503@app.fastmail.com>
In-Reply-To: <aVvSwkK7RdpFDaVv@pks.im>
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
 <aVvSwkK7RdpFDaVv@pks.im>
Subject: Re: git-last-modified on bare repository
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026, at 16:03, Patrick Steinhardt wrote:
> On Mon, Jan 05, 2026 at 02:35:56PM +0100, Gusted wrote:
>> Hi,
>>
>> Now trying to actually make Forgejo use git last-modified after being
>> pointed to the non-yet-documented options but I quickly noticed that =
it
>> looks like it does not work as intended on bare repositories when loo=
king
>> specifying files.
>>
>> $ git clone https://codeberg.org/Gusted/math-accuracy
>> $ cd math-accuracy
>> $ git last-modified -- LICENSES
>> 768f05837e7db2832425bc3b65d0f524e81b2769        LICENSES
>>
>> And on a bare repository:
>>
>> $ git clone --bare https://codeberg.org/Gusted/math-accuracy
>> $ cd math-accuracy.git
>> $ git last-modified -- LICENSE
>> fatal: ambiguous argument 'LICENSE': unknown revision or path not in =
the
>> working tree.
>> Use '--' to separate paths from revisions, like this:
>> 'git <command> [<revision>...] -- [<file>...]'
>>
>> Is a worktree required for this to work?
>
> A worktree is not required for this to work. The problem is that you've
> got a typo in there: you say "LICENSE", but the actual file is called
> "LICENSES". If you spell it correctly it should work alright.

The error message is more generic than it needs to be though. It has
seen a `--` but it falls back to =E2=80=9Crevision or path=E2=80=9D. A m=
ore pointed
error error message =E2=80=9Cunknown path=E2=80=9D would make it harder =
to make the
mistake of dismissing the error as a bogus one.

Of course, separate issue and all.
