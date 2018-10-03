Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751061F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJCXPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:15:50 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:54935 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeJCXPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:15:50 -0400
Received: by mail-vs1-f74.google.com with SMTP id g4so1871890vsh.21
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Knud7B3u0swT8xRSzWz1+dS6tL4cEtmY7UW6QDrMuQs=;
        b=IrgF9NtdhKXfBLNwY+iOI4Rub4jRApHU+5sh6+GZQlRcRvxAHUrJTUANW0xPOU8K0e
         8hoTO0EEKo4Cp/i9epwZ3LXH2F2UOurjAoSdtsDwhHB3UoftHisI484rxWP8y4qaHEXz
         eCgyyv/VBab5qaxftzgbI46ByqqH34Ja2SuBdnsw4k1IqoIfp3h3EFTMoW9d6AANCWmL
         taFZU8O+1LMDRsaE6uCIBGPhyd3pwil5AsDWLzv77sBN+iKOvftBEp92fmnhb3d/s7lF
         BQadKolOW40TZ392JvTMAOsMWdXO6P5BDyqqrifCQdnSpfV8Y2+vSjr7v/iK4EctqEjB
         wNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Knud7B3u0swT8xRSzWz1+dS6tL4cEtmY7UW6QDrMuQs=;
        b=GCa2y2EIEIDdJ81i8yd//GR8zs8IwUFFqRvrG7Wwg8AVzJH/S/gELjd2xh+SJVxOkZ
         9fqaJEdPHBBDo3Yz/vlW7/bRoyvGDulLXvP7zd4iTVlWK8M+ivWgsm84RSR9bp/uKPS7
         CB9C+bsaqiLSE4lLh0FraVwPJiwYuNpFIZHguX2hccg2jG4ARSMqkg7uGAAA+6ga3c6M
         pLFKyS4E7VEHDGyK7ID/FJw4pOFigmcA6TUk8kcbGFDgBxMqJgAuK5jyzUNtJL9cf2Vs
         Cjn8EBTnmJdpF3g8oZ5CSHkGTLwOdfnFFCOWyf5MmRRWr0P95s3NZRsUtdM44hbt7VuX
         Zv/Q==
X-Gm-Message-State: ABuFfoiXIN0GnVztr39RV20cibLfy2fh3DfC0+gtgj1x92A4IV0MFRYa
        uVG5QPvgD7cXP38ODwZFOu/CGLsAZFZeEock/3jpZMiBQfwO3EYOsfW5pbRg/5zsC7MFOVk/6yv
        wverpF3fTz/EyPrYM1H58htHTtxHFPk/srgR7DdspD8kEjrTRUAHCqCoqqpE=
X-Google-Smtp-Source: ACcGV62u7SONvCtxrff/RU8OBmcvf3fpi5u51+bByecM/CPTFT8AdWiIiMYARSPG2FZKC5kQDmvKiVJIlJMs
X-Received: by 2002:ab0:6552:: with SMTP id x18-v6mr1966493uap.22.1538584003353;
 Wed, 03 Oct 2018 09:26:43 -0700 (PDT)
Date:   Wed,  3 Oct 2018 09:26:04 -0700
In-Reply-To: <cover.1538581868.git.matvore@google.com>
Message-Id: <5286adcc7184d00383fa24382692e294380ef885.1538581868.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538581868.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 6/7] t9109: don't swallow Git errors upstream of pipes
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git ... | foo' will mask any errors or crashes in git, so split up such
pipes in this file.

One testcase uses several separate pipe sequences in a row which are
awkward to split up. Wrap the split-up pipe in a function so the
awkwardness is not repeated. Also change that testcase's surrounding
quotes from double to single to avoid premature string interpolation.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/t9101-git-svn-props.sh | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 8cba331fc..c26c4b092 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -190,17 +190,21 @@ EOF
 # This test can be improved: since all the svn:ignore contain the same
 # pattern, it can pass even though the propget did not execute on the
 # right directory.
-test_expect_success 'test propget' "
-	git svn propget svn:ignore . | cmp - prop.expect &&
+test_expect_success 'test propget' '
+	test_propget () {
+		git svn propget $1 $2 >actual &&
+		cmp $3 actual
+	} &&
+	test_propget svn:ignore . prop.expect &&
 	cd deeply &&
-	git svn propget svn:ignore . | cmp - ../prop.expect &&
-	git svn propget svn:entry:committed-rev nested/directory/.keep \
-	  | cmp - ../prop2.expect &&
-	git svn propget svn:ignore .. | cmp - ../prop.expect &&
-	git svn propget svn:ignore nested/ | cmp - ../prop.expect &&
-	git svn propget svn:ignore ./nested | cmp - ../prop.expect &&
-	git svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect
-	"
+	test_propget svn:ignore . ../prop.expect &&
+	test_propget svn:entry:committed-rev nested/directory/.keep \
+		../prop2.expect &&
+	test_propget svn:ignore .. ../prop.expect &&
+	test_propget svn:ignore nested/ ../prop.expect &&
+	test_propget svn:ignore ./nested ../prop.expect &&
+	test_propget svn:ignore .././deeply/nested ../prop.expect
+	'
 
 cat >prop.expect <<\EOF
 Properties on '.':
@@ -219,8 +223,11 @@ Properties on 'nested/directory/.keep':
 EOF
 
 test_expect_success 'test proplist' "
-	git svn proplist . | cmp - prop.expect &&
-	git svn proplist nested/directory/.keep | cmp - prop2.expect
+	git svn proplist . >actual &&
+	cmp prop.expect actual &&
+
+	git svn proplist nested/directory/.keep >actual &&
+	cmp prop2.expect actual
 	"
 
 test_done
-- 
2.19.0.605.g01d371f741-goog

