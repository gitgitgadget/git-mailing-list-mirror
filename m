Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8BE26C38C
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188102; cv=none; b=Fobpf+IoVKJ1H4ot8HFvGYnKssN5xsc8VNZTC4qc/eIvGmnOoGXjoQ7XZYlDeLyWBVoc1jyFwl1wVtQZSwA1rRnDC69OcsP79rUG86367peRvhq2aT64U1qSTtP/6q1jrG8v5QiItQeFnrEP5gi0gYCEPoDKw+idAc+mekCYS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188102; c=relaxed/simple;
	bh=SWW66oWGKFd7trhlJCn+++AaBgq0gLNt8DEhBs3c+Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbN1LN+a0LgpsJNCcteMQngfZ6+ysCvZVLTmwc15YNIJWw8fdb3iMuYLnGtv2+FcpYSSDOtw81lg9pJoZ9NQsOZdM4601RVfucTMyJsG3D4GZtltoClQNvMPtLuw8+KOJaHDgWOKV5cHcVRRqGc70Facd8R5cPZQRNZ8A3rTmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WIdFvCBn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKKId8Z9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WIdFvCBn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKKId8Z9"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 214BFEC0185;
	Mon, 29 Sep 2025 19:21:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 29 Sep 2025 19:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188099; x=1759274499; bh=pYzKjIzchd
	0gyp6eq3gTloqTo5eZ1UOKdcb8+I2XqU4=; b=WIdFvCBn5llqetXXto+Th8NLCH
	n9EgYAHpVl34f1b0h82tWXuV/VaRnGweKqfBwTPIyDRfPuAAmHrABa5K3KNVq9AJ
	R/j5EWlWe5mXkTlGi159nv/Yshkutc9NpUJkIq0nCix0+cfbweKaR0vj8a4lW4y2
	xOqhgtJhvecf4yDHGtGH9aveiH9fxNkaQTdkO8flegQQRAkhFWewKQdgIAhrcn1Z
	CkxkBPhw6R5Qsbo3m9c03ejDK7MCKQxJe9fQi+uw6w80z82O1ppl7If9JdEODOcX
	oaLvaDpA0RmpCf79wcILII0IbDuWSx4NgWi5mmhCtL54hR1mzSgDs+bF+qpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188099; x=1759274499; bh=pYzKjIzchd0gyp6eq3gTloqTo5eZ1UOKdcb
	8+I2XqU4=; b=SKKId8Z9KY5ihpOJ3lQBP/EfBIAiZXSTqk+O/ZOfSbu9TFmajOe
	tl3uhgDTUF04SrxlYSknAIuz3lbkuSGyH1eaHBbe5R1vpg1PNyW2OgWqldES/6Fa
	4g0kHBN4O7WT3ho97fV2eU43Ku58sWbFnGScgcoNSQN0w3bsYJVQIwVczXGoJtYK
	zSGjqiH4rJsZ/07WIoT7j7R+ps4NtIohLPGMTl2EDY0DaT6cjKuWGS2AsiyN9k7O
	ZkHseNnxw/Y7Uu8AZb7w1CA8hoZM6DufjzDgGrCiUhkKCQ/y4fuz1BQ2Cz1YjBrk
	XYokHaiIM/EV9mvsnvr3UJt6DA3nSfrZoCQ==
X-ME-Sender: <xms:ghTbaA0kw8zTdbA45Ghfh0NPKFyPc7mysrD12lzig4OIjbkzSZBjLg>
    <xme:ghTbaOxI5_qS31iSDI36oJQLE0ccLvQuuRm_A6A6F68rT63Ic0NYh5TNVsV2Oad6m
    ldkfh735ninVY9g8zGj32XU1izsQ-mUlajC1I_JNKpqVvEn_qKF_Q>
X-ME-Received: <xmr:ghTbaCtvUcobqW-lMs3VlMcWrX8dH-RC2wOYD5b9ExU-55r8nK1OzhQYSodcS5JowI1j5HBDEB-EhstwnybPYuzaRgeVdiVECkHrYgFmrh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ghTbaAxnHvgsypy5xZMX8uwyl8Zk50BTyfAGONf1MKTaqiA41vGojg>
    <xmx:ghTbaFB3DMNsk4Zl9ZslMbndLK39cDqxaRgybG_eHE-pOJYhvU9DUA>
    <xmx:ghTbaOfLcCyvXi-RX7wP86dj-bPIjgAwiw2IDIpZ2-hYIhy4HyNACw>
    <xmx:ghTbaPnRNJz9BWiXeYn8lEK8b686NQHihvIlaq5xrdlTFiewKhjfHA>
    <xmx:gxTbaDThXBDJIrxcGvXXE6-ghlCEVXtiQSHFSzUCxh-ZVpG6nSJNdiIA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:21:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4677ba0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:21:37 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:21:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 17/49] builtin/repack.c: pass "packdir" when removing
 packs
Message-ID: <aNsUfrE-2Wc8_1Fm@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <df75c3130bced8d5489dc9184701a0a544617049.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df75c3130bced8d5489dc9184701a0a544617049.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:16PM -0400, Taylor Blau wrote:
> builtin/repack.c defines a static "packdir" to instruct pack-objects on
> where to write any new packfiles. This is also the directory scanned
> when removing any packfiles which were made redundant by the latest
> repack.
> 
> Prepare to move the "existing_packs_remove_redundant" function to its
> own compilation unit by passing in this information as a parameter to
> that function.

I would have expected that we also get rid of that static variable
either in this commit or a follow-up. Is there any reason why you
skipped over this? If so, it would be great to highlight in the commit
message.

Patrick
