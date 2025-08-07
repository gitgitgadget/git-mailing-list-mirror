Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1E5695
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585010; cv=none; b=rG5YmsAgZwhHoPExkW/qxUvKeT+Q4bsicZnplKD20FhnVRG39qUTJf5pAv43PcXcJkfyGJgSyoqnBlv0tq0BEo9fJWywcpmEk+RWIXyBkhTmJP9K6y7vxaHXarbutcvtWZRMEUqLK3NA9Yotq0tKeRmJAHjv3Bu+lAL24BmnPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585010; c=relaxed/simple;
	bh=foRC4B4hP+e7DcWPOaNOcq2SrD6lRjelkgL75QA+GGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZalfjWG5em36xkKccho9ieMASApvxl+hk427HVGsfJXK3pu+K1NOscY16mjJFMzhgDqEaRPKV40iWcILGDGTcpFd6L7A4dTbg/q4UzHipJC4coPLoT1ozJjI4I/upKfM5brrdCBbXPi2JvMZdjTL5pyCWxJhHa3br1zdIx/lj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ofi74K+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PW7T4jOP; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ofi74K+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PW7T4jOP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CA3911D001B7;
	Thu,  7 Aug 2025 12:43:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 12:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754585007; x=1754671407; bh=iUu4ub0PXO
	U2bU1LGDKpxiHRapurAmlNSNN4H/9e3bo=; b=Ofi74K+1WHr3N6xZ0F/pxQVsBn
	ukRXjreIfAtDX9xFwO/egtWVlaMd8iqxhg2uCbIGtquwZl9j6C2hC/+uKcQ/JSav
	s/zCp6oa8C0iegwvsO159DWuUCH3Dtgbkwd86xiKs+oX41amNf4lvpX23Qq4A/0g
	NZlINd/dqzTyQ96z9DJEAdMcNoCKPd2uV/dleTqqN/eRwUcxNVqC5urOaWcUxMgU
	BQ45R+iAZx5xZVRS02irVK4jdJiM/s+XFN3ui3KisMu1JkNztutDSyH7f4rL+aVw
	zUUAk0SUxB81BGGp+psM8TQ/Pg/TlbJRj3vjuOnMawjJ/tOwjz7BwGHbJj2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754585007; x=1754671407; bh=iUu4ub0PXOU2bU1LGDKpxiHRapurAmlNSNN
	4H/9e3bo=; b=PW7T4jOPtV/WMO4ENF1CIhvAFdYgqUb7LzB6JvzJ4sA7jmZFmbc
	KfeKSyrJRFjSppH1Y0tMMLSyJIGk8KNENo9QRQdJ+k5FSLuUlheD08qYJG84Acq5
	Oh2FPYqUqY8UNcDbi38jsv9Bfble04yurl+BtsDCuwEpiDMoRxkqNd9DLHUhk5Nr
	2T/VKAAUL5Je96WjNFOkoIVCJ9zxyY8Rb0Rho98EV5y/YOSrB+9rpYU7ve5y05sc
	03b5V6VG2Ic0CIIK9BIwJTzkEHnlXdIz7ZD94PIg3E7IjFRD8EwMvHhrGAgsfhL4
	zJD4SOxHUCMgQGRM3JsEML7MtUQYA8k6YFg==
X-ME-Sender: <xms:r9eUaLDof6WMi_ZYDFN_iFBo6C9Ow-nXR-VyeHZannhe_C8-xpiPrg>
    <xme:r9eUaPEOCHAJg_n3PpheWzCqk6IoxWnav2nnWYoO5vGnRz2iaGzZoaw2PVidNKSEf
    fpD7WC6kcesZFzOXg>
X-ME-Received: <xmr:r9eUaNBQtkMcHUJPFm-1JLevuUOrIrYSvXELS0BUkV5HikZFa-TG80OMkQyc-idXLtBdunazKrKN6Pi_vZzYMZOHTkJhpCC3xmsBYPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhh
    grghgvnhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:r9eUaPUcsMjw55qDBKi5mYiudhwYRgNTCu1O1-FvH2IPav7zOG_xKQ>
    <xmx:r9eUaBrSKSckyFcZi6z6k2zDF797VaNJzDa-wNwxJessoFtKjpQMSA>
    <xmx:r9eUaLQsZO-ETgOO_fUEj6MObfjm37n9GT4wMY0Abldfn6pLx1aajA>
    <xmx:r9eUaL27KcoNHUm5N37p3-uEuFbQPxOtYhPJsJCjLeidp3qa0Wnf8Q>
    <xmx:r9eUaLVSUBSCBQwS6YNc3Zzpn9YSZol7Hw3G7O8iJ9jctFS4nXmyS2JO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 12:43:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: introduce `count_t` typedef
In-Reply-To: <582e8e75-c6eb-4845-8f3b-62f234f0964f@gmail.com> (Phillip Wood's
	message of "Thu, 7 Aug 2025 15:17:14 +0100")
References: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
	<582e8e75-c6eb-4845-8f3b-62f234f0964f@gmail.com>
Date: Thu, 07 Aug 2025 09:43:25 -0700
Message-ID: <xmqq4iujqdzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> On 07/08/2025 10:22, Patrick Steinhardt wrote:
>> Historically, Git has been very lenient with its use of integer types
>> and didn't really give much thought into which type to use in what
>> situation. We interchangeably mix and match signed and unsigned types
>> and often times blindly convert them. This use has led to several
>> out-of-bounds reads and writes in the past, some of which could be
>> turned into arbitrary code execution.
>
> My feeling is that one of the main problems has been using different
> types for loop indexes and loop limits. If we mandated that the loop
> index had to be the same type as the limit that would improve things
> considerably and without mandating a particular type.

Yup.  And the limit being unsigned would force the counter to be
also unsigned, which can introduce buggy constructs (like counting
down).

>> A discussion that regularly comes up in this context though is what
>> types to use for counting entities:
>>    - One question is whether the type should be signed or unsigned.
>>      Arguably, the answer should be to use unsigned types as long as we
>>      know that we never need a negative value, e.g. as a sentinel. This
>>      helps guide the reader and explicitly conveys the sense that such a
>>      counter is only ever going to be a non-negative number. Otherwise,
>>      code would need to be more careful as it may hold negative values.
>
> The counter argument to this is that it is easy to write incorrect
> loops when counting down if the loop variable is unsigned. Using a
> typedef that hides the actual type makes that harder to spot as it is
> not immediately obvious whether the loop index is signed or not.

This is very valid argument against typedef for something trivial
like an integer.  Use of proposed count_t loses both size and
signedness information.

Thanks.
