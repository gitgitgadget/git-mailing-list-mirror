Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECD220248
	for <e@80x24.org>; Sun, 10 Mar 2019 08:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfCJIKd (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 04:10:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42284 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfCJIKd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 04:10:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id b2so1581423pgl.9
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 00:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+eBoSJ9ARcozua0Se4O0zPcu4GM6E4K7QblL9zOcXw=;
        b=YmRqHjQc57gCHd+YDZlazS/hd+rrEMa5Ov1cMUxqtlv6ElzkCLIJV8MqdlnyIRJ9wJ
         Dk1MsRomgYZfcYwz0NejXXk1W4emxs3Heg6G0Ubd1rJUSS8wB4HshL5raMIzd0gvStPg
         voG+IMpYDXYiigPOT/HS3p/d5T96LGn9lo96wSyGu2DDj6d3t2uSGL3WOy1FFj32AYcU
         +wnWQeeMTj7U48Mb6mr/KR3TDe3zS9ZIKXxHin8IN29SrJuqORdE7tK3zi4cL2C0jcMM
         hpgxIC6+hnETXav4p55+86uWI+8SebTuhrvtxYzwS+gRWfyL2LsPs9Re4Z7uX9KjaM57
         ahcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+eBoSJ9ARcozua0Se4O0zPcu4GM6E4K7QblL9zOcXw=;
        b=fLiHapRnNlF8uaV6oJ2vbr/w2cfJOUD3aR1ad39kK/GnZwOBw3SQPMDGSxtHBEra+7
         hhupEYVfsWX0Q/xPquy916vjMeUiOgckkV4rFwDL9ZThbJRXZvBztw5vDn76HzuudtKd
         qiDKLYVBlD1pfxGQ55WlMu8I/07e+RD+erOLYo0CPG9ApOflTbdS6z23YsqIJSc8Nz6s
         dxT5jcsOb8Q8+skQVnPSml3qasF/hIULNw6I1t06AdQGQ3WFp2Lnq61LcFfoWgBOMAeW
         75YTxSjXn+gGUHlIu4PqkyL6LgLQ/OXYHByE5CvSxtWgBbSwvqiLyyHoCxOfTqG2jyTK
         9HGA==
X-Gm-Message-State: APjAAAVkx1SWRs56Y6nDKiwzqRoPh56NZsi+CmzsjLUMRv6ny/3F9cN8
        6xz4AbdhkkV9NlReFVhDUoU=
X-Google-Smtp-Source: APXvYqzI95awRD0moK+qE20lE34Z7FZ59p+fWOa+sM84WSOCTkRpVWLSwBymCLINigC7pMncwCXpXQ==
X-Received: by 2002:a65:614a:: with SMTP id o10mr24700066pgv.51.1552205432543;
        Sun, 10 Mar 2019 00:10:32 -0800 (PST)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id d6sm3737757pfg.47.2019.03.10.00.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Mar 2019 00:10:32 -0800 (PST)
From:   Jonathan Chang <ttjtftx@gmail.com>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Subject: [GSoC][PATCH v2 4/5] t0022-crlf-rename: avoid using pipes
Date:   Sun, 10 Mar 2019 16:10:23 +0800
Message-Id: <20190310081023.64186-1-ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190310080931.64134-1-ttjtftx@gmail.com>
References: <20190310080931.64134-1-ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>

diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 7af3fbcc7b..05f443dcce 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -23,10 +23,10 @@ test_expect_success setup '
 
 test_expect_success 'diff -M' '
 
-	git diff-tree -M -r --name-status HEAD^ HEAD |
-	sed -e "s/R[0-9]*/RNUM/" >actual &&
+	git diff-tree -M -r --name-status HEAD^ HEAD >actual &&
+	sed -e "s/R[0-9]*/RNUM/" actual >output &&
 	echo "RNUM	sample	elpmas" >expect &&
-	test_cmp expect actual
+	test_cmp expect output
 
 '
 
-- 
2.21.0

