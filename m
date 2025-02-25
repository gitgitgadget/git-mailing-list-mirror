Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0A19DF4D
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507632; cv=none; b=G2uUMREJqlhCJb7qM5blSqbW4uVar3v6jIlmUg+lyrNXPcCd2Ou9m9BvZrYT+RKJoHuVPXbnPGr2VXO8mA3gJz2qhPL7299WsRQjh1GQrsBcNzrcJbmsa6YsgRN/n0hj3ivWZv95U0YTg7kbt6sxwx/o01jSXDeHQByJtp20csU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507632; c=relaxed/simple;
	bh=nVN3khmxvWcg5eI3L9NPlT3YdecUK9m0p6ecd9C5yCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P+Lq36Awx0KTUHIIEgtuDSC7dLZon+mdKT+o5gK+ss7ULTn9B52CyjjJ/3k9Fq3IkbinT6Dn45z0v81gpsAk8VsGeZw1ui41VpnJ9YurDF9gSnrFIvY/uKKO9TfEmraoZS/3w5O02WcnjnjfreKuIIUtku5tGsgCJ7Ub960DB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PhYZ8p1Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YiESL03y; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PhYZ8p1Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YiESL03y"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E08A13814FA;
	Tue, 25 Feb 2025 13:20:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 25 Feb 2025 13:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740507630;
	 x=1740594030; bh=yw3fQekZE0Ed3nNZXZwZQ0EXi3DuJQLeHRZ+Le6fbAg=; b=
	PhYZ8p1QIGz04xKUuJvhVaCJp3r2KOo5UxTWPZ5zliYvbfqd5CIWlUY12bxdKQRD
	pwterJyYS3NHGmQQxJyHjTINvpIqWYWrdjMK5gDa/LPzse9HolK6sRQJqg7UY63y
	VfDojqJvjjfF0rU1sb4K0U/XudFC+KM7ZXZA1IhL6gRXmY/Eq+C/dCPEK3pScrn+
	+xB+9q3iqMEMmlIzpXqsplV+txPOVurJ6j5LqiAxFwEPG2uWSLQ6kMsaOElA2iZ6
	AFvJZ3LGOFDF93vSSrftMa74Fi4InLqDikobI2xudjbDlEBM0jkCGaJF45Wq7AKp
	xxVJs5vBxZ6mK7egTUpBXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740507630; x=
	1740594030; bh=yw3fQekZE0Ed3nNZXZwZQ0EXi3DuJQLeHRZ+Le6fbAg=; b=Y
	iESL03yUXlO1hGktmcvI2TM2b+z/SXJhSAalh3sDUQaXPt6JmesZEuZlcCVR/dkI
	N0Jsq0NzrUyexa+WGN9vqWfjumEibWJx6e0zf7QpuT2xJQ2o17jcceI0svc0Lk1V
	wfxqE4Kz2b0mBM6BfGwLDZalskaCXZd/CVi8cDUzU02n5rrjt3OQi/oaGqqK8jDp
	wkAUXhk5QiZsFuE+12SJr+6uUAY15a1VWY3VGskrjVf7I1gk9TzRXM2Kz8Q2P1g1
	aYGyQ7ZZ0RpPGPDDQYDL8dsjCGZrbnNCs/qom5YHs1N1lAsgu8WPIpjkt/738hR/
	qHkLx63RBKOULAmADdE9Q==
X-ME-Sender: <xms:7Qm-ZzeRn4V5Wrml_XbD6au00QesmFKVSN0HYcMcxlHEmvnrNY4_KQ>
    <xme:7Qm-Z5NaEhpzoXKDEjxCAlksKOK3dzA9kepWIMlRBbwHt5YMPCOoCNsk2YDJHd3nr
    Rhi-Xknk0BZ73z8dQ>
X-ME-Received: <xmr:7Qm-Z8j6FIiYOg8Y3x1_E10ZndoNnYpp2D7wSNuhaaIIybZvVkno-02T-PTcDuO0mhf7NhNHODKYul9e4roW-hpAyvDV7_rN9I9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdfhgeeihedttdefheejieegffeiteeu
    geeljeeukeeuheduudeifeelhfehtdetnecuffhomhgrihhnpehgihhtqdhstghmrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepphdrugdrohhlihhvvghrsehmrghvihhtrdhorhhgrdhu
    khdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7gm-Z0_jga_goxNJcZYUb-mCkNEUXBgvwM_e1AW4GIKuUtgi5sR-Ew>
    <xmx:7gm-Z_uGnreVkFJQ1ugNz5bhq8-dQ2ak0Dfad37wygOwPIJxNboGqw>
    <xmx:7gm-ZzGXDzYCWI9NYnq81E9NxxrF9SEXBveKH2OC8pkw6asIBerkGQ>
    <xmx:7gm-Z2P3Qlgcjg1u-8ilfeidxzoNdkUGR8ORn52fVYJ5KW_lcgmCdA>
    <xmx:7gm-Z_JRp9Wl8lcDNNl1zKnn1ZlsrbM9jaz5qooS_EcuzG4VyjyeDIaT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 13:20:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Oliver <p.d.oliver@mavit.org.uk>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Fix Meson Perl version check
In-Reply-To: <ac54ce2d-a00d-4e9d-2c79-fa6b8de4aba4@mavit.org.uk> (Peter
	Oliver's message of "Tue, 25 Feb 2025 12:28:32 +0000 (GMT)")
References: <Z5c4OzzHWOo30Hu6@pks.im>
	<20250218153043.63535-1-git@mavit.org.uk> <xmqq8qq3kqyk.fsf@gitster.g>
	<ac54ce2d-a00d-4e9d-2c79-fa6b8de4aba4@mavit.org.uk>
Date: Tue, 25 Feb 2025 10:20:28 -0800
Message-ID: <xmqqmse9khsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Peter Oliver <p.d.oliver@mavit.org.uk> writes:

> On Tue, 18 Feb 2025, Junio C Hamano wrote:
>
>> I wasn't involved in the review of the previous rounds (so it was a
>> bit of surprise for me to be listed on the To: line)
>
> Apologies if that wasn’t the correct process.  I am not a regular
> contributor, and was trying to follow the process described at
> https://git-scm.com/docs/SubmittingPatches#_choosing_your_reviewers,
> “After the list reached a consensus…”.

No apology needed.  Thanks for the update.

