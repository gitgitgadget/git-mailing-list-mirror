Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CDB1DB362
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149516; cv=none; b=oR0G9jBDUBmA7rqoRedmnzAUbfycr7s3AK3bVNEtX3DtF0k3bK525e0KXSb9QpKNqEDeoHXxisqIUh/hvh4ZLGMNgANt2t3Nh34ps04SDyap3F8Mr0cAjC7o39W0l7sLZIFhDai5Cms3esEx9SrxiQfQ2NgjRsfuCK5Osxyrq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149516; c=relaxed/simple;
	bh=9uulPGrHHdtkCYu2fZxrPHrpN9b11UJTWlRAvTOSy6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2tA4ZyU3goFNnqzFnNKc+GUqbX1P7Mbm+CzhShyanBMMyytuN3mepBpHhoKe7bfR0lodsLKCh0GcOkEEvuyppk7qK7dyTYVg206BT2IRuTFG4s8+QpkD+4erfbcQj12cAHwdOORlt2U3IbZGJyikVI5AI/g5ss6A/347bDeESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v06Ih7vR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QF1h6La9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v06Ih7vR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QF1h6La9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33B7011400DC;
	Fri, 17 Jan 2025 16:31:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jan 2025 16:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737149513; x=
	1737235913; bh=LnBE1ZWpZ236dUuCQuTgvAE/zV59EjrGeOkzAU5+1sw=; b=v
	06Ih7vR6C6a1owAL0CV45kydMlcER+CLaN/3nvYtOP0xDA9h5atC9rywCWAryhaY
	gnAW15sd3SRxfLZKb9JJMhk2+v0+T5DHawfbz3VI4mI3eo+CT5at9Le6l+umkBlp
	ILVm2TNEiUr6oFe3J5QAiO3La+UpZOAh8CJQeXd2PDXNcxidQtV1oFXkrLGimKPV
	3FohaPtNve/OxG4DWb8OMhM23Y14FvyUMe5fZdpzoU0K+fYd47oOP/v7vOymsylV
	84cKgVY05SclY3RMRD8FQbTO+mYLkcNKs14khd6ES45kVaRsIAMhoLzIiHhK1ztR
	BUO1dsSbiz2HOco1ZWJZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737149513; x=1737235913; bh=L
	nBE1ZWpZ236dUuCQuTgvAE/zV59EjrGeOkzAU5+1sw=; b=QF1h6La9ebknkoAEg
	srgqJ5Kh6UnHcMSMqxY9fAJLkScieuIeMzyY2gBSJfKBZ8TZbwSlZGFY+iMMnIK5
	3BsdpZ28FxzIrNc5upgiTmx/AVaIF9MGES36YoOwInve39xe8xIq2XUjP2GwzSZq
	SsPT2Q7pFvaml0ioXpU175jbCUTQ7/ig2L9N3Css0kQty9UxnSsHkBIMJNDk18r2
	nES8SxBVstAgBvBRxDavVQVqnCLqmBBIorgHoFG6arGC0HXrf41iswsHjbHunblr
	gmSCIJxQBPfKbZNqnrEJg41S8JhJgZzCnykRVrZ+uxoAj1liD4OtvyMBDlFuKqcS
	d7YFA==
X-ME-Sender: <xms:ScyKZyJUm9yU6ktK0Pn_JFLOY3NFbet1vx5WRMMW_WrOxp_UJMyfWg>
    <xme:ScyKZ6J6B8_vUfUJ2x-hdKxZvxrl9Nr3XbGXu-sW-LBC5UfW3O7CpKlrBKL5LYLLy
    Yf-7gv23D76eqvUug>
X-ME-Received: <xmr:ScyKZysbFV-l5pf5OkQZOdU3w4A6tydy95JtqwDfFP-0BwONQ0GWbGI4EMXtRgmPFj96OPFpuxBMi5Obg6FnJRWLYfvfRUdfrmlK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvd
    fflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddvudeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:ScyKZ3af7Awd9IqWBP8pkmqx1DiK6ix3o-c3AnINYXBezHPoV81DJg>
    <xmx:ScyKZ5atD6m-unzodqrcagPBR9OBQsq1bvAcqR83spAsyUXXYtkCbQ>
    <xmx:ScyKZzBJ0KxeFQEX4URkEBgLQEo5pSh4kswyunKlMroSm3mWEBZrPQ>
    <xmx:ScyKZ_baTUFvl6EYjl-hPgth7HEtAhTeFaMped8J8he_pjMo5nLpTw>
    <xmx:ScyKZ9Gk5u054fAu7Hr_wa8n1hqa4h5U0LlZZqAhWs1P1ju3DqNFsmzl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 16:31:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v5 2/6] parse-options: add show_usage_with_options_if_asked()
Date: Fri, 17 Jan 2025 13:31:44 -0800
Message-ID: <20250117213148.3974552-3-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-218-gc7e8be6a8f
In-Reply-To: <20250117213148.3974552-1-gitster@pobox.com>
References: <20250116213553.2563751-1-gitster@pobox.com>
 <20250117213148.3974552-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many commands call usage_with_options() when they are asked to give
the help message, but it sends the help text to the standard error
stream.  When the user asked for it with "git cmd -h", the help
message is the primary output from the command, hence we should send
it to the standard output stream, instead.

Introduce a helper function that captures the common pattern

	if (argc == 2 && !strcmp(argv[1], "-h"))
		usage_with_options(usage, options);

and replaces it with

	show_usage_with_options_if_asked(argc, argv, usage, options);

to help correct code paths.

Note that this helper function still exits with status 129, and
t0012 insists on it.  After converting all the mistaken callers of
usage_with_options() to call this new helper, we may want to address
it---the end user is asking us to give the help text, and we are
doing exactly as asked, so there is no reason to exit with non-zero
status.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 10 ++++++++++
 parse-options.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 33bfba0ed4..4051a8e1d1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1282,6 +1282,16 @@ void NORETURN usage_with_options(const char * const *usagestr,
 	exit(129);
 }
 
+void show_usage_with_options_if_asked(int ac, const char **av,
+				      const char * const *usagestr,
+				      const struct option *opts)
+{
+	if (ac == 2 && !strcmp(av[1], "-h")) {
+		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+		exit(129);
+	}
+}
+
 void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
diff --git a/parse-options.h b/parse-options.h
index d01361ca97..39f0886254 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -402,6 +402,10 @@ int parse_options(int argc, const char **argv, const char *prefix,
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
+void show_usage_with_options_if_asked(int ac, const char **av,
+				      const char * const *usage,
+				      const struct option *options);
+
 NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
-- 
2.48.1-218-gc7e8be6a8f

