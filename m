Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DABC61DA3
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 23:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjBTXwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 18:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBTXvb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 18:51:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4D21E5F5
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 15:51:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p1so1133433plg.7
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 15:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMT+JEiWLJg750iBj/zzRXMIYlbBeiRVGYuAuPeOLvA=;
        b=UQEB3GnpEMGV/g1+8cCD6edK3H1sqU/fem853bChKb1K+p/WAEewYLnzjRtBHin37c
         K2Jvcs2YfMKdlk33oEBSm4VruA2lTiRsTF/YgCuvSzAhdIzbISTMzeQh23YGn4MOGP+8
         Xt7/UEFyfD5U8iQ/5OofO/KHb6PkVusdikRL7j6PPogwTlYEk1wdShWEaaYl93HQY5ct
         INXbyzQ9xYe2jiqekRbjY4S7uf8iJPNuAjySZD8AtiwPuJVNgkyrcST6KD96ajDczUr0
         y+wcKcEcdaZt/ZIszPac6PRyRjTQjd6W3Mklp5T5bKHQC8t2fqDSF5ZyFfJHO1XF9vkU
         8T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMT+JEiWLJg750iBj/zzRXMIYlbBeiRVGYuAuPeOLvA=;
        b=Nj/pG5BRmpxslnS7u4x7nr+3VxHNOqmkgZM3hH59R5e1T1wwapWaffSU0BU3S6yCGo
         h5sXcfvLoTxoprAcYQTU18nt2zdMpUp+adiaaaFOpxszlZ+r7O6EbR2t78C5D16dHhTH
         9TwKTu1RgYDfbE/m3g3lJlUH1dlkM4wdJljM79cuXF8AAQPl9I2TQqUmTmYAh4AAtwF7
         WtJELivb9RX63O6MlCBGgEkuEECmOzTKQd2dYi9GWGKrIh5zyeILqVdloNemvHI1Z/ZL
         TfD1q48l6VUHX03YvcGIaEq6tsRaT+duaot6jeF7QH/cH7RlK8IL23M7C52UXqKE0DV9
         GkvQ==
X-Gm-Message-State: AO0yUKUR0vvF21O73HXEiT0q/FpXV+0xzRT3nSF3BT4MQJvtbKjT817I
        db6WAk0fJbt4JouUjtD79baBo0UD+9E8Rg==
X-Google-Smtp-Source: AK7set+6xViHLoYOdxIcWZbpW5ilBLJXxUA/8tkNuqGpDdpL2QiL+78af9mRN8AbKQ9wi5Id0OuIrQ==
X-Received: by 2002:a17:902:f983:b0:19b:76fb:c6f with SMTP id ky3-20020a170902f98300b0019b76fb0c6fmr2971925plb.68.1676937086176;
        Mon, 20 Feb 2023 15:51:26 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dg56d59ey2wgev.ipv6.telus.net. [2001:56a:740f:7b00:548b:6839:29d0:4517])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902ed4900b0019c91d3bdb4sm128633plb.304.2023.02.20.15.51.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Feb 2023 15:51:25 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [GSOC][PATCH] t4121: modernize test style
Date:   Mon, 20 Feb 2023 16:51:21 -0700
Message-Id: <20230220235121.34375-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test scripts in file t4121-apply-diffs.sh are written in old style,
where the test_expect_success command and test title are written on
separate lines

Signed-off-by: Vivan Garg <gvivan6@gmail.com>
---
Greetings, my name is Vivan Garg. I am currently pursuing a double major
in computer science and finance at the University of Waterloo in Canada. 
I am currently completing my third software developer internship at Morgan
Stanley. As part of my coursework, I studied C and shell scripting, which 
I then applied in internships and personal projects. C++ is the programming 
language that I am most comfortable with right now. Please feel free to 
address me as Vivan, and my pronouns are he/him/his. I meet the requirements 
for GSOC participation. So far, I've either read or skimmed the following 
documents based on prior knowledge: Submitting patches, Coding guidelines, 
Myfirstcontribution.txt, gittutorial, Giteveryday, readme, Hacking-Git, 
General-Microproject-Information, SoC-2023-Ideas, and 
General-Application-Information. I'm looking forward to having a fantastic 
time here! 

 t/t4121-apply-diffs.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index a80cec9d11..2ff38ededa 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -16,8 +16,8 @@ echo '1
 7
 8' >file
 
-test_expect_success 'setup' \
-	'git add file &&
+test_expect_success 'setup' '
+	git add file &&
 	git commit -q -m 1 &&
 	git checkout -b test &&
 	mv file file.tmp &&
@@ -27,10 +27,11 @@ test_expect_success 'setup' \
 	git commit -a -q -m 2 &&
 	echo 9 >>file &&
 	git commit -a -q -m 3 &&
-	git checkout main'
+	git checkout main
+'
 
-test_expect_success \
-	'check if contextually independent diffs for the same file apply' \
-	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
+test_expect_success 'check if contextually independent diffs for the same file apply' '
+	( git diff test~2 test~1 && git diff test~1 test~0 )| git apply
+'
 
 test_done
-- 
2.37.0 (Apple Git-136)

