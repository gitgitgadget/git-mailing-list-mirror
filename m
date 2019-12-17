Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED3EC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 08:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7653D2146E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 08:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtgbzCok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLQIdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:33:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43750 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQIdM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 03:33:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so10290401wre.10
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 00:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V206vPk1ALr+3wG9FCpmM/dCYSVI8m7jM7cBxfy3c0M=;
        b=HtgbzCokFJTWVblpQAl4uOM6PKdcafhTCNQJbSV0POLofhTkm+FrWCMNeMB6N3TDs/
         gNcgKWo1Ws3alSMQFfwoxcjTQzQ574RuaSEKULohzNrBC/EvarHl/Ny/FxxEg00+eZxo
         C2fGVUYG9Cl4ifpm2f/sdnBfRfZQJ8t5pvAOZlPcN59M6aqBUvEkMGpfzSj1xdX5VI5+
         aQXv/lC+2I7tAUbcjyfhsmZOr9t53fhbnMr5jero1Qm4LJTTzw1VclCdz28k0RN57IXU
         I6NPP/1XaKoo6CpGoUN64EaMW4aYv3EmwERjXILSsmvPNUtBP9yMWYPYkxozfwQFGjVc
         4Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V206vPk1ALr+3wG9FCpmM/dCYSVI8m7jM7cBxfy3c0M=;
        b=FJWnNPm/xepksG/lxRexF1WlaOujsnwjnt33AglH4pyaAm/GiT+B6zocZFy2kT3eiH
         XGq1KhQHPcsHL59NstDcxOS3U3bDqn+BFwouiGmh1Pd2kkipdZTUm41yBDJ0CA20V0LR
         6yQUJsgvO+ZNOTq3e5HZecBFpBGrLnjAbYog/eFRtFrgO4/V6R3FUBH88orw0+uBVWEz
         YAuROINiWjJD6T1C3Kf7Wiurb+1gvzanQfIpUOQ1YCif5uVLs0f+qmsD7hvgOJdyv6RI
         OCm3AQALMexAm14hnkeUBIb7CHFpcAkgWycGCyiQFrBvdUhlvkqLC57RChFVDDrbT0pj
         yFYw==
X-Gm-Message-State: APjAAAXNRxCfRFibsAW03CJMHrgkbWUA727REmD9D4YhRL6hp0WaY0ox
        xy1eE72VQiS150lB9bIPz1tXtEg1
X-Google-Smtp-Source: APXvYqyueq7eGF7JtPpGtMPOiuF99fF/1WZnSnKwDa+zvcVRF3KmevuCKZB4w93aR1T36y+6NWVzfg==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr37568160wrt.100.1576571591403;
        Tue, 17 Dec 2019 00:33:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n189sm2204522wme.33.2019.12.17.00.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 00:33:10 -0800 (PST)
Message-Id: <47814640e411b3fda19e5035234513e7d238f75f.1576571586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
References: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
        <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 08:33:06 +0000
Subject: [PATCH v3 3/3] dir: exit before wildcard fall-through if there is no
 wildcard
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The DO_MATCH_LEADING_PATHSPEC had a fall-through case for if there was a
wildcard, noting that we don't yet have enough information to determine
if a further paths under the current directory might match due to the
presence of wildcards.  But if we have no wildcards in our pathspec,
then we shouldn't get to that fall-through case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                                              | 7 +++++++
 t/t3011-common-prefixes-and-directory-traversal.sh | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 13c0c2333c..f08bb073ef 100644
--- a/dir.c
+++ b/dir.c
@@ -379,6 +379,13 @@ static int match_pathspec_item(const struct index_state *istate,
 			       item->nowildcard_len - prefix))
 			return 0;
 
+		/*
+		 * name has no wildcard, and it didn't match as a leading
+		 * pathspec so return.
+		 */
+		if (item->nowildcard_len == item->len)
+			return 0;
+
 		/*
 		 * Here is where we would perform a wildmatch to check if
 		 * "name" can be matched as a directory (or a prefix) against
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 54f80c62b8..d6e161ddd8 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -92,7 +92,7 @@ test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
+test_expect_success 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
 	cat <<-EOF >expect &&
 	untracked_dir/empty
 	untracked_repo/
@@ -110,7 +110,7 @@ test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses int
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
+test_expect_success 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
 	cat <<-EOF >expect &&
 	untracked_dir/
 	untracked_repo/
-- 
gitgitgadget
