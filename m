Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8045C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D6560F01
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhHEBet (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhHEBes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:34:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62760C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:34:34 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y1so4741157iod.10
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=00UZMXUqFnSOV9QDJ4eyXRzAqUaB3zRj8ZhSEnP+IYo=;
        b=olqfLIN59DPJq3jD1HwqoLiUa9FoR7EIOF2QR+TTULFfCtQ7ENMSlFJTKTXsEySdUj
         4wQVKErAlwaM5qxB8YOujG0ULdjpb49o0PN8wKUpTX6xEJ2H6hvo09dMBAuO1gW5NY72
         SzlA/Ao5kWruKPPqEfSChXeDS6it7JrR1DwlFXAcLH9cDvXd9hfQlCP7RQS9xKBaOjZt
         RacqKoiSfyyFuZfVQJ51EWOFn8IBMCelVw2bmX18Z+HbzXbnVbQ6jUBRPjA+F+XVoJdP
         IL08DMcrfKYlFtejXYToGX8+6Mbwg6wqNleldtPEwb+7hcMKltnP/Lgp16iaCGhErs6N
         /XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=00UZMXUqFnSOV9QDJ4eyXRzAqUaB3zRj8ZhSEnP+IYo=;
        b=NsQ0MRlLKoz75TlDj8voN6ZrPVzDG42N6VJsaGoI4ZQrmYfA8HYh533l3f8S1XCkrD
         TVtQC69k2Sz3BHHVcPvCSAlVCDmgLdwygHEMmDnVdwpJoLo+iUN7F1TVbUlK+cTN5Dox
         mp42YSsCEvJ1x2Ov5h6GqoS9ImAQVbq9G11XTRW2lxYyy5OdnGzFqzVAZG0WcRB48bmP
         p84Hp+nlKJFmcjsQCNW8keyYVA0FNkPCbnKNCqA1wT/59VlNiIy9I8cPjZtFV8xpvFlF
         Ruyyifk6f8x/pF5+jmb5Q6Fedid1kiVKMS6sL65ww0Q78fhqs9GGNU4XDJsUKiEMEYRr
         EMKA==
X-Gm-Message-State: AOAM530CloUFINdFFi7fpFKIhXVrB6uIAgznHKdTJj8YRwY4clgtCWoS
        NCipDmRYeEJvdZeppdBZM08PNg==
X-Google-Smtp-Source: ABdhPJwoUjbtHCWDhl98Q7+vEzb96wLDfS8tnzo7ETZGEc2stOjnbghmg0Lfa8CiYZ8JZ+5IlKPtag==
X-Received: by 2002:a5d:9284:: with SMTP id s4mr183305iom.131.1628127273882;
        Wed, 04 Aug 2021 18:34:33 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:dd9c:1551:d5f7:652c])
        by smtp.gmail.com with ESMTPSA id l5sm2614039ion.44.2021.08.04.18.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:34:33 -0700 (PDT)
Date:   Wed, 4 Aug 2021 21:34:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     zegolem <zegolem1383@outlook.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] configure.ac: fix misspell in comments
Message-ID: <YQtAKABgIjyEs2yr@nand.local>
References: <HE1PR05MB3371C8B2A590C32E0FDD212DD3F29@HE1PR05MB3371.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <HE1PR05MB3371C8B2A590C32E0FDD212DD3F29@HE1PR05MB3371.eurprd05.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 05, 2021 at 02:03:47AM +0200, zegolem wrote:
> There are two places in the file where 'you are' was written as 'your
> are'.

Thanks; these both look obviously correct to me.

> Note: I didn't review the full file for other errors

I took a brief look. Those two are the only instances of 'your are'. I
looked through all uses of 'your' to make sure there weren't other
typos, and I couldn't find any either.

Thanks,
Taylor
