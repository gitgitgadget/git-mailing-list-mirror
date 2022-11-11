Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE9C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 07:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiKKHfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 02:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiKKHfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 02:35:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5267579D18
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 23:35:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so5357637wrb.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 23:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6FCyrFXbh3obm2y4A9Slp4FVhb+lEF3leBe8lle/Y0=;
        b=LGFlCIeZ9iXFwRCt0ZPUrwUvrfJAvJCrVurXDQFjmCTqdPVUY7B0Zh480dV3+NbyYj
         UQ+NGKOfQWaYTFARLZvJZbhXHrU/PkxU6czoekUvQO6VBS3PRJT912u82NWRwWB+LTcq
         ELUurF7S2UJKbIfpMczIbjAA+u6r5zHNGOO0lHR1i3nnu69ky8ZHnXxS+6prMXF+gpg0
         6X1SexsVQj+nLkLa7KCEAiN2Fj4O5wh8799LFIm1X7lPhQnLTt0iq1udHn2PtgrNOTjd
         gCNCr67VihCAQZXC+kuSyntkc6Kp33kVorLL6eSbogZEE8t5M55xApxJCtdvfNQlG177
         2/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6FCyrFXbh3obm2y4A9Slp4FVhb+lEF3leBe8lle/Y0=;
        b=JnI8CDAmovoQm6+ARy09S1O86DX/IpkTlYv9EcmWGIrO9NP3wspUUjj6uwSV27J51h
         P5JiTCueueKuzp5J9AL+/THBFl31hxKqVBNDgVctnBVnDhNqj0tPzzxGKg1XIkZkRcvF
         l/qIFTQDz8bS3L8HfFNZG37WRXivqPeZD0jhSX4yyc8caMMTjTKMDeDdeJagryGMugsW
         oo37MonxHyjfT7eQe+CRQuH4FKNaZ1A6BAImXnxeP53sTqSsFj2XC6t4OOfj4Xs+Ytpa
         pFg3GlctH22x8u3YZZFrxvAseGlySTmnuYxWfyOseyrNINmmzXlwmZuQxg/Rpun4aP18
         a5Tg==
X-Gm-Message-State: ANoB5pmNXnjyr81wHqRaALHX6OzTOQQBfInrYM8CTJPn205o9pi1gJ3S
        f/YHc1Y2ar71jT6YSqJ1/AWNxhAv5Ns=
X-Google-Smtp-Source: AA0mqf6NX5OmofQBYt19mRz/bjLKY6gacCD3Soozi9xJ7rCFZN143QL6bNjP8eJGeW8eagjId3kEDg==
X-Received: by 2002:adf:fb01:0:b0:22e:5291:c4b0 with SMTP id c1-20020adffb01000000b0022e5291c4b0mr435378wrr.449.1668152098605;
        Thu, 10 Nov 2022 23:34:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c1c8700b003c6b7f5567csm11845323wms.0.2022.11.10.23.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:34:58 -0800 (PST)
Message-Id: <3cb4ff4d330acf0f6feaa53c499d1931cc793dc6.1668152094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
        <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 07:34:54 +0000
Subject: [PATCH v2 3/3] chainlint: prefix annotated test definition with line
 numbers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

When chainlint detects problems in a test, it prints out the name of the
test script, the name of the problematic test, and a copy of the test
definition with "?!FOO?!" annotations inserted at the locations where
problems were detected. Taken together this information is sufficient
for the test author to identify the problematic code in the original
test definition. However, in a lengthy script or a lengthy test
definition, the author may still end up using the editor's search
feature to home in on the exact problem location.

To further assist the test author, display line numbers along with the
annotated test definition, thus allowing the author to jump directly to
each problematic line.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/Makefile     |  2 +-
 t/chainlint.pl | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 882782a519c..2c2b2522402 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -94,7 +94,7 @@ check-chainlint:
 		done \
 	} >'$(CHAINLINTTMP_SQ)'/expect && \
 	$(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
-		grep -v '^[ 	]*$$' >'$(CHAINLINTTMP_SQ)'/actual && \
+		sed -e 's/^[1-9][0-9]* //;/^[ 	]*$$/d' >'$(CHAINLINTTMP_SQ)'/actual && \
 	if test -f ../GIT-BUILD-OPTIONS; then \
 		. ../GIT-BUILD-OPTIONS; \
 	fi && \
diff --git a/t/chainlint.pl b/t/chainlint.pl
index 67c2c5ebee8..4e47e808d01 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -614,6 +614,7 @@ sub check_test {
 	my $problems = $parser->{problems};
 	return unless $emit_all || @$problems;
 	my $c = main::fd_colors(1);
+	my $lineno = $_[1]->[3];
 	my $start = 0;
 	my $checked = '';
 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
@@ -623,10 +624,12 @@ sub check_test {
 		$start = $pos;
 	}
 	$checked .= substr($body, $start);
-	$checked =~ s/^\n//;
+	$checked =~ s/^/$lineno++ . ' '/mge;
+	$checked =~ s/^\d+ \n//;
 	$checked =~ s/(\s) \?!/$1?!/mg;
 	$checked =~ s/\?! (\s)/?!$1/mg;
 	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
+	$checked =~ s/^\d+/$c->{dim}$&$c->{reset}/mg;
 	$checked .= "\n" unless $checked =~ /\n$/;
 	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
 }
@@ -658,7 +661,7 @@ if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
 # thread and ignore %ENV changes in subthreads.
 $ENV{TERM} = $ENV{USER_TERM} if $ENV{USER_TERM};
 
-my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '', green => '', red => '');
+my @NOCOLORS = (bold => '', rev => '', dim => '', reset => '', blue => '', green => '', red => '');
 my %COLORS = ();
 sub get_colors {
 	return \%COLORS if %COLORS;
@@ -669,6 +672,7 @@ sub get_colors {
 	if ($ENV{TERM} =~ /xterm|xterm-\d+color|xterm-new|xterm-direct|nsterm|nsterm-\d+color|nsterm-direct/) {
 		%COLORS = (bold  => "\e[1m",
 			   rev   => "\e[7m",
+			   dim   => "\e[2m",
 			   reset => "\e[0m",
 			   blue  => "\e[34m",
 			   green => "\e[32m",
@@ -678,9 +682,11 @@ sub get_colors {
 	if (system("tput sgr0 >/dev/null 2>&1") == 0 &&
 	    system("tput bold >/dev/null 2>&1") == 0 &&
 	    system("tput rev  >/dev/null 2>&1") == 0 &&
+	    system("tput dim  >/dev/null 2>&1") == 0 &&
 	    system("tput setaf 1 >/dev/null 2>&1") == 0) {
 		%COLORS = (bold  => `tput bold`,
 			   rev   => `tput rev`,
+			   dim   => `tput dim`,
 			   reset => `tput sgr0`,
 			   blue  => `tput setaf 4`,
 			   green => `tput setaf 2`,
-- 
gitgitgadget
