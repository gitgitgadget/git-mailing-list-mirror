Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC91D5CCF
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149514; cv=none; b=oUje66akPIjPALwVwPaFQb8JWEhvlFjzY5T+qpvXindxJPds9RI2ZeloE/1WUIV+dQ2x13QqUnIy2ohAKVVWAmlIPHWBCIIwJ8Lu2LafP40C3VbMeB6TRsEgETFUkaTvghhq8Ye2V6gH8XY2P1O8FAjVCJe0SdBop6VBn3hd5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149514; c=relaxed/simple;
	bh=Pjp/Akb0yAkDReFNwRziEOlEnjdgi3qrm35LHHDOiEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dN7KaGcft+yEMgsYcyIS0HpL75FNABqEQv9wemsc3X0JYCKKuDhkkXAilkU0ICCpVbKZmcq9Ak5a36skGtKZnrlvDESIiAmtdBV+XuPBh3HITsvYq21zT4fnto4mAQf/OmMsVHFyBEKOxKWi5wonEX6C5NncEm4EzeeJZqGaTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BKkZPCRT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7Y5kgAC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BKkZPCRT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7Y5kgAC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AC5891380167;
	Fri, 17 Jan 2025 16:31:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 17 Jan 2025 16:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737149511; x=
	1737235911; bh=DUzw/oduyEmFtRe3OQUnTm5Tg6xmLPqs7CYeTK7vbCI=; b=B
	KkZPCRTP8GBdRkA5A8wT3DC3V3SGCR9LFNuGX2YvjJ5rVsTjiJo1HmmWOtGUYlta
	4hPMurasYwZQC3nX/9Ordak0gOE/f8n0wN3zEgKrVCMJcUWPtEIDfmz4rKWSCZFP
	85qvG9nnT6MSZCuaDklE9bbUrgyUKvbzNJNSbjaCSjDqtSYgy7EROYtDrcRt+byV
	uWxgIHZLG8ZOfsjezRph3k78bEDfP9CTKfVORu0cnNRfaydY4srxAMdznhkMDuYG
	0m9ugpyfESLfwyqRRJwlysKUTkikeDQVoq9S1kBPfSKsDwPN1BlPd1huHFIJdAQn
	IuZxnTyowyUtHboeZxUVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737149511; x=1737235911; bh=D
	Uzw/oduyEmFtRe3OQUnTm5Tg6xmLPqs7CYeTK7vbCI=; b=k7Y5kgACukE5ImBau
	tl0Tri6GzdJbpXkYk4mTKX781iuRgAB3MwuaT2oXazJErAOlq+iQyOpgrkTE5gPx
	uDVU8PbgCCXDdgvftKf1mZplHPZ1nOPQ+Ds3wTjX+ldhwtylY01x2Htgh/QbLSCC
	uti+GPVJwMQUcWChHM+4+UZ2efGdQjNCzzgV7k5KLUqo7VAOQnLJL99hlhPvFBSb
	kw9UlMoz/rRDPfBErciNngdqBX+9vACMnyJy7F0C7j/zfcwKwk8BPXBfmuDj3wHN
	As4eGWMWptCWWD1/+fR9A7G/ifogiEssvCjCJlYrZXAIeirstIUqbQqyPwaOMKSJ
	DlfXQ==
X-ME-Sender: <xms:R8yKZ10kIfAWWvnkrQhZl5psqD-x8NpAJfm982Vazm5OTe4o-ubW-w>
    <xme:R8yKZ8Elenhg61QZZW6YyqtN5Y0Gx8_V0RC3gZoPM27XqSY48XsJFNp1o2HDgHUGu
    VB-VgcoDI0szQaNEQ>
X-ME-Received: <xmr:R8yKZ17ROS1G3BPUfgCOUzxysHtuLndBPpeOK7nvItsVZ170Xv37zmxTFq9C6buNK2rPhGbdMHJQ-tJpRLDSXVyPXhRe1754cL2j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudegkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:R8yKZy0FRP_bKvhVyt1vD_SlgVFgEd4j3jL947fXbrveRrbhXfHDRA>
    <xmx:R8yKZ4FmXNSGZMd9Yj3uYdzwnqYQ_t6bF7Y73qnQaVTORP7IQX2udw>
    <xmx:R8yKZz8nQk0I1YThHxJr3GP4ZjQD5Y2yDgoMWBwf1raimEVvy1zsOw>
    <xmx:R8yKZ1nhHpfvjGEVVQToWl3-V0aOmHDKt29FXDiKpPK3kdwYmZVCDw>
    <xmx:R8yKZ8CVqr6hO7cHJU7dCh7S0-d1e95LI1aJCDXfMskltjVqQN61xfih>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 16:31:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v5 1/6] t0012: optionally check that "-h" output goes to stdout
Date: Fri, 17 Jan 2025 13:31:43 -0800
Message-ID: <20250117213148.3974552-2-gitster@pobox.com>
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

From: Jeff King <peff@peff.net>

For most commands, "git foo -h" will send the help output to stdout, as
this is what parse-options.c does. But some commands send it to stderr
instead. This is usually because they call usage_with_options(), and
should be switched to show_usage_help_and_exit_if_asked().

Currently t0012 is permissive and allows either behavior. We'd like it
to eventually enforce that help goes to stdout, and teaching it to do so
identifies the commands that need to be changed. But during the
transition period, we don't want to enforce that for most test runs.

So let's introduce a flag that will let most test runs use the
permissive behavior, and people interested in converting commands can
run:

  GIT_TEST_HELP_MUST_BE_STDOUT=1 ./t0012-help.sh

to see the failures. Eventually (when all builtins have been converted)
we'll remove this flag entirely and always check the strict behavior.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0012-help.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 1d273d91c2..9c7ae9fd36 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -255,9 +255,16 @@ do
 		(
 			GIT_CEILING_DIRECTORIES=$(pwd) &&
 			export GIT_CEILING_DIRECTORIES &&
-			test_expect_code 129 git -C sub $builtin -h >output 2>&1
+			test_expect_code 129 git -C sub $builtin -h >output 2>err
 		) &&
-		test_grep usage output
+		if test -n "$GIT_TEST_HELP_MUST_BE_STDOUT"
+		then
+			test_must_be_empty err &&
+			test_grep usage output
+		else
+			test_grep usage output ||
+			test_grep usage err
+		fi
 	'
 done <builtins
 
-- 
2.48.1-218-gc7e8be6a8f

