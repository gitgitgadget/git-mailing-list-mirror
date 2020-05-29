Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A757AC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D90E204EF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRcylUFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgE2TU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2TU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 15:20:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC845C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 12:20:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h95so992248pje.4
        for <git@vger.kernel.org>; Fri, 29 May 2020 12:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=goFDEKIEeWfBmNKQMCwQrTOYy0H1Jsv9j2e2o+jwKbA=;
        b=fRcylUFjXtyh0usPCYe0qW9RtLj5CFiTnjznPzjqCzsb3KHT+8n7nXo8YG3KqtdAnY
         KyFOaOX8iEMR9LVToCATlenJliNyRHovqRinTfd6a5/+VMPAsdshx402o4B7w9qhFyAU
         1stfyeIHZkoNAVTeSjTY+4qWs9Sr/1M6Ey8spQgfO+ObEk3UEEAEYtwg1wK/zw4HFDt+
         Zr49lmvrlAZZF7eJtuuuZmiQz77dg4HaEnLTin1CdQnh5wvGVvXw6uB074US6N4N123O
         7HSYCAbRXeCOwX6GNMxEuTBgmvuB4KzVfxlWCOzltsDMOa+mKwBE0YpR6Awcx7gr4q1Y
         Y/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=goFDEKIEeWfBmNKQMCwQrTOYy0H1Jsv9j2e2o+jwKbA=;
        b=PdvjWp3C/kx29pcV4SW48rA3gMP4ikmyB4GR5D33xj7gIZ3WtyiIz0U7iEZywj/pVO
         B7c7s3u3ojQ3U4B9CNcJgcw58HzswhyDVUSWWM88QUQ5sZ9WBELdbFBBr+Z90EeYaWai
         QQdlYs1/0Kh2ugrhBudM/LYwHlUab3Msg1JswJ3148Pggzy1+g3qRoa+Fp6/vjI1n3u5
         Kz4CcbUjwUKE5l6tMV4hLLcrANvz60kl9APqrc9LlxwGm332fBThItiqqI+R8QBvIu1M
         qpgOGMYASBFYjq1ai0LEFipQcs3J26VAfFuE/+yYOcSWYmz9bORgPXQ1HwPGaC2sSagL
         Qmxg==
X-Gm-Message-State: AOAM533Rz/wqkX7C4+tAabSbyWMxYgQjpJVI6JEYjpxr/IwVXi5DvLvi
        PmhEYhS32fZw0KDB9ptIydw=
X-Google-Smtp-Source: ABdhPJwVA36PD32SivebL6j0XJCiSGKRKJU0YskXl7RgvMG1iWg3jxRXB+T3F/7aD9TaWNKVzF9SvA==
X-Received: by 2002:a17:902:b781:: with SMTP id e1mr6920763pls.152.1590780026232;
        Fri, 29 May 2020 12:20:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i22sm4984447pfo.92.2020.05.29.12.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:20:25 -0700 (PDT)
Date:   Fri, 29 May 2020 12:20:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Joseph Smidt <josephsmidt@gmail.com>,
        Anders Kaseorg <andersk@mit.edu>
Subject: Re: Git fetches whole repository and not just latest
Message-ID: <20200529192023.GC123244@google.com>
References: <CAHp75Ves8x9_1=fVo_+dB92GpAGLcbGVqeo2gjRbBnzTzM0uzg@mail.gmail.com>
 <20200529172955.GA123244@google.com>
 <CAHp75VdTX=pJw6r=H=qfaDcv07n69uGQQ0TwrR0bACAx-OQAXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdTX=pJw6r=H=qfaDcv07n69uGQQ0TwrR0bACAx-OQAXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 8:29 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> What Git version are you using?
>
> git version 2.26.2

Thanks, makes sense.

>>  Can you test 2.27.0-rc2?
>
> Is there any deb package?

Yes, you can use the package from Debian unstable or experimental
(https://tracker.debian.org/pkg/git).

If you're on Ubuntu, you can use
https://launchpad.net/~git-core/+archive/ubuntu/candidate once it
updates (cc-ing the maintainers of the PPA in case they want to
comment on when that will be --- e.g. Git 2.27 is planned to come
out this Monday).

Thanks,
Jonathan
