Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087632EBDC1
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096673; cv=none; b=qmTAyMiL3AjLpyVvvS0R3dUKZ7JEHaqcY0bazb4rDxrclVShtkvwIUyOaNTrK6Z+kMlOfWerhDwglGH/d8TqEEIwQY12+n/tzzYVRYtc7ikCmqNn3REmiKil2thUG+h0+tN2PL+JKAzbcxi8cyJ0mWz4WdJOOpgZa2DCJ7Jf6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096673; c=relaxed/simple;
	bh=H1IOwj0iKDpqn0LZ2iiYdhGQDHXW7+soTLgyTstfyIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y01XsyrGq0BPqUyMxsVyobiy+njNq+JKjAz/W8bp5kgMH6fVSoh6C0p3BYc0Z3KmXIteTGRHVEG3tFRo+1/UHrSKRPFwyKaEJ+eekRsWLFCXrL8+n5yxjJkV8XjurLaWeCkQMcxHZTqEd9hawP3GfzanFUtfZwyinDXvwI3LLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b6Z1FihP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Euxd1kK8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b6Z1FihP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Euxd1kK8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E81197A0038;
	Wed, 13 Aug 2025 10:51:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 13 Aug 2025 10:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755096670;
	 x=1755183070; bh=Ni5mpO+TpQk68vvsv13TGXz612Ulr4+4Y17zPkBuMjw=; b=
	b6Z1FihPxma2nTHpFtEC5NCOqwhd/EDQ0GbYf91sbxOXMg4ASJV7XENYcvzLU1DQ
	AC255sDnFyq9+xRWGCNFHOxbd/mgI6cshHFL7OxshLHCgzug1nz1uyjfxqXGbgmP
	5nxtjVWGB2LYZrBNaGKMvZcHQnGbo5u29Y4FIZSD9Ekzu7kCHNPLZeLbFWVdzxJn
	diNYapmCHdL/XPTGgkFVXoO7NhWDHQXqveITce8z7vNCmBDTuKNkmyarWhBoFp8O
	m7RfFqqvZzhkxDElBiiv+6pb4ceqwscS8tJidbqLeTk8Obotq50CDuZkALvBelRd
	9EaFNguxtBE6G3ydM63Orw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755096670; x=
	1755183070; bh=Ni5mpO+TpQk68vvsv13TGXz612Ulr4+4Y17zPkBuMjw=; b=E
	uxd1kK8ymRoT7rtAd4+h+aYCZmumvv706mDC1lzWtHkm5Oj4mDQ4q7AlHcxmtuSy
	NxachE8A/ExjrVv2ru9Jx0zvmME8iKlaE0Rh90WsJSxT0/KJkwX2VI/SGVV5sGP3
	4Utun4L+sql8h/ucRhCfV525bC3k+bsQid6ZN6fq/aItks6aR7R6tDtFzolxVdJY
	BF3rWNhvd02M9RQVE68Esp6cByDJdMHjTXjVu4DGF8Qz3MeBavtCK+WeyEtp/Aef
	kVfRtKd7lzYBzN9CVK9s3CIY5TjwQ3GB3AuQswKRdBjl5blO7/dupQoyTapRdGpP
	i+lzj0m4ZvBfr4Vqedg0w==
X-ME-Sender: <xms:XqacaADf-j_lmjLpgHsGO3dX9g402vNrBYeTfujRokD08GIaZMIHpw>
    <xme:XqacaNEAFaQT74oXwA9wv_fA1MiHwo8-SIrzXJhaEWos36QokIyQ3b9FP7NhA8DYo
    eZMuV631B4b9XvZGA>
X-ME-Received: <xmr:XqacaAIteZNh4Ijg5fO4qT2leRuWaLwsyO_qqOWyYAsOeVF4onS1kRDJkUMUAt-3Hq9Z0zNQnSg48e_EZCBfFX8pzNJfdi414a67c4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepughilhihrghnrdhprghlrghuiihovhesrggvghgvvgdr
    ohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XqacaJkrIZA5OklTp4e2QrGP9Yx3FVPEtmAlyMOH4Gd5CL9R_vjSsw>
    <xmx:XqacaARU7Vh94BvPpj87WLfL1QoGrch1Yu6NuGS3JBBYjNGy1TrBvA>
    <xmx:XqacaDJxI4ok_92UxT6IyREgJsrTdaslyiAQoD1U8s8DNZImkP_muw>
    <xmx:XqacaOAED3qKFvzGqFHB77cocZqzJ-h3Wy42ssqafJBeZtSrPiTjvA>
    <xmx:XqacaHeXq3qcx3TRZlKPStW6J8kunkxiVrbx-LVHl0Flrs7V5om-WNl3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 10:51:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?=
 <dilyan.palauzov@aegee.org>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: git diff shows twice =?utf-8?Q?=E2=80=9C=5C?= No newline at end
 of =?utf-8?Q?file=E2=80=9D?= - no need
 for repetition
In-Reply-To: <626efd2e-0396-45a3-9a12-29bb8cbfc173@gmail.com> (Phillip Wood's
	message of "Wed, 13 Aug 2025 14:11:55 +0100")
References: <1b0d634286da16f32cd9faf541ee28c811d6c83f.camel@aegee.org>
	<626efd2e-0396-45a3-9a12-29bb8cbfc173@gmail.com>
Date: Wed, 13 Aug 2025 07:51:09 -0700
Message-ID: <xmqqwm77nule.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 13/08/2025 08:20, Дилян Палаузов wrote:
>> Hello,
>> when a file, which does not end in a new line, is modified, git diff
>> shows twice the text “\ No newline at end of file”. As this piece
>> of the file is not modified, I think git diff should print it once.
>> In the example below the first “\ No newline at end of file”
>> should be skipped.
>
> The "\ No newline at end of file" applies to the line that precedes
> it. Removing the first instance in your example would mean the the
> newline at the end of the file had been removed when the line was
> changed. The output of git matches what GNU diff shows for incomplete
> lines.
>
> Thanks

Thanks for a concise and accurate diagnosis.  It is unfortunate that
we cannot point at POSIX X-<.
