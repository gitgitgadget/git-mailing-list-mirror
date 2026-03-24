Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285023B637A
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333591; cv=none; b=T0oWaWlEfY8+MKug2eLFZm7PIX0632DoIH8+akdzROVIOQNQ3NQxASqFghssMyPeH4Blktrw42ocOdnF5FE5BPvp7VsqH7j0av+N5mRirkRfFziYft7jrvFmBYnAWYwY/6cITSfK0xKLcCESc+ymHqlzIHd/3ZAqgbiPJvMHjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333591; c=relaxed/simple;
	bh=de154EXlvEk+TODcVjbdidhnD2fdSqua1oDF+i9Bf5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzoaXgWvKsQzLgDft8A3GoVjA9LCiuhvrgKWEwwd8inVCJOcAA3XUgM0OgaRmKal++Jy8kNMuhLMxkx8d1kQ3s9LHygpKjTp2skAgYTX68jD7FQYHNqY7lzvJpJMEsZ3W/u8boDyQI0PBfjEY7Zo5a+7742HvUb6m3+dHBhyxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AqIvzAmK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cWPfQKoU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AqIvzAmK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWPfQKoU"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 70898EC01F4;
	Tue, 24 Mar 2026 02:26:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 24 Mar 2026 02:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774333589; x=1774419989; bh=XlJDrhyxyT
	fWANMrPQFWbZQ3LfSKX8fF9K1pHCQHVBg=; b=AqIvzAmKXrNass7V0x5m0iVN6Q
	mz5uUr4ABlJ37LxVQOoEG1yLRyIq9+j9X+VvpxMwFUqvFGUL9jdEJzvVXt88F6ej
	Gu5FUaEpg74CVtvZW9Cq+x5AnOpr3e8Udnnof0SLSfznTmCIlzRmcI90C5uwD1gx
	5W0A3ZuDWmpDqqhg+UzKil1QYmwda7kKJ41FAFfISQJ4ODKb7VFsXUxRie6ffu94
	BGuPyIP5sbAoFhwavflci1UYBgy4k7elJrw4Rxxl1uKhfPb1l1DmfA5gGjFLPbqp
	HBbVsfMir/u4AGiOlNnrptBG8H8G7GHveBEoUeD8cjsFLyqyfboOlknG1EXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774333589; x=1774419989; bh=XlJDrhyxyTfWANMrPQFWbZQ3LfSKX8fF9K1
	pHCQHVBg=; b=cWPfQKoU3DP3csBq2FbjznbRvzR/dXZJZW+/GKuWtJERFg+KxOV
	qDpM5ZxSuWCL38otvwAMXWOWMRVN7eoZBfvuxTLPWjr8ijFAV2ObRsh/p16fabqC
	266sQUfFFPGOyGKd8G8v+tHhs16k08tcIpKLf7VRU26TGi6yamCg/GFgsotn2sHH
	aqCGr6Ue30mDqCtP+csgx9KXVD368VMycy/xYjir90hXUT3eulv8BGHx3RITEC9t
	TzFimS/ziyUwbAz9mR6cACAy0eMjvZ8GgzoBYUk7Iivf/GI4IcYHUYXA85pa+rfH
	UUNBr0Rl9LpLxaWvGNO3doNvbM50cH2YR3g==
X-ME-Sender: <xms:lS7Cac53R0WblctaDd-NVP9Itkgl47ZaLLhsiBY2ID48RMbeOrRxPA>
    <xme:lS7CaUz9JeZ7ZIS3Ior5lp0maJt-Zyt8PrH7aBHSNCOYkNGnBwfMo_smvz4ID9QRA
    r25zn1DhibSkbtKygc4d5S8l-7ACWBCPaYGsdod0Wx0c0baUrczTQ>
X-ME-Received: <xmr:lS7CaTy04Sw3018vamVTkm9L3Aj7tcotwdlXr4S_FN7Wd5A27m6wsCdzOddv4ytR5sGyJZ1XZMrXdVB7Y7coq_Z6IuQ_yj0zPK3oh4k8k6iuiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrhhhlvghtrdhtrghkrghsshgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lS7CaczP-JgMUDmuA8fRrPKwCU1duJKTGKKW3llhGry_u-4oNX6KnQ>
    <xmx:lS7CadZ-x1k5WCgOwGdszdLJJMzIZYZGT5M0_84B3I0ZqS-cze76eg>
    <xmx:lS7CadWeKfsAldm81EkcXg-CSsUGWyUcmg9h4TaF9qxyvqHcCEheXQ>
    <xmx:lS7CabhGAc5Boy3Wf1_UBXwGNaV-dvDNLKf_ZfQrarE6zpo4RGagbA>
    <xmx:lS7CaQBpAC6ahQ2RBb3tWA2WxcVfa5qnmjZhWzWxLkKUW3UEKjYtyE5y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 02:26:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6cd5051 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 06:26:26 +0000 (UTC)
Date: Tue, 24 Mar 2026 07:26:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mahi Kassa <mahlet.takassa@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, lucasseikioshiro@gmail.com,
	jltobler@gmail.com
Subject: Re: [PATCH] repo: show subcommand-specific help text
Message-ID: <acIujxB3kod2VYfB@pks.im>
References: <20260323152937.257406-1-mahlet.takassa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323152937.257406-1-mahlet.takassa@gmail.com>

On Mon, Mar 23, 2026 at 04:29:37PM +0100, Mahi Kassa wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 55f9b9095c..5ccc5c401a 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -27,6 +27,17 @@ static const char *const repo_usage[] = {
>  	NULL
>  };
>  
> +static const char *const repo_info_usage[] = {
> +	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
> +	"git repo info --keys [--format=(lines|nul) | -z]",
> +	NULL
> +};
> +
> +static const char *const repo_structure_usage[] = {
> +	"git repo structure [--format=(table|lines|nul) | -z]",
> +	NULL
> +};
> +
>  typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
>  
>  enum output_format {

These are basically the split-out parts of `repo_usage`, which makes
sense. But it also means that it will be quite easy for those two usages
to diverge over time. Would it make sense to maybe split the individual
usage strings into macros that we can reuse? Something like the below
(partial) patch.

Thanks!

Patrick

diff --git a/builtin/repo.c b/builtin/repo.c
index 55f9b9095c..200c5901a7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -20,11 +20,22 @@
 #include "tree-walk.h"
 #include "utf8.h"
 
+#define REPO_INFO_USAGE \
+	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]", \
+	"git repo info --keys [--format=(lines|nul) | -z]"
+
+#define REPO_STRUCTURE_USAGE \
+	"git repo structure [--format=(table|lines|nul) | -z]"
+
 static const char *const repo_usage[] = {
-	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
-	"git repo info --keys [--format=(lines|nul) | -z]",
-	"git repo structure [--format=(table|lines|nul) | -z]",
-	NULL
+	REPO_INFO_USAGE,
+	REPO_STRUCTURE_USAGE,
+	NULL,
+};
+
+static const char *const repo_info_usage[] = {
+	REPO_INFO_USAGE,
+	NULL,
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
@@ -214,7 +225,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
 
 	if (show_keys && (all_keys || argc))
 		die(_("--keys cannot be used with a <key> or --all"));
