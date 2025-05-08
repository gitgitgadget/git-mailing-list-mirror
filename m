Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB371D618E
	for <git@vger.kernel.org>; Thu,  8 May 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728793; cv=none; b=Zi+O7yp4Dw8cNidpXK/MjMZZ3SkOd7cjjtDKJyZEplgmcN5ErXiO5/MrZhP36C0CH2L0jKVTif6Q7uyyIdkRYJ7CZy14x1TgOA9lKWSJFeh1IqLjfliSJUR9Xc07ceLIqQxIwJ9ESaeGwz3PlOi0nabAiDBQcQYytBcMNh94eIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728793; c=relaxed/simple;
	bh=CEB8XcsG7/ZPiE2yRVSVp2Z4EaD68h6ZyLThfKIzv7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mWSJOnCqm6QR7QNkRUgGD+eDpfOPieLLumL95lUBbcuGhsirn5Ia/ctFZCiWHRqYLbzIwx1aXNq3nmKObza3iLw0B+53/Pdjq/ghOnszTn8LaTPQPbbUjRP9iYCKcPmQ1mQ98+Ul9vGvX9v8BfJsP8JHgF/g7L1b0nLXqHcYnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B9BSCA/I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IT5xn7si; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B9BSCA/I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IT5xn7si"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BA72611400DB;
	Thu,  8 May 2025 14:26:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 08 May 2025 14:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746728789; x=1746815189; bh=i/6lhxJqA+
	kOR+2lAH2iLHaiJf8sPw+B2hnM9yX0v4U=; b=B9BSCA/IRHKqruhbS1Re11V0vQ
	J+Ima6zQvzk5Uekhw+Fq1VYZ+R5t2a65QX4jJFNokhgnPOpGTn1c1puUuDtPYWEX
	xMvCBWkAojBGSzjRYs9E5w9tnq2pfx75pS3HEjeP1X/dcuh6XhDLUUmhIDUbk/68
	OxBIZBCz4hdblRs3PZlitOnLxsDYz6jntWWgTwIXxo9k8uBm6jLUGDF7dblp4TcA
	5ikWZgxFQjTXqHkbFqA6cjAaTV2hPrX7lHo1ql3AWhSdrXNfDLJ3tuU8EYkt0e32
	wq7UFMl0s+jCnSBroHo579+A9lZ0d4p/sX4d+Az1ukEgJc0lxbN9/yVVVN+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746728789; x=1746815189; bh=i/6lhxJqA+kOR+2lAH2iLHaiJf8sPw+B2hn
	M9yX0v4U=; b=IT5xn7siBzD1PKyVAv7IcTKd32K757gtFG3G07XQ3KqGUE9fIT2
	3W3Xf4v209UqY2UUqB6I2vnbMV2QinfWRKhffu0mmc7RbrtbQZBJMWFADavw0g5n
	a5XPHZzI072wOk+74C1XOYJfESAasne96D8yP+Lpmyd7vqWCBK5Lf8htPRi8W19b
	mwZeYuMywNNTKFNyT/YdyINxPklCubtR2CReRUJ8Ou7EVmkGG12USSB3YNNMLYCL
	GWPiqRA0JUpJmcP0HxU93C8tGH1GwOHivkvWyAYdVhi66GmbB4IINliecSUtHZq5
	aEk8zg+SxNS4OF0rr3+WIXDYxBkVRamXocA==
X-ME-Sender: <xms:VfccaBgFh-NBYEgRiqZjQh2NG-n8BpZlQ_7mdurAbDA0oujggS0FJg>
    <xme:VfccaGDXJvnBIUm0kXpV4r6W3i7AEEJL7oXwZztDllyArTaVNNB7IMloD8syBPoct
    G5R4XR5Npbif3suRg>
X-ME-Received: <xmr:VfccaBFM6r7Nq3VtJabaaEli3J6HWBr4VuAsPk8bQJtE4B_J5LlSz-WhUSpW35orCZiVIMmZ6QylZbCQ30fu6-spo0UZY8Rip-Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VfccaGQVqexlK7Fs9tcINcRyPCi0ZIBk6f0AM_sdFYWFiGDlBKFrYw>
    <xmx:VfccaOy3qVmF209a_TTbhROwZTTYMPYcvOFDxz23LJhc-7NJ-qpcSQ>
    <xmx:VfccaM7z9174iSwdBZzLCFQA5CASBB6R9J3xP3ZkbYvUuHyfjTH-ow>
    <xmx:VfccaDx0Iw3qLFAjw-HBJ0ogHt_dRwTTJWvM8uK1bL1FwjWuz2DGcg>
    <xmx:VfccaCynBum-ghYiU24CalJ6m58OD8kcCBxjTr0nR_EdX3WLJ0eQFXCl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 14:26:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/3] Integrate the sparse index with 'git apply' and
 'git add -p/-i'
In-Reply-To: <pull.1914.git.1746579320.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Wed, 07 May 2025 00:55:17 +0000")
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
Date: Thu, 08 May 2025 11:26:27 -0700
Message-ID: <xmqqecwz557w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The sparse index helps make some Git commands faster when using
> sparse-checkout in cone mode. However, not all code paths are aware that the
> index can have non-blob entries, so we are careful about rolling this
> feature out gradually. The cost of this rollout is that some commands are
> slower with the sparse index as they need to expand a sparse index into a
> full index in memory, which requires parsing tree objects to construct the
> full path list.
>
> This patch series focuses on the 'git add -p' command, which is slow with
> the sparse index for a couple of reasons, handled in the first two patches:
>
>  1. 'git add -p' uses 'git apply' as a subcommand and 'git apply' needs
>     integration with the sparse index. Luckily, we just need to add the repo
>     setting and appropriate tests to confirm it behaves as expected.
>  2. The interactive modes of 'git add' ('-p' and '-i') leave cmd_add()
>     before the code that sets the repo setting to allow for a sparse index.
>     Patch 2 fixes this and adds appropriate tests to confirm the behavior in
>     a sparse-checkout.
>
> A third patch adds a performance test to p2000-sparse-operations.sh to
> confirm that we are getting the performance improvement we expect:
>
>                         BASE    PATCH 1        PATCH 2
> ---------------------------------------------------------
> 2000.118: (full-v3)     0.80   0.84 +5.0%     0.84  +5.0%
> 2000.119: (full-v4)     0.76   0.79 +3.9%     0.80  +5.3%
> 2000.120: (sparse-v3)   2.09   1.39 -33.5%    0.07 -96.7%
> 2000.121: (sparse-v4)   2.09   1.39 -33.5%    0.07 -96.7%
>
>
> Thanks, -Stolee

As always, it is delight to read a well-written cover letter that
naturally convinces readers why the series is worth reading ;-)

Thanks.
