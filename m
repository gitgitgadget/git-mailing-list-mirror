Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F2368274
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753698; cv=none; b=Q3B/RQmAPB4bJOblYLaR04eaBTKFZoTcHSFiueOsR/MnV/B/GCM1T9TC0SC0PHYYkXluKylkyIoUMqeLfMPXY3oaL2gTa+OxAjIaBukFkZjto/M2CENM0mpUriqBh9OdSuufkdS7zrUGB4d51dZtxbGkzb8Cj5hi+WLrkoajfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753698; c=relaxed/simple;
	bh=mH7knMiqRGdWXojIDQv9fRD1hcp3hVjzCtUUWVBGIiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO9ZIskoFEyW5xicddPhLbL3k1H7APkoDFibYujjBywNPK8CetUG4SLiEZPpS6mNV0ZayOkCWHGY7NdBfXuMpWYjOW3lBtKhnWeHG88OA4CB6v/BmxwyqxvrSenpgDk9RExFYLmQ1PxN8kDftIZ8eVEqyh/OYuD8kBKJP3/xwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G/TrcIdy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ncfIa8Ul; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G/TrcIdy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncfIa8Ul"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B08014001FE;
	Thu,  5 Mar 2026 18:34:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 18:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772753696; x=
	1772840096; bh=O3fgWMuTptEL6MHwKo5uXjxuLK1CkJj6qKWochqf5WQ=; b=G
	/TrcIdygmmb2g2TgrYsZ/RIzp/qErSyv4oqIIQTE3e5ilMIqcoWL9u6PpyY5zK9f
	lA1BYwwLUGC/4sQaVgww09FFnSFFHX9a6AcJd4y3a4j+ohQOhWwnuq1WuK7AvA/w
	x6jrEZ72SFbLPV1U8TunKd4u3wGMjw0STN0R2gROh4N5N1sq8a9meuDof+i6z3B8
	U0CUdoiXk2z/sLuCp53U60adH2ZW3kgHN14l4GN6mOqrwCt/VfPx4qg0qiJyXvcc
	5xluMC/09g0MwnNLJb6r5w2+uX+KNLXBqcR1iVp9HF58yHXUFESSYiaGgau6tVVo
	dQMxK+FOc4/VCgbA35WUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772753696; x=1772840096; bh=O
	3fgWMuTptEL6MHwKo5uXjxuLK1CkJj6qKWochqf5WQ=; b=ncfIa8Ul4L2/pYJi0
	1UYOf/wEHYqXQFPH2IXU18ZpDUoD98TxC5zjnTSjieiv5k0Md+eTWy+7t/pXz9uu
	kjSHY2Ep27fh5oxzvoE6839hEKb5ClGyyyn2UJsnc9bsMBzFvgC7Br0M7uyQdnMV
	Vwftuyr1uXtSMSoz3OT729fNxZe8iEJg0BknGAACjjgFVMD/Z/SOTaRrAvp7IV1Y
	xBer4MHQObwdojR/gIlwWiP6alBaGNY5ew4gESMTCnZ7z6c9mtxuuuVJWgbhuIjs
	mKfBKYqv5oWb9SEZLjYwWvFBcmqHw2o8uj6ZnqnxcHgljzYJmXTk2SGifMpjBuN3
	WEMDg==
X-ME-Sender: <xms:IBOqaUeeqfeRO1SwzqCaEZnIin3OEaHUVaetbmlf9VxnIlMlswb98w>
    <xme:IBOqaUA8ACw3ToDhB_fDfArYFEfs-nKVljvaHs3iMYG7_01gmpGcBZpZsk-tEheJx
    6IZX5MKBtL5AGPqb4U4Elp3eKEKwdng9CI80ff2r_IYvsUk0UOpzg>
X-ME-Received: <xmr:IBOqaf9cfKr7y8dNPA3TIINgZVMzzy3SRkFUCpX6PMIGcn6rGPiEuxbwNcswg-MHQZFdh-bR6vkbab4pOebw4WMDie_w0ZrH-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepiedugfdvleehteduffetkeefffdtffffheehffejheevveejgefhhefgffei
    jeetnecuffhomhgrihhnpehmihhtrhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgt
    hhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    esughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:IBOqaXIAK36WerIyT3emQfvdhRI8baCPa-9ySsE79R1FjnoSvOcLaw>
    <xmx:IBOqaQiwuCeFzq71UY8vEHBt-QGOgVcjpxEu2-b3VBDQ_-to-2leYA>
    <xmx:IBOqaf4JVyq9NUC4NOJedvubTGUZM1WjsnE-klwwyERclXWxnB_Tyw>
    <xmx:IBOqaQYIRFcU9lJqSxFS7bwNWsmVldBqtBG970uDjrXvX8p3li36Ng>
    <xmx:IBOqaVb3XTy44T-ETC2zh500Bq9kAKBCxp6XV7OUwftYeiAzEoA8kLZ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:34:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 1/7] sideband: mask control characters
Date: Thu,  5 Mar 2026 15:34:46 -0800
Message-ID: <20260305233452.3727126-2-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-629-g0c401728ca
In-Reply-To: <20260305233452.3727126-1-gitster@pobox.com>
References: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
 <20260305233452.3727126-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The output of `git clone` is a vital component for understanding what
has happened when things go wrong. However, these logs are partially
under the control of the remote server (via the "sideband", which
typically contains what the remote `git pack-objects` process sends to
`stderr`), and is currently not sanitized by Git.

This makes Git susceptible to ANSI escape sequence injection (see
CWE-150, https://cwe.mitre.org/data/definitions/150.html), which allows
attackers to corrupt terminal state, to hide information, and even to
insert characters into the input buffer (i.e. as if the user had typed
those characters).

To plug this vulnerability, disallow any control character in the
sideband, replacing them instead with the common `^<letter/symbol>`
(e.g. `^[` for `\x1b`, `^A` for `\x01`).

There is likely a need for more fine-grained controls instead of using a
"heavy hammer" like this, which will be introduced subsequently.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sideband.c                          | 17 +++++++++++++++--
 t/t5409-colorize-remote-messages.sh | 12 ++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index ea7c25211e..c1bbadccac 100644
--- a/sideband.c
+++ b/sideband.c
@@ -66,6 +66,19 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
+static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
+{
+	strbuf_grow(dest, n);
+	for (; n && *src; src++, n--) {
+		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
+			strbuf_addch(dest, *src);
+		} else {
+			strbuf_addch(dest, '^');
+			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
+		}
+	}
+}
+
 /*
  * Optionally highlight one keyword in remote output if it appears at the start
  * of the line. This should be called for a single line only, which is
@@ -81,7 +94,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	int i;
 
 	if (!want_color_stderr(use_sideband_colors())) {
-		strbuf_add(dest, src, n);
+		strbuf_add_sanitized(dest, src, n);
 		return;
 	}
 
@@ -114,7 +127,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		}
 	}
 
-	strbuf_add(dest, src, n);
+	strbuf_add_sanitized(dest, src, n);
 }
 
 
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index fa5de4500a..aa5b570571 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -98,4 +98,16 @@ test_expect_success 'fallback to color.ui' '
 	grep "<BOLD;RED>error<RESET>: error" decoded
 '
 
+test_expect_success 'disallow (color) control sequences in sideband' '
+	write_script .git/color-me-surprised <<-\EOF &&
+	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
+	test_commit need-at-least-one-commit &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
+	test_grep ! RED decoded
+'
+
 test_done
-- 
2.53.0-629-gb58d2f6a3e

