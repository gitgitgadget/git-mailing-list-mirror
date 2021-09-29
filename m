Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31637C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5DC613D1
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347468AbhI2XI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347503AbhI2XIU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 19:08:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3046C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id n3-20020a17090a394300b0019765b9bd7bso2719634pjf.8
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JvnjqduYW8ua0kDwLHNmR7R6o9dSnJXfHcn7II6uyf0=;
        b=X3i9nZkiz3wywmMESKoFo+JDl2e/AC3D7R1+ysc8Z56hufP34/1vwXBC2CGC0lyg9R
         eC8ravOfl2744GSynGmimNknDAja4Ohut5RHBA9pCh+yteo15GoxCvT0hNn2UagdoAaJ
         25kQrmHD2yGIs362CCRBBYUpwFC97D6hJk5FbWX5RaLOrl8pEnH0vqNna+NkbkR+hNfM
         WV48FkZU3D9Rij8O2IPTttheSAd474wEEXiOY53mJJEpK8KFtmUl3ACs3GdQL+x7rFk3
         neHqu/Bl6ZaETkQ9Du2trPqCJpvDfyOOAG8Sbx7iJGIH9vHaRzHEfBL1oSGbia31cJjH
         DVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JvnjqduYW8ua0kDwLHNmR7R6o9dSnJXfHcn7II6uyf0=;
        b=nGaRn89MzurYoN67LsPwewMAYm0EjIjXGTtoMAVaMYSzumlT1Eh91I5Mex9MCBCmS0
         Rr8MXW/CEaVu60TRmSJBYZFfFhhhBsFfUaAVOuSBUnxuBUJ1DWl/osULbnTB7pUJw04K
         gOYTRa4kggtv2NXpH5nkVNf/IYMhvrDhExn7fZN8BHGDuRtDlPvXqZcxCWwk6JtxS8RF
         kVFIDgJX9YVNhSlgWHOPBJS5Ps6eDkb24h7GSKPpmNNIJxo4r7ZFwRJ0Jpttiq7IfU50
         QSR6LnZK7pV71mDljIZHWZuwkxjciMLFz9990Zl2YOLmNUtv62+YZVElnHgD2MK0yzZ6
         TbSA==
X-Gm-Message-State: AOAM530cn8xA/9o9OQW9IO0ZliCEeJ3SWfP4wD/8Y+hGYdsB61QN61rY
        9tzN9E9P7EecSGx7qhnh/CiAdh9a59mT+x0nexotW3rNbIu6UcwQouq7r/viYtG2wL7dTGg9kom
        yLjIq/kRlQI3NmGPHFOxqn/KHyN27nADSNlfPSB3ryC7FDwHYmfBCdQLS1uq7VLN+2NDSum4mgP
        r9
X-Google-Smtp-Source: ABdhPJxh0I05C63gdfgbgHS4U91mZB1reLDS22777vBTFqPFlGbLJXA9hSvA8vTrxX3ipiu01mDa58oCH5EoT8GJzFqs
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:fe8b:: with SMTP id
 co11mr9208847pjb.65.1632956798290; Wed, 29 Sep 2021 16:06:38 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:06:23 -0700
In-Reply-To: <cover.1632956589.git.jonathantanmy@google.com>
Message-Id: <e4b6ee218656bb7c296475ae70562472ddd45682.1632956589.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632956589.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 7/7] submodule: trace adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodule ODBs are never added as alternates during the execution of the
test suite, but there may be a rare interaction that the test suite does
not have coverage of. Add a trace message when this happens, so that
users who trace their commands can notice such occurrences.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/submodule.c b/submodule.c
index 4bf552b0e5..61575e5a56 100644
--- a/submodule.c
+++ b/submodule.c
@@ -201,6 +201,8 @@ int register_all_submodule_odb_as_alternates(void)
 		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
 	if (ret) {
 		string_list_clear(&added_submodule_odb_paths, 0);
+		trace2_data_intmax("submodule", the_repository,
+				   "register_all_submodule_odb_as_alternates/registered", ret);
 		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
 			BUG("register_all_submodule_odb_as_alternates() called");
 	}
-- 
2.33.0.685.g46640cef36-goog

