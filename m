Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFFD8F7D
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853515; cv=none; b=eppCG+jB6mtF8M0VS0pgMBcrtUtNE0Esqq/rmBsCZen0rcy8afRCXtfmDsa+IyFmmaCoBuJkstIBqi3ZxzY64RKf/0vfJL/bMXT8z0OlcRrTaMGYQ14iZZfiJTtE4lqR9/2EuF1Be7OHgh18grKkHVKuXvciBOwmi612/Om8xaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853515; c=relaxed/simple;
	bh=I+g/w1LnQ1jF3i5SPnd0/fcjZrVXZJqIfHMz1iRBKeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mu/CjIFztXhXbu/LV56K7hEBXG6gRaIR5oxlwVZCsKn5hkGiL9JURKM2oBZR62vQiPzf4vKn45KoJUevrl2u6DGqRAp9O2K0u2GuCiOsfstwB7OfEwMKb1yuTMsLAQ7HLpY+bJHaD0FHGrua5uE4UwiVtuLsPJ3s01g4vTdiD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HqIHyl1N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5cgajItN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HqIHyl1N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5cgajItN"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C66E6138113F;
	Sat,  1 Mar 2025 13:25:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 01 Mar 2025 13:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740853512; x=1740939912; bh=66f1mijh1B
	vaAswTFApIE+5Vve5aXaSr8CdEw9UM/jM=; b=HqIHyl1N1S621ncWOMCUZKy5pG
	43fEBYMe36koAYMhmnEQNALpFlmcP1MPXLmHzaG7m2MzaNTJzvUOvFlUdd3r1vm+
	349vwNc6M4fvxasfkKc40cbs5CIFUOz/Od6xEsfa1K8xsvD4qzqz5jWkOpmOb9nA
	BYazagG5Sz5HWHUO3Qqcof/9djwo9hOCwnxqdKbD48kkN9KLlySb2WDbgc1993J3
	hBbq6cESK09RcN5TJlbhfhZ94w4gf42oyPNGooCNmhuoeMafLTKBV4K4uzOcw0Sh
	sLYpqbWhPk0DZkAJgkePskimunmKkw23toMDJJwM3p7KjdMcFGKG0HZg/VmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740853512; x=1740939912; bh=66f1mijh1BvaAswTFApIE+5Vve5aXaSr8Cd
	Ew9UM/jM=; b=5cgajItN/iOU/6zh65JO1kRYaVLynclfAFySMcq2gUBxBPgSutH
	oJhgPsKjwc77iJKg1qawW0D6dieEInu86ybG+P/eko2YWFvB19vzQ6kZskSA3Ihi
	P5WLbPCk3zHmXkPDWlzAV92hriFkxe5psvCDRLjXnCi4uPUgWl21YWbQRmmzGlNS
	0oezkcXB3xHCNa8PF/mMIq7ML/UWbFYa4vSvgkf9zaE4Hm+4sxoi94nfVQJnloCQ
	ATfXRs8FA+1RWH6bH5v50P5tIhl5nF+O1R8Y1HaP0ld3o3w856zHHqWwSPQ3YjsN
	sLU26DE3Kadd9wbsyMPtIM4iVN4wMOoRYYw==
X-ME-Sender: <xms:CFHDZ6PV2SuvnYc3ifGvn3BR6NGEQF-AkPFB7849r87idx3Utkfs2g>
    <xme:CFHDZ4-E6vW1JvYIKnvWJd3mhbu8X0pIUa9RtFJReU51kRpx2ZgTpKB64__q3q3P9
    8zQIix37uWZPyd7JQ>
X-ME-Received: <xmr:CFHDZxRDJ5WiP47xbcqYjpbcIia4IvdLg6WfE1wbzClkh2JOzKLetRP_hAcOHVgUbObwJmqopABlCFdSYCFc556QDhBYGtEZuXCl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:CFHDZ6vzTjvNKvJar6vz1i7B6Cbas_Ei-mGSew1moUlk1gQ3CO7aAA>
    <xmx:CFHDZycmcVdjzMDj07Iosh9baddz1ys5jzSbWpGT9_Fc7tLMXw65cg>
    <xmx:CFHDZ-3kTmIfjW8pmQBK5hwU3v0Y0jFCKNJqXkog2q531jiXoY3Lyw>
    <xmx:CFHDZ2_4XcDx9rttDL20djJLqG7nNjJ_261EDR_JiatxpDDErGhAEw>
    <xmx:CFHDZ_EEFy_CIJ1A0KT7tCkSjEX8G7Jkt3QOddaxwNliOD0cnEVaGm7C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 13:25:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Todd Zullinger <tmz@pobox.com>,  Patrick Steinhardt <ps@pks.im>,  "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 4/3] doc: fix build-docdep.perl
In-Reply-To: <xmqqh64czk7o.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	01 Mar 2025 10:20:27 -0800")
References: <20250301153607.95746-1-tmz@pobox.com>
	<xmqqh64czk7o.fsf@gitster.g>
Date: Sat, 01 Mar 2025 10:25:10 -0800
Message-ID: <xmqqcyf0zjzt.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We renamed from .txt to .adoc all the asciidoc source files and
necessary includes.  We also need to adjust the build-docdep tool to
work on files whose suffix is .adoc when computing the documentation
dependencies.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/build-docdep.perl | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git c/Documentation/build-docdep.perl w/Documentation/build-docdep.perl
index 315efaa2fa..781da12b2e 100755
--- c/Documentation/build-docdep.perl
+++ w/Documentation/build-docdep.perl
@@ -4,15 +4,15 @@
 my %include = ();
 my %included = ();
 
-for my $text (<*.txt>) {
-    open I, '<', $text || die "cannot read: $text";
+for my $adoc (<*.adoc>) {
+    open I, '<', $adoc || die "cannot read: $adoc";
     while (<I>) {
 	if (/^include::/) {
 	    chomp;
 	    s/^include::\s*//;
 	    s/\[\]//;
 	    s/{build_dir}/${build_dir}/;
-	    $include{$text}{$_} = 1;
+	    $include{$adoc}{$_} = 1;
 	    $included{$_} = 1;
 	}
     }
@@ -23,14 +23,14 @@
 my $changed = 1;
 while ($changed) {
     $changed = 0;
-    while (my ($text, $included) = each %include) {
+    while (my ($adoc, $included) = each %include) {
 	for my $i (keys %$included) {
-	    # $text has include::$i; if $i includes $j
-	    # $text indirectly includes $j.
+	    # $adoc has include::$i; if $i includes $j
+	    # $adoc indirectly includes $j.
 	    if (exists $include{$i}) {
 		for my $j (keys %{$include{$i}}) {
-		    if (!exists $include{$text}{$j}) {
-			$include{$text}{$j} = 1;
+		    if (!exists $include{$adoc}{$j}) {
+			$include{$adoc}{$j} = 1;
 			$included{$j} = 1;
 			$changed = 1;
 		    }
@@ -40,10 +40,10 @@
     }
 }
 
-foreach my $text (sort keys %include) {
-    my $included = $include{$text};
-    if (! exists $included{$text} &&
-	(my $base = $text) =~ s/\.txt$//) {
+foreach my $adoc (sort keys %include) {
+    my $included = $include{$adoc};
+    if (! exists $included{$adoc} &&
+	(my $base = $adoc) =~ s/\.adoc$//) {
 	print "$base.html $base.xml : ", join(" ", sort keys %$included), "\n";
     }
 }
