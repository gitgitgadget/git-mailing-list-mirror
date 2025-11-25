Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF671C5D72
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093779; cv=none; b=k/DT/uQi1y3wTBaO4sHnRUq/UzYxrpWN5YDr7Q0TyyIHxvKDhM7lVs4Jrwtv1LRWkCA7WePwleFQM7C17LayNrYBIsRE5FhqEMiD6fYu+Cr4TMaYT/dTOfv/FX/EDspg2EFMIDcGkZIm0Aide7FM6OuqlK7tefrkQJWu6k/G51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093779; c=relaxed/simple;
	bh=qkkPdLmDTCBkQCOLV02OeM43Qivm3fw0zOP+gMvt2M4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JlHK689plMrhdbv968s89F5Jug+vJwhvNxKog9MsPE+JPSDA8QSftwpUFiAfAz+iBOiby0PAyCicS9WoKq9blXmyg7Mbr1E5O/Rj5vv3K6zS8BCSl430J0+u4Pp3byPcsGuOM9i2diLpFJFM/hQcEHsUE7igNfh5RSrkSOUASZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WGB3paWb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0VzNi+h; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WGB3paWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0VzNi+h"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E4011400143;
	Tue, 25 Nov 2025 13:02:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 25 Nov 2025 13:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764093776; x=1764180176; bh=O7nAuEnabM
	VtMq1CUg9JC4gZoTeZMh42T4Q9hSMWiNQ=; b=WGB3paWbPefIZkRGwDoyqjXnnk
	fLnUTRHFyHyyz7rszOF/+KTmJDnPEvNUC+y41YkGwkVLhZ6uEW701/w2dYkKx5dJ
	wAZeLVeEPNcSbc4UlM9jCtBC/k6VKd4ZkpNRWeMqaETfSR+seZ3ETyR/c9ecXyBF
	96l1dgRvDXXX7dTBuV/jBLbG0CVER8yZkQ75byvA+HlQQEQxDqyF1rPhvkTWMqwz
	MjDW4e0Yn/dUAH4U5o28ylHJ4sz6VP/YJtPSUTwAmMjPPGdEcKL8rZqSteDX45gF
	gt1lWjoL4tSiHLjab6Q3xdfKw4rYDO3ibTVY2xHjqtE4qDIoWSIjieFaxnzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764093776; x=1764180176; bh=O7nAuEnabMVtMq1CUg9JC4gZoTeZMh42T4Q
	9hSMWiNQ=; b=k0VzNi+ht0PNMHgxcONB4RxzX2gwA+ibwQj4fbAtM5DlfUxVyvy
	kD29fpTOv0dk+7EVwgozNVx18r3IRFng3UGRHr6BP+NXdg1qy9+x8/ucdbr2TVjR
	d6INHILh15h+1CqoWyT0GpoW3Rc4H+vPA7v+QuZCmkxbcyNlbqnbwhraOxO7MSlq
	oHnEVNvWLu18YaW9P9xTWo7+rhsJf+7cl0MROwIcLsjnErYgSUVLucoKrgai0jfb
	CRbAfFQoP38IifsXx6vecwrg+wWQ0PG6tWY233rn0drHMAoRDVBLX0h0cVWVXHJM
	RAbAcyy0UREgAPK3LyL2fcztZOoG4oIKMbg==
X-ME-Sender: <xms:Tu8lafBRGgFE4PHVC-ifL0N-IJAepiAxrQSUgQE5QvI8_3tkrLi2Hg>
    <xme:Tu8laf6XR05pdmMIadDFcZcRbVWd_R85yK1miZxD4I2MM0Z6vZQjGMDiONfmXlDt6
    NA8ILlhoKNKC6kujfnIAphig_aoDMV379xJ8NsWj-ugtCMSvphX3A>
X-ME-Received: <xmr:Tu8laQuL-LVootYPqR7SiDeBk2ZXDcA2d4_Cj4Qqfc92OagSpKu-xmZQWH7_cI7fwPeHx1RGE7BbDX5B9jg64y-nXGD9K-o9FCv7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Tu8lac45SpuPI3KOka2-rHyiNNw5mD5omBU8nwvvG-sC3-7_G6F6CA>
    <xmx:Tu8lac21nFBuqL81umFpc_clF6S7Z9IU-fGPW4m1SqIIsI1lfil41g>
    <xmx:Tu8laXgJtrAiiNO89859AQ3GTGGoxj1E7bB2ozUndGB8tObTy15v5g>
    <xmx:Tu8laUpIh_XfBj711myGXEMGT539_h-o9Hm_mFbeTiwko6cIAMCm5A>
    <xmx:UO8laU8vQjnL8ur_sKwXgWhCfpoKScsL5sWBM9vypcqhwLwHOlLhu1sB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 13:02:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  newren@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  karthik.188@gmail.com,  code@khaugsbakk.name,  rybak.a.v@gmail.com,
  jltobler@gmail.com,  toon@iotcl.com,  johncai86@gmail.com
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
In-Reply-To: <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de> (Johannes
	Schindelin's message of "Tue, 25 Nov 2025 18:25:41 +0100 (CET)")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
Date: Tue, 25 Nov 2025 10:02:53 -0800
Message-ID: <xmqqldjurnw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The patch itself looks fine to me, if a bit too extensive on the side of
> adding tests: Remember, a nimble test suite that catches a bug once is
> better than a long-running test suite that would catch a bug several times
> _iff_ it didn't tax the developer's patience so much that it is
> interrupted and aborted. You probably agree that Git's CI runtimes are
> already counter-productively long.

I am not sure about some of the negations in the above, but it is
very good to point out that tests want to cover widely but without
overlap.  Two tests that try to see the tool works well under
identical scenarios can be better done as a single test.  We do not
need to catch the same bug in multiple tests, as people tend to see
test breakages, update the code to fix the first one, and continue,
wanting to fix more and different kind of breakages.

Thanks.


