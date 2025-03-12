Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64615853B
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762315; cv=none; b=phNjsMY/7CFnD1lwfjTMgRWAK3kl4XV/bF78tAcWTcVe1BXgRD+ccie09L13L/sLYYbvG2XSqYBrc9bsaasZDNeTreilJnmzh3NXlK745TpOmqb0NhtfAMnGjtwVHvLa98XhBTj/cBZ0QCJvDaC2khWgPB/TGBNo/7Exac6atqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762315; c=relaxed/simple;
	bh=LAJxW+9qJ5S+UJMZ7Zcm0oW/u7MJyHAtHMtgONDJmSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uad+LPCivxblXPuiXaO1gZO6imycdIoPa4M+GRfV2eX9cgXsJBRlYi1LKTKuMBUgrfLvq8YJW3knXo+vyPSBl5kJJ+A4I5r4FTPZ38TT4jQsbh/fE/LfghKQSzTwC4l/7NXuIkdlrFsro4C9utUTOhKgb4LuEQ+ijL8PkyrsSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oa7+0mcd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5tWn1+z8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oa7+0mcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5tWn1+z8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BEF9D254028F;
	Wed, 12 Mar 2025 02:51:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 12 Mar 2025 02:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741762310; x=1741848710; bh=R9Sam7+vwb
	zjIL38R+KBBgmEOXdtBXdmOOk1qxEd/bE=; b=oa7+0mcdrKREv2dsNXtak9O8u6
	lJOzHhLkntmLXPTUi3aaaZASXUC+odVRKcQcg6TBwZlx5BVkl1eshqW/BJAI+zOQ
	CwoO3MpWslLUxrvWrrulPFlErZVs/+mNO3MW+15IOm4iHF4i0ymGsqYnHOpXgwMQ
	Xj43bJeck8YpQfrPv5oWAOVFeHwpexSVpXO51AuSgiS07aDGyTj+KvIzc6jylQfh
	AbUZZRphyasnorkysec7/nabU6L/efXrG/y+/fdEtDzzQBLUVYbqA0QI2uq2TGhM
	+lKaCu/9nnveKybkM/pDFLKxKfqQ8SwXvW9tC37H5eUfxssFYQD3i+RgO4wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741762310; x=1741848710; bh=R9Sam7+vwbzjIL38R+KBBgmEOXdtBXdmOOk
	1qxEd/bE=; b=5tWn1+z8lOSYOGbqkxjeyuTJILjrYm4O199ng8cblLKS5K+Lt4d
	JMipUCJ6896wSn9FusaK/fQhY/qSFhxxTMe+fM1phYABo7h+IkEx9Y048Srcbs+t
	94tVQyjysVxeTUkP09B3XdNH4xJgtKb/YIn7eN/AVwfoKy6Z3coylGOEkZIQjK0C
	PI50UCtXJx6vG3Ad5IYeVdqKMx8NRRrgRietpimuuUOahdwDNW7SBxUwDoqltwaO
	C5tknXQ8OOi+aR9n3boLq+Gsd6lf6CL1j2heK7Q9iuzLaxFi63SZT5GkLf3uS+fM
	0li8Rj44CYhXSew2V2m+SKv/HjQV4pZw1yQ==
X-ME-Sender: <xms:BS_RZ9TllWL5HkrDeB3h8oIr67dI8VvDrnUmYGtmaTAMVkxRwTg8vg>
    <xme:BS_RZ2xvtaUp3DpXt2LiMyFdCS2wtd-9y0RXBeQ1OQ8jCMQhs-dEv9c2forEJ2UWT
    Zh5hw0DJgh4suAEqQ>
X-ME-Received: <xmr:BS_RZy3RS-dl-hW5SrSbZOGHlVUVetQjLLkCyvkdcii-tuudO9ExpBUmx-qNVm4cWNiaGxp5a2sjBUEDsVmMf7gGchjTk1oBhqmLHnTvk1i6H518GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedv
    geeiteegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtoh
    epthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:BS_RZ1DqlbknujeoSv3dT_52ZSsh1WB-s1UwVPJPQEYyVXR307xe6Q>
    <xmx:BS_RZ2hoXFPgJ5VHo5bIiswrK0nXoBmY_POR_6qzLfxU7m6xw9L_Zg>
    <xmx:BS_RZ5qA7HToGUfADYh6Rf6VR5R447Vl1FKFycbdWZ_vfa-jUoZAbQ>
    <xmx:BS_RZxiv0tCbcYFvwYuNeupZGKZhjxCkENND9aXxj8AJ5QdD8-Y8kw>
    <xmx:Bi_RZ6isSW2sYQsP4krCHbFlFolnZ939hazsUmRX9LOCGikMNZISD4uA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 02:51:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c9afa75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 06:51:45 +0000 (UTC)
Date: Wed, 12 Mar 2025 07:51:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Justin Tobler <jltobler@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v6 00/18] reftable: stop using "git-compat-util.h"
Message-ID: <Z9Eu_fZbI8ndkzHw@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
 <xmqqjz9nkrqt.fsf@gitster.g>
 <xmqqa59r2lk8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa59r2lk8.fsf@gitster.g>

On Tue, Mar 11, 2025 at 04:29:27PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Changes in v6:
> >>   - I have rebased the patch series on top of "master" at 03944513488
> >>     (The eleventh batch, 2025-02-14). On the one hand this gets rid of
> >>     the conflict with the zlib-ng changes, which have meanwhile been
> >>     merged to that branch. And on the other hand it pulls in the new CI
> >>     build for MSVC+Meson, which allows me to have better test coverage
> >>     on Windows to better detect breakage there.
> >>   - Stop moving around Win32 files so that we do the minimum viable
> >>     change in this context. Hopefully, this makes it easier for Dscho to
> >>     integrate into Git for Windows. If it doesn't I don't really have
> >>     any other good ideas for how to do it, so the only alternative would
> >>     be to just ignore Windows altogether.
> >>   - Link to v5: https://lore.kernel.org/r/20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im
> >
> > Thanks.  I think the "unlink" thing on Windows I have was queued
> > depended on the previous iteration of this series so let me make
> > sure that I'd unentangle it while replacing the topic with this
> > round.
> >
> > Will queue.  Thanks.
> 
> So, sorry I lost track.  I think I saw you ask Dscho about the
> Windows specific bits once in a thread on What's cooking report,
> but I do not recall the outcome.  Is this topic (and the unlink fix
> that depends on this series) now OK, or would we see further updates
> once 2.49 is tagged?

There was a class of test failures caused by mismatching allocators in
Git for Windows for which I've sent a proposed fix for downstream [1].
I've been talking to Johannes on Monday and he mentioned that he'll
likely end up taking that patch as the pragmatic fix. Which to the best
of my knowledge would mean that this series here is unblocked and can
start to move forward again. Johannes, please correct me in case I'm
misstating anything here.

So based on that I don't plan to reroll and hope that we can move
forward with the series once Git v2.49.0 is out.

Thanks!

Patrick

[1]: <Z8bQsflIqzZd3AMs@pks.im>
