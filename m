Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C08204928
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905873; cv=none; b=YDFmZEibBzvcJg+58bUN7xWYb1MuQlOEl3wdCO5bSQW+dptKoPGY5UKMCNf4PKR1D0LrSx6kj5ux5OVH+ZlWObmf9t/2ZFke0wXBFksIhfICN4wo8BJxrWPhXrPgJLizsFVAFbwL2PqVyfGg8OWCblL07eZZd4JqWJlM2NrqW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905873; c=relaxed/simple;
	bh=SJYlt+4xt3BzDDdAV3A5KglihrLpf/+WzidA5FFxVuo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxquQuLgZPE1DsY7qk0Xf+wM7byzkPbIm9NFx953ipYBsBpzdaiBsba3/nm5kOJRPI0xSRwB04jk7ksntNAz8Me6Q8E1yscUi5l3BdAVINXq6Rgz9eEF5R8AzN5F5fh2xd868v9h3owXf3FMtOlsk7qQy/K7tCafFgaJmbxsGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cmkzL2px; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WiIYprOt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cmkzL2px";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WiIYprOt"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2ED4D1140165
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 06 Nov 2024 10:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905871; x=1730992271; bh=FpF8iGdw2S
	2P+naq7KCb/fl+X8TaD7+amHaH2SgACCI=; b=cmkzL2pxF3L397EJwZShzMgNZs
	DqtxLrvjVQ3qny7QOrXzYSzWOemXZFixc0hXCdmF9jMhVamhc9fjhXruI6MGykf2
	HEVSF8I7fZVFftSdqshirXNhlxFR8bbo+hEoWRwMOXvjWK1qjlFMAgu0Pg7vGZ4c
	c6V+4inA2up1zDUjm1k6GeHyxpaaefLD+wGnctPrxY5fCx5i0yPDGp0WEsyn10Mz
	TaeUcUpE5FqITjXmBX6wXKpfNNwxVeEnmJqCsTjh9CEIQlLsOogZOas2z5xpaP5m
	Rfqe4QMW1xbnMrAtyZ2lzkvPpjSMpVUecDCCvbyWVWgiQlMSBPKJLxQI6Wqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905871; x=1730992271; bh=FpF8iGdw2S2P+naq7KCb/fl+X8TaD7+amHa
	H2SgACCI=; b=WiIYprOtqmhy2Uq5fk7TyJseN+aQCA0CsmVIa5G7qvVceWnR9ex
	UGsbq28IIy+dbN1eL4+pIj1q+kk3WfArJMtZsxjRY0MKWzu6w/cIK/wu/jWryPVZ
	4+arumiWvluU7z5twImaplUoNKIaoT/h6L2LTOE/ENG/5n98wWD3oxdlIX/bqVBc
	E5YTh26cUcorzbF+Vn169DRKrRThEK/QJBIPAoshEmVXI7MjJluxfN2JqN6Y7hWh
	F8lRu26ko2TM2F3QStir9iSZ8EnIQCZ+1ZXEz7KtIRkZmoReBrvsT9tcR2F8y6qA
	dsXQlu7kpwywTKYtx8iYDE/Rh136sTgHNtg==
X-ME-Sender: <xms:D4crZ9AsBkuYUAycT32hzpKLqlO7T9nQI8JZ-dUgAF7WZ8bPfDJfvw>
    <xme:D4crZ7gQmnWfbSO_yUZ0axAUwzkT5zDkS0m7Td7FnOKdN57_WLA1ys_MSu8ssBlvT
    iNnfFvzuR0Fub4k1A>
X-ME-Received: <xmr:D4crZ4nGnm7c9Tu4-kabxpr9o7c9sVmLHnFLkhNoV2epCy_bnuTQ1ci2MNEeH6H1eEWazrgDVkNBbYgKNT6WkbU80XYGbRCdN6NpURw_XxI0lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D4crZ3wKKdn8z54flfTAMT5viAHxx-RIkexAhqy0RwjIk8EoLupqMg>
    <xmx:D4crZySjeMTW5ffrz4mRJsuXP_by5832wda_PIjmSzU3aeiFw7A4jQ>
    <xmx:D4crZ6ZqBijzyjAYBU-nNmBfMLPokfnbYI9vjYr8Ceg0I_K_sFQBYw>
    <xmx:D4crZzQeMobrpvw5PoxumzTbvH-fvja6pEvOVXI0kOSssm7ckYSJWQ>
    <xmx:D4crZ1JpEB8T57SKP0zYHytfCx4_P5iwlD_h0hCI_45LdhCFIkthAJDL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8330bbe9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:46 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/26] help: fix leaking `struct cmdnames`
Message-ID: <2fb012662d6c5720be1fe86973640c7a2d6f5681.1730901926.git.ps@pks.im>
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

We're populating multiple `struct cmdnames`, but don't ever free them.
Create a common exit path where we do so.

Note that this also requires us to use `FREE_AND_NULL()` when freeing
`cmdnames::names`, as we may otherwise try to free it multiple times.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/help.c b/help.c
index 8794f81db9b..51adc530d7a 100644
--- a/help.c
+++ b/help.c
@@ -169,7 +169,7 @@ void cmdnames_release(struct cmdnames *cmds)
 	int i;
 	for (i = 0; i < cmds->cnt; ++i)
 		free(cmds->names[i]);
-	free(cmds->names);
+	FREE_AND_NULL(cmds->names);
 	cmds->cnt = 0;
 	cmds->alloc = 0;
 }
@@ -619,6 +619,7 @@ const char *help_unknown_cmd(const char *cmd)
 	struct cmdnames main_cmds = { 0 };
 	struct cmdnames other_cmds = { 0 };
 	struct cmdname_help *common_cmds;
+	const char *assumed = NULL;
 
 	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
 
@@ -630,7 +631,7 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
-		exit(1);
+		goto out;
 	}
 
 	load_command_list("git-", &main_cmds, &other_cmds);
@@ -695,7 +696,7 @@ const char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
-		const char *assumed = main_cmds.names[0]->name;
+		assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		cmdnames_release(&main_cmds);
 		fprintf_ln(stderr,
@@ -714,8 +715,10 @@ const char *help_unknown_cmd(const char *cmd)
 			answer = git_prompt(msg.buf, PROMPT_ECHO);
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||
-			      starts_with(answer, "Y")))
-				exit(1);
+			      starts_with(answer, "Y"))) {
+				assumed = NULL;
+				goto out;
+			}
 		} else {
 			fprintf_ln(stderr,
 				   _("Continuing in %0.1f seconds, "
@@ -723,7 +726,8 @@ const char *help_unknown_cmd(const char *cmd)
 				   (float)cfg.autocorrect/10.0, assumed);
 			sleep_millisec(cfg.autocorrect * 100);
 		}
-		return assumed;
+
+		goto out;
 	}
 
 	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
@@ -738,7 +742,13 @@ const char *help_unknown_cmd(const char *cmd)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 
-	exit(1);
+out:
+	cmdnames_release(&cfg.aliases);
+	cmdnames_release(&main_cmds);
+	cmdnames_release(&other_cmds);
+	if (!assumed)
+		exit(1);
+	return assumed;
 }
 
 void get_version_info(struct strbuf *buf, int show_build_options)
-- 
2.47.0.229.g8f8d6eee53.dirty

