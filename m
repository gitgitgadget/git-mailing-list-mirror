Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28419C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 02:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiGWC2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWC2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 22:28:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1BE31224
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 19:28:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id b21so4727307qte.12
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 19:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wfUaRV/IJOXE2lqY1qS5uSTzO+VL2demaV2UUti9+94=;
        b=VQimSl+0TykulZKc9/tKu80gAAQa7mQk8tsr/namAHk4TdlhebOU93gXa8wna8djg0
         POhzyVEZ3fxQst+XkYpTXJBa/m282byPf6hsbhlocb/+piNLk0aGyL6h5JDJtOB1HDZq
         omHfuYItZ4kIOGTGGemrrp91UOOIkrNmFubzXlgR48bEkabJkHPhtF7dhIPB6DTyz83B
         ZswmnsSafq2j+Cd8utZ80gkiWbgC2B24yQDihehoPQw7d93tJjJ2iK0pxmAMnggZE95Y
         NThERG9wNzQr/qgywQIUySMjOy5U4szyF3kwH+Ej3f/n5MqdPmDbix/jnz8bMvrL6MMz
         yZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wfUaRV/IJOXE2lqY1qS5uSTzO+VL2demaV2UUti9+94=;
        b=BjGjvQlqCrO9lUoj9rvbisAiNJHFov/2PYLdVYf/jkflKOojM33nepsvdZnL/f26B6
         dDsI6nP2AACGPDExyt0J+9dqQlyU+ioU4g4NowmIVdlxdPR2tT7aVpBMPZzzbmhqBK7u
         LVBmGPe1kXNSg7sfsX4NZngoDcviAE3dhEnQEMFSsKffwXDRtvmKmHDNsiEKyzELv3D5
         GrQQk1orCRwE1T3AN4xe0L3pqeWV+IfE5eZYiWf1TtJ10ib1y9arWIiBcACjij9cHoKg
         RkFsf+iypY4O8UdYt0PuVIBdsYkjv/TxTQ/NDTjOwGji5soULJl9LzvAa8LcqsMVccDP
         xAMQ==
X-Gm-Message-State: AJIora93mttiZ8i67Ig4viei/gkfVULuvmiQJ1+XDe+ey9ELgf3OE+8C
        0vA25KYSH7l3jHpvoWXwhTGfReoioJyManOSHHuIMSOCHSaTjA==
X-Google-Smtp-Source: AGRyM1tEdNALY11cn7P4vLHjyElkDEwNyhdSTzsMuqcQZ5Ho36FTUpQoi3jhPgw3dmtQl6oxaI7NSqO06Hs+nvR02XI=
X-Received: by 2002:ac8:5d8b:0:b0:31e:ed61:b5a7 with SMTP id
 d11-20020ac85d8b000000b0031eed61b5a7mr2442564qtx.259.1658543329192; Fri, 22
 Jul 2022 19:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh738bq21.fsf@gitster.g>
In-Reply-To: <xmqqh738bq21.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Jul 2022 19:28:38 -0700
Message-ID: <CABPp-BEpnEUKvBOy2e0=EnF8Qj14myNx2OOsLS=5gtC6xYKLtw@mail.gmail.com>
Subject: en/merge-restore-to-pristine (Was: Re: What's cooking in git.git (Jul
 2022, #07; Fri, 22))
To:     Junio C Hamano <junio@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 6:55 PM Junio C Hamano <junio@pobox.com> wrote:
>
> * en/merge-restore-to-pristine (2022-07-21) 7 commits
>  - merge: do not exit restore_state() prematurely
>  - merge: ensure we can actually restore pre-merge state
>  - merge: make restore_state() restore staged state too
>  - merge: fix save_state() to work when there are stat-dirty files
>  - merge: do not abort early if one strategy fails to handle the merge
>  - merge-resolve: abort if index does not match HEAD
>  - merge-ort-wrappers: make printed message match the one from recursive
>
>  When "git merge" finds that it cannot perform a merge, it should
>  restore the working tree to the state before the command was
>  initiated, but in some corner cases it didn't.
>
>  Will merge to 'next'?
>  source: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>

I just submitted a v5 based on some feedback from =C3=86var.

(Also, did you forget to update the source link by chance?  Your
referenced source link is v3, but the version in your tree is v4.)
