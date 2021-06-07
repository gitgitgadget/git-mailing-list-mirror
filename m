Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B90EC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD25610A2
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFGVt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 17:49:57 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45723 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFGVt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 17:49:56 -0400
Received: by mail-ot1-f48.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso5253153oto.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=BAbgFsNooS1GMUjCknBumJqh+orHKumiDoxyF2hnr0E=;
        b=pO/MSAMk3LHnvf9raB44U/oXSgdWzsc+1kEzkcpgmDV5O3NmFxKnugIlIwkYDP8iLZ
         ESRE0GFGeUi3V3pugSH1tVITu9JuPBWbYa09+P9HVLCSi9tI+z+wvD8zF6LB0gcIhp06
         5C0ySDLAroaZd3seDk3YHWc0PQ1wdcEr0u8NQUdB4Da0/S6aLXWuF+747jc9tSLlNnLp
         qxzsP821pq2Seph0uPafMMXxFOL9PlixQ5O61zqzO3Z8lml7hnJ7Ypq5NtEYiZ8wSHsB
         5uVgFpHedihgs9dkjq8L5lVuQPy7EexeOWBMYxHhCPiDBfdXqIEjqBC1kIR6Dt8BUG3q
         RAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=BAbgFsNooS1GMUjCknBumJqh+orHKumiDoxyF2hnr0E=;
        b=ESWIVWETOgQXjtq9/7MgNIO6JUvPRK5hHFF2ySpIvdkKikw3cwiYfKXOzXj40i4tMn
         F19mdvAYLVtE+E6wmkJjtSGcjiAoFNMD2cVTsy3r5T0AcPblC0kWFhZnKqDBjws75lg5
         7FHXP/AjouBK6xLBMoEVi3kSyVcRGlzLkAwvsOwb72xo53ZC2TgqwtlehK/h3kY8U15v
         o3rOxFeXsQHaFwwpwZDhWNIREmYcEoZg7gy+9MnWW/NScPfPh3t7Tg890iDuTsAVuVZU
         2foWtHDRbXm/jv1qSzzQBfJne7eTMngdn2hY+kM/kWItWVSMR0o7w0+Lo/t0iCaMVm48
         o8UA==
X-Gm-Message-State: AOAM532AS+tkOL5l4344CAQitNpN21M2H7RRGDUpgmgk+PxCBeUX/Hxe
        FsDTLqkk4DYqd+dwpfV+hss=
X-Google-Smtp-Source: ABdhPJzApDN59KUBWX0vxBDoawEO89+aU3sKYCFOuOKdOoAIn1cRhFJ8CI83h2SPXJvH2fYPQYbabQ==
X-Received: by 2002:a9d:7012:: with SMTP id k18mr15329340otj.179.1623102408193;
        Mon, 07 Jun 2021 14:46:48 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x9sm2405441ooo.27.2021.06.07.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:46:47 -0700 (PDT)
Date:   Mon, 07 Jun 2021 16:46:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Message-ID: <60be93c64372d_db80d20887@natae.notmuch>
In-Reply-To: <CABPp-BE-2s+0vOg+icJGBgR5X6BpoTieJd2KH39SbXW1WAA1Ew@mail.gmail.com>
References: <CABPp-BE-2s+0vOg+icJGBgR5X6BpoTieJd2KH39SbXW1WAA1Ew@mail.gmail.com>
Subject: RE: [ANNOUNCE] git-filter-repo 2.32.0
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> The latest release of git-filter-repo, v2.32.0, is now available.  It
> is comprised of 32 non-merge commits since v2.29.0, including 20
> changes from five new contributors.

Maybe provide a quick summary of what git-filter-repo is?

Cheers.

-- 
Felipe Contreras
