Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922E28F528
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751523342; cv=none; b=mxSZqO35wyAv2z5pFumZJ1thQnTWPZn35fQE0o26NEhgpNBXzBsxNDKEesh/QOukHiUpKyxGpPOFAnAepZcOy7JBYa3bVSRtVGPbC/JoHg4T3bem/bkIOVlWf2gKGemsbiIAfkU27Vo0SuzEkpenYqnsInv/pWUcSU8E3txQl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751523342; c=relaxed/simple;
	bh=pMnFeJV11tUN3gYOFRYdimdHRSF58vjTEQVpBwWM3HU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mp0DJ8vg3lXkpflfcKr/2rstVB50FfiIFOOgHkN02w1YetL4SUS7vjXAN5g07j1gWyzejXyiNctPoRgvTmMlLyBoEyOpVNEI7PlqKOQo6jj5Y2XzWJWvEy4zqwUCh0YLn7rK3t6cqYm2KvWyl5Cl5Rn4F6bppFoI1PxbPfWdUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BlnTn19I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfXX7Zi5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BlnTn19I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfXX7Zi5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D13721D00265;
	Thu,  3 Jul 2025 02:15:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 03 Jul 2025 02:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751523339;
	 x=1751609739; bh=1CIvEW9USxVpDZs6DJCbYH6j393opxTWfWrKkkmM+Oc=; b=
	BlnTn19IPoa9Z3I+NB3s8SybFpbJezoHjsREzT19lqoGw1AobkS21eHYzld5mz3J
	WmGYmBZL9M4TcFPbFGQE0X4KUXIfyNigHr0O2gkCA8/vpf0JKg5Lc4yssMKJaYlR
	st2vk5NyXhL3iYSfBNcGgAyu85CkwUgbjUHwN+O4TMGCPmq5tFwwUTZYtCe5dx/N
	XFzwF4rmx44H5XlL1t0qg7nwpxpyhEZOPQ5WhUzM9wf5edOxOhqt2dTTqG+M4lNX
	qmmDN2mUBMAojBOg/SnuluSyd+XhTz4KIgfPcVwZNhBWgtsUvNGnj25meQ5z2Urr
	DfKHWuMLaZiFMjhncJ36Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751523339; x=
	1751609739; bh=1CIvEW9USxVpDZs6DJCbYH6j393opxTWfWrKkkmM+Oc=; b=m
	fXX7Zi5hVGPYdP/A6UrAYVaJzc40MRVRPBGxkTx4ohAR6+JGgOSqNryi/lYtOSSq
	SNeukTrWC2tPk5BpeDGu76hYa1hASWjvw0I3mJkqhpYk1kcQvs7NOjTdhCRjFV2X
	dtZ4kqQohR4e8XKRATLZWOlvsXmXwGWT3K51qfEM87pVufVjfQ7Gsurnu1/G/zW/
	eR4Mi0ooA2zkre6EejmCmK9qlSactFfWs0EwBbXsg0rNMrIKbsEAiEodzqqaJHwc
	q2PevJk1JiVKsx4TnzjCsz7tuLIIbF0Db6O1rD0WuxXCWgDhrjNWC9UuqOzYERkW
	QGTotv3NL7eRRB7KDsTfA==
X-ME-Sender: <xms:CyBmaKffGD3YEKBxapwglOwdiSBsZnZeYUimO156ggF-w3XzLWNf7w>
    <xme:CyBmaENgcaQ5V006yA7CdnD16muKsrseJNEkUPoj09HVQAjtAL7StrP4wxK35cGj9
    ZneYakCXxmBdMWzsg>
