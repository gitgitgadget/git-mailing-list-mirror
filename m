Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9D1D6193
	for <git@vger.kernel.org>; Sat, 24 May 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748122515; cv=none; b=fGkIn8XZZhPVIT19Z4A7CAZG4xN3hvs27Akm0xKhgmgKhIICiI0GEMT/C+wIKP6SSfKot7WKE/UImgv9nYbyjFTPSSpUBAOKqMLVj9C2bkKiDQVcyGlX7V3MrfIOwDPwDfSwSR2bDkDvorockZ1jzpoZ1qYPFRZD2Z0bNDgqbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748122515; c=relaxed/simple;
	bh=6w9adMarJ21aRWtIiKR0C/MCqZWsmRSitx9ricZ8uSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sY6oJJuHbttaR3wdSprrNjhVRLkaZ45guQRi5xItQ7e/rCAZn8MwglSZdJSCXa2Z+1VNdh5kNThzjs5W4K7lGGD5BC0l40/InT4fNH3AmqzwV+SrYSODYYyANeb4cWHyYz7IKxYO7ZYazFYgP6IRg65UwUUvvLr3IzPJ/TpJShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=xmhR7Tx/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vpA2+IBH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="xmhR7Tx/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vpA2+IBH"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 52276138043F;
	Sat, 24 May 2025 17:35:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 24 May 2025 17:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1748122512; x=1748208912; bh=7A
	qEoF2o4F8Fc0Nuh2nJOsDjCYBxDFaZU7NWGNq4meI=; b=xmhR7Tx/h9Y7pCwJxD
	QC9IBdB90f9qJN1gzeJoSpm5RZ93IKF3SrOI7NKAHtmiCWewgf7UfJihpsERW5lY
	GNoO5Z+99tk+fxvqRs7d8kaTBc/8oyhIj47JdrG8E/hd/mvafkSLSp2Yq0GcP1Hn
	F1uJyxPTCwTSJ0BD0qU00NJKh9dU10Hxum5IUSw6dKBq6iCkOHOl7ExzQCXx/PN2
	Hd8CCgcOTwfYO3nokjhOBR0+naREj47YWBFUasedwwhxNZTut9PebCjcRklRHL1m
	4RRL/aPIZRJrTCuWmkmP/Hj6FlSBpKmiPr9Il8QOylwlohw2ZyNUmKRRpUy65zf2
	XoIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1748122512; x=1748208912; bh=7AqEoF2o4F8Fc0Nuh2nJOsDjCYBx
	DFaZU7NWGNq4meI=; b=vpA2+IBHZCVffxdnxaiKQbp7Do+DsZD9AF6/V5HometG
	1rQ6fL9yU+/x/5ZhD2pduWKKwYytkBgHm9nXeNUtt8i+fS42us6srFXb2YC9ggvK
	VBMANv6exkdqn/1+KXR0bOfovUG4FA0cfA5icIPUWkKOYhLpcP2eM28WOBzLJ8CQ
	G4vYBYbfh9C/xuREWfRkJ4pWfXARREsFhWWA1UU91r5NtmFl/G4lVbuahAAUSHsk
	JbUrpNNCOwt2FqhR8d/loEsJYWuwdshJomp36MEBO+TI+x4GipRHgVM3SO13Y0KP
	a2MVVFCfebWh3va9YPMEsGyx72UIP5dvW0julNIMUQ==
X-ME-Sender: <xms:jzsyaE1Wbn1sSF8i6MNE8J2N4lFLPf3sy5qg5XtRHd3KE9MTqM4FvJk>
    <xme:jzsyaPEIdia56dJRJoau0de69terDldUjPYbJXSHGT2pqdueFZ4pWhPyqkrRHBpLc
    YC_2g0Yk-MyvW4neg>
X-ME-Received: <xmr:jzsyaM6s1p_pVcQsqABs7ISGtJK_QvXAQ8VnDi12HcmUfVfM191BONbh0BmyfPJZpJlSk-Atd1okp0hGap59Wc8jNAtqFmzScEUH-8aC0vKCPQTOmfnkG2-Aug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduvdektdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtf
    frrghtthgvrhhnpeetgfekjeffudeffeffgeekvefgvedvgeffueejjeelgeduhfdtffei
    keelfefhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhs
    sggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:jzsyaN0TdCS_U3lvF8FCpCWbLT-9KsXGpwfTmmHHMpgxuAQU_sWk6w>
    <xmx:jzsyaHHHRAHwS-D4QGqwO9GQooIofstBUMbJeDdswErLd0GFPobYqg>
    <xmx:jzsyaG8Ni7DlY7W5lj0Y9pUiPC5aYmiSZDORdwXTFvMVP0TIco3nIA>
    <xmx:jzsyaMkDODAney90EObk0ZrWEzVY_D__N5DxoVgZTZR-5ip6_4c_CA>
    <xmx:kDsyaA2blQaVTaTL9UTmpj92wcUP34Cs-t4-oKNaZDfM9Dh3q1dsRmx4>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 May 2025 17:35:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] notes: remove trailing whitespace from editor template
Date: Sat, 24 May 2025 23:35:02 +0200
Message-ID: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The editor template for editing a note consists of the commented block:

    git show --stat --no-notes <object>

The indented commit message will introduce trailing whitespace for
paragraph breaks (blank lines).  Some editors will highlight those lines
as an error immediately when you open the editor.

Let’s strip all unnecessary whitespace from the template to avoid that
very small problem.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/notes.c  | 2 ++
 t/t3301-notes.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/notes.c b/builtin/notes.c
index a3f433ca4c0..ca4782eca19 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -180,6 +180,8 @@ static void write_commented_object(int fd, const struct object_id *object)
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
 	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);
+	/* strip trailing whitespace introduced by blank lines */
+	strbuf_stripspace(&cbuf, NULL);
 	write_or_die(fd, cbuf.buf, cbuf.len);
 
 	strbuf_release(&cbuf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d6c50460d08..70a21be54fc 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1629,4 +1629,10 @@ test_expect_success 'git notes append aborts when editor fails with -e' '
 	test_must_fail git notes show
 '
 
+test_expect_success 'git notes add has no trailing whitespace in the editor template' '
+	test_commit --signoff 23rd &&
+	GIT_EDITOR="cat >actual" git notes add &&
+	test_grep ! " $" actual
+'
+
 test_done

base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
-- 
2.49.0.780.g892193c3f50

