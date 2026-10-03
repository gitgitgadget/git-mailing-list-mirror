Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCCC2931EE
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033062; cv=none; b=bwEs3lFvdzVmByFK037lpcqLeQyvPVptiHN5CnjU+VqRfwPgCaPdS16d81B/tZyiV3BtgGYMFY9GkcSVUZDGe3nIZIBNObysgEC07VAFQFwDmMslH1+d65ZVOdVOeTVZiLNnKotTMy6WqP0yij4PDBC53RHEp+AzSnnzn7ru8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033062; c=relaxed/simple;
	bh=JEe+DOliG6y2/6drSlnkXMpHqHamvG6xDH9rPBiGK+w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tLlF4rqQTHczOD5D+kH6oQR5bbTgalIxIsQjwQbFdf+vJse2h6Q5I8WySf0VJkLdIzpN1gRxVP5OoVfHob9QjfjwXQwLDBqt24FxUsbcJdvLlei+cLi1qjPrvWs6yPmtDHhulhuqlHApi8mvGLwZ+djSbqUdPKWYQFKflvePC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qL7Rr/xs; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL7Rr/xs"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-49dfaa16190so391780fac.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791033060; x=1791637860; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P9ileaihWDmF0SMPhTL4IHYxY73We02lxeJDFDHNK0E=;
        b=qL7Rr/xsm5ePCaz9AAlZd2ERGDCX0tAU0ft2iFoNo+5bL3r4egwHXIKXRRqGOCAyjG
         +GuC5/5+ENQ0i5nQXGqlwarncBxEu28o4bTwNcCyVISdT1GYQN/DsQhlAlZcT3YAnqKa
         93XJToB0+C7rJ0OpzZ+bML3xDdeJYD71qlVi1HXBBY3acQjQIx2jcGQi597XoFYfieSN
         en2VAAEc2Er+TFsaDFEmttOhL9RQ17FayMJWfFmDhMPYDgBrcNVLOqewCx3qVglt4Ow6
         xP7rofN4qb5ZKJPgOPahBsdcYrjsIoBk8sq8kLh6/C16b2MON7fxXUWq6l/wBTep4DSr
         KnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791033060; x=1791637860;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9ileaihWDmF0SMPhTL4IHYxY73We02lxeJDFDHNK0E=;
        b=mbk5N5XJ/v6jnCnozDsxFtbNx877gz3NFyVg/+xQApJWpjR/DCb3p7/nRW32n51wNZ
         aPsdCKLOEHqUmX4P27Tn3/E6GxTF4BbhWHiZonAk/QoHaVeKBLo4/kHiM4PVrO2VyKnJ
         RacoYHk8ezUIoJR48mA/M7wo3yjvrwya+ykamRkFUapKSmRWbgtOp9XRQytMwg8c8Hfr
         m3LMZdUPdC/QRFAutcZk6kvGgz546Zu+slZKhMjuLYoTiYZNue0ZYu9EN5VWO17f82W4
         VOddKTbjOfnuG2N+y9UHZlioLIaVfoghta/2pIboavSMrrK6iQKNUOV1aqXCjGO3WXMQ
         Pcvw==
X-Gm-Message-State: AFq9FYLXq3wIcwD6RzVEqAnHGoAUNnRCr/aw0xa55EZY1bhOgSk7slaF
	T/00mk7VooGbwIU7/0KlTh1CQfu6hb55mWZ85i9sKdvukzNS45J5Q9y5PNx/DpUp
X-Gm-Gg: AYBFou0/8nGh8SdfpqFN7UW/Rtr5kegi4LaZzY1qq4P105LrD541IAAph+nOQethmNG
	nt3Q/EiRQ3ksBqK5WksKBzm8jhAuVGGqGDcFE/SnrmxOMGOjtDcJIvRC2a2Kol02IdBYJ2FYMCP
	OpX5/OKKXrl8eJFGh6BIkIL1ILmW/fgMup75SANNdnP+OMhxVbPRDZmCTHYzoplw5GxkyzFkVvP
	1Mawh46RDRy/er7PjQggmTFA19QZUp+9vK0dC7xcqvgOvOWy2xZk9sIoZlojNdXMS57N364931U
	0bdDtIBsHt89JIsXCknRjAqNQRtFSZ+5l3vE1FvHEYmrA0KpGlE/jaSCP2FU420k4jlPgByShby
	EVTMeYc86s7cjecX4nGPOHv+pM+ZkTY0w7yVl1rSr9L4aFFf2egnESTnoxCVTxqHA8wFKKr8QTJ
	J6FglwIwtk8bo2FdWW8IwSgOTazzLp6Sv3YxHMtvss9oe3xxzKZDVIvfQQPe3S1b0IoJX7Qxwt9
	7sKxoAYIZkg
