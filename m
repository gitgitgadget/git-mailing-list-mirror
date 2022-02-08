Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B747C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbiBHBsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbiBHBrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 20:47:24 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75567C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 17:47:24 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so15921689ooo.13
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 17:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHfHCj6gq8WDiaJwKD8w5sIG6F+4Z+V9+ln7cQxYJpw=;
        b=cgj7COvQFLmqBnHxLX+xTYqQL/ilV3MTL0vrRFXVubfp/RJHXgJjK2SQglYdiJgnGT
         Ai1zdQAvoW72l8Bnv/cl2UNBNRiWy/3AyOuL2YDyv5XJqHT/sguQSwJ12IPWILmaAw9X
         V25rhR/yHM2Xf+4cZO1ijPDxTCzvLtvNwB0NrV3XE8Gs1sOpkhhc/rrVYvKjrcZTRQOl
         9/iel/XFKdirtMCwzVYFIiQ0tAeiyW6XmCBCPae7Xdb8tzt6JrU9WVOG5a+0xJGIOjqJ
         ivhs60+m3zaUkwJZCiVEl1gwf5IARWjAYC4hZFCZQu+HVSWm9Ef1c+Y4JwJcT/q+kbsE
         ipzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHfHCj6gq8WDiaJwKD8w5sIG6F+4Z+V9+ln7cQxYJpw=;
        b=VhhY9g2svmY5oYncREEzH05TK9y5PoQAjXJ0fDCu/NfzkvJe2mcrzhzu8opHkxxth/
         1vk2c+59Xw6V1U5L8EV9s9qWZAJjRrNtHzzNcd+k9Z/G8Dp27JHnBz/ddT5oR9qDCNA4
         tAHpXDhCF26wMOZUN54Tl8W0GyR4zwXKVBHiZMLEeV1VxvybhiePeBjZoAy4d3qe2xux
         MRJSUyIzyEQn1iG74A84brzkNm+kQuwX25t9GsXu/Uz3s53cDljm0ftH1p5uZn+k647T
         OXzIKqBa4QQFBWRatDvpLZUgRgFCTSAdgTyl/JXpnQZ1h5P1L5tUNiMpW/TuTnZYVWVc
         83uA==
X-Gm-Message-State: AOAM530IXiloYOGjrbLiF76j5MPIsfk9BBL/pZUQA9MwhMB1IFw9W7Py
        Q49YYpDfhtPkzdbjyj7+XMM1iPsFOKjM2z8ZcfM=
X-Google-Smtp-Source: ABdhPJxk5AU9Z0uY8LTxYCfvlGlgF05hDIaL2YOzGKxXgbByqr3qbPjKd7OUvPioPIrckbBVdOkixvtkye6kZIU7QiI=
X-Received: by 2002:a05:6870:1847:: with SMTP id u7mr593304oaf.347.1644284843861;
 Mon, 07 Feb 2022 17:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220202064300.3601-1-shaoxuan.yuan02@gmail.com> <20220202064300.3601-2-shaoxuan.yuan02@gmail.com>
 <CAP8UFD0c=TeBwcyWo_GKLKV7Y8837beHLk7JGqfF9_DU79NWig@mail.gmail.com>
In-Reply-To: <CAP8UFD0c=TeBwcyWo_GKLKV7Y8837beHLk7JGqfF9_DU79NWig@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 8 Feb 2022 09:47:12 +0800
Message-ID: <CAJyCBOQR5wWkQhcVBVC7xJQDsaciifmX5LVuwPhBX2sVLMB7bw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t/lib-read-tree-m-3way: indent with tabs
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 7, 2022 at 7:54 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sun, Feb 6, 2022 at 10:51 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> >
> > As Documentation/CodingGuidelines says, our shell scripts
> > (including tests) are to use HT for indentation, but this script
>
> Documentation/CodingGuidelines talks about "tabs" for indentation not
> "HT", so it would be more consistent to talk about "tabs" here too, or
> at least to say something like "are to use HT (horizontal tab) for
> indentation".

Agree, it should be phrased in a more consistent and understandable way.

> > uses 4-column indent with SP. Fix this.
>
> Same for "SP" here vs "space" in our doc. (Also note that `man ascii`
> talks about "HT" and "SPACE", not "SP".)

Agree.

--
Thanks,
Shaoxuan
