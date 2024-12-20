Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F421221475
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723892; cv=none; b=QSJW+N0W2j2VBE//1yeM005lbt5xIxMFyXYOT+MqA3mB8dNERUMrsNpYkQnj5IGv6aFrNtHqLIEQmv9+Kz7Q24T0cwaLgGTzbHsooMF1hYRJsf/ABy8A4SwIpSKW5mPYMNYTYKQ4bH7ffJnZxumdz7PqtKXOj3gAzc1rBx0iA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723892; c=relaxed/simple;
	bh=1t/FfGdnA25Nzdf5cyBL0KtjEpJYvDv/F17cw4HsJR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CtZ5OYiD2KAdNNL671pUS4iDuKTbNCCE4CXlqvp7pcUEknKFVWBEB0eqbDxeWZ+IHyvwVfdbKajTIerPbdpc4YxYfhJ6noK9E9VI41anNttMSgT5fkJh8R7BU0K63Ft0mopQNZKEb4u3A6UrwXK+erYKmBWuYui5pQ1U1bpJ2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wxU6fGlW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4DBlr34h; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wxU6fGlW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4DBlr34h"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 24E1E11400C7;
	Fri, 20 Dec 2024 14:44:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Dec 2024 14:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734723888;
	 x=1734810288; bh=q8Y/Q2JsIIpyn74b9xgtzjcuPsOPWCy4jOw3Th31q9c=; b=
	wxU6fGlWS85GFrtimPbDdDKuDygWSy0E5KiV2ZPH39cLPMlm8NwCcX38x89sHB75
	PHTLe2fWttjzQYdMMteN2vB2Z4RbKw9PCou5NCEm6pIM0OxIs4fi1r+IX4hTGMKG
	hXxiGEZuMygQKIkV66mUFwnkvfX2fTpCTM6L6PAhlFAK3+6r0JvcJXQbFdz3M+c/
	gnqd7qc1qT54D8CmwZwrqZ3XSDjHWLN4qFfxA2oJyfA2TiM/u57sGPj2o1ogw+0q
	vAY1pKplTENtRw+wCvvVW8bk+xG/CLqQfOwvo0lnDmsuc/REPFmHaJmaDvTkcTWr
	I5Aah1S+jueCX4DZzzb3sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734723888; x=
	1734810288; bh=q8Y/Q2JsIIpyn74b9xgtzjcuPsOPWCy4jOw3Th31q9c=; b=4
	DBlr34hoEEzoHTpc7tb3noeA1DlABHgtDt3GBG5rddKGpmpi8RpMfJFmDn+Ewgj6
	vw7acOFZmMHATOZXCrqSSB+Hmrl3MoFhnEPgMvXfsNcSjekhn6OtPN+ebydjv21s
	8qausLXw5HVHLg5KrPaeTjhDLP+ClcMIHQopEHjh3k5mbRSxtJX17+CEhqzUfqhF
	MC2ifcNfNYAUcPO4XYAnvK0VIo5XM1XezK4vJGzzpApQWgwKDlOIWeKNSQLp0mU4
	O6EZYa0G9NmslfpxSh9w7jd2B28Or2yXmxGMt5G8nQZmjqv+/+TJp4TlFTjPkUax
	hHGDGkEXE1BOzSg8PyodQ==
X-ME-Sender: <xms:MMllZ1-KeLA0dJ2WkpxPrOZKVMWuDe4qEu3VvB6tBnUZKwc7u8Amuw>
    <xme:MMllZ5tgLqks-KkwkxgWsDPxcLPCddXEVke50u-W7hBy59Jis5E6rIiVC94FhvqnF
    Bl2UT6LRRIqb40pyQ>
