Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870AC1632F0
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091141; cv=none; b=IHEfDV2kUUWasKzVYP5H6bL1wmYZ0Dg1PHq23nerNNk95sZjSmhAytiAMqcVVyVxU6t9K9z4C+DTkLKtUAQ72+QXmiGvi57jtXHuRmKSA+tZIaI3aNEeFTrvBf2tubqybLseTjeKePgCQl9wjz0R7hzTJzrdaVrg79MDZuyNInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091141; c=relaxed/simple;
	bh=TmvDjbeneuN45++upiIEKbKlpcDTCVdH/oQjCSTeGnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bwvi8ccfANuW83N4pXP6ZvDfYFbM2ZIlEtX/mkilxCdmRn6xyPPtifGusD/nYVUH/9QlbHfVptxAk5SdoPWNWeEFUIiGrrFR9IoP0wZhU+z8B3uWgz7WGv9mqBs1PbSLacPKck8FOVn3pLc8pxDmDbUaxFVGNzK9U3mEcg6tLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NFj4Ighj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZP43mJ9q; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NFj4Ighj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZP43mJ9q"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AA26114021A;
	Fri, 13 Dec 2024 06:58:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Dec 2024 06:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734091137; x=1734177537; bh=I6c4wC31Yv
	dCBYbhC/6GZwZEmhipo4S5VJtqJzB3PBs=; b=NFj4IghjxYsH9AfP1RenzQ/uAH
	fQ5dS/RSMGiVK3HJpgK++zkjipqg/d3kyevhlftpGAv3LutpMI9MuNBcocklcbdM
	Y7ExqzYnASyLs9wtOBNU0XgRTHPqcc8n1+SX7qETVzYkQPjCrVmmNSbz44aGMST9
	vtVG4SR9NPLB3Bs67VGDVKHNmVhwCtiQH3rjCLEnHAJiTlQISlgoKvhLwCbFHZQw
	LpyfHjio0Fv3zEm/TTLMpLnqv6OmBYCxCmTAZtEnw/lPsaaAeZcp0+wJH4Y8fdFT
	9zO0Xh+0IXQb3nvB1ruDCHHq1Xg3Kmscnp4M1EJ4m7OXbrppcrEluPx4bWqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734091137; x=1734177537; bh=I6c4wC31YvdCBYbhC/6GZwZEmhipo4S5VJt
	qJzB3PBs=; b=ZP43mJ9qJDlD0vrRBhkfXFlvIm1Q5YE3QZrHYfLfYDGNtHpGf7/
	C9JS7wyAInSkEugEhrEMDRs4wd7sUiTb4s/paEJqFkfmMp/ZKmmQZUkrvpVrbe+u
	CRNRrrjPpt8ri/Ccrr6XWuo72AabymlL7fng0bMKXERJbELFr0MBGEv3jh8+gTI0
	EnQJYNqbeFxp14MJMHOQLiLUQT7FZ8/RzIlde9nEdHfr1rQeHQ96zv63tuiFMseB
	rfhCeO0Nx4tYX+RGj8LGscbKm7fhR1gSBqro/1Ha7uPy4ktUIvFeznV0LfV65yKS
	s6N5MdzykfmHmI/hOvotf3cvfIOr2N/k15A==
X-ME-Sender: <xms:gCFcZ3dat7zurQnXXphSfa8E4YJQJycVAsgUw-UAmwR9hr5Ildp7HQ>
    <xme:gCFcZ9OKAvXqXrnTRAS9G6txfzIrIxbNt5xxobFhXTy-jfnAHNINzitVVfzcFCD1w
    0M2AZsB1g0xt_Y5cA>
X-ME-Received: <xmr:gCFcZwgGs4bGIMDJT6LnVkny9c2BawKWKMclQ58jky1ZEZSTTpXOz3UWxGAA8VXTsE7yEdIohp_Ang2chRXyqJj-ZcK2-OrILqt_2YR2p-hTjhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gCFcZ48t6PVxe4PgJU1KFKI_5SL-B4MTvSu7y9XpwO86RV3GA6IBHw>
    <xmx:gCFcZzuk4YrAWfoxJZWOg7kN1Y_Ch12B00faM5iI6j5cEIbpTJ7YZA>
    <xmx:gCFcZ3GL6uyoAZTzrbnQDIWCmVNa7VNMvi8WZyVghQXVPx903aNyEQ>
    <xmx:gCFcZ6N27pX7RkMBfScgrtL-BmXr3asd02269J-pC-l6DpecVJLlaw>
    <xmx:gCFcZ8M0UYO91_zt2MkC0MXsgKxvE6azuAgy3oJfOMg78vs7YR8YKbfN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 06:58:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0aa04e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 11:57:13 +0000 (UTC)
Date: Fri, 13 Dec 2024 12:58:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/7] PATH WALK I: The path-walk API
Message-ID: <Z1whbcb71srg3hju@pks.im>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>

On Fri, Dec 06, 2024 at 07:45:51PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> Introduction and relation to prior series
> =========================================

Sorry for being late to the party -- I wanted to review this series a
lot earlier, but never really found the time to do so. The patches
mostly look good to me. I've got a couple of nits on the first patch and
think that the error handling could be stricter so that we don't ignore
anay kind of data corruption during the walk. But other than that I'm
looking forward to the usecases this API will enable.

Thanks!

Patrick
