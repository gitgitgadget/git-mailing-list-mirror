Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94A81FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbdDITLl (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:11:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35302 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbdDITLe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:11:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id t20so26581392wra.2
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r0WOJTtoStcLeVbmoeglZVjXEYsma4CI/1HeS1Qb+ls=;
        b=kAanJchyYyF+13QLgAW4Va5yynItOBC6cnDsWI4dKh+jNXpYPT0eZ0/6JLl8SxwZQW
         sPqIh/uVnQQQlZglh9AtYGPYL0Ad0WhIH5inT7uzsiZN3ie5xm3w7ctXkV9bOxah2ab0
         bf2/eteHPNXnJKBQKLH3EY2CEPMoV1Wha1yHWIbcITcW72XYuoSqlED+oMekGIG2tZ9m
         sL40hTv2vcDQU9dYPdwb7ubPOmnjQaLRvD9PyRUWzHd1CNVsp8By1+XCWBHxx+pT3B2v
         0xMfu5O0C5RVlQ/HZdoO7zkHjaxEGmNU+J7dpsKUOJE6YeLy70RUSftQMDYoN+NMGclB
         V4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r0WOJTtoStcLeVbmoeglZVjXEYsma4CI/1HeS1Qb+ls=;
        b=Phryi4Rt0MsOAZ1JvTam3NWVkMFxanmxXi9mrYsgif+WftMB/AfRhJfQeIQwnvr+c+
         IcfEQiLCwLTKwaqDqmLfXIsp/QXU/JSQ2SeQiPeVPqow5Qnog/gLqaPRxXIfU8ID2WVL
         6oUjGBV9XdELTti47RZfuwTByl3V96lmcyYCqOkv5SiTE3MVeS3U0iKVZmGX/fcO/eLs
         h5ct0GBDwf/BpPaysRqSOUmiXLX+vOfyoL4WYbCqjYOBtLzWhX6aj0wfrB7r+W7pqDwb
         uohvY+xXa2RApjSXInsxi9k8Rkg6hMKjglSB/H9J83kGWXjln3zk48zv6YCXFNe5nbge
         v5qA==
X-Gm-Message-State: AFeK/H310EwMhWev6MW93Vhz6DTgUsUxLbWjTIRX+z0bxasmqIYSlnF7W9W2eM7/GSP0oA==
X-Received: by 10.223.142.172 with SMTP id q41mr23556046wrb.25.1491765092737;
        Sun, 09 Apr 2017 12:11:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b82sm7363895wmh.4.2017.04.09.12.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Apr 2017 12:11:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into the TRASH_DIRECTORY name
Date:   Sun,  9 Apr 2017 19:11:17 +0000
Message-Id: <20170409191117.25175-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170409191117.25175-1-avarab@gmail.com>
References: <20170409191117.25175-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test library to insert non-alphanumeric ASCII characters
into the TRASH_DIRECTORY name, that's the directory the test library
creates, chdirs to and runs each individual test from.

Unless test_fails_on_unusual_directory_names=1 is declared before
importing test-lib.sh (and if perl isn't available on the system), the
trash directory will contain every non-alphanumeric character in
ASCII, in order.

This includes all the control characters, !, [], {} etc. the "."
character isn't included because it's already in the directory name,
and nor is "/" for obvious reasons, although that would actually work,
we'd just create a subdirectory, which would make the tests harder to
inspect when they fail.i

This change is inspired by the "submodule: prevent backslash expantion
in submodule names" patch[1]. If we'd had backslashes in the
TRASH_DIRECTORY all along that bug would have been fixed a long time
ago. This will flag such issues by marking tests that currently fail
with "test_fails_on_unusual_directory_names=1", ensure that new tests
aren't added unless a discussion is had about why the code can't
handle unusual pathnames, and prevent future regressions.

1. <20170407172306.172673-1-bmwill@google.com>
---
 t/README      | 12 ++++++++++++
 t/test-lib.sh |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/t/README b/t/README
index ab386c3681..314dd40221 100644
--- a/t/README
+++ b/t/README
@@ -345,6 +345,18 @@ assignment to variable 'test_description', like this:
 	This test registers the following structure in the cache
 	and tries to run git-ls-files with option --frotz.'
 
+By default the tests will be run from a directory with a highly
+unusual filename that includes control characters, a newline, various
+punctuation etc., this is done to smoke out any bugs related to path
+handling. If for whatever reason the tests can't deal with such
+unusual path names, set:
+
+    test_fails_on_unusual_directory_names=1
+
+Before sourcing 'test-lib.sh' as described below. This option is
+mainly intended to grandfather in existing broken tests & code, and
+should usually not be used in new code, instead your tests or code
+probably need fixing.
 
 Source 'test-lib.sh'
 --------------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 13b5696822..089ff5ac7d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -914,6 +914,10 @@ fi
 
 # Test repository
 TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
+if test -z "$test_fails_on_unusual_directory_names" -a "$(perl -e 'print 1+1' 2>/dev/null)" = "2"
+then
+   TRASH_DIRECTORY="$TRASH_DIRECTORY.$(perl -e 'print join q[], grep { /[^[:alnum:]]/ and !m<[./]> } map chr, 0x01..0x7f')"
+fi
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
-- 
2.11.0