X-ME-Received: <xmr:MMllZzC8ziNtUVAhoV00sF7CjXcuxH6ExBXduow6jqgE1ShPvNP-W5Ifa57ZtYrTjA86RmpbnGhxZTph77zes_JaTnq8NYZ33_KuwS7HH1vakfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefgfdtge
    ejieetledvleeifeeuieetfeffvefhffffvdettdefkeffteekkeeiheenucffohhmrghi
    nhepghhnuhdrohhrghdpmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:MMllZ5esPF3cHNozZ1K4zE0oazlV17Qkn4P4-GV2zbSDiUsOUTEiFg>
    <xmx:MMllZ6PqXH9MnzMQfG1wibx_lWma2RUO9S3v5w2vZxGmrmM5a2AEbA>
    <xmx:MMllZ7n1iN7ZEx0NxpNolxhMs7aay6UblIh9xhe2M_G9lSWp3w69Ag>
    <xmx:MMllZ0tnPjR4TukSYApNuijVjJ3oJEMJ4fbN8yMX0ytKZWsaNVkctw>
    <xmx:MMllZ3p0-1WA6LlPxct0YGujlj6JInicUbDUKOJHPB5pzUspXXmMF-xv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:44:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 874a2bb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:42:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 20:44:24 +0100
Subject: [PATCH v3 4/6] GIT-VERSION-GEN: fix overriding GIT_VERSION
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v3-4-1fd79b52a5fb@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

GIT-VERSION-GEN tries to derive the version that Git is being built from
via multiple different sources in the following order:

  1. A file called "version" in the source tree's root directory, if it
     exists.

  2. The current commit in case Git is built from a Git repository.

  3. Otherwise, we use a fallback version stored in a variable which is
     bumped whenever a new Git version is getting tagged.

It used to be possible to override the version by overriding the
`GIT_VERSION` Makefile variable (e.g. `make GIT_VERSION=foo`). This
worked somewhat by chance, only: `GIT-VERSION-GEN` would write the
actual Git version into `GIT-VERSION-FILE`, not the overridden value,
but when including the file into our Makefile we would not override the
`GIT_VERSION` variable because it has already been set by the user. And
because our Makefile used the variable to propagate the version to our
build tools instead of using `GIT-VERSION-FILE` the resulting build
artifacts used the overridden version.

But that subtle mechanism broke with 4838deab65 (Makefile: refactor
GIT-VERSION-GEN to be reusable, 2024-12-06) and subsequent commits
because the version information is not propagated via the Makefile
variable anymore, but instead via the files that `GIT-VERSION-GEN`
started to write. And as the script never knew about the `GIT_VERSION`
environment variable in the first place it uses one of the values listed
above instead of the overridden value.

Fix this issue by making `GIT-VERSION-GEN` handle the case where
`GIT_VERSION` has been set via the environment.

Note that this requires us to introduce a new GIT_VERSION_OVERRIDE
variable that stores a potential user-provided value, either via the
environment or via "config.mak". Ideally we wouldn't need it and could
just continue to use GIT_VERSION for this. But unfortunately, Makefiles
will first include all sub-Makefiles before figuring out whether it
needs to re-make any of them [1]. Consequently, if there already is a
GIT-VERSION-FILE, we would have slurped in its value of GIT_VERSION
before we call GIT-VERSION-GEN, and because GIT-VERSION-GEN now uses
that value as an override it would mean that the first generated value
for GIT_VERSION will remain unchanged.

Furthermore we have to move the include for "GIT-VERSION-FILE" after the
includes for "config.mak" and related so that GIT_VERSION_OVERRIDE can
be set to the value provided by "config.mak".

[1]: https://www.gnu.org/software/make/manual/html_node/Remaking-Makefiles.html

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile |  4 ++++
 GIT-VERSION-GEN        | 48 ++++++++++++++++++++++++++----------------------
 Makefile               | 19 ++++++++++++-------
 shared.mak             |  1 +
 4 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ff30ab6c4295525757f6a150ec4ff0c72487f440..a89823e1d1ee5042367bdcca6ed426196d49ce89 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -181,6 +181,10 @@ endif
 -include ../config.mak.autogen
 -include ../config.mak
 
+# Set GIT_VERSION_OVERRIDE such that version_gen knows to substitute
+# GIT_VERSION in case it was set by the user.
+GIT_VERSION_OVERRIDE := $(GIT_VERSION)
+
 ifndef NO_MAN_BOLD_LITERAL
 XMLTO_EXTRA += -m manpage-bold-literal.xsl
 endif
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index de0e63bdfbac263884e2ea328cc2ef11ace7a238..9b785da226eff2d7952d3306f45fd2933fdafaca 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -27,31 +27,35 @@ fi
 GIT_CEILING_DIRECTORIES="$SOURCE_DIR/.."
 export GIT_CEILING_DIRECTORIES
 
