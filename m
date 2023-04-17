Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921FEC77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjDQQVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjDQQVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:21:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83107A9E
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso45789435e9.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681748506; x=1684340506;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I+TJb3UF85e7M46snjurYlU1bJrW9+bpGYaoMDA3Sc=;
        b=O4hluSS/zRNmU31X5clANad0dmsgvpEefM/wIzzcjNpPmuk0bzde9xg4md1dVdYu6n
         R+FmkQN0gtf6/CtGJ2AacWro2SfFKsYDb+9B+a8hv+rKmBujZ1/aNvmOTvLsZ4kk5vlL
         U7YWMB2Pu8kUoX0eEdsLsWKMLbrJTpyK38baD4xtD8J+d5Eo1d8a4yAANwb+JcxTTW69
         BWZXIRLRUGqLrCpyJ+hSQEfRzl3NLkwVp/3jsZPzgmsZ1UadvtF483fN3JqKvSf7PEI7
         tVgSAB7UbygyOMWOOssFUmfb1W98BbtpGogrB3U2lDKvQ/dZ43K5e4NyVk4tvI4Rvjvf
         tZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748506; x=1684340506;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/I+TJb3UF85e7M46snjurYlU1bJrW9+bpGYaoMDA3Sc=;
        b=fC+6nxek48quCLIzu7Pxc5rQR0Vd6wk1rmtWjyE7ZNQp7CSwuPHoZGRpqk6+B4EkUa
         WNFXsp0Vjwv5XMNY0hQC++BPCU/9qyT9Iqog4kmGxGfANNbi5BcDKC9HZh/iip/yrxJv
         lqamhdjVAcMJ9jm0CuatfpVZ1uKehp6v4/BcozDs9XQo0hf+b9q5+M/6ISVcTeePEtp3
         kFpq19kkqltIK1qq8Xu/IkJ5Sb+DQuawc/9ORRp+oDR9Zq1ilN8Y86VuhPcOljCJe9KD
         9JiERTntOOBv/HzsIY0JpU/h4z8SkasLCZKpkaU4ERwJ2L1EfTIXbNVk3yUGHOOq5U0g
         1nQg==
X-Gm-Message-State: AAQBX9c24pO6f0y1c6YpAATXZQDOycOOZaVNeE8XJf1JDID4fr2dFhka
        2+DNBYTBlQuXqWYCGa4IpHhYaIKUQRc=
X-Google-Smtp-Source: AKy350YQYPH+4Sogr9awf8IW4rXDQHEuM9v0Dp2WJcU3abMahySXevHopKc2+Ud99RdjyKIgaiDfmA==
X-Received: by 2002:adf:eec8:0:b0:2ef:afe0:727a with SMTP id a8-20020adfeec8000000b002efafe0727amr5438253wrp.12.1681748505971;
        Mon, 17 Apr 2023 09:21:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14-20020adffa4e000000b002f5fbc6ffb2sm10732490wrr.23.2023.04.17.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:21:45 -0700 (PDT)
Message-Id: <adbe9c8ee90e087e864bd9e0c67338974b5dbc8d.1681748502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Apr 2023 16:21:40 +0000
Subject: [PATCH 3/4] fsck: check rev-index position values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When checking a rev-index file, it may be helpful to identify exactly
which positions are incorrect. Compare the rev-index to a
freshly-computed in-memory rev-index and report the comparison failures.

This additional check (on top of the checksum validation) can help find
files that were corrupt by a single bit flip on-disk or perhaps were
written incorrectly due to a bug in Git.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 pack-revindex.c          | 25 +++++++++++++++++++++----
 t/t5325-reverse-index.sh |  5 +++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 007a806994f..62a9846470c 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -310,16 +310,33 @@ int load_pack_revindex(struct repository *r, struct packed_git *p)
  */
 int verify_pack_revindex(struct packed_git *p)
 {
+	int res = 0;
+
 	/* Do not bother checking if not initialized. */
-	if (!p->revindex_map)
-		return 0;
+	if (!p->revindex_map || !p->revindex_data)
+		return res;
 
 	if (!hashfile_checksum_valid((const unsigned char *)p->revindex_map, p->revindex_size)) {
 		error(_("invalid checksum"));
-		return -1;
+		res = -1;
 	}
 
-	return 0;
+	/* This may fail due to a broken .idx. */
+	if (create_pack_revindex_in_memory(p))
+		return res;
+
+	for (size_t i = 0; i < p->num_objects; i++) {
+		uint32_t nr = p->revindex[i].nr;
+		uint32_t rev_val = get_be32(p->revindex_data + i);
+
+		if (nr != rev_val) {
+			error(_("invalid rev-index position at %"PRIu64": %"PRIu32" != %"PRIu32""),
+			      (uint64_t)i, nr, rev_val);
+			res = -1;
+		}
+	}
+
+	return res;
 }
 
 int load_midx_revindex(struct multi_pack_index *m)
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 6b7c709a1f6..5c3c80f88f0 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -185,4 +185,9 @@ test_expect_success 'fsck catches invalid checksum' '
 		"invalid checksum"
 '
 
+test_expect_success 'fsck catches invalid row position' '
+	corrupt_rev_and_verify 14 "\07" \
+		"invalid rev-index position"
+'
+
 test_done
-- 
gitgitgadget

