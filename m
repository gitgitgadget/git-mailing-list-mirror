Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E042FC001B3
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 08:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGAIOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 04:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGAIO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 04:14:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC13BC
        for <git@vger.kernel.org>; Sat,  1 Jul 2023 01:14:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso3134790e87.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2023 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688199266; x=1690791266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EfSCm4E3fYardgt87DUse1LdFjs/9GjMleeDToEUYUY=;
        b=Ozv7SsC7cRCc5nHaObHGhAdTq6f866ppSu+bnnszL5eMmOHDGnIP1gZgIKkoVT0KC7
         nVPKMl3sR4PN5O520T+gvXoU6TECZGFvUhVr3OoyhKVMmpV/Y39y8roQj+wBkj1SLiiw
         RCJW5hNMnoPm/xm2nlcIbtF0TDsLDleTYn+Cyl0mjlMUW7LX9bOe3qS4sIXCI0FaZVL+
         EYJMDNgAzPD9HU9jsl0pE5mOUV7MOffNZLfGiWjwtQpO1A5qp8/+tFf5JXC9JaxINGiL
         zObH4hFae57OqeWxQSarZW0G9NIH2u2OQIE2AoLnEaMBigEoqjbNOkh35oYkwR1c17Ay
         HISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688199266; x=1690791266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfSCm4E3fYardgt87DUse1LdFjs/9GjMleeDToEUYUY=;
        b=JKJWQsjGswbBT/wFv/AWscI7eGAd/4Z4a8TGEAyokZmQeekNFzX823VPB+QnbkXk0F
         RG/0ZqsXJdgGr7rRtKcdofjol9vCUZZIcxIGaG5lgHF3zlt+Ct8DSmLYoMeV7gkagPv9
         UFQjqewnJOKn0i43rOHD43vNCnhIihX9mYmYcMTRk+l2waie4MFZzQ2gl6WVEgQ+9HeR
         ohI/Gu2kZGuHNhQuPYbN4kghTGW3GUuYFYkDgvxO8ZisMkKPfU3ZeiW8S0+976NyBZNa
         GtFHW18Dn92ypsSRNSUgcmQXc+GqcGhgiusuFKyaxG5k+cc9rKJnQziDU9YMaV5PxIYt
         lHog==
X-Gm-Message-State: ABy/qLaOlZE3pjsC5ltRaU7QPFyDB7rf3AeG+z5fVpADUqdmOLKWuh8k
        R9bcdpgE4gC42VZ7ylvO43yT9ThuzeIQPrQuo/hTYv0qSH4=
X-Google-Smtp-Source: APBJJlFc+wkn1m8WFGs0GX3MmtVD43gWP0WEv6RUITlmK4Fv9uMUQUZKWZdOuDFUUQaFAxM5x327ncrxWMdz1y9siH8=
X-Received: by 2002:a19:6914:0:b0:4f8:5713:7dd5 with SMTP id
 e20-20020a196914000000b004f857137dd5mr3889073lfc.10.1688199265387; Sat, 01
 Jul 2023 01:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5y747l16.fsf@gitster.g>
In-Reply-To: <xmqq5y747l16.fsf@gitster.g>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Sat, 1 Jul 2023 13:44:13 +0530
Message-ID: <CADE8NarZ7B8VC2cnh4Vt8o0YyNswguXDeJtfEk=9_isHzv4SNg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2023, #08; Fri, 30)
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 1 Jul 2023 at 02:24, Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen', and
> aren't considered "accepted" at all and may be annotated with an URL
> to a message that raises issues but they are no means exhaustive.  A
> topic without enough support may be discarded after a long period of
> no activity (of course they can be resubmit when new interests
> arise).

> * vd/adjust-mfow-doc-to-updated-headers (2023-06-29) 1 commit
>  - docs: include "trace.h" in MyFirstObjectWalk.txt
>
>  Code snippets in a tutorial document no longer compiled after
>  recent header shuffling, which have been corrected.
>
>  Will merge to 'next'?
>  source: <20230629185238.58961-1-vinayakdev.sci@gmail.com>
>

I found an error in this patch while fixing Emily's branch to which the tutorial
points, which I linked in a prior mail[1]. This would also require "hex.h" to be
added down in the tutorial where the function oid_to_hex() has been called.
Accordingly, I have fixed this mistake and rebased, and will send it
as a resubmission.
That should allow the code to compile properly.

[1]: https://lore.kernel.org/git/CADE8NapQK2ouy4YDQA+3NNkUn_EegkSBQCtDfcSCVGmZvVufXg@mail.gmail.com/

Thanks a lot!
Vinayak
