Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3271F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424522AbeCBKCI (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:02:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56289 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426114AbeCBKBx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:01:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id q83so2029986wme.5
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 02:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8QM5o98TX6YMqDWQtFOuUARXJ7xFYXub145/t8/gWo=;
        b=eBL0Jl5Wqf3dEgkuwoz97pdyLbNFmyGumgzis9k03x8h+yGYR2iwU3/Ft+Q7xCzJHK
         LpnEsi37lQBL5JR4l0W8C5nhpcw42MThTS/szZeDpD1Wy4mSWxV8dMdtni3oaakHo+Je
         IISvc8oNQd3Z9H0OWWdW08X/IiHe2iMC+7NTk/bBQJzTCRoL9ufb6DzEln3nmqJN1orQ
         Kjrku5K8+G3iCKHm+NHKaZkFyyzuV6ykQ1h6Sijhw2LdJVdcxSCybZ42SCJ2mjejeAm3
         S8rmeV82cuq7VLSaWGcKcp7sQhAPhJ5JQyxHGgS6zy7xXpEh+zK3F0BX0AnCqURw0D+o
         Z4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=J8QM5o98TX6YMqDWQtFOuUARXJ7xFYXub145/t8/gWo=;
        b=HAPYax/svt+gKqjIPYWbdg9Y11GuLO25MWMrng+JLpfSt97rs8+E8Tzpwye99MDUKJ
         7qYOgpbAP6mtutb2tPZLaBq4YVaYQFrvMx3d/ueuMBRN6UiJg40I0yLvDwScXIexM1I2
         CZ8A34y4e3cYM6pyILd33jKR4OS0f93ox+Asm9eMfqouSJHnQRBV1KRBRXTaxSuzmduD
         ZPSNp8ix+vAd33wVUNQZ9M0R1ZvtUUVRSciTVX8FNBIFWV5cSaiIo8koXnsL1G/aCvDX
         sBC/ibhd3E+yNodTL9I4TqC5sKKtqc8TGVtrn0vmKdyj+V/Gi9lvrKyGt/QC826byb3+
         DQEw==
X-Gm-Message-State: APf1xPCCjEEqddZFsIsD7NO0b4AbRqKAnAIUVUi/cNbhOip+BTu7rmil
        KI/XaOKo/QmwP1VZZNEEfnseI7dj
X-Google-Smtp-Source: AG47ELvkSEUfdlp/1eCRBkK7zVe5djQhKwtMhZ05uQvpW8VVomQnmjpO/pz0cv/aSNUqn9fO3Jqqiw==
X-Received: by 10.80.137.213 with SMTP id h21mr6754116edh.39.1519984911756;
        Fri, 02 Mar 2018 02:01:51 -0800 (PST)
Received: from birger-Dell-T1700.hials.no ([2001:700:1200:5104:f593:cb86:c151:ca05])
        by smtp.gmail.com with ESMTPSA id q19sm5947150edd.86.2018.03.02.02.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 02:01:50 -0800 (PST)
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
To:     git@vger.kernel.org
Cc:     Birger Skogeng Pedersen <birgersp@gmail.com>
Subject: [PATCH v2] git-gui: bind CTRL/CMD+numpad ENTER to do_commit
Date:   Fri,  2 Mar 2018 11:01:48 +0100
Message-Id: <20180302100148.23899-1-birgersp@gmail.com>
X-Mailer: git-send-email 2.16.2.270.gdc6133cf5
In-Reply-To: <CAGr--=JqXhwEtOrs0K3cscVa=LV75ejz=TYKtV7mgrd_96Jk6w@mail.gmail.com>
References: <CAGr--=JqXhwEtOrs0K3cscVa=LV75ejz=TYKtV7mgrd_96Jk6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CTRL/CMD+ENTER is bound to do_commit, but this did not apply for the
(numpad ENTER) key. To enable CTRL/CMD+ENTER and CTRL/CMD+(numpad ENTER)
to yield the same behaviour, CTRL/CMD+(numpad enter) has also been bound
to do_commit.

Signed-off-by: Birger Skogeng Pedersen <birgersp@gmail.com>
---
 git-gui/git-gui.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 91c00e648..6de74ce63 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3867,6 +3867,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
 bind .   <$M1B-Key-plus> {show_more_context;break}
 bind .   <$M1B-Key-KP_Add> {show_more_context;break}
 bind .   <$M1B-Key-Return> do_commit
+bind .   <$M1B-Key-KP_Enter> do_commit
 foreach i [list $ui_index $ui_workdir] {
 	bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
 	bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
-- 
2.16.2.270.gdc6133cf5

