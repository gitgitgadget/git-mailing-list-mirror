Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A871F45F
	for <e@80x24.org>; Thu,  9 May 2019 10:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEIKVL (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 06:21:11 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45082 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIKVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 06:21:10 -0400
Received: by mail-io1-f53.google.com with SMTP id b3so1155667iob.12
        for <git@vger.kernel.org>; Thu, 09 May 2019 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLYqGsOhPk4Fi+GasIIMn+pikz8kj5g0mPctwb7qhl0=;
        b=XitFTkOE2tRnTGwBmLtXmPbOZWC2t9UtCyibtG1aXJ5TTdkGBZFvFi0DOoZuy4fP9d
         KMlUyD76iXL1xDkq/TQxfxW5fVF6CyfYqixRClHQQvDiXkpSdeAP0W8/MMxKgfo+VGvo
         djQjb3UjeNQMq1ND6SARZLggRi5ctv3JiV02metPoLCNbewvuiIhmcHJgp2cWqJDH7EZ
         JEfCq2cynhE0XbqhfPvOwKy46xNY2Xqkx0vKpL4NgCqhrQmNyCi7Lo1OGbawvTW2dcmV
         R8+P8M94GNYrK+xOrGFRn5hTyMFGMg/EsDlzI4qHhUzV/gKJNr8dGE5MAy6p7fcaXLDe
         YzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GLYqGsOhPk4Fi+GasIIMn+pikz8kj5g0mPctwb7qhl0=;
        b=OwgX8JdZegbnyY37Z9n1n1Vostn7j8aCoj46mJLt2w00dAbkMv5gTU7MnT2yg7xWxq
         gP803VH+AtL83xp+mPTxiJHZVPExXOvvBfJVthkLPtqVpKPAhl3jvZtZMbREbE5l4KV1
         pjvDuz4YCSEeMGLRbn5l8QhY9Z0saLPS7tGM46gcdufoAAwsTPR4qw2dENsAPuM1Er0l
         TRWuFRRuqYNZUorYPESF7qFdsFFcIAKGtJlt5ocxfDdRWhv9fqhKitab1OOyOvj0hM/d
         5A0WI4KuzmU9KvVMffMhkaHBvuFONdtaqfbqPVD5pezT6upBHJfM/H2NxA7uqLUxB+AS
         7k/A==
X-Gm-Message-State: APjAAAWByqdj7gRCKzAy58fREmbNXg8rY/SJMgeY0eRIY1Z/sqlaDm46
        kee/N4lRbTGqydhue2HlDwLl3ubT
X-Google-Smtp-Source: APXvYqyQ1KAS87RGxREnpk4b9ROs6Yu/IwOqGT17VgSufy92vYO8rBvjK54/lb1axyFnGsaPU6HaLA==
X-Received: by 2002:a6b:e510:: with SMTP id y16mr1402088ioc.259.1557397269575;
        Thu, 09 May 2019 03:21:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id c62sm783258itd.17.2019.05.09.03.21.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 09 May 2019 03:21:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeffrey Walton <noloader@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] check-non-portable-shell: support Perl versions older than 5.10
Date:   Thu,  9 May 2019 06:20:37 -0400
Message-Id: <20190509102037.27044-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.21.0.1084.g81c186ecd2
In-Reply-To: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
References: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For thoroughness when checking for one-shot environment variable
assignments at shell function call sites, check-non-portable-shell
stitches together incomplete lines (those ending with backslash). This
allows it to correctly flag such undesirable usage even when the
variable assignment and function call are split across lines, for
example:

    FOO=bar \
    func

where 'func' is a shell function.

The stitching is accomplished like this:

    while (<>) {
        chomp;
        # stitch together incomplete lines (those ending with "\")
        while (s/\\$//) {
            $_ .= readline;
            chomp;
        }
        # detect unportable/undesirable shell constructs
        ...
    }

Although this implementation is well supported in reasonably modern Perl
versions (5.10 and later), it fails in a couple ways with older versions
(such as Perl 5.8 shipped with ancient Mac OS 10.5).

In particular, in older Perl versions, 'readline' is not connected to
the file handle associated with the "magic" while (<>) {...} construct,
so 'readline' throws a "readline() on unopened filehandle" error.
Furthermore, $_ assigned by the outer while-loop is read-only, so the
attempt to modify it via "$_ .= readline" in the inner while-loop fails
with a "Modification of a read-only value" error.

Avoid both problems by collecting the stitched-together line in a
variable other than $_ and dropping the inner loop entirely.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 166d64d4a2..60e607ba42 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -27,14 +27,14 @@ sub err {
 	close $f;
 }
 
+my $line = '';
 while (<>) {
 	chomp;
+	$line .= $_;
 	# stitch together incomplete lines (those ending with "\")
-	while (s/\\$//) {
-		$_ .= readline;
-		chomp;
-	}
+	next if $line =~ s/\\$//;
 
+	local $_ = $line;
 	/\bcp\s+-a/ and err 'cp -a is not portable';
 	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
@@ -48,6 +48,7 @@ sub err {
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
+	$line = '';
 	# this resets our $. for each file
 	close ARGV if eof;
 }
-- 
2.21.0.1084.g81c186ecd2

