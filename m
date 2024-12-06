Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC120B219
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499934; cv=none; b=cPvMuE3oqwg/bkuDFG8RG99msqU0gUDTThGQ2tk7PNZiBfWnZQnAomGuRjjIY83KcWiomlUtjvsKcrs6equLVs2ObmuX86lUzvIsxslujsfeOE+7BGSzEPREBHNp1fQsrx9oBqFXHEVASGy0WTPMCW9ECpQvGB+d14RbZuBmomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499934; c=relaxed/simple;
	bh=F0b9a9n0s93L7NZyMuWZm3BCIFzwtU/qoxi8YaH9bws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=Mw9h0wXUEPyvFPbgu9tl3Vp9Bs5hjYcSHIY5NjR0SDwSE9OoLAPCH9BQDf0n+irV5EJWNbIamWdKSLicRGy0Du10c24eXPHDz6hNm0NMzDB3eDRDB31+1q1Bl9t+2Xi6OzXIkjmRDmhn7PhQQ0pcamwZJ5JMhRFH71XSyHcF+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CkQvll/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kl6dHvW/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CkQvll/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kl6dHvW/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FAFC254015B;
	Fri,  6 Dec 2024 10:45:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 10:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733499931;
	 x=1733586331; bh=ta8WDzI+gHDFJhvicv0r0Ez6UT0cNBzl72Nt+2cdMhg=; b=
	CkQvll/OiJdSn9xqxImevFgoiFRDothtkAaujYRave+uhMUlIlwdzG+vuHTZ+CU0
	UcFmwak98T0ryaHeDd7XFKM536hWCKZKzIp8Kq4CSzHAjMY2cN+CmXRVSfXX7TWT
	BrQQ2Xl8p6td3O8S/y43mjOF+basWmWWlQa7HDD1ANDW0erYmzZC+YTvFKpaaztw
	h4q8/8aRlAvIM7HZUlCxkaRNZyOSRVKWotzTHNO/Mtz6ZRbmOqQP4YXbPPyh06zJ
	vr079HxCPVMkPh/FgdfzRXQvhtcAS/tXw4nWcmYC8OeosYizd6qutmSt9ixmRKO4
	rrOjQmFIqhULu0GFyaJhvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733499931; x=
	1733586331; bh=ta8WDzI+gHDFJhvicv0r0Ez6UT0cNBzl72Nt+2cdMhg=; b=k
	l6dHvW/U/zYHtDpl9yJ0PKVySe4ViDthv250XEJAQ6bpZpXcoVZvE/P6s9mTW83h
	sorHUzX2gXwWIuqQnoUimjfd3W/KnsiSwSEEdSnHB1nFdF63awHvS13QceJiOZtN
	3T3NUx5qRuKsvgPeONy/15X7n4dz6Gxu3bMETOzJD0Xf0EMyz1KwLkTq9cH0C4u6
	dhktJV41Jad//My+kr3xqQ/8rStJ10xEC0I75Yko4ZNU809LzDkd0mRyL+wNGqaS
	YMDWgRG4LL78Y8XewM4tP0GiPc/UkWI744Eo4vNRZUsHR+Cwfj2h32kK6rDEPAMT
	cgsVK+co7D2+jZjcacBlQ==
X-ME-Sender: <xms:GhxTZ_eDibkvSTR0JnXsz6kBipFwdFv3MRG3cxQit6t6Lsj6KEWXHw>
    <xme:GhxTZ1M2x6290LCbc6osHOs9K1W2_guxBUHetd-mrIVrvuu9iXXZTifHrqmm-gm4J
    ajqgsBNgQBo6UJLog>
X-ME-Received: <xmr:GhxTZ4gLhf633ARpv_EAaiiVD2pVPfiLDHT4FhPtcG3SCAxARiK4lWTh1s-2rclXL1YZKR5uiKwLAfvlN7AN5rqIvekRwrERTZubkBcviCDPiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepieduvddvfeegudfhteegueffjeelhfekheefkeetueet
    leehuddtieefkeettdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopegrrghrnhhisehvrghlohhhrghirdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GhxTZw-FRb2HZ3aufEKufGp4o5Al6ep6cIGgTLvF8BaojHUYS3Kcxw>
    <xmx:GhxTZ7vlPPTuMIUu6xMcSMZ3MRYMbTpoxdpdhVdtg97b0FA8irAMhA>
    <xmx:GhxTZ_Funidqsmc-vLt9shj5LGMNy-iwmpRkgHWJSHnFFihQBPEysw>
    <xmx:GhxTZyNU6-wj5_Pe2CWgmW7sfkKu0bfRZ7hWwsvKcCN0LOiM9MRE2A>
    <xmx:GxxTZxUZShPTguSiYq7p8TJWBlnr2znx8_3JBIOPHNytVnIyI1qTQPXc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 10:45:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d738f44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 15:44:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 16:45:13 +0100
Subject: [PATCH v3] object-name: fix reversed ordering with ":/<PATTERN>"
 revisions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im>
X-B4-Tracking: v=1; b=H4sIAAgcU2cC/5WNQQ7CIBBFr9KwdgyDQMWV9zAuiEwtUdsGDNE03
 N1pF651N2/y//uzyJQiZXFoZpGoxBzHgWG3acSl98OVIAZmoaTSqKSF6ZaBgzD5lAm6+FqI+A5
 wj/kJsnPaK+ktWiPYMiXi0LpwOjP3HBrTex0suHx/dxcEBGe8s8Zqr0N75MY2PsQiLupPmWIZO
 mlQq3ZPPnxltdYP/LPy/BgBAAA=
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
':/<PATTERN>') started to return results in reverse recency order. This
regression was introduced in Git v2.47.0 and is caused by a memory leak
fix done in 57fb139b5e (object-name: fix leaking commit list items,
2024-08-01).

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

Changes in v3:

  - Only mention ':/' as having regressed, not 'HEAD^{/}'.

  - Link to v2: https://lore.kernel.org/r/20241206-pks-rev-parse-fix-reversed-list-v2-1-190514278ead@pks.im

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