X-ME-Received: <xmr:CyBmaLiG5q86VJ0gUXOijxEpgVbW8Ejpkxw7e-3BbZ2eWQNQLwCBTN54Bfbzu2EgqfHNsx5asuql_46h986RXkPF3NlcbPpiikQBCR2-Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhihvghnuhhssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CyBmaH8YtAgcRvPNBLDK2CZWCSdM6ALCbKpt6gC6wp40UVLnCCZIhA>
    <xmx:CyBmaGtMCHYuLf7Ym3AUhTZKIV7vNHkvEKXiSxTzDeDIaqJRBGk1bg>
    <xmx:CyBmaOFHu3OQ6_PtWUmBR2p0GT5L5BIsAEM1vGCt0T8t4lNjHMnEZw>
    <xmx:CyBmaFNSW121XQKrrih-p9ndmq-8sxAc0c668LoTSB-5dWn3Z3nX-Q>
    <xmx:CyBmaJ7kc9PQcmR5S_E7MwPF7LPreK5NChGV3R1jpg5aEiQ7PjZzhy_2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 02:15:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1553bac6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 06:15:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 08:15:30 +0200
Subject: [PATCH v2 1/2] BreakingChanges: announce switch to "reftable"
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-pks-reftable-default-backend-v2-1-5a27e72a8c5e@pks.im>
References: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
In-Reply-To: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
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
 Documentation/BreakingChanges.adoc | 44 ++++++++++++++++++++++++++++++++++++++
 help.c                             |  2 ++
 repository.h                       |  6 ++++++
 setup.c                            |  2 ++
 t/t0001-init.sh                    | 11 ++++++++++
 5 files changed, 65 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index c6bd94986c5..614debcd740 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -118,6 +118,50 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
 <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
 <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
 
+* The default storage format for references in newly created repositories will
+  be changed from "files" to "reftable". The "reftable" format provides
+  multiple advantages over the "files" format:
++
+  ** It is impossible to store two references that only differ in casing on
+     case-insensitive filesystems with the "files" format. This issue is common
+     on Windows and macOS platforms. As the "reftable" backend does not use
+     filesystem paths anymore to encode reference names this problem goes away.
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
+Users that get immediate benefit from the "reftable" backend could continue to
+opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
+config. But defaults matter, and we think that overall users will have a better
+experience with less platform-specific quirks when they use the new backend by
+default.
++
+A prerequisite for this change is that the ecosystem is ready to support the
+"reftable" format. Most importantly, alternative implementations of Git like
+JGit, libgit2 and Gitoxide need to support it.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).
diff --git a/help.c b/help.c
index 21b778707a6..89cd47e3b86 100644
--- a/help.c
+++ b/help.c
@@ -810,6 +810,8 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 			    SHA1_UNSAFE_BACKEND);
 #endif
 		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
+		strbuf_addf(buf, "default-ref-format: %s\n",
+			    ref_storage_format_to_name(REF_STORAGE_FORMAT_DEFAULT));
 	}
 }
 
diff --git a/repository.h b/repository.h
index c4c92b2ab9c..77c4189d5dc 100644
--- a/repository.h
+++ b/repository.h
@@ -20,6 +20,12 @@ enum ref_storage_format {
 	REF_STORAGE_FORMAT_REFTABLE,
 };
 
+#ifdef WITH_BREAKING_CHANGES /* Git 3.0 */
+# define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_REFTABLE
+#else
+# define REF_STORAGE_FORMAT_DEFAULT REF_STORAGE_FORMAT_FILES
+#endif
+
 struct repo_path_cache {
 	char *squash_msg;
 	char *merge_msg;
diff --git a/setup.c b/setup.c
index f93bd6a24a5..f0c06c655a9 100644
--- a/setup.c
+++ b/setup.c
@@ -2541,6 +2541,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 			repo_fmt->ref_storage_format = ref_format;
 	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
 		repo_fmt->ref_storage_format = cfg.ref_format;
+	} else {
+		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
 	}
 	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f11a40811f2..186664162fc 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -658,6 +658,17 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
 	test_cmp expected actual
 '
 
+test_expect_success 'default ref format' '
+	test_when_finished "rm -rf refformat" &&
+	(
+		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		git init refformat
+	) &&
+	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
 backends="files reftable"
 for format in $backends
 do

-- 
2.50.0.195.g74e6fc65d0.dirty

