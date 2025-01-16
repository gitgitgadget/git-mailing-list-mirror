Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE201D63EB
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063361; cv=none; b=SRpjenoa7aFa9Oo/nQ2tVvqc0hcikdUZB9X8lLpcfwrZql0G9tlIweOa0YP4uFZrAmxGcCFVO55STJ/Sw/k0SBDE0wVL5zORpgceoKYPnz5Zku7p1a/zs3M+a+O2Y1pwAas22+jrTnl2sGJmt3a748QDw7v1FDnTF0Spa2RyL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063361; c=relaxed/simple;
	bh=dbqv6ZMYuvkfkhhcSNsmdaBhPZ7d2ZbHtGkUpDj4l0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4760hNVjZcvWKa87MI1JHY4Cte/iVdSZ0Do3d0iz28/dQECs39HOshuTUVnoZQtPYyisiVGS6srXvfQJmwi7U+XlLyaVhoo6ZRg+f+njkDl4pDU8S6YGjNcw2UX95D9nGRUbhl0XJc+OBKERAE5c+D7OXoR4tfEb96Ecen28WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fxOywGaC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pv5Yglal; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fxOywGaC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pv5Yglal"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C76AE138021E;
	Thu, 16 Jan 2025 16:35:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jan 2025 16:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737063358; x=
	1737149758; bh=3wjjqTWtcOm6RjDt7g0gCOrIY+yTm/8v2c46Yw+T+vU=; b=f
	xOywGaCquWILI593tTejrbrcdgJ76HB+av75ryXiZEgFa+Zg0qiQfEepD8ZTzjZ6
	b/VdkycEgLcAXRzWNa8a1d4GN8FG8ZELfgkMdfHBZr/7g8bcS0P474B9Iy6F0NxU
	3usBpbRiFvDFS6ZuKyU6uIjv9J0mwkWZN+c3p70sOyzSFNC2pBYgemMssOAkAzRz
	xaGw2sVPigJOpxJYd/3iwGTXKq05qGOBPTkW2FgNAk8x15vKnlO23BY5OWqrGo9a
	jKjUTsB9XHyjHuN4osb/0HScG9FKmbYyvWmJPcYk4L2o+PfRH6WwJ8zjfY9QHsL7
	pmxVS3Eh33i55zdFbWypQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737063358; x=1737149758; bh=3
	wjjqTWtcOm6RjDt7g0gCOrIY+yTm/8v2c46Yw+T+vU=; b=pv5Yglal9kCydfoNa
	Rm1DTQXeM1LG9baf+HrfZbvqXI90uM4evonyWnc+MsyijsxMq8GZ6DrfdW0i0qe9
	KCzTm9186Rant4Zc4HHvfNl+h0nm/0orrJcgI9y8hiwMmEZj0CQGwGq28uPFqXcd
	x98Ix9KgGxUneEa5bdBGJwGrSbPkwQtSB3fV65IEAtZcefdP/onFIlvEULNOXeqO
	4vXdzBQKvFOxuaMbWWzAM/eeGAb89jqyNyIsxsEJV6TEiDidwvgybsd5tW5wZyz4
	7gsnMEsmgquE5sl8m2rUz1XPoopmOVvzG/7Mo08szWv+7LVPxZPUW0NM9KsU3UyD
	cxgXg==
X-ME-Sender: <xms:vnuJZyQaedC2Tkvt6XLDgCcX2a5WBcPFvSEw9dQZDEtyIVN6fH-t7A>
    <xme:vnuJZ3yVMipjtgMddiwDFowyq_mGcIT_MJgXSsjHAebJKK5m6v1ewdfyYHJzdWMQA
    Dwpqc82OeIC8_0DCA>
X-ME-Received: <xmr:vnuJZ_1lh7eQADhwCdatgfDL7_T-Rb86QFobXitYquYdCDeI0hhoINCQM9vZ-WbUHDrBhS0YjEQncD0zomtQEhQ1i9D0IQNYtzOt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:vnuJZ-AmZ3p_iXlBT0kBCGav5GVb5Q8FqBPFXTBij5Ito8vnMiMu6Q>
    <xmx:vnuJZ7iRnB3xyAmsCErPnPluxqFr2qyQkovriK_RWW8gklXyu7Rwgw>
    <xmx:vnuJZ6r3G62vm0ULDFGbVGAXyArlXIJp8IN4728c1muGlte-JGM5mQ>
    <xmx:vnuJZ-jAwATBrzXgKDNpJNcnAsLV33pjaIHZYVS6ocogfv3g4DS92w>
    <xmx:vnuJZ4vop_YisVFQK7wZqr_56GW6DImrQbxK4jTRg1pyYY-SvARdFUIx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 16:35:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v4 2/6] parse-options: add show_usage_with_options_if_asked()
Date: Thu, 16 Jan 2025 13:35:49 -0800
Message-ID: <20250116213553.2563751-3-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-210-gaa1682cadd
In-Reply-To: <20250116213553.2563751-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116213553.2563751-1-gitster@pobox.com>
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
 * Helper function renamed.

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
2.48.1-191-gafe818080f

