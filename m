Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A042E5418
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107005; cv=none; b=pAle/p8VHD413NRzCIuTuUOLomvoYZKO3yjKOn4PLUZeju0AHU4+18ym/HPrRXHdKX7IiGrX9ULnhB9o2Y7LqjSjZKo1veqXtZGK0isTjhzgVp5Glhl24ddjT9GaK8HceTtQPs1Onu53two4HUyQOJBOCbd0dp/4LE3PzRmKz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107005; c=relaxed/simple;
	bh=mDc3n6jB7lZcY9h48syYl5rwVXdSiAVawMrFvRW+C4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMCPWYWBetF2d5IB0947ONDZVahO/thGbSFCSktbqeOTKPKDCoTcGDtunyZ4Y9WziJttLqOQYs7eQaIvOQzdi2RFN75R/cU+49BOwuxDfbUDOqOn6kWxLnZpgbzGuKBhHADJqskSTHWGsrbGkkVOMIj8FgBU2y0rOUHHNB1Xwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bUw5lt8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mrRm87vB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bUw5lt8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mrRm87vB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BD7761D00067;
	Tue, 30 Dec 2025 10:03:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 30 Dec 2025 10:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767107002;
	 x=1767193402; bh=uIoYBhNepmMLPxQC9n4+UvD+GxtA0CNd04GiFDKSdmQ=; b=
	bUw5lt8m3Z5eDWnJwtMkfJp3NYUpSF5SjdHUGrcOkQGd/se4ZrnuligEFLRS/CiG
	Z2Qs/kMtFw2SegvJCXRe+x6yro+bQ0IVri3IjFBRFUucOOrLa29DRD8JVFO0E7O5
	ZqGPwzp2xMZjIxKMyfMFZMvVGd7yDHsd0wKPz9OAgsWEqEiXcgVcnZKr/fNl6+tL
	+pz/GM0/1j7yal624W24xsyuP6gwquZF6z1y6w0P6LgFT3qLoNFEdgJxypRwxF6s
	hRel3/e2uKb53DHJS+sZjYkpEIs2gcE633GIXNN9qxf+lu4ztdKottpJi8w80NOJ
	MzVtxRuu8fUmvha0EhJBTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767107002; x=
	1767193402; bh=uIoYBhNepmMLPxQC9n4+UvD+GxtA0CNd04GiFDKSdmQ=; b=m
	rRm87vBpguwZ+r20sXOkJwhtk5dtE1GyCyff4HeG1Fm9SQx2dAK5CkkGPPQPwh8B
	ojnEYxwW0wg7KOmw7VfKl69pgn/lmx+9f71/OGhB7xX5OF2kMEs5UpSmE9+ntDMV
	82BDyV5vpLJDXmjEJKzYkxvMZN8bb2tsEAzpZlaujBLynIVHYPLOPW7pA6dG/iJ4
	oVIbduSDbYHGKQs3ZF01pql3xwia8t/X4DLJWNx3Xei3OJ2dvVSCcI0HPZxk6lan
	iSIGJjVh0sPWCD/97Gs5ZMQa5+XzGfaHlHqAiYG5czoIbLNMQY/MIVOcZu+kDIpw
	wiStvN/GlTrJ+eKjpkPFw==
X-ME-Sender: <xms:uulTaX6sKn-NCAr7nHFcUVbC3sYNZ-2XYtDznjgCA1IXETZJBOS3ph8>
    <xme:uulTadkT_FJnQMKalotdPV_aFvca-BOw94hhJeEz-dPxXpkUlzH0Emyrd7Eg7GIIn
    7QeQJPd-YenOFVOVQ2vLfJdua9mv3fsoHJ8TwkOwhKw7a2bEcOHvg>
X-ME-Received: <xmr:uulTaco96pALtQHp23JIEJObBpB9DvBY9DLVyNRLRiJzoLlTR_v7b1fkvCEeWx_isdKErFIuK5ess2ZdbvJSQu31AisDLabcBmQNJ-cPKQlLfstoP919KbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpedulefgueeiueetkeelieefgedufeehteekhfej
    ffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiug
    guhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uulTacsqxZuDEf09_LPWsq8GmlPqaAwNVGWG2fe_HAEOZjCfiMOYjA>
    <xmx:uulTaRH2Y2hiAk4sVBd6yz1yvuzvx5H4YjOJcj76x6qckwHSLcs8UQ>
    <xmx:uulTaVYGuGVdXWi0RD40vmnOD1WN4HRLOaRzwTTcgGMSU31-QEdi4A>
    <xmx:uulTaZW04KMvXw_LWYjjTNa3MRGWKmGMEEGIN3c_4r0BLhdlksxXmQ>
    <xmx:uulTaR1eX7BkGFeeWEgQ6Y5xUKtqCyg4UIQB9p65YeUAA9PoNv4HNBJT>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:03:20 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] replay: find *onto only after testing for ref name
Date: Tue, 30 Dec 2025 16:01:48 +0100
Message-ID: <V2_~axonto_after_ref_test.17d@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <V2_CV_replay_die_descr.17b@msgid.xyz>
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We are about to make `peel_committish` die when it cannot find
a commit-ish instead of returning `NULL`. But that would make e.g.
`git replay --advance=refs/non-existent` die with a less descriptive
error message; the highest-level error message is that the name does
not exist as a ref, not that we cannot find a commit-ish based on
the name.

Let’s try to find the ref and only after that try to peel to
as a commit-ish.

Also add a regression test to protect this error-order from future
modifications.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]
    
    Fallout of v1. Needs to be moved so that the new error message does not
    “shadow” this one.
    
    See: https://lore.kernel.org/git/xmqqpl85pb7k.fsf@gitster.g/

 builtin/replay.c         | 2 +-
 t/t3650-replay-basics.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 54849f65c87..35813140e99 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -184,18 +184,18 @@ static void populate_for_onto_or_advance_mode(struct repository *repo,
 		char *fullname = NULL;
 
 		if (!*advance_name)
 			BUG("expected either onto_name or *advance_name in this function");
 
-		*onto = peel_committish(repo, *advance_name);
 		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
 			     &oid, &fullname, 0) == 1) {
 			free(*advance_name);
 			*advance_name = fullname;
 		} else {
 			die(_("argument to --advance must be a reference"));
 		}
+		*onto = peel_committish(repo, *advance_name);
 		if (rinfo.positive_refexprs > 1)
 			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
 	}
 	strset_clear(&rinfo.negative_refs);
 	strset_clear(&rinfo.positive_refs);
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 58b37599357..7dea62f064f 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -49,10 +49,17 @@ test_expect_success 'setup' '
 
 test_expect_success 'setup bare' '
 	git clone --bare . bare
 '
 
+test_expect_success 'argument to --advance must be a reference' '
+	echo "fatal: argument to --advance must be a reference" >expect &&
+	oid=$(git rev-parse main) &&
+	test_must_fail git replay --advance=$oid topic1..topic2 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'using replay to rebase two branches, one on top of other' '
 	git replay --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
-- 
2.52.0.10.g08704017180