-# First see if there is a version file (included in release tarballs),
-# then try git-describe, then default.
-if test -f "$SOURCE_DIR"/version
+if test -z "$GIT_VERSION"
 then
-	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
-elif {
-		test -d "$SOURCE_DIR/.git" ||
-		test -d "${GIT_DIR:-.git}" ||
-		test -f "$SOURCE_DIR"/.git;
-	} &&
-	VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
-	case "$VN" in
-	*$LF*) (exit 1) ;;
-	v[0-9]*)
-		git -C "$SOURCE_DIR" update-index -q --refresh
-		test -z "$(git -C "$SOURCE_DIR" diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty" ;;
-	esac
-then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
-else
-	VN="$DEF_VER"
+	# First see if there is a version file (included in release tarballs),
+	# then try git-describe, then default.
+	if test -f "$SOURCE_DIR"/version
+	then
+		VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
+	elif {
+			test -d "$SOURCE_DIR/.git" ||
+			test -d "${GIT_DIR:-.git}" ||
+			test -f "$SOURCE_DIR"/.git;
+		} &&
+		VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
+		case "$VN" in
+		*$LF*) (exit 1) ;;
+		v[0-9]*)
+			git -C "$SOURCE_DIR" update-index -q --refresh
+			test -z "$(git -C "$SOURCE_DIR" diff-index --name-only HEAD --)" ||
+			VN="$VN-dirty" ;;
+		esac
+	then
+		VN=$(echo "$VN" | sed -e 's/-/./g');
+	else
+		VN="$DEF_VER"
+	fi
+
+	GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
 fi
 
-GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
 GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
 GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
 if test -z "$GIT_USER_AGENT"
diff --git a/Makefile b/Makefile
index 9cfe3d0aa968eff10379d22edff6cc6f4518c2ff..3cdd2278fdaa40feb6139992aa275ad26aaae4a6 100644
--- a/Makefile
+++ b/Makefile
@@ -591,13 +591,6 @@ include shared.mak
 #
 #        Disable -pedantic compilation.
 
-GIT-VERSION-FILE: FORCE
-	@OLD=$$(cat $@ 2>/dev/null || :) && \
-	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \
-	NEW=$$(cat $@ 2>/dev/null || :) && \
-	if test "$$OLD" != "$$NEW"; then echo "$$NEW" >&2; fi
--include GIT-VERSION-FILE
-
 # Set our default configuration.
 #
 # Among the variables below, these:
@@ -1465,6 +1458,18 @@ ifdef DEVELOPER
 include config.mak.dev
 endif
 
+GIT-VERSION-FILE: FORCE
+	@OLD=$$(cat $@ 2>/dev/null || :) && \
+	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \
+	NEW=$$(cat $@ 2>/dev/null || :) && \
+	if test "$$OLD" != "$$NEW"; then echo "$$NEW" >&2; fi
+
+# We need to set GIT_VERSION_OVERRIDE before including the version file as
+# otherwise any user-provided value for GIT_VERSION would have been overridden
+# already.
+GIT_VERSION_OVERRIDE := $(GIT_VERSION)
+-include GIT-VERSION-FILE
+
 # what 'all' will build and 'install' will install in gitexecdir,
 # excluding programs for built-in commands
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
diff --git a/shared.mak b/shared.mak
index b23c5505c9692b032cd0b18d3e4ede288614d937..a66f46969e301b35d88650f2c6abc6c0ba1b0f3d 100644
--- a/shared.mak
+++ b/shared.mak
@@ -122,5 +122,6 @@ endef
 # as arguments, in that order.
 define version_gen
 GIT_USER_AGENT="$(GIT_USER_AGENT)" \
+GIT_VERSION="$(GIT_VERSION_OVERRIDE)" \
 $(SHELL_PATH) "$(1)/GIT-VERSION-GEN" "$(1)" "$(2)" "$(3)"
 endef

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

