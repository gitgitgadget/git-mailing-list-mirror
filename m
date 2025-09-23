Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EE31DDAB
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617727; cv=none; b=l+qwH54ypoOjLA9zqmLNY3ECfLV7aCaI5tebEfHE9IKCBTwGjwGxaargLbBEzGAn9A4S8DrRGiWfyyQaNisLUCvjw1GCUObR9MnQRK4pYBtnyYeFrRBrRs8aiLwje6/4rN4XudZoACWY67Y+a8e6ji5JrNkdFuglO9iCR6G7isg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617727; c=relaxed/simple;
	bh=vh/DheVy++xhayr5CU8PrsU1x/qcil0mUgTQcfjCyDE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=McUaKkFgoo/d3453ppcwn+eS9McLb1HxEdJrTEBWgInBF/RiKzsh1+XMCJrW7teE8uxO6Ks9lV1f03/dq9u/BBFnvOAy94U5Jz6HyzzHyoyxeinb01docO2OxlmquOP1nplZT5cTPKRR9pCcwADnaNBn9E6qYzjxN7UNpyHWmiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk; spf=none smtp.mailfrom=git.strova.dk; dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b=qHdMJN4y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4vuI83g; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b="qHdMJN4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4vuI83g"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70C777A02D3;
	Tue, 23 Sep 2025 04:55:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 04:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=strova.dk; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1758617723; x=1758704123; bh=8i
	0A6N8isK9ISZBjR3CykOSIsJEU4T8dyN1hQ9yE8B0=; b=qHdMJN4yBnVeNjixrW
	K/uNpuLX0uxbvpYSy37hI2UdxWCSkowX38eAAjLinF/zeYCs+1x679KawVtNofZ2
	pR5T0E6JhxeEPO/7+m0KrypV8Gklj/6PepoXnh5x83isPSJg/6mQLJCIkbjZXcse
	Qxb23g/7w1rjuwu1Enz5ueSvVGPKKYk0lNKTIVnud/wloIqbW+CnSBHVBHoYFRjl
	LaMCjuU1isFN9J3ua5MNQT41P7wxNKuHNvNb5a3MrnVHrm09jb5wyvtMAP/GKJV9
	ur11llgM6bw5yoqYOURqjUpyXCORr+7KtL9DiPDObfgKF/50CZ/nGgC2nJUnB9g/
	BjEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758617723; x=1758704123; bh=8i0A6N8isK9ISZBjR3CykOSIsJEU
	4T8dyN1hQ9yE8B0=; b=B4vuI83gDYsTZyCG/AN7z7pzHcTa43IWy06zhxif1+mx
	8YEicHmCto9vrRuTBwYh9UxWo5iOaqyyXrzNeZ6soAnv2mxR3zNVygvQ2iMO3T+q
	+0ZelaYRQZnTEhlw7RVNCTVTlE9XRs5FJ0taNWaWlKoGII43KFwY1a7m08ABZ+m6
	mNGHRqS2toHHVgv2oZErLTa4RCopVv8kZIuXG1zrC7hPYKxxaqkdfDx8xDKN+e0/
	WkYkq7F7h9S5QpBgi0UOoyYotB9/ILi1veScgNspdyD8kBrUqD7GzVmXCXbv9OIS
	TLNp+y/RCJHCXrMD3bSWPM3+oPQNVsriw01EU6r0Ag==
X-ME-Sender: <xms:emDSaENCRpOaa1BIgNl-3HzH3DkqWbqEZs3jT6-OkrakW9yPdE4v1g>
    <xme:emDSaFw8xd9t_u55B387u2WBg1a3GY_yPAlmg0IE_nYQABm2wP4xS9gdXawi8KMsK
    jvQn2cq7wtrxiKmO7FdawA9UMElA53wBvV2rZ97naamK__TFkbEYOmD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdforghthhhirghs
    ucftrghvfdcuoehmsehgihhtrdhsthhrohhvrgdrughkqeenucggtffrrghtthgvrhhnpe
    dugefhteetgffhkefgleetgffguefhheefhffggedugeegieetveeileetieeiieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehgihhtrd
    hsthhrohhvrgdrughkpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:emDSaHx1gapTHPtjCpawgLc4AQylzPQA-qNHgHVYX-esKjWaVVdDjQ>
    <xmx:emDSaPbujclUPD4V0orx3Jjza_gIjfErcwNWneU3B4e_noKf_Ov-5Q>
    <xmx:emDSaJTMumL7iM3cBnDIgA8sqJBuGDPS2-70K6s9GhEkRP7fww218w>
    <xmx:emDSaJzT9DAPI_YjpxtVPPgZk2p3E6WRU-Yz5xOpQN5BoLOb7TXCGQ>
    <xmx:e2DSaLLCzdfIFJSPebjx_ffFi8cP0ClQX0F6iZNl3tKoHvz5RgTOfztv>
