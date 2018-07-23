Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828A81F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbeGWOEH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:04:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38018 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWOEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:04:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so891264edr.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmfyXNf/EFFxXWV337g+MoNXqlX24oyJc/dWf6RzE5Y=;
        b=Ap08Cl2tjzEu7sEbAAPeSWK/Gc1DdCbeEHd4WDanq8p6pAOPePl07/5adW+JhAfoRx
         2GfYoAQFj/DoIrvE89l5PveLV71EHKi4DOv1bInAsleLoxgnY0wm7pVrSp+JeyvAesPA
         ZtSX1/yUe2z9Kydt1bAePjnnoPKGAn0YWH9g6WbkW+UN5DxgOpVt3KlTYX3Olc3/1E8V
         5MBiRc1JEnxk5ZCJFkjHnyFMxnadCXGMVh0Y8QJUvwSeyr9MXR3WZp2Yo14CXBxtdVIV
         NrN8w/X7iobCD/mjakwcc2qJ0XD7GDkJTfx1AyPQkpdbG9eJ1vhUS9Lnz7Z6y/z/QrJg
         ZGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmfyXNf/EFFxXWV337g+MoNXqlX24oyJc/dWf6RzE5Y=;
        b=jS24nCMr0jaua3M45eSbw8M/sBwoxbywnLh5Q7tulyRbynlTZonn68IzmbXYNI5kpl
         dblVykQcZsFdMP9vYuTHj5h0maoyaEYsdiRQFJL2RhESEWl+fGcJwTZLrMHxoCOOIT56
         nbf0jaH6KMbnn72oPnyHgRYnz3/NH1tsb3WdhfQw8asuzfruvtnUheaE2nXxh9rar+UA
         y3uXRYYmOHn7544E3/V2PlSx7xA/sMSD9XU1qUaNJdg86fCBaGCCE59PEkejIZ4tDosx
         QpjrmvEe4rOyKFo/MKC28E6vvCYm3Bf/ecbadS6WRNyzlPSajCxtgfoRQdsF/m0zC+oI
         k1LQ==
X-Gm-Message-State: AOUpUlFVJ1pCPvt5MymjtVTXFC0MpgjwTdxdSTHq5KZ8GeCkL27JArzE
        dFin8E6jxAzh6BdeMQgVZv8=
X-Google-Smtp-Source: AAOMgpeM+LyRiJBExlJy2D3dUxI8jsnis/Jwy5GqHA70kD1csr/k6PFDNQ+ePOt3GTniB10lPmBZgw==
X-Received: by 2002:a50:a762:: with SMTP id h89-v6mr14273932edc.261.1532350977919;
        Mon, 23 Jul 2018 06:02:57 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a5-v6sm8834263edr.1.2018.07.23.06.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:02:57 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] travis-ci: fail if Coccinelle static analysis found something to transform
Date:   Mon, 23 Jul 2018 15:02:30 +0200
Message-Id: <20180723130230.22491-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180723130230.22491-1-szeder.dev@gmail.com>
References: <20180723130230.22491-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coccinelle's and in turn 'make coccicheck's exit code only indicates
that Coccinelle managed to finish its analysis without any errors
(e.g. no unknown --options, no missing files, no syntax errors in the
semantic patches, etc.), but it doesn't indicate whether it found any
undesired code patterns to transform or not.  To find out the latter,
one has to look closer at 'make coccicheck's standard output and look
for lines like:

  SPATCH result: contrib/coccinelle/<something>.cocci.patch

And this only indicates that there is something to transform, but to
see what the suggested transformations are one has to actually look
into those '*.cocci.patch' files.

This makes the automated static analysis build job on Travis CI not
particularly useful, because it neither draws our attention to
Coccinelle's findings, nor shows the actual findings.  Consequently,
new topics introducing undesired code patterns graduated to master
on several occasions without anyone noticing.

The only way to draw attention in such an automated setting is to fail
the build job.  Therefore, modify the 'ci/run-static-analysis.sh'
build script to check all the resulting '*.cocci.patch' files, and
fail the build job if any of them turns out to be not empty.  Include
those files' contents, i.e. Coccinelle's suggested transformations, in
the build job's trace log, so we'll know why it failed.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-static-analysis.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index fa719c9ef9..5688f261d0 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -7,4 +7,23 @@
 
 make --jobs=2 coccicheck
 
+set +x
+
+fail=
+for cocci_patch in contrib/coccinelle/*.patch
+do
+	if test -s "$cocci_patch"
+	then
+		echo "$(tput setaf 1)Coccinelle suggests the following changes in '$cocci_patch':$(tput sgr0)"
+		cat "$cocci_patch"
+		fail=UnfortunatelyYes
+	fi
+done
+
+if test -n "$fail"
+then
+	echo "$(tput setaf 1)error: Coccinelle suggested some changes$(tput sgr0)"
+	exit 1
+fi
+
 save_good_tree
-- 
2.18.0.408.g42635c01bc

