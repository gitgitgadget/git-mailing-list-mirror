Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F933F8C3
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186570; cv=none; b=kEN13TOUGwpY0GTdGx/TfurPIh9O1WKsi1DjsAIo00mXrsZGmAqE26l2Y89OR4qzxWtSvSJm6pLOUQsEJgogzzW+1CT8sMwP8Fse3tPO7gecBwduRn3OBdu01RIupsFa1up4lVKUVxffdxcZJnPu0q5BOEYmnlc7zI3eMFyiNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186570; c=relaxed/simple;
	bh=9bD2NvuHirfifQKIN2Hhi+4Uv4lFhnpea+Ng9acmiEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PaV+E8pPKrJB6A3igq9BhTq+B4FJsVhtEbZ6dK3He3/FYVv2+GCYpSfYFXtAZ8rGKQbRqa+ysqdScgJiDez4DMj2nJPWMMOL7chPY9McAe9JkE+b4trv6l+oZUCLjndG+PZ24PyUnNNxvfLnErCRpsRgImuVO86WFfvMxRIv9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=msr53UP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVZrQMS2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="msr53UP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVZrQMS2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DE3841D00178;
	Wed, 26 Nov 2025 14:49:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 26 Nov 2025 14:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764186564; x=1764272964; bh=lFKK07AsUF
	X3NtkV/kxTFzolP18/jtw8zIBSZ/0hAag=; b=msr53UP24Q6JANk0YfMKW41jcn
	/CclGpPPldoktUe7W5HlCh3xg4TQnkFyQfDTVHqR6Unhw3BF1gGTiRFC3Ies/9Eg
	clJ7lGLIeZTK+oL4Q/8JmUfFZzzfaLfaNXOvZ3cGB/p5ZyfYEnZWc8APn6rCOGKf
	6DsTeB53JSaFN1qp+81KB1J+PuSOX3F8eF11a3//cyt7P1w3ZwJLUwY3Ql02kUZK
	bd8gBmT33dYUwSGoKVwJC5+WWpA3vwJFgOgt4kJ13CLmlECZ1Giwf99LGw42qzBA
	RwUD3CuFuUWRz2llXiScoNTLvXKgA8Jdzj0yzvT5njc0pJuenCtlNA14MqlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764186564; x=1764272964; bh=lFKK07AsUFX3NtkV/kxTFzolP18/jtw8zIB
	SZ/0hAag=; b=iVZrQMS2wXVZrtJJxE2j9qdzBhjFBTIiWG5tDIi9rVMGg7R/zp/
	Vn9J2wJNw1TBQz2CfbBUStMHwegnDG15TsjX2sXyBHWOXIiwe/pLOBItJ1ijQPW3
	6o/mCDBQCEqv/2D+bF924n+cUTfSUHrgzQqEdO73jxoFZZzhh1Th908Vo0CnI2Qp
	XP36KwY2xWSh9KSsLXf8VthjUZDGzt+CXi5dmh3XRd+acE5w2iidtOGRG0fy2Ln0
	m0dIDeryqH/XVYoifnap0zcG1NJZyzwEU7/r8nXrQRX56QnFxMRkObg6x2O6pmXd
	xm6hfQMFEn8tANK3gZrHl9EMSaQPBHuL9ZQ==
X-ME-Sender: <xms:xFknaTrPwkFQUW83EIgyfI1l7hkWjbvO0s4XHsMbgZXSu8s3NVHV7g>
    <xme:xFknaVFPag3fjyWPKSUCK7MOB7nQ8-FKGQRNv1wp0pb8N78o0s4sCTj5TKDfh0K_m
    jhM556nNIdDHOppBd_4SwSKHEFkEt1B9Iitt1nOdUYnsC6k-rk2eQ>
X-ME-Received: <xmr:xFknadmTsMogD2owXzUd8ZfaKNsP_1VEqP1N8iqvIG7n7jsz-OCNBeTwnDWkXR8duAwvZ5eQOmD29rwllgvC-IYMozZ9-4CwfSiy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xFknaQlt2lQG6JKvw-4jLIaED4vDiKhe35nc8TdhKwLoRBfKIwqyFw>
    <xmx:xFknaWv-oxuuBHad2QXNOFbpCPuSbiBto0H4hlGiGwWLwj8OwxBs8Q>
    <xmx:xFknabn2nHoytYYf80IFPalkKUojL2A_F_RYvb1u0nFrGoNsZJbCcQ>
    <xmx:xFknaZtM3og8b4zH0kZREo7lU_-79Mz7MwezC9ApVpePaL_cWgFrUw>
    <xmx:xFknadu4XkVbbCrDmGX0yyAhwk-NnBW-WaNyI9_wWLYqhbqLznrFoRpO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 14:49:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] last-modified: document option --max-depth
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-2-608350df0caa@iotcl.com>
	(Toon Claes's message of "Wed, 26 Nov 2025 07:09:44 +0100")
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
	<20251126-toon-last-modified-zzzz-v1-2-608350df0caa@iotcl.com>
Date: Wed, 26 Nov 2025 11:49:22 -0800
Message-ID: <xmqqldjsmv5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Option --max-depth is supported by git-last-modified(1), because it was
> added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
> max-depth parameter, 2025-08-07).
>
> This option is useful for everyday use of the git-last-modified(1)
> command, so document it's existence in the man page and `-h` output.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-last-modified.adoc |  9 ++++++++-
>  builtin/last-modified.c              | 12 +++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)

Does this step pass t0450?

    fixup! last-modified: document option --max-depth

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index ccb7ff66d4..857554e70d 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -523,8 +523,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 	struct last_modified lm = LAST_MODIFIED_INIT;
 
 	const char * const last_modified_usage[] = {
-		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z] "
-		   "[<revision-range>] [[--] <path>...]"),
+		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]\n"
+		   "    [<revision-range>] [[--] <path>...]"),
 		NULL
 	};
 
