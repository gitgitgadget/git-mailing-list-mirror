Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F095242D6E
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606502; cv=none; b=JIAfBPPavu/w5RwSGqjKfp2h6T19oWJccEF3A2MGjDyGDltpfTBnPOdOaL/GKOd+Lc11eNXfW9TAP6uyqQRWbEIrESWDiMg20bB+9eDwrYic3TU9wPt+BK+VMqSsZTEZsCllRcGoy8UYDEQbsVFFTngMIJnHCYhkKMcd/Rlvuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606502; c=relaxed/simple;
	bh=5gc7DBF5yyjDGLy0+IuTKnsQUAMT7vS60dxT+TtRXag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WiWG98TOoGwg1E+RlYymtTNGjW0HCgAkhMLh6tBlF0QSBdDE8uh862umnz2G1NZqwnzGeKXsixLWHKNPGRPNLq0yS4t7hD0jmqgLwEU7v31qJdkmbT8Knq9VvX4Y7k8R1KJGj7oyFT4g9rYe6tXApGwiyRKDx/uaDXcUL4Uq4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AcPOfZUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gdHxKE3S; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AcPOfZUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdHxKE3S"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A847AEC01C2;
	Thu,  7 Aug 2025 18:41:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 07 Aug 2025 18:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754606499; x=1754692899; bh=42ZY3ueKmg
	TltH0LtVVxtEIsbvnpzdBYyHcv6yNXHbo=; b=AcPOfZUiLOicpp8x3hQiLOYhox
	xiC6Za2LPGSpOGomh3mSV5jeAn6l5z6hT/MI6njH5R/K4hLGa9jQ2nb/6p22YAjz
	WZkjrntKtQ674M8RceK32sBekiQjQi3qy7IMOaBjiKIrxWgjGUiRft+VViPr9vQv
	GRkoJc18PD4D++CCE2pTYTeWzbYEka4SqOStNDWNHc2mVBgI8Qj9shRRQcz3osmN
	/hrTAAXhpZTlmvxv5CCg2lNAA1KlD5ovvk0sGwT3I9ld1UViJkfsjD0SRdoZ7sMt
	YOtNwXkqItjsRymKRB67YBJZ1twg2/BeYPHRODRcXbhyOFg2d32Dg7r46tyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754606499; x=1754692899; bh=42ZY3ueKmgTltH0LtVVxtEIsbvnpzdBYyHc
	v6yNXHbo=; b=gdHxKE3S8A1XwCG5zhns3BgIQ7fuM3Bi1eyutujGCzCOw/bUr3I
	agPfa14qbXzt7ZisapA4J3FX5tL3bqAFW8Jo41sddfOcmtluDJEHg0Iuw6mEY9rT
	/03NV+pek6rD9enO1QTl1dW6MPMmpPyii6orAHRS6FOZb/vNZfhZpGmN/4Csc4j3
	O9L8luR6JVqGJcEUAc4uZnYy/qTjWEkhpJWhTh3S87Sj140b1UXUKtuAGQs+BSSG
	pYt5KZi9MG8biAC77n9SroSn1tnq330hsJUB9M2y8q3DYBg0BGBqrHoFZVPLWPVy
	VMTZzujDicqLCAepe1USiAsuenF1GRczymw==
X-ME-Sender: <xms:oyuVaNvsX0pcSC5BXi3mRUFXzuWca_W4c3SgEk1DZF-ScFU5UBc0wA>
    <xme:oyuVaB8um8DIZRNkUquQp5ElSCmdPttFyRN5SQjrZrsoVlqT-gB2_ndSbo69FUh0B
    D_tVn_-IbxBMVehIA>
X-ME-Received: <xmr:oyuVaHOnt1lgtRXl9rY2ULBuVtp6ieU9onJKohZ8uiqmTcZFtx32bYHw4Kcnktkg4E0r0JE4axjTs1xh3JA4f_Kmxi2tE3q-z7KuEmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghg
    vghnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oyuVaPFavYBNmxUpXOQbQXOqErcxnk-m1EvcHObg4Ps0UXe8yJAI1Q>
    <xmx:oyuVaFSYfMi3ZswDqi8ozWxf_L77zzfN7-N6NYDhZODlw5gp_iylqg>
    <xmx:oyuVaMubkenWGIpl5Y9vow4GkO90am9EkzGfOlh7zoySncMHemn5dw>
    <xmx:oyuVaNL4jOXJBhckdLVmG13eES2YY1L7yq7kRDdtWX8X2Mt-nkEU0w>
    <xmx:oyuVaD4QaMMuXApDbjZf_oWllxuOqsBSlShuX4VGvd_Op0IinhdmJw-O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 18:41:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
In-Reply-To: <aJRP_muuzCAy3mzF@pks.im> (Patrick Steinhardt's message of "Thu,
	7 Aug 2025 09:04:30 +0200")
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
	<20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
	<aJB5uKFdGybf-IbN@ugly> <aJCW7aYqJB20LDNg@pks.im>
	<xmqq5xf35429.fsf@gitster.g> <aJEppnTkY+66IEza@nand.local>
	<aJL06Nlee6CR-KK0@pks.im> <xmqq4iukwj83.fsf@gitster.g>
	<aJRP_muuzCAy3mzF@pks.im>
Date: Thu, 07 Aug 2025 15:41:38 -0700
Message-ID: <xmqqpld6kb4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yup, fully agreed, and this is a good reason why it should be signed. In
> the case at hand though we never use such sentinel values, I think
> making that explicit by using an unsigned type is a good thing as it
> tells the reader that "Yup, no sentinels involved, it's a plain counter
> from 0 to $NUM_ENTRIES".

I do not think such a "statement" has much values, especially the
right $NUM_ENTRIES is different for specific cases and is not
expressed anywhere.

Also, by making it explicit, such a move is also making it explicit
that we want to close the door for certain future evolution of the
code paths involved.  I.e. anything that starts to require the
member or the variable to use a sentinel value is unwelcome.

So, I am not sure if I buy the above as a justification for this
change.
