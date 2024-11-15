Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34B18C933
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655307; cv=none; b=XS/ecYElKMaja9CzWmvhmMiEoIhUTovk0t65URjcH/7zgI15d21S0AxBcMX/QHyniqRQjA/L3tCN2R1Sl24R5dRwpdtYT7Y5nfTE4u3emB2ApFjZDzRjf6YiAqasQJy37xD/7YbQfiIFYl9IxlNsZ/181yUheYkoQ426wDul2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655307; c=relaxed/simple;
	bh=svIfw3RWTaqFkBPmNFTY1rZwJSvfY1x+DMlbv00uK68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cltwhUe4xeTfkRLpgFITPwTgKwXfizUDMHN4iHzrN9ghtVSQIfpAznImg/ozMIp65M6e0s+hsUdUJkonNXU40H96+s6aY1yeLyyRGnv4eojhtXMGa+XayQWHzwfVhXd/pOI0A/IvAX6nRbCW6tjmCkycrM/0wA0/pVaFrQn05Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2LKx0iA5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fOFuvHSK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2LKx0iA5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fOFuvHSK"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 596A41380667;
	Fri, 15 Nov 2024 02:21:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Nov 2024 02:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655305;
	 x=1731741705; bh=955h9Bjz7MmREMeWmSUC9wcllpX/6od8opLAXZgi4hM=; b=
	2LKx0iA5gDU1cJQRogbx73/8HJdi0wuzApEmjzKyv22fC7l34TR1w40YH6854MdM
	hl08/iGPNfBXUtPwMGUpVNY2ErVndK9yQWN/qwFA+NdAx9aR4escpRoLlGSlQ89G
	iJJYDlu3rmhmNxVipEDMZx7ySrhnRxnxGpFoIHQ/fx58dN3ReZVQp7LMMkTfHefg
	NbNYf2gqlzCIbRe5XMsaexNE41p80iuhRaCGiMVcVfNp4YjEd/sz60tE4uKUREcJ
	KJPRaUIIO3rG/16v7eqrC2HSy+ec9oIMd0Ryt3fveNKHcBzNEbBcJAJdFtVd+YHj
	3kNHzp1CfdU7uo0KB6uc7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655305; x=
	1731741705; bh=955h9Bjz7MmREMeWmSUC9wcllpX/6od8opLAXZgi4hM=; b=f
	OFuvHSKaIN4ZFJt3mb3Eom9+ihnXZGSYhI6GNLb4/fWfAwv8ErCkMf0vyqM6VxUO
	/q7T16FbgvxnKmvjhT+eMtGpT9QCQ9iVsdgG5Kk5A+SXI8YDs/PElbk8dMCEModl
	6mM4tXfqEI5ivzmXbQ+dMeS324V8C3JfZJxVXq8Dli1oy78FFR2dMFME++x2YP6F
	SsWMykb4mNHsJMT+B9UO0P6Q4yOp/gHl9+OtGDS5IHqQnxURZcV3js4u+mJz6Qn+
	b8Go3zSUdMNeeMiQq3wKr7xPddPGZVwGUcM23jveyHtmYkHtN5h0mFNJjYbzDwRI
	v+tBJro48CpFxXd/jBA8A==
X-ME-Sender: <xms:ifY2Z69HtrSc6yO9z0oF8ijcAcf-zbpmAyFFXVNFlHtOx4cyu75t6g>
    <xme:ifY2Z6vbTdX_5yXysZqdTSG5NY6cVZcrT1IbPE03SjZF5J2O2k_xqWRP0mxlmyHcR
    TPs_Bh7yEtmcxkGkw>
