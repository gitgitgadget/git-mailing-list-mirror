Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE246C4DD
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305675; cv=none; b=b88xa1g54lXyEVJqEkR2roh1Pmk1/84Ri3Mh8bfHa/qZRhsUIqn4IkFzQoGZdO6CG342NIccC2wBVEYTKMnfc/+gDxFxE01lfpLpMnJKwpDHOOllWJufLzVZXgGQfuzshxG5uRWs7I4620cQExtEFUKH1VhpDB/IOdyS5YD7mug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305675; c=relaxed/simple;
	bh=WgQysKQ6hrbW3YLKwupValmxJqDBNxNfMV57kAUN1/w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EkGhp+Fy9cLNqDyP2gjgW9UfT6JSj1CZoJdoG9xfXJLyysf2ITWN/yGrhAfi49aDN8VYKQXISmeiPOcOKH6FPPkDsrOjRM1eJImGCZJ6FMJ1NA4th9X5Tt8WXJ+B+zh/w5EHU2a+Bo0+KmiMFzU+WivL/u+nZo6t+KEP3o5JPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGY4CzQH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGY4CzQH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so1471052a91.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791305673; x=1791910473; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6dcPlKlpGbKMqE7RkH2aTf4H5tGF5QAXJ9x+8f3GHt8=;
        b=KGY4CzQH2SnN1+UXL4OfoO7e7SJ7vVOzwHDvjlmHsBOJ1rPEfi66QIsYBcxvgf/CG/
         Vu9hayJ8w2jEgIKbyitBMWY1k5UvPNMzLp1ltYfotkorrIvR4dMosTavBSMUB7eDaDKF
         H4KCeW+BJ4q0vHUkyIe0Rr9UOZd7sQ57pDQIOdxEC9jyCVfdD3X5ynKP/tmcYIHSsMah
         IQLI2ff3zbP+fpL1KiVQ+U9hm/UcEpcCoh3qtJit4EquSjVVGjiHXnFY0aFFqwbOqTYq
         v5bk7AHQNipYoPsfXSGiEixBrbx/MDBC//ZzxXbXLhGb1sWtOxPb5FyMqZmojt3hfGd9
         ha5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791305673; x=1791910473;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dcPlKlpGbKMqE7RkH2aTf4H5tGF5QAXJ9x+8f3GHt8=;
        b=C5Ns1DM3ytQnARQO5pjS1T4c9X7kCSKntgVAsynL2biLdaUIDkzAOPpEM8b6rPERaB
         OS6Rat4Y6OJXrkXJV4wfOVUcGV1cfkVzPsijSyEDGRzggOFD0WGbXkCvXij/AeG1Z9Fs
         taBQ1xXl5ZdZYcTZ4ONWlSrDQ4apD74dk8z5d74fsbv6gf5EHgKyb42CsISanA7Lbd4Q
         c8VhytNotq8kx60pOngVXYBwpvToO6aMYry18Vygphu9iXjHVyOoMgGUFJmmr4KoEEnT
         cc/GUy8QUDH+/f8iANXEv/IuBIGTtz21UxS2fpViZW2ysYJluLeFRRivJ/ohTK6zLPtW
         DflQ==
X-Gm-Message-State: AFq9FYLsc+iQ0l6KFjqJyK3yOlApaf1qQL1Bv4JFT68t2GesFYAtZHYn
	rycfYQVKbAfm/n9ImcFsehjaqbiqWu82yRFxPA2MSTfTiWLnVT4P+ygkpB69uA==
X-Gm-Gg: AYBFou2f4a/nPZROI1ofPAMJ5E65mjAyrp4F63Oeec5aP+t57taB076rLmIFZiotnqP
	caCZliauvK4G2s6DpdjngcgR+InKOcLqpmP7HlSeiWvAadISZ9aKltUhRjtBc3QWgrfB7+9qfCO
	Kji39gsbUuOhhicKYPxLpSwa644joqj2LulftOKkmJmr5saQdbUPR4eYe7+S8rq9m2c1FO/0GOC
	7EZlA4FQci1jSwQZ4r3ElgFU9BwIwRintyO9Jgmb3XBlGRyy8wnbc53q0H7YjiP6qP+p1iME443
	GRGmpJ6tqqaeTc0AiNGnnpq7PiqYWvQcwXCGCxZvLeBE6UbwWewMzwr8x/lXv3I84maCXmKo7mR
	7CGQhDkVsVBzsB8Rf0soZG+wIYJw6kZ/WR+mttv4ohQ3DfRKVyQid8YqsACZhSZqr+HHlrK7r3c
	7KqQvdrrZkeSwPiExQIJIy21jfCDEqcKbXSJx5vq5Ofe8ZflTLNdp0rFfofKTIQLAlsLak5Ss1M
	RU=
X-Received: by 2002:a17:90b:3d92:b0:3a4:a850:6982 with SMTP id 98e67ed59e1d1-3a873530514mr1621392a91.26.1791305671953;
        Tue, 06 Oct 2026 09:54:31 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.11.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89b4a5619sm415254a91.10.2026.10.06.09.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:54:31 -0700 (PDT)
Message-Id: <pull.2246.v3.git.1791305670386.gitgitgadget@gmail.com>
In-Reply-To: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
References: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 16:54:30 +0000
Subject: [PATCH v3] doc: don't require a SYNOPSIS in section 7
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
    
    Changes in v3: Make sure that $man_section_number doesn't become
    undefined if the first line doesn't match the regex
    
    Tested on a file with a first line that isn't well-formatted to make
    sure it works and got this output:
    
    gitdatamodel.adoc:1: first line must be formatted like 'gitfaq(7)'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2246%2Fjvns%2Fno-synopsis-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2246/jvns/no-synopsis-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2246

Range-diff vs v2:

 1:  d6004e0c6b ! 1:  6359681fa1 doc: don't require a SYNOPSIS in section 7
     @@ Documentation/lint-man-section-order.perl: sub report {
       	chomp $line;
      +
      +	if ($. == 1) {
     -+		# assume the first line is formatted like 'gitglossary(7)'
      +		$line =~ m/\((\d)\)/;
      +		$man_section_number = $1;
     ++		if (!$man_section_number) {
     ++			report("first line must be formatted like 'gitfaq(7)'");
     ++			# exit to avoid dealing with $man_section_number being undefined later
     ++			last;
     ++		}
      +	}
      +
       	if ($line =~ $SECTION_RX) {


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
 Documentation/lint-man-section-order.perl | 19 ++++++++++++++++++-
 12 files changed, 18 insertions(+), 52 deletions(-)

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
index 02408a0062..35af3b8f67 100755
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
@@ -53,10 +56,22 @@ sub report {
 	$exit_code = 1;
 }
 
+my $man_section_number;
 my $last_was_section;
 my @actual_order;
 while (my $line = <>) {
 	chomp $line;
+
+	if ($. == 1) {
+		$line =~ m/\((\d)\)/;
+		$man_section_number = $1;
+		if (!$man_section_number) {
+			report("first line must be formatted like 'gitfaq(7)'");
+			# exit to avoid dealing with $man_section_number being undefined later
+			last;
+		}
+	}
+
 	if ($line =~ $SECTION_RX) {
 		push @actual_order => $line;
 		$last_was_section = 1;
@@ -92,7 +107,9 @@ while (my $line = <>) {
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
