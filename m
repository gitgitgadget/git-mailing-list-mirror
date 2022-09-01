Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0CECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiIAAaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiIAAaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2230422CA
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so2420357wmk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=g5sz2lNydeA2+NtaZNWjc4Wf0QYQKS+84cFK0G1aZg8=;
        b=PuyX7RcU1PhkN77LIOCx0uj0cRAy17fRYQSZ2C98rUKPEIdqjhZuFFeHsejQVcmH/P
         sqvQBvwjgboNurbD3DKmWoDenF8FFYUNReO2JC8T8Qm9zSwbTSwbM7hf1zTtmTuQWUMn
         atMKg8Rlojp+f2tHn5HajP/pHovafybpyVEcCto3Yzu5sszTCfMKzX0Cigs95sMCD7sl
         P8md7G41rWPpcD3VfwxnRIyyj+8aEKrf9LBG0xn4PUbAoLP9TH4JnKa10CMy+0lhusJD
         Y3IykPwtfAcnfCYaTCygq8Hwe79GWmIDz6BLB1Swx0gry9ivdy7ZpwJUNSwI0GR1ubWd
         h3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=g5sz2lNydeA2+NtaZNWjc4Wf0QYQKS+84cFK0G1aZg8=;
        b=T0GeuKijjulH/yqAkwXWwSD/lnD3a8tz+eBjgYUD0UhJhkGupxCNyKX0PBB7Se7pqm
         oQMDaD2pGpDKnLUT/0JwjSl4WfQ/xBDRZhWYcrr3awSG2WAQGeTd328zxxJhfxOMjRBq
         DvzigBlCWGBJ+RdHFgUOaYWEQ7KcninAWSGZZZvVKNyrhNFZGvjzd5GtFw3tZII8vR49
         ZSGV6K5jTEHXrxthZScIqK05qKDYneflFwQlvSrTTiACDdzpNUgL9iNCQv5inE4Y5t20
         XbXpgdI7jzi3dVtOuJIGa98ToakJoxhvuTddwyUhQ3ENUM7BzJg25URJS1mzqKLxu2mB
         CclA==
X-Gm-Message-State: ACgBeo1tbBR/1713h+OMwUA3OxH2kmQvRtDPxLFs9RAVju4Bz6JNYqjb
        q8t90CxOUCObXsP8t3LTfKTfJCk4CGI=
X-Google-Smtp-Source: AA6agR42F2XM9uJICIiFySSUZbNnQJ0kFL4DqPi2+kUFImf25cL93sNddfFNGDT/2jlOSrvripjFog==
X-Received: by 2002:a05:600c:4e8b:b0:3a5:f5bf:9c5a with SMTP id f11-20020a05600c4e8b00b003a5f5bf9c5amr3479048wmq.85.1661992205276;
        Wed, 31 Aug 2022 17:30:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay21-20020a05600c1e1500b003a536d5aa2esm3657937wmb.11.2022.08.31.17.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:04 -0700 (PDT)
Message-Id: <0de14477a42f2c18efb4b1e0ba52155645a7f0e2.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:43 +0000
Subject: [PATCH 05/18] chainlint.pl: add parser to identify test definitions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Finish fleshing out chainlint.pl by adding ScriptParser, a parser which
scans shell scripts for tests defined by test_expect_success() and
test_expect_failure(), plucks the test body from each definition, and
passes it to TestParser for validation. It recognizes test definitions
not only at the top-level of test scripts but also tests synthesized
within compound commands such as loops and function.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 63 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index ad257106e56..d526723ac00 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -487,18 +487,75 @@ DONE:
 	$self->SUPER::accumulate($tokens, $cmd);
 }
 
+# ScriptParser is a subclass of ShellParser which identifies individual test
+# definitions within test scripts, and passes each test body through TestParser
+# to identify possible problems. ShellParser detects test definitions not only
+# at the top-level of test scripts but also within compound commands such as
+# loops and function definitions.
 package ScriptParser;
 
+use base 'ShellParser';
+
 sub new {
 	my $class = shift @_;
-	my $self = bless {} => $class;
-	$self->{output} = [];
+	my $self = $class->SUPER::new(@_);
 	$self->{ntests} = 0;
 	return $self;
 }
 
+# extract the raw content of a token, which may be a single string or a
+# composition of multiple strings and non-string character runs; for instance,
+# `"test body"` unwraps to `test body`; `word"a b"42'c d'` to `worda b42c d`
+sub unwrap {
+	my $token = @_ ? shift @_ : $_;
+	# simple case: 'sqstring' or "dqstring"
+	return $token if $token =~ s/^'([^']*)'$/$1/;
+	return $token if $token =~ s/^"([^"]*)"$/$1/;
+
+	# composite case
+	my ($s, $q, $escaped);
+	while (1) {
+		# slurp up non-special characters
+		$s .= $1 if $token =~ /\G([^\\'"]*)/gc;
+		# handle special characters
+		last unless $token =~ /\G(.)/sgc;
+		my $c = $1;
+		$q = undef, next if defined($q) && $c eq $q;
+		$q = $c, next if !defined($q) && $c =~ /^['"]$/;
+		if ($c eq '\\') {
+			last unless $token =~ /\G(.)/sgc;
+			$c = $1;
+			$s .= '\\' if $c eq "\n"; # preserve line splice
+		}
+		$s .= $c;
+	}
+	return $s
+}
+
+sub check_test {
+	my $self = shift @_;
+	my ($title, $body) = map(unwrap, @_);
+	$self->{ntests}++;
+	my $parser = TestParser->new(\$body);
+	my @tokens = $parser->parse();
+	return unless $emit_all || grep(/\?![^?]+\?!/, @tokens);
+	my $checked = join(' ', @tokens);
+	$checked =~ s/^\n//;
+	$checked =~ s/^ //mg;
+	$checked =~ s/ $//mg;
+	$checked .= "\n" unless $checked =~ /\n$/;
+	push(@{$self->{output}}, "# chainlint: $title\n$checked");
+}
+
 sub parse_cmd {
-	return undef;
+	my $self = shift @_;
+	my @tokens = $self->SUPER::parse_cmd();
+	return @tokens unless @tokens && $tokens[0] =~ /^test_expect_(?:success|failure)$/;
+	my $n = $#tokens;
+	$n-- while $n >= 0 && $tokens[$n] =~ /^(?:[;&\n|]|&&|\|\|)$/;
+	$self->check_test($tokens[1], $tokens[2]) if $n == 2; # title body
+	$self->check_test($tokens[2], $tokens[3]) if $n > 2;  # prereq title body
+	return @tokens;
 }
 
 # main contains high-level functionality for processing command-line switches,
-- 
gitgitgadget

