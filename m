Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB828200B9
	for <e@80x24.org>; Wed, 23 May 2018 12:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbeEWMBQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 08:01:16 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:46432 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932544AbeEWMBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 08:01:14 -0400
Received: by mail-wr0-f169.google.com with SMTP id x9-v6so23142634wrl.13
        for <git@vger.kernel.org>; Wed, 23 May 2018 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KWt2T67Ja0FoMS6XqD8Gn3+/BZiFZbiKMjg6xx5UauM=;
        b=kY44Q5qz/PEELwlIOHzqzm1UnzCzOvYxcgPTweH57xD0GHOnlt2/BxtBV9KS8kKUvW
         HsELUdoRQX1+1l4/LGHZ3yD2IFx5m2clwF+iFqV7fFY2q0+2WtWuaUm3fIrvYjWb5rpa
         /QIyZVUCA8fZ2Sc3yv/qZ754AEOual9E+yNN8I65qo/dQrCB1V7SOX732p3ETsVY8twM
         zDqazv0MVgpuyOWlu++NtVvtuslq2EtwjqyDeT4wSx5SK3t9sbwL/jxbNMk+i4ZbNktA
         NIV2jwc+Hv9a6ffxmcio6aRFHHt/FqSDde1kmPPDAm4TyV8+hVgiy0v4gsP0h+mvp6P6
         VR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KWt2T67Ja0FoMS6XqD8Gn3+/BZiFZbiKMjg6xx5UauM=;
        b=C2lbBquCLBNVwlpXnjET5CjB9BylsVgQb+2oj7kqAPhKZgUEPV0w/WH2EWyK9HqbPn
         bycUJiL5tYbXHbwM/6vbjr/EuCR+T1IbSs+FPh77j81iBQ+keiVJrPWsrsGtfRsG6ok/
         ZbEu/+s/N5dKjtM0cGvw2pfznH8tlX+O54lwuXxaIpFDVd+fLGD0axPsXcA+ybPjaAmy
         UAqDcd3aQtkT02nIN/b/hM16uosh4eo1+tRvUcLpDfaCj3eI/BunXtRXZTcOyTKbXebO
         EyggklUytbomt25GPxfqctYI6NYg3iwnJec3Rgjo1W6IBDfnKrYyeKzs8Ke+dOYkdNGF
         syEA==
X-Gm-Message-State: ALKqPwe2oG87reD7GcMv+9Jh/nrlWQxiBOJ9M/AVZ1g/+y0fCekZEGOt
        hCD7iL3+E5gkzuPLJ5rSsG7DQn13NJA=
X-Google-Smtp-Source: AB8JxZpfMc9CvLI5ac6y+Z68J3iEyP+kOjPro0CktTWOhitZBnP2VArqwv/SUJEXne4CoG+R2T94Nw==
X-Received: by 2002:adf:aead:: with SMTP id y42-v6mr2343743wrc.23.1527076872665;
        Wed, 23 May 2018 05:01:12 -0700 (PDT)
Received: from 192.168.1.103 ([88.98.201.186])
        by smtp.gmail.com with ESMTPSA id h196-v6sm2081176wme.1.2018.05.23.05.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 May 2018 05:01:12 -0700 (PDT)
From:   Tiago Botelho <tiagonbotelho@gmail.com>
X-Google-Original-From: Tiago Botelho <tiagonbotelho@hotmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        haraldnordgren@gmail.com, Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: [RFC PATCH v3 2/2] Add tests for rev-list --bisect* --first-parent
Date:   Wed, 23 May 2018 13:01:10 +0100
Message-Id: <20180523120110.36532-1-tiagonbotelho@hotmail.com>
X-Mailer: git-send-email 2.16.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 t/t6002-rev-list-bisect.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index a66140803..977c82157 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -263,4 +263,43 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
 	test_cmp expect.sorted actual.sorted
 '
 
+# We generate the following commit graph:
+#
+#     A
+#    / \
+#   D   B
+#   |   |
+#   EX  C
+#    \  /
+#     FX
+
+test_expect_success 'setup' '
+  test_commit A &&
+  test_commit B &&
+  test_commit C &&
+  git reset --hard A &&
+  test_commit D &&
+  test_commit EX &&
+  test_merge FX C
+'
+
+test_output_expect_success "--bisect --first-parent" 'git rev-list --bisect --first-parent FX ^A' <<EOF
+$(git rev-parse EX)
+EOF
+
+test_output_expect_success "--bisect-vars --first-parent" 'git rev-list --bisect-vars --first-parent FX ^A' <<EOF
+bisect_rev='$(git rev-parse EX)'
+bisect_nr=1
+bisect_good=0
+bisect_bad=1
+bisect_all=3
+bisect_steps=1
+EOF
+
+test_output_expect_success "--bisect-all --first-parent" 'git rev-list --bisect-all --first-parent FX ^A' <<EOF
+$(git rev-parse D) (dist=1)
+$(git rev-parse EX) (dist=1)
+$(git rev-parse FX) (dist=0)
+EOF
+
 test_done
-- 
2.16.3

