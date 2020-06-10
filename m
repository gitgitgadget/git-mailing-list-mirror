Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E62C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 03:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385F92076A
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 03:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJKa7VZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgFJDsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJDsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 23:48:05 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D63C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 20:48:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b27so818526qka.4
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 20:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kK8dmYiOfhZoA7JW3heGry92TNQXbubH4jNfHkLlhyg=;
        b=BJKa7VZmihuIjz9YKv68qojBeMo7IGrlArkvi0zE+1K51n1+pEW+tiCfoiT0XWn7vi
         zc3l/wq+/Otp4wnlyg393A/1kEOlNhI6g7qwYCuvuyOlINN0BgiYRRsWNH62DPulHOlo
         FCQW+79LfGZSYOzsduWB4evcqvGB2FkTZc7/CB2tDOuQQ5hVQVzTWFrt1BBV4n5Yb5vN
         DqO4CNVdPADv3LCyW3snzdFx6WhSpCFZk9vEmkvlDl4RpmgbGJ33BhTrsmDKzEYixVY/
         fsil8WLOfMpkhOeNilmyNpmggXeOxjaFVjpQMsYVqaLvzGhoDGPSoevXuX5Rf3n/R6C4
         c1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kK8dmYiOfhZoA7JW3heGry92TNQXbubH4jNfHkLlhyg=;
        b=dyNKsmlAtj5CazFBdOTSkRb94HAmEJQ4daPa01Z8ara9tG02dRW92ZKhdmIaPdpSGP
         PkBdXQ//I3/3E0QUrbfkrhOfwQDqfzfNEA9/rRSN4zrLtWfU6yyNR7Chk+bImQw3QMoQ
         MFruHREGbrb0l9CgqUSkFuTx1jwQCm/QJMEp4u0A8efHaxyq9cbvi9V9oRB/UKRa0sW8
         MDsqXDFEWahroLqAXd2OjCpuHdnYHIvgkjoFd0VNKJ+sNZl8LenBDPdUsnq0PoEdxRTj
         eZCb19rbNzKVM2Begemp1laqhM8h63eAeeVULsFUym8zmGKt9PsYccfLqDOErvDlFXqa
         H5Dw==
X-Gm-Message-State: AOAM531QcriikefVOfY+NPPFXXYCaok74iWoxVt0fuKRP9+E2I363XfK
        NuR5ej9P3EqF4Dz0LRg87pYptSaA
X-Google-Smtp-Source: ABdhPJyjT2XfTYRGcZ3q9D+jkhhIgoKGuq3cmNNlA5AYo0hKYoVUqIh0iPyFLUEHQtZcdT8c+Ardcg==
X-Received: by 2002:a37:e107:: with SMTP id c7mr1073221qkm.483.1591760882973;
        Tue, 09 Jun 2020 20:48:02 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id r5sm12777585qtc.40.2020.06.09.20.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 20:48:02 -0700 (PDT)
Date:   Tue, 9 Jun 2020 23:47:59 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] gc: recommend `git gc --prune=now` instead of `git
 prune`
Message-ID: <20200610034759.GA18542@generichostname>
References: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
 <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com>
 <87bllsa47u.fsf@evledraar.gmail.com>
 <xmqqa71ci5vd.fsf@gitster.c.googlers.com>
 <CAKO26MuO6UR8c5U+WX0ayEJjmXEnsp9P=ujZGwasM7KbrUgcRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKO26MuO6UR8c5U+WX0ayEJjmXEnsp9P=ujZGwasM7KbrUgcRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 11:43:09AM +0800, 林自均 wrote:
> Hi all,
> 
> Thank you Bjarmason & Junio. If Denton doesn't have other concerns,
> I'll start working on adding bash completion for "git prune".

No concerns. Thanks for contributing!
