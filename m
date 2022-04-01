Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9801DC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 12:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiDAMUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 08:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiDAMUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 08:20:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE65AA61
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 05:18:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 12so2588977oix.12
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ympCLHcG5nijhzihu63X0TwBjmmvpTQbI/qCvXthieg=;
        b=TMMbLgDQ2ISFommmPIu6SJQWGVzC1O0BisO4zaRqkgVGRVQ6RcLALxkqv1c9MzrIkU
         G5UKeqtZb11VMnY/fjDitf/LiWRvF9S8errkxKd7slqVEws95BKg9hx3hm9nQj8Ca9OJ
         KJDFwOBt8anZjYU2nzbCGCvzxAX3h/JhM5sxGVg+TWhlhLjcymG4zchMFInziakwaBbf
         QsDtpjy30JOYiMlR/QzHHqhDo2RkPqvqd4j+RVixKYQGd2Citrd4ujiyvY9WdnnPjW65
         hheKx/8NNLajz2z08sAp8f8eWCiGWqYF9Py3fyo6TkTqMGsaO1At2wL2eixnCQA8EeE6
         yI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ympCLHcG5nijhzihu63X0TwBjmmvpTQbI/qCvXthieg=;
        b=Yowv0wSqbzCVf0q0zUZOXuiUqveCbdIxuYqt7Rep608tPVUlVMW/kmlscEOoLdjgI4
         XINJjmcdXi+aMydauxEegHNJCWsEaz6id+lDEMAjI2QWTpD95V6ceXK8z8zkf+ePGtOy
         /IIOVk9Ylm+lQ/5sjZlRYBuYs711bnYqYGg3m5i07s4Hjpe4QY8nBCh0WvqW8vVhLeK0
         IZXN2eDGeL57RynHBXdUna+7VCvpiRM2A5jZafgU8ndfSxX11yMrg5v/puRapT2K70pz
         5K3PFhlyWwcdd81JxogOAiK9KoJbCONheT2Hi1JN7MlPn6fAhAUnAJNOWbyJTN1Fu3jm
         GOgg==
X-Gm-Message-State: AOAM533I/Ee58cOoYCZmxiCtCkdKRCETtUB+UIoee1zqlw4fNKlAWYQS
        U9yE4L6pocwJOvq4owSXb+1E88sv5PGnmEU4+Aw=
X-Google-Smtp-Source: ABdhPJyqp2p6sK8NSPGespjYfM0g0aDlffAE+ZN1cc/wim7GtHlkW+rV1+kWngN0XSOZbXMS0kugYoTIS8UYOYgcZnA=
X-Received: by 2002:a54:410b:0:b0:2d9:ddf4:2ea with SMTP id
 l11-20020a54410b000000b002d9ddf402eamr4609631oic.280.1648815535977; Fri, 01
 Apr 2022 05:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com> <3c6a562b-d55f-d73e-3547-36ce752fcc6f@github.com>
In-Reply-To: <3c6a562b-d55f-d73e-3547-36ce752fcc6f@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 1 Apr 2022 20:18:44 +0800
Message-ID: <CAJyCBORjR1C1cs9aUYPsyEJoBaRsBo9ATHXBopFYPqrKQAbXxA@mail.gmail.com>
Subject: Re: [WIP v1 0/4] mv: fix out-of-cone file/directory move logic
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 1, 2022 at 6:21 AM Victoria Dye <vdye@github.com> wrote:
> Thanks for working out some ways to make 'mv' behave more nicely with sparse
> checkouts! I did my best to address some of the specific implementation
> questions you had in your commit messages. Beyond that, my main points of
> feedback (beyond some formatting nits and implementation questions) are:
>
> * Patch 2 deals with sparse directories, which won't show up until you
>   enable sparse index; since you can't test that yet, you should save the
>   patch for your "sparse index integration" series.
> * Patch 4 should either be moved to the beginning of the series (with the
>   tests flagged with 'test_expect_failure' until the patch that fixes the
>   associated behavior), or split up with the tests associated with a change
>   moved into the patch that makes that change.
>
> And, as always, I'm happy to answer any questions and/or clarify weird
> behavior you encounter while making changes to this (or subsequent) series!

Hi Victoria,

Thanks a lot for the detailed and informative feedback, they are
incredibly helpful
to guide me through this first attempt! I have read them all and am preparing
corresponding fixes :-)

-- 
Thanks & Regards,
Shaoxuan
