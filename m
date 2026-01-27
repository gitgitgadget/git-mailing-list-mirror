Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95942366548
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542182; cv=none; b=D1/V3RGOrSXhZ9C+KLIRGogiZiw9b4im76D4Ft9O4zRIH4wR4A+eA0e9YhX2u3ZISQfWTuOXXiZzvWbG1jK5TmkSQjyOn9dyDEpdgMbRQ/OoDLetm+ENwi8cy29V+W09yVLKmYVQ9RUw5kF//pt+jqSSiZkWfKc/ly3aq17/m2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542182; c=relaxed/simple;
	bh=Di9nJ6j36v1+tWFvX/aa+0EkNXvXl26zL2KV43pHF5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2DRvYYR+JCeUmPMEhpA6YeycEJd/84faLnFuI6qoLbES7fO/MDkHFKQv4FxuHdgT58NDzrDQDFBR9Zcf95ZNqvQ3XOOFTsU9T0vunmOnTeW7zWRZojfUtq9WYJ3Hi4g9vK6oJtQQTv2H1G5uVDCWn8VkiKBGZBHIoI4D7l4EFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fbJA9MSv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/uug0gj; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fbJA9MSv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/uug0gj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D35F9EC00C4;
	Tue, 27 Jan 2026 14:29:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 27 Jan 2026 14:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1769542179; x=
	1769628579; bh=r8n5wQwBhPYqkDmgp9OACJWrwHIPjumCWfzyTJxbGG8=; b=f
	bJA9MSv/kwrB0ooXO2YdsVZ7ZDf/qAmcXFCKrDMMxswhVRr0JETIkGqEIRbygm66
	sTIilMw5WH/3eOJOJI5EtznPXpXnruvJsVk3lNiHi7+bGZmurAV5frcu05Yazddx
	3tr4n4A/QmQCXgnPiZT8D/mzSNM4u0i0ijhrkObAje29kRND98Jrtzd1Kuhg0gt+
	ZUEttfZuAOqrgUoESNv7kvbbo9p7GCuZ9Kb3kzXjA3GNCQZSBgZwkhdKGdba0bf1
	z4biiZGDmcPpVGEh869GTdNw8XZw+uzo+VvoEX0ven471DeGvtkXtQFAyGKqJy8R
	8BnOKK1H+8+h0CXZV1QAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1769542179; x=1769628579; bh=r
	8n5wQwBhPYqkDmgp9OACJWrwHIPjumCWfzyTJxbGG8=; b=s/uug0gjhPb4vSRyv
	jHOCsASeq0fNLHjIkq+sBGZWsYZzkmWwLq9jVCjkJq5w9OT1Br/siwH7PqL7HChg
	ntKj2274o/GFsbRoZeIQ73ZmL62vM0zzrANjJzClwa4Z8aCNFO3/MlvOXYVbnGjt
	tt6j7m+kbf0Xnjm4ZTVMv6KyM7iqCDDk8reTwJrYwF+k8kgU2VXCpOHA8XiNJCwf
	S3mvWIcCqAAO5oc0h5IGOCoUywlm2s3WajrIzloriF693Jb1zkEmFOyIWzKVHV18
	wRyeUxN40EzVfjjJO2y+jNO+4a7H48OOVG/jsNlp4BCGgJsqDiEuHwmUYyHuvQgm
	drvbg==
X-ME-Sender: <xms:IxJ5aTlRNPCEKwAnxjkcTevKKqAcUIiQMQReOmxaULSSmvu0O8OR6w>
    <xme:IxJ5aeTCnUe70F4CWltcak4fBAgI94bOlOgTExnkY8yAjf2ccDFr6surWiiKfKyHU
    8BP6eYDS4YDtXCflSXyKWSpymVblvjPxRDNa0PSyndBl-qqBpX-rmA>
X-ME-Received: <xmr:IxJ5aXDb8tG2yFqqH6pY0K4845Ve32kt_HLaBHCz0GnR2VQuyrZHsd1ZzUeB5cFqFidcnIElyYgMeN7IwlIYE4Cv-XZu40J30ZV_LrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedvffelhfeutefgkeettdfhudelff
    duteelfeeiueelhfdvudeiueekhfdtvddukeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgihqhhsihhmohhnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IxJ5aVSSmOkgaFXQw2uz5480CNBOVjdwOo3maSp-93rkyBVxFj5pwQ>
    <xmx:IxJ5aVpBP7EMf2LGMZKYmWrwij3vN_2n73U2jAKcwqemgfgFmpU6Eg>
    <xmx:IxJ5aXwwL6Lk3VYcT-zJTtI5wdwE_ryAHjAOd7T7U-NJ0ItdzJeSMA>
    <xmx:IxJ5aaIWyhtEEavcAgk0KavmVQKXlD2rpZYzgt8FV7pxIReIppqFbQ>
    <xmx:IxJ5aSRyIsbl--8IzOulQE1SQpLBHqsR63taCLEIAkalvd5xBTVsgxbV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 14:29:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Simon Cheng <cyqsimon@gmail.com>
