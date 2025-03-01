Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525671DE3CE
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843377; cv=none; b=fJOnA0b7sW8s0th439sZXz9q6J0VJGoS3dPOCPCZI+IEDsjMtotldAmCAUvaZ7hwJPt/vbKE0TtWaHrYzT8DvwdUfe0Rir4sFjA0LhLD2B7eZDe7wchnq1kditDHEI8Ukvkz6lA1tRtABrpEmsgOIxco+Vf8GTVfjdNyoDvViWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843377; c=relaxed/simple;
	bh=e2MPSCnGjtqAcv5gY3bDoqPNOe7HukU0+t/sPMZacak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWmUGGtFGZDcayNUi18W5Uf5PkG8RRQIzlD+vxXPiQfUJNsFrb1qoPsWtbUxXbzqVAIWGCrKFxAp7emBcfymIYudR81jO+zOJetNmTXWOXnjfjfXtKyuHl0Nx6azpCftXjXy/B1s+tOeKDznLt572d3524fyFr0IaRb9PhMNgNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iWOfluqk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMp+dTHx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWOfluqk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMp+dTHx"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 58D2611400CA;
	Sat,  1 Mar 2025 10:36:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 01 Mar 2025 10:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1740843374; x=
	1740929774; bh=iF8a7pvaC5ulhy9z/UMQ3cs70SfNpgsAgjmbPvb9ZOc=; b=i
	WOfluqkQQfcZN8zhd1ATjBV+2OwRQVm9DEGYxS/Pt7D+sSlH9A1wGH12JLuVnIOZ
	6105QlljC85QJX3cEOelR0Wg25pT1UaoosYZl32dbVbE+S+hu+Gz3QdgZ6Zy1b9O
	V/U7uDTJQp0U/tuHKlgBu7m12OahMxsXPDHbdROD/GOaNJ2eCd5pmmuItHs6NqxC
	idMv41AoGYMynVuPTC0A/7LJDzd/EgIQ0Xva6+47xC4osQjYISuw1lI+auDv0zKV
	O9X0XNYcdoB3H8jmcVMxpHnsGyrzjixtY6dhHiWgfTRvU1KrSFDUBCOxx3h4gdpg
	mxIP96ykrLDGPydvkpKnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740843374; x=1740929774; bh=i
	F8a7pvaC5ulhy9z/UMQ3cs70SfNpgsAgjmbPvb9ZOc=; b=BMp+dTHxGneu4kGo9
	OSUufCrNBBxeyQEHskRaLqSNgn3umU80S6vK/Rg1ROUVg5cwaH6ZyUI2+quPBLU1
	9OVM01SfQv/W8+jfrzgzCkVyuDVCos0G0EIC2nEjWzekuCwvdWbYkRtbejFvdaHI
	KNs6U2wfTNyn/UrCzHqiXprSUQNI624/QkU/nP8N2ynYEkkxAStEt7rnYNMe0upO
	yVhmD008FU9boCLbWatDHWx0blAAHthSWOtDUil4ZuCngd1yzYCohiihnOSbHpkh
	ppz6F1Od+oohwq/T5f0G/4IYke3CXagzSRU+1ka6yjEDa8q8mEQh8yk74ZAIeo5l
	YpnmA==
X-ME-Sender: <xms:binDZ2aaI4ihxXYAOATC8Cy7juXit5HaKfai6NK_F36DKgNZ3XWNAg>
    <xme:binDZ5Z93gUjpHc0MWEPiGk5GzeGdlAGwg8lW3X67c82if59PGCXePyyUWlawqvQH
    -5aMpaRCvoFT5PbkQ>
X-ME-Received: <xmr:binDZw-VODZUJEWY8-AQtvjGYhKedsha5ewRG692oJs32febHq7fwGLGag_CCuk0j1Yq4HdCTSrmta17oaAbFL4DV80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeejuefggfehieeugeeuheevgfegudetheetuedvveeu
    ueeileeuhfeigeefkeekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:binDZ4pdupxRT473IjoyCD-GDT2uWBN_HDpQbyqbMtcsTCxpDFNgvQ>
    <xmx:binDZxqU305vx5VVJXyKtgFdRRBtaU7jCzeR30V1rWEkzNFREOLOFw>
    <xmx:binDZ2QHIAkf_JtG_CnpYKMFQXPPmLjyAc63lhJb2s_SpB-w0-CxOQ>
    <xmx:binDZxqPFKQE0gU9tfK-Iv9gwI-p-sBcjD6dcmwb3Qzgl6C8lg9H7Q>
    <xmx:binDZyknOxVBHSnX1fyuXno8NlvpsJxCSVylHHeTDKdDztPQW28EWAHL>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 10:36:13 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] contrib/contacts: rename .txt to .adoc
Date: Sat,  1 Mar 2025 10:36:03 -0500
Message-ID: <20250301153607.95746-3-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250301153607.95746-1-tmz@pobox.com>
References: <20250301153607.95746-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
extension for AsciiDoc files, 2025-01-20).

Do the same for contrib/contacts.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/contacts/Makefile                                | 2 +-
 contrib/contacts/{git-contacts.txt => git-contacts.adoc} | 0
 contrib/contacts/meson.build                             | 4 ++--
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename contrib/contacts/{git-contacts.txt => git-contacts.adoc} (100%)

diff --git a/contrib/contacts/Makefile b/contrib/contacts/Makefile
index a2990f0dcb..9c4ca4f3bc 100644
--- a/contrib/contacts/Makefile
+++ b/contrib/contacts/Makefile
@@ -34,7 +34,7 @@ GIT_CONTACTS := git-contacts
 
 GIT_CONTACTS_DOC := git-contacts.1
 GIT_CONTACTS_XML := git-contacts.xml
-GIT_CONTACTS_TXT := git-contacts.txt
+GIT_CONTACTS_TXT := git-contacts.adoc
 GIT_CONTACTS_HTML := git-contacts.html
 
 doc: $(GIT_CONTACTS_DOC) $(GIT_CONTACTS_HTML)
diff --git a/contrib/contacts/git-contacts.txt b/contrib/contacts/git-contacts.adoc
similarity index 100%
rename from contrib/contacts/git-contacts.txt
rename to contrib/contacts/git-contacts.adoc
diff --git a/contrib/contacts/meson.build b/contrib/contacts/meson.build
index 6ec92f47c4..73d82dfe52 100644
--- a/contrib/contacts/meson.build
+++ b/contrib/contacts/meson.build
@@ -16,7 +16,7 @@ if get_option('docs').contains('man')
       '@INPUT@',
     ],
     depends: documentation_deps,
-    input: 'git-contacts.txt',
+    input: 'git-contacts.adoc',
     output: 'git-contacts.xml',
   )
 
@@ -47,7 +47,7 @@ if get_option('docs').contains('html')
       '@INPUT@',
     ],
     depends: documentation_deps,
-    input: 'git-contacts.txt',
+    input: 'git-contacts.adoc',
     output: 'git-contacts.html',
     install: true,
     install_dir: get_option('datadir') / 'doc/git-doc',
-- 
2.49.0.rc0

