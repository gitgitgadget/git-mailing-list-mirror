Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2112C1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeCXUiX (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44290 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbeCXUiM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id g203-v6so22885727lfg.11
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93FT7ziSVt86H2q29FXyVfIAlIs679WWsm+/n7Ms89E=;
        b=rpUZM6fzGDt4kJHHaMj/sc+lRoB2El3Bs9vL0ZNvrl6FyqTIJ3IqTVhRthtJ4rd12T
         Z2xLnmTUQf92cYWLGBsNImgvR0TEhI9Xfc7xMTrDNKBvevWCW6defiMfVCG1/SKNfyvW
         gB8nvocwknuC+xFrbBXe4o1CDUYefS+Y5nvvlVg44HeZHK3qfEvMLVHELSqW8h8sBh/n
         RiOwz2UNSuebB8zMBv1ETvVDQYtq9enQIYKoFdIIUJJTiNgX2ysTulqO07L18b+rxNI2
         NfuboefRqDcKMlH76XSTK5e5n6mw3TCSAHG1IEZE3ZJ3zM3jU5y6kVYWD2vf25OFjti1
         z1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93FT7ziSVt86H2q29FXyVfIAlIs679WWsm+/n7Ms89E=;
        b=pB1O2Ur5ELquI/NwZtPvsjsC3MNjlgH+5NN2r/yFkkmaAADyAX13wGBT3VHFv3N3sk
         JoynPGH6RC32Cjd64YGIHM7m6vcu0DO9lMGZQ4B+pghPBCh7vdveee7X9LQoBEfjrOKZ
         Dj+WITHfN264HSjIqFEdfMSso6e06p1Zg7vQHKak+/kcCuQd8H1VxnlyodXbWBEHvBvO
         Z/GVEqyflV94j4IDmYj3wg9q86xhTCxeUvC2C9r1Umnvonk9ToRLgig/v+uQgbHZ17fz
         MtC/5Fr4kfcGjv2l/tSPYO9KWmCQJno9qnK2U3ak7BRRUD/XBgIIkjk/6+05Mio2j+ma
         fqnw==
X-Gm-Message-State: AElRT7E0V56qD1xS7bfEovZFGyDPZSk/4nKVAmZOcVUYYuh/TtpfXFll
        nVwwUvY6Y0MPQFOkQ64NeBI5pQ==
X-Google-Smtp-Source: AG47ELvUTqaeA+jnTrQ2U/UizE3kmCx6LQHdYHOTFGu/4X9/A/+N6j0bXjgswFxn3BlikrUUqHOVCw==
X-Received: by 2002:a19:3bc6:: with SMTP id d67-v6mr23524806lfl.100.1521923890906;
        Sat, 24 Mar 2018 13:38:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/8] completion: delete option-only completion commands
Date:   Sat, 24 Mar 2018 21:35:23 +0100
Message-Id: <20180324203525.24159-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324203525.24159-1-pclouds@gmail.com>
References: <20180321193039.19779-1-pclouds@gmail.com>
 <20180324203525.24159-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new function __git_complete_common can take over this job with
less code to maintain.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a90b0e8db4..0ee0ad7ac3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1501,16 +1501,6 @@ _git_fsck ()
 	esac
 }
 
-_git_gc ()
-{
-	case "$cur" in
-	--*)
-		__gitcomp_builtin gc
-		return
-		;;
-	esac
-}
-
 _git_gitk ()
 {
 	_gitk
@@ -1810,11 +1800,6 @@ _git_mv ()
 	fi
 }
 
-_git_name_rev ()
-{
-	__gitcomp_builtin name-rev
-}
-
 _git_notes ()
 {
 	local subcommands='add append copy edit get-ref list merge prune remove show'
-- 
2.17.0.rc0.348.gd5a49e0b6f