X-ME-Received: <xmr:ifY2ZwCChoj90QBO-nfolrCD6ai4jjRLoVrkqvWjdOOja_6X66vk9hL7ONYYETN5tpMlO7VyRAKE0nYkWeWN0vW0eBDX8VMqH0zYBnxI0IJIKuAkuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvhhiug
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ifY2ZyfG9BbG95DW0dkY5s0xCw3soMzmazInrJiKsMr64r1h17VKPA>
    <xmx:ifY2Z_Msd2p9txQDwq1JSbQZUKBs4rylnde-QgiaZm_JC00T2UHQ9g>
    <xmx:ifY2Z8kRCxI3peM1Aspe54H09cwm8fu5fYF27rkIoOIz5xrq9cuSIQ>
    <xmx:ifY2Zxu6msYM2cyaIGegxomj-SbIBS18KduJmkflKX_fz0XJnXKDYA>
    <xmx:ifY2ZwHiHgXuBhdKn1U-ScgAX3qlO_m1cSBK19gNofj10WOXIQ1k_ANB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c201007 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:21:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:25 +0100
Subject: [PATCH RFC v7 13/22] Makefile: allow "bin-wrappers/" directory to
 exist
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-13-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The "bin-wrappers/" directory gets created by our build system and is
populated with one script for each of our binaries. There isn't anything
inherently wrong with the current layout, but it is somewhat hard to
adapt for out-of-tree build systems.

Adapt the layout such that our "bin-wrappers/" directory always exists
and contains our "wrap-for-bin.sh" script to make things a little bit
easier for subsequent steps.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                                      | 1 -
 Documentation/CodingGuidelines                  | 2 +-
 Makefile                                        | 6 +++---
 bin-wrappers/.gitignore                         | 9 +++++++++
 wrap-for-bin.sh => bin-wrappers/wrap-for-bin.sh | 0
 contrib/buildsystems/CMakeLists.txt             | 6 +++---
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index d3be460040c6120d862a25dff1abd325b93b37fd..e82aa19df03fc865eaa0468f12b734cec0c48a2c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,7 +12,6 @@
 /GIT-TEST-SUITES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
-/bin-wrappers/
 /git
 /git-add
 /git-am
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 87904791cbcea6e57d0fb3c7d4e27f2b0d80b95f..1df9d0c42f1ee7b16ecd7abc22d2653dbf9bae2e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -583,7 +583,7 @@ For C programs:
    Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
    run `GIT_DEBUGGER="<debugger> <debugger-args>" ./bin-wrappers/git foo` to
    use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
-   ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
+   ./bin-wrappers/git log` (See `bin-wrappers/wrap-for-bin.sh`.)
 
  - The primary data structure that a subsystem 'S' deals with is called
    `struct S`. Functions that operate on `struct S` are named
diff --git a/Makefile b/Makefile
index d9a0025b30db24cb035f19812f0071fe0642386b..056234e0bc0722ebc9f5d6ccae97f98fc9a64a37 100644
--- a/Makefile
+++ b/Makefile
@@ -3200,8 +3200,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
+$(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
@@ -3697,7 +3696,8 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
-	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
+	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
+	$(RM) $(test_bindir_programs)
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
diff --git a/bin-wrappers/.gitignore b/bin-wrappers/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..1c6c90458b758641d0311e812563b32dd4656b48
--- /dev/null
+++ b/bin-wrappers/.gitignore
@@ -0,0 +1,9 @@
+/git
+/git-cvsserver
+/git-receive-pack
+/git-shell
+/git-upload-archive
+/git-upload-pack
+/scalar
+/test-fake-ssh
+/test-tool
diff --git a/wrap-for-bin.sh b/bin-wrappers/wrap-for-bin.sh
old mode 100644
new mode 100755
similarity index 100%
rename from wrap-for-bin.sh
rename to bin-wrappers/wrap-for-bin.sh
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index be1ce1f37a775c366098717047cd7579cd81015d..6fc4f051400db00761232d0aaf1bc88634022b5b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1080,20 +1080,20 @@ set(wrapper_test_scripts
 
 
 foreach(script ${wrapper_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@PROG@" "${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
 	string(REPLACE "@PROG@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
-file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
 string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})

-- 
2.47.0.251.gb31fb630c0.dirty

