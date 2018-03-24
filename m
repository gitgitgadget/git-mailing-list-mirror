Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B8E1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeCXUiQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33295 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeCXUiO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:14 -0400
Received: by mail-lf0-f68.google.com with SMTP id x205-v6so22936806lfa.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P458p3EmfMXgMbqDvCECj8k/vHY5TCVEFGJ/dYUi7tg=;
        b=QUVC/Rg6Cuk7ykSu96Dvk4kTe928NAKQb8AotoFDcDFAsIT+Vfix9ETYYg/f1uSROh
         3YljVscYRTpagl2jKGhvK1s0FU3HUigu0BjlE3g3f6U0g5yAm9r4vTsF/1tAMG/NlPid
         zeB8FTaFcWa/S7FPXGZBBEB9iy5lFAh82Bip+QraiOw1m4RH5ymhCfuPJ3wMHGGD0aUr
         tZO290CJZXte2M+PcIOryLOY7Ufp0NF8Xo79j1ul+G5+bQDRPuY8G6mHRsV9HTtd6dAY
         F43Jx/n/4/7ULNDv+u2TuBChfSLvaGbAlr6xXhDi9YNj+OSt/kCyh8wnVCQC3uwddFeD
         QxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P458p3EmfMXgMbqDvCECj8k/vHY5TCVEFGJ/dYUi7tg=;
        b=Z9l8oA03LQoruFaLpzaIhwD7OrqaKH5JXXZ+disf8QwaZoyVI7IcCREUoSL/w/oNV9
         h6Ood5JBrrt5ginXETCYruNWU9NkHOzTnuoaOma9ATlBDnSWkrfZA6oL3bPtC0hv1YSR
         /OImt88w30lBN1549e0UYtAda0t1lagkYFKi5aTljjE4xZKhNDABDeTTeARj6t5uyqSg
         Vp7fxthLRC8hKqbimDFNbaXJPuJsfp/fhRJLwkZGd1zaC1qbHMBv30WvD1WLlrfu2YIa
         3qa/ZD7NkLZa2xsP35XchgI6an0OPvVjsesXYhu+LCDczIGrnq4F1esEKa3V31kj6F+b
         0IwQ==
X-Gm-Message-State: AElRT7F66QCpGVePBShE1vSerF/0b4tJM4KKL41FcBJJrccUMVTE/Dp8
        qDHxIklsnGQXCl8X7dJylCQ=
X-Google-Smtp-Source: AG47ELvmWkLIwp/jG4wcr0Vxc4112yx6nTqNgGA2lEYqGF+fBYnnyaUVFeXohjwSZI9EJJrSCf0SpQ==
X-Received: by 2002:a19:9904:: with SMTP id b4-v6mr21944238lfe.51.1521923893052;
        Sat, 24 Mar 2018 13:38:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/8] completion: use __gitcomp_builtin in _git_cherry
Date:   Sat, 24 Mar 2018 21:35:25 +0100
Message-Id: <20180324203525.24159-9-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2f16264413..0fe91d016f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1282,6 +1282,12 @@ _git_checkout ()
 
 _git_cherry ()
 {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin cherry
+		return
+	esac
+
 	__git_complete_refs
 }
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

