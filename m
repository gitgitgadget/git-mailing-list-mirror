Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503920DD4B
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141111; cv=none; b=UZG8VMbg1U4BXN+M3CWxqVWJVdwUrgWKOYbF5M2YcmUABXJP39oKFw5DkwyBfoUppEHisUCeqIBmyAwRem5cya8ltNMZsNXE8oQZNVkJLT4F4o0WwjfPrZU4/O8Q8GIVnae5Vd+Im72FH1v6f6l3rESJ3naTyS8nt/BR/yaXnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141111; c=relaxed/simple;
	bh=yt9s0BtuoNwslmGrVUJspMnZLrL8LjlqmoebGr92Pjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPMMNLYnCfJhct+DXnGrKui2oeQ3Uwf/EVcw0g0TefLcdlKv+K7WnXCk/0KcVef5yeergnIDj4w5GR9YBgOPHyPWYeUlFvJkmRJvOQe14PFMJcL1mRPYbz91g8+SqAXC/5+gQ26ul6naqk4zxhEqFKhEC7nHC53P2ZHCFIps7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zdx/88iW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Btp4u9sa; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zdx/88iW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Btp4u9sa"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C76D3254016A;
	Mon,  2 Dec 2024 07:05:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 02 Dec 2024 07:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141108;
	 x=1733227508; bh=WVe4Ftejp5H0HkEx+Che1Q/7xLKln4ZVzJqDk+25+2M=; b=
	zdx/88iW2SKhgPaAor0PKtcBmGQvDtEpikTm+unabRL/4WWZ+iissWnpG7pRnWco
	BpyYENI2DosBOCAqE8wiSEsoO1vxFMvkdYsahCu1TOt2X3FVgYjKYdnxw8EY6t2S
	3NcwL5xaARs6rM0ezX6ttxPqxtOwWjFua2PNn34LmjRzrtucAuCywt37PZfkhHhv
	j1gM5yKj41XK1iYJWTjyIGOR2lDk8LEYuguyUTqDOUFk7OXEHuln5g9Lo2xkK/P+
	t3POO6qsKOV1gVWiEco1jmcrrwtCYA/3enCLEeMSfhODnltU0Vh4Qududo4JRTkX
	3/TpgHEYAlVyUWYBXKO+yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141108; x=
	1733227508; bh=WVe4Ftejp5H0HkEx+Che1Q/7xLKln4ZVzJqDk+25+2M=; b=B
	tp4u9sapaoF/lPSSBlb5S3WvO0DWhGfE5cwnihABVymEJE0Pu51JPvBXvrYp4aKn
	xoc1wOM19ayEELqa1KBL6HPUWTiOPoA2stKG0EOPLIC6WHtWrPy4Y1AEXtx9Nw+X
	TShsnxAWUUeg7Lx6SMK1Bg6d2kjuV+A87AvnUGby/BNuzyIrYYi2HB2IyEQMpZ02
	/dWPktPhC6VJnDTqgnUtH+tTgddZxfx0/7LBQ46isXnFQoDJ/I5P0CCiT9yWdIF3
	S941KjuCi4dodpMu2q9YRN7Rd+QuC2wWfpttAjCF71AcO9KPrwdYOiED2x8wBa16
	6p60UQrGue0km2ri2k+yw==
X-ME-Sender: <xms:dKJNZ2XBCEcade25uSpdyzELzI6PQwou6mSZ0em9ng-_165cGB-CrA>
    <xme:dKJNZykyjUNOlWoux7YjpFmFSPrhXHW_m9i6fllGYT9mgyvbeKbHAZGGhWkzuicRs
    DDmbRf0GwC8KqPPSw>
X-ME-Received: <xmr:dKJNZ6aJW2HfYUkpYWul7qzjaO1PZzRM_Y6193kjNskHGMxw0X4C-TXQ3eZZ5oohonkFFfiKroRE0nXJFiwuW9LW69O2Nv6GN-hHLDk9x3FqXxDypQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dKJNZ9UrkM9o6EujJk_lspW21Pehgmx3KUC5VT11DiUycP57IqsxSA>
    <xmx:dKJNZwnMY0LIiZREeYu_DDMCxWNjUjUeUh6T6hE-mTjvjRzUpmqZAg>
    <xmx:dKJNZyeSAFXa_8T1dycOyGhdv4_QTVw8y7W91vqwxYOpZkv1jRu03Q>
    <xmx:dKJNZyHWHrUKC58a-wcJShiK22KMCAUWrTNMDBZLCvuXuSlCbx47og>
    <xmx:dKJNZxCorkbqT4FYS-yHorfYVSK6IDCmtXAf4ecis84-wpGAyNshFOP->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e0986d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:45 +0100
Subject: [PATCH v2 13/14] scalar: address -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-13-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

There are two -Wsign-compare warnings in "scalar.c", both of which are
trivial:

  - We mistakenly use a signed integer to loop towards an upper unsigned
    bound in `cmd_reconfigure()`.

  - We subtract `path_sep - enlistment->buf`, which results in a signed
    integer, and use the value in a ternary expression where second
    value is unsigned. But as `path_sep` is being assigned the result of
    `find_last_dir_sep(enlistment->buf + offset)` we know that it must
    always be bigger than or equal to `enlistment->buf`, and thus the
    result will be positive.

Address both of these warnings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 scalar.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scalar.c b/scalar.c
index 87bb30991bf768534a988608d9b194dc8b5ba78a..f24bcd0169cee4f5055304a42954f7bf5df67e48 100644
--- a/scalar.c
+++ b/scalar.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
@@ -380,7 +379,7 @@ static int delete_enlistment(struct strbuf *enlistment)
 	offset = offset_1st_component(enlistment->buf);
 	path_sep = find_last_dir_sep(enlistment->buf + offset);
 	strbuf_add(&parent, enlistment->buf,
-		   path_sep ? path_sep - enlistment->buf : offset);
+		   path_sep ? (size_t) (path_sep - enlistment->buf) : offset);
 	if (chdir(parent.buf) < 0) {
 		int res = error_errno(_("could not switch to '%s'"), parent.buf);
 		strbuf_release(&parent);
@@ -655,7 +654,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 		NULL
 	};
 	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
-	int i, res = 0;
+	int res = 0;
 	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
 
 	argc = parse_options(argc, argv, NULL, options,
@@ -673,7 +672,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 	git_config(get_scalar_repos, &scalar_repos);
 
-	for (i = 0; i < scalar_repos.nr; i++) {
+	for (size_t i = 0; i < scalar_repos.nr; i++) {
 		int succeeded = 0;
 		struct repository *old_repo, r = { NULL };
 		const char *dir = scalar_repos.items[i].string;

-- 
2.47.0.366.g5daf58cba8.dirty

