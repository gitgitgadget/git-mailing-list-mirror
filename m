Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B09201100
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488154; cv=none; b=Q9V6/kvNTYLL9CceXxpcJEygihwtMx9JXOlkIKCLIgMmH80W8FsHRAtR02tpaardD/tqTVZjrIroVhFDGV0ng9yhyLeqR7sD1oxdPrJsyG0IdSiHiCrHOyq2Ign3TrRWZei78fG3Z1zYNzCFYTzGQIEn4nCg+Uld090FPxm+xao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488154; c=relaxed/simple;
	bh=5SrqF/oV2IHezEwrejCizKoBAAo3semCOuidP2+j40A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=rS9TVye9PYM7iawcxRDGVgTkA4VBLAaiS1H4l+NQBb5a2s+jTqRKDa6GSwdLxWtnker70epfaQ5PcxOyDXjUOultEL7zeVmz37GNDg4PgYjHQlU1v8s+Hh8rNWFiOiyvihLJvdcDXTSMm9Zk+AsrsExb7SgONP6XIlsRETaCuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fMCiyXZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j0Bi8GZ0; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fMCiyXZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j0Bi8GZ0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACCBE25400F5;
	Fri,  6 Dec 2024 07:29:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 06 Dec 2024 07:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733488151;
	 x=1733574551; bh=6IMem6yT9cZnt/nh4omPNrPftJeACzRPGh0M5RYPbCU=; b=
	fMCiyXZxoxoMY47dFHQmcpp2MG4ZV+0Rkv4R18U3ZIa4LM8lQLCFKTxF6a05GWFz
	AYW2FGKP3s4gtb5c6SeIhTalOsw8p6Mj6DXZ03EY4W0btIUV+55xb9DvI904I7Wo
	1UexYaUnEEr2+3BuhQzQhjwyouQF+Xn0MTJCWEP3glaqx69vE3QqdzElANRX5+nE
	6llnoUldnLMHcbRzhZRTcDBOtMli798gFWNWdz+pVvs0GL2X1M9w8dmGLGa8cXuI
	xlfCCoJs7fKKYRE1jM/zyU2nFOtYnFVzj7M+1AmVFUrSdgwG2yTLj7DL+WYpJ2Em
	J+HXPqSW7XWJRWE40UKyrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733488151; x=
	1733574551; bh=6IMem6yT9cZnt/nh4omPNrPftJeACzRPGh0M5RYPbCU=; b=j
	0Bi8GZ0lOrwYtUxe9xRFPBIW58QQ1cdw6DWCS7iLm4d/qCGRf6rfHECqeo4eAY7/
	QcilORpkMV/iW5pHzQ+VMGyW3gyVm74ojBx4gKxA9t8BFnPXYhiv+5vy4sgJrV3U
	sjXF9ADDkgLQMeZFghKCcsNWppcaw9CuxoZl3s7XcOlSOvyMuSyim59blKSHZXXr
	GKLXNkjXmfGgTKm27NhX52voRVgRWB5VmvCNH52zR6jbrYxqbusOsBUD8o7aODmL
	R6Yzpf+K6/A4Kny5SVFjXkRkMdIAHOh1ny5nWzL6AP9QfLPEwEK7/WaPAzZRxUqb
	+gKNuecFOXId2POF9/Ifw==
X-ME-Sender: <xms:F-5SZ7w3HF5kqegFYIlgUSOv6iLpyATKwaZulLr4Y7pgyTrNTkLkoA>
    <xme:F-5SZzS_XB0-WNfoNwEMssjJb6o8wtPqhEEza4lZMqVFBPbO4WJ6LN9vhDMIMoR1J
    sZLG3MBUYp4HBkkIQ>
X-ME-Received: <xmr:F-5SZ1V5lifisJp3yV3YNDHzaVfOSWga1FWtv_KwUKF8Bw3Yx6Pj8q0SYR3ZH-q9R8LAn8_5jmgV28aHXUfjutmg5J5j3mIjZ1pMAPpqG-z_XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepieduvddvfeegudfhteegueffjeelhfekheefkeetueet
    leehuddtieefkeettdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrg
    hrnhhisehvrghlohhhrghirdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:F-5SZ1hzU-Ea3p1xjYRZQ2uobGmkxU7fseEtKTgbCdM1A36Q8iqv-A>
    <xmx:F-5SZ9DwjMug65-MtCd7mSlkFbuK5f3Yizl3TzbtEhbfVPlYe1JaLg>
    <xmx:F-5SZ-IEBCwxoOFWyRQ1k03QFhwnB2R5D5mM2iiEd6io8cuhhBQFgQ>
    <xmx:F-5SZ8CxDkme9C1tdi6maO7b6xH1r5avOf3BJnR57yecx3rj17s6xw>
    <xmx:F-5SZw4FiGNhWTRuKl72u8khwL-XrPhIdliucalgEehMJX2O4lAA_WCs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 07:29:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 678a819e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 12:27:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 13:28:54 +0100
