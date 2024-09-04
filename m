Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4A12C46F
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431192; cv=none; b=h7MRpep6mqD/+L+mvJlLXAp1KhCK/fOUPJHP+qKRvmAsQTzfXNts4dKvJ7p1tYN71qUlmLt5xaznsi+o2+Sn2AQ705tZ7A9k56qUyQ9mxZfeQFRKblamBGE1/fe1HfKSjbunv3ZF/9ga+AM2sN/fRZdUck8EV/2az1SdI5+Cgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431192; c=relaxed/simple;
	bh=RsStEh+RAiaSAwWGWVAXV1JfDT3gFDBdK1ocGiDS5qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJKiaTTgcaJpeuNskPT3aGUAM4jRe9U7rhQVYrAhCRxjoq3BswMkBJQgsriMR99MNI4g6FoabU3A+DhUdC7wQzFeldOSYnGVa1lAwd6V7Wg0dfQICHgoMNGmZ6qr4wgmmzwycq/Cx57vZKHWC1djkZCLWOGJ/0G80W6prmbaLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pk0PhTgM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8Byy4eG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pk0PhTgM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8Byy4eG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1284D13800C0;
	Wed,  4 Sep 2024 02:26:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 02:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725431189; x=1725517589; bh=GeJRfrBrAo
	+uBJ190iBILYt/3tPoTtOoMMBrwYyNDxQ=; b=Pk0PhTgMzszXdnHep8D6viy5wr
	sO+6cH8xYzsD8JBKpwjgjeaFl1ISkHz5cd2hwbc3aFweCuejBLvF7DQSUGgjUsdU
	CRtNG+7K4MALoUrqfiu68ra/FbOOgehffmB/IEtt2XCcYB4DgulwcEt49AIMbiTz
	GynxML4ezoWmqhCIQcb01nBeg4dsm7N0c6zDeyVfqXZQfHGOqjgdW0cXH0CkPYaS
	J48n7vtRaCnY7e8ZWXp3SOv4dgWyJwboWUktKq3HvUTDIWyrJyimE0c+rMBuEMne
	k6NroeGkUzAnsxdmdqzQk7QGxMOa7KWgJd1anz5s4nyAy0HaRPod30oocqMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725431189; x=1725517589; bh=GeJRfrBrAo+uBJ190iBILYt/3tPo
	TtOoMMBrwYyNDxQ=; b=F8Byy4eGNrDlTmu2X+dwadiHSYU4d02lI0GGAZpv4BIG
	/Y8UXNY9f4ReQhPFv84RYps/1bNzJC7PBiiG4zRtqWLFEGMqkjLEI11FigMgapzb
	48GHhbWkplt+ld8i40a5SvAVGQ/UEKA0eBNHjFwZNXUyifcIucX5gveDzLLkmjwD
	Tg1UrA2nRF/aHMFCZUhJw9xcPNaaG32f3ZyzcA2ZXyuu9EgCHneLILz7+aVLYReI
	5qCHXFPFUVbvKpLIk4cB/ST1MYcaSOCXvwN3aauEDMQYczTMdi9wfNIHOpQ25VxB
	TmWm5JvJQ4v0VpknKucT6aRtLdAOmDuOuLUWx7vzQQ==
X-ME-Sender: <xms:lP3XZgPHJaYiBDZ3XcPIhKbZyKpFAiAqScJOCLzZiXlPhCM_95kKWA>
    <xme:lP3XZm-KnAdbi7kJ-VuShyinkzIXhSTpleu27KmdopX9c1pIxNUBRYPJhncdJnjKp
    j19fW4sRSyMuOQQ4w>
X-ME-Received: <xmr:lP3XZnQDu7mCMPwmkqDXwUAskTNbQEstry952MFAJF5Zv4fYSpwxzjhEQVFKMIHvIGrb7jLZ021o8Vyfxx6q7mtU8AqrdcJOnotJdj9dwIEP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthi
    htohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmvgestdhuphhtihdrmhgvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lP3XZoscjiWGdrQqG2ElFIeKgdt9A_o-khskhuo1q0t0W-601YSgjg>
    <xmx:lP3XZofNjsF_sCFIxKSVHhAgLeUgbYgod92WWabks9lT4LisCDoQgA>
    <xmx:lP3XZs1oz8GlHGyDfmOdvZtJPRS3I9C8rFiYn59_F-B-xQWz5HdEaQ>
    <xmx:lP3XZs9eEbPdt9qbKi9Ge1AQ7JA-cAAT-QWPaZ7dqulZEej7p9HkMw>
    <xmx:lf3XZn5Y_HjHAOgUm800UjzFWhAVh7Jg0eUksm7iBPPqBOBTRWc43ROb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 02:26:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c148261e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 06:26:17 +0000 (UTC)
