Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC9320CB6
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011207; cv=none; b=N5mbRcGmZwiLi76b0fy8zICdVdNOBebbg4kCd1Oen81OHHbi0Ert74710/UXKvdb8m3OzsYHry11sTGM0aQCYDg2AhzGiqV1GkN85oMOeC6TS17FiEI+9aIZGphUPhCv8ghdK9lgM/z5ubQ2YuDrHUsh1R+KD9qUJx/rH0Sybx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011207; c=relaxed/simple;
	bh=roMonQgy5ZHuGaevtfiZnpQABAQ5FKLtFbIyDPUwpKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovFYj8hUhccSdSGZoR+AI/9K7GBKWNdaQLF8F/L+vu72Y9NYQ5A5b67tzKlszzszgLB96OtZvP/oAzZMfhuN7RW0feuKa40/AqMU82uCk1fxb0CRXpPtnwvW8yxhGP6iPuiYSbrbfKRS2J/aoexxYDmLqG1XWihKm9vDZoVU6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QXg8CH02; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0Byvthm; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QXg8CH02";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0Byvthm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4EABB1D00440;
	Thu,  4 Sep 2025 14:40:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 14:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757011204; x=1757097604; bh=qBc+gZHSUw
	cOO4CI5inzJLMPwA9h34fGAR3XLzCz56o=; b=QXg8CH02mN2QxUrmL75idYolyw
	hHdc9yx/M1TmQQpQ6WB93oWVESmUCMq2554P58+MkoR2zo+IiQe++Z5vx7xybSQU
	gSFAXkbAl/XK4toHv/L7/FBzTtTOu6zkh/F9E8SX+Mc9uE3k50mUy2IT8m/PD9cD
	8CHLhpvvWJIVV5R3+Ao0tVXvOQatH6jU0dFwCOhYQbhwdtxgl2giUQiJq7htGUcc
	kh8Byu1W7JrV+Mj/M+ZPqNaCjEyaAGDZf8H2QJBhfa1hnX41sxkpou0JvrZmF/b3
	kauOZCZzVOKCJJRVbOSpYuAdtBfcvhvR4iRpdbXXp1jtGHoT03/iV/itpzkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757011204; x=1757097604; bh=qBc+gZHSUwcOO4CI5inzJLMPwA9h34fGAR3
	XLzCz56o=; b=B0ByvthmHiQQ62+NSfzwGqRgX5MMKMhfCWen4gth/u4yRIwWv62
	SiPqDnUPQSBn2ej2SHKCfmfdc7hMpBDAQYTQEvy4nIKiIwtxO05EZ0W6IWPSOl06
	3H5BSeZRGkUYiV6M5tOXLAE4Ewje/TAI/z3HwdcoO1uziE6ip40UUrxi0DM+D5St
	ImV32N1ybbUDm0kXQ6MLnmSASKgOXqU060YstAlVUOe4AAIeOuqtRQh+jqSu1Qlb
	bsRZT60wRH+9yWi/gzvpHimiW7AgE+Q8yazdptTHdTXL0KdAY85x1TL9P7dmu/XR
	EIGR4GB/HMNDtL3S8nWWzrWFuoliI9hmm3A==
X-ME-Sender: <xms:BN25aOxcBnMXA0n0hfQ6h4lDcClWleql0ulO57dIRD0NcXCFlcM9sw>
    <xme:BN25aFwr1KXFQZU_tfI9LRvdN_jCp_umnNQr5k3H88BBVPaZ6Nw9JRezEH1I9h8M0
    cixzlV0886jE22nYw>
X-ME-Received: <xmr:BN25aGxIvIBQpH9ziZKQSC0ADWXM8j8uG8D1RUS71fd6q-4DKk-OPc7hLo1diYGAzODp64XiVePDJps2emKXRQ-P4p6LoQeur5HzEo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BN25aPaa4Zl0FLX82Yl63oZ1TgGda9gmg2nTibO6zCSDwnZ6rl59ZQ>
    <xmx:BN25aHVYDGmn3sv4xtrAsE8dOsmkFRPXZ_7bKFANlbplGRTypxamXQ>
    <xmx:BN25aNgP0Cly_Jh6-W9vehiRv8zTyps9w3myR_nyLVA4jMcT73GqdQ>
    <xmx:BN25aFsQZJ6U-87gR6n-M30ysFWNYUI9eV0x7R31IBZF4WvxLPGbHg>
    <xmx:BN25aOzrbHhIr4x9rC-7zafWk4KVH8vwaW7K6G5Xzdw8eXXZBtZThLdY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 14:40:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSoC PATCH v4 0/2] repo: add -z and objects.format
In-Reply-To: <20250904134017.47364-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 4 Sep 2025 10:40:15 -0300")
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
	<20250904134017.47364-1-lucasseikioshiro@gmail.com>
Date: Thu, 04 Sep 2025 11:40:02 -0700
Message-ID: <xmqq5xdy83jx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> This v4 fixes two codestyle issues:
>
> - Break line before opening a brace
> - Add spaces surrounding a `|`

Looks good.  THese are the only things

    $ git clang-format --diff HEAD~2 HEAD

reports on the version that has been in my tree.

Will queue; let's mark it for 'next'.

>
> Here's the range-diff versus v3:
>
> 1:  0323f1fa75 ! 1:  19c84e1a48 repo: add the flag -z as an alias for --format=nul
>     @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
>       }
>
>      +static int parse_format_cb(const struct option *opt,
>     -+                     const char *arg, int unset UNUSED) {
>     ++                     const char *arg, int unset UNUSED)
>     ++{
>      +  enum output_format *format = opt->value;
>      +
>      +  if (opt->short_name == 'z')
>     @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
>      +                         PARSE_OPT_NONEG, parse_format_cb),
>      +          OPT_CALLBACK_F('z', NULL, &format, NULL,
>      +                         N_("synonym for --format=nul"),
>     -+                         PARSE_OPT_NONEG|PARSE_OPT_NOARG,
>     ++                         PARSE_OPT_NONEG | PARSE_OPT_NOARG,
>      +                         parse_format_cb),
>                 OPT_END()
>         };
> 2:  b2b241f401 = 2:  6258316d93 repo: add the field objects.format
>
> Lucas Seiki Oshiro (2):
>   repo: add the flag -z as an alias for --format=nul
>   repo: add the field objects.format
>
>  Documentation/git-repo.adoc |  9 ++++++--
>  builtin/repo.c              | 45 +++++++++++++++++++++++++++----------
>  t/t1900-repo.sh             | 18 +++++++++++++++
>  3 files changed, 58 insertions(+), 14 deletions(-)
