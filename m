Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F73DC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 02:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610ED64E13
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 02:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhBACPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 21:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhBACPj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 21:15:39 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79144C061573
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 18:14:59 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i6so9034902ybq.5
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 18:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oZFOXmfsAoDtyWKBo08wWnUxBBBIeu6C1AJQwNtcmhY=;
        b=PVnJY66D9bNZ1C6PzHEjN6g2yy+k93MziUXugJmnCvIsPcYcSoIRYGebG6dj7JfNtk
         wX3r/eJ9EQqpQNWphOUYjLLHa8t7Bs7K7ufAMtEObAw7z7VJd0xiEL2MWBLBo5i4WF1n
         JNwhIMSO2XTeA3Rh9ennYfS5aWVl/KQQ/ln0qntKH33nrfAXobbuxG3Tq7H2iC9ciFGS
         UsUaAcrwyi1dUi+6Jd0xFv1/KTkwvcIhFps/Gi9iMtMnTlUK5zwVRwTz5AIy3xJgrjof
         vEnfZ8t+TT7uKdGrtwaGvB0rFL97V3J1ra8PlMbp3HZb42n81Ar3q9Z3RbsFyNLr6lcw
         fSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oZFOXmfsAoDtyWKBo08wWnUxBBBIeu6C1AJQwNtcmhY=;
        b=YTZwdzcDREaaDqxXd1rUHFnluNiw+id1BxLhJR6bJLesXwM3vZxRT1n5Nuc/cCs9fO
         yhzRvkp/+TQfCzckMexhRZqs0RNwJiws0iEqh3qgUKOkbWru+l12FHQEteWRrhDa3/yj
         9tS2odTx9iSd1/XmAw7N78iLjlWGxvHJMlS1j0hNsP9eolSspA/2+xu7Hjn00W7V0AYL
         0RbwcAM1wJwuk/HSrPjxgdHDFpjuMBlUmD37FHKJ6xbKKs5yC7Z017/5/KEPBc7ailf/
         4wS4KhpSYwm06h6l68wB9W062Mp44HgTSAeVq8ZkT3wZ2EwqNIQgHHsOYu/M/hoqSqGm
         qZJg==
X-Gm-Message-State: AOAM530SsGrVkmfT3wbW+Y0ngtHXN4ab0UXFT8SwYPgbU5T8XZHC8e9Y
        zGQZXWjBvS7/H/1p6nopjSfIhbtAA8Zu1I8W/skX4TnOTZYld/UI
X-Google-Smtp-Source: ABdhPJzKpNNxP4j/Dk3zcpcjet9IFG/gxCNjYZ6C3azwiuCfvSk8S62vtpkfQnIt3Mc+UFEmyyMqGKXpiTjvsp/3uHg=
X-Received: by 2002:a25:b94a:: with SMTP id s10mr20563094ybm.374.1612145698715;
 Sun, 31 Jan 2021 18:14:58 -0800 (PST)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Mon, 1 Feb 2021 10:14:47 +0800
Message-ID: <CAGP6POKSOaaq0A-L2RgQ+R+bJVo-KuZChEOcCuO8jP+Cm9QFPw@mail.gmail.com>
Subject: Recover a git repo after accidentally deleting some hash files
 located under .git/objects.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I accidentally deleted some hash files located under the project's
.git/objects subdirectory. In this case, can I resume the project?

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
