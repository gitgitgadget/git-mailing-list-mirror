Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8611DFE22
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485831; cv=none; b=Dh6FL5wmRo8i0mn9I3JOCy303ccL/Psgu77AUG0VnPSmpf58bERn7LPFLILWZuRdipKgO1eGG/0b58rF5DCi8THOiBZgD2Mp6K292qRe4zLsCJ0HW+QOvWymWiKHQPJKJjrqaNLcsqYad8sNLyC4GFuYCtGoas2L3nOMsO+5mzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485831; c=relaxed/simple;
	bh=8EZFjoTHF1RX+PLdRNUJfauggSt/AqTn9gxKJUUNXnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxVbDppi1j7jjWLHy9imR0gVgE7gLOg3C4cBZ98uzYh+/YT2WOqQe+w3cFZLOKDEwsmHiVn6QBgPOB+QY1ZRCQwlcTzWBW86vQS/oTO87Oy81s1Mhuk/yVmjM5QSmXNA8tNYVuCKD7s5TmDfd9B5tBmWzglIyv8gEJzNGOwUI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RP8uGSNv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dk8heY2U; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RP8uGSNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dk8heY2U"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11DEC1140177;
	Wed,  9 Oct 2024 10:57:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 10:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485829; x=1728572229; bh=WHvFjAGkni
	03Np9KiVSMaa5ZGMj2/mSjQtAn/XARG6A=; b=RP8uGSNvwDQE8We0En2fFd47KV
	Uxx4kCaBzVcgfJCtAeMfVRjZaKuRJddZailJLP0w8J3T8G/6WjmHzDrvHLcOiyi0
	kVIFPHjJ4TAb3IctnQffDOCyf7gmK6EFaGFh/WEXYWKlE0vx6P7oQc07bv+G+0QP
	ndbShauE/Dapc265EPdu4FtnN7wl1ZNT62IhyUYEuwE5gnJC9fuc5aizYLgld/7Y
	3M+H2/jesRulud5WeLWK6axHBNbzIQckpzwusRyorNOfmVAGyu7BZ0NDfR6BM70P
	LPRPB+2M13TWRdqnPCoeldSAUSuXAM4f5XedWwD1zR1A2q0lqpQvUWn1fpag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485829; x=1728572229; bh=WHvFjAGkni03Np9KiVSMaa5ZGMj2
	/mSjQtAn/XARG6A=; b=dk8heY2UpjNizUJLF48Qq1N5aFoouUvozG29bRSMPxZG
	G4WdCX3bg37Ps7MHeUvdf4ocD4z01C7QXBehDaUFmMVMS7EIYRWsdeByshDJfUGa
	dos1DyeGsg74dK/JZApja78U414QaBhegWAYf2pvwLdGzKcN0EaDG3JIlS6o4KOu
	4BlFyUUxEwfWajAI406m6J4WEst7X/xefqqNSdRyfBq8E6yN1nhFFO5WPnELvtb3
	loJ/3kUOH/LMO6M2wJiN/sm6d7DWaIkO+dfqsHZikQ/RIq8hUKSfsR/kHWzHPxgg
	f1XNmergmCR+lT+542ZL0+IVHtdJIis6mZz8Ad0vHw==
X-ME-Sender: <xms:xJkGZ7pJ0ZFsk_39Nf-QCtmXcgAYVHfGUlqNoP9YeDreVsVDQTSBCA>
    <xme:xJkGZ1qcx6n9UptDD5vhPWLgIaOnJ2yeTiFGxeQr6BfFzJCSU8xFbR13fTjUxSlcN
    QE59InyfWQw6rZjkw>
X-ME-Received: <xmr:xJkGZ4PGzsa_k8tHKvaBjD9_xHOz32U-SGtx183NFHxtuojMaoG3zU0wp2kmkGXUZrhCNnH0-_V4q3c9xwngIKRILqpQ0AHrpXt2dLtE7HlDzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:xJkGZ-6jC0zLnLUJM_Ixc_I1RJUzgrr3mlcf-DHXMYPlmhlXupCQEw>
    <xmx:xJkGZ65k6JVTULa7B5KXs1O6Q78gmE8LNl1z2bucbyGJZV6g2AK50Q>
    <xmx:xJkGZ2jOtdNcR5YFM1xQJ_RNv0LOpsjRNuL2rrZ5dKMck3U-R3Y0yw>
    <xmx:xJkGZ87jV2YnVWPfztHvdUhCvcm0eNT2PlXqhch5G8Mc2EYNTww7Uw>
    <xmx:xZkGZ8QxE-kLRh7-CUzXmPAwcavUKrRBtDe_xqlskcfTvtCpYDQLZKP3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:57:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 554104fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:56:05 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:57:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 20/24] Makefile: simplify building of templates
Message-ID: <4eda54cf0f5a77152009e8fb9bde8dbea12a4e97.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

When we install Git we also install a set of default templates that both
git-init(1) and git-clone(1) populate into our build directories. The
way the pristine templates are layed out in our source directory is
somewhat weird though: instead of reconstructing the actual directory
hierarchy in "templates/", we represent directory separators with "--".

