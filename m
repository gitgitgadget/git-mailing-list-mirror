Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAD25A324
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591530; cv=none; b=QrY0qNBGoU3KGwonIUF7dzemXWWqR1WrP9mLj17Yq5YqhrH38ciCdgx+CJ1kclAJMbLTEDL3kgdhrDw1ul3nseQVuseaShvebuWUHPXKC5yQhPphONhceyrS7pGSUbraPqyd0x4RVR6nQsERrGtFpMCTdSolGAtxCrYphHncAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591530; c=relaxed/simple;
	bh=UgbkUeDj4l7YI8D8SMu3t+6QbaNINBbNj4w8iUw8wmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sElgoGr+koFhMR4xq07vbz1s8+JywHDRv9TILhH06FKRCsODHcMOqfZfKq7yReJyC0kvYGizPUVCZ55jN8YeJC049J1ddMv1Wpr6HUSlupICAQ6VDwAJF6SSeh0HFcStrB6RIw8xYlAYEYlZeWrOifcpNLLytKA69ZmAA8k87x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DK93HQvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrRU2ums; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DK93HQvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrRU2ums"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A2B51D0025F;
	Tue, 19 Aug 2025 04:18:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 19 Aug 2025 04:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591527;
	 x=1755677927; bh=GEbuuCnL+cbsdbhxQJvmMalkc6G+VvSuKoepIcyOd4w=; b=
	DK93HQvpaz9/nLp+LP6Xe1q95b8D3+lpsu+Ps3lVTSb4Qau9n29uOWVi+zQVNllw
	vRb3rd10fqFlPlhz9lJ92oFyuZhEPilguRt7KAcI1Akt6gFb8rypLgRjaAFmKlRn
	1vXsOwaoLrEqBkNZxD2rEDXJq3QVIcuDSERbE5pHG9wXylJWtEnAosL5DeXAZeEf
	OM4pT4fhpbbM37P2lcdTJRn5/MjI0UM8CrMVa+anVZRNCcoagQ1tVcWFUsBLCMSs
	cKTQRGsx0o3PXDGxtJjDXFclI6hEH1jmssrTyT02z4BNieqzpflAa5Y7hVc9aMqm
	H0BxcEUXrCWpMbHCBfeaMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591527; x=
	1755677927; bh=GEbuuCnL+cbsdbhxQJvmMalkc6G+VvSuKoepIcyOd4w=; b=K
	rRU2umsfVb3RxBqp7IHsAI321e4rgr8SeD1D1IMiwiSf7uKxsqvR8FVzGAZ8LQTs
	3IPKnMrHxzfkdsL++5zGU6MTy6VA17/9shD5rNaj2R4A/K1H+2fWQkaz9cLTWN72
	5D0taJtPcG2E9d21ki6j9Uu4tOjRougtlSrFI4xwM9ehFgJz5aK1W9L9Ec5xIl3t
	m/cQwLrxmSOhBJzqYUOHa6wRH0Xi2AwonSCmk91ggbL3rPqy5QJau/SSCbowPgpW
	4AH+4Vgd/y/AiRhrzWNDID4ZktW/F//RdFazJJHo8BtA/A2Wr6tmV5KVGUXXWZQJ
	LQXaCzQSV7P4FXr6M5z5Q==
X-ME-Sender: <xms:ZzOkaGigAnNX8GkBtKQBaLXyMvn3oJ_6Drb7dfPopcwmgtIFW_C0ww>
    <xme:ZzOkaHOyZJiK6HqwhfQ_--eL_i3h3vPWPKMPGAP1Jzgjzpz9kj7VQjrLFX7EDPSGQ
    c8b1iqvLJJnVnAwUQ>
X-ME-Received: <xmr:ZzOkaP6VEb9K1t7eUXTA42G-GDOWN2nn7fmDn38Kg97E1iG3LzYBQvnT0imD5r_0hja-Iwnjh93RZItHorz1xI3VzMqnqw58wXaeXF6A0Z4Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeffefhffffieeujeefgeehudevvdeiff
    evfeeihedvveevfeeileekgfeukefhnecuffhomhgrihhnpehgihhthhhusgdrtghomhdp
    ohiilhgrsghsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:ZzOkaN2OLZsuo3sQNw6gq0jhP79vu_7fM30o1K7uo--6Wgh27kg3uQ>
    <xmx:ZzOkaIZNFPjmNqmUZ8aQ-gLu7wTzIhOGwEWTVmc1GnGLbnHnpaZA6g>
    <xmx:ZzOkaNAYaGV29yG6p6FRbtMWAF6co5G7356EM-gFbag9KANLn_E0Tw>
    <xmx:ZzOkaC9oL6UflqQwEz_GSKJetatIwj19z7MNmShd64dghvk9UwiNTQ>
    <xmx:ZzOkaARanuuN2q3E1wEAtxMsfcshk1-y6tv2VgcgQ8B7qOjEIJoe8LuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:18:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c301542 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:18:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:18:36 +0200
