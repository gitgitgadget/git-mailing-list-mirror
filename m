Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9203C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 22:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CD0613C7
	for <git@archiver.kernel.org>; Tue,  4 May 2021 22:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhEDWfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 18:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhEDWfx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 18:35:53 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B2C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 15:34:58 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t1-20020a0ca6810000b029019e892416e6so320094qva.9
        for <git@vger.kernel.org>; Tue, 04 May 2021 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PubjTUVXRZnGxU7s6/6nrW8qtVs6pXdsoL6LevahiFs=;
        b=IlurMSyB95jbJKZExIyfriJZybykUAP9s83yeONpZVBp2VyY5f0AWjJGrYVvYwcHyl
         ufiexAO6LzOFLHSflTjcL8B7KW9UXCzouSzBeHdVNDZcLhWQ/gXkpRQWcnLDP4jwP+6q
         NXtbt7pgaMswC2nXIOssFxu+5sEM2qKLx+DmVWp/GzNcfKZCecQ3vsaiHCjxJZ7YAvZW
         lxeUM+i/LzEI1jPWrc3YJJAQ21MrZZPpBFZHuACts2TDHGo/jBOE1KVyM842mH8RUAdx
         yLVSKqxn9zdi9l9Ow2VIH2XgW3cGPVaWYn9r6yNxAN0tLHDvx4abEbVC6e2zUEZYxY8x
         Xnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PubjTUVXRZnGxU7s6/6nrW8qtVs6pXdsoL6LevahiFs=;
        b=LidysxROIZxDFsiZjFj6DzXypqeWsYYBZjqvl5mtNlvs2F8sx0bwYY05zJd8lL1u+B
         41KZH8FaywPFizFR2hxJ/bR5bp4NZWWwt8vDsarqxAthlqJIgappqEtjFhbUlm8TVAg5
         go82fL85V6yxgdINiARk08RHhTeEF8te8gVvXppr+yE4WRFAStFxU/Ebl1C+Vs0MCkgB
         YfKJWZiFad+WrOym7myHrKT0hcH9gdyKHUXiuhxLhAh0/arymfJ3yROSZ9IA/Tc30D/Z
         ggWZi6qVBHVp2uX3BULq6OIJO2yxs8lw+43Wc7krRCmXisO7r1StnmXErF7GxNlqw1gB
         gYwg==
X-Gm-Message-State: AOAM532iPTJazvhPjHMFWFIqRRNZLqFdoONK3tPsurJDrQjKW5vn1cPA
        yK0H1tSZA6bXdsoxm4yTgFcoK5q3fMfO1JxOed2Zg2HnxvcsztAQLOx5325BGJveTXuqXxBQ+1q
        riZ4zUbn1Qvr8jnI4rO19F4zxlRFaWeD8nILGfZL9Noeo3jJjZ26VfN29KVujLThWRUixvuZQch
        mn
X-Google-Smtp-Source: ABdhPJwa0YjoP3hA7jOQsqMbzQ+NAO1KHx9TyIn6pAm5vGllvAul4/KNlAk4N5Eh5eeV0qBcLa67jMvAWnwRTMb7ktYO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:4e2f:: with SMTP id
 dm15mr11731544qvb.15.1620167697247; Tue, 04 May 2021 15:34:57 -0700 (PDT)
Date:   Tue,  4 May 2021 15:34:55 -0700
Message-Id: <20210504223455.92823-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH] t5601: mark protocol v2-only test
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, lilinchao@oschina.cn,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A HTTP-clone test introduced in 4fe788b1b0 ("builtin/clone.c: add
--reject-shallow option", 2021-04-01) only works in protocol v2, but is
not marked as such.

The aforementioned patch implements --reject-shallow for a variety of
situations, but usage of a protocol that requires a remote helper is not
one of them. (Such an implementation would require extending the remote
helper protocol to support the passing of a "reject shallow" option, and
then teaching it to both protocol-speaking ends.)

For now, to make it pass when GIT_TEST_PROTOCOL_VERSION=0 is passed, add
"-c protocol.version=2". A more complete solution would be either to
augment the remote helper protocol to support this feature or to return
a fatal error when using --reject-shallow with a protocol that uses a
remote helper.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I think the remote helper solution can be done by adding an "option"
(something that can be passed using the "option" command). We have
options for things like "from-promisor", for example. I haven't looked
into this in detail, though.
---
 t/t5601-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 329ae599fd..c0688467e7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -762,7 +762,7 @@ test_expect_success 'partial clone using HTTP' '
 test_expect_success 'reject cloning shallow repository using HTTP' '
 	test_when_finished "rm -rf repo" &&
 	git clone --bare --no-local --depth=1 src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git repo 2>err &&
+	test_must_fail git -c protocol.version=2 clone --reject-shallow $HTTPD_URL/smart/repo.git repo 2>err &&
 	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
 
 	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
-- 
2.31.1.527.g47e6f16901-goog

