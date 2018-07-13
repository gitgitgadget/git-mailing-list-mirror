Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05BDA1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 05:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeGMGGD (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 02:06:03 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41034 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeGMGGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 02:06:03 -0400
Received: by mail-io0-f194.google.com with SMTP id q9-v6so30342583ioj.8
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 22:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Epb933ar7CAk5gyVgmYfCf92w+ZiSJYJGcDWd549U8c=;
        b=rQ4U+inDxsC076Xbj1sqsHWw4njxfV0ZbixmJyiiAO+dcUSCeUEbVyjmRlGExZql8b
         N04H/sVysR0O8gHJT1nLxLUuCUwqZKGx+WL8MBBwUZOJD3/b4aZlp+EKL7wjA5wwwL+j
         0XTDRdgL3rDlfYFZyr0SHJPVNcK306ew9ASpHt7N/K6TBmSQXWbdCP6PoBkn0oiK9lps
         707RCWDjY8NcI8xWRY17AvCNmtLLYAOpMi63G53uZMFlMEdN0BQCaeMAsYaShVFrxj0l
         6eja/jIMY6OkkC4WyJgFVW+GHFH9C38fPchDps8lWMK7Bx3gQumaaSON17wYl4qT4/We
         tg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Epb933ar7CAk5gyVgmYfCf92w+ZiSJYJGcDWd549U8c=;
        b=E1EgxZ4LySc4yjnaB+wRYmMU+pXbiN1z59U2uwVnrqlnkvOvRn+/T2TckcAbH/tZhM
         ETRxwJ5kG66DDDSxb2TOXSA+9IOUcJdJWfsOGwZVDLOMsZLwdCpeOzbd96fXtSLEPHRw
         yHlJc3IIf56X+GIV52uV3R2030Zt7/e1qW8IVxWdPvUBRmhP2gIZnfDUkb0wSMVVEEgK
         1mic5wEVMbZtN6E/aWID00UzKtypbW3ZqspyJfAMKvtNVgTOFjngK1xKxJ+z8UJ0k78T
         R793d0GOMYH8pqI4JXAOW9QDFq1UEgNUcaJF1z4nLoppPKZqfLTsWstHctgTv9oFTWit
         OmJA==
X-Gm-Message-State: APt69E2BCNfJ2fEPuWmKOjdhm5gisMXQSSB4LR7lkwXy3nKH/BIuiXj2
        xH56liHdOmXAlMwk66Tm/ePDTw==
X-Google-Smtp-Source: AAOMgpc/Efxnh7DeDQngOrU97R04t54/E1vJE2BFSQr97NITfQAjanPYs7KsoF7rsBxm957X7J5xuw==
X-Received: by 2002:a6b:9145:: with SMTP id t66-v6mr30742159iod.59.1531461180417;
        Thu, 12 Jul 2018 22:53:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3138036ioj.22.2018.07.12.22.52.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 22:52:59 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/4] t/check-non-portable-shell: detect "FOO=bar shell_func"
Date:   Fri, 13 Jul 2018 01:52:05 -0400
Message-Id: <20180713055205.32351-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e
In-Reply-To: <20180713055205.32351-1-sunshine@sunshineco.com>
References: <20180713055205.32351-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One-shot environment variable assignments, such as 'FOO' in
"FOO=bar cmd", exist only during the invocation of 'cmd'. However, if
'cmd' happens to be a shell function, then 'FOO' is assigned in the
executing shell itself, and that assignment remains until the process
exits (unless explicitly unset). Since this side-effect of
"FOO=bar shell_func" is unlikely to be intentional, detect and report
such usage.

To distinguish shell functions from other commands, perform a pre-scan
of shell scripts named as input, gleaning a list of function names by
recognizing lines of the form (loosely matching whitespace):

    shell_func () {

and later report suspect lines of the form (loosely matching quoted
values):

    FOO=bar [BAR=foo ...] shell_func

Also take care to stitch together incomplete lines (those ending with
"\") since suspect invocations may be split over multiple lines:

    FOO=bar BAR=foo \
    shell_func

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index f6dbe28b19..d5823f71d8 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -7,17 +7,34 @@
 use warnings;
 
 my $exit_code=0;
+my %func;
 
 sub err {
 	my $msg = shift;
 	s/^\s+//;
 	s/\s+$//;
+	s/\s+/ /g;
 	print "$ARGV:$.: error: $msg: $_\n";
 	$exit_code = 1;
 }
 
+# glean names of shell functions
+for my $i (@ARGV) {
+	open(my $f, '<', $i) or die "$0: $i: $!\n";
+	while (<$f>) {
+		$func{$1} = 1 if /^\s*(\w+)\s*\(\)\s*{\s*$/;
+	}
+	close $f;
+}
+
 while (<>) {
 	chomp;
+	# stitch together incomplete lines (those ending with "\")
+	while (s/\\$//) {
+		$_ .= readline;
+		chomp;
+	}
+
 	/\bsed\s+-i/ and err 'sed -i is not portable';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
@@ -25,6 +42,8 @@ sub err {
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
+	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
+		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
 	# this resets our $. for each file
 	close ARGV if eof;
 }
-- 
2.18.0.233.g985f88cf7e

