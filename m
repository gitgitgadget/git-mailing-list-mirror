Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB12C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC4A60FF1
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 08:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGIVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFGIVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 04:21:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B9C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 01:19:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i13so19268383edb.9
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqBQkh0/QlORKhHS2B5UkZG7fgcIOm4d777Vic8/EIg=;
        b=i6/Gzl5iMrHgg9BR4nkM1K9ljVqkzPJkCIg7XdcE1UYa6u6TFSgYNMQw7/9QhbctV0
         jOWTcUUsMLzffua099ye5t/xIYwww/kIU2n88u/0H/Sqh24w2HCLtTMjUneqzY6vjStl
         wV5NYjSLxyXNJrybYyNH+u7OWmm/tC54NgGQgagGPdbTEwMykywLoZEi0T9oseFAVzH9
         E+wS4y8Bl8Q4F601lx+Hu8r8lj80+WDeGqvShc4lVmH8CU+Q7JL5zPbu9KOckbRjvcnL
         nXgXT9upDwFl6Cll4a+hXb6Z6phpDTYxNk1mxP3co4reoZDqDzTQoC7/izso3/ORkcce
         eSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqBQkh0/QlORKhHS2B5UkZG7fgcIOm4d777Vic8/EIg=;
        b=Y3cI9URlT8sJru95tBrFu6P/IhhPK9shRaCoVn/4tVaJ1rHaXXF4sx/qdzYYNDrWpV
         9k9JMUI4jea95NuxAOtBz8zPI5ksiFXiUTh3ddMFGhgZy7HOsJDcbnYxZpNNqqOR+24i
         riL53TR+11//YIH563C9oq1gw1UUNp8iC4RbiMCWlQDkMUwhIYf9OShwwn/MY/zMO7Mq
         vsTSsXps83TXaOA/8Y/SXjZk6EAvjKK/80Gjj1iuoTIxXatPKmWh5zWkAnvTpm8xB3nE
         FXoCio683PUdJviwxlFbUHBgJEFpa18/oI5Aw2aX+gDt5Uidv35HMSz01kyNmO45gQqT
         be7w==
X-Gm-Message-State: AOAM531etkLhTlyvwMTL+2Ry/lzH6vOiqGsT1+fq/ozlWtUJGWF/Qx3K
        fr5dKDcUajBISTguWl6SiKhR5owzPV+JYy/CCLymjuHAQBg=
X-Google-Smtp-Source: ABdhPJyL7i6uPRFGKVyXrWuI67nDtp2NiQdRj2OTGfKQTMFiOUWxcMhhP7S5exXhGt7dl2desKwbEqxVs+GOf1exslE=
X-Received: by 2002:aa7:dc42:: with SMTP id g2mr6411946edu.362.1623053971568;
 Mon, 07 Jun 2021 01:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
In-Reply-To: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Jun 2021 10:19:20 +0200
Message-ID: <CAP8UFD16soOa5RGRaOtPjPbFQ0OjuecCFGM6mCftC+Z__9coCg@mail.gmail.com>
Subject: Re: [GSoC] My Git Dev Blog - Week 3
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 6, 2021 at 2:30 PM Atharva Raykar <raykar.ath@gmail.com> wrote:

> Here is my latest instalment in my weekly Git blog:
> http://atharvaraykar.me/gitnotes/week3

Great, thanks!
