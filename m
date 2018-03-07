Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904D01F404
	for <e@80x24.org>; Wed,  7 Mar 2018 01:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeCGBFi (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 20:05:38 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37380 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933236AbeCGBFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 20:05:35 -0500
Received: by mail-pf0-f196.google.com with SMTP id h11so273647pfn.4
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 17:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKHhAmDQcIDO0cKl5dHWW6ThqPKMG2vhJxpuVdqyLqE=;
        b=SBE3RKdfLW3xPZ3H7gGTFDVDyAeocfimmGxv06sy31P9AQipiuGhx/MGtRn9ZMeIo3
         XoFznxndiVNs4jBx3VSCvmvAPyL/lMlmCxtx2TFMqvFmV8Ksv2fi6h4e81HatAhxueCT
         ursL6RH5qyWZU9nnSe2oD9hjfFO8k9rMiysEoqmoTQIUbMrZwYQJ09r3kuJ5V30GWhLF
         jyzOPGLbAkX7FmfhlI0BNV0dN6r0Zc7BwLT14aWez3DhvYZD9U3zmDAwymNAfuGh47qy
         nXsRN3gBMddjppZOGhoAnDoF6nF5PB5rD0PQ4LYSpDriVUAY1Rrh+DDGbTbRMTD4xKdg
         lXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKHhAmDQcIDO0cKl5dHWW6ThqPKMG2vhJxpuVdqyLqE=;
        b=qg9gPS+ec0l450J1Uansz2osJjhfc6ERWPWl9gFnLmqrghgcN2er0EcbjeM9uM13Oj
         VL8t6mm806qmt7/qDBThFgNwHIW97q+d4UMLr0TB6syc7QaINmPB680IVQPa7Tzz/hSb
         Fg8+Ur7EjtF3nAzcUdzcTRkZJXd07wXqd0/rg+sD2EYhDCp+nvm+7J9mqZTZYkmBkA8o
         qhqrtpswFOTqX6s14hG8+sJgu/Y8kTFe/xXaOUTDFWmuUWT4vLTQ7H9mN7+de1h56DJh
         LgVqPuraLVX9B68TDRPWDqMMu39dv5t4hW4vxlvYQ7DW9ZXU5xSs2KScxL9IDcXJTBVN
         OcJA==
X-Gm-Message-State: AElRT7FUCMTdJcMRGOmbakr10F2puZbWs6so9Mz8nJuK2nWgfHl1Ya+U
        NOXVPLWwo0eeViHh0oeMBEf+iw==
X-Google-Smtp-Source: AG47ELsiDfzC9WSl4U2Or0JoCcHoq7RgB1gp6/WTeN4P/fMOcqDvHLx979jF/ACOSzNw/kAizXcqnw==
X-Received: by 10.98.14.79 with SMTP id w76mr12878743pfi.1.1520384735050;
        Tue, 06 Mar 2018 17:05:35 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p10sm27664133pgd.28.2018.03.06.17.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 17:05:34 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        phillip.wood@talktalk.net
Subject: [PATCH v2 2/4] completion: simplify _git_notes
Date:   Wed,  7 Mar 2018 08:05:02 +0700
Message-Id: <20180307010504.9289-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.785.g429c04a1b9
In-Reply-To: <20180307010504.9289-1-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com>
 <20180307010504.9289-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This also adds completion for 'git notes remove' and 'git notes edit'.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0d858cacce..37bf4a64d3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1836,19 +1836,11 @@ _git_notes ()
 	add,--reedit-message=*|append,--reedit-message=*)
 		__git_complete_refs --cur="${cur#*=}"
 		;;
-	add,--*)
-		__gitcomp_builtin notes_add
-		;;
-	append,--*)
-		__gitcomp_builtin notes_append
-		;;
-	copy,--*)
-		__gitcomp_builtin notes_copy
-		;;
-	prune,--*)
-		__gitcomp_builtin notes_prune
+	*,--*)
+		__gitcomp_builtin notes_$subcommand
 		;;
 	prune,*)
+		# this command does not take a ref, do not complete it
 		;;
 	*)
 		case "$prev" in
-- 
2.16.2.785.g429c04a1b9

