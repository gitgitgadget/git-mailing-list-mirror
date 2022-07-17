Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC720C433EF
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 02:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiGQCqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 22:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQCqR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:17 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AB018368
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 19:46:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id r12so6511173qvm.3
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 19:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUoiPNjPGHzPy1qrbAtb1oHfms0tS9Q+CUSQLmjmNFo=;
        b=PYgAYI+hfzqNT2wd6OlWVN27Km9kO5beQAiOjeYgsBuAQkvWwErKYs1gLqTiimuwW5
         4gtPKvbL6v5rqyRnzFLjTcPbjpc1RfsAAJqaWnCWMG/EnwC5o3KCJ3FN8fTLfQsUpM2U
         6G2Mt1Cyvw4HonhqcRi0n5HT2vOBfqaGjzfL5m53RDpfK04EiiiOii1Z7HeLL2wpXjKQ
         MC54tm2Iw/bt9nzUVt6OO6DR+Y2d9fTbtytmxGjimrYfMkKS6ZJhStWWGOusEMljVEaB
         74ClJ3EWBBqv2RGYhsflAZdBjMBBXFGYlw9uOf4Y+PKthe/JzDkwLRokV3MjPwkuSlXU
         eyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUoiPNjPGHzPy1qrbAtb1oHfms0tS9Q+CUSQLmjmNFo=;
        b=A6lGBlCGJFN+NybFvO5CoCnmKuak0OktETTPvNSMk3bUKFqWqQLAje6NAuZNWZgxOa
         L+HDeBdm8cX4FHo7hCjTbz8vSOYNDbLhTLTZirSnT9RNOp4AR1ZSG3t7L4z0mfw2Nm1m
         jdqeKs76e9IYZXtrL3yIJsWafgkqES5/RnwowPVAid8IpFNuYzDKR97Zi2vEIqaVTASB
         bNa6fgWokxQtDAsGFuLgIG/PmmdCu9lR15vH6IXgoIWdmDR2cHqJRHQ5DQ37xxCkE4Rm
         31i8XqpZN8kiQ7TcthfpOGtCcAIiGrpWpj8/Wg8UhpJfBqdKggsH/ORMuk1TvlEVvD1s
         BCFg==
X-Gm-Message-State: AJIora97nvNw1bMIKbNmK1diw1gqcz0gOKOBXhRY+xuTwJFUGyBc865i
        h6n3xSnEo/mmE6wNzRINGQ5j6e8LKmL6aZGGpCA=
X-Google-Smtp-Source: AGRyM1vsN0bJZ7aaLx0uCBOGU21lIJhUliy1eIX0xd07wPODVPTNO5bholcAAw0hWp5VfeX/zp314sUUx6nVX0iOGD4=
X-Received: by 2002:ad4:5b8b:0:b0:473:5895:d6fe with SMTP id
 11-20020ad45b8b000000b004735895d6femr16839227qvp.39.1658025975649; Sat, 16
 Jul 2022 19:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220629224059.1016645-1-calvinwan@google.com>
 <20220712231935.2979727-1-calvinwan@google.com> <xmqqbktsdgro.fsf@gitster.g>
In-Reply-To: <xmqqbktsdgro.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 19:46:05 -0700
Message-ID: <CABPp-BFHeobAdTz437CewmvbngCABTDeO4mUdHu0hGp=18UwMw@mail.gmail.com>
Subject: Re: [PATCH v4] submodule merge: update conflict error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Calvin Wan <calvinwan@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 11:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Changes since v3:
> > Thank you again Elijah for the helpful feedback! I have removed any code
> > touching merge-recursive.c, and refactored the rest into merge-ort.c.
> > The error message has been updated as well as any relevant test cases. I
> > had added a jump in v3 to "ret:" in merge_submodule() to accomodate
> > early returns, but this has been proven to not be necessary since an
> > early return means the submodule was either renamed or deleted, and this
> > case is already taken care of with the message "CONFLICT (modify/delete):"
>
> Unfortunately a34edae6 (merge-ort: split out a separate
> display_update_messages() function, 2022-06-18) moves the code this
> patch touches to a separate function.
>
> If this is now an ort-specific topic by dropping merge-recursive
> support, perhaps we'd need to coordinate with the other branch.
>
> I think en/merge-tree is ready to be merged down to 'master' in a
> few days, so I'll wait for [v5] of this patch after that happens.

Yeah, sorry about that Calvin; one of the risks of working in the same
area.  Should be pretty easy to resolve, though; let me know if you
have any questions when you go to re-roll.
