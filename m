Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337D2376FF
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034700; cv=none; b=ql3jP5HJq1GIBHccUBIeE+dvDszCkbxPELtjYw4T6oBERcuL1ZiAWunD2iqEi7LDsgBYC9p32quVcT5NlsqMtAcpq+E4yrldJ/nIH4WdzJN/kFyvlkCg6n9M/+w7V0qztEepUCzRUV8BzI8U55KqTFIweaQ1uC5/h91tgDGMQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034700; c=relaxed/simple;
	bh=dqAMH+kSufR10uAmHxIB3H/tcArpRKRplQRz6+DCFM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pglg3t6WHp5zsAsu7ffcZKevjLyooXjs+eokRquvxFD7Zh8OnsIVV+7+WGn9qRFkeMO7Ngrm6Poqh1lJGLRW/o0E9+F8gbhXELesQFIxq+Q8LAj0EA8pC/Z47IdpA2qbUMJCGXRBnbtXQvFAUi5x+2EBOXhkzOzGLXfnV8wZmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HJ1BNzOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYGtRvyh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HJ1BNzOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYGtRvyh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A753F1382C57;
	Mon,  3 Mar 2025 15:44:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 03 Mar 2025 15:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034698; x=
	1741121098; bh=VNVvS2piLfKP5ecjh0t66vnnGkRaPwaqk84orWwZ+IA=; b=H
	J1BNzObFMGWpyK3PS44xwyoQ/5oknFXmileuonU6lbtlGtDUh9Ks8H7vuMO/l1bp
	wlBoCaTdC4CH2E3YCJkOsiMe1AmoVqHmGK3sbm/d83YsuujgOim62Bz3gguIQAzE
	ddkHkGs5HkN2iy3hb28QzSq62do4t6NVo8geaLCMDv629CNWrttM00xZ+xKP9BNW
	FNqleEGPRzGPppKWJO1hm3JALXpe3iy5KjxFLRjk1Xb2ia1jVG9IVaSvif8mbNzi
	225wuwVypsJEIWfZdkTW2wKu0jxE/9rDGemmzDZgWfZ68NBo4TJTUi1Xi+sRA3yG
	gUEACVLb9Q3oo6Djtp/Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034698; x=1741121098; bh=V
	NVvS2piLfKP5ecjh0t66vnnGkRaPwaqk84orWwZ+IA=; b=PYGtRvyh1jF7H6Laz
	dJ80Ng7IAGmhb4g0j1edACP8rHaaO7Hfo04GJDkT83xbquKy9imxSXIYVnVkEScN
	YKUCNPsHZgugJvKktsMZf8ehrTBQPGBmrQh4YXZhywFte+5++zFKZr+/Pq2aGMsj
	or8vKJLOBebRWmFPBe/GWN6m+kMZD6WP/wWAn/Jo22LSpgOGG4RqJkkuLCqtB2YX
	QeyCKY+cKlbPS+D84BZU5Yc+YLwOIwi+VmJvNvtkhaX8vOz8jhyCQodxZfUCIn9k
	adxVZy0nw5+584jgSBimiGWR1Qq3sFyBi61JdD4Rswm7mF/L3tMDMZGfvsNj2Ju5
	PMASw==
X-ME-Sender: <xms:yhTGZ4KOQm6agUzDop7Yl3aosi_xZUL87YnrARXT1u-lSQVkep8nlg>
    <xme:yhTGZ4KVLSI7787i5TKx2cFh2J1GnV3QuysTwfdI7WtIm6szcCa98Tdt3mb4uQBkR
    B6bUo-UR-E-AoFjVQ>