Subject: [PATCH 1/2] checkout: pass program-readable token to unified "main"
Date: Tue, 27 Jan 2026 11:29:35 -0800
Message-ID: <20260127192936.904719-2-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-rc2-135-gb1217c0133
In-Reply-To: <20260127192936.904719-1-gitster@pobox.com>
References: <20260127192936.904719-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "git checkout", "git switch", and "git restore" commands share a
single implementation, checkout_main(), which switches error message
it gives using the usage string passed by each of these three
front-ends.

In order to be able to tweak behaviours of the commands based on
which one we are executing, invent an enum that denotes which one of
these three commands is currently executing, and pass that to
checkout_main() instead.  With this step, there is no externally
visible behaviour change, as this enum parameter is only used to
choose among the three usage strings.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 63 +++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe..4f189fde48 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -43,22 +43,6 @@
 #include "parallel-checkout.h"
 #include "add-interactive.h"
 
-static const char * const checkout_usage[] = {
-	N_("git checkout [<options>] <branch>"),
-	N_("git checkout [<options>] [<branch>] -- <file>..."),
-	NULL,
-};
-
-static const char * const switch_branch_usage[] = {
-	N_("git switch [<options>] [<branch>]"),
-	NULL,
-};
-
-static const char * const restore_usage[] = {
-	N_("git restore [<options>] [--source=<branch>] <file>..."),
-	NULL,
-};
-
 struct checkout_opts {
 	int patch_mode;
 	int patch_context;
@@ -1293,6 +1277,13 @@ static void setup_new_branch_info_and_source_tree(
 	}
 }
 
+
+enum checkout_command {
+	CHECKOUT_CHECKOUT = 1,
+	CHECKOUT_SWITCH = 2,
+	CHECKOUT_RESTORE = 3,
+};
+
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths)
@@ -1767,12 +1758,44 @@ static char cb_option = 'b';
 
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
-			 const char * const usagestr[])
+			 enum checkout_command which_command)
 {
 	int parseopt_flags = 0;
 	struct branch_info new_branch_info = { 0 };
 	int ret;
 
+	static const char * const checkout_usage[] = {
+		N_("git checkout [<options>] <branch>"),
+		N_("git checkout [<options>] [<branch>] -- <file>..."),
+		NULL,
+	};
+
+	static const char * const switch_branch_usage[] = {
+		N_("git switch [<options>] [<branch>]"),
+		NULL,
+	};
+
+	static const char * const restore_usage[] = {
+		N_("git restore [<options>] [--source=<branch>] <file>..."),
+		NULL,
+	};
+
+	const char * const *usagestr;
+
+	switch (which_command) {
+	case CHECKOUT_CHECKOUT:
+		usagestr = checkout_usage;
+		break;
+	case CHECKOUT_SWITCH:
+		usagestr = switch_branch_usage;
+		break;
+	case CHECKOUT_RESTORE:
+		usagestr = restore_usage;
+		break;
+	default:
+		BUG("No such checkout variant %d", which_command);
+	}
+
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
@@ -2032,7 +2055,7 @@ int cmd_checkout(int argc,
 	options = add_checkout_path_options(&opts, options);
 
 	return checkout_main(argc, argv, prefix, &opts, options,
-			     checkout_usage);
+			     CHECKOUT_CHECKOUT);
 }
 
 int cmd_switch(int argc,
@@ -2071,7 +2094,7 @@ int cmd_switch(int argc,
 	cb_option = 'c';
 
 	return checkout_main(argc, argv, prefix, &opts, options,
-			     switch_branch_usage);
+			     CHECKOUT_SWITCH);
 }
 
 int cmd_restore(int argc,
@@ -2107,5 +2130,5 @@ int cmd_restore(int argc,
 	options = add_checkout_path_options(&opts, options);
 
 	return checkout_main(argc, argv, prefix, &opts, options,
-			     restore_usage);
+			     CHECKOUT_RESTORE);
 }
-- 
2.53.0-rc2-135-gb1217c0133

