Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2977EC433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C333264FEE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhCKPYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhCKPYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 10:24:48 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8FC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:24:48 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id y131so20618652oia.8
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4Oy28Lf2WkPvsuTfm0xZQEq4c/OVqrQQqQ4tQLgRcU=;
        b=fbP+4HTovSzpyt41Nar+T6qqtD8rRKrUTgR0lyAmv60yDvGlwMiaNqF5gKagzdfRMT
         7e29pSyT3rUjyPJDtasil9vqOaa/8SEnxxhRlIlIJyomBFGYO2YlF3rbeBiUwSN2jZ+7
         XAIeIwye7TRQR31u0guNNsE2P+5tn5sKJ0EbhLeh4uks+f6rYzEXVJvdk4IYV4tVx4P1
         CGlTDSLL4odKbaRnTMtzMhn9TGJvbgpNeQh4CfJr9LwXPUsFEon+x+kSIppG00JeJDAa
         Kxva/efqGPComhWy29AOl+RhUzXaA3tVR4cherh7CfyXbr5JxmzBCCcZFLGhcb3GcH/s
         XR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4Oy28Lf2WkPvsuTfm0xZQEq4c/OVqrQQqQ4tQLgRcU=;
        b=t8KcGe2JjqJVwl0xRbOEWJFO/vt7Xw4hi1fxt5sMnFVBQw2+NccoKFaiNmztnBy/zl
         fxxyXmH9DjauTbh4p6VpCsrLZ6u48b9RDs1bAnRjfSkM/QgC8RqJGza4p09+FnlWrGBt
         0ocVZKfO8Kj9WzeL8y30NnGvkVzliEAZvIgcoM802i+zl6iR6I0Dceiow2+lpX58d0mB
         jyCxrO7hU9njYkKYwFLHBjVin11GrPxN+JfEb3C8R81DnMKrZYIkO1ynLNPuR7muYsEa
         MkW9Esxr0nz/Tz6QCaeVYUv4+ApXPpI71kfBolp+7QbDZDzcDWin6ejd3Rlb4shinYki
         scYw==
X-Gm-Message-State: AOAM532dtxvXJOxQh8x52aBMJFaoOq9BGZxauY5QAUYavCeqSUz7xt33
        roMTdPOKVHmLpHlCq9VTImp2njfMC+r9B8f6Wpo=
X-Google-Smtp-Source: ABdhPJy7G7mwLeP7iQr7QLRsnb8PzKPsSogbF6apbcszy0+xrStNiQg/v9bOwXvFeeOJdrJzahNkFd8W4ziWysBfY8A=
X-Received: by 2002:aca:3285:: with SMTP id y127mr6489956oiy.98.1615476288093;
 Thu, 11 Mar 2021 07:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-1-charvi077@gmail.com>
 <CAPig+cREZvoFLNNmZROXOP5EKW36L7SKQMjYJJTsbtMeiK2wNw@mail.gmail.com>
In-Reply-To: <CAPig+cREZvoFLNNmZROXOP5EKW36L7SKQMjYJJTsbtMeiK2wNw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 11 Mar 2021 20:54:37 +0530
Message-ID: <CAPSFM5eDSwBO+PHNzjvLhuor4Cs6VSmu714T4aCF8mgjfDqwLw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6][Outreachy] commit: Implementation of "amend!" commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Mar 2021 at 13:36, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
[...]
> Thanks for re-rolling. I left some relatively minor comments on patch
> [2/6] and some substantial documentation-related comments on [6/6].
> (If you take my suggested documentation rewrites verbatim, you can
> have my Signed-off-by: along with them.)
>

Sure, I will add the Signed-off-by.

Thanks for all the suggestions, I will fix them and update in the next version.

> One final request: Please consider using the --range-diff or
> --interdiff options or both when preparing your series with
> git-format-patch. Doing so can really help reviewers focus on the
> changes made from re-roll to re-roll without having to painstakingly
> re-read each patch in the series -- even if a patch didn't change --
> thus saving time.

Okay, I will add it next time.

Thanks and Regards,
Charvi
