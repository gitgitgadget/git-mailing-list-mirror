Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E90D1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 18:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeAQSIN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 13:08:13 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42625 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeAQSIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 13:08:11 -0500
Received: by mail-wr0-f193.google.com with SMTP id e41so19524624wre.9
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 10:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yAKJrt0AqLEpX1UeLjBQOpwtqI4As6K4yXbwUyYhxjI=;
        b=Cb3ugdB8f0zSGXqNuNQtyujRoUXYUnTZWxUH0yaKn4kNl7E9HFSMSGepIuKA5KeExe
         TAqHFAKftXu9YToRfMT6GAlr1XFBGgqWLgmMZaLAM2D/VvVKusG+qzJ2WePhDjoRjLs2
         RYKFGHW1WsHt/kOjdqxJhNDZS2IENkZf3CY5oAtxAvLoCsQ1DhNhoo50akdL9FoBl2GD
         vQaIwgAV8UULeio9KNrZQlci1ZRsSQ/x3BomJzW9UzyKaKUd4ZXtCrRFFjb++xBGLC+r
         R3Zt2Qn+HCPRvoH/ueaXlg/mRnOtlSqP9NUk6+wrNz1FS/+FvscdF/YJQ3o4TD/iuvfY
         eARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yAKJrt0AqLEpX1UeLjBQOpwtqI4As6K4yXbwUyYhxjI=;
        b=BGfoJlqCgkwP5mHAdRfsaIGGtkzse/H0fC0kAY1bcuAtIc9OmeYC8QANs9Fx3HLJi+
         wOpc8EyCkNKnDib39jNRVKuWW7kqQlI7NLpQwugZeFh77j2KA8KzOCDqNSY31WsFKlrB
         t8J5nj9uDjYV0oQnCp43hqZ4bn4vabUncykPBJqm9uI/hxU+XN3XiqD74e1Pw5I6ZNXb
         l+aKZZzljd41yQNmjlFlw0I97vGqumJRWGD9kpSO2Wv0IvNsDhw4GrXi/Ka8XdqyQkUq
         b8Q9A+OhJ7/mD40g9PlTlusch5GGuvUsVaI628ncTbZ6LCXAz5yAN4YgovCOSrU8/WyF
         QkSA==
X-Gm-Message-State: AKwxytcM0sOsljBXug8SRQ7S5+u9vsK1p9zYWJx7r5gonohofjkmUxE5
        R1I2WaKVeX6VkJQpaV9ZMQWJEKgl
X-Google-Smtp-Source: ACJfBov6EV+V66GlwwIePqem4kQKJmgFQfHxhL9+HAakq13lRWY9jQ00yB3V/k/FYN3GdI6M6TDpoQ==
X-Received: by 10.223.208.201 with SMTP id z9mr3452983wrh.194.1516212489345;
        Wed, 17 Jan 2018 10:08:09 -0800 (PST)
Received: from greyhound ([195.145.21.250])
        by smtp.gmail.com with ESMTPSA id 198sm5291331wmo.21.2018.01.17.10.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jan 2018 10:08:07 -0800 (PST)
From:   Christian Ludwig <chrissicool@googlemail.com>
X-Google-Original-From: Christian Ludwig <chrissicool@gmail.com>
Received: from cc by greyhound with local (Exim 4.89)
        (envelope-from <cc@localhost>)
        id 1ebs84-00085a-Nt; Wed, 17 Jan 2018 19:08:04 +0100
To:     git@vger.kernel.org
Cc:     Christian Ludwig <chrissicool@gmail.com>
Subject: [PATCH v2 2/2] send-email: Support separate Reply-To address
Date:   Wed, 17 Jan 2018 19:08:01 +0100
Message-Id: <20180117180801.31049-2-chrissicool@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180117180801.31049-1-chrissicool@gmail.com>
References: <20180117180801.31049-1-chrissicool@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some projects contributions from groups are only accepted from a
common group email address. But every individual may want to recieve
replies to her own personal address. That's what we have 'Reply-To'
headers for in SMTP.

