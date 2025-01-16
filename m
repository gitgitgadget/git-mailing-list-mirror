Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379D155756
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068451; cv=none; b=IHKNa9rag+ncxw2c49Q1wnp8Gm0lKbBLjvuL7/Hat0jAGPnQ+XU7daKkG1M+bAWQOvv4+vrMTd+fQIVUk5eN0+5zxMx/tT5FQLF2HLpIgPIxUN7x17sTFiRQbW1ll3J8ovbQvdZBjdgzbS4CE+0kPZZLaEj+vTxneZMuEu3ho/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068451; c=relaxed/simple;
	bh=Mu+k1ITmN2aAJhTPB0Z6aA3EtKGuSqks1Oq4ZPrOXpo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lvu+FxyZPAGVU6MjE40/RSV/yamw0tJJDRARtBCYLdawpUIdaYbXSp2fyMHw1HNIHvNk/gMiaBpscsRvfioRGZOSiO1Wjre3WHK9hHJ5KqlIoE1CsjvqRFKUErGy89yCmQAe0NZmhN6OG71OPGravbwTrlU/kpi/GHkYk742K9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=7L5mRvmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bn/H+Flw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="7L5mRvmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bn/H+Flw"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CDFB513802C9;
	Thu, 16 Jan 2025 18:00:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 16 Jan 2025 18:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737068447; x=1737154847; bh=Nf3m2fiTEa
	ETW6VCbyvJ/Wlj5VqgddiKETbWy9rwnNg=; b=7L5mRvmmg+HOhF/4orRqqfM1pp
	zET0yUCLgJz+vqhaV5ba03z6MmLY33AQ2h0eDdA+TbPIcXVv82rGdTVBx3cfxoen
	AM2K9jpYK99RqDlxf6yBxKR0CqZVmaib2WB+J11SMXhdzYigAutSMR3qDlqEdySz
	qAsNUD3gKn14KVF+VaUyegyNQS0nxUL7bx4AkK8FBxW/REFqpLENqLXJNg/SyAlh
	lKtT9vKZYz6EgratxmOhfV14HwTIlWnNCWW/4cpcmFPucQyj98FbQyfz2M0byXk4
	UF7mr+YbvuXNEiSd/vqwU0GlhLwqm5A+cmZUZe6YREM8ELE9Z3FHaaE54fLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737068447; x=1737154847; bh=Nf3m2fiTEaETW6VCbyvJ/Wlj5VqgddiKETb
	Wy9rwnNg=; b=bn/H+FlwnaiyWifjolw/OrrCCPNBDBVholrBnhlpurarl5QW4wI
	lNhybZzQp0g9Tk1hfPxL9ZxqRYRRjuq2zDENfDv+OizqTHiU7bChRmPC3LucvHfo
	QpFbGAA0voIVdJ15Z2tSzVqK0FxAJAZQKfeBo2VHqi0FU7V6ZhnOyUTZHN3IAGgM
	9edcN95qTepq2iEO/y1MAvzClrjq2RTUFQFffGlUM0r74oS0+L5POQSYVKtoH/+6
	NPddAFBjppBhFG+gYWUF7U3crOtpmkL2J29WtpyLqpU7ZKBlc5140VinD5N2g9fv
	MosThuakBhbde/Els+q5tn+G/SaZVBSUc8Q==
X-ME-Sender: <xms:n4-JZ8t_zgvCLyovdYl3OxsuQpITNbCTOjY2h9bdMTEPRQN8YJzLlQ>
    <xme:n4-JZ5fn1q5Auy-MfNRYCkGK79DH79aFsKn-pvwKTxe0FiqCvbm4CHRLT59oZy5yD
    KFEM5Ke-9SWaQnRwQ>
X-ME-Received: <xmr:n4-JZ3ydJu61Bqq3w4j1HkBCcNIEWroh0Q8h6FvS2HbVuGGLLlyrmAc-4b8PPwj10SqY3nb9JeU5PfGQUWlUrdnedFwhvANeByDJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhue
    duteekgfdtueegvdfgueeiuedvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:n4-JZ_PhIRN5gt_W4eTmfLpIRNbysbpJ9MZeANmd2_7qu45MQILXtQ>
    <xmx:n4-JZ89KtdgzypSmqDETgmXcWVsss0SV9k9txV31u6cHASvYc9UH_Q>
    <xmx:n4-JZ3VwISDk8MZ7b0K_47GbDIrirELRY9EUWsSnlbfgmyGTOeo4qA>
    <xmx:n4-JZ1eRv02-cP80KlzOOJ6jwD5yd5SGro5jX6d9R-FZecFDVKRVIA>
    <xmx:n4-JZ-JCi6ZDxgqNkKkl3uTEPMDhg-GuaJMJsDqn20xaogEoZhPJQGxZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 18:00:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v4 3/6] usage: add show_usage_if_asked()
In-Reply-To: <20250116213553.2563751-4-gitster@pobox.com> (Junio C. Hamano's
	message of "Thu, 16 Jan 2025 13:35:50 -0800")
References: <20250116012524.1557441-1-gitster@pobox.com>
	<20250116213553.2563751-1-gitster@pobox.com>
	<20250116213553.2563751-4-gitster@pobox.com>
Date: Thu, 16 Jan 2025 15:00:45 -0800
Message-ID: <xmqqr052nz36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

So here is a replacement for this step.  Everything else is
unaffected, so I'll wait for other comments until sending a full
reroll.

Thanks.

--- >8 ---
Subject: [PATCH v5 3/6] usage: add show_usage_if_asked()

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

1:  2b57538eab ! 1:  94a6fdf72f usage: add show_usage_if_asked()
    @@ Commit message
         doing exactly as asked, so there is no reason to exit with non-zero
         status.
     
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## git-compat-util.h ##
    @@ usage.c
      #include "trace2.h"
      
     -static void vreportf(const char *prefix, const char *err, va_list params)
    -+static void vfdreportf(int fd, const char *prefix, const char *err, va_list params)
    ++static void vfreportf(FILE *f, const char *prefix, const char *err, va_list params)
      {
      	char msg[4096];
      	char *p, *pend = msg + sizeof(msg);
    @@ usage.c: static void vreportf(const char *prefix, const char *err, va_list param
      	*(p++) = '\n'; /* we no longer need a NUL */
     -	fflush(stderr);
     -	write_in_full(2, msg, p - msg);
    -+	if (fd == 2)
    -+		fflush(stderr);
    -+	write_in_full(fd, msg, p - msg);
    ++	fflush(f);
    ++	write_in_full(fileno(f), msg, p - msg);
     +}
     +
     +static void vreportf(const char *prefix, const char *err, va_list params)
     +{
    -+	vfdreportf(2, prefix, err, params);
    ++	vfreportf(stderr, prefix, err, params);
      }
      
      static NORETURN void usage_builtin(const char *err, va_list params)
    @@ usage.c: void NORETURN usage(const char *err)
     +	va_list params;
     +
     +	va_start(params, err);
    -+	vfdreportf(1, _("usage: "), err, params);
    ++	vfreportf(stdout, _("usage: "), err, params);
     +	va_end(params);
     +	exit(129);
     +}


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
2.48.1-210-gaa1682cadd

