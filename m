Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BDB34BA5C
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126019; cv=none; b=Vj3KBZPfVqno3ozzu5k0qEB7E4qv3kPoudNR6DoZRb0lb5fzgz+AAVuZW+uI2oPT4Tx71EPXcNokcck/aTI6N5RG5lWx+ye7QJnGWgDmB6viMRKEYVUqEF0f6iuXQ+in20LC9CL4yZ6yxDLt6XFrOJv0opX55+x6WSqWaslESiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126019; c=relaxed/simple;
	bh=d+eo1Z/l+EHWOTqRNHCv8B42or0hGkQVgRQQ51YDm/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDYoYde/AScmyDvqKnjesS1xSYirZIGoTdUIF8FjBgMAH0zExSFdZmD8waByg2kRfMDuEN8Ch1ADv0A2iha9EMYh/ChFPnsIi+CFvMhN52Jg7nI0ZPy3joT8ZIMGpekh5+tlpDestP4xbJsaTfXfIx4rnNXxui8BQUdSMTKH/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JSvdp8fH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBQICH3i; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JSvdp8fH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBQICH3i"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CFB26EC0266;
	Wed, 17 Sep 2025 12:20:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 17 Sep 2025 12:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758126015; x=1758212415; bh=xgcd/W2B/+
	n9U2Kt6b9c+cxmqqUJk/5f41V488XBl1Y=; b=JSvdp8fHlx5x8FQrn0od02iMEo
	iRZUnDTQDH7CGOzAtUB7/TWKcS0TK1f7Q/52blHxccKAq78LELbzL8eBxb+Nrp9U
	xc5uub4rqVMKV843SeExAi0f7aizGmvzG4QtxF6knfttpnH1eGHON4mgAhy2hVqC
	0Jy3xRmQEffIb0Ykui9VC0hQLKm9dAs+VUptEYKGTG8lz5ucNJ3sWTU8ps85s4Jd
	vAmrwSlPsHA4G8aCyDFEHSngqtvPSYWQS2KzLQ2ivSB4Chj+oRXexZZpxx8NlY8p
	8KnnxL8ykyLLXsmpU2Mtl+/tALgPOxVY8QJeUavOiq66rZFQDVVPv9LkI1Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758126015; x=1758212415; bh=xgcd/W2B/+n9U2Kt6b9c+cxmqqUJk/5f41V
	488XBl1Y=; b=aBQICH3iftZL0G7ajJ1eOACHVAIeGoa80K9v9uVh8+djt+2aFBA
	NmPvZ6XW5zaBSeYQMUnFHDRu9gc7OvJD1TH7OrEYeH8f75ncIafdV7GcsG/eHVQP
	9RStFeXBhkaL/DToJpuUfC/OebNUhu3aLEptvfla4At5SKEECsuNgs9YKghaKcVw
	UJJli1Zb9/xZ83xckwJ0WVHOQ6Pw/vu5/0r99bzvtDXiJ+4Iu8XxsO67QH9mLrM3
	6s+HqhI9+UWG5dkxvade0Kam1aiTLH1QserP84hmRTHndVF9/kRpIlOPA6+awv38
	pf1y71ake5YPvuKCCKy6RO0tCrGSJTX8H7g==
X-ME-Sender: <xms:v9_KaDZfHQyCrFW4ljx_-bazMJmCF1nmNh80fUiD73VfSsKKAWJTqA>
    <xme:v9_KaPXLYLn0UL0l5OVJDWUa4fB8pjTCHtrvpGIHjtOIiSDStIBO8G9W1KYHOqm0X
    yLugfAmg-HXuK3WMQ>
X-ME-Received: <xmr:v9_KaBkTOtb9R5FxScAgaN4JCurSgE6pzZbMQh6oycuRAOmcR7uLaA6IV3HEm4nTgcs0gt5PjwyOCSAI9wBEmTU1AtroDG6rFyvb2QU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovgdrughrvgifsehinhguvgigvgigtg
    hhrghnghgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v9_KaCAmLdVK18DX4KcWWzQWRtm2_DhQe5-L6MEacLjDbLLGDJx0Lw>
    <xmx:v9_KaIj5sRoFA6TeBLC_Baej4Y82oZ-w3mPWMUUytO26217-jj972w>
    <xmx:v9_KaHy_GsDXPujSXMN1ssxSxCOtKhf90qk-2HFqKDRoMPejk8Dv5g>
    <xmx:v9_KaB3QcBRRZSGrWp1lL8r4oEhvRYQ_wSCmNq6fHXrbkQakCdBKgA>
    <xmx:v9_KaJ3dG_PrJ3IgQi9ctBKzYJDns9W9UW5x-ZXcWmthMC5dVl57Jb3l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 12:20:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  joe.drew@indexexchange.com,  peff@peff.net,
  ps@pks.im,  toon@iotcl.com,  jltobler@gmail.com
Subject: Re: [PATCH v4 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
In-Reply-To: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
	(Karthik Nayak's message of "Wed, 17 Sep 2025 17:25:10 +0200")
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
	<20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
Date: Wed, 17 Sep 2025 09:20:13 -0700
Message-ID: <xmqqecs5dpaa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes in v4:
> - Fixes to typos in commit messages.
> - Use curly braces for if..else clause with inlined comments.
> - Link to v3: https://lore.kernel.org/r/20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com

Thanks for a pleasant read.  Will replace.
