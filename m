Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD981F453
	for <e@80x24.org>; Thu, 20 Sep 2018 16:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeITWV6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 18:21:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46787 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeITWV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 18:21:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so8981589ljj.13
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dg0zeH9D0TDrA09QE0eziMkyYZJAbCLWMxqnY5rIqww=;
        b=CxG49WKgLnVpNvwBMrEX+L8xZ+4Nf1s3YSNicV12wtLgTpDk/PA54n9OnD2hL5uUb+
         SF775vZgRkpl4NvXca+OWEmrO3WoPVpLks+DveI7jlmsA/k9oETDJYtdaHVtnizajUlK
         GRbztnFGZxFw9rk+Omt7B1Q/013JSqNom3fBGFCpGMjw5qSY77b6pGOAruFAMSuApTnp
         CgjTj6Jt2nmPoy4mhVK2385hanaNfNYu46RDEX9iQchWUgqOBFc2iuj0b6c4HZSDEbhj
         PdbFrb2d0401a56FU/nxs9sdgKtFoq0POL/r5jsWTXqq77TmMWLyFIKmqyoAXxxny6z0
         ZqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dg0zeH9D0TDrA09QE0eziMkyYZJAbCLWMxqnY5rIqww=;
        b=Xv/Ox8+23o0F/AsGCao3r6CsS2nMnSb5Zfnw+jHM0VijhTx4fzHBSr/b3Bf2bNGaSS
         Odqu6LFQC4IFvvJC+/qv0WyojZ+PYR9rV8NObZbEcCTG1DEVDnfS4M2ZJh1NAgflfdZZ
         +tUZNzENHIVL59fivXwVAY2I5rM0fP8uakHyNCDb11qdVskT+FctnCZ7FqaT4aIc7bBo
         8vbr0gFRolXRg7MuHXeDiYLzZDG2rxBYCLrE+ep9tYesIjVQYBbmEbciP4vQUU6eErrX
         +4zR0K1cIY3iyAJhm3QtvTJtX3KgFVA6Fb++pQr8OdIwyzgPT7vsag8UVRWVKEDfKFri
         O7Mw==
X-Gm-Message-State: APzg51BPTLkw4Y24zOuXEOBHRLY0vIZ2w9yOwI4G03zIyi+IjDF8Z8RY
        +EIZ90JXRlTCisWoYSkxe8vpvp/6
X-Google-Smtp-Source: ANB0VdYBuLY1yN9bTAWvjOsQzZHxVfd4915CywfYRUwCb0BwwgVdGvgnU8HyBOiQukAreYDvi/+47A==
X-Received: by 2002:a2e:9243:: with SMTP id v3-v6mr23880572ljg.92.1537461456667;
        Thu, 20 Sep 2018 09:37:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r4-v6sm4349447ljd.70.2018.09.20.09.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:37:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] completion: support "git fetch --multiple"
Date:   Thu, 20 Sep 2018 18:37:33 +0200
Message-Id: <20180920163733.20046-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --multiple is given, the remaining arguments are remote names,
not one remote followed by zero or more refspec. Detect this case,
disable refspec completion, and pretend no remote is seen in order to
complete multiple of them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d63d2dffd4..a66bec966b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -943,6 +943,7 @@ __git_complete_remote_or_refspec ()
 			*) ;;
 			esac
 			;;
+		--multiple) no_complete_refspec=1; break ;;
 		-*) ;;
 		*) remote="$i"; break ;;
 		esac
-- 
2.19.0.rc0.337.ge906d732e7

