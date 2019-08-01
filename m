Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A3D1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 15:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfHAPxa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 11:53:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41416 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbfHAPxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 11:53:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so70923463wrm.8
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdU9NOM3f+HsCfk1SA0uqzQnnqszZ1DIBNIE0nHRwNk=;
        b=MJ3dXwohzR4wyt5rnfvj3E6Z2SC4VERgTeHXogamDLacJ1ubwEv/KmpLyWZmn+u4Ls
         Ua8MnWjiaj5vdMcUI8oigaQyT4+If1WzMzrCoTIE4Vqr9j09F1YAzLVI9e86KNE5Upao
         9Qa0L+j0QDNjUizXEBoXKOb6DtuEvftTMUjhvoYqVU5MheNNNjqMOOwxnNpjVHcXT+Lo
         erYBRe/rDgPN1ZmQGwp36nSgDIfAGG+3hlrhyXCjoOG8EyH6sdcUo5vKdB9++jU+IUYc
         oUqlKdIAuTwSuZBDmV7ttKVUmLpHJYHPiSw79ixEOkOaCZmANpaOSlvDzydw1+TKhZmS
         KgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdU9NOM3f+HsCfk1SA0uqzQnnqszZ1DIBNIE0nHRwNk=;
        b=IDapEtxdj5mdjBWFp0wzXcF8d72zjDxyLigGvFgoJ7XdrOQ/dZBOXeI1Vnthjw+7B9
         dmk3A1A94jycRuMv+fKPX7vhQcxguXd9u7ZmLyXHQynT3QCzjlD9sJc3ED0dKKDAfFDi
         86/4RrxqYpDQZ/OhnvO4P+9r2mAhIlYgFSWnpx5uae/slsXucAKjpqHdkPXd4gIWNtY0
         E5QTxBo9loy3s8um9CD9TQnQsuAOue4EBCSxkSyzZnqrQew1ocJeY3LCo5P6y6sYSse4
         C0Cx2oSO6nrKnW9+0HyXWEgBaZvu+aiJXXMJgv58w5tio0+kd7hAafciRXh3PMozfMiy
         bgSQ==
X-Gm-Message-State: APjAAAUdv7nX4BA8zFsQo+72qmIIkTcc+01Ki+0ZPZyC+8FCeTCJGZrg
        LL9nNp6IohYzMuqXDC1Dvl0=
X-Google-Smtp-Source: APXvYqwwZQSCIqwOzbjU2XENY4q0vjx3VpUWKK3Z653Gh3Ug47c8FQbUCdtUGRaXtP1JEaCVw+gJIQ==
X-Received: by 2002:a5d:4fc8:: with SMTP id h8mr26067386wrw.177.1564674807076;
        Thu, 01 Aug 2019 08:53:27 -0700 (PDT)
Received: from localhost.localdomain (x4dbd0ed1.dyn.telefonica.de. [77.189.14.209])
        by smtp.gmail.com with ESMTPSA id g17sm55434473wrm.7.2019.08.01.08.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 08:53:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] tests: warn against appending non-httpd-specific tests at the end
Date:   Thu,  1 Aug 2019 17:53:09 +0200
Message-Id: <20190801155309.15276-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.926.g602b9a0287
In-Reply-To: <20190801155309.15276-1-szeder.dev@gmail.com>
References: <20190730214000.GT20404@szeder.dev>
 <20190801155309.15276-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a couple of test scripts that are not completely
httpd-specific, but do run a few httpd-specific tests at the end.
These test scripts source 'lib-httpd.sh' somewhere mid-script, which
then skips all the rest of the test script if the dependencies for
running httpd tests are not fulfilled.

As the previous two patches in this series show, already on two
occasions non-httpd-specific tests were appended at the end of such
test scripts, and, consequently, they were skipped as well when httpd
tests couldn't be run.

Add a comment at the end of these test scripts to warn against adding
non-httpd-specific tests at the end, in the hope that they will help
prevent similar issues in the future.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0410-partial-clone.sh | 3 +++
 t/t5500-fetch-pack.sh    | 3 +++
 t/t5537-fetch-shallow.sh | 3 +++
 t/t5545-push-options.sh  | 3 +++
 t/t5601-clone.sh         | 3 +++
 t/t5616-partial-clone.sh | 3 +++
 t/t5700-protocol-v1.sh   | 3 +++
 t/t5702-protocol-v2.sh   | 3 +++
 8 files changed, 24 insertions(+)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 5bd892f2f7..6415063980 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -518,4 +518,7 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	git verify-pack --verbose "$IDX" | grep "$HASH"
 '
 
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 1c71c0ec77..8210f63d41 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -920,4 +920,7 @@ test_expect_success 'fetch with --filter=blob:limit=0 and HTTP' '
 	fetch_filter_blob_limit_zero "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
 
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 66f0b64d39..97a67728ca 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -255,4 +255,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	git -C client fsck
 '
 
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 6d1d59c9b1..04b34c4de1 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -278,4 +278,7 @@ test_expect_success 'push options keep quoted characters intact (http)' '
 	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options
 '
 
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 37d76808d4..4a3b901f06 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -739,4 +739,7 @@ test_expect_success 'partial clone using HTTP' '
 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
 
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index b91ef548f8..565254558f 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -417,4 +417,7 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
 '
 
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 7c9511c593..2571eb90b7 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -292,4 +292,7 @@ test_expect_success 'push with http:// using protocol v1' '
 	grep "git< version 1" log
 '
 
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 011b81d4fc..fbddd0aea9 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -723,4 +723,7 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
 '
 
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
-- 
2.22.0.926.g602b9a0287

