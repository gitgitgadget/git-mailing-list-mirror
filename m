Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB020C49EA6
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 01:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37F8610C7
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 01:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhFYBLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 21:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFYBLi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 21:11:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077DFC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 18:09:17 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id b13so2170879ybk.4
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 18:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfPhWihI7tl+E3zZu5tq7SyyD7BeEn8inRBTgUJVoXY=;
        b=WZir36tQRHjiY8ptZppuBitWUWDTTseiEzSUljV2DIJbGy+dd8ttx9rjFUooJY0cdX
         ns3FLDqXm5/osYi7RxdRRHE8HAOGOdXjw6dBwvNBARgy78lvyGD935lG978INpTHtJJr
         /fx5c2Qgr9rpNf+u+w2fHvXh30eC7RCN3ClJk9GkX/zJqjtwDJyOOcKMQc0JWoQw2PI3
         BG6NFqtRZuQB+KXnaPlMiGlF3souA0SfbJDawCdb1XLpuvpNjX9SZg1Ecy8afibVaCkc
         TF8g532XTINax9ThzjFE3J72EXUO/xB6vGp4q1XyHYvA2j/a3JqdY0J1bDoMP6E05reb
         Bz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfPhWihI7tl+E3zZu5tq7SyyD7BeEn8inRBTgUJVoXY=;
        b=pJKcSvFHyAdU8WtVuQ2UiW29BxXaT/uMOG268jBV1a2bHqhXFSKIAnqXNx/f4iqlRG
         JNTYKllBKQPWZQTYaIVX/JnPasm5b7//MGTPwwmk+vLcK+xO8SLaQDqK2OlwFIm0SEqV
         Dxsr4oUKM8y6QXYvMZXcjEQ6gntPStTUWk5kbCXOiqhHLH9d/oBeoK3AYx+d5lnoUgrt
         dUB+AoWdcd206kGEJLZbEcdNB3Eo21x/mydaiXohuRrcq6xIBnJDk6O2SMaZOwEUkJca
         aS6CBaj219fAHkmg8S1Zz4AjOJda3vSEY3fk7mS5CdrA7Jgkqq+WQMU8DSQT0REMMuU/
         U4bA==
X-Gm-Message-State: AOAM533hCq+fJFlAQIwYzHrukUlgmqtwPzaFy2ueWQbnBcKkTjgD2iQS
        azpNVdaPTImVG+IYEP1b+W2DFHG5BJchUvcQr3U=
X-Google-Smtp-Source: ABdhPJyxpsBO+Uo9DCNSKMHegXAOQOFK2UR1CDZ6cpWbhAssGGL2NmetFmY1LaiyIe+g+CqGZJ5NkKuC08rFlEphp5M=
X-Received: by 2002:a25:f601:: with SMTP id t1mr7889876ybd.81.1624583357201;
 Thu, 24 Jun 2021 18:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <CADdMKP8kY-ry4ZWmp1hLCne328cC4thgavbkXOjdaNpD_ockSg@mail.gmail.com>
In-Reply-To: <CADdMKP8kY-ry4ZWmp1hLCne328cC4thgavbkXOjdaNpD_ockSg@mail.gmail.com>
From:   Douglas Leonard <dleonard.dev@gmail.com>
Date:   Fri, 25 Jun 2021 10:09:01 +0900
Message-ID: <CADdMKP-vTfbkdxcK5ZN2TJh3fVPc7hydqDNqBp8V6Jr-J6F+mA@mail.gmail.com>
Subject: Re: subtree split includes unrelated commits
To:     pauli@indel.ch
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> I hope I got this reply sent to the right thread.
>

Oops, probably forgetting the Re broke that.
