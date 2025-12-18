Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6FD2C327D
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024547; cv=none; b=a05EQsxclh2VkeO6L3y5IST1rrlDc+uPtoAtuQmQkX5IyMIQE8fbEKfbRSXC3Lt+sernPC4KgEmZ53w6Sf1qKvSzt2uElavJwse4CoTYtThqMe6GKun1PYadACQi+u5/KmcA0aSkp89VXBSjtSIwQoM0rLdK+1FG9sYUsPi56J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024547; c=relaxed/simple;
	bh=kmUYtkRZlz19g+WnX4Oyp9aOAkeY89efcQ941XVrWyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bGDeRlEAbpoaBWuoR5XnIvehQvuWdRsCVkY5FxQ4vyPMkjJpr1QBis5O+B0a490ui3duJIG/T9JfpxLdi5Woyvs4/mxTtckf2R7SutJgL/toKXLAiaBYNQR3RS4yE16GDCCAOKWjVtrXtEYOBkUSvfrPJO7d1FmcRdXaADMu9R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nCLPC21m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BiFZK9EJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCLPC21m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BiFZK9EJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F6E6140020F;
	Wed, 17 Dec 2025 21:22:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 17 Dec 2025 21:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766024544; x=1766110944; bh=z9BSniiiY3
	zmTvz30D3s+CLBpqwtVU5yBJBwfFbwlPc=; b=nCLPC21mfvEG2dSro8Vr2VyuhS
	d+R9Z9v8N4bd5uPXz+WUW8/ulwe+QNcJsmNayEkhRc0uB25ZT2j8PPZJsakaYIgR
	1UMxtQgQfFIpMdHMQrbsgBMiB10aedDj1+0VMPuzTK3CWvc2FK9BW8E2b2O8lJxq
	fk7Xt3uLZF1wxIraj4NRRZSiCeCD08H5nOnXgMVVqn76vcBmOxTUpX5ni45BlYQL
	kqCP34lcZJTvn/ZI6SveausncHQ3YvJSLlPBHZmPZAC9D2fiduxkpQdfDDfht7MM
	sQ+ryuJTJxLBjfxMEbmGPupC1vDOut9GnEE/r54tnpt0AHQhdpGqvesn8VTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766024544; x=1766110944; bh=z9BSniiiY3zmTvz30D3s+CLBpqwtVU5yBJB
	wfFbwlPc=; b=BiFZK9EJ3ndDu2XODIXVHJrJFkWY3/xJ5ivRqOYiD9DkVvXgdsm
	hCMyHx/dLKHK8VOWi7Xjf28iVP3YeJMCvNGJ6jnscOp9CeYjWJQvf+D4FQawepkj
	kH21Xz2/bjjZwIBNEQyN6VBlUMzhT5XGiwyTpCrYqPeolzc8U9l/s3nI5RFhHRTF
	aSoVr0XMsmkq7tH/9jpWVL2DArb2NeX8alvPMDxD98DKr9Tp3oywAl4KSMlAdV6v
	doTQZ2Q8dv3iqhcHmj1J1qXkcH6gH3yr4PxhJeS+PC+27dBy9kKTvNEhIjV3sCxQ
	rsSeLSiNKf8mPvph7uiqirb3oVfiu0TtHXw==
X-ME-Sender: <xms:YGVDacK2tsKKbdjTQiEt8bWFC4ZpA1dO0-vBuVzUgrlpMCMI3TMVcQ>
    <xme:YGVDabMXP1XcAnk_2Hae1yjNuc5YbpYIVp8mYQGV5hK7dibHu2otBNj9QCUwUwX9g
    bwa_NU6jW57JXM9IdheLpCAf3WUrs7ozQM1iomSQMsTXc34ra7U_w>
X-ME-Received: <xmr:YGVDaS6nuKEve0YeZhYLrcKRs8pFvrEsctRa5va7R2kXTjwqUGQiJ0luSVs7wYzNrpneZoQtfuKA7sMZtP2HaRzp2No69Bl4yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhteegveelvdevkeegveetvdfgheffveeivefgffduveetfeetiefgveffteet
    udenucffohhmrghinhepvhgrrhhirggslhgvfihouhhluggsvghnvggtvghsshgrrhihrd
    dqihhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgthhifrggssehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehophhohhho
    rhgvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:YGVDaV6gIzl0fBnEk4DAuS4DXf8aMvaebmIOVmSjmYnxFVtKaCaFew>
    <xmx:YGVDaYFKJtluPPCcXmvod4tCJW-40kwOf8UmfolKlPSR_sKIgZNZrw>
    <xmx:YGVDadWc4UlyMllRGU7o-89vbZy_RaUcjwWKKNLPiPMxV5pZvPPICg>
    <xmx:YGVDaUV1FvWGhOPuDKID1z4jvY90EMwHYh05zVs7PXTxid4ET38t-Q>
    <xmx:YGVDaU8MGBncDpVYpNe7XL4vOo72hd00mO0KX4Hw-DWpLKN58-XXaZ_r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 21:22:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Andreas Schwab
 <schwab@linux-m68k.org>,  Ondrej Pohorelsky <opohorel@redhat.com>,
  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/4] sideband: introduce an "escape hatch" to allow
 control characters
In-Reply-To: <2615abd8c5d5c55486cf5885c47e09e52fad61b8.1765981422.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 17 Dec 2025
	14:23:40 +0000")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<2615abd8c5d5c55486cf5885c47e09e52fad61b8.1765981422.git.gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 11:22:22 +0900
Message-ID: <xmqqy0n0y1ep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
> new file mode 100644
> index 0000000000..3fb5045cd7
> --- /dev/null
> +++ b/Documentation/config/sideband.txt
> @@ -0,0 +1,5 @@
> +sideband.allowControlCharacters::
> +	By default, control characters that are delivered via the sideband
> +	are masked, to prevent potentially unwanted ANSI escape sequences
> +	from being sent to the terminal. Use this config setting to override
> +	this behavior.

Two thoughts.

 - Users may want to say "I trust this remote host" or "I trust this
   remote repository".  For that, something similar to what we do to
   `http.variable` to allow `http.<url>.variable` to take precedence
   over `http.variable` would be necessary.

 - It may no longer matter but a remote repository that may send
   messages as strings encoded in ISO/IEC 2022 would need to set
   this, merely to make the messages human-readable.  There may be
   other reasons the trusted repositories want to send "escape
   sequences".

It might even be a good idea to make the default setting of this
variable "allow", except for the initial connections to repositories
(i.e., "git clone $URL", and "git fetch/ls-remote $URL" with an
explicit $URL without using a nickname recorded in our .git/config),
as visiting a potentially malicious remote repository you are not
familiar with may not be uncommon, and users may deserve protection
over inconvenience.

But once the user establishes a working relationship with a remote
repository, would it be a lot more common to trust the contents
there than be on the lookout that the repository may spew bad
strings of bytes at your standard error stream, I have to wonder.
