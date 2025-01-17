Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836751DDC02
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149517; cv=none; b=MyjmCG2GbSFxuwR3z7Jg1xaSSYzbvaZYur4QmxN43R7DJwvGSIQJldVQJoeNqKjzXJqxYEQWpB2Uy6ezCDlJ97XOe0tQ5MgqWEHf0Uyqc4hoiqG0PoiFlRRj7B0Qgwk2T+72YQ+dfDsD/zhWNPEc3DmWY0OBDb7TlyXyz19DmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149517; c=relaxed/simple;
	bh=ydnERI537sfl3Gc29Q+s3HB+/67xH10+UmdqNaWpGxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFpNrXtss3syaZsvk+D8iDZhOKSZBU9egUhcyJJgVh8CGrtEvIos6Bay26YugxasD+vLr08pEQ4SeCRNXq4RRDi2Yk4Ysq7kk9YPCbYn7p2voqcV86A72YqIMVT2x3btOFOFXuig6hd/b+gebsb5x0VCvca0Aor6BL+68DMQCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VtGsdUD2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLq+Orvj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VtGsdUD2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLq+Orvj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 99EC21380128;
	Fri, 17 Jan 2025 16:31:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jan 2025 16:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737149514; x=
	1737235914; bh=CB5M3NoCtHJJzl/NCWOJSxUzzqzTbSddWKxOZBAXLFE=; b=V
	tGsdUD2H7EvyUNZLgWw0GdccVXoTanuuaJbYBmqxAoE7SM4e6WwWMdEjbEu9BrSN
	Fhh9MbhshOUtv+r39d90gadQ0GMcbAtMeoLeeEzAEUlR/r1qrfXrHIQeWibykma9
	aMXNzEm6bLREEodkNAEgpMfKYqMZEgy77avmPjpnvzoHIWYtviD+DXG3DlCI4wph
	L1yNB8c+eEJx7T9lr00Fhn+WwdZ075aT3EddEQBkqrT9HiHIE5A7zF0w4Nkw/BEf
	CBoUGeO5qSpp+8DCnj/6r/DVtrKpu8rYqqwlUSjqWzlUTioF2iPFdD7NbWgYHAOd
	T/G2hisGgZpQBe3zE3Ukw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737149514; x=1737235914; bh=C
	B5M3NoCtHJJzl/NCWOJSxUzzqzTbSddWKxOZBAXLFE=; b=mLq+Orvj007Mi2lLA
	lubyiDwkFeeoLUneJXUc7xI11m5tY+61xooEvIx7FaNNVejGemOa0f6d9TFPJZdP
	STUnIftFSFxqjJBj+0yh689hdYu+JpdIgWliSMPGA4dOZs9qBH/Sl+tNfgCnGKxx
	12cDJXDxKik02LoBu4gUHmdaxw/wc/VNd3VsMCDhSLANmoE1DoWB09y5GINJb2bz
	ay77MGBuqV3yYtdRP2gmkVD1RpDyVRR2dNxr+ca60TLrsBdgIJezgY4FUFSY/Opi
	iuTVbnmue/67RQPG0VL8jKdrWRlydQ+bCdUORHixHWYkEv/HUZKePin+iQEBLJH7
	TO2Xw==
X-ME-Sender: <xms:SsyKZ_4cYQUDfJKQT9M-DWwAuIU0OBizDtEM4fgoitsrPjqphdCDcw>
    <xme:SsyKZ06og9Aoj8Ht-djrocJjS6VhGBlegWh3VZYbqX9IU8B9NC9Itb8OffN6cEzg8
    vbeIc1a0ZfNypXgYg>
X-ME-Received: <xmr:SsyKZ2cVjdSWPA-ZbPH-8fYXuE-vxqfTmNlFQj2ny1rg0vThMyApldxQ5pZN9NfWufACttSrIPPPx5iWOum2xHzmlW419KbPFetF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:SsyKZwITJJMOKbORViHdsccey92P_9tzLkzf01px-FdZzsAR-Gyirg>
    <xmx:SsyKZzKoi43h3XooEEF3vaPppQcF-zll74f1GJFFWPm2rWNb6MkBYQ>
    <xmx:SsyKZ5wlkqh3tSWQyLktOwPUZCQtEKErGUVDZ3qa9nf1cIaVQy4dGw>
    <xmx:SsyKZ_K8cXosYzKyEx-BBMPVSxjvQIFYpPzdjYDic-jXLfjlNOOl9w>
    <xmx:SsyKZ70iZ7nl84DVXs796lFe3wvre8_AKxXzwx0O-9KFbkBGSrSVhcu2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 16:31:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v5 3/6] usage: add show_usage_if_asked()
Date: Fri, 17 Jan 2025 13:31:45 -0800
Message-ID: <20250117213148.3974552-4-gitster@pobox.com>
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

Some commands call usage() when they are asked to give the help
message with "git cmd -h", but this has the same problem as we
fixed with callers of usage_with_options() for the same purpose.

Introduce a helper function that captures the common pattern

	if (argc == 2 && !strcmp(argv[1], "-h"))
		usage(usage);

and replaces it with

	show_usage_if_asked(argc, argv, usage);

to help correct these code paths.

Note that this helper function still exits with status 129, and
t0012 insists on it.  After converting all the mistaken callers of
usage_with_options() to call this new helper, we may want to address
it---the end user is asking us to give the help text, and we are
doing exactly as asked, so there is no reason to exit with non-zero
status.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |  2 ++
 usage.c           | 27 ++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..d43dd248c4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -701,6 +701,8 @@ int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+void show_usage_if_asked(int ac, const char **av, const char *err);
+
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
diff --git a/usage.c b/usage.c
index 47709006c1..38b46bbbfe 100644
--- a/usage.c
+++ b/usage.c
@@ -8,7 +8,7 @@
 #include "gettext.h"
 #include "trace2.h"
 
-static void vreportf(const char *prefix, const char *err, va_list params)
+static void vfreportf(FILE *f, const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	char *p, *pend = msg + sizeof(msg);
@@ -32,8 +32,13 @@ static void vreportf(const char *prefix, const char *err, va_list params)
 	}
 
 	*(p++) = '\n'; /* we no longer need a NUL */
-	fflush(stderr);
-	write_in_full(2, msg, p - msg);
+	fflush(f);
+	write_in_full(fileno(f), msg, p - msg);
+}
+
+static void vreportf(const char *prefix, const char *err, va_list params)
+{
+	vfreportf(stderr, prefix, err, params);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
@@ -173,6 +178,22 @@ void NORETURN usage(const char *err)
 	usagef("%s", err);
 }
 
+static void show_usage_if_asked_helper(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	vfreportf(stdout, _("usage: "), err, params);
+	va_end(params);
+	exit(129);
+}
+
+void show_usage_if_asked(int ac, const char **av, const char *err)
+{
+	if (ac == 2 && !strcmp(av[1], "-h"))
+		show_usage_if_asked_helper(err);
+}
+
 void NORETURN die(const char *err, ...)
 {
 	va_list params;
-- 
2.48.1-218-gc7e8be6a8f

