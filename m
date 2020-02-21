Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FA1C3566F
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9088206EF
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5CDELoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgBUVrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:47:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35420 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUVrc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 16:47:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so3643546wrt.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M9gzvkWuRprmVB3lEsUIcQBwo+OALbpLXD5vzrh6+pk=;
        b=f5CDELoqB2p1EAaYeXn0QE+bHQkqINouGGxd9VO02MNGM48l5HU/L/aOoZrX+lOr0q
         REWJiwFoUTRgdpSevvbJaPvvBkLE5XPYgloPWBKJZVZXfuiri4tyuDNztZrk2EQ0EaEH
         GBzj5wE+UuuJVoREVK5Oge4fkQBYPT3l83x1o7IAtyeidpQpxoar0oU7Gw4DFxYBp6Ui
         QpcrXDHpvIEkEVMEfDv0NlCfBsEUCBXRfxe+bajKdSdZZzz13H1kRkPVhgIgPzVMelEb
         nJXt9zm7B+VmVl/104rAtkloji1uO2PY68F7VBPDW2yqghJn+hgLBffi0xXienP922GL
         ug3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M9gzvkWuRprmVB3lEsUIcQBwo+OALbpLXD5vzrh6+pk=;
        b=U77wB3Qgs400JXzF+vjZZDjzISZyr+KzFMoVxsttJ4HzuqlJpuDwC2NbOM4HMUf4Jv
         +IpjRSC3BbtL6yZbeCrHeD1QL9Mv1rYgXcM2hjoP2eiC+slbVFCCpPwatxcdE3on1BUI
         km3ny9uEU4afNBo+Ylh/Zot2G8bBECIttoqzQrgJB5R8Y5lTNclD49/JimfkoY2qrp0x
         bHAffMMkejD/427TSRNNSyxhG8SEk59DUNFLfPoMMarMcG4kdFfrREEqH1XHd23Jav49
         QfYxjAOmj22z6fs/0IqQsGMcuam+C0A99QP82J3Lo4/E+PFZ2IQDNzK+NKuudEX2gtC+
         EcnQ==
X-Gm-Message-State: APjAAAV9BLZg+D05gPraA3lTWuRodIEySha2CA8q3dokAeS9tLuXYyUm
        +c6pFkQ8ix28hkbrB3HYY7DJVWXz
X-Google-Smtp-Source: APXvYqw37NgVyLzcAvycgwNRC3MqPavKV/nYQleqCjL3jB4M1KXcZf3Tup86vZ2sofeuPjlnFSJtVg==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr49492650wrm.75.1582321650337;
        Fri, 21 Feb 2020 13:47:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m125sm5691930wmf.8.2020.02.21.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:47:29 -0800 (PST)
Message-Id: <04965a8c7a48b2fbb5049b640487015fdd7bbd22.1582321648.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.556.v2.git.1582321648.gitgitgadget@gmail.com>
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
        <pull.556.v2.git.1582321648.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Feb 2020 21:47:27 +0000
Subject: [PATCH v2 1/2] partial-clone: demonstrate bugs in partial fetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, jonathantanmy@google.com,
        jrnieder@gmail.com, sunshine@sunshineco.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While testing partial clone, I noticed some odd behavior. I was testing
a way of running 'git init', followed by manually configuring the remote
for partial clone, and then running 'git fetch'. Astonishingly, I saw
the 'git fetch' process start asking the server for multiple rounds of
pack-file downloads! When tweaking the situation a little more, I
discovered that I could cause the remote to hang up with an error.

Add two tests that demonstrate these two issues.

In the first test, we find that when fetching with blob filters from
a repository that previously did not have any tags, the 'git fetch
--tags origin' command fails because the server sends "multiple
filter-specs cannot be combined". This only happens when using
protocol v2.

In the second test, we see that a 'git fetch origin' request with
several ref updates results in multiple pack-file downloads. This must
be due to Git trying to fault-in the objects pointed by the refs. What
makes this matter particularly nasty is that this goes through the
do_oid_object_info_extended() method, so there are no "haves" in the
negotiation. This leads the remote to send every reachable commit and
tree from each new ref, providing a quadratic amount of data transfer!
This test is fixed if we revert 6462d5eb9a (fetch: remove
fetch_if_missing=0, 2019-11-05), but that revert causes other test
failures. The real fix will need more care.

The tests are ordered in this way because if I swap the test order the
tag test will succeed instead of fail. I believe this is because somehow
we need the srv.bare repo to not have any tags when we clone, but then
have tags in our next fetch.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5616-partial-clone.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index fea56cda6d3..022f1018ace 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -374,6 +374,37 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	grep "want $(cat hash)" trace
 '
 
+# The following two tests must be in this order, or else
+# the first will not fail. It is important that the srv.bare
+# repository did not have tags during clone, but has tags
+# in the fetch.
+
+test_expect_failure 'verify fetch succeeds when asking for new tags' '
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
+	for i in I J K
+	do
+		test_commit -C src $i &&
+		git -C src branch $i || return 1
+	done &&
+	git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
+	git -C tag-test -c protocol.version=2 fetch --tags origin
+'
+
+test_expect_failure 'verify fetch downloads only one pack when updating refs' '
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
+	ls pack-test/.git/objects/pack/*pack >pack-list &&
+	test_line_count = 2 pack-list &&
+	for i in A B C
+	do
+		test_commit -C src $i &&
+		git -C src branch $i || return 1
+	done &&
+	git -C srv.bare fetch origin +refs/heads/*:refs/heads/* &&
+	git -C pack-test fetch origin &&
+	ls pack-test/.git/objects/pack/*pack >pack-list &&
+	test_line_count = 3 pack-list
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

