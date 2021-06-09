Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CEEC48BD1
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B8E61364
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhFIN5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:57:38 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53148 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhFIN5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:57:36 -0400
Received: by mail-wm1-f41.google.com with SMTP id f17so4084980wmf.2
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CblJ3OfMeVETAhnc8n/9uVF841+kXTAaqtBApW37/yQ=;
        b=blX3VMB6n8QDS1bZXy8sbn+EC282jWhROARrof7403HazVGS/DctPPX0Q2GDIPZTqo
         UxyAGgQ4+SVHcbEse6eH+HaBvYk7gDlBa3yY/BPLSh9enBWIPkjhKVvX/xeF9t06K70l
         +icp7xSHAQHKjSykHZHKKIsdK0CjVJtSjLk/BYeZbiIuXbICm+stCEfTUnPzZhekUsMI
         o7XMyiCavjmCJIhlNGyTd9DpB/ifcAtPuLYbWyU676Dz2ZlOPY0kxEtWvMca2FwJ/NBS
         MHirpN35ivfNXNDPsN1H+Qauee+F31Cp8hfq1qnFgJv3fPhiSjW1L6UDtwGL2mECRPni
         cL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CblJ3OfMeVETAhnc8n/9uVF841+kXTAaqtBApW37/yQ=;
        b=dGJOIUuBnM+vA5EYO0ryZtegztmBWXH1X38jIAQW1rZ81RbnxQV0/6dLYgHEdxSa1q
         k66fQRFgOyWgDPQmHoOQNHUELvpi54iCByKSdrg45N6RLYpQPuGAPuadaV53f05kg4k7
         Wa5c+CQs3TWrhAGvVuVXO2S0auu6EDPZK3Z7TKBMe8mDi5vX+8/irg7J7b2ag/uj6LDL
         SyBHl+AsuRACKaBnhx/M1Y6K6Vm8UmpSvgBANKjSR1Nqa+zeQB6j/0OXNf/fpy32MQYK
         lFDVJTp2UkyMpwye4yhTaKilzttl2kHdz9Qa2IkfhXQhy8bpdUwRok0PSc8em763u2J/
         fjFQ==
X-Gm-Message-State: AOAM531raxnawMMoP5HOaKZ57cSHGp37j7J4x/RqdO6WzBLW9UybvrY4
        y7TSVOaN9H5T684PXrrwRij53ZyjHSQ=
X-Google-Smtp-Source: ABdhPJwTOHU+wgDmWCrhsEBNmgutlkm0g6LNhIrgrt5s2LOPCA50meFHIkSGLF6a8BQERGV7iaS17Q==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr28080719wmh.21.1623246880918;
        Wed, 09 Jun 2021 06:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z19sm6152355wmf.31.2021.06.09.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:54:40 -0700 (PDT)
Message-Id: <fb7a7573782ae8ba3bc5341d6aaee704af88fdcf.1623246878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 13:54:35 +0000
Subject: [PATCH v2 1/4] Documentation: use singular they when appropriate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

There are several instances in our documentation where we refer to an
anonymous user as "a contributor" or "an integrator" or similar. To
avoid repeating this role, pronouns are used. Previous examples
chose a gender for this user, using "he/him" or "she/her" arbitrarily.

Replace these uses with "they/them" to ensure that these documentation
examples apply to all potential users without exception.

Helped-by: Richard Kerry <richard.kerry@atos.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/SubmittingPatches | 8 ++++----
 Documentation/git-push.txt      | 4 ++--
 Documentation/user-manual.txt   | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 55287d72e0ef..f519a8dfff7c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -372,10 +372,10 @@ If you like, you can put extra tags at the end:
   the patch attempts to fix.
 . `Acked-by:` says that the person who is more familiar with the area
   the patch attempts to modify liked the patch.
-. `Reviewed-by:`, unlike the other tags, can only be offered by the
-  reviewer and means that she is completely satisfied that the patch
-  is ready for application.  It is usually offered only after a
-  detailed review.
+. `Reviewed-by:`, unlike the other tags, can only be offered by a
+  reviewer when they are completely satisfied with the patch.  It is
+  offered only after reviews by reviewers who are known to be experts
+  in the affected area by the community members.
 . `Tested-by:` is used to indicate that the person applied the patch
   and found it to have the desired effect.
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c38790..2f25aa3a291b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -244,8 +244,8 @@ Imagine that you have to rebase what you have already published.
 You will have to bypass the "must fast-forward" rule in order to
 replace the history you originally published with the rebased history.
 If somebody else built on top of your original history while you are
-rebasing, the tip of the branch at the remote may advance with her
-commit, and blindly pushing with `--force` will lose her work.
+rebasing, the tip of the branch at the remote may advance with their
+commit, and blindly pushing with `--force` will lose their work.
 +
 This option allows you to say that you expect the history you are
 updating is what you rebased and want to replace. If the remote ref
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f9e54b867417..4fe9be117c4a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2792,7 +2792,7 @@ A fast-forward looks something like this:
 
 In some cases it is possible that the new head will *not* actually be
 a descendant of the old head.  For example, the developer may have
-realized she made a serious mistake, and decided to backtrack,
+realized they made a serious mistake, and decided to backtrack,
 resulting in a situation like:
 
 ................................................
-- 
gitgitgadget

