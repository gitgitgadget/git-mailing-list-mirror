Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9420D515
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141111; cv=none; b=evmSwE2KFNxvoZJcGa+W6+tCpm+FTdN9Dgmx2t+74gXkH8/Alxt7nOT+3nl8ozEVRc2TFCrdhcZcWotfSYshTx1LoI6mLL/kVCePs20wGieIGxDg/FqM50AG+91Q30pnH/jtJdXCSxczidY/A+rKENhxpCZ8y4j5m1EY2/9NHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141111; c=relaxed/simple;
	bh=y8FQbQbsybzkRszw4z0Q7nr5ZJG10Eaf1qFV/jzO/sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRWNSdyLE1+gn5My6m1SU+Q+8MNuPpNAvENu3y+RsE4CSe8w6yghQ1YZ14rxDaGEZCIe9t1KNZyhSYaF+Ru1W5KPedUpy/eZzT3YliykuaB8QdwWiiI/WdevcdK6+QR2MZSMlxp98RiALVnkvp1Gb9eq9O7yMo4ANovZY27e++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vUOYjxVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kkacemvq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vUOYjxVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kkacemvq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A2121140183;
	Mon,  2 Dec 2024 07:05:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 07:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141107;
	 x=1733227507; bh=suVoiW7cBGLiXeZR5Wi4pkUd8RCD0UVV+bHRKtSsX6U=; b=
	vUOYjxVDWQ0WLy+SXGvQc1zu0F1rIbMxZMkZBnnEpoTeDWgT0wkNHgJ8dIFb4GIe
	Gm9ZESOnmyzuuS7y1JNwBBVb8CAT19ttuokjUmWxXjINYUQTBqyqYWISv9XazpaK
	ycrhQj3utUwrD3GVnImo1bl8lrKJwC0WWgBF9uZcwC2IdTdUVCgKJhVStsi3w/En
	Nb8zzyZLujZLQDXKtXJmVbnxfuVy/3KuIAcUKWTYzfYWn623O/DTYKgqG7owRYQH
	vWJewxFEDG7D1Rlk2aReztsGJW6xNob2oG94YSWSbtPi+KO4BCj8d/SZ6zWDC6Ms
	hS0WrHwIVUGtv5b6tHddCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141107; x=
	1733227507; bh=suVoiW7cBGLiXeZR5Wi4pkUd8RCD0UVV+bHRKtSsX6U=; b=K
	kacemvqK11/pXQKM1mxlLHW2By6DC//VfDQ3EkBmOueeBkflzWaXXSqij1FWzFHz
	7Ei5sIrVdSkS7lyOSsUC0W/qHFgOV+oWwyDIb972DvczMkF+Aq1EPqp9G1vahuTY
	3890iDdCEWSKLGvnMpqrMho2osawxw8j48e3HimPatDTEHS4GSxXCl+PTUCxaXTy
	0uZYyZ4LzbxGvAR0lcI2FfShECCAbJULb5NMZsUQr39ZP0CjrhG3LK7ytGQOozyZ
	ZrpNBtEyfwKQTMRTJbrjtUBiwf4xkT5wz6569jT0P06lEpXgF6fWnEukYmHyCAwI
	B6ejiKVGhWKMgtRVjWNjg==
X-ME-Sender: <xms:cqJNZ_wPnfmky2FunPkeyQDw2fi_wF91rv4xHemNizMO6b2qXUv31A>
    <xme:cqJNZ3RSgvAcMf2fmNLioW5Ud-LofEx72c546EzNfNCrRUMHAncrID6aAKaR7T3gy
    4vxM_2GU-R55xDlUw>
X-ME-Received: <xmr:cqJNZ5Wr4Q_BLbdTfTPqHSu634DiWpFcJTy7f703uMR49_B6Bm1C9QkJIO9whwYD4XnEjR93-eGKLON-buCFj97Ge6EVyLCykYEECc7_akzi1YT4YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:cqJNZ5hYfSvhzo4y2DeKiWrSNWfzXVDNzl4BdWSDyE6AHMhyEPr7bw>
    <xmx:cqJNZxANW9rmoB89NA15xZD3b0VQujutyP7MzHlcWaVVFyDD1mbIew>
    <xmx:cqJNZyKMJzI3CfwfWq-HqoXyuQs4YZun0guttXZ4dkbPWxEiX2HujQ>
    <xmx:cqJNZwDIsgD3nYJh3OYFWmvd-2P7cJVdwuMdK5CJyybos4IO8dEYMQ>
    <xmx:c6JNZwOUtEsgaCj3KRcBEpqtuFW-IUOwQduf8V6to0Nw4NN4TdT0FL25>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18b3bf1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:43 +0100
Subject: [PATCH v2 11/14] builtin/blame: fix type of `length` variable when
 emitting object ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-11-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The `length` variable is used to store how many bytes we wish to emit
from an object ID. This value will either be the full hash algorithm's
length, or the abbreviated hash that can be set via `--abbrev` or the
"core.abbrev" option. The former is of type `size_t`, whereas the latter
is of type `int`, which causes a warning with "-Wsign-compare".

The reason why `abbrev` is using a signed type is mostly that it is
initialized with `-1` to indicate that we have to compute the minimum
abbreviation length. This length is computed via `find_alignment()`,
which always gets called before `emit_other()`, and thus we can assume
that the value would never be negative in `emit_other()`.

In fact, we can even assume that the value will always be at least
`MINIMUM_ABBREV`, which is enforced by both `git_default_core_config()`
and `parse_opt_abbrev_cb()`. We implicitly rely on this by subtracting
up to 3 without checking for whether the value becomes negative. We then
pass the value to printf(3p) to print the prefix of our object's ID, so
if that assumption was violated we may end up with undefined behaviour.

Squelch the warning by asserting this invariant and casting the value of
`abbrev` to `size_t`. This allows us to store the whole length as an
unsigned integer, which we can then pass to `fwrite()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f0d209791e44025b1965cd447cf4fc1e2ca5f009..94aaa5eb1d2f410274cc5cef1b242f247bf48c1f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -6,7 +6,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
@@ -468,9 +467,14 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 		reset = GIT_COLOR_RESET;
 	}
 
+	if (abbrev < MINIMUM_ABBREV)
+		BUG("abbreviation is smaller than minimum length: %d < %d",
+		    abbrev, MINIMUM_ABBREV);
+
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
+		size_t length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
+			the_hash_algo->hexsz : (size_t) abbrev;
 
 		if (opt & OUTPUT_COLOR_LINE) {
 			if (cnt > 0) {
@@ -501,7 +505,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			length--;
 			putchar('?');
 		}
-		printf("%.*s", length, hex);
+		fwrite(hex, 1, length, stdout);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)

-- 
2.47.0.366.g5daf58cba8.dirty