Subject: [PATCH 2/3] gitk: move into "subprojects/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-meson-tcl-tk-v1-2-6bcaff0bc0a0@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Move the "gitk-git" project into "subprojects/" with the same reasoning
as in the preceding commit.

While at it, lose the "-git" suffix. There isn't any (obvious?) reason
why that suffix exists as the project is called "gitk", not "gitk-git".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/SubmittingPatches                | 2 +-
 Documentation/gitk.adoc                        | 2 +-
 Makefile                                       | 6 +++---
 subprojects/.gitignore                         | 1 +
 {gitk-git => subprojects/gitk}/.gitignore      | 0
 {gitk-git => subprojects/gitk}/Makefile        | 0
 {gitk-git => subprojects/gitk}/generate-tcl.sh | 0
 {gitk-git => subprojects/gitk}/gitk            | 0
 {gitk-git => subprojects/gitk}/meson.build     | 0
 {gitk-git => subprojects/gitk}/po/.gitignore   | 0
 {gitk-git => subprojects/gitk}/po/bg.po        | 0
 {gitk-git => subprojects/gitk}/po/ca.po        | 0
 {gitk-git => subprojects/gitk}/po/de.po        | 0
 {gitk-git => subprojects/gitk}/po/es.po        | 0
 {gitk-git => subprojects/gitk}/po/fr.po        | 0
 {gitk-git => subprojects/gitk}/po/hu.po        | 0
 {gitk-git => subprojects/gitk}/po/it.po        | 0
 {gitk-git => subprojects/gitk}/po/ja.po        | 0
 {gitk-git => subprojects/gitk}/po/meson.build  | 0
 {gitk-git => subprojects/gitk}/po/po2msg.sh    | 0
 {gitk-git => subprojects/gitk}/po/pt_br.po     | 0
 {gitk-git => subprojects/gitk}/po/pt_pt.po     | 0
 {gitk-git => subprojects/gitk}/po/ru.po        | 0
 {gitk-git => subprojects/gitk}/po/sv.po        | 0
 {gitk-git => subprojects/gitk}/po/ta.po        | 0
 {gitk-git => subprojects/gitk}/po/vi.po        | 0
 {gitk-git => subprojects/gitk}/po/zh_cn.po     | 0
 27 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 3aca70728c7..7492db36d0a 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -705,7 +705,7 @@ repositories.
 
    Contibutions should go via the git mailing list.
 
-- `gitk-git/` comes from the gitk project, maintained by Johannes Sixt:
+- `subprojects/gitk/` comes from the gitk project, maintained by Johannes Sixt:
 
 	https://github.com/j6t/gitk
 
diff --git a/Documentation/gitk.adoc b/Documentation/gitk.adoc
index 58ce40ddb11..284266711f1 100644
--- a/Documentation/gitk.adoc
+++ b/Documentation/gitk.adoc
@@ -170,7 +170,7 @@ tcl/tk.
 versions are distributed as part of the Git suite for the convenience
 of end users.
 
-gitk-git/ comes from Paul Mackerras's gitk project:
+subprojects/gitk/ comes from Paul Mackerras's gitk project:
 
 	git://ozlabs.org/~paulus/gitk
 
diff --git a/Makefile b/Makefile
index 834b79ca7ec..861b0b98594 100644
--- a/Makefile
+++ b/Makefile
@@ -2458,7 +2458,7 @@ endif
 all::
 ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)subprojects/git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
-	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
+	$(QUIET_SUBDIR0)subprojects/gitk $(QUIET_SUBDIR1) all
 endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 
@@ -3568,7 +3568,7 @@ ifndef NO_PERL
 	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
 endif
 ifndef NO_TCLTK
-	$(MAKE) -C gitk-git install
+	$(MAKE) -C subprojects/gitk install
 	$(MAKE) -C subprojects/git-gui gitexecdir='$(gitexec_instdir_SQ)' install
 endif
 ifneq (,$X)
