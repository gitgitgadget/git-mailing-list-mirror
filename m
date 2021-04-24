Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD651C433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 03:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8B66140F
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 03:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhDXDcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 23:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhDXDci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 23:32:38 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B89C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 20:31:58 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u80so17537915oia.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 20:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=zAsnRdQLesacqgZJnFvsVpwn7fCC95PRA1fR3EC2lQ8=;
        b=t8bmEmt57dAgehsWOaTLTckkFL5t9RkEEijp+qlumSbG1LvnXB3+/MxENMNgUIGCIa
         3TMvntm5nHymSpAl4+FOhbFa0QNxa+0HMoWz86I4urWe3QTSkTdp87EbDl+TRRfTiDep
         0o3QmUR2Sc5p1AX2PO0SyKrz/HQ4P5HbjzjMwMMlquaOslENnK9B6woCqC4zCfe2rPQl
         55fP2MOufpohKiKFiHoHm86IttTP8Vv+cSAy5pXnkNE7Hq/5Tw6Di4vKXbq0/Z260wQV
         iu6geKgqftf3WZkUp8tZ3tP0YesfitclBkOr3TRczxCwXRrgWWHrueW7/d2FJ5VS3Auf
         do/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=zAsnRdQLesacqgZJnFvsVpwn7fCC95PRA1fR3EC2lQ8=;
        b=WruGW85pzblDJLMYlNfsxgWhdlpb0k8NrXn92YoPsLNZZqFfUBRFfEhnLGoVvSrb5E
         sBx47Ozz32d8tWM31viIrrnCVzuFHTaaIdVHMV9sTVz6WNvYFUb+7/W9xZuOrUw2lShn
         UkE4CRbr8ROQj+yJ7WscVcdWgYZH6ipLz9aS1GFd/KFx447ZTmyfI2v78Eq/+M0FKZT2
         539XeStNrJuxbI3bk6EdI9nQ47XkKG3cKzt1ZsQo9jdeo0vdtXP4w2mwMVDLX8qypk2T
         A0HSOf6LqEIKP+uI/JLlfA3lFIlpeVzqCo49zw93cQagT6+YuDtMdXYxT5XUJCUdKfmw
         QvFw==
X-Gm-Message-State: AOAM530o2mnsb+m4wmiUkC4y+x4JEU3bbVwoTttriIghS9Okuh/1ZlJY
        Z3tDFVpDIvBSkn5+ClOa3Qo=
X-Google-Smtp-Source: ABdhPJwYmoV6OeWiLu7KlAEw9jeZ0t3EDXGW0nhbXCLbS+mXYj8KHlf5vh8tGDdZNn38zQsXyvSS3g==
X-Received: by 2002:a05:6808:60f:: with SMTP id y15mr4907722oih.23.1619235118214;
        Fri, 23 Apr 2021 20:31:58 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a6sm1544012oiw.44.2021.04.23.20.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 20:31:57 -0700 (PDT)
Date:   Fri, 23 Apr 2021 22:31:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Shoaib Meenai <smeenai@fb.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <608391297345f_10cb920875@natae.notmuch>
In-Reply-To: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
References: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
Subject: RE: [BUG] ** glob pattern in git diff doesn't match root directory
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shoaib Meenai wrote:
> Am I misunderstanding how `**` should work, or is this a bug?

I would say this is a bug, but I'm not familiar with pathspecs.

I stumbled upoon a very similar issue (I wanted to find all the *.jpg in
the repository). I couldn't find another way to do it but:

  git diff ':(glob)**/foo'

Cheers.

-- 
Felipe Contreras
