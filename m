Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E0EC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 04:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6622076A
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 04:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vechTWGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJEbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 00:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgGJEbv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 00:31:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C67FC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 21:31:51 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x62so3501985qtd.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hFruXCZw+ApKED170bEo880oVwE4P1ysRm7mi8KUvk4=;
        b=vechTWGRvKjqah2tYtndKlQkxj4YfLgyGrgGmVU84UXDUr8jvuUntsGKDxqLlcHfZU
         Jkh6ZX8r7j0dGWgenRS1RhSRWiTZtMGj/2TL8ybVJFkzgTbCp4y/N3Dxctli2fbQh/Rh
         8AwEjJ93xYWvVx/GvBQ0z6UIdYxvec8V1RBqAJ2D6bIwMYmrCdg8IOKRgwpOIC/jXmfh
         fqOUVeKAGKI4w8uu7P7+EaUZ+j3e7fSvVviU6K0+gSXt5+IC5HK98gSQmzrKkFm72GJo
         EYLYPw+ClOInYQ6ti2IPcc02SrcVdmAVR7lgPdlwixhfPSHsZYuzl7qI+Ggy8duyzkxw
         77NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hFruXCZw+ApKED170bEo880oVwE4P1ysRm7mi8KUvk4=;
        b=KYTS8IDMwch6odypvrkVPB7fNkbcEblLeNzHZD56XZfw63NhB1krdRQD+mtRAjAFyH
         n13otiPhRtyI15+0LkT8NBX0ddASFCeNM48Eqyk5xt2MLmtqsJeBGpMvf2rxVW3Uvyzz
         vV/wj2MdQ0PGJHBAI16PJZN/RX1m881sVoU5WX+EHob4RaJg4MXLx3DuVgk8hqTa+GRq
         OzRb6tw9JkTDIDnQpULH4CrxAGia3tE6mZG/gzKTofqcX26QmpuAB/PK7VlQOcIZJ8qo
         zQZeLRi685W9Bs8toHwMgcyejBJ9BK0YEi98KIQYP1N3qe1C6w24T/b8K2aV6ZhCD+wF
         vlNQ==
X-Gm-Message-State: AOAM530mfVzjvz+m+bIA/os69xa4OEQMI0LBfph/IQx1eOa6L+x8Uh0y
        KXridCm3jAuBI9P8J8d1BzQr4iWoqDbaadYUkPurdEVuJ27nKQ==
X-Google-Smtp-Source: ABdhPJzq6X6Pc/3Zu3qt3vTVWgAMCbi+UoRoCSj8CY4y+y1iF/U7cnZ9cMfcJqCkPO35wALJGIycOa3wNjG76xwicZA=
X-Received: by 2002:ac8:45d1:: with SMTP id e17mr72178940qto.159.1594355509382;
 Thu, 09 Jul 2020 21:31:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Fri, 10 Jul 2020 12:31:38 +0800
Message-ID: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
Subject: How can I search git log with ceratin keyword but without the other keyword?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, list

How can I search git log with ceratin keyword_a but without keyword_b?

Assume I have a branch master with 3 commits, the comments are t123,
b1 and b12 separately, that is:
b90b03f (HEAD -> master) b12
27f7577 b1
7268b40 t123

And now, I want to use git log --grep to search the log with the
keyword "12" but without t123. The result I want is
b90b03f b12

How can I achieve this?

Thank you for your attention to this matter.
