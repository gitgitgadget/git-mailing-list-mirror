Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54297C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhLHRKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhLHRKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 12:10:09 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87CC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 09:06:37 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e7-20020aa798c7000000b004a254db7946so1901396pfm.17
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hg4ZyqoQunDIIJBZyGoY28Nw1U21a4wcdfq1WEHHX60=;
        b=gD/pmlZHZu6p9h7lN74LjgvKqS3oAiEXqs7tsKFyMeZv7dnAISyePFj6o2L4Hg2lDf
         GN5CaCKtX3cVG9xXsg+A5QEeqosPPme2kAmwRfFRT+jdhfZ7CaNasszsHhqBn92xyqoW
         TpNAjZsIbqNQQxWsZlx+OMrkgtojsqQQ+sDZouIJMf5xC2+vage0o7X1U2TSH509zts3
         wjPE7e5U+UaSDQKRjLu01NOiyCpoC29ey0CO3HcdbCepnOYvDhdtymnJv2BsVuIowHB2
         cGzbrCuAgE4Q2P15qyEZvSlMa7Sf1k2W8lov7ziVt3aK0gslDYUXUSAAyjc4v5lMcW9I
         rhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hg4ZyqoQunDIIJBZyGoY28Nw1U21a4wcdfq1WEHHX60=;
        b=mLqCNvAZFBI/Dhw3e0cnl58w2GoAjJhsCerj7kjZh2PnDCaJGjd+PmB4hioGN5pDW/
         KzfcjLFoz6DTmA3piELfTov/nPLUgCtdcVp99X4ylqvPddxdRwD1IDAOzanffjFvBkco
         B3G/7F7B/buq5H/rIeERfdCPZ618iL2RNcL+97vyNN7XYxqRf2+raYrc61i9VbbKKNXb
         BdSdY818uqhtE7qEwDKbxM3mTESDPvlyyXxEgGjMa2JCGEOZQ5ZGUWwyb7aKUhmPZr7z
         8REwsrY7eEDaitUDsVwesWA/sroDuBKtKT7yjbpV14K2P8ZAgdvjwhBYjAFfpNySF2Ml
         MvQg==
X-Gm-Message-State: AOAM5316+zunp40hbW6YkerQdZSRSZqgUVbwyNGBdLY98SsGjPv3cGIZ
        gSq7+maKRSaSOIibYprC8AU3YeckRgUEHQ==
X-Google-Smtp-Source: ABdhPJwdkABt8OTNQBIyfpUQHpn8SsQ3dW51QBLgWEKiJfnlZcVSfQwygFBVJZvkXqsfPboKc2yBH676tphb2w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4f86:: with SMTP id
 qe6mr8738490pjb.224.1638983196726; Wed, 08 Dec 2021 09:06:36 -0800 (PST)
Date:   Wed, 08 Dec 2021 09:06:36 -0800
In-Reply-To: <xmqq4k7k8cz3.fsf@gitster.g>
Message-Id: <kl6lbl1rauw3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <xmqq4k7k8cz3.fsf@gitster.g>
Subject: Re: [PATCH v5 0/2] branch: inherit tracking configs
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Can you two work out the preferred plan, taking relative importance,
> priority, and difficulty between the topics into account, and report
> to us how you want to proceed and why you chose the route once you
> are done?
>
> Unless the plan you two come up with is outrageously bad, such a
> decision by stakeholders would be far more acceptable by the
> community than going by my gut feeling.  In short, I'd prefer
> decentralization ;-)
>
> Having said that, I think this one is a simpler topic that is closer
> to become stable enough than the other one, so it could be that the
> rebases want to go the other direction.

Josh and I have discussed this, and yes, we agree with your assessment.

Rebasing my changes on top of this is also easier from a dependency
perspective because this series has a very obvious interface that I can
use.

I'll send a re-roll soon. Thanks!