X-ME-Received: <xmr:yhTGZ4vM8wiidTfcuO9vjAHIGZkDf09TtFK6-9j8BJCyKKxWUxGh0zYa8_YtaztWUkUqb4xtNYh5fduVafRd2Ck_OcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeehiefhge
    evtefguefgffdugeekvdehledtfeeuteeilefgveegueekgeejtefftdenucffohhmrghi
    nheprgguohgtrdihohhupdhtgihtrdhlihhkvgdprgguohgtrdhlihhkvgenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohig
    rdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:yhTGZ1ZlmjgNkFpDIuRkLfpwN1yEpzuX7nZ_jZOjAnYF76_nT4Is1w>
    <xmx:yhTGZ_YtVAzJnqVfmZLcYYVexznply01inwxWLyqEjsRnaqjjdxOdA>
    <xmx:yhTGZxAy0RQ1jOidye50OPlaWxnXooqWweEaBaornSk0shvniZBW0w>
    <xmx:yhTGZ1ZCakmDqjB-LJM7295InPcWjvXZj8HCDQLm9d364vts8JrseA>
    <xmx:yhTGZ7HJB68Vm60lyazEH-7_wEA5cGeQAel5T3HtdyqKDjyzhWL_sIam>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:58 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 07/34] MyFirstContribution: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:05 -0500
Message-ID: <20250303204443.360595-8-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/MyFirstContribution.adoc | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index e41654c00a..afcf4b46c1 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -21,7 +21,7 @@ This tutorial aims to summarize the following documents, but the reader may find
 useful additional context:
 
 - `Documentation/SubmittingPatches`
-- `Documentation/howto/new-command.txt`
+- `Documentation/howto/new-command.adoc`
 
 [[getting-help]]
 === Getting Help
@@ -331,7 +331,7 @@ function body:
 apply standard precedence rules. `git_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
-about how to use `git_config()`) in `Documentation/technical/api-config.txt`.
+about how to use `git_config()`) in `Documentation/technical/api-config.adoc`.
 
 You should see that the name printed matches the one you see when you run:
 
@@ -461,10 +461,10 @@ $ ./bin-wrappers/git help psuh
 
 Your new command is undocumented! Let's fix that.
 
-Take a look at `Documentation/git-*.txt`. These are the manpages for the
+Take a look at `Documentation/git-*.adoc`. These are the manpages for the
 subcommands that Git knows about. You can open these up and take a look to get
 acquainted with the format, but then go ahead and make a new file
-`Documentation/git-psuh.txt`. Like with most of the documentation in the Git
+`Documentation/git-psuh.adoc`. Like with most of the documentation in the Git
 project, help pages are written with AsciiDoc (see CodingGuidelines, "Writing
 Documentation" section). Use the following template to fill out your own
 manpage:
@@ -543,7 +543,7 @@ Try and run `./bin-wrappers/git psuh -h`. Your command should crash at the end.
 That's because `-h` is a special case which your command should handle by
 printing usage.
 
-Take a look at `Documentation/technical/api-parse-options.txt`. This is a handy
+Take a look at `Documentation/technical/api-parse-options.adoc`. This is a handy
 tool for pulling out options you need to be able to handle, and it takes a
 usage string.
 
@@ -1088,14 +1088,14 @@ This gives reviewers a summary of what they're in for when reviewing your topic.
 The one generated for `psuh` from the sample implementation looks like this:
 
 ----
- Documentation/git-psuh.txt | 40 +++++++++++++++++++++
- Makefile                   |  1 +
- builtin.h                  |  1 +
- builtin/psuh.c             | 73 ++++++++++++++++++++++++++++++++++++++
- git.c                      |  1 +
- t/t9999-psuh-tutorial.sh   | 12 +++++++
+ Documentation/git-psuh.adoc | 40 +++++++++++++++++++++
+ Makefile                    |  1 +
+ builtin.h                   |  1 +
+ builtin/psuh.c              | 73 ++++++++++++++++++++++++++++++++++++++
+ git.c                       |  1 +
+ t/t9999-psuh-tutorial.sh    | 12 +++++++
  6 files changed, 128 insertions(+)
- create mode 100644 Documentation/git-psuh.txt
+ create mode 100644 Documentation/git-psuh.adoc
  create mode 100644 builtin/psuh.c
  create mode 100755 t/t9999-psuh-tutorial.sh
 ----
-- 
2.49.0.rc0

