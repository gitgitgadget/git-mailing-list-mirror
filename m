Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23AFC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 14:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1C821D7D
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 14:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry+Sl6UQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgIIOIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbgIINLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 09:11:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D77C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 06:10:56 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id h11so2215994ilj.11
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OMMMZecsAK4HDCcQxtqOZljGpLcKSWcZwAg4ZYq8qE=;
        b=Ry+Sl6UQ8DZXr82ezvWd+GcQlIdXN/1mxlFK4J0ChHKPMUlYjjgNdy2nwL1tLje/+f
         HrOrocVvCGo2vHYaTWPiaqQIY4fwgs3NEN245LQFLDxv9/tioOP/jDkG9DcxT3TCoq1n
         ji5yvHe3BUnBZcEnUw3E1jADu812ks1hnVqHZbsvaCZFDGyohyNrTBVSuyt3GrZBgTpO
         JCf2VFz+zgD1j+HXqH4XGHt5xk2XjKjTQodlKef74LQg2DAWe1jUtmjO0p2ULQnYVxD9
         E+DkGvx+3bJuwoWy9fo4DDr58Ww/cLHbPVUBsNrTI5T284eVo1GOUCjVCPI2qLNIEb6J
         bkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OMMMZecsAK4HDCcQxtqOZljGpLcKSWcZwAg4ZYq8qE=;
        b=cIwwm91kgVi6er0/MdgSuhed8ja6+crrSKYAz4YGCAA43uofPk7YPgzYI+wznIrsRd
         w+j0NwmjnKY8Uqkbc8f05M2j8nBd869WR4gpUkk02rHgM5zG/U6vN1ORE3D3AZMl3mfm
         gRJlKbT4RcNggtRTIN/WMdrO/xz8Ca/739+bCSs1N+BIRnCqNB1WcG5CW8gNduPFYo9W
         e9tW+N17TP0StzlKmz3H91LGdBuyvAjk7OBIBrDFkkrb9QUQYIMpBXv6ppXSn+PMhRFq
         NnyZKSTjJlAHC5AOZY3Y1jfO/qScm38u+2Gl1JF/7ZgLpYm7rbaI45oyyNEtLZ3OkqDj
         2aYw==
X-Gm-Message-State: AOAM533ZCuEENySZGm0zrc83ihie/vdTXudf6iubv92N19BCEX1p6o7F
        zPsSxg89K7Z6rRoy899e0UWljCoGhIyOXPUtdRM=
X-Google-Smtp-Source: ABdhPJwhhS/Zz++oUMGQV5rjVAObCDHXWEpwE2BXBFHnxp01hjkOMvkP+axYDLmbaYuO77QYDu8KFcbSN//gUtvsqYg=
X-Received: by 2002:a05:6e02:60c:: with SMTP id t12mr3623203ils.200.1599657055547;
 Wed, 09 Sep 2020 06:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200908211053.807194-1-eantoranz@gmail.com> <6b84f112-7e3f-3a78-3766-033fcf494464@gmail.com>
In-Reply-To: <6b84f112-7e3f-3a78-3766-033fcf494464@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 9 Sep 2020 07:10:44 -0600
Message-ID: <CAOc6etbvaWQA9WWofRNPP7Yh5iq80sj5n27AGhtsYvOGOKtWDw@mail.gmail.com>
Subject: Re: [PATCH v2] blame.c: replace instance of !oidcmp for oideq
To:     Derrick Stolee <stolee@gmail.com>
Cc:     dstolee@microsoft.com, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 9, 2020 at 6:39 AM Derrick Stolee <stolee@gmail.com> wrote:
> Short-OIDs on their own are not enough. Please use the
> format "abbreviated hash (subject, date)" as mentioned
> in my earlier reply:
>

You got it. Thanks!
