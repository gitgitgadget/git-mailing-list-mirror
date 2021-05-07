Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B10C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785156112F
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhEGEJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGEJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:09:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E77BC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 21:08:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id k25so7593443oic.4
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IYXAqjrVjeHK69n0PO0dKYVWAMCXPF4ez+ay/ezdHU=;
        b=nA0SEgiG7ypjE3ZunjhSSOpI1xPx2E0/MiFEmJnLC+oXW/vgjkL6Y76KpRFOwc7Mp0
         tTZadAh8wfsYbfM/MihVDtOZzWopa+Bymsv9ytx0dNJRBYHc/BuOfr9fAK/A6EjtLljo
         kc0UnA5ylhNW7l75VxNqLtmUt805iI2/gSAlSLJJbgfnf0HnqYGgzlZMsymFL7it8Ap5
         KdJ3/tJRv7XZqyDcmy9vtwk4j4i0/dLlu489aI2VHAijdOMz/189ObK5MIRbo/ZUHCw4
         X+2MqjStXvzK73A5A5Y3mK1n4NGZqpOycwwjS0rro4UXW49fuXXnzw600rzVxT9q9KOS
         Gujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IYXAqjrVjeHK69n0PO0dKYVWAMCXPF4ez+ay/ezdHU=;
        b=chs1dy5J/3P9myVF1SlkYOJMFDdCpILTAVhG/S/UgEFEJgf7FSGGx6w3a6UutqX5EV
         devryBe6B/EOv/HYtKiUTHVvuqiN3JICecL3ewCCUiV290c8thDlM3LVVC2H7Wn+BK46
         wqs5B6qRQAfBxsh48UyhuhO9o+62trePDxlp/NP1PAxBEEnr8MmZv/6S3NgCwyjdnEdC
         2uhtQ1ZlS2DHOK9WEPk1GOsagHnNZiJTQz7YF+a7NctMiuxL/NQfj5kg7OFeP5u+8J/e
         hTSX0MDTcfNnUtVvXYw/xaihTI1rMU4joO2MaRz6nObvRd14xEYyoqtQqkh3P9TfCmsn
         WVLQ==
X-Gm-Message-State: AOAM5324BaWIse8WhnEqi76S8MoqpOrl5SOztbE2KuOgmgswOdMBQoN+
        RbytEaP17Av0HELk150W6GF4rJAd2YZ8noo16Jw=
X-Google-Smtp-Source: ABdhPJxtCrUPcmPABRcO+6JuhnZFy5iq6bqp44c9K/SpJ68EE/9diWgoeVnCjzf3jkUNtm/NHu/ZbmQ3OmPgVk1yx30=
X-Received: by 2002:aca:6701:: with SMTP id z1mr12842672oix.167.1620360511404;
 Thu, 06 May 2021 21:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
 <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net> <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
 <MN2PR00MB068886B8F36DFC645138DA0489469@MN2PR00MB0688.namprd00.prod.outlook.com>
In-Reply-To: <MN2PR00MB068886B8F36DFC645138DA0489469@MN2PR00MB0688.namprd00.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 May 2021 21:08:20 -0700
Message-ID: <CABPp-BFWunQjgUHKuJBHatNfxdukL=EHGMiS3Tax3wW=eFSHXg@mail.gmail.com>
Subject: Re: Git clean enumerates ignored directories (since 2.27)
To:     Jason Gore <Jason.Gore@microsoft.com>
Cc:     "peff@peff.net" <peff@peff.net>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 22, 2021 at 10:18 AM Jason Gore <Jason.Gore@microsoft.com> wrote:
>
> Sorry to add noise to this thread but since the github issue was closed I wanted to make sure I'm not missing any updates here. Would any updates come through on this thread? Thanks!

I have posted some proposed fixes at
https://lore.kernel.org/git/pull.1020.git.git.1620360300.gitgitgadget@gmail.com/T/#t
(particularly patches 1 & 3); feel free to watch there, or over at
https://github.com/git/git/pull/1020.