The only reason I could come up with for why we have this is the
"branches/" directory, which is supposed to be empty when installing it.
And as Git famously doesn't store empty directories at all we have to
work around this limitation.

Now the thing is that the "branches/" directory is a leftover to how
branches used to be stored in the dark ages. gitrepository-layout(5)
lists this directory as "slightly deprecated", which I would claim is a
strong understatement. I have never encountered anybody using it today
and would be surprised if it even works as expected. So having the "--"
hack in place for an item that is basically unused, unmaintained and
deprecated doesn't only feel unreasonable, but installing that entry by
default may also cause confusion for users that do not know what this is
supposed to be in the first place.

Remove this directory from our templates and, now that we do not require
the workaround anymore, restructure the templates to form a proper
hierarchy. This makes it way easier for build systems to install these
templates into place.

We should likely think about removing support for "branch/" altogether,
but that is outside of the scope of this patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt           |  8 +---
 templates/Makefile                            | 38 ++++++++++++-------
 templates/branches--                          |  1 -
 templates/{this--description => description}  |  0
 .../applypatch-msg.sample}                    |  0
 .../commit-msg.sample}                        |  0
 .../fsmonitor-watchman.sample}                |  0
 .../post-update.sample}                       |  0
 .../pre-applypatch.sample}                    |  0
 .../pre-commit.sample}                        |  0
 .../pre-merge-commit.sample}                  |  0
 .../pre-push.sample}                          |  0
 .../pre-rebase.sample}                        |  0
 .../pre-receive.sample}                       |  0
 .../prepare-commit-msg.sample}                |  0
 .../push-to-checkout.sample}                  |  0
 .../sendemail-validate.sample}                |  0
 .../update.sample}                            |  0
 templates/{info--exclude => info/exclude}     |  0
 19 files changed, 25 insertions(+), 22 deletions(-)
 delete mode 100644 templates/branches--
 rename templates/{this--description => description} (100%)
 rename templates/{hooks--applypatch-msg.sample => hooks/applypatch-msg.sample} (100%)
 rename templates/{hooks--commit-msg.sample => hooks/commit-msg.sample} (100%)
 rename templates/{hooks--fsmonitor-watchman.sample => hooks/fsmonitor-watchman.sample} (100%)
 rename templates/{hooks--post-update.sample => hooks/post-update.sample} (100%)
 rename templates/{hooks--pre-applypatch.sample => hooks/pre-applypatch.sample} (100%)
 rename templates/{hooks--pre-commit.sample => hooks/pre-commit.sample} (100%)
 rename templates/{hooks--pre-merge-commit.sample => hooks/pre-merge-commit.sample} (100%)
 rename templates/{hooks--pre-push.sample => hooks/pre-push.sample} (100%)
 rename templates/{hooks--pre-rebase.sample => hooks/pre-rebase.sample} (100%)
 rename templates/{hooks--pre-receive.sample => hooks/pre-receive.sample} (100%)
 rename templates/{hooks--prepare-commit-msg.sample => hooks/prepare-commit-msg.sample} (100%)
 rename templates/{hooks--push-to-checkout.sample => hooks/push-to-checkout.sample} (100%)
 rename templates/{hooks--sendemail-validate.sample => hooks/sendemail-validate.sample} (100%)
 rename templates/{hooks--update.sample => hooks/update.sample} (100%)
 rename templates/{info--exclude => info/exclude} (100%)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index e32ce8ce8b7..b95287468cd 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -878,23 +878,17 @@ endforeach()
 
 
 #templates
