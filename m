Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAEFC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059CA60F01
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 21:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhHCVAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 17:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhHCVAM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 17:00:12 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A2C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 14:00:01 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s184so19575ios.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QoUprqWIXEo3jcapCLhlfaXT8fNHXJohRKnYdHhdYFA=;
        b=l+0taKCB5daG0YUTvlY1qJsZfkvETeRCMCW2EGcO0rgux9lwfNbWGArDvzyYSTbso9
         ATeq8gbqf9Alk/kqFv0burdkdWC19/G212/GKqmxygCPV4NIzBPmzz/J++B9rCxReGmc
         2TtJubAad5Jbj3OSHM0HaA6J2xYDAgvojLxKK7Nf6yVJOjm0KwHDGyMoofNpVeiW6Ku0
         GY1MQzXCLmsDk2gqSU2rJft5AIFcgZ5hSpMLKxLfmh6jBaQcvaponwjLXP4mfNrYMoPA
         eex5qKvmIB6t44SkKRyT33UqvkrlCsciBTNrFiMEI9iQaglOyNX+moJkNwyjC3WS950z
         E9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QoUprqWIXEo3jcapCLhlfaXT8fNHXJohRKnYdHhdYFA=;
        b=kPJ7EY97FVlYZZx++HNHj7sG51MRCo0t3GUTmj7EMEuTiCzd1GJ7/m4STtBxuVavEQ
         RzZQegfcxo5znkJxOPQIlPgbqy7wBHBOvqBPp67+jPEWV90/+MYpjmXCs0Svc3Md6nfJ
         F8N5yq4aHUVYxzjyQvJ/lz67m4QpmnYtvwBFI43YiywuyKm8gaEKUhm7hPAmVHeHoMGL
         AwMXlqr7OjBLg91ZLpZLS4mwXEmthgtyr2pLV7HLwF618lC0f8ah4Vey3fGUg6QxPcEi
         Cy/DWeDhGUlJQKWQVxuEl61wIvGxTbWl8nqgyudOqYmqY4v0kbJ9G6ZF571DdA17+RSy
         FChw==
X-Gm-Message-State: AOAM5330z103D8zZO9wUmwPKRdiiBJW3wjjxJ2UIJCgCiNtAZDYVYF9e
        J+lDXxQdKOid7sV1IvEWZY5/uQ==
X-Google-Smtp-Source: ABdhPJyVCEEXa3MPwfgGw5RvDJDpNf1roO2rNOAs604bUQZ7EJtEILHlxKTLNiACJfCGLIjEa9VpzA==
X-Received: by 2002:a5d:93d1:: with SMTP id j17mr619803ioo.123.1628024400869;
        Tue, 03 Aug 2021 14:00:00 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a92c:44a1:9adc:e4de])
        by smtp.gmail.com with ESMTPSA id a11sm21044ilf.79.2021.08.03.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 14:00:00 -0700 (PDT)
Date:   Tue, 3 Aug 2021 16:59:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Cameron Steffen <cam.steffen94@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: git revert --continue --no-verify
Message-ID: <YQmuT2ZYe1mzHBjI@nand.local>
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
 <YQmsJUe6hAMy/QGA@nand.local>
 <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 03:56:49PM -0500, Cameron Steffen wrote:
> `--no-verify` is an argument typically used with `git commit` in order
> to skip the pre-commit hook. Since the pre-commit hook also runs on
> `git revert --continue`, I expected to be able to use `--no-verify`.

No, `git revert` doesn't pass unknown options down to `git commit`.

Thanks,
Taylor
