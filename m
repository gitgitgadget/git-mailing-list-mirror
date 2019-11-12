Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913D91F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKLAOI (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:14:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33818 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKLAOI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:14:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so3185849plr.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B4LobExkO6qdJNNfri25obgW5ZiuJa76RQy5+L4ZPY8=;
        b=OBzZccaO+F96R2rRWL0gZ5/2uojZ56Yzl1WwqgON8sYAzF/AYzN8SjdRaJOL7WqYu/
         RA7ozFG9GmDRMkDuy616cGcM3EA4vL5a894C9KRX7eRWi0j0GKXNeE14CvZ8nvwad1cv
         9NpG8a2LewtKBjg/Kn9OuicLK19ZlVfguLy/YZAC4cEznS/VCG82bQH8r2oZaJ1LIS3L
         w0KjJY0fomQxgaNMQHSIPAwkPMEUNitsA4Agj2lOrn2qu1NCx4O/ZVtky0Fd/iYgKgwu
         zBvZydI3XQpemliQ9I1T9Z32g6cwsG9pHTsM9r41cfyWTaW0kP5FHEMBzwfA02NSJ670
         FDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B4LobExkO6qdJNNfri25obgW5ZiuJa76RQy5+L4ZPY8=;
        b=ivB4+d6H2iq7kaven+1Yk55mcVKuLXxuKERsgXlR3Xtvfg9UqGV70ddtdeonyfxpYG
         ZPPdTTyZLxnoM5RVu3oA9uj/NgMiKZY+25J+1gi8eL+CJuEfAmigDLiqJ5q870w8dGiq
         CG7zzgnMh/TrAb9tzgr+rAp+Ce8ciQp+VRUv8J8eM8SJoKvxki1AkDV9RsPho9xLnLni
         36OKtL2mEcouawk4XNkaBzz9FaU6mfxYPO09+8P3LS2vCWTn64vgWKCSR5jTjZPlplL3
         QsCVEIFgc8GJsMeN77s7tDVEB23yum8igcltRZxzi2y2lw/l7vez2reU9aYLm6zWYbh9
         oVuw==
X-Gm-Message-State: APjAAAV8F3kcpgc6Hwbn+H1MTuJbySOzll/bC0xBPpY0pSbqG8MsaeRd
        9KhAvgwb4LiqzeBn2iw1CZdLuJ4s
X-Google-Smtp-Source: APXvYqzXA48vJTv//7TbH4ohG6riDoNZWdXvCqrlK/72QKSCYv84H/PMzuz4ndqywJ9Z76Xk5hnKZQ==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr27423115ple.274.1573517647104;
        Mon, 11 Nov 2019 16:14:07 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id d139sm21950952pfd.162.2019.11.11.16.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:14:06 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:14:05 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 11/14] t5520: don't put git in upstream of pipe
Message-ID: <3fd10a58c64a7e472c0a972f3477a879b1d14f64.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, if the invocation of git failed, it would be masked by the pipe
since only the return code of the last element of a pipe is used.
Rewrite the test to put the Git command on its own line so its return
code is not masked.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 8b7e7ae55d..8ddf89e550 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -668,7 +668,8 @@ test_expect_success 'pull --rebase fails on corrupt HEAD' '
 	(
 		cd corrupt &&
 		test_commit one &&
-		obj=$(git rev-parse --verify HEAD | sed "s#^..#&/#") &&
+		git rev-parse --verify HEAD >head &&
+		obj=$(sed "s#^..#&/#" head) &&
 		rm -f .git/objects/$obj &&
 		test_must_fail git pull --rebase
 	)
-- 
2.24.0.300.g722ba42680

