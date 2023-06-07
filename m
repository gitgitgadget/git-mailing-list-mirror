Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD1C77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjFGRCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjFGRCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 13:02:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFCA1BF8
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 10:02:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so258a12.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686157334; x=1688749334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=33Iu9BfKhdqxsBryqx3JlHrUKvDHZMGPUzffwTjrfA8=;
        b=peNfK7N40E7Q4080p0FQ/3WFnegiMrjLdZqUtVgFTHG9G7kk0IdmSygBkHOR5O7U3N
         DWDZYsRdx0h2UzRZYPJyBr6+Ubz/FcHwRFBDQQosSR6uRLk8+UHYIHXvBgUj/B3Yrsqb
         Yrtk8cr/74P5JaP3WA42XYci2kJShK87wP8NbmhZKiKXB2aN9JoyJhPSHyXKRH3/k+MH
         E6CfcpEhyCaj/w9f9aPIISX0CNSTNXfx/5gW42UZJV/KmwnQiUcslNY1wjZjvYrj4uUv
         neW7B8w9k69oj93LJvQkq6m/4wa6rRcZtAQlD72EmqBmb1+Squv/b5BGkOFo8omMMMu/
         H5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686157334; x=1688749334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33Iu9BfKhdqxsBryqx3JlHrUKvDHZMGPUzffwTjrfA8=;
        b=OMSRaX3uC6fsRXLsFesTK/MQ6jyLWpds9rNhMLZmHwSxco6Kr/sTmHDFDOUTXlevth
         CcGhOTZZnQ8E2vEyZo5ZIP/VbH27uEaYO791Y/2rSzMudESymkxdoyS5uiGJyE05PdPk
         nDsl7n1b8a8p7ksKtz6VYOsUN+D7Dtm82DG5OH6AUYTgP+FaLRECzwkNXXUqbGQsc26U
         JVw7bb2jZrq0FkBc2Bhlkw7DFSt8HD0vxGkYBpgVlhmfDGm22eixp1r0IQI4gpuBZa/2
         wXHYDzzjEUo7doH+MXH/dfO57HyyAl+zIVVIUWaAubq4XihzVaQjs1uQ4Mer7WdweytJ
         9PVA==
X-Gm-Message-State: AC+VfDyRazV/YaRkLJHH8Kny29Rvm+SytXCKCSLpuDHZROhCovdl+Hu/
        W+kTJWksc3t+Rnx2+ZWMTGVsltORtagkBaDGGSffpGv+rP6m8Np95kA=
X-Google-Smtp-Source: ACHHUZ46JbmOKXYAfpolwXD7z82qFa97WMgO+yJwZNjlOLPPRTyIoxZH4+w4Ne5Asad60wSXaAz9iwDWiBuwFc14yDw=
X-Received: by 2002:a50:8acf:0:b0:514:92e4:ab9f with SMTP id
 k15-20020a508acf000000b0051492e4ab9fmr136963edk.7.1686157333984; Wed, 07 Jun
 2023 10:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com> <20230606171002.914075-5-calvinwan@google.com>
 <25d47081-2096-bb8a-dca3-bd5ea931c879@ramsayjones.plus.com>
In-Reply-To: <25d47081-2096-bb8a-dca3-bd5ea931c879@ramsayjones.plus.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 7 Jun 2023 10:02:02 -0700
Message-ID: <CAFySSZBZVn=7gBB19_uNxeUwS9Y8Q6ZZiCT=AwfuBy4+d34piw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] common.h: move non-compat specific macros and functions
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a particular problem here? common.h includes
git-compat-util.h at the top so that it has access to standard
libraries and possibly other compat utilities. git-compat-util.h
includes common.h at the bottom so that other files don't have to also
include common.h as well. Imagine if instead of having git-compat-util
include common.h, we had a third file here: git-compat-common.h. It
includes common.h and git-compat-util.h and every file includes that
instead of git-compat-util.h. Now git-compat-util.h wouldn't include
common.h, but this change can be circumvented by including common.h at
the bottom.
