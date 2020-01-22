Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9065C32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EEE2253D
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdntpyVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAVWiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:38:07 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36956 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWiH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 17:38:07 -0500
Received: by mail-ot1-f43.google.com with SMTP id k14so934740otn.4
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 14:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iah2gdLJ2C0gYUcjOMa6Rq4QvKyG3YLE+C+y+lEtTXg=;
        b=XdntpyVYA7mxNTPkYHf82ktmUE88+1JoFhkgAZeb21T6etxB58LM5N8vB4/cU2DDru
         AWpFBA95lfhvt1IOALt2/ouXknbRnFBzKIbtSdJ3nHoWQ0Tek8zJgIg8Ii5C6+sPt+XP
         odgX3/R6MokHBQI+QGkL6NlsJ+HLt54mTg2yd0bynSKfxjYtkU5CTh+JXzX0jwDd0TJF
         LlwaDcT7/UF1b0W5rV24Oiij8Dq9rwVJrG+qIbD0xiNOToa3Ka1v5jwffUrPRxU1/4Ln
         fTras+VcCQfW2FSlViDGzJIKE79FF9HjCSoYx6vtI+fKn1PHIihGrftruuw4VPLcTI7I
         P7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iah2gdLJ2C0gYUcjOMa6Rq4QvKyG3YLE+C+y+lEtTXg=;
        b=Z2anlXwcdCr/EjkN0GjmxmjsT0QEZsUoWSzKA/5xv/U7BH7uaPKP/wXDuMBjjjpp4D
         PBguZBPRDg62pmS8zkd77/5qBNBd95i+SHzb07rm+RcMcBWkjzDv/8NbEhzZ+c41GIDe
         kJrupmvAfmZjC/Px2J44O//v1OynkWeMoOgnh5FJCYrGwtosrXUMXDsO/zsn0LI3gnaF
         BNGS44sdjNMt6xfO9lpApcYHAQ1A9LGc6W/OYIZQ/tbFnMHpEWv5xH4WsRecen+6tLnP
         tCQyGl861gIfZ5cCNmcYE4rQgXFid6FH1Tcq8hKL+z5VbxFy3yRcIcSCwNoqhFBw4X6v
         eJ2Q==
X-Gm-Message-State: APjAAAXhLdbv9kKVlmefHXDTheAHF60sCz7mt0OTu2EFqIVf9D6citSZ
        XWWuqo9ZIVYB7hzak7NBUKbksNKAUB6BedafWPREUFCf
X-Google-Smtp-Source: APXvYqz2Zz3BpQ6wPABpqpU6+kBKyRwugLJrOLdgV/UsocTH2VTd/I/zFy8P/8WSq5GC3qxKAzrppBa9TvZiTGQfNsQ=
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr9246529otn.267.1579732686268;
 Wed, 22 Jan 2020 14:38:06 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 22 Jan 2020 14:37:55 -0800
Message-ID: <CABPp-BHMwkP5r2tmVfmrjVM904EnhEAQ8hqCbxQ7QEg+vyRNZQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 22, 2020 at 2:19 PM Junio C Hamano <gitster@pobox.com> wrote:
> --------------------------------------------------
> [New Topics]
>
> * en/simplify-check-updates-in-unpack-trees (2020-01-07) 1 commit
>   (merged to 'next' on 2020-01-15 at 586c055b69)
>  + unpack-trees: exit check_updates() early if updates are not wanted
>
>  Originally merged to 'next' on 2020-01-09
>
>  Code simplification.
>
>  Will merge to 'master'.

This is v2 of the series; and it looks good.  But...

> * en/unpack-trees-check-updates-simplify (2020-01-04) 1 commit
>  - unpack-trees: exit check_updates() early if updates are not wanted
>
>  Code simplification.
>
>  Will merge to 'next'.

...this is v1 of the same submission.  We don't need both v1 and v2 of
the same patch to be merged (the only difference between the two is
that v2 has a more detailed commit message); luckily, the one you
already merged to next is v2.  Can you just drop the
en/unpack-trees-check-updates-simplify topic?
