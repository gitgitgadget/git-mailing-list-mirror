Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83434C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6383F61410
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhGANTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhGANTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 09:19:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C3C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 06:16:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i20so9998439ejw.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NljF3QqpR/PD24HiMTYF+YSwbdv7BFjxV/kNdWG6UPc=;
        b=XOeW3BIEpRzwh8anHKD3yfalgHCHMn1bypzRb1Q+3amMNJnnH/nR8SBTDInt7Ldiuv
         w6fJqqLMH3GFss+VeL8nwFUrNRV+ued3bcqgLdVz+hYUaI3o/gPfxgCD9JkaJwpAYBUt
         wRmB96DULokdjKvcjednjvk7sWXp00r55G5pU9P4iMoy4bBfzPlr1ccpRD/E3cYhSV++
         h9wZbmp9BEJvT6ga13hVe1XABRMkLGrOccFlL1ReYlcBTdf10jO4r2bxmjmHU62WId4r
         cCBQnlttL381RBvTOOnFubGc92fn0YaqBIKk6y7VVkvV2aTQkq96ZkGDyB8GGWV3ppml
         Oyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NljF3QqpR/PD24HiMTYF+YSwbdv7BFjxV/kNdWG6UPc=;
        b=qbXQp/9lEcZaehFlobkZQazaLfMijnE1Xd/XifiI2fgGHlie6gdWERN4kt1coADeb3
         7U+fGwFbQ47NLGlCXqt8UuA8MMTO/TIaidn+QhCmD+og0zFwNtUEdnm2YJSCH2X7Hkje
         dCvi/tcODyMAZnmabm/aHaZMomuxjOB5fcnNWKLWW7d/i0ur6V5NpfJwT6qHnNRo8bjs
         fB7sXMMcbE33dIzzcTv5jN6Dis5z4iZMx+qdnmz8yhm3IJ3asKhu55vTw5iCg9YskXla
         +Sz+6BThFFZAAv8+E3M2ifQYrGQ1MvCHyTVAsRvdnSFrKYwTvrFI1QSICx4hkDDCAR2R
         xxzQ==
X-Gm-Message-State: AOAM533+xcsysFmaza1YmLAr9bRmJg4IiarZAYNxNnobUJAQcC9pF84n
        /dfNxA/ZxoVu8hSrFcaJM2Y=
X-Google-Smtp-Source: ABdhPJwGg3o8ED5Fh3WKl3qKQKaVQd4w4j3VBKo+YP5vOw49rZuXesULV4JpP5a3uYKpxGo4LL9NKQ==
X-Received: by 2002:a17:906:4fd2:: with SMTP id i18mr5869303ejw.281.1625145408322;
        Thu, 01 Jul 2021 06:16:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e16sm5057618edr.86.2021.07.01.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 06:16:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Date:   Thu, 01 Jul 2021 15:06:37 +0200
References: <xmqq4kdft122.fsf@gitster.g>
 <CAFQ2z_PYJMzOBcN+KoQSfdD-eYtZVzrArL0Dh-YW-q3R8hgm2w@mail.gmail.com>
 <CAFQ2z_Opw4dZmH7Xc4tRzMvD-op-Reh3C7sM31VoNM5eAHaiLA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_Opw4dZmH7Xc4tRzMvD-op-Reh3C7sM31VoNM5eAHaiLA@mail.gmail.com>
Message-ID: <87zgv6cgxs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Han-Wen Nienhuys wrote:

> (now in plain text)
>
> On Thu, Jul 1, 2021 at 9:17 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>>>  Futz with the way 'errno' is relied on in the refs API to carry the
>>>  failure modes up the callchain.
>>>
>>>  Will merge to 'next'?
>
> Is there anything I can do to address the '?' here?
>
> I am happy to do a review for a similar sized chunk of other code for
> someone else in exchange for review of this.

I took you up on that and gave that series a detailed look now[1].

I'm afraid what I had to say there doesn't bode well for getting it to
'next' (some style/questions etc. there, but also what I believe is a
serious bug in 8/8 was among the findings[2]).

I'd like you to take a look & review any of my outstanding "ab/*"
serieses (or combinatino thereof) of similar scope/complexity as yours
in return. I'l leave it to your interests & sense of fairness what to
pick which one(s) :)

1. https://lore.kernel.org/git/pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/8735sydvzs.fsf@evledraar.gmail.com/
