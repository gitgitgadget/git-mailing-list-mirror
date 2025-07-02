Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B62517B9
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451287; cv=none; b=Q2TPlzpd2IBZoCELZtZ0ARshPHnTYvvK2Fnuv4cQPi/ftD0X2CjCQ6Dn8F4a2vFEOBFfMVbXeA9fCaJRD2Mp8RfPY+WTf/IawaOaTwZJ/oh5VXQGlY3Ibywz0V6taetiLHPTIWsXm01+UnzTExIF8o4mwbsbIm4+ZGGg5mstnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451287; c=relaxed/simple;
	bh=EhJu0FN5vVzH7+F68Zgu0J0N0kxwTiSCSrflzZMdluI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsOAuDF+te0JgeUWGheXhsp3CW4BEpMrgOHV0R2hXqyu3z1Jxy1+MRKLDfPeOAk3/JQFzghKlRMkstw1MS0EbdY2FdnesE76z7mObzRjdd8bRrvKrjw3sQt+aj0AG1h29aUxJ6lv1Z5UPh96Ex/aU1IUgFK4AgB55xOwQGT9AGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DZKrzpWm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dhnupduc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DZKrzpWm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dhnupduc"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4CBA3EC0020;
	Wed,  2 Jul 2025 06:14:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 02 Jul 2025 06:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751451284;
	 x=1751537684; bh=NrkpuuCODmz0yl81vfjXhFM1/qiRFsXaQAoTpiart84=; b=
	DZKrzpWmTb/hxTRs93wa9besD3nilOjHYssKICCtTaY/mJR1Vkw4543pfmppbWWt
	Tqga0mkvYLlnGNdqNlAKOml8/JImWCRam4MnXulP6Xc+bgCtqbflvGS+JrwJQtjA
	JDsw8JugacSIzhpce06BRWIZyruxC8n2anBR0oKqvRKRuMNYBQBrayNCGNKRGYz9
	j+mNeZjuix44fFHJUSiq95a2sLJt22Ukffn6YxAP67QiGR/Q0G5rJl2tSnVveM1i
	tHsSchLmzO2fZ9KE0CpOF+v3/cC8CFD7Ziw2I1QqfP80GWXxWklFxXu2nuwI/LCi
	DUs57EHZ0miyf941+KV/8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751451284; x=
	1751537684; bh=NrkpuuCODmz0yl81vfjXhFM1/qiRFsXaQAoTpiart84=; b=D
	hnupducVij7l5mFHVFjIGPkEr1ZvkdBXHcaNTj5oRUxyXnuftrMaLP7VwDfHRr1P
	NXyZI8OTYLMNuqRj9Tzbg5FSFQvym3XF68ia5kInY9OWvSwZO/6TdcWtWbRpdL1c
	aWS1x4Kg9NNRkkK8D0IpQK/CxfwhgRPDQdSeiOsmgNQ05VQ+9IZq4Uoc9P4trel0
	nYkyEn7Pwgsy9fZ1sN3zbExyr2Ckt4xURhnmlauBuEcBFGhKwCEvba3Q+b72yEA/
	GlQ2OdtqK1Tst1BK1wp3LPVV4RE/xqhfAeTaRlUuofN3JgWo+TTagjjzvVKQ7CGL
	us9Hon0jyN8Pw87uB++5A==
X-ME-Sender: <xms:lAZlaLx5dwNcmnhSM9jDh3pErR1Qu2LjtOuFkR4524R5L9f1KzulUg>
    <xme:lAZlaDTZg1o4OMfILFfM9YtRDq2bvgyHvY_Xi-UEvyCGVG_6ASHO0bFWobINhQKaJ
    7zJV9sUBBK0V9A0pg>
X-ME-Received: <xmr:lAZlaFWLmEoHWl0urAhYbQExAdNIyHXwHUoOpL33j3SP1Qaq133TUvXZ6RxBCgDp0AJauuZ0Llmn5HY2bkom86_3Lpig1jVx13zhI-u_Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgr
    rhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhihvghnuhhssehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:lAZlaFgdYT3tQKv21JmTO2y2RlWPcM8Y9rYUAkF5AYhchqn3IinenQ>
    <xmx:lAZlaNBSGvwZiy_I7WKegYC3LALVbkINvFWoB206x69rMPGEJV0d9Q>
    <xmx:lAZlaOK-QjZEavqh8wOzAytnOWZSWdcrqthHJNNNY3LCDBP8VFSqqQ>
    <xmx:lAZlaMDj33hg_H3YKQJBA5X3mDQX71_W-fj_6H6EY3z1cvWRbqu7jQ>
    <xmx:lAZlaD4HDRTp1SON8UnSGWXKBpu_PN4ANUGvWKt-yTUkAk4CUnS9xIfw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 06:14:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2688285b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 10:14:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Jul 2025 12:14:21 +0200
