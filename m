Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE82C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A411B64DDA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355352AbhCDAXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348291AbhCCRTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 12:19:10 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE9C061760
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 09:18:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mj10so23622821ejb.5
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 09:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hO9VcoeaVDqDcQ2qbN+8aXjcGs6LZtcgQUpUNRvgif8=;
        b=de752LS2/8pLA0loHO2N5F+VnNjdmlxxJxl1ojS+0V3CFJcImofgrjDf50W6YeQ+js
         faVihlbhwj4b4Ib+ryeGEznQ83e2fUcdwOfiWWCtsjg9abChIf0LdJ33ewgrknDvx/1B
         5YK0+6fAetWayprWLRQoFT6GCpo0ypWyl0KeR/D4hTKGzfB4nlLdc9RUwGgDhIEWNqoO
         VY/qYDICuBYH2Wj8gP3gz1Dw9WpqzfLrrigogEf5iRvMFvbS1S3Gm1SV4u9BU5xT20q2
         MVcXS6Tcf2bupmPCsk3GSGS9GsI/xDjF9FUOmirGg6PjhDHSPRWgK/Jm5npWkKiZxREn
         RkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hO9VcoeaVDqDcQ2qbN+8aXjcGs6LZtcgQUpUNRvgif8=;
        b=OBZAJLNqANuuO2filPHO92tEu6hZL4KaVd1qSIQ6psfz0a5infTDeOFsO7wGU6zqQ3
         aE9m0P4qZ9C1clqYOir9slMsFF3jaEuYeInZwO6j97RU7gA9dQK2GWPP6H25lvVLWLkh
         7gaXs7X2GcmDJ6KBgMSlYESWKfaAsmWprIGPaFqugygwaLo1UV061ziCXWu/7PHTzJwK
         ShZe/dOWqojaDCNjPo9NX2PYd3PDENXingZlBT9qkNCygS/z4CXSRxf2WtSH+P0/MfFA
         HHPANcwkkk2qaZvEd0zMLEQhvtO+acETkvZMeH5BpVrA1J5/o35Phmy7I4rZeylVbLvL
         GvZw==
X-Gm-Message-State: AOAM530b1llLWOE/smJiaVXSt5RWjEepTGV3CmLONHvryvzYBDmH+Gvr
        f052uIE4Q3hKe3739sMFCX4gktfJatPSkuEPDDI=
X-Google-Smtp-Source: ABdhPJw7ImYC5cZfS6zH9SuBO/nifOBP7r03kPeCYiiDwRpve4dkxzggD5eZiEaqWuQlMpQjplJ+aINav2QKH60CzHk=
X-Received: by 2002:a17:907:211b:: with SMTP id qn27mr16723839ejb.203.1614791906112;
 Wed, 03 Mar 2021 09:18:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:1642:0:0:0:0 with HTTP; Wed, 3 Mar 2021 09:18:25
 -0800 (PST)
From:   =?UTF-8?B?6ZuF6Zuv?= <zhtw1234@gmail.com>
Date:   Thu, 4 Mar 2021 01:18:25 +0800
Message-ID: <CAG-FSa4CDAOV6mpUKcau+Loe-THJaeZzbhv+BwnUSYbV5Gz5XQ@mail.gmail.com>
Subject: =?UTF-8?B?5YWo5a625q275YWJ?=
To:     alexhenrie24@gmail.com, developer.paul.123@gmail.com,
        dimpase@gmail.com, git@vger.kernel.org,
        golang-dev+unsubscribe@googlegroups.com,
        Katie from Spring <katie@spring-a59f0d91bc8e.intercom-mail.com>,
        mark@hotpy.org, marketplace@github.com,
        MarketPlace <marketplace+noreply@github.com>, nad@python.org,
        nas-python@arctrix.com, Python tracker <report@bugs.python.org>,
        shaan7in@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

5bm55L2g5aiYDQo=
