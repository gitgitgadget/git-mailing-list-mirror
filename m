Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF391CC888
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017071; cv=none; b=cANmTQIttMD2bX8fm/pb0A9Z6o07uIy42VQjij/kfAX1+fqOQ7mHCQGEnhqBfOqoFhpZ4+3RINchyLRbBm1qqQsQO7d/jaVlEVJenbfL9Zt5dj/TDK08Lzrp4xjGuEWY4CkLFLoJkLKuPSFkxb5FwWwNop+ungOOoHKg2IGn+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017071; c=relaxed/simple;
	bh=dEmc4AYAP07C744hawTF+bK/fM93wxaoXe8XjQQhOeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i45n/AQDoMlth3eMVS4FN+yvIqTrx4PfsdJD6PxuH8Ebsw7lijSrGqiii5GD9Ak4xYY9uG2FHjJMc3mfrdlqu0T34UfzU0uXJSXunLfrBe+rKlWWwfRsWftz4M2TdWHPojQXr3Rj+m2Wm6HCCcVa+dgCAw2KRYZE+5BFw+zlfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eVQBbUrn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WqL5SaFu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eVQBbUrn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WqL5SaFu"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3B1811400FB;
	Tue, 19 Nov 2024 06:51:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 19 Nov 2024 06:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017068;
	 x=1732103468; bh=/FWkw2d2Vf8RK9IEXOr7ysq66KBe+Myq9wi+fktucms=; b=
	eVQBbUrnKEh5mNmaCfDjjjwmqEhVV4MiI3tnauM8C4zZGcVw0ZyqHrVb0C3eT4xh
	qBFOdVy5v7bzOFXyA/Gi36NedF4JjpTu4sZ2e8ESW7+4xGyn2OC2VIaDDDQVYEgz
	qoyiOZioBnev8U+IMnf4gnRlHcHvF5U78kTuZUjZn1Wqyw4o+9blmYNc3Q0GvHS1
	u5cCa8JKFydzuHH2g+3SiDwgaqiwt0uu0jlAvucTcnT0glRI6r4hmRQVHGkSHTWF
	zMAbqJso4IfICanv7QEC01IR/s3ZiVPi/vDQtcziM7vAMR+7J90xq1wcAFvl6Y3w
	fBEP9RQtmo1t0k06TywVhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017068; x=
	1732103468; bh=/FWkw2d2Vf8RK9IEXOr7ysq66KBe+Myq9wi+fktucms=; b=W
	qL5SaFuIAh+egSyA4Ve71+2uZvEJPrTdUjV67weKJQu1mUyeU7WHErZCaeGjraKh
	FLR04M9UuNvyNWB3lnS6BWqZON5DOMRdQLCKSwKmFpfTpYIbgTTVSDs8sVGsANW1
	otLVRh5et0nwjGVentJikM9IdSBOq7YgZDVYRjs9BJ4N38b62mgUsnYxlBraqQqI
	nVGd1YmIk4GrGOK9XXUb7pj1ovcCO8ijMoreos4XGPtOiyWFkd5IhfTuTwRWXuz6
	QOHIuymCHG57KoEQ4t5TeXtsg9dwqDccyJPvC94cEFnOhKW3nDOErK5hMb9M3WSj
	gk4X86zvNU4r3rcY7ppcQ==
X-ME-Sender: <xms:rHs8Z_6VpGa6DpISwzyr9GohiqtauSvJI1MkJ-1OKsCInfycjw89iQ>
    <xme:rHs8Z04t9GRvPu5fYmxsItzM7rmobeXkfNgBXBCl3LHZvGJtfsl8NWVKvf3OifIa5
    mY1PO5o6NEbKnm35A>
X-ME-Received: <xmr:rHs8Z2e287thoqIPrgg5471tVqDIFK3ORzY_xEmRyVVSaF5PqUYPQ_KDQFngtYTecbFy6LJLAHUqvHX5ulcIO6nR9dZLUY56ja9HGXUXHmZZ4go>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmsh
    grhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvght
X-ME-Proxy: <xmx:rHs8ZwKgfLq3MN4lf_hq4CVM28WluIX1W0QxGjXcLSPjyiyCkbEllg>
    <xmx:rHs8ZzKx7dgQzAGn71-5OHEPNwLG-Aeb3oVfSw-VrOdMuUzWgWv4iQ>
    <xmx:rHs8Z5z6ZSFbmIOi2v6fEpJjeII6DMyeZhlH3Q5Tz9ouMuu6inUJpQ>
    <xmx:rHs8Z_JtAZqGyBiL3KfRuVtgiRfBBSJ8vD6Iuf2aa_8cV0AWvNUnFg>
    <xmx:rHs8ZwD0yop2N6ZzOznZoWrkIyj0-eJgp6dniRQp7UbHayIb7Q_lH37f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc0b3a13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:51 +0100
Subject: [PATCH v8 14/23] Makefile: allow "bin-wrappers/" directory to
 exist
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-14-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
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
index 0417adbbbb5be9e8b3f45a468faa059a40f2ddea..d0ec819e449575f43552a75761a9cb2e85c6ea65 100644
--- a/Makefile
+++ b/Makefile
@@ -3206,8 +3206,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
-bin-wrappers/%: wrap-for-bin.sh
-	$(call mkdir_p_parent_template)
+$(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
 	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
@@ -3703,7 +3702,8 @@ clean: profile-clean coverage-clean cocciclean
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
2.47.0.274.g962d0b743d.dirty

