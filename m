Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263581A08D7
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339060; cv=none; b=iqgwqNtybSLpBSQQUR+ykWUBn/VGHt8PEEV/Hk44Ug2TTLCG6w1fb7FbTBr9vfHrdItxmKMllIgCoZa3w2QDV1FreK4grDrKoyc9YxCOVG0G/Mkc1+cEgT/Ktcbzy83Dy+Dl2rmPqkeXJ0wQxSVcDyBaXBgNr/XNwgmQZH0Nluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339060; c=relaxed/simple;
	bh=jy7KjcOgLUoG7IpsfaKzZvLFE/NPyBRExKESVCPDdcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOMLeJLs17nI7/t+bJKKE8u+o28bOnDXma/3XeZtWTgw3S/q6S8sq1mtibF6OsCaiWwnuiXMtRL9Kl0LjgZOs9qCNLrtOWB2ZvNpl83RCi85EqK8dcLmtWCRTuObOvqvYkhoQ2Lk+WV4jWdxgJ71CvIS0CfGw3dLYsTdIS/UXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=revl7nPQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OpTvE9S5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="revl7nPQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OpTvE9S5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 429D5114019D;
	Mon, 11 Nov 2024 10:30:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 11 Nov 2024 10:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339056; x=1731425456; bh=VUmprZBNlV
	/FX0TcCZtSL4g+MKSgKtLZZb1IhpkCFfY=; b=revl7nPQTbZUpxskMaNI3y0YFW
	Y3jYVosIsWangoG/4RjiiR/DAeKJcUbeCOORlQG+BrddQpyXEbMzaSFCFAKSIeb0
	QL5VV3uJAl69RQceCVQp2T1wJXHJqQ2lyTN1NyZamWMpAcpNe9dasP1TCuhgR8TF
	nxinIDVBryN3ewZ/ssbVs1gc6h0yxUOB3RmBIvkoHl3SJMDS1GgktSX6Lm1xDQg/
	nbtM6eaW5qw572Sfd8OuEAO0vPoavEuBRHh+dUNJn+n/rODzwkzFjkR75SE9nSsc
	wIuxmBA2g8d3OFJ4408slS5CLFN+I7iNi2FYHvBQPB8RSdzwnN87kWL+ph8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339056; x=1731425456; bh=VUmprZBNlV/FX0TcCZtSL4g+MKSgKtLZZb1
	IhpkCFfY=; b=OpTvE9S58UOJEptgx+4XlNIyMf77T5uMTBZgq6yhfThpA5UdMSR
	KiaBpE+ukzg2UeOCyCVM/4Q9pZyXDz80QrG8q0GNmczBZZPzzZY411/VEYCt3+dN
	/0eAaZBInOMbuNk8YjjkzduExXAdWzJvEY+grf2FPeqIBOXGg4o9NV+76+57NtUY
	nj7fPPGr3tt2DK5NqZxlXFbzXtTp3fwF2kmpvIfER2q9fyuYAvmToMhmiEY/0w1v
	1jAdWN/qLbE83MzrtX2bx+li6LCIL8WXnT4ORFqlp1gnZVGlYa3p0M3QB9cmnh2l
	DrLX8PZMk5ONeQX80k7uZz5QRAznePRlZ1g==
X-ME-Sender: <xms:LyMyZ3jFdYmVmw_YLDcbcmTe18Md0OTEHHz0YmwZUIK9E6my8x4NaQ>
    <xme:LyMyZ0AAJbm5AJjqnJ09lV51wyx-jZjbDHYxb4R7urdxtEpgif7paRR0r5YspoGc3
    9ilCXeWwZfdaivmug>
