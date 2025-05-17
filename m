Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DC8F58
	for <git@vger.kernel.org>; Sat, 17 May 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507578; cv=none; b=oPyN1sB+JRDfs4pIpdnAn+Gg9dEqw8hijiYoA1vIexSjqE2wopf5eZw2tnyujIWLowdySuYCywV+0eKnBoTLDqK82PzPq0XY/6ZKHxNCfET/M5XeaiSZRpdP9hoaqaoO3lEtiRsIOPgWYqx8C4N2c2IRgHfwLQWIntb2G+FDAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507578; c=relaxed/simple;
	bh=D06mboLs8Ds3tj9dPvGUClTyjOaEKuEIl3NvF2/ySqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UikR0Orr3zZXmay+zePimnnGNI/5O8RTyQk3YvB35uZbM2Uq1nzWfr/pVYzUY2mwrq6O+Q2o/5nD9GaPrxz6U0tYO3aQkakTg9lpIKhNTOXjbGe6vm2US3mMqgByuFTIMCy8gGtYNPbob+5uQbGOGiaCul2nSU424yDz7RAO/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g6nHPxZm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GLN8DU+/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g6nHPxZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GLN8DU+/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 82EF225400D5;
	Sat, 17 May 2025 14:46:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 17 May 2025 14:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747507575; x=1747593975; bh=RMYddmc0UU
	XmvABc/P/XQJQh57zXel7q6iNoEUIy1O8=; b=g6nHPxZmGls1whvsCqGgEj9IsE
	oT7xxvT6PJpCg860dgQx6hUnAYk4xyDtWyuDFfpUPtyR2r4COGulNR42vHYP6goh
	4wCn85QatbTJBmjg0UrKQtLuCmO4Uboklounl/S0iZkuHvphlxl1Pp1WHC5vosAD
	27V3XhWnV6fiR5izYWDdaw6vUq+o4jDtqdEYsuR+1auAM5zb3soxZkXRO9AxOpxg
	w3OGtRlIjIpzmMKaguBm3tBBnEg6Dyj/OFCVDJgBXIZpBvl3MFhrW4hLFfZPnmkG
	iydFyYroc/JUuuw3xN66sqnEVC7TGqDLfWeOlLvOJ/sYe9QLxTQJPEEIHG5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747507575; x=1747593975; bh=RMYddmc0UUXmvABc/P/XQJQh57zXel7q6iN
	oEUIy1O8=; b=GLN8DU+/0fA/VuEuBKnVDK27+7Iah+FEsAD6LwJmXWqPo0d5k0/
	lFA/eLIG+WSiL/pLSCDyrv+xvtNEVCMJobEhQkGIIVEPoQYA/mKvlkFnsG0BYja+
	JkHlLS1U9slkldKLnruJPTpiOiJvDi68mmsQUYwPcdk0l98v334KHtx6Y/nJ2ike
	RtXaWnvKiZELZIZEg9+P/uUMFjtAmuN9gEmlB9zlGgsn4I+snd8iOXE4Y9Ye/8DL
	NTBx/nrqHMRPmSlOrI0vHW0mzla1c0J7DUmF04fI0nnAdGQUaVVyovpK8mvdFOzL
	Tei31HBWykZzgv1Cpf3Bxc9U2em1QUdxPAQ==
X-ME-Sender: <xms:dtkoaAGclwESxlEkoS_VUW4nMX-ZpwKgKqXlXQB0W5AbnaDnTjmLqA>
    <xme:dtkoaJVumNqxAGEeC1BnvSImFlOMGXEWOuTS4zhxxNI0t7FpEfR8p6jeRH6A1GWqX
    4EmTqm1tUwI_sWKRw>
X-ME-Received: <xmr:dtkoaKJL_STBqZXm_UtOJDXM4M4d75RwXDu8ELM14lW69NsYqIBHUKacZKgFZOQHoNGvbpiremsAxw4K2rKd795z09mFOGrkid9Gjnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeifeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeiirghihhgrnhesuhhnrhgvrghlrghsihgrrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dtkoaCEsCMxhItsY0VC9cPlF0LNbQrO-lWpHhC3iCeS722mU0CYn7w>
    <xmx:dtkoaGU00L-5C6JJrfbgIR-CbSxaCEP08C7_YyXIs9KIODLznUbsLA>
    <xmx:dtkoaFOpux7cx7lGuZsaRJVankfyrt-kVbV4EmsBbshJs6exBL46Iw>
    <xmx:dtkoaN07KTVrGsyDgcvPqtgmrrLNYy4RBDWv8PtrKd9yI2a_uIHLkg>
    <xmx:d9koaNKgHM7DhgX9imcCDOb-UgFEu_jg8SCiwsWeDqLF8l3FArc3h_CA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 May 2025 14:46:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Muhammad Nuzaihan <zaihan@unrealasia.net>
Cc: git@vger.kernel.org,  "phillip.wood" <phillip.wood@dunelm.org.uk>,
  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: PATCH v2 [1/1]: MPTCP support for Git on Linux
In-Reply-To: <6O0FWS.8JJP67DO2U1M1@unrealasia.net> (Muhammad Nuzaihan's
	message of "Sun, 18 May 2025 01:02:30 +0800")
References: <6O0FWS.8JJP67DO2U1M1@unrealasia.net>
Date: Sat, 17 May 2025 11:46:12 -0700
Message-ID: <xmqq5xhzqdmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Muhammad Nuzaihan <zaihan@unrealasia.net> writes:

> Hi,
>
> This patch is about Multi-Path TCP.

Perhaps reading and following Documentation/SubmittingPatches and
possibly MyFirstContribution is in order.

How widely is MPTCP adopted?  I somehow feel that it is a losing
proposition to _require_ that each and every _application_ to be
updated to support it, but say if we take a random set of widely
used application, how much of them have specific knowledge of how
to work with MPTCP these days?