Subject: [PATCH v2] object-name: fix reversed ordering with ":/<PATTERN>"
 revisions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-rev-parse-fix-reversed-list-v2-1-190514278ead@pks.im>
X-B4-Tracking: v=1; b=H4sIAAXuUmcC/42NQQrCMBBFr1Jm7UgSkkhceQ/pIpipHdS2JBKUk
 rs77QnczRve/3+FQpmpwLlbIVPlwvMkYA4d3MY43Qk5CYNRxmqjPC6PgiLiEnMhHPizEcmd8Mn
 ljWoINhoVvfYOpGXJJNK+cO2FR5Hm/N0Hq96+/3dXjRqDi8E7b6NNp4skjvyCvrX2A8FbqnjLA
 AAA
X-Change-ID: 20241206-pks-rev-parse-fix-reversed-list-0f94a20a6165
In-Reply-To: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
To: git@vger.kernel.org
Cc: Aarni Koskela <aarni@valohai.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Recently it was reported [1] that "look for the youngest reachable
commit with log message that match the given pattern" syntax (e.g.
':/<PATTERN>' or 'HEAD^{/<PATTERN>}') started to return results in
reverse recency order. This regression was introduced in Git v2.47.0 and
is caused by a memory leak fix done in 57fb139b5e (object-name: fix
leaking commit list items, 2024-08-01).

The intent of the identified commit is to stop modifying the commit list
provided by the caller such that the caller can properly free all commit
list items, including those that the called function might potentially
remove from the list. This was done by creating a copy of the passed-in
commit list and modifying this copy instead of the caller-provided list.

We already knew to create such a copy beforehand with the `backup` list,
which was used to clear the `ONELINE_SEEN` commit mark after we were
done. So the refactoring simply renamed that list to `copy` and started
to operate on that list instead. There is a gotcha though: the backup
list, and thus now also the copied list, is always being prepended to,
so the resulting list is in reverse order! The end result is that we
pop commits from the wrong end of the commit list, returning commits in
reverse recency order.

Fix the bug by appending to the list instead.

[1]: <CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>

Reported-by: Aarni Koskela <aarni@valohai.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
This patch applies on top of v2.47.0, which is the first version which
had this regression.

Changes in v2:

  - Include the message ID of the report in the commit message.

  - Fix terminology used by the commit message.

  - Move the test from t4208 to t1500.

  - Link to v1: https://lore.kernel.org/r/20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im

Thanks!

Patrick
---
 object-name.c        |  4 ++--
 t/t1500-rev-parse.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index c892fbe80aa7173dfcc1995de5a75bc322c6adb7..34433d2a01d6a23ce6b4ca19b85c53b7b82fd0e5 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1401,7 +1401,7 @@ static int get_oid_oneline(struct repository *r,
 			   const char *prefix, struct object_id *oid,
 			   const struct commit_list *list)
 {
-	struct commit_list *copy = NULL;
+	struct commit_list *copy = NULL, **copy_tail = &copy;
 	const struct commit_list *l;
 	int found = 0;
 	int negative = 0;
@@ -1423,7 +1423,7 @@ static int get_oid_oneline(struct repository *r,
 
 	for (l = list; l; l = l->next) {
 		l->item->object.flags |= ONELINE_SEEN;
-		commit_list_insert(l->item, &copy);
+		copy_tail = &commit_list_insert(l->item, copy_tail)->next;
 	}
 	while (copy) {
 		const char *p, *buf;
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 30c31918fde6539d52800e18dfbb3423b5b73491..42c4a63cb95eed781ed7d3029c4ff5e600e6f8b8 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -310,4 +310,19 @@ test_expect_success '--short= truncates to the actual hash length' '
 	test_cmp expect actual
 '
 
+test_expect_success ':/ and HEAD^{/} favor more recent matching commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit common-old &&
+		test_commit --no-tag common-new &&
+		git rev-parse HEAD >expect &&
+		git rev-parse :/common >actual &&
+		test_cmp expect actual &&
+		git rev-parse HEAD^{/common} >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

---
base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
change-id: 20241206-pks-rev-parse-fix-reversed-list-0f94a20a6165

