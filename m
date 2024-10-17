Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CA1D88D7
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166883; cv=none; b=BWv8BL8PPbKoqx842Xr1jvhUzVKPAQBJWIgTakKd9n5kRASbfKhf42a3jhYHiAAXBZbwBTXP120LU0hsclE0OLu07Dj3jq6YXRLVtiqw5C1SVCmx+4AXT294ZPaLatFAy2XAeobUe3aFWYs1soMFMXS7mZ4FgPWAxF3tviE8ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166883; c=relaxed/simple;
	bh=X7D8CA6HPXratxRVjI12SoLK4nJ5PujGKdNL/PRPV5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L15OY9CbY+AhCS7hOHsrJeqxoTJc4M3DwFJGbzSpIVWGL1+K8S97o82t61+N/oOvjSncX9Zt5sIkHESouPgWheAN+svpLKQOh3Gxdf6p30h7eolhgvpTqb3puW8QqoWYJIONjROD2Czc/prWLlzAQor54e+hvYhExnGSLhbryUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DuV3x9ar; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZpxMklLo; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DuV3x9ar";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZpxMklLo"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F5E311400B9;
	Thu, 17 Oct 2024 08:07:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 17 Oct 2024 08:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729166878; x=1729253278; bh=FclpPtpqbi
	vTJwr6FORwla8jH4I/nvors8ieLDuVTtQ=; b=DuV3x9arIjW2f9n6EnHMGvkGkL
	vfrbJc1ERmS+OFiEJ1ZTzMiUeloOU5yQeAxQSGKfR45EgkyK1jCPMQt6XoJmcSBh
	p3WLGXjphGk362rnApFXEAXQmYGM/2GUgtIM6McRO5fuvv/PsSfbkXg7XDXF4XYI
	t9T50vd53DsmVrs+RRTgIf/NG7LAe0HLcGEXNFKpiKwpY8HPVxSxHuMu3Oam1JgX
	Lo/i3WErcRUMmn4siRtBwARu4qAzVVw2TE2Pf1mMSPLfX/dmEowVdxie6Qllh/Aa
	9xVPomxlGZKUOKZH4pjQvFcqe7GQbfoFr/iugsUf4GTgOb5BeKZem7VV3xVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729166878; x=1729253278; bh=FclpPtpqbivTJwr6FORwla8jH4I/
	nvors8ieLDuVTtQ=; b=ZpxMklLok8ZlqK42rw16ztc1TooLn96u6pTM5JnhUZ8z
	m0FWdeJ22GgpWv8UPgH4YstZlgxbp4D7jySLOgK/bTfvxTs7iIj2L6oZjMoOj6r+
	TXUsYRaGizHZ9WvgmGfPoWZ0Qd8/hdZOledlrrbhzQSrOH+2zpcnf2NPK1qjV8bu
	fx0a5u85P5Hp6sGaGBQ8e4lSr6Ut4zdvxdW3jc7tZGs6XgVc6U+CYcoi+cUmcOcw
	ZD9haPNt2Ww7V+IdZ1MYV5mttHiXeF1kAzGulrKbHQBQJv2pVMLWwGSjBTsvh7Nn
	a4eljYzKqvTuJCXT7TCnrc6m5pcuFsWb4U0FkK9WUA==
X-ME-Sender: <xms:Hf4QZ5BgTQVRNbA1KqM1ezTnguktvdxV6wmoVDTcxvofrwiPhJJ1ZQ>
    <xme:Hf4QZ3iZafO0IsynV8iTeMxonyb6D9jUwAcKWwQIaJ7vMVNaDuON6scXfReUS_F3h
    3jNmxQVDUysa2vqDA>
X-ME-Received: <xmr:Hf4QZ0mA2AWwvYfhUOEUkTF6Q4xkJbABnV2ubq6G8cf62PE4xGwcRWg94F7QInFFlYmTJDf-hjimTNJkMbr2EfeqtDjlVDdoU6klKvc6MGjTgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeeivdevtd
    eigfdttdetgefgffehveeugeeukeffleeugfelffffvdetkeehhfenucffohhmrghinhep
    phhusghlihgtqdhinhgsohigrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrmhhmhihmohhrvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:Hf4QZzyhn9anGD2v8JrayLWtSZ3H1jqxND15Yw0rZ-NhZfgPdLkGLA>
    <xmx:Hv4QZ-RSZ7QI_cpfGiKnUOqAAXVM1508N7k7cAgr42EB0Ka2WOulXg>
    <xmx:Hv4QZ2a_jUeNxUbchoj9HNPsEE6DVJ8H7jwbK-3PHNxuCsC-HVLiLA>
    <xmx:Hv4QZ_Sz9SkgcmYInw4QutWw4mUE8h298i8zh_GHwLeozmfZXXuvVw>
    <xmx:Hv4QZ0NNpuaNH0-fRDSVhE4xQWM9md1JNmGoX7z93v61nN5yUA_ywSqo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 08:07:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de2677e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 12:06:35 +0000 (UTC)
Date: Thu, 17 Oct 2024 14:07:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Abraham Samuel <sammymore50@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	"gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [Outreachy][RFC]: teach the '-e' option for git notes sub command
Message-ID: <ZxD-FCW9drBpC4c5@pks.im>
References: <CAO1n886ZRRD6m_GQsYz-AGwpbkDB4S+0+hRx-9mmN=6iJ1o7Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO1n886ZRRD6m_GQsYz-AGwpbkDB4S+0+hRx-9mmN=6iJ1o7Mg@mail.gmail.com>

On Thu, Oct 17, 2024 at 10:43:56AM +0100, Abraham Samuel wrote:
> Hello,
> 
> I was searching through the list for a #leftoverbits project that I could do.
> I then came across this conversation
> 
> https://public-inbox.org/git/xmqqed7bhobk.fsf@gitster.g/.
> 
> The suggestion was made to make messages seeded with -m/-F to the "git
> notes add" subcommand be editable when the "-e" option is passed to
> it. This allows modifying the message by opening the default editor to
> enable the message to be edited before adding the note.
> 
> I have checked the current version of git and there is no "-e" option
> implemented.
> I am also studying similar implementations for git commit and git tag
> to help me understand the implementation.
> However, I would like to know if I am permitted to go ahead and if
> yes, I would appreciate pointers to other resources to aid me in
> implementing it.

You don't have to ask for permission in order to fix issues. So please,
feel free to go ahead.

I assume you've already read through the common documents that we have
in Documentation/, like MyFirstContribution.txt et al. Other than that
I'd recommend to have a look at how this is implemented in preexisting
commands, but you already had that idea yourself. You could also dig
into the history of how those `-e` options have been introduced for
these commands, which might give you an idea what was required to be
done for them, and you'll likely have to do something similar for `git
notes add`.

I don't really think we have any other resources that would be helpful
in this context.

Patrick
