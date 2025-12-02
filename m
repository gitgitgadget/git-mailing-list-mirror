Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799121D3C5
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701309; cv=none; b=Haoae1S6gOCTiV7/BZNNVVCpfOqr0k5sM9Je6T4Z5exzCrsXfRE5nOxROiNCZA2xIYPKcDktRYP+Y/97KC+N94SdUQSXGR/ume0xbjv9WR3NKfpTFXk75m9m81tJo0OLgqE9vM/pwcqceKZAgnzKF7dY05Caeu+ANi5oYZ+YQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701309; c=relaxed/simple;
	bh=0VGKN+2y9tRkjAO3WO75Qf81+OXiaFLi05nMGxYHGzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3FXc8bR1AktVNMIM9XYoJOBhOeVgl6fFzl5h0lVBtNMG826lqQqaHC/vmqh+rMB6ffX4STgTLvYNB//+ohFIVKRR45VbnkByMN9pl0dIK3WLpDZ0kzz0CakG1GNxOh2X3DgKz1zbS6mRg/Xn3NLRrgKt5vRVO9ooZS3qmTpRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JKRnYyAS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGjcsPp/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JKRnYyAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGjcsPp/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B359AEC0556;
	Tue,  2 Dec 2025 13:48:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 13:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764701306;
	 x=1764787706; bh=ihFue8TpBX8AQSiz4T8mOiPhSh5tI0fON051jgGG3eE=; b=
	JKRnYyASAcI08pzkLlBk0NBgoX1necGCLgOXHJTKqxef5aNOG7vmkRi5DH1cUhpL
	jmkIvizX0B4kDrndNHetkh745m7OXdlZuHOgZKuaUWTrltw67KR2B8hWxJk+9chP
	vdVZm058e1a8n8aadRsjE6hQIfPZUpQTF5QIgqY5xM3jkBylSiVipsvR4l+cHmhC
	ACbhwcWVefdVOkxicQ+fmQ/wmO7fIO2m1ExHG9UR1Ifl0a5hUrQrCaxsC+ZHCHx7
	7HCyFKhNjGx87St1rLUABUotfLk/brnZ2dzx+mAesqgUmBSLZsjzSRLdjf8NMBSL
	A5l1zu53rzEWQuWe7ttBhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764701306; x=
	1764787706; bh=ihFue8TpBX8AQSiz4T8mOiPhSh5tI0fON051jgGG3eE=; b=n
	GjcsPp/XtjKeUlWsMNp3KX8zsIdR0QrLp91eAmTqfXG4tgV+qhl8OFIgRNbjUxhp
	i8hAmMVQk2yiO2ftfjcef4XrGldcnaARwDPzG9lp59oDH3LjKq8WuZQpVVyWltZp
	XrnoOyk9QmiU/ujQlAm4vU3vM+5e5YRVoV3Or86/XwlBQDko3XZWMvwWdUn185VS
	dd0aD9BAgqpnRdjnq6QO5jYS1ovDqRsD6j/halBCHtyWzzPGwr+WaZvCwv/MSyN+
	OMcqLAeGzN7YIeNaP+Ei47nMRsY3M8YAYp0sNkh2BvNT4Ijnq0ZuhCiF6knk4jIX
	NUxPPU9TCHXLIAdQ8Vvaw==
X-ME-Sender: <xms:ejQvaYjuK2yfMs6wz44cTlpqbn2k-j9Gt6LBemGOGVr84UBpLw3x7w>
    <xme:ejQvaTmgFo-FC33l4KToWquYsF0DYgqrjraV6-nm-ToORmbuhHd1yRb8031a2qR4D
    p3m4k-Qv9pPYqVSHuTki-6YKCcCrIobOAIUYO_L9kaIvfhzC5autQ>
X-ME-Received: <xmr:ejQvaTtDP-oiHpcgJYGPq-4hbEOkS5GRGSclDpILBuqJqAYt6-HsN7_xTV0huAv_X3NTW35ybkFYx4-IsxQ8eTrfjuSrIq_lo3q0P4ztp4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvd
    efjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    horhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehf
    rhgvvgdrfhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ejQvaZZXR8VTR1nAgGbTQHa_T1DVTlhzyOUMxHXtlILCSnKwklrV5w>
    <xmx:ejQvabA-2Wvr2PU7ReL6-62AYEsg3T3lDkvSBUdxH8TnCBMy1yTMpQ>
    <xmx:ejQvaR-Hs5UU7EH2-HiGVhadzVWhxR2uhmeijHY18XOV1c4rNsogVw>
    <xmx:ejQvaXRecUSoEKL2c0qIL5tB7MdCYKbCZEL6pr4m_0CGvHY9Z33yyA>
    <xmx:ejQvaW8qnvCa3mRZwxCPnQukCpZbXdg5rr90ee3WKpRxb7jd6duQ968->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:48:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb9ef828 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:48:24 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:48:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 04/11] builtin: add new "history" command
Message-ID: <aS80co7VTABD6nXs@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
 <CABPp-BGSYKPB7met4U_4ECNgA9vb5y_AWnMWfpiisOHnd_OyhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGSYKPB7met4U_4ECNgA9vb5y_AWnMWfpiisOHnd_OyhQ@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:02:20PM -0800, Elijah Newren wrote:
> In addition to what Phillip commented on...
> 
> On Mon, Oct 27, 2025 at 4:34 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > When rewriting history via git-rebase(1) there are a couple of very
> > common use cases:
> >
> >   - The ordering of two commits should be reversed.
> >
> >   - A commit should be split up into two commits.
> >
> >   - A commit should be dropped from the history completely.
> >
> >   - Multiple commits should be squashed into one.
> >
> > While these operations are all doable, it often feels needlessly kludgey
> > to do so by doing an interactive rebase, using the editor to say what
> > one wants, and then perform the actions. Furthermore, some operations
> > like splitting up a commit into two are way more involved than that and
> > require a whole series of commands.
> >
> > Add a new "history" command to plug this gap. This command will have
> > several different subcommands to imperatively rewrite history for common
> > use cases like the above. These subcommands will be implemented in
> > subsequent commits.
> 
> "...*Some of* these subcommands will be implemented...", right?  You
> only implement two of them in this series, not all of them, or am I
> reading wrong?

No, you're right. The initial versions of this series implemented more
of the above commands, but at no point in time did we actually implement
all of them.

Patrick
