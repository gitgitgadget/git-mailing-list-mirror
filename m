Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D4F1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbdFHXlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:19 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35270 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFHXlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:17 -0400
Received: by mail-pg0-f52.google.com with SMTP id k71so20705696pgd.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xntMiHl4JoHiNDXW150A1ElVwVypwZduOzAxYkOAZHs=;
        b=HfVHRpyKK4DW0CHg/jaGI8i4X1uLo6H/YFuzMgB7tn2kXQB+rjhcZU6lG/7UMpQRwx
         vM1++bUrXyDkkaMNFDrwH/WbtYAp3jpAZPxMpsyOaef1uf8+x7j3PFkiJVBU1PRrtczV
         ttJ2263d1g1C7Isl6KWx1s9IoiH9VsEJsaB8yDXWq8FFRiKjRNHw5jy37qr+dVbmnX2i
         SMD+fA+mdCHSGKjzPGX6sIrwoerzRQV9+qeoQgIxzM4tXZr+RUQYCD01pdHnu/H/kPTE
         2SAV93JDwa72U2b5z/GWiNrblYPQ5mtnpK3qh/bdDdr/AbdjVsxhubsUFAIwCCjW7/KS
         cNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xntMiHl4JoHiNDXW150A1ElVwVypwZduOzAxYkOAZHs=;
        b=tjKyUhfu2zmlLs38rZMNtCP+BXom+153gmTi7J6S+agalGKTBMA6Hu7SNSjIz+zZZv
         /gy/Utvf3vyzcRkGIi8IaC0WV8stetImkAjFoAjcN6x8QEIzLE8FeJ130ONfQszgjF2E
         saM2YsfN/F0fv0mXDWyodfEIv8ODE09hpJlrL8YqeeR9aculvA+TDEiISt7bH8bpTwCV
         7uuyRvM23BMyNpk41fOakBQR9GrSIVimuXC2IPY21F7g9pzP/W9UcOayAnDyzJ7aQyTy
         2M/bgMHi3A0JfzFDgT5N0Jxf8DLgNtiONzMcmqvlcoJ8/e715iX+qTPZeYuhXE5MYvdS
         ax6w==
X-Gm-Message-State: AODbwcAmCICqKT3np2TADTnU7cyZa+VlHWMEsp611m4OaJVhaq0kvJ4k
        nW7gAQm7XATaK3vgEquq9Q==
X-Received: by 10.99.170.1 with SMTP id e1mr39769728pgf.128.1496965275772;
        Thu, 08 Jun 2017 16:41:15 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:14 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 02/32] config: remove git_config_iter
Date:   Thu,  8 Jun 2017 16:40:30 -0700
Message-Id: <20170608234100.188529-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since there is no implementation of the function 'git_config_iter' lets
stop exporting it and remove the prototype from config.h.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.h b/config.h
index f7f8b66c5..c70599bd5 100644
--- a/config.h
+++ b/config.h
@@ -165,7 +165,6 @@ extern int git_configset_get_pathname(struct config_set *cs, const char *key, co
 extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
 extern void git_config_clear(void);
-extern void git_config_iter(config_fn_t fn, void *data);
 extern int git_config_get_string_const(const char *key, const char **dest);
 extern int git_config_get_string(const char *key, char **dest);
 extern int git_config_get_int(const char *key, int *dest);
-- 
2.13.1.508.gb3defc5cc-goog

