Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31F31FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbdFMVDe (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:03:34 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34937 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbdFMVDa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:03:30 -0400
Received: by mail-pf0-f174.google.com with SMTP id l89so73438155pfi.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JAYT1Ik6308rojk564r+ALr0yTxpyLMJtc+NeWFrISI=;
        b=X5AcnPEfR6Tz86kpSsCHnhpn5TXZsUQdO3LTfnDR5Ml/m0BMlOFuNt1DUFl3MWL1lp
         XTfxzj5URqkIDpJN6moCRUv9Kb+SOZV/nWNxExRIlDdKAmBnkSux9OAt9zBmSznZT7+U
         HPW5BnkMYAmzqWjpvFQXPZJfSOR/Gd5CYU0B0QXieiglIbj5ToaFZR6D1TBAw+b11szt
         xgM8QGTCoX9zxWEUItdRPgj/iCh8oumhBmWX24INp6OZhk5pXEwF9q4At+8YU9DhuEdw
         x9j0WMZ9F2Qfv+QB/l3qEmXBNKRsAxXoUwNBnqYRwWxMXGHcl0hwEXE8fRRczF4/O+4X
         G+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JAYT1Ik6308rojk564r+ALr0yTxpyLMJtc+NeWFrISI=;
        b=BffbB7Ye4cEYY+vw73maJBtA2keecH8nXAQkNGgnvYzB4VIboBr+UeQS7pf+/VS5XG
         SLV001WVAnoySoAQEuPTrSBueOAJagK3QNM5P0pXz28KjgDw+JrqBR+VlUlYRmXVQIck
         PZA/wEQy2Ss2gIjqt/WvM9vklLfLVSES8V/SRN4BI86iq+QhMhKeN6dsufMjMtYMFR2V
         vGV6E248kDnJnLw+1eEWoI0vOZq1jfWUyR6BCq8xsyr760/kFUI5O72hN/WElhH6h+PX
         Xgl/YVjiNcXWhdmV8eClHin9Mq6gw2JwzaDuFcvF5WaHRqTkw4bI6WhU+PxrtBYeWQyQ
         WrOw==
X-Gm-Message-State: AKS2vOwivVpqQZ0QSpCu8ruzYegtlRJodRr4812qI34EiKcJsR9jkZfi
        OOqNTseM+p7JVy6GsBzT6Q==
X-Received: by 10.98.40.132 with SMTP id o126mr1292088pfo.238.1497387808740;
        Tue, 13 Jun 2017 14:03:28 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b65sm29154065pfm.29.2017.06.13.14.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:03:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 2/6] config: remove git_config_iter
Date:   Tue, 13 Jun 2017 14:03:17 -0700
Message-Id: <20170613210321.152978-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170613210321.152978-1-bmwill@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
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
2.13.1.518.g3df882009-goog

