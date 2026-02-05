Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2B2F6925
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324251; cv=none; b=q1+IFLkJ9Y+JJ4PC5eNf7UDgq5vPOqQwivi6R8FHo8U2gjjjU7gC27AO0lZ5973VOBIcLmNmYCg9oK481sr4tQFJbojTnWXKzfwvrwBy5/+LrtnW0g1tlHQF7aonXjW3F+kOyDjqsJb3kFrERVJj1b0mqWHLDTXKvqHuh0qtqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324251; c=relaxed/simple;
	bh=fN5DkYIdK260hM3NMX4ZInRbjH3ZM53oS5u7PYk56OE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVMnocgk7lIOdCzJdSUqM8JyY2/kLvDa7Yc6SU1q3riBjHS50U5+wnJlInraQCPpx8tEuOIYCSHa59AD8S763DZ7S2ZLEjCeB3QJHBGpYlC1NnC3ijqqL0RUoKZ0VoHKkXNCFcSOicJXVne72kEgnCQsNeXAduOjchQfLx62B7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FpJ6kBld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeCF7tYW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FpJ6kBld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeCF7tYW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFE831400173;
	Thu,  5 Feb 2026 15:44:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Feb 2026 15:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770324250; x=1770410650; bh=w02tSCoQrq
	rTyoZ+A01tFDlBrBWBf1KMS4uQykFPUjA=; b=FpJ6kBldrYCaZbL1Ep6uNFMM9x
	VdEGYmKsuJg1x1S6WDWOykmTRiqY2+4nyoGV33S8yDlExDVY7pc3Huo36gmQw/DV
	g4T2KQHXR6J7Ipo9s0u/wEjsN3zkbdQiOxBnTdFZX68oSELMdbOmN1X0qPL6m9jP
	AHa7w86UxF8PbuKU8U0wK/5f/4SLNZef6EX2imQJRuoL48v7YH7Wxd22qx0c/gHW
	3cyxTXbX1ERLwqZGwGfpZzYBK/PjueHD4IJvphpWOjNTPCfHA8I11PMYiKE3SkfX
	SDTArpC7vaKDYMwCt69dJl81hBNBsDmyTA52ikv1jHLd2v+4hclWQWY4giEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770324250; x=1770410650; bh=w02tSCoQrqrTyoZ+A01tFDlBrBWBf1KMS4u
	QykFPUjA=; b=HeCF7tYWsYfEFixDc1Y9Su9MsEz/PGuUvWwe91k0BCgYOTss4I5
	AUIPer29c3VRuDsXhpr5F0GbKF0B3hgAOsBHbVq+34YvBXBnBTzOZ3ktrr2lIhiW
	3QwyoPOehl+Hh9OTtI79H0Xc7gEeFziDVPXYDQ1/8EtTUtONxbzJZBM4mlFpCBI2
	m2kPCzzfKWq89+sRb9vcAK8ilt5PVewZAZbJhnxW+1ygIOTV2ctJxWl8+/wqvDiu
	y6TkWFbMg0fKtDVDmaeAVEOdhs0qPCXkAMYLoly3R2Y8Z77dd0NyoxfhQ0gAuoh7
	Wqi7nwXviVt6aWjp460yKXskf/J0elpsj8w==
X-ME-Sender: <xms:GgGFaUfFP-2my7AiqqTd6bmUulW13L3IqGkYtlbHGTjY2kDUg3V5oQ>
    <xme:GgGFadGvBdrtC8-eMe2jFVtBdS-SO5_3kN4H_tfOqoyUVpNdcOG9UYdHvmmKibfSB
    hrjpt99IziUoJHUw_y4DAQmtSHXh_yjD8R9gCFus1H2AQN5nVh0Bw>
X-ME-Received: <xmr:GgGFad00IOZesa8uf634ac7qfqOT4euIPKxzQsYyxq9ccQ7a3F-jYpcwdpeM5qmSFJBsUzKiDd-7P68ePFB2ZUEuom-V6Fnd-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeejleefjefgvdejvddutdfhgfetiedvudevhfdtjefhueetfeduudefieei
    ffefnecuffhomhgrihhnpehmvghrghgvqdhfihhlvgdrtgifnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epuggvvheshihtrghushgthhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmrghnuhgvlhdrlhgvrhgthhhnvghrsehquhgrnh
    httghordgtohhmpdhrtghpthhtohephigrnhhnihhkrdhtrghushgthhesqhhurghnthgt
    ohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GgGFaVk6ktJxIAjQRzF01RwYfx8HEPO9Kxv8GMD3ZzPIk18kOy_nEA>
    <xmx:GgGFad-K0DUaIwI0yFsQxWdbWTKQoRRZaRmTpk2l8wunOtjstfQSDw>
    <xmx:GgGFaarUH7IWROTHHMnEsR3JG1SoJouHRQDTGTGgBzx_62hNr9wQxA>
    <xmx:GgGFaWmQjz-AYod1QrB-Imk7lTMy6CaO8BS_U-E1Zp8HFNjq04cIhg>
    <xmx:GgGFaRj_ID5JfXzUi3sulc47dU5wcDoUeTqhXhgsHtyrJ_duPVXRfdp5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 15:44:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org,  Manuel Lerchner <manuel.lerchner@quantco.com>,
  Yannik Tausch <yannik.tausch@quantco.com>
Subject: Re: [PATCH] merge-file: honor merge.conflictStyle outside of a
 repository
In-Reply-To: <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de> (Yannik
	Tausch's message of "Thu, 5 Feb 2026 21:27:21 +0100")
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
	<xmqq4invm2dk.fsf@gitster.g>
	<3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
Date: Thu, 05 Feb 2026 12:44:08 -0800
Message-ID: <xmqq8qd6ly3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yannik Tausch <dev@ytausch.de> writes:

> -	if (startup_info->have_repository) {
> -		/* Read the configuration file */
> +	if (startup_info->have_repository)
>  		repo_config(the_repository, git_xmerge_config, NULL);
> -		if (0 <= git_xmerge_style)
> -			xmp.style = git_xmerge_style;
> -	}
> +	else
> +		read_very_early_config(git_xmerge_config, NULL);
> +
> +	if (0 <= git_xmerge_style)
> +		xmp.style = git_xmerge_style;

Wouldn't it suffice to unconditionally execute the body of the if
(startup_info->have_repository) block to pass "repo" we obtained
from the caller to repo_config() instead of the_repository?  The
caller of this function passes us either the_repository or NULL and
repo_config() does the very-early thing when passed NULL as the
repo, signalling that we are outside a repository.

IOW, something like

diff --git c/builtin/merge-file.c w/builtin/merge-file.c
index 46775d0c79..f9de636884 100644
--- c/builtin/merge-file.c
+++ w/builtin/merge-file.c
@@ -60,7 +60,7 @@ static int diff_algorithm_cb(const struct option *opt,
 int cmd_merge_file(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	const char *names[3] = { 0 };
 	mmfile_t mmfs[3] = { 0 };
@@ -95,12 +95,10 @@ int cmd_merge_file(int argc,
 	xmp.style = 0;
 	xmp.favor = 0;
 
-	if (startup_info->have_repository) {
-		/* Read the configuration file */
-		repo_config(the_repository, git_xmerge_config, NULL);
-		if (0 <= git_xmerge_style)
-			xmp.style = git_xmerge_style;
-	}
+	/* Read the configuration file */
+	repo_config(repo, git_xmerge_config, NULL);
+	if (0 <= git_xmerge_style)
+		xmp.style = git_xmerge_style;
 
 	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
 	if (argc != 3)
