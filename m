Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE5C33C99
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CD62070E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkpkT1Kw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAHAKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:10:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35968 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgAHAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 19:10:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so1130273edp.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 16:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+2adGaXrZxr9m5uJFQUJ7pP+qJe5ojD/ngjbDQ+Iws=;
        b=RkpkT1KwFn6NxttVfq/kvgt0zhv0y1FFVuivbdEP7laAvhaaTBua2x0jm+NDXrWkq1
         aBXakUpztH0ITwUb7fjDomwYzUZ1jTROCcgStukzjDYXznCzyJ+NmVprpO5iWUCGcdqe
         TR5fNVfDcLx0vhu2EH2euD8q1leDJ/YhZ6CN89S+vCRx3FNGT36V7tBpDKT3b5RwkwUF
         gztRTWca8UCqjc23P6WKLU2XFUDI3ahUQpidn9B3/u3KrNnQq7oADTIR5Ri4J/RRs4HV
         /kT+beQ4Y1FJ+FN5jRcMRzhyypkEZyS0QAteEJgEr1L81z+5wb5hU23x8f6N2+0FHJbq
         EZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+2adGaXrZxr9m5uJFQUJ7pP+qJe5ojD/ngjbDQ+Iws=;
        b=JdMxk9XmedsWWLo2p0rqYJV8/Hn03oiddYCug0zi4u68A0kqabBDn1aihAyRQv8ZXY
         Km+sMTuGKvyY15dK7TugFG6huzchMewVvxpSHggT+Z+N1tKPBSz/YGBPI3xDjcHN2IEy
         ohlFh9e0fOgEXWolD5EelmAEAJiDGphkfeI0cAbGwg47QXto44ZIcf9vnjL5porbDEgn
         93FAiO8MtEyBjKE33AAwccWvI3cnBHot+Rw7I0dBsi/56eDmXh45znw+XdxP5zHytgbY
         bOnyn9nRguhOkVxXh3dU4R5eioFshZUYO6qs3SxgWH92Ty+YVlTduv8Qc9D0r7/SGNRH
         +KnA==
X-Gm-Message-State: APjAAAWA7qTzIwtx/vJhuUXqQHpRZX+fxtVMYf6RKnpMxCrCXQHVW1Y5
        iiIMGZSgwynjNt1mW9iEtoqLyU7YXNLBTiJaxyo=
X-Google-Smtp-Source: APXvYqwstKwY0KayV1tBm1JP2vv66KQhC6RQnsDStRfBQZNnzKZzCwlQkRx6P7PlWRtt1RMMh5/vsI35vArIiO4YghU=
X-Received: by 2002:a05:6402:b7a:: with SMTP id cb26mr2742929edb.2.1578442198487;
 Tue, 07 Jan 2020 16:09:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.515.git.1578391553.gitgitgadget@gmail.com>
 <ee8636e0ed40888b2a132cff2dacc97754550ba1.1578391553.git.gitgitgadget@gmail.com>
 <CAPig+cTv5SOxEjjVQ7QvqJ1WbZGbcXegcCP4d5CK+nSdJvkNdQ@mail.gmail.com>
In-Reply-To: <CAPig+cTv5SOxEjjVQ7QvqJ1WbZGbcXegcCP4d5CK+nSdJvkNdQ@mail.gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 8 Jan 2020 13:09:47 +1300
Message-ID: <CACg5j24A+g3_MFQvurd1Esy1s6A8W4VkLEWZjiP5WXxcTvqr-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: fix a typo in gitcore-tutorial.txt
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 8, 2020 at 12:35 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
>
> Calling this change a "typo fix" confuses reviewers since it's clearly
> not a mere typographical error. It looks instead as if you are
> recommending git-switch over git-checkout, so a reader would expect
> the commit message to justify that change rather than merely calling
> it a "typo fix". However, digging deeper, one finds that this is
> actually fixing an oversight from an earlier change which already
> updated this file to prefer git-switch over git-checkout.
>
> To save reviewers the time and effort of having to figure all this
> out, use the commit message to explain the situation. For example, you
> might say:
>
>     doc/gitcore-tutorial: fix prose to match example command
>
>     In 328c6cb853 (doc: promote "git switch", 2019-03-29), an example
>     was changed to use "git switch" rather than "git checkout" but an
>     instance of "git checkout" in the explanatory text preceding the
>     example was overlooked. Fix this oversight.

Looks like I overlooked this commit for its simplicity, I thought it
was too simple and self explanatory. I agree with you though.

Thanks,
Heba
