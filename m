Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E240C433FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A5C610EA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhJ1Sdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1Sdi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41EC061767
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:11 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id hg3-20020a17090b300300b001a3fd07578aso3506193pjb.6
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/jW7Z4NQq8oD4q7raYAzyIvk3oVztHUbLVm4scQCQSE=;
        b=DzAbKNSU1i3M51qXOrhDTUNBZEQnZOcsYB1CvigpY7XWwKYnLU4l0Yj/xPTwqaJE0s
         BldJNH36GUcQjlea4AOCBnqe4iOef8IqXHh8RwIWp90TLb7M4Wabu/cwNcE3OFKFoQJs
         rPc7l3s8tRrnx5kr/MvL/M4uPqiMK6dCp7LQoA/Us1QIpl7xcs9Ki7gNVLJkKTJrpaRZ
         jSUPF3GG5JLwpgMLs0q4awMwtwT2x6CHV2025ZDaJjQ2l86ZCKT9uum/7UPbCM1s/Ckb
         qURSAfyHP5IgXGdp5z5FMPgpZRRXYDLX6NUxBWMgOMactUVBtK8v/jAyNsgE0yl6vRN4
         ZxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/jW7Z4NQq8oD4q7raYAzyIvk3oVztHUbLVm4scQCQSE=;
        b=DgmpXR9g1Jst7cm9knadeI+ZAYfpyqFDabZiTVvVyEZ5llOg/KiFDU2ZvfkDwXG+/V
         pRvhLl49hyq5o0J2paN0lsUvZFchOMJufhf/mzkqII2cRr2avv3P+fupUyPIrgz0BG2x
         loffBN++q8CptPZDsAfyg0meFZXO+1OdTk5qNWyvY8Ow3Jmm7IqjPpMmeT4tvxCpFZR2
         YepMyepQSlpJKafb/D3bOJDRpuzCdDJLB+oblw6A2zx9BxQLZ+qRDq2vSI8yUelJgGGS
         9j4tTj8KYzjtiOzsZsxOVjze6EGwu5XgbVjDLDuh11Bw1/tCjBtHG5lTqPRzludGTB86
         GfoQ==
X-Gm-Message-State: AOAM533QyTEbbUx/qKkG2tvTmRrMZm5RtC3aEJoBfIrnV2g6Jzwq5yOF
        0bvFwvQ4EeUS/v9LR068OHf5jqymiIks0z4y8fqnS1sl1K/Bv+L3ZN8kawBdwvIDm6o1GdT/lJ/
        bTrScH0kAJTNDEN4IWE7YNoEAAs1K0TKS/DLFXa8AKn3sqLQwZrNbHxQechrHC/M=
X-Google-Smtp-Source: ABdhPJwv6uEaskIauKRAWsHCs2kkNgJ18DVWllpWp+5Lhx4+6USWPKdsjmc1EFjTe+8qbORAK9XP6KPWnVJP1Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ea09:b0:13f:ac2:c5ae with SMTP id
 s9-20020a170902ea0900b0013f0ac2c5aemr5292139plg.3.1635445871194; Thu, 28 Oct
 2021 11:31:11 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:30:56 -0700
In-Reply-To: <20211028183101.41013-1-chooglen@google.com>
Message-Id: <20211028183101.41013-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211019224339.61881-1-chooglen@google.com> <20211028183101.41013-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 1/6] t5516: add test case for pushing remote refspecs
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In detached HEAD, "git push remote-name" should push the refspecs in
remote.remote-name.push. Since there is no test case that checks this
behavior, add one.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5516-fetch-push.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8212ca56dc..d4c2f1b68f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -541,6 +541,15 @@ do
 
 done
 
+test_expect_success "push to remote with detached HEAD and config remote.*.push = src:dest" '
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