Feedback-ID: ic5d648a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDD7E70006B; Tue, 23 Sep 2025 04:55:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 10:55:02 +0200
From: "Mathias Rav" <m@git.strova.dk>
To: git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
Subject: [PATCH] rebase -i: use same commit's message and date with f -C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In `git rebase -i` with the fixup command, the -C flag controls whether
the commit message is taken from the previous or current commit,
but currently the author name, email and date are always taken from the
previous commit. The fixup command is used to squash two commits where
one commit has a good message and the other's message does not matter,
and it is usually also the case that the commit with the good message
is the one that has the good authorship information; the other is a
fixup commit that was presumably made by the user moments ago, whereas
the commit with the good message is the one whose date should be kept.

Most of the time, a fixup commit is made on top of the commit to be
fixed up, in which case the rebase -i fixup command is used without -C.
The fixup -C case arises when an earlier commit in the branch is split,
leaving part of the commit to be squashed into a later commit, in which
case fixup -C would be expected to keep the date on the later commit,
and discard the author date of the ephemeral newly split commit.

Change the behavior so that fixup with -C takes both message and author
from the current commit, instead of taking the author from the previous.

Tweak try_to_commit to allow specifying author in addition to AMEND_MSG,
and pass author from the current commit in do_pick_commit in `f -C`.

Tweak the help text in `git rebase -i` to reflect the changed behavior.

Add a test that ensures that the author metadata for the second current
commit is kept, and remove some author metadata checks from other tests
that now fail since the author metadata is different (as intended).

Signed-off-by: Mathias Rav <m@git.strova.dk>
---

I described my own workflow for fixup -C above,
and it's the only use of fixup -C I'm aware of.

If the current behavior of keeping message from one
and author from another is useful in someone else's
workflow, then I'm happy to be enlightened.

Correct author dates are certainly more nice-to-have
than need-to-have in most git workflows, but I think
it's worthwhile to have git go the extra mile here.

 rebase-interactive.c            |  4 ++--
 sequencer.c                     |  5 +++--
 t/t3437-rebase-fixup-options.sh | 15 ++++++++++-----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 809f76a87b..dd303168c2 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -53,8 +53,8 @@ void append_todo_help(int command_count,
 "s, squash <commit> = use commit, but meld into previous commit\n"
 "f, fixup [-C | -c] <commit> = like \"squash\" but keep only the previous\n"
 "                   commit's log message, unless -C is used, in which case\n"
-"                   keep only this commit's message; -c is same as -C but\n"
-"                   opens the editor\n"
+"                   keep this commit's message and date; -c is same as -C\n"
+"                   but opens the editor\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
 "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
diff --git a/sequencer.c b/sequencer.c
index aaf2e4df64..80209b6b07 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1560,7 +1560,8 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		if (!author)
+			author = amend_author = get_author(message);
 		repo_unuse_commit_buffer(r, current_head,
 					 message);
 		if (!author) {
@@ -2419,7 +2420,7 @@ static int do_pick_commit(struct repository *r,
 			strbuf_addstr(&ctx->message, oid_to_hex(&commit->object.oid));
 			strbuf_addstr(&ctx->message, ")\n");
 		}
-		if (!is_fixup(command))
+		if (is_fixup_flag(command, item->flags) || !is_fixup(command))
 			author = get_author(msg.message);
 	}
 	ctx->have_message = 1;
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 5d306a4769..2361d3fb78 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -85,6 +85,15 @@ test_expect_success 'simple fixup -C works' '
 	test_commit_message HEAD -m "A2"
 '
 
+test_expect_success 'fixup -C keeps second commit date' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout --detach A2 &&
+	get_author HEAD >expect &&
+	FAKE_LINES="1 fixup_-C 2" git rebase -i B &&
+	get_author HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'simple fixup -c works' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout --detach A2 &&
@@ -105,9 +114,7 @@ test_expect_success 'fixup -C removes amend! from message' '
 	FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
 	test_cmp_rev HEAD^{tree} A1^{tree} &&
-	test_commit_message HEAD expected-message &&
-	get_author HEAD >actual-author &&
-	test_cmp expected-author actual-author
+	test_commit_message HEAD expected-message
 '
 
 test_expect_success 'fixup -C with conflicts gives correct message' '
@@ -181,8 +188,6 @@ test_expect_success 'multiple fixup -c opens editor once' '
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i A &&
 	test_cmp_rev HEAD^ A &&
-	get_author HEAD >actual-author &&
-	test_cmp expected-author actual-author &&
 	test_commit_message HEAD expected-message
 '
 
-- 
2.51.0

