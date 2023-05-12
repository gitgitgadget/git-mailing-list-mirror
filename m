Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FBDC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 22:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbjELWr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELWr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 18:47:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFAC173A
        for <git@vger.kernel.org>; Fri, 12 May 2023 15:47:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f13dafd5dcso11750901e87.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683931674; x=1686523674;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQQ0C7RVrnQQulLjDx3WfYWHc0vSRajNLKZAsYyXTEQ=;
        b=dX9Pzrh8UabKPiFPFks5Qy8miusYDYnFsi8FHpYB9e/h7zk6MmnWdtEXFjh1zk7Sm6
         VU2YksjvOd9lMrZukEuxx2myqXw2A6VGctiARcicE21vzcXg64V8slbodOiZyf+ibrcS
         kKtf8cLS6hbFLWTtYGs0HUHH/ccBKELypXiIMLjiS+AL72KEOXHlYpUgByTwZYXCum4y
         gx0wfo778+1kgE9lFVE95L6BtB03CX498qgrGLYcyrkdpOz8AJSBpzzZ5sscd5OXjlUl
         kZqsUPYlBue2detwp1xyeOVcolUJIEHgU8O0+RZrNTgvUL6aOVq66tOQZyrj8fYZPzjS
         FAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683931674; x=1686523674;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQQ0C7RVrnQQulLjDx3WfYWHc0vSRajNLKZAsYyXTEQ=;
        b=bltizo4x56g7gPjKlCadXU10KOlBFEPtcU6RC9/Xo4MssRmtXuEU/ltlLrq1divVqk
         xh83/XGnqdb+BlxP3OsGcNY4x9V9o27sLBr7P52DRplsF/FTgy/nLpehuCDzwGJOlTBG
         A3P2ohBD0C7Gf0n6uEbQNoKfxGJybxJBpUnqrchnGNHuEpFm19uKKyGR3jx4Au60YGpw
         Fxtn6CdhYcJlr2hONIIDzb9atovJ+szS+/R3WLzrDT2tq9yNEgDuGtuVCZynKqH3xYSG
         2XEUEpBR7voPvHYsTku+Rx8pdC/O3EcZkpZJF+YHzsO1uhSMaOaztjHvbB9USNaHYF1A
         8rDg==
X-Gm-Message-State: AC+VfDxNznTGwpzNyAgfLmu6rgz83btj0U/+kOuUJWJZloZvPu3Ttu4G
        Ov2t3xNdcHcZ78xIg4CaXxP17WIh2W8=
X-Google-Smtp-Source: ACHHUZ4AikXeFQTelxpvkbKpazzh8GOURxA59YJXU0dha42LtAOPLNHTgOHrHReRJhI9pHEqyWSNNQ==
X-Received: by 2002:ac2:4c22:0:b0:4ef:e87e:df88 with SMTP id u2-20020ac24c22000000b004efe87edf88mr3603831lfq.64.1683931673508;
        Fri, 12 May 2023 15:47:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w17-20020a05651204d100b004f14898d18esm1585977lfq.85.2023.05.12.15.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 15:47:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
        <xmqqv8gxpd8r.fsf@gitster.g>
        <645ea15eca6fa_21989f294f5@chronos.notmuch>
        <xmqq1qjlp98j.fsf@gitster.g> <877ctdi5wp.fsf@osv.gnss.ru>
        <xmqq8rdtnqij.fsf@gitster.g>
Date:   Sat, 13 May 2023 01:47:51 +0300
In-Reply-To: <xmqq8rdtnqij.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        12 May 2023 15:17:40 -0700")
Message-ID: <87y1ltgoa0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> Indeed "--silent" or "--squelch" is one of the things that I plan to
>>> suggest when we were to go with "--no-patch is no longer -s" topic.
>>
>> While we are at this, may I vote against "--squelch", please?
>
> Sure.  I actually do not think either "--silent" or "--squelch" is a
> good name in the context of "git show"; as the output from the
> command consists of the commit log message and the output from the
> diff machinery, and "-s" is about squelching only the latter.

Yep.

>
> I have a name better than these two in mind,

--no-diff?

That said, in the context of git log/show, as opposes to git diff, it
all could have been:

  --diff=<list>

where <list> is comma-separated list of options to pass to diff, and
then it'd be:

  --diff=off

for the option in question with apparent synonym --no-diff, and less
apparent synonym -s.

Hold on! Now it starts to sound familiar... --diff-merges! )))

Thanks,
-- Sergey Organov
