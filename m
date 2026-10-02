Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA93EF0A6
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923837; cv=none; b=q0itrDN5Ce8y9O1rYGFC+rbyUtC9yES5645HCfKX+C0fmzI7LMdtgKGBHN0liSeKxOjCI31J+HL3gl9nC1y/eCWoLreTxXOfJKUFrSB2r0PFsKLZSWpi9PDmRc/EkPvFAHIbRNWe7R7o0O7nmz79BOrUy4j92/N6eI6CBkG8F4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923837; c=relaxed/simple;
	bh=mcWGgl/zG7YXmPJxcxXQyc/9mASMt0A4CNaJ4mv9otk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=pxySsiOPY+6RZ5VmGxdFS9DQzDvTQHVmziqXfyor2bG6tfGozumivTwHb3DjLuQKrc9hm+WFtiVpWnevIwtVXlLMZ17DY3Tqh0mtyYNMkR8ATIyQjRBzia3Fq43ND7aYAaTtKQeQagLwLp0Y4KRqqC8pbkCZYF+9dWAGi2gZmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=CeKciY7Z; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="CeKciY7Z"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-821ff9f018bso890759a34.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1790923834; x=1791528634; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+5IBwtS5OxY3Xm7eNUndYeROzO20In5eib2wtWJ3KM=;
        b=CeKciY7Zy6/j2jrLWU9jZHSGpT/k/53XNsF23x9hY6LiLJdF0DfCaVLbbfnXETX/sV
         UWc3KcykZGoNat8XxVgx2c1NGrlAFqy0IEAtkeNPBWqz1qnAl5e9pgnfeSW2iQ6hoxQk
         cXvPIF5eK77CIrMWtOsfgQXZie08w73qvPeFKm4fc6syoHpB8q6aKRr5vAnk1VMzCA6E
         +XlXQC+EU6AkN9+CRS/cEdUYwFhppr4LPbIbo+y5xmgGsGTFKlmTEG4neHGaOtpiLIZp
         SYcuec+4vwLu49JAPo7Nf5jxbjno+9iz369iBiL8vyNxEdJPjAxZJ673MPOrp+qV5z2W
         nBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790923834; x=1791528634;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+5IBwtS5OxY3Xm7eNUndYeROzO20In5eib2wtWJ3KM=;
        b=bBL4FQVpCM9e8FmiU6m/2ffDrIYigrfqf53UpJ3PXy0dfSxBabDHVTUL+EO/40iUXH
         oqL5VnSBCI5BqbSj2JvHGDPqHnAN/m+YExyvWia/7SXqi6/KMFCKMb45pWjpSPZZjUwu
         rzPW3u6xla/tBVz0qoV+r9MrVb/RuEJSGFrN0Vx+zqbFwBFR4HrRRkMZnK5eygF95/tt
         8EQy3wpB40E6OFeFlfVB1TjlmBddwqvcrfHHghlNfURu3VTvnIfJMhd487bCV1lcaAen
         WAO1hl/CllmnUDF3/VSAnvK/dmx11VKFFOBzHqJVoIigXBXhzeC6vxfySsUVx7iOIrBM
         I8AA==
X-Gm-Message-State: AFuF++lttYpd3bSUu2xW8yVnPNzknp9e2reccCYnSZ0iUw9eRNb2n3zG
	6DX2n1FwvJbEZWbyFH7Qj9PWfH95IG/Zy//suDMFcXfLr2DLGR/eJoEcw69c4110StlSSNxM/f2
	xYoKm
X-Gm-Gg: AYBFou3IIE6yRwoUAdSDzv+HWZbOr0tTJBVKNqX6JPFGa9NxQU9qVbyVPcDnTR/0FEv
	GW8YKKnBtYWrbLJReJdkyfjqmEmKc4U+QMXzkH32OvPylGlnynjU8evWF8FlLJIsuplqBOpTeKK
	cyfJcKZ08sVQ2MFrdz/KbyXnFFA+emCwFZsgVVoD70T9QMsNzMDVab1KDIfpcKNbBi2tzdhd5OJ
	pN2s5+8pSfssOLFLZ0N9N/IbHMIjYpIoysUX25cKhrl0C5VA+9NjFnUcejBy74FJf0rF6L826yY
	9VxGoamp4RomiP/bpBnVoBIvHgUtRc03fOBQ+BiRKWlcgMO60/nYXk3+33ZxHujs2Hj6vpLC5Vx
	taVt9/6gRuEXkm6Fjd0IF5jlBG/t7ULwChkLxLMCIKr+CmlBCGJEmkcqpKetKUOMUbu12Z0zmtx
	GFc/X6T+/aRC1CmrATtZ9HO7sYmcQtSg1NGqXzOywGTxy4Lw/EH4xc1H1e4pDFT2b2X0KbJrjsz
	kzpotXTcoP3kDIXDMKH7ANFUnicrsMtGXWaVw8=
X-Received: by 2002:a05:6830:6587:b0:820:2aed:60b6 with SMTP id 46e09a7af769-8228396307cmr1962896a34.29.1790923834489;
        Thu, 01 Oct 2026 23:50:34 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a36943bsm2326834a34.19.2026.10.01.23.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 23:50:33 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Fri, 02 Oct 2026 00:50:20 -0600