Introduce an optional '--reply-to' command line option. Unfortunately
the $reply_to variable name was already taken for the 'In-Reply-To'
header field. To reduce code churn, use $reply_address as variable
name instead.

Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
---
 Documentation/git-send-email.txt       |  5 +++++
 contrib/completion/git-completion.bash |  2 +-
 git-send-email.perl                    | 18 +++++++++++++++++-
 t/t9001-send-email.sh                  |  2 ++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8060ea35c..71ef97ba9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -84,6 +84,11 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
 	set, as returned by "git var -l".
 
+--reply-to=<address>::
+	Specify the address where replies from recipients should go to.
+	Use this if replies to messages should go to another address than what
+	is specified with the --from parameter.
+
 --in-reply-to=<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c..2a0dc4eef 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2081,7 +2081,7 @@ _git_send_email ()
 			--compose --confirm= --dry-run --envelope-sender
 			--from --identity
 			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
-			--no-suppress-from --no-thread --quiet
+			--no-suppress-from --no-thread --quiet --reply-to
 			--signed-off-by-cc --smtp-pass --smtp-server
 			--smtp-server-port --smtp-encryption= --smtp-user
 			--subject --suppress-cc= --suppress-from --thread --to
diff --git a/git-send-email.perl b/git-send-email.perl
index 0c07f48d5..9bf758307 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -56,6 +56,7 @@ git send-email --dump-aliases
     --[no-]cc               <str>  * Email Cc:
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
+    --reply-to              <str>  * Email "Reply-To:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
@@ -166,7 +167,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_in_reply_to,$initial_subject,@files,
+	$initial_in_reply_to,$reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
@@ -315,6 +316,7 @@ die __("--dump-aliases incompatible with other options\n")
 $rc = GetOptions(
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_in_reply_to,
+		    "reply-to=s" => \$reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
@@ -677,6 +679,7 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
+	my $tpl_reply_to = $reply_to || '';
 
 	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
 From $tpl_sender # This line is ignored.
@@ -688,6 +691,7 @@ for the patch you are writing.
 Clear the body content if you don't wish to send a summary.
 EOT2
 From: $tpl_sender
+Reply-To: $tpl_reply_to
 Subject: $tpl_subject
 In-Reply-To: $tpl_in_reply_to
 
@@ -738,6 +742,9 @@ EOT3
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
 			$initial_in_reply_to = $1;
 			next;
+		} elsif (/^Reply-To:\s*(.+)\s*$/i) {
+			$reply_to = $1;
+			next;
 		} elsif (/^From:\s*(.+)\s*$/i) {
 			$sender = $1;
 			next;
@@ -884,6 +891,12 @@ if (defined $initial_in_reply_to) {
 	$initial_in_reply_to = "<$initial_in_reply_to>" if $initial_in_reply_to ne '';
 }
 
+if (defined $reply_to) {
+	$reply_to =~ s/^\s+|\s+$//g;
+	($reply_to) = expand_aliases($reply_to);
+	$reply_to = sanitize_address($reply_to);
+}
+
 if (!defined $smtp_server) {
 	my @sendmail_paths = qw( /usr/sbin/sendmail /usr/lib/sendmail );
 	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};
@@ -1315,6 +1328,9 @@ Message-Id: $message_id
 		$header .= "In-Reply-To: $in_reply_to\n";
 		$header .= "References: $references\n";
 	}
+	if ($reply_to) {
+		$header .= "Reply-To: $reply_to\n";
+	}
 	if (@xh) {
 		$header .= join("\n", @xh) . "\n";
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 81869d891..c62318a78 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -205,6 +205,7 @@ Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 In-Reply-To: <unique-message-id@example.com>
 References: <unique-message-id@example.com>
+Reply-To: Reply <reply@example.com>
 
 Result: OK
 EOF
@@ -297,6 +298,7 @@ test_expect_success $PREREQ 'Show all headers' '
 		--dry-run \
 		--suppress-cc=sob \
 		--from="Example <from@example.com>" \
+		--reply-to="Reply <reply@example.com>" \
 		--to=to@example.com \
 		--cc=cc@example.com \
 		--bcc=bcc@example.com \
-- 
2.15.1

