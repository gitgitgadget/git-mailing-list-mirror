Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152E0C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 18:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357441AbiBNSXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:23:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357428AbiBNSXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 13:23:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48879BCAB
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:23:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v12so28346485wrv.2
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=BsQJMKkDwxsN5bx1a6tBiFUthE858juY6tUoHkR2OCVQ3eDehsfngLOGHikGNMD/Ul
         GgnXYNUzjNm0hXWaao6VNOCfto8l2f37ykxahy1YdCcjEAgEXyJ9RxcIERD0WhwFNfkg
         mustFk1R5banzCHtSjnS7KUiK1KmoaHCzgFfmIcm0vjMWzNbjipIW1NXoCmGSBZs4gie
         C7eJB5wXoXkMOSfvemy4xYSa00YaKsHckvtERCYXZY5IC2sWASDT2D8try0jtrJ4nT2e
         TH7pczxgDjcgoRrko0IAvovnueDGdLAPCLS5rMy0v4O5NaKIuk4+IuijDQPN5I+mWGpp
         reYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=Kf5V5Ng1ddxfM/hHmpADhBs6d1nvNkkYt5ZLrLMsxJ3NOhEQYXntlr1O2txc4h8IFE
         KLGqSfPeNM5bfwhgxQ4qrO0iNUCht9hroXGmJVTuLkECxeFosZ4MERjRN1nGfBB/4e7Z
         hPRUvWQG9/I0IFEAB5PinxnVfr7JdKDZwGvNgt07xx1x/EQXOAXP+29+lb/tM0TeMpOs
         axUtAdF+JnZs9P+kPM1lQ0Adr9SW22w1bMMQQlguyx2WYEnQdMg+Avxg73pI30hxrdrz
         0ymxrMmIdEmu2qqCR583jnsEwxybOuyjK71dh0aIPStnb/bv6Dz/FJ2NdVD1eccJ3XEI
         iOng==
X-Gm-Message-State: AOAM531N1SKLjw+eTnmcHfI7wjZelG3LxGuCbtY3l+j797+rLN/z0Exz
        rxy0/Qy7+m6gQqId7/rn8v0sd8kY0Tk=
X-Google-Smtp-Source: ABdhPJyRyJcT8e6HPKtCUrSC+z+nyiY9KcSIgtPoSoUG8YUatu0ec+r2EhKuePIE1X5A5bAbLZREjQ==
X-Received: by 2002:a5d:5382:: with SMTP id d2mr263282wrv.44.1644862992776;
        Mon, 14 Feb 2022 10:23:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13sm30523863wrd.78.2022.02.14.10.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:23:12 -0800 (PST)
Message-Id: <486ee84781679d587f137b9c24fb5377e4b138d8.1644862989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
References: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
        <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 18:23:07 +0000
Subject: [PATCH v6 3/4] cat-file: add remove_timestamp helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

maybe_remove_timestamp() takes arguments, but it would be useful to have
a function that reads from stdin and strips the timestamp. This would
allow tests to pipe data into a function to remove timestamps, and
wouldn't have to always assign a variable. This is especially helpful
when the data is multiple lines.

Keep maybe_remove_timestamp() the same, but add a remove_timestamp
helper that reads from stdin.

The tests in the next patch will make use of this.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1006-cat-file.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 145eee11df9..2d52851dadc 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -105,13 +105,18 @@ strlen () {
 }
 
 maybe_remove_timestamp () {
-    if test -z "$2"; then
-        echo_without_newline "$1"
-    else
-	echo_without_newline "$(printf '%s\n' "$1" | sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//')"
-    fi
+	if test -z "$2"; then
+		echo_without_newline "$1"
+	else
+		echo_without_newline "$(printf '%s\n' "$1" | remove_timestamp)"
+	fi
 }
 
+remove_timestamp () {
+	sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//'
+}
+
+
 run_tests () {
     type=$1
     sha1=$2
-- 
gitgitgadget

