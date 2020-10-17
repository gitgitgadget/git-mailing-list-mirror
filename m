Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E7C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 14:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE56820756
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 14:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azaasoRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438320AbgJQOYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 10:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438317AbgJQOYX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 10:24:23 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03377C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 07:24:22 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k68so977148otk.10
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jlKzaKSLYInhoBCmb8aC+6hxS++TXXXFWioyvwqfDEM=;
        b=azaasoRcZCE4lbRsNvoY/4+qAx+xlJIXMRNYanYIEPiQ11U6qWYjG76rsIaMrakA5G
         4SdBdFK6uwO//HkwMygLf+jNqZF9sEshDhgvC6TkTGm4cpuaF1Nds2Yw6RM4UoD/a8bw
         SBqbuar6Org8QGiuCVIKggLPc0mK9hOGsCcok9eGGuZsKd0gIJxqa9kiHMtDgUgaHd6e
         CtV1h6E13FzSI/F4p4+odAnfxZlWQGZnyEEPXs+Ozz+ws8iEZ2EKsOYiWzZ5EocptYi0
         5yiGywVm6dYx3OSN/u4LBs4iVA73hu00OTcdwdrCg4O5JBZgErYxUC/MR9ORcgB8K7fG
         H8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jlKzaKSLYInhoBCmb8aC+6hxS++TXXXFWioyvwqfDEM=;
        b=P5EKc31KRtuFniFU2Y2pqOpLY7s5SrkWI7DyGLqbCRQCRSxcz+bz/sbXQ2yEGACiLa
         kOLmMfiTrK78pLCoVILfmGWKPGQHYopd11xrypfAENBjZGWwAHMuwZUTzq/0GBZ7O5eF
         IavzEafkyavhEQKMUTeh3oo/YS7v6oagW3dUrbCLDrF/3Aj3f55L+Ep22LMDiVUmYvgt
         F4lmM/kyvqMUFjNENBg0cTUiDemaioh1mlaTCtEL620itUgYibpVFiP3pFnfkPZ6Tzib
         T05TUEcXJKM1yF4MmhONte0eY/Yq1R/nWxYGMQxLI1LDJ9yCWDwtauFA23uwUgLSjvT7
         Difg==
X-Gm-Message-State: AOAM532sZgbuNnlH4VwFmnxIvQvn8UbMq/h6D5J59CwEAee7EGY9OiGT
        NpvOG69/uMEyF/rd0N7weH8/qmA6FQMUqppHhdZB69mr2J0=
X-Google-Smtp-Source: ABdhPJwBWYaGPhJnNQsISTq30YXPdBO77AnFQ5mjc5+mg5EIYlPYnqYjJxzGU0ZtcYwGz+tzVqk9/arozLhexBQdH1I=
X-Received: by 2002:a9d:21c5:: with SMTP id s63mr2082407otb.171.1602944661933;
 Sat, 17 Oct 2020 07:24:21 -0700 (PDT)
MIME-Version: 1.0
From:   Sri Harsha Akavaramu <harsha.akavaram@gmail.com>
Date:   Sat, 17 Oct 2020 19:54:10 +0530
Message-ID: <CANZ9uZyL=+LNS-+2p3ukSPg_UXxjfcjD8QPVF4p0NF5-+eYMYA@mail.gmail.com>
Subject: about git hooks
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git,

I just wanted to know something about git hooks.

we use GitHub enterprise and I'm the owner of the GitHub.
I'm trying to understand that I want to pose the pre-commit and
post-commit rules on all the developers by default and is there a way
to pose git hook restrictions on all developers on default.

I came to know when reading with the documentation we cant push hooks
to source control. Then what is the best preferred way to pose
pre-commit things on all developers using the repository?

Thank you,
Sri Harsha
