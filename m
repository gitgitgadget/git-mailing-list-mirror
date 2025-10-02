Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2CA4D8CE
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419191; cv=none; b=lLXKXZJx8CBZOOhPSFnBxhi1YgBi/0v4p77NFdsOWrw5t/ja3Br+UTcQcY39f3FkctTH/CJpcZs7zRIuVDriTP3k4WkXtE4O+cT9doTi6UvD+Eer2gA0VWQVgO8N80sC4QDZTOFYATgqWV7J0NAR3jQb3K5/rCc10kJleIi4kxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419191; c=relaxed/simple;
	bh=ZvVAx6psiftTJPlXbDkV0j6AwGfErYa30dDydxyicm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUf7J+ucOEtcVB+dAaAl8NuslQrSQbY4POImKsm+dvaOynYdi2hxVKelbKXQdqewsxuxpTyOr7WoT3HYIQccqZVkvQH0IF0dowX6rbEhK3cEwYIe0P0UVDs1l8+PRiSIfB6PsZuvOjNz8c6V3VtoipOrDjStVQROb2xxPy15Cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kC7b9xMD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uTnSXHED; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kC7b9xMD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uTnSXHED"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E509D7A0098;
	Thu,  2 Oct 2025 11:33:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 02 Oct 2025 11:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759419188; x=1759505588; bh=3SEL/kJnUS
	7w5mrAJ4Ph9KgPSWJwefpVIoaerqeeWK8=; b=kC7b9xMDlD1K7PDrN46cVwY3/W
	xfed+6R9tXUYBNkcvUBQHTN3KeyGNRNNmVp7okeieNY0bYuQIrWiQurb0+TF5Os6
	wP/USqhRjZcP+Zz1OpDrI4VZb7JFLi3idB87auI6674DnWA3ALqR26wpe2LmHO3A
	WX2hW6xCthkQSSt0mKJioXqhPUTvrFOd3kzNHOWKsajqurCN9fbYT0b2Nft5kbLt
	vvrn6yPqZzuoigabpoVxwA+yEbecBvcF2Am5CPhOaRy3dSjvHkwgSx6FrD66Nm5S
	wdVJ+GUiLYSOtIBsL8M/HL5CsY5qxqERduX5Y05QTxjAOzWK1vF+AoP3oBEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759419188; x=1759505588; bh=3SEL/kJnUS7w5mrAJ4Ph9KgPSWJwefpVIoa
	erqeeWK8=; b=uTnSXHEDOm6HGQ0dh3FWHRFVhLdgNPCgtwtDW22CuhIRNrru5XM
	JwI9f6O7M6TiXOoM6beiGT7d4xSM/YEB3kFAq7tFU6h435ZRG9kavsCbSPmpJI3a
	nWvtoF+McO4+m4bb7h6xKtUhiA/qDDqW1dQQTTDDfJNgJ47l7tiEGI9yR/q0erpw
	sTdzZVH3xXroEEi7kxKWIMlffD1lLZsE8utXntUEbMXLlgVZEX2M216O+OyClkWd
	VDJXapllOEmiACn5BDlzQqiS8gYEV+rw+k0/9gp8T6Er2T1v05/ni5njDnfnOLn8
	AORwVRH6VdLfubn7lxciC7z857rvMUk0f4Q==
X-ME-Sender: <xms:NJveaD4TBkYkTIlVzSJWO0vRURre81jtnNg31CnQsNLSD9SHV19raw>
    <xme:NJveaP6lNipP_k5FTdyfDJyRm6Y4t-0fEzt_iixTngRi14_BRJlTHjPJRdj0UF2O1
    vW7E_SBxX74m8mBNeyaKkeuMHMRnBo2baAjNYyXhMVlsAym-1o->
X-ME-Received: <xmr:NJveaPfueMpUOdDk6YqMMo0baE43j3axgawl4VeCD-uZ7wXBCaJU2hKRu5-1ekjjpN0gkoPRTqmovl5yui_QA9A0QysKAAHL-qahQ5vqyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:NJveaDC3AzOqODHFeUTX4KK0gFvVTnzZYyKpA76Z6ghRvN3xvAkMZg>
    <xmx:NJveaC9VqzyxYTCcEtUPqxWb-D8bOfLJtaeltjZK9Qqy79lh4L4_vA>
    <xmx:NJveaOLMZVu7NmzS_Roe2CC3VukQUkeUfGXRHrXg80EOU-sqhbnuaQ>
    <xmx:NJveaLhbrsSIcBepcjFQZs8dwx-H0-5T5VxGyXO-tgvmgmK2LUZUeA>
    <xmx:NJveaO_PqMRcB-EpOhMTH7YIrWMyugxMXL341dWuWi6fSfxj94SBjDBG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 11:33:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 234f6280 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 15:33:06 +0000 (UTC)
Date: Thu, 2 Oct 2025 17:33:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 2/3] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
Message-ID: <aN6bL07N8Qz6USTf@pks.im>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>
 <aN4R51_j2ieF-sjy@pks.im>
 <xmqq1pnlzayy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pnlzayy.fsf@gitster.g>

On Thu, Oct 02, 2025 at 06:31:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Oct 01, 2025 at 06:02:27PM +0000, Ezekiel Newren via GitGitGadget wrote:
> >> diff --git a/Makefile b/Makefile
> >> index e8fad803be..d89ba03286 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1397,8 +1396,7 @@ XDIFF_OBJS += xdiff/xmerge.o
> >>  XDIFF_OBJS += xdiff/xpatience.o
> >>  XDIFF_OBJS += xdiff/xprepare.o
> >>  XDIFF_OBJS += xdiff/xutils.o
> >> -.PHONY: xdiff-objs
> >> -xdiff-objs: $(XDIFF_OBJS)
> >
> > The removal of the `xdiff-objs` target isn't mentioned or justified in
> > the commit message. I personally don't mind that this target goes away,
> > as I don't really have a use case for it anyway. But in theory it could
> > continue to exist. So I'd either retain it, or explain why it goes away.
> >
> > In case it goes away, is there still a reason to have the separate
> > XDIFF_OBJS variable? Can't we add these objects to `LIB_OBJS` directly?
> 
> Doing it this way lets us still keep the "logical" organization to
> tell which object is which, even though we may lose physical
> distinction by throwing all objects in a single library archive.

Well, I guess the logical organization still exists due to all the files
living in "xdiff/" and "reftable/", respectively. So I'm not sure that's
a definitive win.

But in any case, I don't have any strong feelings here. I mostly
wondered whether we can simplify the build infra even further.

Patrick
