Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3F8C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 00:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54D560FDC
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 00:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhDBAuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 20:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhDBAuD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 20:50:03 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA799C0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 17:50:02 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x17so3987227iog.2
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TlKvnJ1A19WSSTeVR5jgQowJD8VI59GwVhJnE6yQznA=;
        b=HQKBARMlsHhGEyhGwsR2TcA4a9eJMd4YDecfA9V5keyCDBkBgn4rfihrhZbvyNUBkA
         fdzpIcNKnzIiJWr24Z9sFbyyaQFrUGrf9aTw5RxI0iYyFAIoBHKQ50ixKPImCAR2iqCA
         vY7OkAB6tRzrzYqy3DnKtqI6G0HmOBcojLWBItOGjQjujIvxEYU6kiTz4aUVeFXNF8Xx
         kuRFVb9koqO0fg+J3HtRjW8sMTvxHxILX38l36dLpQ+YpSQ/ae1nlR6Uemkv3BalsAK8
         5zk2SfhOA5yk4aoAMAvtESwwSH3tScGkpPqvBmmgNFrteXudlSk9vlJVt1+psNzIQJfz
         /Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TlKvnJ1A19WSSTeVR5jgQowJD8VI59GwVhJnE6yQznA=;
        b=LnES38jDWh8eCml39CvkRr81SlXIC/3WPz+CBlCaFHeRDI8GcEW+6qDld1/ab/i9AK
         3JxBABVHWph0hgbAGH/hgAHhs0/R/ZDPc6uwVuracpNgXGt3fZcC4owrbPYDF5xhdtk/
         c+nZbR1kzwzfDnFrThJoE3KbhYmO64DrqVh4dNi+3PcyUjejspGM1MJZr5o3Pt/11JHM
         HToksm+glztEqVG7D7QtemFoiqcsnh+OvVnaiZMrVrBjIfbDkQNTlBp7+jTG3j9Vhhml
         ky1xvWBJ0y4Y68FWITTKSQGrZ7njXxJEJ7JJ1G51Jn+JFnjlG3KpR3tjfv9wIOYaQPP+
         0zOQ==
X-Gm-Message-State: AOAM533sd2mZ8oKI8JKXEpDuConD3VuWcHbJcmI253c9b8UY4Q3xxIpd
        imRgyWPLyKE9Axr1XW2m+IK49sv5IChjeh+puEa30HmYioA=
X-Google-Smtp-Source: ABdhPJws7HX6us0WLXdd43SJ/7fr9bMPYExYj9ijzVwyT+bM8Qokva8jK/mM+fNW/WSKfNVQRawPSw73KqLduvi72Mc=
X-Received: by 2002:a02:294e:: with SMTP id p75mr10388264jap.34.1617324601523;
 Thu, 01 Apr 2021 17:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABrM6w=wmcDqL5shONB-fVXcOb60DKHjA4cqGoYn95EBTOiR+Q@mail.gmail.com>
 <CAEV-rjfAW56702Vkj-AiXA2WVqFnMjh0Ox-jyv3E1P570GdX_A@mail.gmail.com>
In-Reply-To: <CAEV-rjfAW56702Vkj-AiXA2WVqFnMjh0Ox-jyv3E1P570GdX_A@mail.gmail.com>
From:   Peng Yu <pengyu.ut@gmail.com>
Date:   Thu, 1 Apr 2021 19:49:50 -0500
Message-ID: <CABrM6wkbvC4AvFnbirtRDAr0VBPaueoSP2PEr0W89evG3sPqAQ@mail.gmail.com>
Subject: How to mirror a directory of a repo?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://github.com/bayandin/chromedriver

It seems that the above repo is a mirror of one particular
subdirectory of the main chromium repository
https://chromium.googlesource.com/chromium/src/

https://chromium.googlesource.com/chromium/src/+/master/chrome/test/chromedriver/

I don't know how a repo can be partially cloned. Could anybody let me
know how this is done? Thanks.

-- 
Regards,
Peng
