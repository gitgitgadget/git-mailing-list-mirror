Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090AAC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiK2NVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiK2NVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:21:15 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2821813
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:21:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a9so10221211pfr.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TlnPAktKofhkzlF1MMI7hynIHuV/Up7+QqokQbGpjM=;
        b=Nqe/8kofOlSJumzSAyfJdfcP+r42ZzcsFM4pIl6KjtgQfHDSGHFKPbZNA+4zWJb2TO
         KeIy+rYAE3F/r8lC4qkn+e3hDb3y4Ok5vNO71Xid7AXU3xYh63QADG3sfIsybjsas+uz
         3vp9zowHK2kWVGoUAyza8VbGlWiZpfJzGLhEQAi331uTcM9Vpi1KGZXFzwetY1t9mVwY
         FtCrO1Cnvhig8AzodTHRFDX2kpWVz0b2yBH1qCq5h4lLR0Pmo0PgJWIs/tm1HqVrTNRo
         WljCg6i4vmRMnC3BI37sjlAj+vyALIsZW6HUReiNpOQvuuFF8CtSuOdOeBxWxg2K1Y+A
         4Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TlnPAktKofhkzlF1MMI7hynIHuV/Up7+QqokQbGpjM=;
        b=Rhm0NIzKTX3d5lBWz/9Xm0cowmWI206uURDSQHipYLoOZVBxhqK/kWD/CDwFV7Lt3l
         iHa+PREQTmG3fco6xu9L5UP0wuNy2EkrDVLXq2tdDy1dPVZgUurJeYRZ+xwS4tRQKEDG
         DIu4YA9/sM86zzopZ0+zZsYF4XsXYF7XXKHSamkO8XiNh9wsmqF+G20MCCSyNzj0Z+HT
         5Ry52VIRQrZY8CX4Ixg6dh7HHZUdi2H+//EG0a0Jknu/cb2jXuMmq80XM38DlBtxLa/J
         RXk0lMuir5JO+gvse+MXgIwph2K0h5ZvQBd7yQ4SAwgj0PkL1MkeAOHY0xpe0K8DGz7S
         1+WQ==
X-Gm-Message-State: ANoB5plGnoj02yTZiJ0jC6wD7LhGVNPJCErGaIQgTS2sEpwk4lx2YFdt
        LzclMJrcOOwMM7we51rZzl8=
X-Google-Smtp-Source: AA0mqf6FNgXYZ8f8HS5H5mUfsljxM0wmwjDmNp/vagAfUy+JEP1sbYGlbewcJ+fU5Kwf5wBu4LbXbA==
X-Received: by 2002:a05:6a00:1bcb:b0:574:ba25:1e43 with SMTP id o11-20020a056a001bcb00b00574ba251e43mr21576653pfw.63.1669728074279;
        Tue, 29 Nov 2022 05:21:14 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id f26-20020aa79d9a000000b00575448ab0fdsm3346023pfq.114.2022.11.29.05.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:21:13 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 0/4] pack-bitmap.c: avoid exposing absolute paths
Date:   Tue, 29 Nov 2022 21:21:07 +0800
Message-Id: <20221129132107.82953-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <Y4VEeIC+iInY4MuB@nand.local>
References: <Y4VEeIC+iInY4MuB@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> > Besides of 3/4 and 4/4, the 1/4 and 2/4 seem already in 'next' as
> > 8ddc06631b184e6f43051f7ea8ac9bbc86817127 and
> > 2aa84d5f3ea1966a81477ad31bee0136e39d3917 , but I send again here just for
> > the completeness of the patchset, I think it will be nice to merge Peff's
> > commits of there are no new suggestions.
>
> As you note, the first couple of patches are already in 'next', so those
> do not need to be queued again.
>
> But the latter two patches look good, and are ready to go.
>
> Thanks for continuing to work on this :-)..

Thank you for your help, Taylor Blau.
