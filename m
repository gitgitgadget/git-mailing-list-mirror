Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71861201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdEPHgP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:36:15 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34819 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdEPHgM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:36:12 -0400
Received: by mail-qk0-f196.google.com with SMTP id k74so21267905qke.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 00:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DAfbd4/RRWL6Qg8nWQlB8aofBmC42OXO55jySoDEt4I=;
        b=TpHwPfLBZAgqpHoQvBUHtbtohrsGwo/TmwYO8bm/HV2GJ1VW1q1CJEOdL2IPw14OSc
         Oj3Z50E10mQuai74r7QYgWrVM1dxGXlpU4aAvvke6AGfgd3GxDk4ToyMK76Y4P7YA9Ow
         KdL3zxT4zbe76n210URp2vjRiavdg+f5BQOlmS6P8L82+3IO2rBrLlOZ/0A5E9gs89tq
         bkH59QxdZ/S7aIiItq8Ttlhe0mr0Y44tOg1i21M1O7lNxvrD1ooS535eNx8h6bFBP9JZ
         tGADUqG6eHnKMDlwmBv5sE9jI1JVrA9/GEc0o0/7F2QFhtyhsnMXzdihLyJHOo8s5jhD
         SozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DAfbd4/RRWL6Qg8nWQlB8aofBmC42OXO55jySoDEt4I=;
        b=STZEx7FiZ1v2H/ouMNtaWKL8dicCFwmU/9xpzKDzI0BvJbJi7QGVZruiOAuVpUsVes
         3vpBbWZiCjgjM71hkm/JnOzspdZaXMkNljtPRQ7W2egRWiWoRRPcCJRDa3k81RKs71lo
         h9BOdQbaO7VlHdSod6Ym2F1fcwNUS+tXMZTiCkpPV6n3Pn5k8VkLtXxuWnogJfGB2wmM
         JlZRr2gpS++J0Ku+2H2N4bSKZ7aApVT4ufWo+to0Z67T5D35Lur8Z4O4K6+quOvsYdeZ
         /iHy18iGWKdeN+2L89oR8gRzJCefbPGTyvpJDtkhc0iPQgfsvOzt45+0rjDbc6zSiyD+
         gLjA==
X-Gm-Message-State: AODbwcA8pQjbJ8ByhFLn5DH3Gc77EPX4Zm7YoZo9cIVnD2TMlEv/IOVl
        axX/cPrfA8I6/g==
X-Received: by 10.233.239.65 with SMTP id d62mr8449017qkg.119.1494920171814;
        Tue, 16 May 2017 00:36:11 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id i51sm10374103qte.28.2017.05.16.00.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 00:36:11 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 2/8] t7061: status --ignored should search untracked dirs
Date:   Tue, 16 May 2017 03:34:17 -0400
Message-Id: <20170516073423.25762-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per eb8c5b87, `status --ignored` by design does not list ignored files
if they are in a directory which contains only ignored and untracked
files (which is itself considered to be untracked) without `-uall`. This
does not make sense for `--ignored`, which claims to "Show ignored files
as well."

Thus we revisit eb8c5b87 and decide that for such directories, `status
--ignored` will list the directory as untracked *and* list all ignored
files within said directory even without `-uall`.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7061-wtstatus-ignore.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index cdc0747bf..15e7592b6 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -9,9 +9,10 @@ cat >expected <<\EOF
 ?? actual
 ?? expected
 ?? untracked/
+!! untracked/ignored
 EOF
 
-test_expect_success 'status untracked directory with --ignored' '
+test_expect_failure 'status untracked directory with --ignored' '
 	echo "ignored" >.gitignore &&
 	mkdir untracked &&
 	: >untracked/ignored &&
@@ -20,7 +21,7 @@ test_expect_success 'status untracked directory with --ignored' '
 	test_cmp expected actual
 '
 
-test_expect_success 'same with gitignore starting with BOM' '
+test_expect_failure 'same with gitignore starting with BOM' '
 	printf "\357\273\277ignored\n" >.gitignore &&
 	mkdir -p untracked &&
 	: >untracked/ignored &&
-- 
2.12.2

