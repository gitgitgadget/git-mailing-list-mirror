Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526D1C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 13:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CC920716
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 13:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM7lsbgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgC1NZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:25:49 -0400
Received: from mail-vk1-f174.google.com ([209.85.221.174]:40691 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1NZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 09:25:48 -0400
Received: by mail-vk1-f174.google.com with SMTP id k63so3442898vka.7
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJUchqTemVOl/9JLThZLeTsDl66yjDJ90D4PODt/f3Y=;
        b=lM7lsbgTnnlyUNlsbgewMGMTIoHxKPF8eLIEjb/NaVzWh5s2P5nRmn0CDzn6X1ERVX
         IevmghPCVvgLcjblGdCUq6McV8ufIySw0fszv56W5ihuEEiYrs4TjQipSIgAJ66soHaT
         mAbA5Yb+KJTej+0K0zOEgh9mTaErqK5EHLa590WpUW2/pGLrAlNWoir9TxqsIQEmG0L4
         qyicfTb+S5MZWzHN8JtaVlC1HooKvEl33dvj6imU2OvnLI8ernw00oxgechfsJePDPBW
         V/2B28PacGdhIaOkLDxcxkgXU55XjgHzePCewiLBF2oeXRcXW6PSnnueGoc7neXGdEOu
         J9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJUchqTemVOl/9JLThZLeTsDl66yjDJ90D4PODt/f3Y=;
        b=rKnNGJr3szD62TLp1nfxg1Tmeds2mkYhztaCD22wV4JYJZTPeCFE33mrq5qGAH554K
         J001soxu+uOU2zraQoBmpd4gOFDkfT+kFLmOo/s85fBDrCVlhtnpqwryilN8APfQIWoQ
         sqboVGhs/LW3y7adMRBmPUY57E9utikcObnb3Y8NSWxFr+4NwqVfmkoFQPER5xlj5C25
         53vAkJP4gMAM9VY8Le/TlZL5gP26JY/q6YdciG1zc2zt4ExiLwGQl5EODndkMRI3Y5gA
         AQJdibirRkqMUuR1hJKCwbztm+MjkR/bZerVJoTsOLaCFgX1+qsdVaqqn7bmcNlRURGc
         pM2w==
X-Gm-Message-State: AGi0PuYGeKsO/zSFGE28Mh9z614MgHqsytu0thqxjdq5E63AfO3qQmJU
        U0GyWK3sQUcX7JeDyy2o+5DN+J2iWS+wymKNesEdUkUq
X-Google-Smtp-Source: APiQypLrEXeVkXKpShxy5wcH5zU7vlYaJAtyKEytvcDz93qoCvLZiat3oRkCqgCYDAKUIjs/Y4P8nJ3ldjBtbm/TON8=
X-Received: by 2002:a1f:9d16:: with SMTP id g22mr2192621vke.22.1585401945618;
 Sat, 28 Mar 2020 06:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP44s2XuXrgBztke50YgnZ1SQh6gvR6cdLz064xDDK3+s2CSA@mail.gmail.com>
In-Reply-To: <CAMP44s2XuXrgBztke50YgnZ1SQh6gvR6cdLz064xDDK3+s2CSA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 28 Mar 2020 07:25:34 -0600
Message-ID: <CAMP44s1oKq3hf+dRyQjc+yOs3xesq5qn5UaJJ_0i-KYrXCeodg@mail.gmail.com>
Subject: Re: Regression in git ls-files, or bug in completion?
To:     Git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 5:39 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> I noticed a possible regression caused by commit b9670c1f5e (dir: fix
> checks on common prefix directory).

> Before it was "empty", now it is "./".

I guess you don't care about this regression.

-- 
Felipe Contreras
