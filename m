Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F710FD
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642867; cv=none; b=cTAoN4vsJ1YrT5wvW+j9jLsbRq/eUBt9W5IbRU8t4LA0tSEOUuIWv4LQWFJh4q1MAXW86Yzoe41a1lyPbh92q4oBghdi+fiTObwWK53FYcB0kk3gsiPmN83IKKDDo+/pYa2ZfyRRO7lz4AV8AH1uEo+cCxzDkJIzDO7uB8iiPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642867; c=relaxed/simple;
	bh=/77f4omTlyLDq54fosbHJprjqC7DuDNAXKrfTe22+18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V853NFroPkEt4NiUoiAknKTuad0ssi2YUp2XanrTpWuJii+xO1/fPRiML8/ODCpqFw9d8jMj7mVbvoHzS/SkzTywsdlpEV/1WSxVbLMIpJn3tPD5Y3Vv3OY8Lzl6m/Luquw1VVR/JTed4/G3aCwWbRhBmxUjIHwgVDh9J4+sNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=sgR0NgWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEdXbbVu; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="sgR0NgWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEdXbbVu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 986001D00123;
	Mon,  5 Jan 2026 14:54:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 14:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767642864;
	 x=1767729264; bh=vnwKaBfJ9StIFYNyFF9GPeVoK+9ppS9IkH2FoGWv3FY=; b=
	sgR0NgWOQ390/jGf1eKcX8tgA2LYkPLcSp/Cf78+BHbtJief3xCeDoZG8Uq9obkh
	5ckSLas9xNe+8xoqeSAxU/hI2KI8iiUJy/UEpTNCtHeZ4fYJWHwjGzYbXCwlnT3w
	JqJCGs+UpiGuUspOrMXfdQChz2oX28W3gSFPOF7Bi4KAunjv7eQvi+xKqz4yEJTW
	TIwvetjUt7hPXCk3VLoABPzTTvTpMCHDEvwV4Jwo8vpRceNk3DiSmYIA5ZLlYkmR
	9bDhWoG1fzarVbyBKi1nDk0HB3TaTVyWUKPw1w1cJ+uDpKV7G8T9vTakhwTu7iPh
	pKRbtm6bPsopQDMYdqcABg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767642864; x=
	1767729264; bh=vnwKaBfJ9StIFYNyFF9GPeVoK+9ppS9IkH2FoGWv3FY=; b=I
	EdXbbVuA/wFUoZ5yV4x6rhyRvurHYP7ntz7nDzetiPlRiVijmXkqU5cCEnRRbPsY
	98oKlfKb2tCWKUQ/wC2VVY3/0jY2y/VnnFjIgGRwsAXvU0g2TIamhvwpKsOKHeZO
	HbuQ2UTqniYDN9U7Suh7BGKCc5jl1URXcx1G6veF1A8dfplQEkFCdFgqhQZTgMpl
	FfhSCn0p0Oxaikp/riM0WJVQmPloU4oKE/n4MY3r4+oCslbmnWfjJwt2bSdVvCer
	NGRuw7RRBFpX/IgpG6FMOwE2xM/6NfrWVDnDebzQoMKgKVbhpJ7BFOTwr4eL1REz
	WRFoBymmxWui/NU+QAniQ==
X-ME-Sender: <xms:8BZcaT1Lz8fU7JV14QbPAmd4TmZAtMTXx0bqYQ7_Q7sV_QRqnxUwnKI>
    <xme:8BZcaSxFxyEc4rxpgqyi1AEWwzmeu7znQPoEVuDC7_BJFz0nJoxDAaLQHpqIY9AOl
    i94gbLZ3mfEAuUFG1d4rP9osUMUWx7tJOtBbWu7IejK97g-wJCv4g>
X-ME-Received: <xmr:8BZcaSHQQp4pUZJVOqFJXewyfZlqjFLc6O83Ycx1CJYB_4zjpOj8GqMNA9JB1lLOdWEhmfy6U3ODpN3fTck6LLvvJHwNhEW0CZixPJnXiPkIgzXJf2IaFzbczQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedulecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:8BZcadajKThTmhZYpR5Ir2ucGAe9LGGDAiuSqWH5HulOq9x6rpKQQQ>
    <xmx:8BZcacBhD2RvZoNTY5WkdYEc92FxNjNEv6eWFFRxzUO2C8TyPey2jA>
    <xmx:8BZcadkZyJfjczmPjT4jgPhTqQ_Kp1_0NUsWPswkNZKGpBshV6znPw>
    <xmx:8BZcaVy1BP3BslTKer-CkF5JTAMqOECm4BtDqfm1yfkWk7t6luxziA>
    <xmx:8BZcaU3W22QqAHu4nZlzyCbe2aK7NnkvUoLhtWYpYE5sxr-F7SaoIw82>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 14:54:22 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/6] replay: find *onto only after testing for ref name
Date: Mon,  5 Jan 2026 20:53:18 +0100
Message-ID: <V3_~axonto_after_ref_test.1a6@msgid.xyz>
X-Mailer: git-send-email 2.52.0.383.gb1c58d6b301
In-Reply-To: <V3_CV_replay_die_descr.1a4@msgid.xyz>
References: <V2_CV_replay_die_descr.17b@msgid.xyz> <V3_CV_replay_die_descr.1a4@msgid.xyz>
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

Also add a regression test to protect this error order from future
modifications.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    
    Don’t use a hyphen in “error-order” since that can be confusing.[1]
    
    🔗 1: https://lore.kernel.org/git/CABPp-BE13K1QB42YLv3mLzB9+jUgkMtHNmbs_XWoTsbv2zSYog@mail.gmail.com/
    
    v2: [new]
    
    Fallout of v1. Needs to be moved so that the new error message does not
    “shadow” this one.
    
    See: https://lore.kernel.org/git/xmqqpl85pb7k.fsf@gitster.g/

 builtin/replay.c         | 2 +-
 t/t3650-replay-basics.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6e0fedf1061..8c33a15398d 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -184,18 +184,18 @@ static void set_up_replay_mode(struct repository *repo,
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
2.52.0.383.gb1c58d6b301

