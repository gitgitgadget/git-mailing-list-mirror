Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E6225766
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881238; cv=none; b=VZuQLK+LQCFssGeupNclpaYvsGJDimhu4UllRtIxGD1Yl8PhN+PvsryYS9w0Ov3k9phySrbW7AK+acYB2qbI0a1XK0k4mq0yIJagHezIgNxyv4B+cGjQiW8Se4mbVJRwFITlHS+BPf4RhmWUd8Y1YjLgbJ7/Bmu/fKVBNCO8Ezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881238; c=relaxed/simple;
	bh=xbJKIcs1xFzTD8ikTZpMFUUi09e3Ph+Rc39fDzKvSSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C4yERpR9P3IgX5UM/2Q6ZCR/439PB3z9YV57ESsCyYH6o3pRsjrACbzZVvaUCmqx6RI2FKwrt3A7mhJv8GumjVZw2H6u5sZLGAKWuKVY8HCuYihIY/4eN22Z+ty5wdP2p6mhFJjRSWjdXl72NhiJnHcSYrYEMXUaU1HMJGPWuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ffy5BSBT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmxveVvG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ffy5BSBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmxveVvG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E57191380382;
	Mon,  2 Jun 2025 12:20:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Jun 2025 12:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748881234; x=1748967634; bh=EQ6HGvzOnS
	zN1kU247BApDCRD03lZJhyB+zeBFCl/Q0=; b=Ffy5BSBTVEBMlxQsP5xg+rAuDQ
	eoS7R27wuXgsN+8mgXKx6LMXAIaH8m4mFz14nMG8yKHinttcPqXO3tUTDTmebMp2
	1xdtfWQd79GRb43Wsvl4sCTnPoSGWpfJNnCLXeplTt4LVDdadywOv+65JjqMazcq
	JB4zx5RNbD+dE+PQXibY39aupsiG5t49ySRtM467Ux8j1/AuWrfKIoeXGKDkUaRx
	NLRQjTJ/3OJJTGv2Zf9gALanJOj07+nLUwH41/c+vltj2nSsLzo9PbJ+3GQ1QAPe
	9IwGt6TRAaOChigYy8rHNm081SZqlJCoeCAJQacpDLys3rJtl8zYqL71HKmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748881234; x=1748967634; bh=EQ6HGvzOnSzN1kU247BApDCRD03lZJhyB+z
	eBFCl/Q0=; b=gmxveVvGFQjSZeQCUo4Ese+uDptyKtrqStMV2C62jvGCWonxlOp
	9Yx6+6GKw+fU44IBMDff5m4+DGdFqyzrplHPiEXDQml/RZ+IgXP320vN0QMkdzPV
	T7R2mtYAzyC36N2lN8Bx22fadYwdb0UgTj8ThvnuNts2/Nt8dTM2qRG0KR/KMQqw
	1MRO/qcJQmzuz3E2646h/ibuzRobWISbIGlG1iCLZpJpN+bcH7xSOsRC7DrvyNqb
	ro68u/CmtpuJZ47P5sU5mJcqrDiAniDr6+xkwdsn+Gu2EtY95POZKn2yywRKcD6Q
	lk81bmmdk2yt0AMTGIJLHYaTrmmBVxkiXmA==
X-ME-Sender: <xms:Us89aOTPWQ6Pt2tHgOhycSrmpdgEjsZL2iIhfsx0YeEwkmEUYO0kgw>
    <xme:Us89aDx4KnMk5jmn8gnTqM3jCNO437Z-eDa-_yM7tFQZ6vt_WL9dcJQpZkXYADiYO
    5kz5_JtH5vnweQuCA>
X-ME-Received: <xmr:Us89aL1xywcwDM9eIv32HqfM-s8Ef-UYWE7DnPAAPyqF3KZKqnotrlkDuYI1vYcRl_z7YgTGZbinF5nlAkeX7y7pPiHbiO03ySsr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkedugeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehluhhkvghshhhusegurghtrgifihhrvgdrihhopdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Us89aKCn7h4Vaa_8ImBQK5jheI8LRNuRmGm9LB-vIOMb3OeQtDJDVw>
    <xmx:Us89aHjj-hkEMPNmkC-w1GCZ0RE6JmzQlJ50Y3v6I2si7t0gdhCViQ>
    <xmx:Us89aGpGt7uDY3RmE725LSPL7Gg7uh-WUZlQnA1fcAbZQBSnhRWcQg>
    <xmx:Us89aKjIod5-CDQFkMkPsrNQTnzJenlmWCz9S4kiInBhKLQKAPrGxA>
    <xmx:Us89aLt9zzQc6Iw-uBF6KrTFFDuqkBrQEI7iRB21JAPDPEaM7TJyR-Pg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 12:20:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Luke Shumaker <lukeshu@datawire.io>,  Elijah Newren <newren@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature
 algorithm name
In-Reply-To: <CAP8UFD2i-ayL7vs=Y46DpYkv64ROBj0YHNHEbbaG76mLTncyEQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 2 Jun 2025 17:56:10 +0200")
References: <20250424203904.909777-1-christian.couder@gmail.com>
	<xmqqselxtfyf.fsf@gitster.g>
	<CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
	<xmqq1pthtbdg.fsf@gitster.g>
	<CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
	<xmqqzfeyqdye.fsf@gitster.g> <xmqq8qmgsky8.fsf@gitster.g>
	<CAP8UFD2i-ayL7vs=Y46DpYkv64ROBj0YHNHEbbaG76mLTncyEQ@mail.gmail.com>
Date: Mon, 02 Jun 2025 09:20:32 -0700
Message-ID: <xmqqtt4yt8rz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> -Earlier versions this command that did not have '--signed-commits'
>> -behaved as if '--signed-commits=strip'.  As an escape hatch for users
>> -of tools that call 'git fast-export' but do not yet support
>> -'--signed-commits', you may set the environment variable
>> -'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' in order to change the default
>> -from 'abort' to 'warn-strip'.
>> +NOTE: This is highly experimental and the format of the data stream may
>> +change in the future without compatibility guarantees.
>
> I wonder if it should say that the default is likely to change too?

It is to be decided in the future and we have no plan to do so
before the feature loses "experimental" label, no?  Those who are
opting into a highly experimental feature would know that already.

>> +test_expect_success GPG 'signed-commits default is same as strip' '
>
> Here also maybe we should say that the default could change in case
> advanced users look at test cases to get hints at what is cast in
> stone?

The same answer applies.
