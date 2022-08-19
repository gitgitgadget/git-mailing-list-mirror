Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB941C32792
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353141AbiHSQdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352875AbiHSQaU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816CB11A2E8
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u15so958505ejt.6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2Qij/kLkdgP71zXzkDz6G8WKKnSGh2IGjvcbU0pn7vU=;
        b=pQkzH/AizFqRh2dN0Fr8o999BZt6SIXYNVQxjSc2uvfI+gKTmumbfuBpFoiSQPxpr8
         wDA2VUdnT+6hPkNFq9mC3JsH1qhAhN5WrVKvkXVeRaPQ5ZauRSwyAb7w+yadwFH9XZiD
         Y07g4ousYo7/ONCFlC4RdyBCQexn4hMn97rnTUTy5fgqJLqOM881ssufGf/iGr8pMSRm
         bYngqG5VokwJbF6cW3BFOOSdTTs4w1K4z5EAKsAgIu41mte8nfqdQ9xaV3zRkj4MiuIW
         qWfcHB6ms/qIwvUjWBuQgmrqQVkU3ySB5YSkoWTjKr9ZNHw3C8OIxEk3b6PuGA9oRhUG
         S9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2Qij/kLkdgP71zXzkDz6G8WKKnSGh2IGjvcbU0pn7vU=;
        b=UMJFGmQK/7o1i1S3Ad4lzsYFse2bu4BBWpqY0N1XNJy3Lr16QgeoLUZovMnUSma9w4
         5d9prIiXFj9CAL+vq4Lly2FepqFcvyMAP5U4QI4/R4aj/NLED2OC+deq7nDDMJOJDvEk
         0RMkEO+WEETZDrH6Y5KAdJOvpLrC23U5oKNWb6rcoETY9oc32Ms4GIhH2OTgHQxPD1eJ
         oY3RC0Gq79XhSj4vqyJndhJHPXrycFqG2mFJg+WHn9apr8mmZGjLazSS34JRg4hQdrY+
         c9K5ptPo6XQkZv0Z72AVAnlWfg4rIlKu1NJ4N+P0ScF6ctSdlUXUfkEtoCKXYovZMr8y
         qLiw==
X-Gm-Message-State: ACgBeo3fpu6w50yEZ7nr0NGPrV60dLJHy4yjQ8pp/uAkq6qO8JmXIeKr
        aWYGnEtdyKAaZY/4bKQgmCQXZCWySKw=
X-Google-Smtp-Source: AA6agR5T6EwIQNirvu+kEW0qZzmcY9a44UJflQxZcsOt8TSsgKYgsArz6rAPhGqaazvIyNJcleKj4A==
X-Received: by 2002:a17:907:7241:b0:734:b282:184b with SMTP id ds1-20020a170907724100b00734b282184bmr5311746ejc.445.1660925081472;
        Fri, 19 Aug 2022 09:04:41 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id kw24-20020a170907771800b0073c10031dc9sm706768ejc.80.2022.08.19.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 05/20] api-parse-options.txt: fix description of OPT_CMDMODE
Date:   Fri, 19 Aug 2022 18:03:56 +0200
Message-Id: <20220819160411.1791200-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of the 'OPT_CMDMODE' macro states that "enum_val is
set to int_var when ...", but it's the other way around, 'int_var' is
set to 'enum_val'.  Fix this.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/api-parse-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index acfd5dc1d8..5a04f3daec 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -236,7 +236,7 @@ There are some macros to easily define options:
 `OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
 	Define an "operation mode" option, only one of which in the same
 	group of "operating mode" options that share the same `int_var`
-	can be given by the user. `enum_val` is set to `int_var` when the
+	can be given by the user. `int_var` is set to `enum_val` when the
 	option is used, but an error is reported if other "operating mode"
 	option has already set its value to the same `int_var`.
 
-- 
2.37.2.817.g36f84ce71d

