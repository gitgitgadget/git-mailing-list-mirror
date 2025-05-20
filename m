Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3DD25C829
	for <git@vger.kernel.org>; Tue, 20 May 2025 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747778995; cv=none; b=eanoATOgbJz9OZVDxh8+XwfJWXRb08lZ5kkmGY0+Ork9uqYjho/0Xz/UEMrqzozh40hh5voOIoRI1RnxFl0c2BX/u3zwKyDlG+SkB6R8siLicLuBWfbqyVTMQQJVoGlqoLAd4F3/MALTgsh+KCvwAZQfx9OAca4Kn3MDdTQ0OdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747778995; c=relaxed/simple;
	bh=xjeqLBmYcMN/8fXLxsocLkUewoxB9RvLCPE8JOIx0bs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rz8Mprm8tKMmfmHXQq4qduHFCwsUda5xjdQ51IozNMEo53TQvmMSRgYvmO1nbpkLrszgU7acZU2VdE+uWpS7xa0Fba1e9EgPkh0+TR1bp1h3Zusi4p/Vdxf/3uLb33gu2+zcBcobhJuX58mDgzoei2tLaaZGhiL2j8DqL60pmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=St4n/Maa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VO1QdZFB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="St4n/Maa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VO1QdZFB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 94B6311400C4;
	Tue, 20 May 2025 18:09:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 20 May 2025 18:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747778992; x=1747865392; bh=xjeqLBmYcM
	N/8fXLxsocLkUewoxB9RvLCPE8JOIx0bs=; b=St4n/MaatYQ5zYZz1wSEJuwMVF
	gnvwar3XNy2qS4rIBSKcrhwYmXlMUYlfkVOd91P2oxrFuv66K/XcJgLbr3kFWwEU
	3yM8YLSQB78TwfUq9gxVbK9klf0EDlErIK1IU2nTBPxFTxtPhO9vEX+EgW0newJU
	9GIDjFbsMhpYJG51PqHY/tiQkKXn5wW7s/12WuovtIvP/rohtAR3eryajje+noXm
	HvU24675Kn5t+pRpME82aLdtrvAPOZXAzgK/TE+e8jZEgs18C7HsKFDjlQ4cxNQZ
	9SmFBF9kncXLaOqw67aiNAj+RXUPZWXEjPDYfpI3vbhxnLYE0RZGNmTjZXTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747778992; x=1747865392; bh=xjeqLBmYcMN/8fXLxsocLkUewoxB9RvLCPE
	8JOIx0bs=; b=VO1QdZFBUoLPPepk0xrOoj2H66oKF2m/kxJtt8O1cQUsbH9yjI7
	9taqxGaQLQrMzpq9ZzqzVDKAQmZ8LU6sigEZLWRL3nvWkVhCdjjW0JbZj3IX47tH
	KbYy+rUaZr3QzLky/tUnSTLtYIAOcaqtnilMGP3OJYAhSidSQqIvnFpfh3EdvkhY
	b0I0I5iFwCUncCuYm16jhb9k6+rSwc7/Kops4iEz4l/2UICXe60iTKua05s6dLFn
	rgSUcRBU+BDUi2S9zWn4G6C4rcXutUrYmkgeOTZt3LygD2dHSXS6PlMAui8jMqyC
	lcaI0QgH+PcJyVwbWvEyj5NBtOWj7lavkaQ==
X-ME-Sender: <xms:sP0saMXK_EaOoZDn8AR6SF9sDEz-qoVIuSVODn8X5jgLCzy66qNPQQ>
    <xme:sP0saAlwYWM5reooWiD4rgGi50tKTAblFwsPsqMru1gukcxklRgOT_NJuzbLh9mY0
    zw6JD4H0fb5W8osWw>
X-ME-Received: <xmr:sP0saAYi0ehZbEIEK0bezrNGSR7wXhOkw-bbFDOq8M3dxPMA7u6PPichTfDuCiGaVyuRwUTQItdxoS3M0LS0ZsQsT3qw3Oi_XhtGGKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddufeejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sP0saLVMCNxCuTWTM7B6-OHGorBv35Zm8EPLngrou5Jv9JRA9jLXHA>
    <xmx:sP0saGkLkw0ZOj255xZw6vaFJ00C4fv5VE15_JLpbp5O6aEzySqDDg>
    <xmx:sP0saAfOjveVwEG5ZvKd4MNkBHVZT9YGcC1hLaNvcoagIiMfAWPCqQ>
    <xmx:sP0saIGU-SfjCeAvt_1RFxz8zi25r9OcBdIopyjU6smV5u0HVYAe4A>
    <xmx:sP0saL3N5EZa2I1RE8AtiBmh3AS71HH6eygfyJWCnXx39lQ8-UbZcZdO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 18:09:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  stolee@gmail.com
Subject: Re: [PATCH] t: remove unexpected SANITIZE_LEAK variables
In-Reply-To: <dw57mhszlyk3s4rvitdthpbaoiicjnnraq24e6uxaeu2kze26d@xpiouvxmhowr>
	(Justin Tobler's message of "Tue, 20 May 2025 16:16:02 -0500")
References: <20250520-kn-remove-unexpected-exported-v1-1-bb60cec57e84@gmail.com>
	<dw57mhszlyk3s4rvitdthpbaoiicjnnraq24e6uxaeu2kze26d@xpiouvxmhowr>
Date: Tue, 20 May 2025 15:09:50 -0700
Message-ID: <xmqqbjrngci9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 25/05/20 04:40PM, Karthik Nayak wrote:
>> As of 1fc7ddf35b (test-lib: unconditionally enable leak checking,
>> 2024-11-20), both the `GIT_TEST_PASSING_SANITIZE_LEAK` and
>> `TEST_PASSES_SANITIZE_LEAK` variables no longer have any meaning, the
>> leak checks are enabled by default. However, some newly added tests
>> include them by mistake. Let's clean this up.
>
> Indeed, both `GIT_TEST_PASSING_SANITIZE_LEAK` and
> `TEST_PASSES_SANITIZE_LEAK` appear not have any purpose anymore.
> Removing all remaining instances where they appear makes sense and from
> a quick search it looks like this patch got them all. So this looks good
> to me.

Thanks, both.