X-Received: by 2002:a05:6870:3329:b0:470:e97e:8f87 with SMTP id 586e51a60fabf-49df050bb6dmr6737111fac.23.1791033059861;
        Sat, 03 Oct 2026 06:10:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.133.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16f853cfsm4816396fac.17.2026.10.03.06.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 06:10:58 -0700 (PDT)
Message-Id: <pull.2246.v2.git.1791033057232.gitgitgadget@gmail.com>
In-Reply-To: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Oct 2026 13:10:57 +0000
Subject: [PATCH v2] doc: don't require a SYNOPSIS in section 7
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Tuomas Ahola <taahol@utu.fi>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove the SYNOPSIS section from the section 7 man pages where
appropriate, to avoid having a section that contains no information.
It's not the norm in section 7 to always require a SYNOPSIS.

Update the perl script with a special case for section 7.

Tested by running `make lint-docs`, and looked at the renaming synopses
with this fish script snippet:

for i in *.7
   echo $i; grep SYNOPSIS -A 5 (string replace .7 .adoc $i)
end

Co-authored-by: Tuomas Ahola <taahol@utu.fi>
Signed-off-by: Tuomas Ahola <taahol@utu.fi>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: don't require a SYNOPSIS in section 7
    
    Changes in v2: Tuomas rewrote the Perl script changes to be both more
    declarative and and more correct. Previously it didn't work if there
    were multiple files passed on the command line.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2246%2Fjvns%2Fno-synopsis-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2246/jvns/no-synopsis-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2246

