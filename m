Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD491F404
	for <e@80x24.org>; Wed,  7 Mar 2018 01:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeCGBFk (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 20:05:40 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41946 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933236AbeCGBFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 20:05:38 -0500
Received: by mail-pf0-f194.google.com with SMTP id f80so267215pfa.8
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 17:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wS18nULXuaSUYM6X1lxgluOmuv7M0NXiSA8a2M1NOU=;
        b=dhQpC4gDMp5iifxjU4CgFLGQfsaImlOchx8ZWHmwCgE4fGbSq+ia3dhXHcCH71jR8H
         MJ/5aZi1kgt7QfngB5l46Kh4qXHo1l/mf7TXpHrGNHIOoUgDRU538k8ikofefhLIzPya
         SzYrpXHHKkb25uI0u6/U2tMxLwNZrexEIxEHJdmNffF+JucK1eRHCgYuwMK6tjuM51a/
         bwPpCIFiIVjQW6k+xAb4tR/y/EFPrf7rL45Vcm2gy28NLvoXabdcEsQaNiSZDzfQQ5ST
         E4OJU7LwyQ5bFSQV3I+xKpWRa9biUhamzlF4P83Q60q/0dhSA4Zxrpo5Bi+QTTRs2MTC
         XSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wS18nULXuaSUYM6X1lxgluOmuv7M0NXiSA8a2M1NOU=;
        b=OvNYqn6clRyTTLZy3EwPIKPsGK2lWUS5TANsw+NfTo37ry0aoUUfI0mNsAZldtZuoG
         ez2pQ4j1x4xMR56X/0ZTu2CuSlVQjJ9kfL2tBiwkmY2SE631FMBbiBu6yfcTMzdisgx+
         6teYsyvyDoY6aQ3CZDmcfm1NqdZIvlieQ+cyb902FJH3FJIC75fZQsZuS7tkpQ8I+8H3
         FfHGcjuZRpBv3pENzU/kVDxl5iDR02pqjT28b1SfpZuhwORTYxL8B+wGV95Ci3Edya1A
         mIpIR7NTzZsoB5bQlmFldqleBTj3Dx687vAkYAm5xLZElserPVuchBAb/lsCA3Rf6Pfb
         NCQw==
X-Gm-Message-State: APf1xPD7s700sOFQCSdI/pMCZ8RVCbtgoR86qrxK8eVrz18q/nfxFp0G
        6QKXUXLPebJ3eZ4bYhWQKFE=
X-Google-Smtp-Source: AG47ELv97pQHRDu/Y60hoJ4DeLS3/KLvFZh4Ztby4hF5ZM7TWB/28d5J8ttnM4lx6gvSAYQJvApI7A==
X-Received: by 10.101.75.199 with SMTP id p7mr17160152pgr.0.1520384738034;
        Tue, 06 Mar 2018 17:05:38 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p10sm27664133pgd.28.2018.03.06.17.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 17:05:37 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        phillip.wood@talktalk.net
Subject: [PATCH v2 3/4] completion: complete --{reuse,reedit}-message= for all notes subcmds
Date:   Wed,  7 Mar 2018 08:05:03 +0700
Message-Id: <20180307010504.9289-4-pclouds@gmail.com>
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

The new subcommand that takes these options is 'git notes edit'. Just
accept the options from subcommands since we handle them the same way
in builtin/notes.c anyway. If a user does

    git prune --reuse-message=...

just let the command catches that error when it's executed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 37bf4a64d3..dc3ec43b65 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1832,8 +1832,7 @@ _git_notes ()
 			;;
 		esac
 		;;
-	add,--reuse-message=*|append,--reuse-message=*|\
-	add,--reedit-message=*|append,--reedit-message=*)
+	*,--reuse-message=*|*,--reedit-message=*)
 		__git_complete_refs --cur="${cur#*=}"
 		;;
 	*,--*)
-- 
2.16.2.785.g429c04a1b9

