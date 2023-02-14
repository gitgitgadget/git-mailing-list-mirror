Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A728FC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjBNWR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjBNWRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92AD40E1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:17:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so212855wms.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewVsyWvJL72NiHnQeYOlP7WD4o8NGLnkkLXaAFGfGeQ=;
        b=h37SEwHQ+e/2YSeRqnan9RlgPC6a+pl7IW1CTkYgDi3TgOaBEpxuLqBUSUIr4o6Pkj
         f7ShP0zDZXFuzWeVfESDfXE8kyP5YQuxdQxtqumhSkI1rbk6fira8sAVGLl2Qa5zRQAO
         11snHaJ6U2ZjZMYAfB/dsn1dTyqjGk1JS0RzsbqUvBsZSpqRPFXI03KViPOhAQh7ioBR
         N7ro/ElLMSxQKsXtAbNdVYNpumQ4+QfGiviRaLTH/nGbdqftWTIBWi2dH51qyxn+Jstt
         fPCPfMOg8/SAc0j0R5C6ZZpH+xK8211J/wB3+GTCRRpjS7us3hTrZoy7m0JyyKMzMB+5
         fZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewVsyWvJL72NiHnQeYOlP7WD4o8NGLnkkLXaAFGfGeQ=;
        b=R+o8x5NEU7JSzZNWJPafzhOWkWid96Wed5z5jXsw+ph2x5FQv1Mws3KE3BtkgW6Cu5
         xVT2HKpW0Esr4NYprWk5tdFWy52rDF2n62mzBfhKlTkHjHFoXw+2E+mQRBPswTenTLvs
         lvEwN0FevasndT1r/JODk50NJgBDVb0CyhOwNzcdLnDwRqPIaIdBDZvznLSLH+w2MKqE
         zmzW3H65my7MN66T7bvU0d9mDBjd5rYq9czxI5Z34tOpqare20/TpH9R/r/gkJlaXY4H
         EG9vjRFkKLKnksinDyXL7HjoZj0kmHhIH4V1Kq0SspKegvNKHRQ6szkcE7awyE76/aCN
         A9hg==
X-Gm-Message-State: AO0yUKWUAiVccVFIKOq00FSd21K1iIEMHKL0dV70h0ZkwY3qxgjrA2Qw
        iDCSNo8q5TlX8x0+F5nALPZ5OV8wwjlMQx18eXBxnO9IKMbeAQ==
X-Google-Smtp-Source: AK7set8etMLYJvn0RzErxRaTr6YOKbz1YlbVppECuwpIEwOGN+qQDv88OEpXMytL5cIQxcpsVNnj5leZO4DxlO95hyk=
X-Received: by 2002:a05:600c:310f:b0:3dc:5956:9619 with SMTP id
 g15-20020a05600c310f00b003dc59569619mr108924wmo.7.1676413068125; Tue, 14 Feb
 2023 14:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20230205145245.11078-1-cheskaqiqi@gmail.com> <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
In-Reply-To: <xmqqlela2z3p.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 14 Feb 2023 17:17:36 -0500
Message-ID: <CAMO4yUHqogcHaQa8=LCFyze=dZTtrPPKdcscQHMvaNRX8w7i2w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I didn't see this change in " What's cooking in git.git". I'm not sure
if the V5 patch is overlooked. I didn't receive any review after V5.
Is there anything wrong in V5 that needs to be corrected?

Thanks,
Shuqi
