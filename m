Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0743C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B521610A1
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhEFP7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbhEFP7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:59:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D237C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:58:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so3696651pjd.4
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jJES7TxpUn5FN6DFKSfSNKOU7LwOxnV5u9jEo5qdUzo=;
        b=XCA0ieQsXN+M941tO13WCMrsQB/bUKM/O54AlQ7TwRJY7qiX3DkUQV+P9brK8vkRv2
         bwDxdJFJ4O8KO6t2AuJ+ra0pWfoYLChgWzmyfBYuhLvjlLynhmt8eKx1hg6cWxWv6wE/
         MdHn5B2l/YroYqHL3wgQ3OLoyYczrsqg5to7OFLwZGcq1Nvk9uNP+Df+ALExOw2pdzZj
         eYJKKWZsZfJBeXIePqsVELbIe3J/BPGKZUA0H4HWKlugaMP9LqFBOkC6CKL1z0pa3rGo
         PveqgkKY8tCXaAoOCEWWdVgjHJYAa8NKJ5Bb/xbF4RkG+haGNqjy8zS20ugESXmicqqM
         tIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jJES7TxpUn5FN6DFKSfSNKOU7LwOxnV5u9jEo5qdUzo=;
        b=g4zE3vtB0d9zfnlCT3NmWw2N+7cpPixLyQY29C6Oiou7oCvYU5Lke0AlL/t2VcLaS6
         +D4q/bsvfiPN9A++IK5jPKA8y482FziRuo8BZTknLhPOCGZs0urQArGzc5GwY3ePGr5y
         /hHRZYJ4aogS0WGJE55hBA+mVLF5UOdginvWI9d+NSXhYMxIcHR0oZOuJ6faQQ6Ts+EC
         BhFoqNWzPILRzuv9X4evWo5j8wZJyHfJLjHINxAzFv1LH2phfv/SONYZL0kXWJwejJkf
         ZiXQsYLv4MyjHomf21tXStyxdIF9/oAfjC1ne12RBmX6x/5XL/l1ig+kPDLHYD5SRl+I
         rRIw==
X-Gm-Message-State: AOAM532OXoM9zJmy++NHi6Maww3bz/QpY4HojwHLRe3SnxsvyEKIUGDa
        2oGyJE29ssVCY311Qr1dePw=
X-Google-Smtp-Source: ABdhPJx8WkI7BEcEwcHxkDWmU+K/mQvo3FyGTMwxmoBxiVZmnJ/zkDrAwob91S1sPGSHyiu6xSUY/w==
X-Received: by 2002:a17:902:8307:b029:ec:86a4:90fa with SMTP id bd7-20020a1709028307b02900ec86a490famr5325045plb.22.1620316682693;
        Thu, 06 May 2021 08:58:02 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id ne20sm2442279pjb.52.2021.05.06.08.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:58:02 -0700 (PDT)
Date:   Thu, 6 May 2021 22:58:00 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v5 06/11] describe tests: convert setup to use test_commit
Message-ID: <YJQSCKlS5bZixZ5z@danh.dev>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
 <patch-06.11-589eaf7a078-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-06.11-589eaf7a078-20210423T072006Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-23 09:21:10+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Convert the setup of the describe tests to use test_commit when
> possible. This makes use of the new --annotated-tag option to

s/--annotated-tag/--annotate/

Otherwise, looks correct.

> test_commit.
> 
> Some of the setup here could simply be removed since the data being
> created wasn't important to any of the subsequent tests, so I've done
> so. E.g. assigning to the "one" variable was always useless, and just
> checking that we can describe HEAD after the first commit wasn't
> useful.
> 
> In the case of the "two" variable we could instead use the tag we just
> created. See 5312ab11fbf (Add describe test., 2007-01-13) for the
> initial version of this code. There's other cases here like redundant
> "test_tick" invocations, or the simplification of not echoing "X" to a
> file we're about to tag as "x", now we just use "x" in both cases.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

-- 
Danh