Date: Wed, 4 Sep 2024 08:26:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ilya K <me@0upti.me>, Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] builtin/index-pack: fix segfaults when running outside of a
 repo
Message-ID: <9a4267b8854312351f82286b6025d0a3d0e66743.1725429169.git.ps@pks.im>
References: <14ec9394-a7ea-456c-800a-6a84c52e5cda@0upti.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ec9394-a7ea-456c-800a-6a84c52e5cda@0upti.me>

It was reported that git-verify-pack(1) has started to crash with Git
v2.46.0 when run outside of a repository. This is another fallout from
c8aed5e8da (repository: stop setting SHA1 as the default object hash,
2024-05-07), where we have stopped setting the default hash algorithm
for `the_repository`. Consequently, code that relies on `the_hash_algo`
will now crash when it hasn't explicitly been initialized, which may be
the case when running outside of a Git repository.

The crash is not in git-verify-pack(1) but instead in git-index-pack(1),
which gets called by the former. Ideally, both of these programs should
be able to identify the hash algorithm used by the packfile and index
without having to rely on external information. But unfortunately, the
format for neither of them is completely self-describing, so it is not
possible to derive that information. This is a design issue that we
should address by introducing a new packfile version that encodes its
object hash.

For now though the more important fix is to not make either of these
programs crash anymore, which we do by falling back to SHA1 when the
object hash is unconfigured. This pessimizes reading packfiles which
use a different hash than SHA1, but restores previous behaviour.

Reported-by: Ilya K <me@0upti.me>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/index-pack.c   |  9 +++++++++
 t/t5300-pack-object.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fd968d673d2..763b01372aa 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1868,6 +1868,15 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!index_name && pack_name)
 		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
 
+	/*
+	 * Packfiles and indices do not carry enough information to be able to
+	 * identify their object hash. So when we are neither in a repository
+	 * nor has the user told us which object hash to use we have no other
+	 * choice but to guess the object hash.
+	 */
+	if (!the_repository->hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
 	if (rev_index) {
 		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 4ad023c846d..3b9dae331a5 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -635,4 +635,43 @@ test_expect_success 'negative window clamps to 0' '
 	check_deltas stderr = 0
 '
 
+for hash in sha1 sha256
+do
+	test_expect_success "verify-pack with $hash packfile" '
+		test_when_finished "rm -rf repo" &&
+		git init --object-format=$hash repo &&
+		test_commit -C repo initial &&
+		git -C repo repack -ad &&
+		git -C repo verify-pack "$(pwd)"/repo/.git/objects/pack/*.idx &&
+		if test $hash = sha1
+		then
+			nongit git verify-pack "$(pwd)"/repo/.git/objects/pack/*.idx
+		else
+			# We have no way to identify the hash used by packfiles
+			# or indices, so we always fall back to SHA1.
+			nongit test_must_fail git verify-pack "$(pwd)"/repo/.git/objects/pack/*.idx &&
+			# But with an explicit object format we should succeed.
+			nongit git verify-pack --object-format=$hash "$(pwd)"/repo/.git/objects/pack/*.idx
+		fi
+	'
+
+	test_expect_success "index-pack outside of a $hash repository" '
+		test_when_finished "rm -rf repo" &&
+		git init --object-format=$hash repo &&
+		test_commit -C repo initial &&
+		git -C repo repack -ad &&
+		git -C repo index-pack --verify "$(pwd)"/repo/.git/objects/pack/*.pack &&
+		if test $hash = sha1
+		then
+			nongit git index-pack --verify "$(pwd)"/repo/.git/objects/pack/*.pack
+		else
+			# We have no way to identify the hash used by packfiles
+			# or indices, so we always fall back to SHA1.
+			nongit test_must_fail git index-pack --verify "$(pwd)"/repo/.git/objects/pack/*.pack 2>err &&
+			# But with an explicit object format we should succeed.
+			nongit git index-pack --object-format=$hash --verify "$(pwd)"/repo/.git/objects/pack/*.pack
+		fi
+	'
+done
+
 test_done
-- 
2.46.0.421.g159f2d50e7.dirty

