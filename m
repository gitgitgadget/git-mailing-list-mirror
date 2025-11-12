Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB131BCB6
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968275; cv=none; b=MPyDlNClubyGRCZF61ufK6fk66DURHnlO3LM6w7WduZwaEfKlN5YugipqtQlLf5q88DHGw2CINDcF6TzEPFEGAgxsIFQxnM6f2SBMQN4H8nHbErVSimadrm6Ywyy0HgONf3hHJePSsn5JkLEDhDlD+wCs+Y985VuvE8M8VrD1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968275; c=relaxed/simple;
	bh=6pTSTomVQ+46tqjA2Do/0h7LH/hmMx5SGo0P79qcrg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e95iPby7uePj2jixDskbV5ekiG1Bfy3cjvfznpcoFtwGq6ekv7vc0oxnXbWFZv/co3fZtOtQo2WpF4P02FOSVJnYRHQXlNsoaXPY7cY9hKzOCaxDMSgzcJt6ddohR/rmoELevdzY25IS5Sd7LYSBvNxSCyOwfLHZGysIOPiEO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GyObhZzQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avUBTatO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GyObhZzQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avUBTatO"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 967247A00BF;
	Wed, 12 Nov 2025 12:24:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 12 Nov 2025 12:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762968271; x=1763054671; bh=a359Vqb9Qx
	WgkDY/+RD9i4bstQI41dqtmqgWnbUYg0M=; b=GyObhZzQ/UEk6BXWGkkxrGYksH
	d+Oo4TU5cjt7fsQ5nry6z9vuWJ8fcojSXTRTtr0vVTMTyCLs2PF3i0Rpgy3uwzvi
	RP3Dt5RgNk6h69zqCB5qMM2CMVLlorNygZXGGdxKZZTEjr8X0RJsi0uo6u+AsUxo
	G4dafoT0zvGOWFiPXt3d39ywF39wB3P2EwWLu9OCy1Nl3ci0/I09+4aKn3vQms7x
	2TfT/0xxxbzV3FauIGwdAHdXnbOJEh1W769pGVOoXcdU8vicVhI8S3rD4QWw/ySw
	yCWI2o3AhPB4usFgKaC9fQX4qngJVKgxZ8iumv8exN7k1/w7NPTyvaLQbLcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762968271; x=1763054671; bh=a359Vqb9QxWgkDY/+RD9i4bstQI41dqtmqg
	WnbUYg0M=; b=avUBTatOuli/yhoA3YKpN8+H3TN/FcjRNKj1XTxfpPJ4zCTIP2K
	cLxSBeoNkuQibS0Pme5np3cCMZfB2nZ+4pHmYr4duaPPrbxXTorUmp7qS3JwEMJx
	l0SaDqJ24/uv7ZDtdSvWrhCJfYoEtwkWRslDEEawrWcneEQdnJ+n5FcxJdvC02el
	1N92bNr8WNTID8tDkK4qV0jbOwEy3xnY8dZFvlBXWNpLZmJIVgmxBUeJuSPffC71
	USr3SXQUXemKaMNM/Rcbx9ul3ZudMKsOZVe2cYjqI4/aD3O2AgAQOL5KssCLTKjS
	Q0ujw9Scjwv78QjSAcic2j7sBRajEHwbp0Q==
X-ME-Sender: <xms:zsIUaZVK7Us83GsXykANnluNr6EszDH9XUT6bwFBC-trZC-tf9_27A>
    <xme:zsIUaS4PVGAoI8fV3Km3J0CYZhTGLMIydQFWFqZRT4EzslqkQ1PJfYYY1WTn9D_f_
    h8Kzrplm-zkWkXJzv-wMJh6o8vCZjZOhsspejTRSi2epI2XZE1L>
X-ME-Received: <xmr:zsIUacqZS9Im7_Tqal1VDwQwcEql-xqEBQnFSp5j7pFxz-cglxaaZ405Izl4Z2qgMS3xKLxBC3N0W_cu6lZcIwILd9OBVNGsaX4H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggulhhtvghrnhgrthhivhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zsIUadkVxPel2JaCw1R0FD06Yfnj1MN2Hir0PBhmTJMt7uJ864Qnbg>
    <xmx:zsIUaQO6Mgp8COT8yMbf54LOrPm_GEPLoQdPhGNnVdwIlh_OYCEuMQ>
    <xmx:zsIUaZPpSf7mnZbRM4h_nMVmhG-Gu5nyrvxgth6WICm_gJ0VPxtu7g>
    <xmx:zsIUaZhhGmYFzOuurlf2OiB_QmB0VJOXNO3dhEicbUj3zqOr1MtXeg>
    <xmx:z8IUaYCHWjRRwLSqujKn5EbOa35zzdq2ubBCPxk3kjOPCx-spfMjeUda>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 12:24:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: ZheNing Hu <adlternative@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  ZheNing Hu via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: add --committer option
In-Reply-To: <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
	(ZheNing Hu's message of "Wed, 12 Nov 2025 23:58:02 +0800")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
	<CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
	<7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com>
	<CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
Date: Wed, 12 Nov 2025 09:24:28 -0800
Message-ID: <xmqqqzu3qi43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

ZheNing Hu <adlternative@gmail.com> writes:

>> I'm afraid I don't quite follow. If you are amending existing commits to
>> fix them up after you have corrected your configuration then they will
>> have the correct committer automatically when you run "git commit
>> --amend --author=..." to correct the author. If you are committing
>> before you have realized that user.{name,email} are misconfigured then I
>> don't see how "--committer" helps because you have not yet realized
>> anything is wrong.
>>
>
> You're right that after realizing the misconfiguration and correcting the
> repository's user.name and user.email, running `git commit --amend` will
>  fix the committer information, but the author remains unchanged. Users
> then need an additional `git commit --amend --author=...` to fix the author,
> which does work but requires an extra step.

Isn't it more like "You need to run with --author to correct the
authorship by amending the commit *anyway*, but while doing so, the
committer information will automatically be corrected"?  As I said
earlier in a separate message, the author and the committer are not
symmetric, so having "--author" does make sense in the above picture,
while "--committer", as Phillip points out, much less.

