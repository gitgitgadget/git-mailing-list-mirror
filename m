Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97288C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 17:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKIRBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 12:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiKIRAz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 12:00:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DCC13EA8
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 08:58:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so26651584wrs.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXkbfX/y2huPC/dZjCOIXo5RszT66Kow8WyYzH+vLNE=;
        b=hPi9R3sW2zJvvymy41YjOgL5ztPiGzcOtPJCzsAfxr2SXA893Lxdyc72QBhTswrYox
         i8Di9rPwBHzcP05ecORR+CwsV9O+w/5XxTurzq9ThjkaBsbylgEWnE86tOGrRks7+HNW
         Y9+6HawdnYgKIsT1mKZVkTHvxKyTtoOT9WBi6jtTk5KUN5KNU/kl/j/oDXnm/D9hNCwI
         yrkaADm2zt/C3Wq9bV68Iv/VfbdNBhXJTbdOnWSfXjpBO3LkbjqQfLY0TV+zxcOUve88
         eFyvB4Sc7VkanbyaNYluXSB/rrh48zxqG98DzBfkZR1ytraEduQyQH3G1VTIpVa8X6yh
         Ug2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXkbfX/y2huPC/dZjCOIXo5RszT66Kow8WyYzH+vLNE=;
        b=U/uQsM9r05rejQa/9hzB6+SeRMV7JQ/RobeYHhhjI8CVb3QXR8WVbuMWUf9U9Y+A/I
         syci4onC04sjCMI4fVJE1FZfJCliAGv8E0ubMS3PwvnAeopeXjPZtMh4N141YMmeu9Xd
         U3aZFCKaPYMbOmZNaMzYHSO2jsAc6cCzNuPMQ7CYz8S+dkR37OWsyYnpZECqZwnP+6pn
         H/7xSyTLp64P9RiLOzGkRiywvThwbcTvsqyK3pe/nE+GbL/ntayQGZej1WGF4u+/IQFe
         HWJwyitQ4cnEmO3qVP7lPszOnvlZQPUlQhEIZALwSGTGQ+L52ecobuJ8OPAEtyC223S9
         kGlw==
X-Gm-Message-State: ACrzQf2N153XWnfD5AWq3d1jHYGX6ST+GB9yZbPcQyB2DzW7UC3ArBF8
        ITSxqfHB+DXCHDqVBbvW+34vxRmaV3k=
X-Google-Smtp-Source: AMsMyM5ZjLFmrlmqSCvl7FXb8vciGYyvI2lJp94E5SLLpqdTltDVRwq2p+lnxPInHB32RcpyKvKl9Q==
X-Received: by 2002:a5d:58d9:0:b0:236:5b81:2c99 with SMTP id o25-20020a5d58d9000000b002365b812c99mr39703329wrf.494.1668013123641;
        Wed, 09 Nov 2022 08:58:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c199100b003b4fdbb6319sm2307378wmq.21.2022.11.09.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:58:43 -0800 (PST)
Message-Id: <380b146abd1d97d51511c7acd11ffb99d1affcc6.1668013114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 16:58:34 +0000
Subject: [PATCH 3/3] chainlint: prefix annotated test definition with line
 numbers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
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
index 01f261165b1..48dde978480 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -613,6 +613,7 @@ sub check_test {
 	my $problems = $parser->{problems};
 	return unless $emit_all || @$problems;
 	my $c = main::fd_colors(1);
+	my $lineno = $_[1]->[3];
 	my $start = 0;
 	my $checked = '';
 	for (sort {$a->[1]->[2] <=> $b->[1]->[2]} @$problems) {
@@ -622,10 +623,12 @@ sub check_test {
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
@@ -657,7 +660,7 @@ if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
 # thread and ignore %ENV changes in subthreads.
 $ENV{TERM} = $ENV{USER_TERM} if $ENV{USER_TERM};
 
-my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '', green => '', red => '');
+my @NOCOLORS = (bold => '', rev => '', dim => '', reset => '', blue => '', green => '', red => '');
 my %COLORS = ();
 sub get_colors {
 	return \%COLORS if %COLORS;
@@ -668,6 +671,7 @@ sub get_colors {
 	if ($ENV{TERM} =~ /\bxterm\b/) {
 		%COLORS = (bold  => "\e[1m",
 			   rev   => "\e[7m",
+			   dim   => "\e[2m",
 			   reset => "\e[0m",
 			   blue  => "\e[34m",
 			   green => "\e[32m",
@@ -677,9 +681,11 @@ sub get_colors {
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
