Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1232DAFC7
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622190; cv=none; b=SbXxO0rsVke5Dmi1y7HOUFWQkWpjgAklBhdnnPecPdZGPvQvZ8ani983FAA3dGD7DJf/Is9feOXHFZVXDg9aZNuD8tFB38ZVLaUp2S13nJOxBj+P4qHVmJVN/Iy2x71QB9foC563ByPzzGE5Y+huwnxBypEivBZ3BIuJxh/pwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622190; c=relaxed/simple;
	bh=0MRgJj0NJLZs9k8cE9PLZVWwys0AdAxfly8xLpzMqzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHu3VLevsTV4+Z1XQaYXiP3Gnsl+14IAxim/uvcO+P9/PhSPMiGCq4MP/+oGd8jJypXQC4TooMERXqR/hIfjjFFF0SIa5xRdvqoYa9P6ffRG6bs9c2t0MvQUznOXglWHpnuY7rNPIQ4tNsBTpD9Jw6XTu8kSgjmQaLpspkFWuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UB9CTb0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArZicPZ2; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UB9CTb0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArZicPZ2"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 160057A011F;
	Fri,  4 Jul 2025 05:43:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 04 Jul 2025 05:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751622186;
	 x=1751708586; bh=ETMIs19xfNkMUKBYkSQzsYp9pfCHZxaLtfyicrqAGW8=; b=
	UB9CTb0OVezyK/ktfBZZvpeQ8Zr0Hg8sozl1UqJiSK5A+7srQRgKa5qqQz/9fvnh
	m2zg9TeYkxl/0A1ILjvr/OnF3GWw2txN1M0ayqJnjUkyMkaVPJv/6IgsFEyGNAzc
	gsCN0okaemQLPgCWTHixh9fm3/FE2nP2MiDdV+opxgk4xbExBBH9Kg/an1kK0KwM
	I6K63BaLura54Tq6jdXck2IrbIo5zdvuT/uIl6g7kZHqJWcexaWCYRbIKIFKO3lS
	MxG/6YAd1RMIXRqMkCiVLc4edKM6JQXz5VQwwTDztWFEdJxWqXsEhsiPHWQeLn4g
	Ed2xPpScwHalIO2pE/KkeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751622186; x=
	1751708586; bh=ETMIs19xfNkMUKBYkSQzsYp9pfCHZxaLtfyicrqAGW8=; b=A
	rZicPZ2QGgSzwB9WYQ/ufz0MbLWeRaCdMjowzI/yMpdhZC7a3ldsy8WnvCh27pCi
	wu+o9TxzlPMu31/xpdT2/+/RQaNarsKNn+DEqEW3UhL5461FFyBEp5EdL+WDDdSK
	dD+0hqtcGoyLqHuZW4TrBMwxY/2ib79gDX0aNQJVQ1tKTojxjs9YkJLJg2BAOo/W
	LQND5HdqlrAhbfINsOm4TNBqZKy7GYsC/rLtBZyhjQNfr1d9ubSXIuRKrKlWLzS5
	wRcmW1Ldl9M8W3hbz0bhGXr455E71LQeDFSaA+Rl2+wgxzN/MyAuYwVuS144PlBm
	MVuQql6Lv4pxPahv+5srA==
X-ME-Sender: <xms:KqJnaLNj0rygerd6xc0-pRSMTjDUZsAhxsbrhw1E4izRiuoM9pkeMA>
    <xme:KqJnaF9hIdbHdHO_exQ0eLVUoBSITVxpA9ikt0C-lquw0N3quDttdWlEXWQIPDDdW
    IyBxxCkS5wqCvtp7A>
X-ME-Received: <xmr:KqJnaKQnpkbtD7O1Hg6Zu86CdKDNoX3HMoZagfCbgDsxogiRwzueCNgaDwkYFWPz1dolxVhTH0_O65Ocofm0fNnaelXgTLZYlRDB_KI4l1mq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjrgihrghthhgvvg
    hrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhihvghnuhhssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KqJnaPukb2SR3a41jjRlEfO0PT3KJRS3iPf275LIF3TXELGn6h9KLg>
    <xmx:KqJnaDeFag_6wG4WGfQwbMP47U_tffdS0AO6KmtlXfMuF4Ff1VMDqQ>
    <xmx:KqJnaL2-pEXYrC2qfPsw4_vES3rtJjJUeQS01BjB3VIRpXYWWxvcZg>
    <xmx:KqJnaP-VXNmRkQAtVy-AX6svRsWGBBk5xtyBA2jyxW_pnEgSCTqv9Q>
    <xmx:KqJnaJpXO0k_BBa6v5sxD79BHlg7eDs4RW0yJEzNM8NYqdR_rBmlPLgo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 05:43:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f20b2ca (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 4 Jul 2025 09:43:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Jul 2025 11:42:56 +0200
Subject: [PATCH v3 1/2] BreakingChanges: announce switch to "reftable"
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-pks-reftable-default-backend-v3-1-a1eb63e8442a@pks.im>
References: <20250704-pks-reftable-default-backend-v3-0-a1eb63e8442a@pks.im>
In-Reply-To: <20250704-pks-reftable-default-backend-v3-0-a1eb63e8442a@pks.im>
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
newly created repositories and wire up the change, hidden behind the
WITH_BREAKING_CHANGES preprocessor define.

This switch is dependent on support in the larger Git ecosystem. Most
importantly, libraries like JGit, libgit2 and Gitoxide should support
the reftable backend so that we don't break all applications and tools
built on top of those libraries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.adoc | 47 ++++++++++++++++++++++++++++++++++++++
 help.c                             |  2 ++
 repository.h                       |  6 +++++
 setup.c                            |  2 ++
 t/t0001-init.sh                    | 11 +++++++++
 5 files changed, 68 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index c6bd94986c5..f8d2eba061c 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -118,6 +118,53 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
 <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
 <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
 
+* The default storage format for references in newly created repositories will
+  be changed from "files" to "reftable". The "reftable" format provides
+  multiple advantages over the "files" format:
++
+  ** It is impossible to store two references that only differ in casing on
+     case-insensitive filesystems with the "files" format. This issue is common
+     on Windows and macOS platforms. As the "reftable" backend does not use
+     filesystem paths to encode reference names this problem goes away.
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
+  ** The reftable backend uses a binary format with prefix compression for
+     reference names. As a result, the format uses less space compared to the
+     "packed-refs" file.
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

