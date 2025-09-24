Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EE4524F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695565; cv=none; b=QkiLv7h0hZB/EUSHpk5Mc4t2npLVn6X8iEEhQwYtINeCxKiU3qFzRa2guh6HjCSjxUn4a3GzySoaFqQIXDHRKk+yLM6MA/sTtPpsfaiorl0UU6kZUiswOhUWgwKzix3SZGwsbL0rvug7y33nLx1U9xzXr76SyIHRygZWs/gYK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695565; c=relaxed/simple;
	bh=VW+lPAs15FTSa44sr8LyfcZe6VJ5FzCCp9Hb0rnOwms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5XkfPFCvWmaJBglv/C0/Yq4/aXRJiJpZ3tYQQePbgpKGCPUfMjQVYQEapWE2DPtUDRdEc1Ig9U/BDUnp74pWi0WeMjkZgaWOOHfVXupjySzPb1RsqTaBp0n0/ouG2C6mL89zgpYXwMG6tdsbUUh2jsYty5K9OeYGhfFZn1q/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=chf4bpDv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7P6Q2ua; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="chf4bpDv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7P6Q2ua"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A185EEC00A6;
	Wed, 24 Sep 2025 02:32:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 02:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758695562; x=1758781962; bh=eUM8NF56ZO
	OJqX7obYYel5ph41CxLXFLkomV6R1faz0=; b=chf4bpDvuu5mZuIgNjHVhRYM6L
	3oceULw1H2+ri6yrZijxDpS8adwOJZOOC2fZJm5g5V90d3MabIoC4olFSp5Net0B
	NBKw+XBQ3DLMNlRKokDrreED8B78Rh3vSdWXKFYkLoC5XN+LTpInDE39Rwqr8FlY
	ZNIX9/TMs9s5LS+QtD7HB3f5avf9noXZTJUIIq9A2ZCR8zwYdL82UsyB6BVtLbtz
	Xa3vLOfvgimBrrjAk8rnGN1Bd6WDHgKoWKdzIE39XiFPqdffR7POkn5zj7QSI/by
	th+jZnoDyey/ZZ0chOz3qnbvSuKGYbR7YONjL5I1B7ktyNrNOeLhbAsE3X+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758695562; x=1758781962; bh=eUM8NF56ZOOJqX7obYYel5ph41CxLXFLkom
	V6R1faz0=; b=V7P6Q2ua0WOy+roS5nPiPnzsZwFdAt1wQBG9NWdOQPh+RmMJk2f
	adVw6B4Kseo87eEvvzmDnleh4/9qAjmoudddURlfbehrwhSeuP0vRxeWwNfQB9pE
	Tuyc6X0oIwXYMDuTMsPqEHs8qC8nMDCMaMtRdPPgJujt9Jclw6QcJdo5bqREjPJI
	7dUJwYwKYiKHv3goPRKZoyYht2Nnz2QC866Z2T3VmX/dhzZyTfK+TNN2jbRq3uN9
	lxwO6r+Eie1HyPB47rewulzHb8ty7VdCihHuJKyDWtA6zcrTHhVL1vCPAc9LwHiL
	x6q7T00JHAqH6LNI8DbNJFIk2yQPkNeUalA==
X-ME-Sender: <xms:ipDTaDjWv1knJg_jbs1AU5jZKH0BDMuezuAhMDNt3eqz8CbgorL-0Q>
    <xme:ipDTaHBG8__AOtPT2DS5nVjYw1S00zjtNYT9-DFwHxG5c4afxLuXblKMSd_Li6xzW
    O5mNk7HPfj7jG62LhxfCx5IoMbGquzkpxtJ_OkQ4yqjpWNtYOKZYw>
X-ME-Received: <xmr:ipDTaIGrBwmI1L7Qharan2LD2Cqx7LbvMJEetMg8sJzLt4ZbsrvOkGXesCDaKvcpqFT5uUi21TCRsYRw9b4qjDhbJyvfc_pzrQTO3L6pnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ipDTaPL5ZY4qkK2abZIEsLAVHKSBMSuBDcAS8db425Be2t98ECXWRQ>
    <xmx:ipDTaMkNVDRK6FzSghHmxWymEWme0mkO58Ble-X46jYoE8hjiS6Eaw>
    <xmx:ipDTaHTCDh5TMUqydEl67e_6ZnHmFkgbSJ7sedf4TzXSkfq7YjIt6A>
    <xmx:ipDTaOIW2HFLNGsMJQw_VaTzDLwDwrGD07ZpJnJL4re3pxD_b9LIZw>
    <xmx:ipDTaPncgttsrd7O-q_PvexiB85zP8jib1A8HZeyJh71FHb61rz9UPjA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 02:32:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5db0f45c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 06:32:41 +0000 (UTC)
Date: Wed, 24 Sep 2025 08:32:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org,
	shejialuo@gmail.com
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
Message-ID: <aNOQhncjwYCwCaZ3@pks.im>
References: <20250923104533.21165-1-meetsoni3017@gmail.com>
 <xmqqecrwon2h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecrwon2h.fsf@gitster.g>

On Tue, Sep 23, 2025 at 02:50:46PM -0700, Junio C Hamano wrote:
> Meet Soni <meetsoni3017@gmail.com> writes:
> 
> > While `git-rev-parse(1)` and `git-show-ref(1)` can be used to read
> > reference values, they have drawbacks for scripting and discoverability.
> > `rev-parse` performs DWIM expansion which is unpredictable for scripts,
> > and `show-ref --verify` is difficult to discover and cannot read the
> > direct target of a symbolic reference.
> 
> Well "refs get" is even harder to discover (it is not even in Git
> 2.50's manual that is available everywhere on the net), so difficult
> to discover is not a good excuse.  In a sense show-ref was invented
> exactly to serve as something like "refs get" you are writing, so I
> wonder if a better approach is to extend it instead of introducing
> a new subcommand in a distant place from it?
> 
> Perhaps "show-ref --verify --no-deref" or something that does not
> dereference but works directly on a symbolic ref?

For now: yes, it's more difficult to discover for sure. But users will
adjust over time as they get more familiar with git-refs(1), and from
thereon I think it will become significantly easier to discover that
subcommand.

git-refs(1) already hosts everything needed to handle references, so
from my point of view it is only natural to also provide an easy way to
read a single reference to complete the picture.

Patrick
