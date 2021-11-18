Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB87BC433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3AE61251
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbhKRA4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhKRA4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:56:41 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82F5C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:53:42 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c21-20020a62e815000000b004a29ebf0aa7so2596358pfi.2
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AU5Bk/32zjduelByQqyJLtOSDrQw4PqLJqEko5EiDOs=;
        b=tYcxQ/XB+70VJBQpCCODxNykzWCrOwA5KqiM50rb9wR7tkRGi/znbG70SUxf1xFkcH
         GQCuf8Xtm1GwN75990U4K+iJDbvzlqJrahxorJC6tnhxARbQTF/GdjcBcGk186FLCn+/
         UrVFNmirS5nU7fqJc0HAKczCEmDOADVnFdLQDy7FhVsfHIM8kyETjGqEdLJJB9wvLdHT
         N9AbZm8ng0G+0C56tJGbODN67HJldavsMZpk8JrkosFjwYSGxqaSBYziXupq9LipPA7W
         qF+bkwh/xHt2PciTFWsthUafDcflRQnEfmsB+43MWfhnQ4dNYQGucHOoEhdBlosxiusM
         XWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AU5Bk/32zjduelByQqyJLtOSDrQw4PqLJqEko5EiDOs=;
        b=JntcYoP5NB7kJECVc3ef5hX/MrqGPOlFEHZfR7N894pUZ5KKP8trZuBboYTODD3aH+
         U2SAj/IoXYv2PN1NvX+WmarekaZJ2x2NHd2ogdfl338V0azb42yRyS9Bi4u7aWYa8L1E
         QGN00UhTlV/B710NMYBsOwx16roCDOwU8NpGC06K2oCBLihhl0WZxob1q8iNDG4aMGZl
         f6jVcNhF2XaP9RrSfJvJVFXntPPR6EDU+dnHwxtUZz8P8QliDfrYXiiK4md1wtR0bPyc
         ByJgK4ShUFe7EeB82y0TJc6rl6qM2kNb0lswF2Pks5Qf60bFWYloCNiw8iqsPOdND3af
         oNEQ==
X-Gm-Message-State: AOAM530Pe+igorzc91fQnQbAlnVIgbF1ZDg6SlxV46Z6dcUmyRvF5XNL
        vU8rb0ubhMIx/YDpvG3rvQGwpJmS6Iq9+/IuwXnu3yD7tMaLzjs9mBdiQ6Xfv6bkb2hwTZepeVM
        KY/XH2Pqa6q6SYzBX0UrnB9UgkWCd3mO3ionSIl0uJcDZwdEn+EELxnNmUl0qmPw=
X-Google-Smtp-Source: ABdhPJyGgzm01ORn58Fw4ibgj4NbxVIiEaaoi+ZB6tIEeJt80X3PWdJzfxnINh7ox7o9undjK8BPQrrgCmnzzg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:5882:: with SMTP id
 d2mr742333pgu.120.1637196822109; Wed, 17 Nov 2021 16:53:42 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:53:21 -0800
In-Reply-To: <20211118005325.64971-1-chooglen@google.com>
Message-Id: <20211118005325.64971-2-chooglen@google.com>
Mime-Version: 1.0
References: <id:20211028183101.41013-1-chooglen@google.com> <20211118005325.64971-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v5 1/5] t5516: add test case for pushing remote refspecs
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git push remote-name" (that is, with no refspec given on the command
line) should push the refspecs in remote.remote-name.push. There is no
test case that checks this behavior in detached HEAD, so add one.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5516-fetch-push.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8212ca56dc..7831a38dde 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -541,6 +541,15 @@ do
 
 done
 
+test_expect_success "push to remote with no explicit refspec and config remote.*.push = src:dest" '
+	mk_test testrepo heads/main &&
+	git checkout $the_first_commit &&
+	test_config remote.there.url testrepo &&
+	test_config remote.there.push refs/heads/main:refs/heads/main &&
+	git push there &&
+	check_push_result testrepo $the_commit heads/main
+'
+
 test_expect_success 'push with remote.pushdefault' '
 	mk_test up_repo heads/main &&
 	mk_test down_repo heads/main &&
-- 
2.33.GIT

