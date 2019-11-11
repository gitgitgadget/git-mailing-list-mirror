Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F051F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKGET (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43849 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKKGET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so9915991pfb.10
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9fWiKySW1suJgtfVV3vz4byD8nYTaq3iv0Zy2pW0MU=;
        b=mEd+6Gfhnvrw2Yex7COhwHacTCRWHLsHRrRupI/YYauWgO2XDwXuAbZ/e78IiH2RBD
         hJ0BCTWB0SjxuPj2dpaVHZbXhd/MxSeqwetJb1zpvyJk2POyTcOsy7i78l3wiLd8Gg2M
         hv7CRd14vHgSMgSZtLjAUMNru1WpuEzS1AScLdffwQJ8UazJUnLDNGkeHnvLIvqcsJWA
         U9GhcB7m5MjMGwJ/Ubm/Zs5YmLm5v3KNZUNPmY49agO8msgopGHp/IrWu/fxKctxr+OL
         AvOdRXCasrS1H8zxaGRRz6l+S+QKQDmQw2Huct6Qzk7uDsZHr0RWu+wenVPI5tFjG4Xu
         S+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9fWiKySW1suJgtfVV3vz4byD8nYTaq3iv0Zy2pW0MU=;
        b=VntC1TuCSbpk7KyMfoScYZe14s79ws5q9/BvVuVjT19c78ljvFcZAnWcoVLPRmLk5d
         +tbJc0oU2OwRkPi2m8rUPeoCmC3BPstNg3uF7tYH793+L4iPIamObOacMOTQSDFM8ECx
         EVnexl/affgECqhvaFUJBtZMhnAfyLmv3s1v4N94f12CuvHdXi6Lj4+4C6Lr6LGeDAff
         dm0Ic/kPgDGexRBOKuh+bp2MLvy0ptVr+3Bpj6Kya942a4JDkxIw01o4aeDydNXuuXIt
         /FkLdFSK4XAWneIdfKLPT5UMf/t3Zon6D5zQOwRaniPtLRlmt1hWHFylY6/nI4zhIOZ3
         Sdfg==
X-Gm-Message-State: APjAAAXhYEaPCIOfpeb3RJNWDLe/IeBWVPDf73bvOZBCkMz6oI3pTC+l
        ERh0d4bExNBin7RZkCt8U0YZqbP+
X-Google-Smtp-Source: APXvYqySPBoGcHXhIP3APuTvn+oxsahUMGBI1KE34tNa2qupBDdPZaE3mERcx0HGCM2BXS0iRLRa/w==
X-Received: by 2002:a65:5c0a:: with SMTP id u10mr27590643pgr.315.1573452258117;
        Sun, 10 Nov 2019 22:04:18 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:17 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 4/9] sequencer: reencode to utf-8 before arrange rebase's todo list
Date:   Mon, 11 Nov 2019 13:03:37 +0700
Message-Id: <0ab92e7999dba2441c90317fb608f85507ebd5b9.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On musl libc, ISO-2022-JP encoder is too eager to switch back to
1 byte encoding, musl's iconv always switch back after every combining
character. Comparing glibc and musl's output for this command
$ sed q t/t3900/ISO-2022-JP.txt| iconv -f ISO-2022-JP -t utf-8 |
	iconv -f utf-8 -t ISO-2022-JP | xxd

glibc:
00000000: 1b24 4224 4f24 6c24 5224 5b24 551b 2842  .$B$O$l$R$[$U.(B
00000010: 0a                                       .

musl:
00000000: 1b24 4224 4f1b 2842 1b24 4224 6c1b 2842  .$B$O.(B.$B$l.(B
00000010: 1b24 4224 521b 2842 1b24 4224 5b1b 2842  .$B$R.(B.$B$[.(B
00000020: 1b24 4224 551b 2842 0a                   .$B$U.(B.

Although musl iconv's output isn't optimal, it's still correct.

From commit 7d509878b8, ("pretty.c: format string with truncate respects
logOutputEncoding", 2014-05-21), we're encoding the message to utf-8
first, then format it and convert the message to the actual output
encoding on git commit --squash.

Thus, t3900::test_commit_autosquash_flags is failing on musl libc.

Reencode to utf-8 before arranging rebase's todo list.

By doing this, we also remove a breakage noticed by a test added in the
previous commit.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c            | 2 +-
 t/t3900-i18n-commit.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8952cfa89b..05403a9005 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5167,7 +5167,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		*commit_todo_item_at(&commit_todo, item->commit) = item;
 
 		parse_commit(item->commit);
-		commit_buffer = get_commit_buffer(item->commit, NULL);
+		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");
 		find_commit_subject(commit_buffer, &subject);
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index dd56384b93..a518281b04 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -209,7 +209,7 @@ test_commit_autosquash_multi_encoding () {
 	old=$2
 	new=$3
 	msg=$4
-	test_expect_failure "commit --$flag into $old from $new" '
+	test_expect_success "commit --$flag into $old from $new" '
 		git checkout -b $flag-$old-$new C0 &&
 		git config i18n.commitencoding $old &&
 		echo $old >>F &&
-- 
2.24.0.164.g78daf050de.dirty

