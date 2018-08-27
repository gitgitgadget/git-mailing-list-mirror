Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56ADE1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeH0Xbm (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:31:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45461 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeH0Xbm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so88611wrb.12
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7i9R/oQc97sLGxLdKqbNXZlKXIZhBSXqrS+pyXO9UCE=;
        b=SUkniZ64YFEGIb0G06wFtDj73zvqrqMG2qkHW9B/GNvQOZtqmJKySkpl5kASDldktM
         pSqMSK/wnFU4o13R+cafCRbrIHJv9oD85Zj04MdbT8xXAd0Ku92EquNMcsPZyPoquxFu
         RHvmzRj4DH9YsPQiKrrO+Ckl+xxLlgWHiEGewBEjxg7Hf81q6LN0XSkShn7+xMx+1Uo1
         eN/RxahKetUAVS9VYHT00Lw0VJbXpniNOgI8GI646ax4QDx9gfUCdh/0Ko46qCjkZDPl
         rEGHXY+q3x2ypgo11EVzZLGJV8XMLI3t/sgyCcgPjGuJWArw2Gm4rb6V2IMeVQyqbacT
         dnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7i9R/oQc97sLGxLdKqbNXZlKXIZhBSXqrS+pyXO9UCE=;
        b=akJ5h6n3eANQ+MbPUmlP8HcH/uiETnJOxzHkKKvS3NR4YjKVO1tYuCeETfjqLXsk4L
         le+sDJlE0FeKrZ3MJ9COv+BRp/+l2k7LVcoWadoUgcto95FUawWwuyeIbSNTFcWLwffa
         0Qq15v/R5qCQ1VCjhRMj3qNJYwmqP1XrtevcOLTtf9tU6Qs//IAyXgpmYWszw1EATbdw
         xyHHCPiJhbdRpLG54QljP9SswSwJnfS/vl4ERxhTmF94Ca4cGdDd3ZhNE31TqL8KcMo3
         +lQ83AqfmHSz/KIxFLiFCnmxdQoAuh2mzyyaKu/ps2u+vHg8/CV+PGSh4amT0bxn5MYz
         kATQ==
X-Gm-Message-State: APzg51BWIHBBYGZzMHXk/pF5FWxIhUJYM7K5SKOEFI3/xAkVOy4lxT8c
        dy0BHR0YyPaThbg1Xjf7/6KJhXuLMFk=
X-Google-Smtp-Source: ANB0VdaXkSTQfftVryExtHYmXSpOSatzOEygWdiWiDfUy7wZ1ve4LnJG62+BbQWgz84dNa/+cIxNpg==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr9814861wra.120.1535399020622;
        Mon, 27 Aug 2018 12:43:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm121958wmd.4.2018.08.27.12.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:43:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/7] fsck: document and test commented & empty line skipList input
Date:   Mon, 27 Aug 2018 19:43:20 +0000
Message-Id: <20180827194323.17055-5-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180827194323.17055-1-avarab@gmail.com>
References: <20180827194323.17055-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is currently no comment syntax for the fsck.skipList, this isn't
really by design, and it would be nice to have support for comments.

Document that this doesn't work, and test for how this errors
out. These tests reveal a current bug, if there's invalid input the
output will emit some of the next line, and then go into uninitialized
memory. This is fixed in a subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 11 +++++++----
 t/t5504-fetch-receive-strict.sh | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9359fb534e..a8dfafa61d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1710,10 +1710,13 @@ will only cause git to warn.
 fsck.skipList::
 	The path to a list of object names (i.e. one SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
-	be ignored. This feature is useful when an established project
-	should be accepted despite early commits containing errors that
-	can be safely ignored such as invalid committer email addresses.
-	Note: corrupt objects cannot be skipped with this setting.
+	be ignored. Comments ('#') and empty lines are not supported, and
+	will error out.
++
+This feature is useful when an established project should be accepted
+despite early commits containing errors that can be safely ignored
+such as invalid committer email addresses.  Note: corrupt objects
+cannot be skipped with this setting.
 +
 Like `fsck.<msg-id>` this variable has corresponding
 `receive.fsck.skipList` and `fetch.fsck.skipList` variants.
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index fa56052f0f..38aaf3b928 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -169,6 +169,27 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
 	test_i18ngrep "Invalid SHA-1: \[core\]" err
 '
 
+test_expect_success 'fsck with invalid or bogus skipList input (comments & empty lines)' '
+	cat >SKIP.with-comment <<-EOF &&
+	# Some bad commit
+	0000000000000000000000000000000000000001
+	EOF
+	test_must_fail git -c fsck.skipList=SKIP.with-comment fsck 2>err-with-comment &&
+	test_i18ngrep "^fatal: Invalid SHA-1: # Some bad commit$" err-with-comment &&
+	cat >SKIP.with-empty-line <<-EOF &&
+	0000000000000000000000000000000000000001
+
+	0000000000000000000000000000000000000002
+	EOF
+	test_must_fail git -c fsck.skipList=SKIP.with-empty-line fsck 2>err-with-empty-line &&
+	test_i18ngrep "^fatal: Invalid SHA-1: " err-with-empty-line
+'
+
+test_expect_failure 'fsck no garbage output from comments & empty lines errors' '
+	test_line_count = 1 err-with-comment &&
+	test_line_count = 1 err-with-empty-line
+'
+
 test_expect_success 'push with receive.fsck.skipList' '
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
-- 
2.19.0.rc0.228.g281dcd1b4d0

