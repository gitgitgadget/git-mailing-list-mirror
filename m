Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3FFC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 15:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJLPTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJLPSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 11:18:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9952E3182
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 08:18:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d24so16539421pls.4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGzUTJKlG0RdH65ItJe6dVzyYMzaK92HMO9Wu8PXmVM=;
        b=ODbE3mN6kloEjI+HTNbePaPKqhsSudcn9DVX0B7TK87MYxUgbz6LZpjXm1MzO9umjc
         2pDuxCEV2VUw7Vg8FCSS2XKjUWYkM6zc+frTSYJU/5OI0MztC27pH/N4WQ94ShgXHD5w
         dni6Af7GXRnT26ECaBgN74De053A9ZB6RDZb76xoroNi82SED2GVYy0J5o9H7CWJ2lS9
         l6Mpy+o2e141kI3xaeVMjhQjRaQWKhwlEzQ1+9WU7b81s2C3io44MM0cblsxC8KoHKvx
         nnFx5EVc+xlmmCqCLXKA+k+R7ktAkvisT7i/O79ebBK0BUkDToFyRV6zFoO5Ud74jKaD
         0OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGzUTJKlG0RdH65ItJe6dVzyYMzaK92HMO9Wu8PXmVM=;
        b=gU6LUhOaSzhFlgifiaxL/9C24C+sU+pDsvklnEygzH/snQzLCT7mfFaLkOO5CaLYyP
         g/TNQpusFRCv25jLr+6nPdh/zmUfJaq5QSIKQVIavR9rA0hJhlgEhFKBuHh8fyhMk5RT
         eYKSu31pfJKLVie9C/wydelALWxl5Bcr5SQ7ni7d6db9vM0gYGu+VldflvsPWU+q7+Wi
         0xCJRsuMcWv1NMo7qw4vuBTkr9+1Zuqz5fXqYFo/rhgMNeLVvb7yMP95dheUCxtbhkmU
         TgFm6GOCK2Z8ufD7ZO3m9IlnKz0truLKbOSComQtZ2XXSGU8QRB2kJ/rBoOt0fNuWJlm
         BHxw==
X-Gm-Message-State: ACrzQf3EQfpJKxqVgz8V5w7Zp3N6dyUTjuxbHa5aZ+TiFlc7R78/3GKM
        8hlF6ppP3N3wt74rAUecJk4=
X-Google-Smtp-Source: AMsMyM4ZMWafn9yiCSPxZ0eZ0IWo/MNYFS9f8NYnHwHbdT9rhCyCJxNTG/K8qhvGBqmjmlYRy3+r+w==
X-Received: by 2002:a17:90b:4ac9:b0:20d:56c4:a8b2 with SMTP id mh9-20020a17090b4ac900b0020d56c4a8b2mr5678536pjb.174.1665587911443;
        Wed, 12 Oct 2022 08:18:31 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id 77-20020a621450000000b0056281da3bcbsm11602144pfu.149.2022.10.12.08.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:18:30 -0700 (PDT)
Date:   Wed, 12 Oct 2022 22:18:28 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luna Jernberg <droidbittin@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Subject: Re: [Outreachy] internship contribution
Message-ID: <Y0baxKPxHp7UdYTi@danh.dev>
References: <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com>
 <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
 <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com>
 <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
 <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
 <xmqqleplmz3n.fsf@gitster.g>
 <Y0Zig4XUePPhMaA3@danh.dev>
 <CA+PPyiGPo1j-2MxTvmV2jDYNVFV1q8+7TVX1uoEUpWc0o+Rkdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PPyiGPo1j-2MxTvmV2jDYNVFV1q8+7TVX1uoEUpWc0o+Rkdw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-12 13:37:48+0300, NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com> wrote:
> I am using ubuntu(wsl)

Please reply inline or inter-leaved.

Perhaps this documentation can help you get started with building Git
from source. (I suspect you're missing something like libcurl
development files, too).

https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

-- 
Danh
