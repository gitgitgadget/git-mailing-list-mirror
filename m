Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B021420B
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848096; cv=none; b=F5kHkm9GkHY6oYfY5eGKSHzD4EOQ/zTI2PXdjssneUNCFu9/VFdt3XdIjEMDkMszzEn5SKYlKCgXY78gcZ6q77qxh8BWQGSN9Mb8eyt3E79JTaXvYd7TPsuvEl8VNVOMrLf92PU6BPlVX4MvUU0uRR6XkjtIUcKeZ200O1OBRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848096; c=relaxed/simple;
	bh=2wtm4yytV7CNHx2W31cHqtQOCOPgqarzNUH6Fwy8PQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jkby+XN/nkN7POTmI5miOETTK3PDTax+OqmT8bno/GXH7Pp9elTr282l7PM/KTbPx+fgHqcvyx5ye+Tkwg8/e96rPOhT/Z9PeEKBtuZy9r2XwrqKxlNebi6SSn0j9bUo+rW4BJgITfHty80vHmOmK6peVl2wkckij0mYuuXY0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JHqduG2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P52haE3Z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JHqduG2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P52haE3Z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 29B2E1D000CA;
	Thu, 30 Oct 2025 14:14:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 30 Oct 2025 14:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761848093; x=1761934493; bh=2wtm4yytV7
	CNHx2W31cHqtQOCOPgqarzNUH6Fwy8PQY=; b=JHqduG2TfxudztDUP7fOW7p+KC
	DR4W6iTNzWQHTKEsHophx/TZVjMYsURMi12RyreVTNmkh6YqHyz4lVAlOjPpQECB
	O3yofTt8+QFQTqGyol1OP2bpXJOFWIJMCrUO4dw5BTPegv/apWUnGyw6hvI/N+sC
	a6Xa71wGnVIIpTy8irL9/8+aLgNyDKx/7eyPvEsZQ7khfvI9m+YcZ5hiqqR4fwF5
	u3ZBizaqbn0N4/6doQzP65zRD4QWULl8mQWE6p1BcsyWaoArwjQA6ZgeFbfmhwdb
	Qz1JV9chdIb5DfYTgsnCVUo925F47aXDyCsV2SepWS3qfNQPhCrVrByW6QWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761848093; x=1761934493; bh=2wtm4yytV7CNHx2W31cHqtQOCOPgqarzNUH
	6Fwy8PQY=; b=P52haE3Ze07sR6ptKcOGF8L7wLqhlkGmAzS55nAAnY6oGX14Azx
	UV4VW7UbBOQQipBkNshCjSrgUsEpVr1AwPGk8udjF3xqP7IaZLtg99vreGo5G5fr
	8DN0itlFgnSDNHXebAiOjqHblqdBc+5wpdWf8yLZGyKzBS3QVn4Rd6azEzLylflO
	qJiPp7IAdhCBSg72lYjuiE6KzLLt/imDjuynpe26Sd1k6469+Yxpv/DLySNbHB0I
	wW1NX8eTAOmv4tkbmm56qtiqLd1W1AfqDGG7M3TQP9CL4q2dBqeUXt4JARVJfkJj
	8Y7XNj/N62AdDMlZIu1ZwncLGEbFMymvDNA==
X-ME-Sender: <xms:HKsDaQZR6L75VxDbMaqYqUt81OVOK-KiRmiTZMcW5qB3s5lEfAq9GQ>
    <xme:HKsDaafepnUsmRwHohqiDDGX_29EyLeCnB2fgEd_Tz9dIstNvHJhrH4zbAncwSmju
    gEn3xbtd9jjS5vcRtrFdEMfBfMcGD4qHxk5XqUMqKVi1TFDXX7eBGA>
X-ME-Received: <xmr:HKsDaRKVl6umZVyGCtpLjc_4NqwMFQOWGZbS652yp_FJ-8EYXlO1bLvrpbuzI72NiYaxqs_J4-yHWLP5bsbgGdxziGvLL9sPTYID>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HKsDaXLC-bwN0dOHFfoqAUb74rIwaXcVGd-iUqxspvVwQrf8gTmpjw>
    <xmx:HKsDaQXFYCAyYsQfk8-g0TWiNRffx8yHTqEXe5Z2oUkhR2hJPzEpgQ>
    <xmx:HKsDaQlfipFriBBYFsR3haYJRvh_jNO9uSHug-jBEfVTpUWVORrGxg>
    <xmx:HKsDaWndWzZ9shnRldi4iYl5PCdo_NbMu6ZZRca2Sn-8Yp8Gfjj93Q>
    <xmx:HasDaRlXVwapAwwLEZ4d0uOaSVFLswUsR2s3KPSK0qvfICRie0CF_k4w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 14:14:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] fast-export/import: cleanups and translation
In-Reply-To: <20251030123332.3337684-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 30 Oct 2025 13:33:27 +0100")
References: <20251028081232.3068147-1-christian.couder@gmail.com>
	<20251030123332.3337684-1-christian.couder@gmail.com>
Date: Thu, 30 Oct 2025 11:14:50 -0700
Message-ID: <xmqqikfw5k9x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> There are only small changes in patches 3/5 and 4/5. Mostly some
> uppercase letters at the start of error and warning messages have been
> downcased according to our style.
>
> In patch 3/5, an error message that started with "Error: " has been
> changed to remove that part.
>
> In patch 4/5, some tests in "t9300-fast-import.sh" had to be adjusted
> because they were testing error or warning messages where the first
> letter was downcased.
>
> The commit messages of patches 3/5 and 4/5 have also been adjusted to
> mention these changes.

Thanks, looking good.
