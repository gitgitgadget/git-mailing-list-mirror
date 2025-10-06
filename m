Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55E1DB12E
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782166; cv=none; b=sZRTNHvTF4+gNnIElpQ2ichPDyxIK4PDoeVf0OHpwkzIcZ2/yxfMuDFnvDXWNVEtekr1p3jQp/jae/5oRqugbewDhHDnKdlClYu9rXxROfwtTvPDCDQnaYYkPpdQaNm9d7aqfSsdVZQKQL78uAQsDNBXkswNwPTZ582P3t7Ezuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782166; c=relaxed/simple;
	bh=aHZgRve8x1u6lzf485UMdIDfPx8nE4XqH64RxL/guds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jxb4MAARmpKaSM9DtHmMfQumYskRodUqmh9b2VXLWvyutHRsNtMtI7q7x/7kjG600FX6icUJy0qEYGguVhdQLYsgUpX49XcxcumnJpWYJQcrgk9zrP35yS4c2xR+6qdy4ld4OC8pzB29Se/hNtQek1FT4+Z3I/Ka5GM3oLU2tTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EtU99GGY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMRXpvhi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EtU99GGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMRXpvhi"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF58E140005E;
	Mon,  6 Oct 2025 16:22:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 06 Oct 2025 16:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759782163; x=1759868563; bh=ZSR7JnsNC/
	CzDcmxh4FYk9wwp7bjwgJUXIOem5YTufA=; b=EtU99GGYY5L0BZvYEiVg/f/Xgq
	US0Ls3BXkESMulz+JcQpxMOkzk0774pNqXgIjlfNW6B4Pp6mCULPQQYf9RGLHcYy
	BXx+PM3J0W45D9ci3E5VvZeNJUDxYG5Zcg7ls9gOxE+BAj0r5aO2ckz2fpK2HF9e
	+o+UTtGNK9UJKMUPpRyIRnL9+i6VZx4X5vh4yHTXvjDVYDVgif93giyFGkYxaW4U
	0rqd3IOKkqmh7hx8L+8mfwcvRyRYEE7mhc9LGI9QjDRvu//o60DOfFALLaSVRav3
	SxiXuJuOyXqDb2FTJXO3culk8c3jsMkh4AT0RLHlR8DY0/TEjArM3XKmz6RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759782163; x=1759868563; bh=ZSR7JnsNC/CzDcmxh4FYk9wwp7bjwgJUXIO
	em5YTufA=; b=iMRXpvhiHTPQQCexExXbJaO5gu97RDBedqDXfnLsKOyMZpMwzs8
	MR5Qn00y1IAOMoirJVJl5DzxH4T42LfZLb75PgAkfM5TG+vGyK2EFxczlhL8dHYm
	+Agm04b3T61WvfCizVayPPC7DJvrmvCZpAavFSUjc9yd/72f5YyNSP70FtjmClsc
	BI//Yxm3GoQA1h/UVzV+AYU/elF349Tx6QeP3+pojglHsb56y8Kt4j922xNOlMST
	Dv0+CDCybfB9CBY0SGHjFQWHAPpm682JKeyDmCJKB46Uu6tEOQKs33NLQQmjfexl
	a+zYdIvB4lJEM7sj7wZepb5VhGxRJqFtzAg==
X-ME-Sender: <xms:EyXkaKxAbkSKTIbfpoLiy5TwDAa3_lZemikZqABpZvHaRyMhgZhGYA>
    <xme:EyXkaCqRfDhxpjWYcvb8VMJzrxxcxFTdGXuSiPfWYZLMPEypARFFSELTKiQvb4A-2
    j2XTtM8Rs7LBOOHCp4aYp2mbsgrotXfUroJADOc-TCqIu8iLW6tAA>
X-ME-Received: <xmr:EyXkaAwc6XjI_YlyXz8LW-KSLDY_Ltxx5wzgxJ4uPf1A4mOrEMmXnrE14kaq2U1CEsimk304-359FgcaRA6ga2JltyDbF_CemcZm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnohgrhhdrphgvnhgulhgvthhonhesghhmrghilhdrtghomhdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepthhhrhgrnhhurhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrhhoshhsvghrrdhmihgthhgrvghlsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:EyXkaOrNuLRLV144r4inwoONDwi6OhTXCUnVSpvUlwxUWcd07ppP3A>
    <xmx:EyXkaIeILmjyHaQoA5ln_m-3pG6oEOgtGDmzJur1LrxjU9Dc3fdn-w>
    <xmx:EyXkaJqPVDTCiAXeCo7twkWsia1R_SgyBkTFQxTTZ7RfhXL9zjjE3A>
    <xmx:EyXkaKmFKMNykeCtLbc17xoWloZxMNcKo7tZoXxXTolmoKsUwPVm3Q>
    <xmx:EyXkaLHyd0qhscVvWJ8WkBjsPHDbB1zDHBBLlBognNnacJZ8OV0K3JJY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 16:22:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Noah Pendleton <noah.pendleton@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Thranur Andul <thranur@gmail.com>,  Michael Grosser
 <grosser.michael@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Taylor Blau <me@ttaylorr.com>,  Matheus Tavares <matheus.tavb@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Calvin Wan
 <calvinwan@google.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH v2 2/3] config: values of pathname type can be prefixed
 with :(optional)