Subject: [PATCH 1/2] BreakingChanges: announce switch to "reftable" format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
In-Reply-To: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The "reftable" format has come a long way and has matured nicely since
it has been merged into git via 57db2a094d5 (refs: introduce reftable
backend, 2024-02-07). It fixes longstanding issues that cannot be fixed
with the "files" format in a backwards-compatible way and performs
significantly better in many use cases.

Announce that we will switch to the "reftable" format in Git 3.0 for
newly created repositories.

This switch is dependent on support in the larger Git ecosystem. Most
importantly, libraries like JGit, libgit2 and Gitoxide should support
the reftable backend so that we don't break all applications and tools
built on top of those libraries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.adoc | 39 ++++++++++++++++++++++++++++++++++++++
 setup.c                            |  6 ++++++
 t/t0001-init.sh                    | 16 ++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index c6bd94986c5..c96b5319cdd 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -118,6 +118,45 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
 <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
 <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
 
+* The default storage format for references in newly created repositories will
+  be changed from "files" to "reftable". The "reftable" format provides
+  multiple advantages over the "files" format:
++
+  ** It is impossible to store two references that only differ in casing on
+     case-insensitive filesystems with the "files" format. This issue is
+     especially common on Windows, but also on older versions of macOS. As the
+     "reftable" backend does not use filesystem paths anymore to encode
+     reference names this problem goes away.
+  ** Similarly, macOS normalizes path names that contain unicode characters,
+     which has the consequence that you cannot store two names with unicode
+     characters that are encoded differently with the "files" backend. Again,
+     this is not an issue with the "reftable" backend.
+  ** Deleting references with the "files" backend requires Git to rewrite the
+     complete "packed-refs" file. In large repositories with many references
+     this file can easily be dozens of megabytes in size, in extreme cases it
+     may be gigabytes. The "reftable" backend uses tombstone markers for
+     deleted references and thus does not have to rewrite all of its data.
+  ** Repository housekeeping with the "files" backend typically performs
+     all-into-one repacks of references. This can be quite expensive, and
+     consequently housekeeping is a tradeoff between the number of loose
+     references that accumulate and slow down operations that read references,
+     and compressing those loose references into the "packed-refs" file. The
+     "reftable" backend uses geometric compaction after every write, which
+     amortizes costs and ensures that the backend is always in a
+     well-maintained state.
+  ** Operations that write multiple references at once are not atomic with the
+     "files" backend. Consequently, Git may see in-between states when it reads
+     references while a reference transaction is in the process of being
+     committed to disk.
+  ** Writing many references at once is slow with the "files" backend because
+     every reference is created as a separate file. The "reftable" backend
+     significantly outperforms the "files" backend by multiple orders of
+     magnitude.
++
+A prerequisite for this change is that the ecosystem is ready to support the
+"reftable" format. Most importantly, alternative implementations of Git like
+JGit, libgit2 and Gitoxide need to support it.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).
diff --git a/setup.c b/setup.c
index f93bd6a24a5..3ab0f11fbfd 100644
--- a/setup.c
+++ b/setup.c
@@ -2541,6 +2541,12 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 			repo_fmt->ref_storage_format = ref_format;
 	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
 		repo_fmt->ref_storage_format = cfg.ref_format;
+	} else {
+#ifdef WITH_BREAKING_CHANGES
+		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_REFTABLE;
+#else
+		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_FILES;
+#endif
 	}
 	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f11a40811f2..e0f27484192 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -658,6 +658,22 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
 	test_cmp expected actual
 '
 
+test_expect_success 'default ref format' '
+	test_when_finished "rm -rf refformat" &&
+	(
+		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		git init refformat
+	) &&
+	if test_have_prereq WITH_BREAKING_CHANGES
+	then
+		echo reftable >expect
+	else
+		echo files >expect
+	fi &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
 backends="files reftable"
 for format in $backends
 do

-- 
2.50.0.195.g74e6fc65d0.dirty

