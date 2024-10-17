Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD8190055
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155194; cv=none; b=JjWkHAhOPfIxg38P0ZoDwIiVdpAyLPQc5LTdVMvEUv+PMDBCWFOZKijybBlRD0Fn99oeeJGAOQAIMY6amrazhSD31fwQYSW43NExnaiHJb+ZelqT+DNeI9a4GAnxrMWIQMbF9VhRQw9TWX0OL3WaGXTX0oLkg7wlBZXD/4J1vGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155194; c=relaxed/simple;
	bh=/rRmZN4T23keXTYkpPnpnp6mkjOuyzvk1dVVlKU58LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji4ycLU2GFvP6EtNwFruw/BcTeXhI5vYvQCoC6DgrG2lg9UDLyvAC2N/T1tjnu19eQGXiIZ0Ky7inNZAxlvxNRb8lJVN+cTZFW2f5n9/23SdEEo7eatWlOhYK5xmRRbdCt8RKCsOFLt+ZCVPF15Z5LZx1yuVXQli63nV/9W3U/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sZsSys3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kifqtkxP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sZsSys3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kifqtkxP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D9DF2114009B;
	Thu, 17 Oct 2024 04:53:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 04:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729155189; x=1729241589; bh=iNPeil+pDd
	ubP7HGDufromVeEmy0XwRaIoH1uyYdhCM=; b=sZsSys3OGT1YvbnlhJ9Jj4IBhu
	y40tvjEZAUlRJXkfEEIxe0V3yZeLGvkBryajMjbqFF7iZHhjs6i5nnUeWWxhknJg
	xP9c39oGvZdhR9kdPjdHQahBwoC4VnW+6LGsNMO/TLKnzRuO8ZZIno0HMofKm4hB
	8gfNc/jesx4xHnATrD89C9hW/ytvZr+qw2oGsdsfucHDqbOuKLTBKoY6XmyoprK0
	MjU91W/4w9sKurI2ns/KSF7yXe8s1vghvZfkQ6RWVYtEVZWV2URK0TWQhRwxxidz
	eUJajxgjklsgsp4RdazjRluTyKumlJKZnxL+owa9IsJBxz657LTdGZ3JiwWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729155189; x=1729241589; bh=iNPeil+pDdubP7HGDufromVeEmy0
	XwRaIoH1uyYdhCM=; b=kifqtkxPBTEuHDYPilZU9pCN29b4pQt1dWEhGBi7U6L+
	IZxX+ttUWmG2y9AqNksRfc+iW3l/DjicbL8tDC6CfcQyXTubyRwlM4RN/DGRG4ge
	tw5SEseZvGdyFIcIqQ1RtlbnGEBETst9P6yqBW6PdGmPtMOQ9BMyLS3xDGVQ3RQw
	6R/omG1sbQIHD44K11VVLd0JicCy3tnwMXGrUR3CDYgV19DVyxUeckWLhztE+X7q
	lKwDNWzmNmHH3wesgd3ZmTh6HautbhmGs2Y7akHh3gixEyMEG48kB624O+2yEPGh
	mokpC2sTPDfTf0lL0jkBufoYsUnDnW8t6b4TfV5UrQ==
X-ME-Sender: <xms:ddAQZ6DbSHIIyH7JfJ2xZI0IgN2DtrNgpKePF7kHsJMZpmF4eQckdA>
    <xme:ddAQZ0hfzZ2ER7eAgawxOZMVSeSr83AEc5t_mJVrZ4ffn6aOEiryyQ54nRUAsIIuu
    kAhRNio2NrTLwH-Dg>
X-ME-Received: <xmr:ddAQZ9mZzPFhRy23L4eLwdQOm7tVrzNj23QE3IYsmc76N5k6avZhK-I28BH6e4pijetEEArwnClomVf9pjdR-GY8REWjG9asrVbhAP3hc_dqCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjedv
    iedvudfhfeefveejheduteetkeegtefhvdelueejtdehgeelkefhhfevueefnecuffhomh
    grihhnpehgihhthhhusgdrihhopdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkuhhfohhrihhjih
    elkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:ddAQZ4zjRQ3aYv5WExHBye3YL1NPXBgfwbi15GZBzeRXA1rXCn6hKg>
    <xmx:ddAQZ_Ruhdr783yiEWO8S1FDQSQgI6KhPBRpkvBLzCU168CjdT9h_w>
    <xmx:ddAQZzYSVk52CEgqXTofKk_maxBlF02LLSjFnNfzxNdEdJFnYjagUA>
    <xmx:ddAQZ4TWZ78vwj05dKpFjrIAUIkR6tfDvBb2NruVMMUL_Qp1sinjxw>
    <xmx:ddAQZ5dI3p8nzH-NhBCaTMLSM3UAMVysuq2XML-L3sfqiAWxpZb1FeZT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 04:53:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac611617 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 08:51:47 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:53:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [Outreachy] Internship Applicant (Contribution Phase)
