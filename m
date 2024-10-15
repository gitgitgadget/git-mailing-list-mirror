Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0481F80A1
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019122; cv=none; b=RUE2F87P7wkw624dufpxY7YwdHCWoVEUbjQw1cYUPdAx28bJ203d5+biN9N8BpKfS1dY/mjKp8OsK71jxA8k2txJr4huejWKNY3Qh4AnFXatUop52uAGoduo+zhc90LonhbWmKAaKnYyIGc/9zZeNE+f7kej+HXQfFEiDyBznVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019122; c=relaxed/simple;
	bh=hrEBwSkmBH4Pl87bGsFVTj/TtxwPZtdIfNLZkdI16Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0b3I3O2rq3wVtK31BJ58tuR+4NrLYt5vy5i6WIfsZYLtxpLvve6bSHkXLv9Dqkg4n38065ORCo8v8trgiO9nAGreDNgG1UNs83t4SwL1ePKihXungwcHI2ODQT9GOy8b3a1pPinrdPDRwRN8FVfiI0ptd7QMexgG0mnFmvo2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eFMyGaD8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c44MH0xg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eFMyGaD8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c44MH0xg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D9B2813801D1;
	Tue, 15 Oct 2024 15:05:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 15 Oct 2024 15:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729019119; x=
	1729105519; bh=oLCurpmci9ZYyRJPPg8VCPSSLuFxgquCsUUO00AlJss=; b=e
	FMyGaD8YER4Q4tiNu8/etWCc1x6JnFItC5N9PRnHCRZrFFR7TFKDCEQtdbfip4r9
	zXBSVSJNpqBMD54dbiZZ4zAFZyTWYQsCfXxnGJ51J3PgTa8aGJ1Tj21+u/cqvgZl
	1R6Cjt/Q0ZXfWb5Sgft+asT3w7YjObArxK4RhfvDbHWpEv78Tnv9Xgu6vOvIfRVQ
	JtgVTpZ4eeXrz9EeMnxgEo5QHKbsBgTJNH5nkQQv2iPU4OdtqWGy90VMP5zlIj5Z
	gKHcq89R/WB8NWSmTGb6U3laeNAm0bLcoziho94qET2Jhq7QsIpDESPRbf661jD3
	XzwWJxRPgXKcjeI/SXzSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729019119; x=
	1729105519; bh=oLCurpmci9ZYyRJPPg8VCPSSLuFxgquCsUUO00AlJss=; b=c
	44MH0xghjFwPeslmgaJqp0AenZ8jTqcTGyAaTXI45d+KnLjqandTvejCF30mykGM
	SvR0nka9WgTNxVV0RTJ9XOueNlV93XlJfSka+pfk3TXR9J/E7ZnppVXbz5DkjKGc
	YDkBBcWLA+yF687Xv69IpJLT7/PbBK/hUsHRxR/uCQyYfBq0F8JdEZHkZ+gS8VFn
	Ni7ex9lzZ80wGPtx9ljwzXNM4nCehQeRPDK9+lVZv9w57Ru3mqj0w7EXwgJX5apL
	ZIeDYwdoPXySXDksXoGudPSyKBdyKRaA8FSTvZXbBocLPoy/wryxgMJsRSE6blgS
	zgbCgdmQt+aEg7pvLz3wA==
X-ME-Sender: <xms:77wOZ5mC_D2KayBTDlbW54a6OxDUp9YUsgEhaWiZgXqw_spRvr6boUA>
    <xme:77wOZ00t25wBWLVR85CpKSa5oXo74p8NZ9IoE2qB5mGq6uevxHVUSYA2Ri67u93uL
    Dx8yZ03_ijuGsdcYQ>
X-ME-Received: <xmr:77wOZ_rPYTRVgnXeHwYeAnmy4eDTIi_EAjg5xHEFajpIXNWQRVyrgCopG_5IK7xqw6SDZEIWrmUm9g5Li3zUwksUDCrJ-xu-mkPhshBR6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepfeehte
    ekfedtieffvdejteeutefhuefgtefgtdevhefhveffuefftdehiedtfedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghntggv
    sehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:77wOZ5mV2_mB0tTKaZc_wGBj8M4V5r-svCZuv00DuI8hTlt4sf4t7g>
    <xmx:77wOZ33sNX7FkXfyBrar9TQ8QQH8L5UsOk85GbRkE6d5CTOFU80iSA>
    <xmx:77wOZ4ubkBniCnWDZhV8Vo4nrsAth0NHmb7lSMijjk1HzfPHUKrbDQ>
    <xmx:77wOZ7WtEi9hw9fsI30NGgG9PzdMpEnImUQA0mSQceMnykK0zpVQeg>
    <xmx:77wOZxrA4-54YIeTA1DfM580-wk_WDEQqFhzLdXx_8ExXCb7YoZ1nUMR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 15:05:18 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: [PATCH 5/6] doc: update-ref: discuss symbolic links
Date: Tue, 15 Oct 2024 21:03:14 +0200
Message-ID: <3575fb48c932f50b2a3f6fb0e582b3c2a9b087af.1729017728.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729017728.git.code@khaugsbakk.name>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com> <cover.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 3575fb48c932f50b2a3f6fb0e582b3c2a9b087af
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Add a paragraph which just emphasizes that the command without any
options does not support refs in the final arguments.  This is
clear already from the names `<new-oid>` and `<old-oid>` but the right
balance of redundancy makes documentation robust to stray
interpretation.

This is also a good place to mention why `--stdin` has those `symref-*`
commands.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-update-ref.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 4bb3389cc7c..623c4d860eb 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -25,6 +25,12 @@ value is <old-oid>.  You can specify 40 "0" or an empty string
 as <old-oid> to make sure that the ref you are creating does
 not exist.
 
+The final arguments are object names; this command without any options
+does not support updating a symbolic ref to point to another ref (see
+linkgit:git-symbolic-ref[1]).  But `git update-ref --stdin` does have
+the the `symref-*` commands so that regular refs and symbolic refs can
+be committed in the same transaction.
+
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-- 
2.46.1.641.g54e7913fcb6

