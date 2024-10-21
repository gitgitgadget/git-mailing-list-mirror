Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFA1D1310
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514064; cv=none; b=L7hpyJ1bCns8465rmbnFA/pvN+aq9cezlaCtdMGJilCgyrl9+xom5tOo+Tf28oTHLmMpHx+azae72fExPLId1WTO4Y8VbQAGVQh9r9XBhlVtbLD9VvdvcG7cUX0IJKQLZu2I+aP1NPBdIQNQeZdZPXCU5UM8JfGXYbD1WhHIYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514064; c=relaxed/simple;
	bh=8SFvlPK4caCk6jR8EkmMKnwDo5id2HPzUUv1Swg4ELM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZZfzJXAoQNjxfopK3ngoRsqjMo4u2ZD0tnL5uiIr8aRG7OxIh3LMZiAwxnzT12+4hg8svom4FZ+PQ2/21c0lJ89+Gq8Atvoq65gqc+YunRQl9fSoyeMsLZn72xvnPfI2i4cvI2eHBVEOGeiVWcl95Dyc0bVJ/XiaZOEAibNKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=5VqUA4HC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KaU569nk; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="5VqUA4HC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KaU569nk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 024F9138019D;
	Mon, 21 Oct 2024 08:34:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 08:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729514060;
	 x=1729600460; bh=8SFvlPK4caCk6jR8EkmMKnwDo5id2HPzUUv1Swg4ELM=; b=
	5VqUA4HCou3QYBOK9FGUadJ0d6V4c+o2dJOt4joyKEMuPuaRlbPbccVfSRizIMeg
	KqwtADZvnrPunsgL6GvHro9QakMA8siO201enIjd+GwXsAX8qIPYoQnH5l4kqzEB
	6Us6vr0yEL77dNItyQrAOjzqOUWykGXbrgIXq/glJCbZ29FHKT8hIWKu+BG4wniF
	8mUeayRd39fFcRq2npNWKhN++fM2yFpo2bC2GHF6G3qBH6q8OqE186doSvO8E0C0
	Xiom/iOAat9CZF8sT9JgkeoZkrKUVAMrPra3pXqjNKrdytjIVoq9uy2WFWc18EwX
	uj0ESyhU77w0Qgk9bdQmTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729514060; x=
	1729600460; bh=8SFvlPK4caCk6jR8EkmMKnwDo5id2HPzUUv1Swg4ELM=; b=K
	aU569nk6oUFhh56RvRYmYFdzwRe1dWwTtDz1WNY1ueCGQXy13Y0YOFhQC6nVXvKx
	c/MW4I072xk8vXhA0paDmbj7yjLmI2eZlG3jW8/7nqRrUsrzGQD3w1KUcL2UgOXR
	hZnw3HTQY32b0YJ9nfdug2AzpyoobEg6a9r+kamUKGhKQB1duk/KpZds9WD5WYCR
	muvTFHonOLkReNfP+SMUnYYAyFN+hy2KrS6PeUOEURPAechFUHTdiaszQOBOhbCg
	6vwgIpONvQwGc6gHbn/4jH2YW7NxSCON7XuMhfDV2KblUsJ3wG3Vrb5DPIY8yngr
	PDwQX6JgACcyrUOYZxhDQ==
X-ME-Sender: <xms:TEoWZ-asfcYLyiTPZUxOVU1KiE3BdBIEHVEfPpboJvvFyNN59Ev9nQ>
    <xme:TEoWZxZe14y8xwPPdE8YKZ-0wmWoNjH__u6Q52B7hrNOYCL-foGn08BEy4864ESC6
    XeIwh_xwgzWElPbpA>
X-ME-Received: <xmr:TEoWZ48r4z0W8dspsHl6xHe-DTO7jynURqd1_xmhN3xDRQOcBzTRgPPLFOJVUFxYpgfj4dvB28di5bOOENk3Xb9VidJhp2jid2sYfVAnqw09>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TEoWZwpyk-Hapa-D7rJgJluFfHpIwpI6bDaAi1fgleXUFk-aaNPYVQ>
    <xmx:TEoWZ5pOuI1v0YeLX6v90H0v4XuwBeENO0CCwjga3rLPxpgYLIwNGQ>
    <xmx:TEoWZ-Rv9nDY2w4MuZ_Gab08E5ehhvaWlSyAwQmx2wSWh5-Np23VTg>
    <xmx:TEoWZ5oNQtIudOVmnUnUHyNdrkVc3-n7gsrlp84HeE3QXt8cUlLrfA>
    <xmx:TEoWZwVu30xLiI_cGHc1fxn8LWF-mfzI0h7jmp9t3b4-WrZqVwJ9B7Ag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:34:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c94cb95d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:32:48 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:34:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
Message-ID: <ZxZKQrc0Ch_YA1IV@pks.im>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHIk-gH0Onpt15@pks.im>
 <CAPSxiM-wLZfA1+1zvfjW-PN=Zpjrgy3KR9c_jrb=we7vhvoUYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM-wLZfA1+1zvfjW-PN=Zpjrgy3KR9c_jrb=we7vhvoUYg@mail.gmail.com>

On Mon, Oct 21, 2024 at 12:27:05PM +0000, Usman Akinyemi wrote:
> On Mon, Oct 21, 2024 at 12:20 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Oct 18, 2024 at 01:53:00PM +0000, Usman Akinyemi via GitGitGadget wrote:
> > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > >
> > > Replaced unsafe uses of atoi() with strtol_i() to improve error handling
> > > when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
> > > Invalid values, such as those with letters,
> > > now trigger error messages and prevent malformed status responses.
> >
> > The line break after "letters," is a bit funny.
> I just noticed that I will change it.
> >
> > It would also be nice to point out why this commit doesn't add any new
> > tests. I guess the answer is that we don't have any tests for
> > git-imap-send(1) at all, which is too bad, but a fair excuse and not a
> > problem of your patch. So introducing such tests would be too much to
> > ask.
> I can try, but, why was it not introduced before, is there a reason ?

I think it's mostly that we'd have to have an IMAP server available to
test sending emails properly, so the test setup would be comparatively
involved. Nobody felt like doing that, and thus we don't have any tests
:)

Patrick