Subject: [PATCH v6] git-contacts: allow inputting patch via stdin
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-git-contacts-stdin-v6-1-49878e872d3d@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PQW7DIBAF0KtErEsFGIjJqveouoBhYlPFdgTUa
 hX57oV04wXu8ksz7888SMIYMJHL6UEiriGFZS5Bv5wIjHYekAZfMhFMaGa4pEPIFJY5W8iJpuz
 DTDn2wpiOITeOlMV7xGv4fqLvH385fblPhFylOjGGlJf482xdeZ37t2DllFNjQYse9dUL9uZiG
 EY7gZ3uDm+3V1gmUqtWscdUExMFE4wpprk37GyPsW6Hia6JdQVT2nvZgZZe6WNM7rH2ZbK+6SR
 KB84ZDseY2mN9E1OUUTQOwaIDecY2tm3bL5vFz38EAgAA
X-Change-ID: 20260914-git-contacts-stdin-1e829930e19b
In-Reply-To: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
To: git@vger.kernel.org
Cc: Brigham Campbell <me@brighamcampbell.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4301;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=mcWGgl/zG7YXmPJxcxXQyc/9mASMt0A4CNaJ4mv9otk=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9b+ENNDy+8fv5/e2DuVt2nF9adMky8bZRzxaw/YtNGzl
 Glby9/1HaUsDGJcDLJiiiwqt2apX5xs/ehgBP8EmDmsTCBDGLg4BWAiHr0Mf6UTdK6tVCyPEtj3
 ZOGdQ5KuatPiVd/xqj9L+Btx9B7boyUM/3OPqfCa5OZwH2l7vqvq3xMLlw8Wklo6L3ZsLd2qbz1
 LhwMA
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Make git-contacts accept patch contents via stdin for better
interoperability with other utilities. Read from stdin when the user
passes `-` at least once:

$ git contacts - <patch

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
I verified the documentation changes by rendering html and inspecting
the output in a web browser.
---
Changes in v6:
- Squash documentation and code into a single commit
- Make documentation changes more complete
- Link to v5: https://patch.msgid.link/20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com

Changes in v5:
- Add a patch documenting stdin support
- Link to v4: https://patch.msgid.link/20260925-git-contacts-stdin-v4-1-9b4e4bcbb91c@brighamcampbell.com

Changes in v4:
- Don't imply that git-contacts processes input in any particular order
- Link to v3: https://patch.msgid.link/20260923-git-contacts-stdin-v3-1-56dd43c64d56@brighamcampbell.com

Changes in v3:
- Make user pass '-' instead of an empty argv and non-TTY stdin
- Link to v2: https://patch.msgid.link/20260915-git-contacts-stdin-v2-1-2005061d907a@brighamcampbell.com

Changes in v2:
- Minor variable cleanup / un-spaghettification
- Include update to usage comment
- Remove Cc trailers from commit message
- Link to v1: https://patch.msgid.link/20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com

To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
---
 contrib/contacts/git-contacts      | 11 ++++++++---
 contrib/contacts/git-contacts.adoc | 14 +++++++++++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 85ad732fc0..e4656affb5 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -3,7 +3,7 @@
 # List people who might be interested in a patch.  Useful as the argument to
 # git-send-email --cc-cmd option, and in other situations.
 #
-# Usage: git contacts <file | rev-list option> ...
+# Usage: git contacts <file | '-' | rev-list option> ...
 
 use strict;
 use warnings;
@@ -162,9 +162,11 @@ if (!@ARGV) {
 	die "No input revisions or patch files\n";
 }
 
-my (@files, @rev_args);
+my ($read_from_stdin, @files, @rev_args);
 for (@ARGV) {
-	if (-e) {
+	if ($_ eq '-') {
+		$read_from_stdin = 1;
+	} elsif (-e) {
 		push @files, $_;
 	} else {
 		push @rev_args, $_;
@@ -172,6 +174,9 @@ for (@ARGV) {
 }
 
 my %sources;
+if ($read_from_stdin) {
+	scan_patches(\%sources, undef, \*STDIN);
+}
 for (@files) {
 	scan_patch_file(\%sources, $_);
 }
diff --git a/contrib/contacts/git-contacts.adoc b/contrib/contacts/git-contacts.adoc
index dd914d1261..ea5dd58826 100644
--- a/contrib/contacts/git-contacts.adoc
+++ b/contrib/contacts/git-contacts.adoc
@@ -9,7 +9,7 @@ git-contacts - List people who might be interested in a set of changes
 SYNOPSIS
 --------
 [verse]
-'git contacts' (<patch>|<range>|<rev>)...
+'git contacts' (<patch>|'-'|<range>|<rev>)...
 
 
 DESCRIPTION
@@ -23,8 +23,10 @@ which touched the lines of files under consideration.
 Input consists of one or more patch files or revision arguments.  A revision
 argument can be a range or a single `<rev>` which is interpreted as
 `<rev>..HEAD`, thus the same revision arguments are accepted as for
-linkgit:git-format-patch[1]. Patch files and revision arguments can be combined
-in the same invocation.
+linkgit:git-format-patch[1].  A single dash `'-'` character in place of a
+`<patch>` tells the command to read patch file(s) from the standard input.
+Patch files, standard input, and revision arguments can be combined in the same
+invocation.
 
 This command can be useful for determining the list of people with whom to
 discuss proposed changes, or for finding the list of recipients to Cc: when
@@ -73,6 +75,12 @@ $ git contacts R1..R2
 $ git contacts origin
 ------------
 
+* Input a patch via stdin:
++
+------------
+$ git contacts - <feature.patch
+------------
+
 * Helper for `git send-email`:
 +
 ------------

---
base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
change-id: 20260914-git-contacts-stdin-1e829930e19b

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

