Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADA920248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfBYXRB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36098 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfBYXRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so567867wmj.1
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NynYJujQ94lxKJxLarWt0zDZrAirFlfY/iW6RJK3jXg=;
        b=YmJ4MLg1eENQAp9Cb7OeKvTl2mGu4u6U6Qb/8Zp90lAyFKewua/cvJaijA7NtdXmuS
         CePvu0j2+pMBGF1gZ9utEcx9z1rhbokvjkJnB50PEb6uiMKUnOOUw/CRtzdRsUMLLgy2
         fFLWzzAHAWgjr6jxIBrPnH62lR1cuPuVS0x3QMy7AR/vroGUaDRv8feBPL+IGu2ZskK5
         pMIm9uvPA/ev3b1PIHxlixwSj3W3gtzwjj6D40Q7PwBFyLOclRIL2z/qtqCbRg0HYTaV
         u2Ybo7adWngP1TmTbVOozH2dPHpXfd8eUStLNlcZJMaR4ZJkzlsNALD1sVfrvHmjOpn6
         2eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NynYJujQ94lxKJxLarWt0zDZrAirFlfY/iW6RJK3jXg=;
        b=TAmJOszaqxO8q9KSoa0d4vHprVcjbKjth5mdgh/7xPshoguM37Se+KF4nTAWZaYqFS
         /5wSdnSJ8MC77KcqWr6meZlZkZQb/CPb51G/0pn/17gX0r5FcNiDarIGB1n3VyB/pVT1
         kIW6HqP6JUrLiMmheVm4JM/5/BetHxywQV2IYvik6VL6MxpNvr1XLErrW1lOWo7R32TT
         St3iK0nZrVrG3SVdOttLqREsiz9N8z7s7DM6R+/QLxVff7hcdpUigcYPsZA3bVv7ng+G
         B7ctWlGIddOHoAVUvvpO/OreSlwgtQb8zHLx361+oYptamSVFEgYJhUqycT+Na3xHWGA
         uYsg==
X-Gm-Message-State: AHQUAuY+ViCShSOHm0w+vl9ptgh2+ppgHS5CRcj0n1h8Ei+qZiq39TW6
        nMGKzSEcNAgOFrmFp88mlDXvMWPK
X-Google-Smtp-Source: AHgI3IYdJNpI3kVs5GSgJvAsOPV5NPih0q6+YqeFlNP8NUghGrmXbmfezU87m0BOJMj4tSyi9wzIbQ==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr638459wmg.136.1551136617919;
        Mon, 25 Feb 2019 15:16:57 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id i13sm11115282wrm.86.2019.02.25.15.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:56 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 07/27] t3903: add test for --intent-to-add file
Date:   Mon, 25 Feb 2019 23:16:11 +0000
Message-Id: <20190225231631.30507-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Kraai <mkraai@its.jnj.com>

Add a test showing the 'git stash' behaviour with a file that has been
added with 'git add --intent-to-add'.  Stash fails to stash the file,
so the purpose of this test is mainly to make sure git doesn't crash,
but exits normally in this situation.

This is in preparation for converting stash into a builtin.

[tg: pulled the test out into a separate commit]

Signed-off-by: Matthew Kraai <mkraai@its.jnj.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3903-stash.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4e83facf23..fc292f339f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -287,6 +287,14 @@ test_expect_success 'stash an added file' '
 	test new = "$(cat file3)"
 '
 
+test_expect_success 'stash --intent-to-add file' '
+	git reset --hard &&
+	echo new >file4 &&
+	git add --intent-to-add file4 &&
+	test_when_finished "git rm -f file4" &&
+	test_must_fail git stash
+'
+
 test_expect_success 'stash rm then recreate' '
 	git reset --hard &&
 	git rm file &&
-- 
2.21.0.rc2.291.g17236886c5

