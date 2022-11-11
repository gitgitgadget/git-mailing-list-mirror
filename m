Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5486AC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 07:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiKKHfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 02:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiKKHfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 02:35:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBE79D12
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 23:34:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso5021895wme.5
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 23:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9hQJpAEXF7ETyJBJagD4laIajYoDDRzBHFa3WSzqUw=;
        b=QZT68IStd0h7dK0SFZ9ZAI3o6tk8VJ4zHrBwrVZKIDCFALoNXjltFEZdilooqpwslJ
         Lou/B9+jBoT0KmEXvvpN4LvYjLHpT+6v1CmaenK+ykA52KOURJpd2/7U/8SiJNXHO5Uj
         PGAcDK4Uu8zLYKDJtsujy3YlDbKvjoAf0FWqduIl1uB3el/Xj0oQf8kR3YZ7n5Ggy3yb
         2EGPnFBBxrv1sVh8NePIx7PU0y7bgocJHmqNYmlf218nTXf/R1uTZgzo4/rcZK/dPfX2
         2X4VX9m6cxlSalZrcNbHCF5l8kGovwoGnMOJ1k7K2YQBcjNcVaU1viVNJIcweyh+TtWg
         X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9hQJpAEXF7ETyJBJagD4laIajYoDDRzBHFa3WSzqUw=;
        b=8BaxsCob4Dm2gEcoxMIrM0S5uqctbd1pnLwSwxJf9jIKg1LRsfNCYXBbOkxTRCuQWv
         p3M3LpPkY5F/zzVDoGIZ5pegkorahQ5n7fdHuk1rAon3YeTl7zDZ6Qlo2PucafRlp3DO
         79pLeYPfislQwCnnNLJvzO8mJYipQKJ1t/C9/OltDcLzL9F/+cHBVZX0hpJOrSTLWzPa
         329B/ui1qoDy+jCnlObone9RiwNCUsNfwoiH+PuBq7h5FGuCU3yvwGT19+Qo2AGsDvdB
         32k1kvKgrf/nTGlLpcbGiDcEG6dRRUd37u+iwa3p7pBnErjcYDaCPinNSIGRkJhSFtFC
         eOhA==
X-Gm-Message-State: ANoB5plq3xjDgi62h+2BhTw7A/bZ9/5+mUrgoQMIGc/c63qN40Gh7PKb
        VKgX6uYWegA1VwldGvCqFoD8/vQxEBg=
X-Google-Smtp-Source: AA0mqf4EhsZtVkke/fCpl3KUGQoIDPnyifpklOOwX7Ol8aY9iaJq8v5h0+RlXTHLFvpYUsHygEa0FA==
X-Received: by 2002:a05:600c:1ca1:b0:3cf:ca91:7094 with SMTP id k33-20020a05600c1ca100b003cfca917094mr361951wms.24.1668152097735;
        Thu, 10 Nov 2022 23:34:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b00236722ebe66sm1158054wrn.75.2022.11.10.23.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:34:57 -0800 (PST)
Message-Id: <84ddc6707fb0fd5e1be675ba587e453c55a76acc.1668152094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
        <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 07:34:53 +0000
Subject: [PATCH v2 2/3] chainlint: latch line numbers at which each token
 starts and ends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

To further assist the test author, an upcoming change will display line
numbers along with the annotated test definition, thus allowing the
author to jump directly to each problematic line. As preparation,
upgrade Lexer to latch the line numbers at which each token starts and
ends, and return that information with the token itself.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 0ee5cc36437..67c2c5ebee8 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -67,6 +67,7 @@ sub new {
 	bless {
 		parser => $parser,
 		buff => $s,
+		lineno => 1,
 		heretags => []
 	} => $class;
 }
@@ -97,7 +98,9 @@ sub scan_op {
 sub scan_sqstring {
 	my $self = shift @_;
 	${$self->{buff}} =~ /\G([^']*'|.*\z)/sgc;
-	return "'" . $1;
+	my $s = $1;
+	$self->{lineno} += () = $s =~ /\n/sg;
+	return "'" . $s;
 }
 
 sub scan_dqstring {
@@ -115,7 +118,7 @@ sub scan_dqstring {
 		if ($c eq '\\') {
 			$s .= '\\', last unless $$b =~ /\G(.)/sgc;
 			$c = $1;
-			next if $c eq "\n"; # line splice
+			$self->{lineno}++, next if $c eq "\n"; # line splice
 			# backslash escapes only $, `, ", \ in dq-string
 			$s .= '\\' unless $c =~ /^[\$`"\\]$/;
 			$s .= $c;
@@ -123,6 +126,7 @@ sub scan_dqstring {
 		}
 		die("internal error scanning dq-string '$c'\n");
 	}
+	$self->{lineno} += () = $s =~ /\n/sg;
 	return $s;
 }
 
@@ -137,6 +141,7 @@ sub scan_balanced {
 		$depth--;
 		last if $depth == 0;
 	}
+	$self->{lineno} += () = $s =~ /\n/sg;
 	return $s;
 }
 
@@ -163,8 +168,11 @@ sub swallow_heredocs {
 	my $b = $self->{buff};
 	my $tags = $self->{heretags};
 	while (my $tag = shift @$tags) {
+		my $start = pos($$b);
 		my $indent = $tag =~ s/^\t// ? '\\s*' : '';
 		$$b =~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
+		my $body = substr($$b, $start, pos($$b) - $start);
+		$self->{lineno} += () = $body =~ /\n/sg;
 	}
 }
 
@@ -172,11 +180,12 @@ sub scan_token {
 	my $self = shift @_;
 	my $b = $self->{buff};
 	my $token = '';
-	my $start;
+	my ($start, $startln);
 RESTART:
+	$startln = $self->{lineno};
 	$$b =~ /\G[ \t]+/gc; # skip whitespace (but not newline)
 	$start = pos($$b) || 0;
-	return ["\n", $start, pos($$b)] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
+	$self->{lineno}++, return ["\n", $start, pos($$b), $startln, $startln] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
 	while (1) {
 		# slurp up non-special characters
 		$token .= $1 if $$b =~ /\G([^\\;&|<>(){}'"\$\s]+)/gc;
@@ -188,20 +197,20 @@ RESTART:
 		$token .= $self->scan_sqstring(), next if $c eq "'";
 		$token .= $self->scan_dqstring(), next if $c eq '"';
 		$token .= $c . $self->scan_dollar(), next if $c eq '$';
-		$self->swallow_heredocs(), $token = $c, last if $c eq "\n";
+		$self->{lineno}++, $self->swallow_heredocs(), $token = $c, last if $c eq "\n";
 		$token = $self->scan_op($c), last if $c =~ /^[;&|<>]$/;
 		$token = $c, last if $c =~ /^[(){}]$/;
 		if ($c eq '\\') {
 			$token .= '\\', last unless $$b =~ /\G(.)/sgc;
 			$c = $1;
-			next if $c eq "\n" && length($token); # line splice
-			goto RESTART if $c eq "\n"; # line splice
+			$self->{lineno}++, next if $c eq "\n" && length($token); # line splice
+			$self->{lineno}++, goto RESTART if $c eq "\n"; # line splice
 			$token .= '\\' . $c;
 			next;
 		}
 		die("internal error scanning character '$c'\n");
 	}
-	return length($token) ? [$token, $start, pos($$b)] : undef;
+	return length($token) ? [$token, $start, pos($$b), $startln, $self->{lineno}] : undef;
 }
 
 # ShellParser parses POSIX shell scripts (with minor extensions for Bash). It
-- 
gitgitgadget

