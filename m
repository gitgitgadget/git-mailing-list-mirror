Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BA231C8D
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960047; cv=none; b=AGddsAmo7Pd8EN1qI95KETxOtHsnDehlOZe8L+azuGrWynhZt5+yLUDL6CTeAuesyHBJkgzzS7SUPGEY/e2cJueqqL5rV0vTJzaMRgqVRokpGZJH4YGY0dkoc1pXP3V2t4RjYCdJHJio9JnaaMYhqwKQP/y8P2wLV9TdwIVa8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960047; c=relaxed/simple;
	bh=NZvbEn+FZJqB6yIbH1RHrSl5Gy08GBzMglrTYNe70ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUmROzIEU+87QfDXuE0jbEqM2oLl6IW3liupu50ymNkfIngjxH5lhwLTaDh9PqdeH3v2DsA/zg3YIBPZ195hqje+whSDb7TWo07S4E9QKQzLEss8lOmmb7Ynjhy0lR2PpzjpFSZTQ9wLH3chFEaaDE+V98V/WiOl/c9cFLE9FQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ms0ypGLA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJKrfXfS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ms0ypGLA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJKrfXfS"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A75E1140106;
	Tue,  3 Jun 2025 10:14:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Jun 2025 10:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748960045; x=1749046445; bh=lcVSsomf3L
	JJePbsE9hFbpz0F211ncFT56Z2HqL1n9w=; b=Ms0ypGLA1HcSZrXb+tZAfQH1i+
	k960pZJTBcEydT+b7vqmo8LlBOp8U+cCfmQIfbPduQzXkRfVUtuQM/QOjY0yOoa9
	HapvnKFgCKTadR4CDS9c/N1zVCEayCVHflZ1bezVqkABbBjmNRSd4QPLgWewnUm6
	eS0RJ2ypMjx29SJrmo6uAkXNSJ3y0JazuKKCzVYdC+CFVgzNf+ngwuerPba/Eme6
	ycJMfX4hL9IRi1U2hMrjOAB18tLt6G6yW9ypZgLNrE7GHYBCEFtxY1vBVJsVyV72
	rf26wIS9QHWlso12AugLmyWrgdpHg0sHFC3LfYHxNruEF8Jo9cjF8zq8kjRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748960045; x=1749046445; bh=lcVSsomf3LJJePbsE9hFbpz0F211ncFT56Z
	2HqL1n9w=; b=CJKrfXfSQmbiOXukcxR58a7Cc4VqhvqIjVVF63Jtn1tSjNaUgfo
	0eDdiLGvaQu0PoDzv4F086dOw/YD6jeOaKmcxVuGmsqAs9648tQvJiOW7nDy/3GR
	1n9X+JskT8QRumveYtHad5KimCHYykQLzuUkgQSLvqQBcyKYlEH7jXfpnf4HlHLs
	3/Ba3WZOZHKV3txk7+DHjg9QC9Nh17WDk88xPEDCTJtvKLkF98ZGE//MSOShEAnH
	FwaeyXp2o1iqSzZ9KVM4muWoWkgmZJsQxgsx2iG7euValjqBxa78DKKZya1ydd9t
	vuVA9EiParGWqX/hrxzGssvwBv5QMNA+HiQ==
X-ME-Sender: <xms:LAM_aBN5z0OY5ah4OEZ1QtIrrgX-VA1nVsm_HaeDt1lbkdkeLL3z2w>
    <xme:LAM_aD-7l6Vkp5Zw9nx_mLKyTA7d7KaygRwXDcBoZLoK-Zo0DuhUl9MxRFhVhWfCU
    zjO1Q2tgCHsv3NpJA>
X-ME-Received: <xmr:LAM_aASsSQv5o8w9qpXMqvvZcugDjfT5QnwNSxDURex5LPbk9UfDX_KhAmYiHor3VooV_1vBZf7XjX0WqdG3Pyvzwy3adl72wlVWOf8Z9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LAM_aNtBfU-ZHaiV4QxEonF-6XDi1V3mlC_QwyUYtrKfCVAhQH3OQQ>
    <xmx:LAM_aJeQpz20zFhJvHL5Thc2xPCxaE8jlm0vwUtqUgqE5Ey5umc9TQ>
    <xmx:LAM_aJ3WWooo2nqz1pBRenJA_BzExzpFZ_GvDjZjj1w8QjWGvAjMOg>
    <xmx:LAM_aF8A2Pbq2cGx7NhjHhI8Z7IJaO4SojzJmvyOZTydNqc-C68eqw>
    <xmx:LQM_aJym0f1iD87JFgNDeG1guFhWFMkvenUjWabamWQ2Eo8aesKkwDiV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:14:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a5945bf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:14:02 +0000 (UTC)
Date: Tue, 3 Jun 2025 16:14:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 02/10] t/unit-tests: convert reftable basics test to
 use clar test framework
Message-ID: <aD8DKUrPEi0robtt@pks.im>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
 <20250602122559.208780-3-kuforiji98@gmail.com>
 <aD794N8AjBqw0N43@pks.im>
 <CAGedMtcaV5r-hVn_aPP=AVCV-Wx0uX-yPqcOijxJh+qTSDJXrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtcaV5r-hVn_aPP=AVCV-Wx0uX-yPqcOijxJh+qTSDJXrA@mail.gmail.com>

On Tue, Jun 03, 2025 at 03:03:45PM +0100, Seyi Kuforiji wrote:
> On Tue, 3 Jun 2025 at 14:51, Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Jun 02, 2025 at 01:25:50PM +0100, Seyi Kuforiji wrote:
> > >  Makefile                         |   2 +-
> > >  t/meson.build                    |   2 +-
> > >  t/unit-tests/t-reftable-basics.c | 219 -----------------------------
> > >  t/unit-tests/u-reftable-basics.c | 227 +++++++++++++++++++++++++++++++
> > >  4 files changed, 229 insertions(+), 221 deletions(-)
> > >  delete mode 100644 t/unit-tests/t-reftable-basics.c
> > >  create mode 100644 t/unit-tests/u-reftable-basics.c
> >
> > Hm, these still show as deletion and addition :/ Did you try playing
> > around with the creation factor? What is the exact command that you have
> > used to generate these mails?
> >
> > Patrick
> 
> This was the only file that came out as a deletion and creation. Below
> is the command I used:
> 
> `git format-patch -v3 --cover-letter --find-renames=20%
> --range-diff=upstream/master..convert-reftable-clar-v2
> upstream/master`

Ah, true indeed. Never mind then, I think this is good enough :) Thanks!

Patrick
