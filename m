Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF947C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12B061157
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhDSLY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238449AbhDSLX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:23:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A17C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:23:27 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v72so17577155ybe.11
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NV1lmtqCpiu8LWf/o0Rszl8x08O7FDJOiwnKhFgX4SQ=;
        b=oQwkQC9EPBMR7EyKKXyBMtVRlfmbin0zuLhhDyzLZQz+XMOyCHtAfHvTEcA48Xz7fk
         N8WES2TRc7gwRKz7phLCA+dGBsHIrWxrmNq3h60YdxZ8ij53Yv7FfWUC/IcrTjE0hlCf
         CTSWYVomVOnoRkVkJRihDeqL6WgVS6KYdIP3rulkhUq1zSpUcq6EtQ71sUo1RyIP3QdR
         Nau9+5biyXzt0B3luoliQk71y1hxKjWY+Ws/+fgLBy7vWWimsLfSLwB2CfqG9J5cIFEe
         NFiB4cSulLLUKlxeEJpmkY23HlPcT2u6Zt4wk6XxEwBuaRDxCYxZ/qZr5ZOkP7gGZKfT
         TUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NV1lmtqCpiu8LWf/o0Rszl8x08O7FDJOiwnKhFgX4SQ=;
        b=XlsIJ40C5pfsZ1vQzyMVpdLxVEGWano1XCicbq4ej/8Xqdlgrksvilu7rpqQ7jgabO
         hF3k/YVvf31kWbLaC2gIq+8/dFn8AdEGKF6Tn6DOxjafV4CWLGWU6vRzCVN8pA1UDoGU
         jEEs/D95lf0pRKEQUtB7ti+ZOCx+ccGWaYyn/r8qM1UJVdrttuBm2Phlo3qmEUn6Q091
         kznbHgG779rCpJkmRxk1apV6xzqtDPysJ0B15A4U1thM5XiQD9iDEtLee4KmKBkFNxCc
         cxeOTJMZ/9tqWeFP0ccE7xAFFiqszBewNvJlwnrOMrbutw7pOYfiK7TsaCkyXDv89Qjg
         8BSQ==
X-Gm-Message-State: AOAM531Vn2Z1ozGq/zdhj6e1Vr+8BcV/PpyAA7PnQhvDK6UQMBBbpiq/
        mfYSBXt3j+khNkGsDcpG9CwVrAtzweWkJ02e3X5AT/67SQmMVQ==
X-Google-Smtp-Source: ABdhPJzwaZGyO2ig/PcUmXL9Y51tbEkQ/buSvT9EVMsmsd3LDzDvtMOqA0/gd1OIc5pb16rw6mOid+TERpf9itIP8oo=
X-Received: by 2002:a25:ab88:: with SMTP id v8mr15620421ybi.500.1618831406281;
 Mon, 19 Apr 2021 04:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
 <a6a5bb81-9a86-8901-31dd-dc9c09da0a23@gmail.com>
In-Reply-To: <a6a5bb81-9a86-8901-31dd-dc9c09da0a23@gmail.com>
From:   Cristian Morales Vega <christian.morales.vega@gmail.com>
Date:   Mon, 19 Apr 2021 12:23:14 +0100
Message-ID: <CAOWQn3Qa68aWH8ztGAej=ctJDw4dkzuPQkkqo6Ydvn=13hV1vw@mail.gmail.com>
Subject: Re: git checkout behaviour when only ctime of file changes
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 19 Apr 2021 at 12:10, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 19/04/21 16.11, Cristian Morales Vega wrote:
> > Basically after something updates the ctime of a file, a
> > "git checkout" can behave differently depending on whether a
> > "git update-index --refresh" has been run before or not.
> > _Maybe_ it could make sense for "git checkout" to always behave as if
> > "git update-index --refresh" had been run before? No idea really.
> I know that setting SELinux label can alter file ctime, but when
> I need to write the test that simulate file ctime update, do you
> know which Unix command can trigger that, beside SELinux tools?

I am no expert on SELinux and I'm not sure I understand the question.
I know "chcon", from coreutils, can do the SELinux labeling/ctime
update. You could use that when writing a test. There is an example on
the fifth comment of JENKINS-65395.
I know "docker run --volume <host-dir>:<container-dir>:rw,z" will do
the same, at least if SELinux is enabled. Which is what triggers
JENKINS-65395.
Don't really know a lot more.