In-Reply-To: <xmqqms63ok7g.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 Oct 2025 13:21:07 -0700")
References: <20250501214057.371711-1-gitster@pobox.com>
	<cover.1759094936.git.ben.knoble+github@gmail.com>
	<5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
	<a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com>
	<xmqqzfa3onxx.fsf@gitster.g> <xmqqsefvol7s.fsf@gitster.g>
	<xmqqms63ok7g.fsf@gitster.g>
Date: Mon, 06 Oct 2025 13:22:41 -0700
Message-ID: <xmqqikgrok4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> So, here is the preliminary clea-up step that should come before
> [2/3]
>
> --- >8 ---
> Subject: [PATCH] t7500: fix GIT_EDITOR shell snippet

And this is [2/3] rebased on top.

--- >8 ---
Subject: [PATCH] config: values of pathname type can be prefixed with :(optional)

Sometimes people want to specify additional configuration data
as "best effort" basis.  Maybe commit.template configuration file points
at somewhere in ~/template/ but on a particular system, the file may not
exist and the user may be OK without using the template in such a case.

When the value given to a configuration variable whose type is
pathname wants to signal such an optional file, it can be marked by
prepending ":(optional)" in front of it.  Such a setting that is
marked optional would avoid getting the command barf for a missing
file, as an optional configuration setting that names a missing
file is not even seen.

cf. <xmqq5ywehb69.fsf@gitster.g>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.adoc                 |  4 +++-
 config.c                                  | 16 ++++++++++++++--
 t/t7500-commit-template-squash-signoff.sh |  8 ++++++++
 wrapper.c                                 | 13 +++++++++++++
 wrapper.h                                 |  4 +++-
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index cc769251be..7301ced836 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -358,7 +358,9 @@ compiled without runtime prefix support, the compiled-in prefix will be
 substituted instead. In the unlikely event that a literal path needs to
 be specified that should _not_ be expanded, it needs to be prefixed by
 `./`, like so: `./%(prefix)/bin`.
-
++
+If prefixed with `:(optional)`, the configuration variable is treated
+as if it does not exist, if the named path does not exist.
 
 Variables
 ~~~~~~~~~
diff --git a/config.c b/config.c
index 97ffef4270..73fc74c8fa 100644
--- a/config.c
+++ b/config.c
@@ -1279,11 +1279,23 @@ int git_config_string(char **dest, const char *var, const char *value)
 
 int git_config_pathname(char **dest, const char *var, const char *value)
 {
+	int is_optional;
+	char *path;
+
 	if (!value)
 		return config_error_nonbool(var);
-	*dest = interpolate_path(value, 0);
-	if (!*dest)
+
+	is_optional = skip_prefix(value, ":(optional)", &value);
+	path = interpolate_path(value, 0);
+	if (!path)
 		die(_("failed to expand user dir in: '%s'"), value);
+
+	if (is_optional && is_missing_file(path)) {
+		free(path);
+		return 0;
+	}
+
+	*dest = path;
 	return 0;
 }
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4922543256..a85229e556 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -46,6 +46,14 @@ test_expect_success 'nonexistent template file in config should return error' '
 	)
 '
 
+test_expect_success 'nonexistent optional template file in config' '
+	test_config commit.template ":(optional)$PWD"/notexist &&
+	GIT_EDITOR="echo hello >" git commit --allow-empty &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	echo hello >expect &&
+	test_cmp expect actual
+'
+
 # From now on we'll use a template file that exists.
 TEMPLATE="$PWD"/template
 
diff --git a/wrapper.c b/wrapper.c
index 2f00d2ac87..3d507d4204 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -721,6 +721,19 @@ int xgethostname(char *buf, size_t len)
 	return ret;
 }
 
+int is_missing_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno == ENOENT)
+			return 1;
+		die_errno(_("could not stat %s"), filename);
+	}
+
+	return 0;
+}
+
 int is_empty_or_missing_file(const char *filename)
 {
 	struct stat st;
diff --git a/wrapper.h b/wrapper.h
index 7df824e34a..44a8597ac3 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -66,7 +66,9 @@ void write_file_buf(const char *path, const char *buf, size_t len);
 __attribute__((format (printf, 2, 3)))
 void write_file(const char *path, const char *fmt, ...);
 
-/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+/* Return 1 if the file does not exist, 0 otherwise. */
+int is_missing_file(const char *filename);
+/* Return 1 if the file is empty or does not exist, 0 otherwise. */
 int is_empty_or_missing_file(const char *filename);
 
 enum fsync_action {
-- 
2.51.0-580-g8258b70b6e

