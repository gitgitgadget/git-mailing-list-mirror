Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3D16F85E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321532; cv=none; b=UDUYhhBCOP9EXojvRyMBhm4JdZtNub4AEp8WINF0bOXDcj67+bj6I/9fsC5XJ7mu6Asqwx0WMslwGALm4nkgby1J2oxxWYXu32vGvPcGVfdvyHdhp8a1ObYuwEGQ+SsNIhr/1+B92p3btVbkIZML8rY+33EyrIrhVdJrQoEoKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321532; c=relaxed/simple;
	bh=I+iYOloMtd6FePBq/0VaiDYy6Bg+o+k05kOUJRE5Uoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=awC+PxWTSiGTpFXm30mghc3gkd7Ioz+dPk4M45Xv4vpz7wFoBTjbBD9udoF7L8+tnTvwrUGncr/3X0eE13759gast9VyUI5MmqLDl80KnHTmHv3PYvKwr7F9pAvmrNHCnp09gmmH645mqt+tPWWnlhB6QGLuvxSNVNow2L/MjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lm1UlXdH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmq1CJCj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lm1UlXdH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmq1CJCj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B2971380685;
	Mon, 11 Nov 2024 05:38:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 05:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321530;
	 x=1731407930; bh=z5cZ4R1QpOKCkf9BKOMRZu0LTIYXkypYWKVucTKFlDw=; b=
	lm1UlXdH74T7L+lkqDutmpPB7SkWjafHfLHwORzOk5j13elT/a+D0LwWpIjfRc47
	/DpipoMoQMPlw4jMx8v51Sr9qYjkoFbsJvuVIWARGTt+/m5wrL6I7E4RtllxZrt7
	dA5QTvaaQA+z2kpM6D53DSpGMFN0Kue2sMEnK+QQLa1ZB8tC1LA6cy3JAOTJmK+P
	6TeuEUv5eX0MoesHCR4rxnQNdX8xcxYuPJWFwsaVW5HJE0/qg0+KLRQ8pgQ3m+mA
	Y2X8lro7bHyMvjt2XLPqUCIXpP4YYaCaDR0DO1lov1VDC6Ai+Nk1c6th7Bva4BCu
	JUfDfRix7VyRyRHbQ367Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321530; x=
	1731407930; bh=z5cZ4R1QpOKCkf9BKOMRZu0LTIYXkypYWKVucTKFlDw=; b=m
	mq1CJCjplLGrYXqD2oS6sd4DvVnAL0g/MIeXcUrCwL4wFayCuaBwUNr12IEzyXNW
	lBqqCcWkZqqnUf4kMXyVMehZ2AVkAortyA1tu61jBLP8ELcMrlzIj3Fcw7VSnVeY
	zGs2Zo0O9G5cUYV+RRDoND/9fUxnNQ1h2Q68StZ+Kecq/zpb20zi6MVgejMy6yc2
	v51d89nurNz/j4MoquRxneGal8E8s3RWi8OlEAK3ckPHnRAqoONElalOetDpEoyw
	xn0T9IaW7pjMZ5wUXULHHTk5wHBUtsQFxbLO32mf05TCSWWOothm7QmJUFup9ya0
	KsIZD/T6UvpTt6aw/tQjQ==
X-ME-Sender: <xms:ud4xZywIi_8wBSf9adcHQDm5WdSu66sxfTVHux40vV-x-8WnuclvoA>
    <xme:ud4xZ-QeELBdxSQWGdMSvM2nMTiizqG70DPydKYcfwd_fVzRAwej4bdG806H2wu3h
    M4Fyn5QpF7P6sFUlg>
