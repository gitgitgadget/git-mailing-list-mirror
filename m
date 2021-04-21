Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3AC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9866144C
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244369AbhDUQol (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244388AbhDUQog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 12:44:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D360C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 09:44:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c15so33094619wro.13
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wBDCKKuEwSH//D6xAhpbQPFCTjVzhVm9Mk0b5H3rzPQ=;
        b=ahg7hpRFsOezey06lp68mW1Q40TaEByOQ31Kd0BNbgJx2N+Is77biInf9MNPbWp5yn
         y7wFSPhRorTDp9IGKkLN2YbPtcgZ34qZq3JF6x3fWqfrCem8aVmhWTC17e2EieO897uH
         kQJrLNHopk3EGlYPomlZY4Va/px8c9hzGES7P2DSixFMi3bIXVLh4V1QhLrJQuY16Cra
         EAQpQb3wX3eVOy8loDA8u4pv0EWCSe4Boi8EjUBQY6LUM0lzrMlxuWM+oFrxTH7bFSOl
         v3TXTWprAxsstzcc3FsJc2ksArs3JXQnUsCss4lQCkymvFqlvnTcikeu0ImbTWI2TG4C
         OGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wBDCKKuEwSH//D6xAhpbQPFCTjVzhVm9Mk0b5H3rzPQ=;
        b=MCIi/YCeflbyPthPZHT341WcUnNanI9EjNLNFml9fny02sU5geYTEPsGKr02dvd87v
         9vEvJe1+pLG94a4sdyMVu4HPxwaAO/GkL9JwAuvdU3KoEy2374yHXBQBz+qIPfp/aw0T
         BRuQ3g5AsqEQ8heEOF2IgaBNmtOtUYYe6R8KIBD5Yb/Qvw6PxEzMJNzGfNgj34SYila1
         QTS3qc6GDF9w2gCEXKEIYojuZ/09vF80cbrwHQneC2ZQk4Hd7Sy8FyjxXhiqlSByF78G
         StOwGzM8QY1xSJiPd64Vnzwc29qsTv+rtbUFpPuvnIp88FZs/wRiux9mEaDJV1fqvGmk
         PoPw==
X-Gm-Message-State: AOAM531SV1ti8b30SMzq2sWKoUEvK/7x+SSMN+S1sRtxYrWvf8/sHV+r
        n4PqgG7vjla1a76yUXEJATY=
X-Google-Smtp-Source: ABdhPJy5wgCn/09IJksu67iat6dkOCIAFDx9ycnPIGDobxOOFN8BIbSOl9ta605sDgeniNLalIfPnA==
X-Received: by 2002:a5d:4a48:: with SMTP id v8mr28302421wrs.204.1619023440231;
        Wed, 21 Apr 2021 09:44:00 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id t20sm2680378wmi.35.2021.04.21.09.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:43:59 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:43:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v4 11/11] test-lib: split up and deprecate
 test_create_repo()
Message-ID: <20210421164357.GZ2947267@szeder.dev>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
 <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
 <patch-11.11-311a9dba36-20210421T101156Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-11.11-311a9dba36-20210421T101156Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 12:15:16PM +0200, Ævar Arnfjörð Bjarmason wrote:
>  5. Since we don't need to move the .git/hooks directory we don't need

Again: Since we don't need to change directories....

>     the subshell here either.
> 
>     See 0d314ce834 for when the subshell use got introduced for the
>     convenience of not having to "cd" back and forth while setting up
>     the hooks.

I think this is worse and even more misleading than even v2 was, for
the reasons I mentioned earlier.

