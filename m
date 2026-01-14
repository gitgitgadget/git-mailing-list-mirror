Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F126E71F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399850; cv=none; b=SNykc40eedG3680d6VDrDOOef7BgOREm7V+e50elwOCvgx7xYIsNj5i2LPhFd2eTjxNkGWjgDgoEo7jJoPNtx6EpWD2vdhII7BPb25rWw3muznhmC8LbbBVbA17D+yJWi2fk0r3GqeJ610yFmB8w8uR9tqMeoIU/UGnfgXXwKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399850; c=relaxed/simple;
	bh=h7zrvH32DBDqkS5EItatUHpu3oy/j0wMi8hzp4m2k4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CtG0Vyu0JpnBu5P7jIvU9LVftzTOkJD9wDpNEA4Boxm8/mCGq8wFwqSqYs6dRAaxcoGRDebMQDeV7sgh6aDu1wHoNCmE6DyVCJJXYtSyvUDChlRqWVzTn9MfNvxjPJ1j2WPmaem/RUuKNS+oMPHKEoESoXx9RqVG5FkhYKCKr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C+ADjJQE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RbwNIRHl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C+ADjJQE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbwNIRHl"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAF7A7A012F;
	Wed, 14 Jan 2026 09:10:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 14 Jan 2026 09:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768399847; x=1768486247; bh=h7zrvH32DB
	DqkS5EItatUHpu3oy/j0wMi8hzp4m2k4E=; b=C+ADjJQEri0x1PYF8eQYLvLjd7
	zO6/eUG4uOlHrDnitQbANv7V1DMPA5Ea0pOIHCAhJwf2TokKFYyfTDvEBjot8wsL
	jmpDSCgSYN5QAPvOWbdIrXL8UWnhSlewR9hCCpadmHBo/g/UJ69M4O5I+dRZa4gz
	ZGYfUwrMeY9UxJ1UwyPljJsG/rsZ8JwMd06axQzlRrF27dNkVDPG1LYykV3GFQ6E
	n8Gvhzq5V24o1mbVBll30i9G9C02FXHxXneLz5jzH6ZAcNjlA/W8rulUGNNvDNYv
	0eeOz6NbLyRmQdzUBCtaT/7D146YwN35sJOdS31RgzqBsgGSbkNNrHk8axtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768399847; x=1768486247; bh=h7zrvH32DBDqkS5EItatUHpu3oy/j0wMi8h
	zp4m2k4E=; b=RbwNIRHl7chRiHmPEjrgMv4+/j+7q7PcPI4M+PteLikfZAYlUqr
	2rzuIUcm324MzEEhUunQfeMwSmasJSI2cEowptxL3hwtJ4du0jLg58Jjv0yeKhAV
	D/JRkvvUtryYMeizu1pQJlwxvL0V/fdeWOkmcsdFBwNQDeNzcG7eq2oPwgp3eEze
	Tprzp07YKchoZVePJVMtd0waz9W5lTXTUH2iZwpfFVaex0L2huSCCqVi68R3+U/M
	LOHLJ8L684mkf0thbmiGJriB8CrwRhIzvuTYIA6lN8zQ4ABSTShAb35em1jKEgMx
	eoVrZABFnpPYQcefqr/611lZMTviSNg8/jA==
X-ME-Sender: <xms:56NnadUNQTOHBCvz-qmLAWC21cmLjqnQ9k3TTrmbXhthEav1ZgqiYA>
    <xme:56NnaW6xaZ_zf3Frug0mxD40y_WN6eHafkJcPFP-5naS24xtnBIX9txYGEi_mkc1S
    Fuw_XRsclIL4l0DN6DAJ-5-vgF1REAvfaHKqEdfeVPhF1SzS-MU>
X-ME-Received: <xmr:56NnaQovRzHZ-0C60U8UaCfzeWvDyI_SAOVIfqExuWVgD6VtxhREtn084mFo2AMyuRQfM_oAuyTfauCp7x3wMB3FybV1C2fZK0vOwyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeffeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepnhgrshhsvghrrdhgrhgrihhnrgifihesohhsshdrqhhurghltghomhhm
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:56NnaRki-oeBWgWXTklojoyNnZj8gsC-Kp_Ras0hF3LEwjLgeI7ZdQ>
    <xmx:56NnaUNxN8trDrwVv8nwbqzvr51dRZu3ValWs1su4sb7mkQf90Xo4Q>
    <xmx:56NnadNv79hKFT7QXZllyr7flEnB9WdkeJ2sF_Q_qv6icHyf9njL3w>
    <xmx:56NnadgKMnjKEvK3c8Rj8vy0qBdYdok95RWWELhjpfYgfbeGQEpDUQ>
    <xmx:56NnaTYtZFPR03pwGRmsSF2IanKFINyZVIU8amlJYX81-ibXj--lOEc8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 09:10:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH] Fetch missing submodule objects from default remote
In-Reply-To: <CALnO6CAVup7AeOyUu4Qt9onD77c+GWsWJ1o5NVDtymGhwuE7XQ@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 13 Jan 2026 21:19:14 -0500")
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
	<7FB6BFD0-4C54-4924-851E-D4B5C574D7FC@gmail.com>
	<CAFcKa=_P8kUXvsuneQsoi=Bwbmc8U1kBv68fx4yq81vKBLkFEQ@mail.gmail.com>
	<CALnO6CAVup7AeOyUu4Qt9onD77c+GWsWJ1o5NVDtymGhwuE7XQ@mail.gmail.com>
Date: Wed, 14 Jan 2026 06:10:46 -0800
Message-ID: <xmqqms2ggu8p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Thanks. That should be sufficient for Junio to correct it when
> applying, ...

I'd prefer not to see such recommendation to use the maintainer as a
janitor, though, as the number of contributors well outweigh the
number of maintainer(s).


