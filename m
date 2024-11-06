Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D5202F6A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905881; cv=none; b=eosuQRfDCe7jYPswVRQjvKEpntLUZTm/VmW7lUnWlM7HRUQcq5XojazLnXdAFITWHQQukJZm2FbDeXf/sxRA1/x1Ew6Tsy1/DJy8scaUmsIEgDezFDRTMaSt/t87WCl0Ih5Ar49x+8PL3AftAr2VfMYMDZyftS9I4N7YY5iVeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905881; c=relaxed/simple;
	bh=4IRJO0eEdpq1z5NV2a0T8ecAT30GK6n3z4fz/Yhkfbc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4wEi5y/CArcyFwFTdNDUH31WjxRLJPUgsyYlvQlFf0hpnRhVbfV6ssnmzv1fVcf1vG9NSFGpLAu41doqIuboCgaRChI69wd80TnglUgaQeJXP3tv7ovNBN72e5DuRf9n0uJQzSUsMdvav/X0Y0GmpLn8C6qtn3C/5XZbNkHJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0c8IU5IB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UauRFhD/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0c8IU5IB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UauRFhD/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E2B061380687
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 06 Nov 2024 10:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905876; x=1730992276; bh=AEhmSuPG8W
	AzNW2+lsz3oeQ+L8gJ56waokRIn2HR0+8=; b=0c8IU5IBTyzBFqJflNJJ/DYaDc
	N0hiJPrU50KzPvRzhFQ7eRXxFGU7P2+dMDefDkOHw4ZdWUMwM4gfmlbSUyEfiGlS
	gSXpNzeQSRtKZISXfsaRDRb0/p/eu5JMQdqhX3ZSZOlMrlmeKdb8IBRRVXlagb78
	Kt082diDcbpE1yN3CrPryxDyBl2DDEDopuAiPIm64skU0DPQ4d56VBAXS4Da05Fj
	k4mWMvv21KEOyFZDdTShCGigl4zZZpeVBT11TkI268LU3VTgFTmzJGC++XiOOmIF
	mgZBvDMyL4j2U8LSI+qjWHA08a6iCdkkQuEST0Vbbe7JhfbHxPpgR+CxvRuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905876; x=1730992276; bh=AEhmSuPG8WAzNW2+lsz3oeQ+L8gJ56waokR
	In2HR0+8=; b=UauRFhD/MmdJme2PCPpIHH2myDm51wjQXV4YmmuIE2gLvZrrJ/e
	TUt2dbb6jT24z2GsUX5OeHXLNR7zX8ZKDvs9T5yY8dfszDjsE+EsKzkfS3DnyCng
	QfAzhXCDnz8++dkvBKS3G+5d+PhEZRtcfOSXZTk5D7NS/R7aqLmfBKNw4Nfb9LDS
	m5fOn8eMRyI3aGxFVgIX5q6bGFNSyez3W8779VxE+2NzJVxBRIoKc7qIH0kZDAIE
	pWTARVFATfpcU/opTvX07dJDGF/nFpXnhTMl13HPbj1pEWyophATmAj6cIwyWyYt
	tOq7kjIAT2rC4AurJXl1bJKymVQBqUrLKVg==
X-ME-Sender: <xms:FIcrZ_OZohTp34krqy9bG_VHmtcmAeY8PbIRB9j23QWeadFnDTN1yA>
    <xme:FIcrZ5_6hc0UqLVuG1b03MeczQwrIUREJ3gEkdEl7EtlMN6YcUi0n2OV7K1vZG1Le
    4AyTTPPfRQt7OnQpA>
X-ME-Received: <xmr:FIcrZ-TnKsXHY1-lqPnQ9xWSV_U7f-jJCbk1x00I7sALvF6RiVWoQqhh1u33RLFz_2QbNNRevnchFlo9As-zkkwhqgJBVHSHiPdGzWl0TyNhgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FIcrZzsAr0IttJ4cEERd1wHlvpefeskPCGGDUu2UgZ0CXLqcfXNF7w>
    <xmx:FIcrZ3ffXzuroZq4TNcuPMNwghWjMYvOhOUS4UjQ8-iqDiHfIU32Ww>
    <xmx:FIcrZ_2rMR86e41uPQCcmiBxA8qzDO14vhU65yrMtRyozN05xHJP_Q>
    <xmx:FIcrZz8ahU74ibFbK76RNKvrwK3pqTVFyn-J_XsQUsmqJXzpcPmVxg>
    <xmx:FIcrZ_G3kRJpcSdb7_LMD-W4fNlbGpfseIJWXAi0sZVKSSrfEftCnglp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 683fa0eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:52 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/26] builtin/help: fix leaks in `check_git_cmd()`
Message-ID: <b1a7761d9b00545560c03c7aafe6d4db64c7ef60.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

The `check_git_cmd()` function is declared to return a string constant.
And while it sometimes does return a constant, it may also return an
allocated string in two cases:

  - When handling aliases. This case is already marked with `UNLEAK()`
    to work around the leak.

  - When handling unknown commands in case "help.autocorrect" is
    enabled. This one is not marked with `UNLEAK()`.

The function only has a single caller, so let's fix its return type to
be non-constant, consistently return an allocated string and free it at
its callsite to plug the leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/help.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 4a5a0790704..6a72d991a84 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -551,12 +551,12 @@ static void show_html_page(const char *page)
 	open_html(page_path.buf);
 }
 
-static const char *check_git_cmd(const char* cmd)
+static char *check_git_cmd(const char *cmd)
 {
 	char *alias;
 
 	if (is_git_command(cmd))
-		return cmd;
+		return xstrdup(cmd);
 
 	alias = alias_lookup(cmd);
 	if (alias) {
@@ -589,14 +589,13 @@ static const char *check_git_cmd(const char* cmd)
 			die(_("bad alias.%s string: %s"), cmd,
 			    split_cmdline_strerror(count));
 		free(argv);
-		UNLEAK(alias);
 		return alias;
 	}
 
 	if (exclude_guides)
 		return help_unknown_cmd(cmd);
 
-	return cmd;
+	return xstrdup(cmd);
 }
 
 static void no_help_format(const char *opt_mode, enum help_format fmt)
@@ -642,6 +641,7 @@ int cmd_help(int argc,
 {
 	int nongit;
 	enum help_format parsed_help_format;
+	char *command = NULL;
 	const char *page;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
@@ -713,9 +713,9 @@ int cmd_help(int argc,
 	if (help_format == HELP_FORMAT_NONE)
 		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
 
-	argv[0] = check_git_cmd(argv[0]);
+	command = check_git_cmd(argv[0]);
 
-	page = cmd_to_page(argv[0]);
+	page = cmd_to_page(command);
 	switch (help_format) {
 	case HELP_FORMAT_NONE:
 	case HELP_FORMAT_MAN:
@@ -729,5 +729,6 @@ int cmd_help(int argc,
 		break;
 	}
 
+	free(command);
 	return 0;
 }
-- 
2.47.0.229.g8f8d6eee53.dirty

