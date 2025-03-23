Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E613635E
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742767690; cv=none; b=cLQ5ZGV9xlEZBmACIJoA96AmnEzjO+YePORr/ztX0AtehU1VQD0sznGvtE9N5BxocrpnkWfh04iu0h8Y4bS69+b3kOFa4KmAIyl8uoq7NPhuGis3X9UovqhNZtLl3wwtHFHifZXxlo6QHddHcmOOrNDZLbbZsLiDfjT2Faq5SQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742767690; c=relaxed/simple;
	bh=8BrSBiT/Z6M+ER+nuGXUbkUs15DBAgX+drAdJwYmdTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EBAORPQyAxpV5sqWWZq7N0NKCIrmdeWfL6AoJuXT3oBqArIyNyQeMmZISGTZ1gRzloXQDHSIe4kX+IFWkb4ukwTRPO/oCEcbREVDE7r+1uMD7em3mVTwbM2vqwysycdDfBr7/1u/mRggJvWi1fQ8PNxn+rCvBe5fj/fBXGF4UA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qO66yG6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m57pJ8o+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qO66yG6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m57pJ8o+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 82F63114009E;
	Sun, 23 Mar 2025 18:08:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 23 Mar 2025 18:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742767687; x=1742854087; bh=Hdc0a3w1Nq
	6ukpK4ACeYMEmOkNhZziLo+vgcCLU3v4E=; b=qO66yG6k6ARuNr8lIb57ZEX4Qg
	7ew4lLndYmAKRRKt0SH8Db/nOQPqbfKYPYS07YWUFHMQKk4cmOPNjQKA1FScwxcb
	y43LnS8Ze+ffSitLM2fxgFKLLoCP7D1euiTu3/0gQ/U4RJ3ULMLuMf+WATH+dhq3
	a+YFRUI56i5LB5pPA6oux9vcpyQzz+SqTZGxqY202UqEEDAx/3KTJBZWptFsoc5R
	R1gZLXZxF3bIpEJs5jz5ZjosYfY1Kv20Dv6UglRsmbtwZ5FXZsh/13efMdBl7nP5
	MYy7rMDP//znkiuSfIT9qsuf1oyLy7bfZJjHKow3xkavyrh+6KNFiLahFgOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742767687; x=1742854087; bh=Hdc0a3w1Nq6ukpK4ACeYMEmOkNhZziLo+vg
	cCLU3v4E=; b=m57pJ8o+JoCQBRs6LYFszdvKc5QzQdRDV6SissVHD+G0q6Ageqg
	B09kFUj1VjZIuPyVVVTFUDR9q/CT8MsWURx8235LPxTKTYo0jgifjMWvfLmRlrJE
	eMrjeTu6NRsTdy1hkf8T0sDMdjVaAzQ61difzoJ3e2tPenIkZd0yxH9kaCdEyegd
	gNYneay5Fp3h2HlRH66KwR1/eewEIYlpg75lOaGRReeTQRJLXbtxMKefp8sdgbij
	BkmlGewv6cBkxLCOaSI/oP12+baa06eVqy/sz2PCCmFtZNuJraGL2AHVKYV2FxF0
	eYSFRKgMbC4M1Yfk1AWfuuThNpufaejFEcw==
X-ME-Sender: <xms:R4bgZ1ric5Va14JrARBbqKeCX1XbkapcRVhqVK8NktxaJdotTXTbng>
    <xme:R4bgZ3pYor6q_oiy-vB_ofs1JFJ3tEWQ7PXiIhMfUa_GaVS14XY4hVs-rMNU3hd3m
    2snHiw9o_WSGH2aJQ>
X-ME-Received: <xmr:R4bgZyOgdVrDtn5CrHYDTwQVaJqfSPf72N63oHj2V0EPozIBpdJREV6kpFDINHuw1KSTnvkwY02bLmivIb6LT5eF7jzfzwXj_ZTZeQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:R4bgZw4NHHEdIAURk0PmSPpV8yjNwC31MHc-wQx5iaNtPzNi_leecw>
    <xmx:R4bgZ07n18WpG2anVRfU1Khf2D2CqOPsrFs8X1sCVGxxGnqJNkClnA>
    <xmx:R4bgZ4gsjJe-jOmG6RN8J5BLEGU5Kacb_7wnjVhZYVhoi7Q3BuhREQ>
    <xmx:R4bgZ263ruZJPb5dgSqiiAen0bVmV82UlK_Bw_97KzjB-z7G4emhAg>
    <xmx:R4bgZ_2FSmrmjSOy_bi438f92Tv74AuVrfl5TPjtFbWZuArtFKM7nh2Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 18:08:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com
Subject: Re: [[GSOC][PATCH v3] 3/3] docs: replace git_config with repo_config
In-Reply-To: <20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 21 Mar 2025 20:00:22 +0530")
References: <xmqqa59evffd.fsf@gitster.g>
	<20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
	<20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 23 Mar 2025 15:08:06 -0700
Message-ID: <xmqqiknzqu2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Refactor config handling by replacing git_config(...)
> with repo_config(...) for better repository context
> awareness and alignment with modern Git practices.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 57 ++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 45efe117ab..3ae85016d4 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -316,26 +316,47 @@ on the command line, including the name of our command. (If `prefix` is empty
>  for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
>  helpful. So what other context can we get?
>  
> -Add a line to `#include "config.h"`. Then, add the following bits to the
> +Add `#include "config.h"` and `#include "repository.h"`. Then, add the following bits to the
>  function body:
>  
>  ----
> -	const char *cfg_name;
> +#include "builtin.h"
> +#include "gettext.h"
> +#include "config.h"
> +#include "repository.h"  // Required for repo_config_get_string_tmp()

I do not think we updated Coding Guidelines to allow // comments.

