Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E485674D
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990734; cv=none; b=Xx0USO3LBixchWYy/FHZDdmmgXAkqkp5jcgOxqJbbHQ6l/DPe9E2v/JYzwLKXdhVvx4xpr/bzxMyaJ12RdftDW9U8QpifBv5YLnmv6LbjFc4IaEr8/n+2b67c+aEiVS5hO/5QUp3nLnUYRp+rcaLIlYKWsbAAKozlMUFVfKjdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990734; c=relaxed/simple;
	bh=j6gWbIZNNEh6chUr5makqZtgofiUG8MRhH3YWkHuWMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbv42CxQPwDrnPzBR5liMj59bdOZQxHEEjVItu4nt3TyYg43ovtI4u3M52qoM070Sl5Y7PgpxIXoKDVRn6BcPoJUUlfOW5gXzjiJg34rs+Yl0Bm+JXotfDkcdycGznuT9hUdCFLvqRkVfzqRA129nI5ygsBdQubCX2uNM4VK5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pUTwiQPf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfSnHRE0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pUTwiQPf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfSnHRE0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F1AE41380231;
	Wed, 15 Jan 2025 20:25:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jan 2025 20:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736990731; x=
	1737077131; bh=jq76kOpYlSZD2g37Q75mprLnNU4RxLxhMWf/1vvAlRc=; b=p
	UTwiQPfZKircrsi3L3NlIm677GizVn2tIR6lvMHkTdf1oxT/iqs881cjJ6A0SBkv
	XP3s2ZQ6/nmOtVstXeBy+bW4SG8ARV/mNLGffXCJHNCkRfvBZjyqec+Zl6V5yajj
	O13haDL5NVIWyLehcg1jFgls9uzzSzMWFhwQRfIMOjsK6hBMSG2SnTRFKj2CIahD
	nYTQhb+soW7wHZgST3clPZWKMmG/ROIvS8402syEHqRmkiHY856zQiaAVPS/DWK5
	Zvuazn66WyQYS3TAQOSYaLxVlOOvv9dt++PNLCMVGoaj8alyQk+TsTXcaknI0aMQ
	jyeirAXILv26qKIGDFHqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736990731; x=1737077131; bh=jq76kOpYlSZD2g37Q75mprLnNU4R
	xLxhMWf/1vvAlRc=; b=hfSnHRE0ce/eVCkl6PIvAnetsQb7SP7IoUZRYxFX8WJe
	ZwvZf8YltkM85dDHmUzZPJNRVUmDotYCIoNl2wfMpUDVz6KNCv/STconE6AEqrbb
	JfaybzPpnGFFUBwU9dfTH3keP6Zdf6FTKx+sULBZQx5xc12A9pDZ/NR7KvlmvJjt
	kITkprOXKFoqdtk7Ey3/olDSlESQR27EoZn5Sd8TaFF1pVuaQsM5GYYTyS/YDvbK
	vyHCEKAGcACcZSE5wnBpzwlU9J41zKHoSK0ubg8cPsPDSoQ/TCYSV7Qh8NPQY4HZ
	OIsSUfyFkaQFghTMPqxp7oR5dCQ6pR3RiQb6NqJQzA==
X-ME-Sender: <xms:C2CIZ6dKcARJ0_E3zVgFNJZIg37RiJagquJGD3heVZi1-tiSc-jnNg>
    <xme:C2CIZ0Pvy7IGUhy0K0xHbPseFTW3k12jhoTwCkp-XTuhGTq0Op55mDNB2YwLZc6OL
    NlhRIhdTaNSd41Jhw>
X-ME-Received: <xmr:C2CIZ7hp7_yssU0MsySxv2tSF28S_HN7z-lr-c58bbZN8CBcK4MxNSEGix38_4NBUZVMEh7Tv6_l0DvhezIqLhjgT82tUJ4EbKWu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepleevie
    efieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:C2CIZ3-_bhWTcSz0x0xqPV4x1ek7YVJgUm1Gkz6VzqeUHVo4ByCrCg>
    <xmx:C2CIZ2tni4cT2eLseG6fnBpSVkFRlbxQtpy4t8TtrHp-WnPOpET8-w>
    <xmx:C2CIZ-HGz5aFs1POcv2f3pfSELBY94e-8Y35rzwgqnFm0Ysy7HOI9g>
    <xmx:C2CIZ1NlL8vNM9_XOgvtnVr-qXDRzUnvvbIe1DT90WNJgjUjSVRwHQ>
    <xmx:C2CIZ_7WdTLdHBf1PgpeLlDVwyCdeZ3MVW4AA-PonlBUIGa4Sfgiddjp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 20:25:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 4/6] usage: add show_usage_and_exit_if_asked()
Date: Wed, 15 Jan 2025 17:25:21 -0800
Message-ID: <20250116012524.1557441-5-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-191-gafe818080f
In-Reply-To: <20250116012524.1557441-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
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

	show_usage_and_exit_if_asked(argc, argv, usage);

to help correct these code paths.

Note that this helper function still exits with status 129, and
t0012 insists on it.  After converting all the mistaken callers of
usage_with_options() to call this new helper, we may want to address
it---the end user is asking us to give the help text, and we are
doing exactly as asked, so there is no reason to exit with non-zero
status.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |  2 ++
 usage.c           | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..6edf50bc95 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -701,6 +701,8 @@ int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+void show_usage_and_exit_if_asked(int ac, const char **av, const char *err);
+
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
diff --git a/usage.c b/usage.c
index 47709006c1..26cd54a511 100644
--- a/usage.c
+++ b/usage.c
@@ -8,7 +8,7 @@
 #include "gettext.h"
 #include "trace2.h"
 
-static void vreportf(const char *prefix, const char *err, va_list params)
+static void vfdreportf(int fd, const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	char *p, *pend = msg + sizeof(msg);
@@ -32,8 +32,14 @@ static void vreportf(const char *prefix, const char *err, va_list params)
 	}
 
 	*(p++) = '\n'; /* we no longer need a NUL */
-	fflush(stderr);
-	write_in_full(2, msg, p - msg);
+	if (fd == 2)
+		fflush(stderr);
+	write_in_full(fd, msg, p - msg);
+}
+
+static void vreportf(const char *prefix, const char *err, va_list params)
+{
+	vfdreportf(2, prefix, err, params);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
@@ -173,6 +179,22 @@ void NORETURN usage(const char *err)
 	usagef("%s", err);
 }
 
+static void show_usage_and_exit_if_asked_helper(const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	vfdreportf(1, _("usage: "), err, params);
+	va_end(params);
+	exit(129);
+}
+
+void show_usage_and_exit_if_asked(int ac, const char **av, const char *err)
+{
+	if (ac == 2 && !strcmp(av[1], "-h"))
+		show_usage_and_exit_if_asked_helper(err);
+}
+
 void NORETURN die(const char *err, ...)
 {
 	va_list params;
-- 
2.48.1-191-gafe818080f

