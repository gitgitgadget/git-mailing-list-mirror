Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3A5C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F9F2419B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZefcAVOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440899AbgJUWD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395367AbgJUWD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:03:58 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1124C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 15:03:58 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y8so2657981qki.12
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=xk2nhrs3LymVqumxRigcD8thF9rqU9CjTxPqYBWSJK4=;
        b=ZefcAVOvzunfGHBFGuxEolDIwKjYdXuVuhVl5X0k/+OOG9a8xWdv6FD0Eaiz5YAHLG
         jzlIJbG6XCO+/FrHfGZDD1h/6RBKjGo4MK/JJw0fhrDTXmvKr6vDTW3c+KugQ1NmOBSa
         ArY5fqyRVlBvriF7YphzYLL1WPPLGXRjmkiQ3PxUj93rxqSVMVf0F+aFchENe7BsxLyv
         rTE9ZLSRN6eU8gYVwVvz4QfNfd0ECZnnCIQGe70XF5QPoxQlTX4+LdSpkpCmv4AcGxKj
         ytQfYg2ZSQuQPWgamwFIPyJcAbLJZ6xH2vB5EXKnEVhxjVhWrfSX1SIwjpngaYZlRNa0
         RTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=xk2nhrs3LymVqumxRigcD8thF9rqU9CjTxPqYBWSJK4=;
        b=hBAx4s1k6zeyr2W6X4lMluUAJlGqHKPMVuwpj+RKdtoSCs/CN5aH/AnBW/tY/Cerhr
         YGpLi10BSquHL2To0g/q0gdmdQHb6oExWzxBwU0tr9PNn9Mz7QCRc052bULgoDzwczIC
         0l+MWcsCS8eOry1UsziHPJpDHHPxqRdO2O5azpdnITC5ColGT87xyrLqy6ARXcDAskea
         OY+r11rnOUuhBfP5hzUuQ++FtktrbQh7TXj9i6xIVoG9b31fsAGCPXsJbnRo4wjLF6Jn
         Fbv4Yb1vCRYh+rDrSdbKoXQwohOA+Rrb22m7n+21H2x00Bmp/9HzEDZz6NBrT4EBoxSf
         v1Vg==
X-Gm-Message-State: AOAM5319bfwz7fGyS38TAxl+nOcqLxKEThwDhfFwaPd649w3WuDbpbWT
        QUCEAu2ZrvZe1X4HY/ri7WCzYmDh4cy/Mnwhx/LhPcMpraZP0YWcK2YRZa4RMatMrZroKloGLze
        x8JWoT4zaL1ALSlb6X/MVa65gvMtPeCVm7LDQIEp5vK8ZVwSykwzr6JgTvl/LPAUJ7SOKYQy7HT
        eC
X-Google-Smtp-Source: ABdhPJzz+uU7q0NC0d8EI9WudwUX+xjKnCXbxypU8tM9m4hP2rSk8AO7qDhhJ+G7TxXZ1tRuQI3u6lNxCIsMcuZoqoco
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:48c6:: with SMTP id
 v6mr5032531qvx.11.1603317837120; Wed, 21 Oct 2020 15:03:57 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:03:53 -0700
Message-Id: <20201021220353.928067-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] sequencer: tolerate abbreviated stopped-sha file
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 0512eabd91 ("sequencer: stop abbreviating stopped-sha file",
2020-09-25), Git was taught both to write full object names to the
stopped-sha file and to require full object names when reading. However,
a user would experience a problem if they started an interactive rebase
using an old version of Git and then continued with a current version of
Git (for example, if the system version of Git was updated in the
meantime).

Teach Git to allow object names of any length when reading.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Not sure how big of a problem this will potentially be, but I noticed it
and wanted to mention it.
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 00acb12496..37847d4534 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2653,7 +2653,7 @@ static int read_populate_opts(struct replay_opts *opts)
 		}
 
 		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
-			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0) {
+			if (get_oid_committish(buf.buf, &opts->squash_onto) < 0) {
 				ret = error(_("unusable squash-onto"));
 				goto done_rebase_i;
 			}
-- 
2.29.0.rc1.297.gfa9743e501-goog