-file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
+file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/**")
 list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
 list(REMOVE_ITEM templates ".gitignore")
 list(REMOVE_ITEM templates "Makefile")
 list(REMOVE_ITEM templates "blt")# Prevents an error when reconfiguring for in source builds
 
-list(REMOVE_ITEM templates "branches--")
-file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
-
 #templates have @.*@ replacement so use configure_file instead
 foreach(tm ${templates})
-	string(REPLACE "--" "/" blt_tm ${tm})
-	string(REPLACE "this" "" blt_tm ${blt_tm})# for this--
 	configure_file(${CMAKE_SOURCE_DIR}/templates/${tm} ${CMAKE_BINARY_DIR}/templates/blt/${blt_tm} @ONLY)
 endforeach()
 
-
 #translations
 if(MSGFMT_EXE)
 	file(GLOB po_files "${CMAKE_SOURCE_DIR}/po/*.po")
diff --git a/templates/Makefile b/templates/Makefile
index 367ad00c24c..0b91d189257 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -29,24 +29,34 @@ all: boilerplates.made custom
 # in a file direc--tory--file in the source.  They will be
 # just copied to the destination.
 
-bpsrc = $(filter-out %~,$(wildcard *--*))
-boilerplates.made : $(bpsrc)
-	$(QUIET)umask 022 && ls *--* 2>/dev/null | \
-	while read boilerplate; \
+TEMPLATES  = description
+TEMPLATES += hooks/applypatch-msg.sample
+TEMPLATES += hooks/commit-msg.sample
+TEMPLATES += hooks/fsmonitor-watchman.sample
+TEMPLATES += hooks/post-update.sample
+TEMPLATES += hooks/pre-applypatch.sample
+TEMPLATES += hooks/pre-commit.sample
+TEMPLATES += hooks/pre-merge-commit.sample
+TEMPLATES += hooks/prepare-commit-msg.sample
+TEMPLATES += hooks/pre-push.sample
+TEMPLATES += hooks/pre-rebase.sample
+TEMPLATES += hooks/pre-receive.sample
+TEMPLATES += hooks/push-to-checkout.sample
+TEMPLATES += hooks/sendemail-validate.sample
+TEMPLATES += hooks/update.sample
+TEMPLATES += info/exclude
+
+boilerplates.made: $(TEMPLATES)
+	$(QUIET)umask 022 && for template in $(TEMPLATES); \
 	do \
-		case "$$boilerplate" in *~) continue ;; esac && \
-		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
-		dir=`expr "$$dst" : '\(.*\)/'` && \
+		dir=$$(dirname "$$template") && \
 		mkdir -p blt/$$dir && \
-		case "$$boilerplate" in \
-		*--) continue;; \
-		esac && \
 		sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 		    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-		    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' $$boilerplate > \
-			blt/$$dst && \
-		if test -x "$$boilerplate"; then rx=rx; else rx=r; fi && \
-		chmod a+$$rx "blt/$$dst" || exit; \
+		    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' $$template > \
+			blt/$$template && \
+		if test -x "$$template"; then rx=rx; else rx=r; fi && \
+		chmod a+$$rx "blt/$$template" || exit; \
 	done && \
 	date >$@
 
diff --git a/templates/branches-- b/templates/branches--
deleted file mode 100644
index fae88709a63..00000000000
--- a/templates/branches--
+++ /dev/null
@@ -1 +0,0 @@
-: this is just to ensure the directory exists.
diff --git a/templates/this--description b/templates/description
similarity index 100%
rename from templates/this--description
rename to templates/description
diff --git a/templates/hooks--applypatch-msg.sample b/templates/hooks/applypatch-msg.sample
similarity index 100%
rename from templates/hooks--applypatch-msg.sample
rename to templates/hooks/applypatch-msg.sample
diff --git a/templates/hooks--commit-msg.sample b/templates/hooks/commit-msg.sample
similarity index 100%
rename from templates/hooks--commit-msg.sample
rename to templates/hooks/commit-msg.sample
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks/fsmonitor-watchman.sample
similarity index 100%
rename from templates/hooks--fsmonitor-watchman.sample
rename to templates/hooks/fsmonitor-watchman.sample
diff --git a/templates/hooks--post-update.sample b/templates/hooks/post-update.sample
similarity index 100%
rename from templates/hooks--post-update.sample
rename to templates/hooks/post-update.sample
diff --git a/templates/hooks--pre-applypatch.sample b/templates/hooks/pre-applypatch.sample
similarity index 100%
rename from templates/hooks--pre-applypatch.sample
rename to templates/hooks/pre-applypatch.sample
diff --git a/templates/hooks--pre-commit.sample b/templates/hooks/pre-commit.sample
similarity index 100%
rename from templates/hooks--pre-commit.sample
rename to templates/hooks/pre-commit.sample
diff --git a/templates/hooks--pre-merge-commit.sample b/templates/hooks/pre-merge-commit.sample
similarity index 100%
rename from templates/hooks--pre-merge-commit.sample
rename to templates/hooks/pre-merge-commit.sample
diff --git a/templates/hooks--pre-push.sample b/templates/hooks/pre-push.sample
similarity index 100%
rename from templates/hooks--pre-push.sample
rename to templates/hooks/pre-push.sample
diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks/pre-rebase.sample
similarity index 100%
rename from templates/hooks--pre-rebase.sample
rename to templates/hooks/pre-rebase.sample
diff --git a/templates/hooks--pre-receive.sample b/templates/hooks/pre-receive.sample
similarity index 100%
rename from templates/hooks--pre-receive.sample
rename to templates/hooks/pre-receive.sample
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks/prepare-commit-msg.sample
similarity index 100%
rename from templates/hooks--prepare-commit-msg.sample
rename to templates/hooks/prepare-commit-msg.sample
diff --git a/templates/hooks--push-to-checkout.sample b/templates/hooks/push-to-checkout.sample
similarity index 100%
rename from templates/hooks--push-to-checkout.sample
rename to templates/hooks/push-to-checkout.sample
diff --git a/templates/hooks--sendemail-validate.sample b/templates/hooks/sendemail-validate.sample
similarity index 100%
rename from templates/hooks--sendemail-validate.sample
rename to templates/hooks/sendemail-validate.sample
diff --git a/templates/hooks--update.sample b/templates/hooks/update.sample
similarity index 100%
rename from templates/hooks--update.sample
rename to templates/hooks/update.sample
diff --git a/templates/info--exclude b/templates/info/exclude
similarity index 100%
rename from templates/info--exclude
rename to templates/info/exclude
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

