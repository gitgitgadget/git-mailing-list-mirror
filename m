Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13E13B7A3
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773784355; cv=none; b=bvpFTwkVsxvVHrtTMwiX0dFrrUI2skPpJd/S59FYYfbwJWY208b/46IkVR4eV/Dz2AZeitNfSFwHPPuuB7aG10Giz9nWcDZs4DohJxyxepqo8e+KgxF2DYwUMHfudQpiyqNmyobX40GavTQKx3bpNzZXEMXYwqnr5ZAjAXeULRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773784355; c=relaxed/simple;
	bh=aOnTZssYFfLq5LJwoGUSZrPMlkV8/b5sPMTUIVH8VtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ulNFiSG1PgN5KPuf0vpDwTfmsD1ISBSXYvL2ZaPniA1p0uIptgRXGFrOH+/ePCFuaM260pqB0E5/Qp/P/XzJI98VeCQKBj5s86v41LZEhbCd8BPWtaLB+Q7bMnWJi8g/JQU9eaWQIVtIjFxfdefSCgRNbHzY/Y4t3OMfOGyeZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fIzSGJt1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rPrvdgxy; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fIzSGJt1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPrvdgxy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 55C6C1D00179;
	Tue, 17 Mar 2026 17:52:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 17:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773784353; x=1773870753; bh=K4SFJCC5Ar
	9pkEGxfJ39z1DKcBMLb8jerwVXTUg9UpE=; b=fIzSGJt1mgysOw/wh+EYF0Lsoj
	tWxZUb6lCUY9npamuq5dYFNwkuerGZ3Jf+IV2kHNwcXwr4zaJEx9YMDdkbJSAnaO
	JIXmGf/MUaDHJ5frWCNl5Nil3idQ66go5CzFdeCBu972VxNfA5w8oOLQqnuiL3sr
	S5A7REE8S7K50ABuLAWeJCtO4C/QRMAm3T0K+Uk90Yf546E/uYMsLRlqEMoHZOKB
	mdGm45rAiaI/y/x2Jpe9H0FNPRN62YWf9UAoACVcEBff9PunHwO71E4KJqWJRW1F
	5VMz59S1KuS8l36Cfz7ApDspp9MAUoIuMhDN7mqrgVuetd7FipDrC3Ofic1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773784353; x=1773870753; bh=K4SFJCC5Ar9pkEGxfJ39z1DKcBMLb8jerwV
	XTUg9UpE=; b=rPrvdgxyh2V3o8uU6Zl/AiYuvGuSkvwzf4JfCsJR5J003P6t9NI
	3c/USXvDLJ/aavhjbkD8afLoOj/L2aYPDCBWkuQ5+7Og/Mn+KlHTggYnTOMWB78n
	24ISjavU12k1pA12OePy1pi/DQnUkzdQejGvRX3VQY1uqOmNUg//3ntO1+rw9FW/
	wvcxVwDCwViqmWBiNGsFvVUV9aicLaoKxi1i3KNxVfT+QI7KMUyjdCAe48eGbuHn
	4CWZdyG3oyWmZRd9EGFlnAHWCqyk7oOQq6mdITH8zDH/h5m/wKrGmlfxqIQLZr5u
	LBdPjMdKXnKOT7bxuTt0tL/6O6QOw3VXeKQ==
X-ME-Sender: <xms:Ic25aRKqKAzqV8KMYeUPTzaEdxohhbBVnQzIL5NQ6LXHN-pB9udmsw>
    <xme:Ic25aUJW430LmGMaQG6DqyJ61v6BnIsxIen0YXxpHPGkU02N_GXRzSnDJ1wgEln8I
    _04M4tP3O4ObslEHHmt0wFeiqDBXBUL8xv_wS_E0GT6gyEtQHWeEw>
X-ME-Received: <xmr:Ic25aesTDQifxxQLacfoxIvkwEVu8TQeCUY0E4M-QwF2AhWzQ2l1syCRtSE_-KviQU5mefczWNh5hPrnSZzhyP-C-5L9mvsWxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:Ic25aRSrOi0WDwz7WJlqgUkB0Gipc72aoA4_a77ovspVCO2hSsyiLQ>
    <xmx:Ic25aUMFYLPMLRaNCRbMbF7aWgums3yqClgNLubZalIHFii-V--2Ig>
    <xmx:Ic25aWa99uYTGSgstwtpbdPrIE2PKVFrB9sk_DMwiHT7wRbmFqUbGQ>
    <xmx:Ic25aexbK5tygiOGBIpuZQ4-bpvjeaRryXOTVJucxPxkPqv4Vs76dg>
    <xmx:Ic25ad750jPVsWtNnXb4Regfog7dcy33dH94OGss81Ll-bdBVO3O9TQv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 17:52:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] revision: include object-name.h
In-Reply-To: <fda0239103f6e2b9e76403144b9ed2e9205e1c2a.1773707361.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 17 Mar 2026
	00:29:17 +0000")
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<fda0239103f6e2b9e76403144b9ed2e9205e1c2a.1773707361.git.gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 14:52:31 -0700
Message-ID: <xmqq341yjf8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> The REV_INFO_INIT macro includes a use of the DEFAULT_ABBREV macro, which is
> defined in object-name.h. Include it in revision.h so consumers of
> REV_INFO_INIT do not need to include this hidden dependency.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  revision.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/revision.h b/revision.h
> index b36acfc2d9..18c9bbd822 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -4,6 +4,7 @@
>  #include "commit.h"
>  #include "grep.h"
>  #include "notes.h"
> +#include "object-name.h"
>  #include "oidset.h"
>  #include "pretty.h"
>  #include "diff.h"

OK.  Other symbols REV_INFO_INIT needs are REV_SORT_IN_GRAPH_ORDER
(in <commit.h>), CMIT_FMT_DEFAULT (in <pretty.h>), and STRVEC_INIT
(in <strvec.h>), and all three are already included there.

Makes sense.