Message-ID: <ZxDQX47MuMED_bB6@pks.im>
References: <CAGedMtfng3eqH7DY=2cnBPdrEWyPpJmEFwW5vBH3ruz=b=ym8w@mail.gmail.com>
 <Zw978QPS0jQMOm6I@pks.im>
 <CAGedMtfo2RhrPv5BC3ci6tW0XW9ZG73yMD-_sJqe+oR4Gb_dvg@mail.gmail.com>
 <Zw9-YYpbu9hMQQ7y@pks.im>
 <CAGedMtcf3TcaZUu3+=Kz-qXAikSjxpi-ULdwyU=Az7pmxyju4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtcf3TcaZUu3+=Kz-qXAikSjxpi-ULdwyU=Az7pmxyju4g@mail.gmail.com>

Hi,

On Thu, Oct 17, 2024 at 08:27:13AM +0100, Seyi Chamber wrote:
> Hello everyone,

one note up front: we do not top-post on this mailing list. Instead,
responses to a mail should be either inline, quoting the parts that you
directly respond to, or below the quoted mail.

> My name is Seyi Kuforiji, and I am an Outreachy applicant. I have read the
> following documents;
>  - https://git.github.io/General-Microproject-Information/,
>   - https://git.github.io/General-Application-Information/
>   - https://git.github.io/SoC-2024-Microprojects/

Nice to meet you, and thanks for your interest in the Git community!

> I want to get started on modernizing the test script:
> t/t7011-skip-worktree-reading.sh using the specifications discussed on this
> thread:
> https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
> .
> 
> Before I proceed, is anyone currently working on this test script? Is this
> a good first start, @Patrick Steinhardt <ps@pks.im> and
> @phillip.wood@dunelm.org.uk <phillip.wood@dunelm.org.uk>?

I'm not aware of anybody that'd currently be working on t7011, and
searching our mailing list archive [1] didn't surface any recent mails
that indicate that this is the case. So please, feel free to pick it up
:)

Patrick

[1]: https://lore.kernel.org/git/?q=t7011

> On Wed, 16 Oct 2024 at 09:50, Patrick Steinhardt <ps@pks.im> wrote:
> 
> > On Wed, Oct 16, 2024 at 09:46:04AM +0100, Seyi Chamber wrote:
> > > My Apologies Patrick. There's a second mentor on the Git project
> > > contribution page, I mixed it up :(
> >
> > No worries! I basically assumed that this is what happened, even though
> > I was confused by you mentioning MolEvolvR and not Git ;) For the future
> > it would probably be preferable to send the emails to the both of us via
> > Cc such that we don't answer to you twice. I've done that now.
> >
> > > Yes, I want to contribute to the Git project and would love your input on
> > > how to get started.
> >
> > The first step is to do a microproject in Git to demonstrate your
> > ability to adapt to the workflow of the Git project. You can refer to
> > the following links to learn about how these are supposed to work:
> >
> >   - https://git.github.io/General-Microproject-Information/,
> >   - https://git.github.io/General-Application-Information/
> >   - https://git.github.io/SoC-2024-Microprojects/
> >
> > Let us know in case you have further questions! If so, I'd recommend to
> > also put the Git mailing list into Cc with an "[Outreachy]" tag in your
> > mail's subject so that other people can chime in, as well.
> >
> > Thanks!
> >
> > Patrick
> >
> > > Best Regards,
> > >
> > > Seyi Kuforiji.
> > >
> > > On Wed, 16 Oct 2024 at 09:40, Patrick Steinhardt <ps@pks.im> wrote:
> > >
> > > > On Wed, Oct 16, 2024 at 08:52:24AM +0100, Seyi Chamber wrote:
> > > > > Hi Philip,
> > > > >
> > > > > My name is Seyi Kuforiji. I would love to contribute to MolEvolvR. I
> > am
> > > > > skilled in programming languages like C, Python, and other
> > programming
> > > > > tools.
> > > > >
> > > > > I want to join the public channel for ease of communication and would
> > > > love
> > > > > a pointer on how to get started.
> > > > >
> > > > > Thanks in advance for your help.
> > > >
> > > > I guess there must be some confusion here. I'm neither Philip, nor do I
> > > > know what MolEvolvR is. I _am_ an Outreachy mentor in the Git project
> > > > though, so if that was your goal you've got the right address. :)
> > > >
> > > > Patrick
> > > >
> >