X-ME-Received: <xmr:ud4xZ0VXLpyPBybyq3JPSQRJu6TzNAXGUv1sWd8rADMrIZpArvz8enuXPZ4itPThM1IYeVNBJQG8j1jDfA2pbQoy74tO_tZyAU9KtIwJ7Lj8vfDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ud4xZ4iSorCbYZvN5EeF4ZvuxwxJ81JsUiIJ9Pbp6-kZ7dr21o36nQ>
    <xmx:ud4xZ0BYgoaj-5ijaSeqwZoTQoUNsthE6RAMOI3pfmWEmUatCuYBbg>
    <xmx:ud4xZ5Kvr7zIq3PNvOMWmXOS-ih0Qc1NUsqyCWqwXALncUwoJsk5aQ>
    <xmx:ud4xZ7B-wBf88rQBL1-XephXLf6cG2YRTYw85PMNC_eB1VVwNHEy_Q>
    <xmx:ut4xZ3MtqIn2nAtwTUjMNDyrjfFsd1ZFENU7apCbUxKvD_837u8MRlyD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8946640c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:31 +0100
Subject: [PATCH v2 02/27] bisect: fix leaking good/bad terms when reading
 multipe times
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-2-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

Even though `read_bisect_terms()` is declared as assigning string
constants, it in fact assigns allocated strings to the `read_bad` and
`read_good` out parameters. The only callers of this function assign the
result to global variables and thus don't have to free them in order to
be leak-free. But that changes when executing the function multiple
times because we'd then overwrite the previous value and thus make it
unreachable.

Fix the function signature and free the previous values. This leak is
exposed by t0630, but plugging it does not make the whole test suite
pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c   | 14 +++++++++-----
 bisect.h   |  2 +-
 revision.c |  4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4713226fad4e16ebbda4ba2e8d13c6eaf7d4bfb2..9c52241050c14ecbf3f7950a0c5e7b962fcaa541 100644
--- a/bisect.c
+++ b/bisect.c
@@ -28,8 +28,8 @@ static struct oid_array skipped_revs;
 
 static struct object_id *current_bad_oid;
 
-static const char *term_bad;
-static const char *term_good;
+static char *term_bad;
+static char *term_good;
 
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
@@ -985,7 +985,7 @@ static void show_commit(struct commit *commit)
  * We read them and store them to adapt the messages accordingly.
  * Default is bad/good.
  */
-void read_bisect_terms(const char **read_bad, const char **read_good)
+void read_bisect_terms(char **read_bad, char **read_good)
 {
 	struct strbuf str = STRBUF_INIT;
 	const char *filename = git_path_bisect_terms();
@@ -993,16 +993,20 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 
 	if (!fp) {
 		if (errno == ENOENT) {
-			*read_bad = "bad";
-			*read_good = "good";
+			free(*read_bad);
+			*read_bad = xstrdup("bad");
+			free(*read_good);
+			*read_good = xstrdup("good");
 			return;
 		} else {
 			die_errno(_("could not read file '%s'"), filename);
 		}
 	} else {
 		strbuf_getline_lf(&str, fp);
+		free(*read_bad);
 		*read_bad = strbuf_detach(&str, NULL);
 		strbuf_getline_lf(&str, fp);
+		free(*read_good);
 		*read_good = strbuf_detach(&str, NULL);
 	}
 	strbuf_release(&str);
diff --git a/bisect.h b/bisect.h
index ee3fd65f3bdb89611d7575239ee79e8c50bcd703..944439bfac729cf092d6c5962c9edff2321002e4 100644
--- a/bisect.h
+++ b/bisect.h
@@ -75,7 +75,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
 
 int estimate_bisect_steps(int all);
 
-void read_bisect_terms(const char **bad, const char **good);
+void read_bisect_terms(char **bad, char **good);
 
 int bisect_clean_state(void);
 
diff --git a/revision.c b/revision.c
index 8df75b82249b36e7e3ee9a4a151f085c189acc45..347dabf7f9a1a87765150ec998deae9b6709b5f6 100644
--- a/revision.c
+++ b/revision.c
@@ -51,8 +51,8 @@
 
 volatile show_early_output_fn_t show_early_output;
 
-static const char *term_bad;
-static const char *term_good;
+static char *term_bad;
+static char *term_good;
 
 implement_shared_commit_slab(revision_sources, char *);
 

-- 
2.47.0.229.g8f8d6eee53.dirty