@@ -3786,7 +3786,7 @@ endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 ifndef NO_TCLTK
-	$(MAKE) -C gitk-git clean
+	$(MAKE) -C subprojects/gitk clean
 	$(MAKE) -C subprojects/git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 96388dbdd22..fd66efe7100 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -1,2 +1,3 @@
 /*/
 !/git-gui/
+!/gitk/
diff --git a/gitk-git/.gitignore b/subprojects/gitk/.gitignore
similarity index 100%
rename from gitk-git/.gitignore
rename to subprojects/gitk/.gitignore
diff --git a/gitk-git/Makefile b/subprojects/gitk/Makefile
similarity index 100%
rename from gitk-git/Makefile
rename to subprojects/gitk/Makefile
diff --git a/gitk-git/generate-tcl.sh b/subprojects/gitk/generate-tcl.sh
similarity index 100%
rename from gitk-git/generate-tcl.sh
rename to subprojects/gitk/generate-tcl.sh
diff --git a/gitk-git/gitk b/subprojects/gitk/gitk
similarity index 100%
rename from gitk-git/gitk
rename to subprojects/gitk/gitk
diff --git a/gitk-git/meson.build b/subprojects/gitk/meson.build
similarity index 100%
rename from gitk-git/meson.build
rename to subprojects/gitk/meson.build
diff --git a/gitk-git/po/.gitignore b/subprojects/gitk/po/.gitignore
similarity index 100%
rename from gitk-git/po/.gitignore
rename to subprojects/gitk/po/.gitignore
diff --git a/gitk-git/po/bg.po b/subprojects/gitk/po/bg.po
similarity index 100%
rename from gitk-git/po/bg.po
rename to subprojects/gitk/po/bg.po
diff --git a/gitk-git/po/ca.po b/subprojects/gitk/po/ca.po
similarity index 100%
rename from gitk-git/po/ca.po
rename to subprojects/gitk/po/ca.po
diff --git a/gitk-git/po/de.po b/subprojects/gitk/po/de.po
similarity index 100%
rename from gitk-git/po/de.po
rename to subprojects/gitk/po/de.po
diff --git a/gitk-git/po/es.po b/subprojects/gitk/po/es.po
similarity index 100%
rename from gitk-git/po/es.po
rename to subprojects/gitk/po/es.po
diff --git a/gitk-git/po/fr.po b/subprojects/gitk/po/fr.po
similarity index 100%
rename from gitk-git/po/fr.po
rename to subprojects/gitk/po/fr.po
diff --git a/gitk-git/po/hu.po b/subprojects/gitk/po/hu.po
similarity index 100%
rename from gitk-git/po/hu.po
rename to subprojects/gitk/po/hu.po
diff --git a/gitk-git/po/it.po b/subprojects/gitk/po/it.po
similarity index 100%
rename from gitk-git/po/it.po
rename to subprojects/gitk/po/it.po
diff --git a/gitk-git/po/ja.po b/subprojects/gitk/po/ja.po
similarity index 100%
rename from gitk-git/po/ja.po
rename to subprojects/gitk/po/ja.po
diff --git a/gitk-git/po/meson.build b/subprojects/gitk/po/meson.build
similarity index 100%
rename from gitk-git/po/meson.build
rename to subprojects/gitk/po/meson.build
diff --git a/gitk-git/po/po2msg.sh b/subprojects/gitk/po/po2msg.sh
similarity index 100%
rename from gitk-git/po/po2msg.sh
rename to subprojects/gitk/po/po2msg.sh
diff --git a/gitk-git/po/pt_br.po b/subprojects/gitk/po/pt_br.po
similarity index 100%
rename from gitk-git/po/pt_br.po
rename to subprojects/gitk/po/pt_br.po
diff --git a/gitk-git/po/pt_pt.po b/subprojects/gitk/po/pt_pt.po
similarity index 100%
rename from gitk-git/po/pt_pt.po
rename to subprojects/gitk/po/pt_pt.po
diff --git a/gitk-git/po/ru.po b/subprojects/gitk/po/ru.po
similarity index 100%
rename from gitk-git/po/ru.po
rename to subprojects/gitk/po/ru.po
diff --git a/gitk-git/po/sv.po b/subprojects/gitk/po/sv.po
similarity index 100%
rename from gitk-git/po/sv.po
rename to subprojects/gitk/po/sv.po
diff --git a/gitk-git/po/ta.po b/subprojects/gitk/po/ta.po
similarity index 100%
rename from gitk-git/po/ta.po
rename to subprojects/gitk/po/ta.po
diff --git a/gitk-git/po/vi.po b/subprojects/gitk/po/vi.po
similarity index 100%
rename from gitk-git/po/vi.po
rename to subprojects/gitk/po/vi.po
diff --git a/gitk-git/po/zh_cn.po b/subprojects/gitk/po/zh_cn.po
similarity index 100%
rename from gitk-git/po/zh_cn.po
rename to subprojects/gitk/po/zh_cn.po

-- 
2.51.0.261.g7ce5a0a67e.dirty