Range-diff vs v1:

 1:  b6f8878a1f ! 1:  d6004e0c6b doc: don't require a SYNOPSIS in section 7
     @@ Commit message
             echo $i; grep SYNOPSIS -A 5 (string replace .7 .adoc $i)
          end
      
     +    Co-authored-by: Tuomas Ahola <taahol@utu.fi>
     +    Signed-off-by: Tuomas Ahola <taahol@utu.fi>
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/gitcli.adoc ##
     @@ Documentation/gitworkflows.adoc: NAME
       
      
       ## Documentation/lint-man-section-order.perl ##
     +@@ Documentation/lint-man-section-order.perl: my %SECTIONS;
     + 		},
     + 		'SYNOPSIS' => {
     + 			required => 1,
     ++			optional_in_man_sections => {
     ++				'7' => 1,
     ++			},
     + 			order => $order++,
     + 		},
     + 		'DESCRIPTION' => {
      @@ Documentation/lint-man-section-order.perl: sub report {
       	$exit_code = 1;
       }
       
     -+# assume the first line is formatted like 'gitglossary(7)'
     -+my $firstline = <>;
     -+$firstline =~ m/\((\d)\)/;
     -+my $man_section_number = $1;
     -+
     ++my $man_section_number;
       my $last_was_section;
       my @actual_order;
       while (my $line = <>) {
     + 	chomp $line;
     ++
     ++	if ($. == 1) {
     ++		# assume the first line is formatted like 'gitglossary(7)'
     ++		$line =~ m/\((\d)\)/;
     ++		$man_section_number = $1;
     ++	}
     ++
     + 	if ($line =~ $SECTION_RX) {
     + 		push @actual_order => $line;
     + 		$last_was_section = 1;
      @@ Documentation/lint-man-section-order.perl: while (my $line = <>) {
     + 		@actual_sections{@actual_order} = ();
       
       		for my $section (sort keys %SECTIONS) {
     - 			next if !$SECTIONS{$section}->{required} or exists $actual_sections{$section};
     -+			# Synopsis is not required in section 7
     -+			next if ($section eq "SYNOPSIS" && $man_section_number eq "7");
     +-			next if !$SECTIONS{$section}->{required} or exists $actual_sections{$section};
     ++			next if !$SECTIONS{$section}->{required} or
     ++				$SECTIONS{$section}->{optional_in_man_sections}->{$man_section_number} or
     ++				exists $actual_sections{$section};
       			report("has no required '$section' section!");
       		}
       


 Documentation/gitcli.adoc                 |  5 -----
 Documentation/gitcore-tutorial.adoc       |  4 ----
 Documentation/gitdatamodel.adoc           |  4 ----
 Documentation/giteveryday.adoc            |  5 -----
 Documentation/gitfaq.adoc                 |  4 ----
 Documentation/gitglossary.adoc            |  4 ----
 Documentation/gitpacking.adoc             |  4 ----
 Documentation/gitrevisions.adoc           |  5 -----
 Documentation/gittutorial-2.adoc          |  5 -----
 Documentation/gittutorial.adoc            |  5 -----
 Documentation/gitworkflows.adoc           |  6 ------
 Documentation/lint-man-section-order.perl | 15 ++++++++++++++-
 12 files changed, 14 insertions(+), 52 deletions(-)

diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 6815d6bfb7..9c4598e29c 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 gitcli - Git command-line interface and conventions
 
-SYNOPSIS
---------
-gitcli
-
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitcore-tutorial.adoc b/Documentation/gitcore-tutorial.adoc
index 2122aeb976..71fda63a1c 100644
--- a/Documentation/gitcore-tutorial.adoc
+++ b/Documentation/gitcore-tutorial.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitcore-tutorial - A Git core tutorial for developers
 
-SYNOPSIS
---------
-git *
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index 56b7635c19..8d9be02036 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitdatamodel - Git's core data model
 
-SYNOPSIS
---------
-gitdatamodel
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/giteveryday.adoc b/Documentation/giteveryday.adoc
index 6cfdd0e07b..0c9db2f150 100644
--- a/Documentation/giteveryday.adoc
+++ b/Documentation/giteveryday.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 giteveryday - A useful minimum set of commands for Everyday Git
 
-SYNOPSIS
---------
-
-Everyday Git With 20 Commands Or So
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitfaq.adoc b/Documentation/gitfaq.adoc
index f6c9b9d9f7..b26e4e3a09 100644
--- a/Documentation/gitfaq.adoc
+++ b/Documentation/gitfaq.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitfaq - Frequently asked questions about using Git
 
-SYNOPSIS
---------
-gitfaq
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitglossary.adoc b/Documentation/gitglossary.adoc
index b046d9cb29..eb1e60832e 100644
--- a/Documentation/gitglossary.adoc
+++ b/Documentation/gitglossary.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitglossary - A Git Glossary
 
-SYNOPSIS
---------
-*
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitpacking.adoc b/Documentation/gitpacking.adoc
index e6de6ec824..b0d952c797 100644
--- a/Documentation/gitpacking.adoc
+++ b/Documentation/gitpacking.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitpacking - Advanced concepts related to packing in Git
 
-SYNOPSIS
---------
-gitpacking
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitrevisions.adoc b/Documentation/gitrevisions.adoc
index 7146117de5..4412f84d83 100644
--- a/Documentation/gitrevisions.adoc
+++ b/Documentation/gitrevisions.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 gitrevisions - Specifying revisions and ranges for Git
 
-SYNOPSIS
---------
-gitrevisions
-
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gittutorial-2.adoc b/Documentation/gittutorial-2.adoc
index 8bdb7d0bd3..6a4d482ed6 100644
--- a/Documentation/gittutorial-2.adoc
+++ b/Documentation/gittutorial-2.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 gittutorial-2 - A tutorial introduction to Git: part two
 
-SYNOPSIS
---------
-[verse]
-git *
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutorial.adoc
index 519b8d8be2..03120ba191 100644
--- a/Documentation/gittutorial.adoc
+++ b/Documentation/gittutorial.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 gittutorial - A tutorial introduction to Git
 
-SYNOPSIS
---------
-[verse]
-git *
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitworkflows.adoc b/Documentation/gitworkflows.adoc
index 59305265c5..ad02828bff 100644
--- a/Documentation/gitworkflows.adoc
+++ b/Documentation/gitworkflows.adoc
@@ -5,12 +5,6 @@ NAME
 ----
 gitworkflows - An overview of recommended workflows with Git
 
-SYNOPSIS
---------
-[verse]
-git *
-
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
index 02408a0062..160c65e1be 100755
--- a/Documentation/lint-man-section-order.perl
+++ b/Documentation/lint-man-section-order.perl
@@ -13,6 +13,9 @@ my %SECTIONS;
 		},
 		'SYNOPSIS' => {
 			required => 1,
+			optional_in_man_sections => {
+				'7' => 1,
+			},
 			order => $order++,
 		},
 		'DESCRIPTION' => {
@@ -53,10 +56,18 @@ sub report {
 	$exit_code = 1;
 }
 
+my $man_section_number;
 my $last_was_section;
 my @actual_order;
 while (my $line = <>) {
 	chomp $line;
+
+	if ($. == 1) {
+		# assume the first line is formatted like 'gitglossary(7)'
+		$line =~ m/\((\d)\)/;
+		$man_section_number = $1;
+	}
+
 	if ($line =~ $SECTION_RX) {
 		push @actual_order => $line;
 		$last_was_section = 1;
@@ -92,7 +103,9 @@ while (my $line = <>) {
 		@actual_sections{@actual_order} = ();
 
 		for my $section (sort keys %SECTIONS) {
-			next if !$SECTIONS{$section}->{required} or exists $actual_sections{$section};
+			next if !$SECTIONS{$section}->{required} or
+				$SECTIONS{$section}->{optional_in_man_sections}->{$man_section_number} or
+				exists $actual_sections{$section};
 			report("has no required '$section' section!");
 		}
 

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
