Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA7C2D0C2
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124AD2464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD0JNe5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFNIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:08:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39915 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfLFNId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:08:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so7269302wmh.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cVW3knpJz0qslluRG98HoYb0muEhNyhfjcTfVDLWKjM=;
        b=nD0JNe5Um4qFRv69N/cyNwdXx5uYjM6AdM9WMSjeluqBa4tpX8ExSrB728oU3c/5wB
         pqKiECrzZy5YQD6n/K7StHKHjlQMKNbX7e+xwh7wcZx4MOmTfPUbBvxvUuRiODonaTHC
         hulXuyRYO2kJKSJE5WfmTIMTRgpxLTOdhbQJL7FZseywOk4vCDCh/Ys2RSRbHYovDGzY
         IMP8fyLoso5VafoFjNA68ruyzZDpZYp7sAKlp/vv39hvxVwnzxq85NkaPmXy9qujO8yA
         5JAv9++YzAGXT5JUSIH+Hy/ccGpAWjBDVypthuNiZ1gmvePmA58gCQ9W61cxwVM1Wgi+
         hz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cVW3knpJz0qslluRG98HoYb0muEhNyhfjcTfVDLWKjM=;
        b=q6gxQ0l6RdhinPzZ4/sMM+Tun+z9SU3vVsMAfENnIFEGyPIKYIRzxf5MVLa6pvqu7y
         QqRa5qxXppp2BC9c0hv5wtwqnbchotn278HqH/rHtmSxeyLcnw/zI7IDQEYVfaOPfvU0
         7nhoBzSfkbnoLo/MbotrutIFhW9tT8pA+ac0AX8sV/6jFwGkxLUliAKIuZM6GTgoWKvW
         mTYpLsi3CsZhuskT5YNssnHW5jIH2DZHZeXbv2wIo9goQXv0KwFTxfYj97aHciucQ6vD
         J1KEiBLN/4a7W2wlfXjTHJlRDtX3s0z8UXWH9k6G3xzKTKrWDuWhX2EMLLeQBxmcGW40
         2PDw==
X-Gm-Message-State: APjAAAWBM6EU2wybUeSOn5Eh0hl4rPEQ8+Z386RHi6NYybMWB4G6TCYE
        UIiiT5BfW12AEJ9YeKeU/HxD0LLo
X-Google-Smtp-Source: APXvYqwwK+YD8AKLRhMpeqzahV9gZvGQ0euPs6cDxSKlYYzw97ZoXZGvSzhzQBMUPp9IOP81fFmeIg==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr10419581wmj.152.1575637711217;
        Fri, 06 Dec 2019 05:08:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm3468905wmf.29.2019.12.06.05.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:08:30 -0800 (PST)
Message-Id: <27c8ceeb1150dafeaf5b83831487f6bd66c04839.1575637705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.172.git.1575637705.gitgitgadget@gmail.com>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 13:08:24 +0000
Subject: [PATCH 6/7] git add -p: use non-zero exit code when the diff
 generation failed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The first thing `git add -p` does is to generate a diff. If this diff
cannot be generated, `git add -p` should not continue as if nothing
happened, but instead fail.

What we *actually* do here is much broader: we now verify for *every*
`run_cmd_pipe()` call that the spawned process actually succeeded.

Note that we have to change two callers in this patch, as we need to
store the spawned process' output in a local variable, which means that
the callers can no longer decide whether to interpret the `return <$fh>`
in array or in scalar context.

This bug was noticed while writing a test case for the diff.algorithm
feature, and we let that test case double as a regression test for this
fixed bug, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-add--interactive.perl  | 8 +++++---
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 52659bb74c..10fd30ae16 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -177,7 +177,9 @@ sub run_cmd_pipe {
 	} else {
 		my $fh = undef;
 		open($fh, '-|', @_) or die;
-		return <$fh>;
+		my @out = <$fh>;
+		close $fh || die "Cannot close @_ ($!)";
+		return @out;
 	}
 }
 
@@ -224,7 +226,7 @@ sub list_untracked {
 	sub get_empty_tree {
 		return $empty_tree if defined $empty_tree;
 
-		$empty_tree = run_cmd_pipe(qw(git hash-object -t tree /dev/null));
+		($empty_tree) = run_cmd_pipe(qw(git hash-object -t tree /dev/null));
 		chomp $empty_tree;
 		return $empty_tree;
 	}
@@ -1127,7 +1129,7 @@ sub edit_hunk_manually {
 EOF2
 	close $fh;
 
-	chomp(my $editor = run_cmd_pipe(qw(git var GIT_EDITOR)));
+	chomp(my ($editor) = run_cmd_pipe(qw(git var GIT_EDITOR)));
 	system('sh', '-c', $editor.' "$@"', $editor, $hunkfile);
 
 	if ($? != 0) {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index f43634102e..5db6432e33 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -530,7 +530,7 @@ test_expect_success 'diff.algorithm is passed to `git diff-files`' '
 	>file &&
 	git add file &&
 	echo changed >file &&
-	git -c diff.algorithm=bogus add -p 2>err &&
+	test_must_fail git -c diff.algorithm=bogus add -p 2>err &&
 	test_i18ngrep "error: option diff-algorithm accepts " err
 '
 
-- 
gitgitgadget

