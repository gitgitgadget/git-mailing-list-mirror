Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AA7C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C080A2087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxIxJTpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgJLTlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgJLTlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:41:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A7AC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 12:41:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c20so3899508pfr.8
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qrbcQ/g91LkdSLDT9GILCLjTwsr+jSgpZiA/B+5cmF0=;
        b=YxIxJTpfBryGIXl0v+QNh+Gsu/E6Pg4JIOi9rb0kUgM24UdpZwfbKbaY0oAb4mWvv/
         yHq1OgJBg3m4byFQij0H3LNPjFnRbBRfwwjCdkm0N+ox/aj+WfdojFMIcnrS7WrxqnS+
         +yD/aZTr/1VH4yXSWE1qpp/Ng6faAzmPtaSOpHugaV7joSZhm7CQUoFioFpvWAdpC/tF
         pM09dsaXmaeIAoAkvwxrEaxOr45Kh3+UFKAvkpdx4m+6s49em58iw9BMQi0IFCIGW+js
         0du6XERzNvfY74W4nGXh5ON8/j2AF30JK0VIeakUga4o88qv58MhCT0ylgf4rtRCD+xX
         aVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qrbcQ/g91LkdSLDT9GILCLjTwsr+jSgpZiA/B+5cmF0=;
        b=OxVHsFWPjaskHtNrvIqgi7p1KLEiu8O2Uhwwy+uipeX3xV8Du2N1IsQ1+ImWuSuJWT
         4sOnJjOh3dSkwwAjXmKwoX+EsBHjWogIEJwA45r/Oe1DyAyHrWFOCa9mSZs42aGSIKu2
         kYhnyjDSekD5wE66hko2uQRewM0Ly2H9LcmZpGhf3pvrUIRlD2zQww/X9kFwMASnLQeY
         FwYosXS5zHWjMXVmNe9Bv70ISnqRf2h4fCjwv4TYO65+89aTxLsC/LiC5eLdbj7lhMxY
         twHistkTo3dv6C1qE1kPNtGTgVzKPv21cQXQYT/Gx+J/EBxOvHSQa1u7B/FU0QQciaBl
         11iQ==
X-Gm-Message-State: AOAM533QS5k7zWli3hDRlrfFwqK1q9z/fkDmtsVswdpKLmds9V8r0pZA
        KojjA2DVn7x4jfAPPOI3NTE=
X-Google-Smtp-Source: ABdhPJzj1R5wUji9a5fP0+RK/j2fEawkqt8/UgfzwU4nqEJ9F1vTUIJt2JF0hLmi6rqDEtZZKaAHYw==
X-Received: by 2002:a62:cd85:0:b029:152:6881:5e2c with SMTP id o127-20020a62cd850000b029015268815e2cmr24349717pfg.36.1602531684202;
        Mon, 12 Oct 2020 12:41:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id r23sm11438714pfr.62.2020.10.12.12.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:41:23 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:41:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
Message-ID: <20201012194121.GA3814681@google.com>
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
 <20201008014855.1416580-1-jonathantanmy@google.com>
 <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet>
 <20201012151919.GA3740546@google.com>
 <nycvar.QRO.7.76.6.2010122035330.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010122035330.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

>                                                          Of course, at
> this stage I understand that my feedback is not very welcome,

Do you mean because you don't feel that your feedback has been
sufficiently acted upon, or is there something else you are alluding
to?

Puzzled,
Jonathan