X-ME-Received: <xmr:LyMyZ3HzWsWUJtpfZjFF1wn7-Az-9bEk49o5qWuR4KjCdNtsZK96X0u3DIyMCrLPMBXEHTZ5YPjGTUYsvsl6HJh-6ccOyAwLb9PI48apLq9Oxomf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstg
    hhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:MCMyZ0SZgG0jfggHjaEstbRM7iPRhdFUUOUMnmZItQUHqLCbagHnVw>
    <xmx:MCMyZ0weaKgaTd4xwzuc_-qMptEykKGD7NxQF7_lMrntoHPYhyjq8g>
    <xmx:MCMyZ67Kg5b9_GF-1FWyXNDBbIQZFg7aKnfhw5glVdUFvgGR2be4Ow>
    <xmx:MCMyZ5wxO61uViubLIHRUDLUxpcOQht5XYVglEkBozolWuRoN-YvvA>
    <xmx:MCMyZweTvt7bNXTBq3nOt08mXxIVFmFiL31WtK0pTudVJlCNNCq8qwjc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:30:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8bc54c4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:19 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:30:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 04/19] Makefile: extract script to massage Perl scripts
Message-ID: <442972984763cbc5ba768a2d7968576a8ed10e2e.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

Extract the script to inject various build-time parameters into our Perl
scripts into a standalone script. This is done such that we can reuse it
in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            | 12 ++----------
 contrib/buildsystems/CMakeLists.txt | 21 ++++++++++++++++-----
 generate-perl.sh                    | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 15 deletions(-)
 create mode 100755 generate-perl.sh

diff --git a/Makefile b/Makefile
index 22ed53f39e7..e04a381e8f0 100644
--- a/Makefile
+++ b/Makefile
@@ -2604,16 +2604,8 @@ endif
 
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
-$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN) \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	r GIT-PERL-HEADER' \
-	    -e '	G' \
-	    -e '}' \
-	    -e 's/@GIT_VERSION@/$(GIT_VERSION)/g' \
-	    $< >$@+ && \
-	chmod +x $@+ && \
+$(SCRIPT_PERL_GEN): % : %.perl generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION) GIT-PERL-HEADER "$<" "$@+" && \
 	mv $@+ $@
 
 PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 608ad9714d4..2ae337c61b5 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -848,19 +848,30 @@ foreach(script ${git_shell_scripts})
 endforeach()
 
 #perl scripts
-parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
+parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
 string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
 string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
+file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
 
 foreach(script ${git_perl_scripts})
-	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
-	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
-	string(REPLACE "@GIT_VERSION@" "${PROJECT_VERSION}" content "${content}")
-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+	string(REPLACE ".perl" "" perl_gen_path "${script}")
+
+	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
+		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
+			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
+			"${PROJECT_VERSION}"
+			"${CMAKE_BINARY_DIR}/PERL-HEADER"
+			"${CMAKE_SOURCE_DIR}/${script}"
+			"${CMAKE_BINARY_DIR}/${perl_gen_path}"
+		DEPENDS "${CMAKE_SOURCE_DIR}/generate-perl.sh"
+			"${CMAKE_SOURCE_DIR}/${script}"
+		VERBATIM)
+	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
 endforeach()
+add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
 
 #python script
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
diff --git a/generate-perl.sh b/generate-perl.sh
new file mode 100755
index 00000000000..12e116b76e5
--- /dev/null
+++ b/generate-perl.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 5
+then
+	echo "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION> <PERL_HEADER> <INPUT> <OUTPUT>" >&2
+	exit 1
+fi
+
+GIT_BUILD_OPTIONS="$1"
+GIT_VERSION="$2"
+PERL_HEADER="$3"
+INPUT="$4"
+OUTPUT="$5"
+
+. "$GIT_BUILD_OPTIONS"
+
+sed -e '1{' \
+    -e "	s|#!.*perl|#!$PERL_PATH|" \
+    -e "	r $PERL_HEADER" \
+    -e '	G' \
+    -e '}' \
+    -e "s/@GIT_VERSION@/$GIT_VERSION/g" \
+    "$INPUT" >"$OUTPUT"
+chmod a+x "$OUTPUT"
-- 
2.47.0.229.g8f8d6eee53.dirty

