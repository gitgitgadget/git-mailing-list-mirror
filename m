Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF20C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65D261051
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhIJFTn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 10 Sep 2021 01:19:43 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:39637 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhIJFTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 01:19:43 -0400
Received: by mail-ej1-f49.google.com with SMTP id a25so1760363ejv.6
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 22:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0WOnKOiohFjaiXFbqFLG3zD4bw2PIzTju2l66dYvar0=;
        b=wEUvWbKYFdtfzcyGoDl+xluSRs5SYzynPWZ/JDoPa/Uc6sOgKWO0f2z72by8OykP4p
         2Zk0BlucUAdjzV5m/MGnfu3Utb4UBRNxsdvO4Bq7sdKPfHkYuYi/Z7Lrs3a60z0b1Qo6
         gUPWRIo0UJXMblZ5osoAuNKnTUOhQNk74tOPFwd/D/t9RfePpWTqXxGvzL/TI8mxYcGc
         gii7EECtc5W+nycDwzt+c7Pl/AAH/6mtYorClEge7Yh5q3bKhNniAiVTFOzL5burLx4Y
         vhHzmz/BwNr2G8NDxyx/GYS3XHPikxNkV5UgQIEianau8bDH9Hk67wPGaf2+M6aM3Gax
         zJDg==
X-Gm-Message-State: AOAM533eq4GxQOqeyjXY4UBKZH8xhJ8sU39erZbdNIKlsZI82UV/lR7U
        vyB6HLu0d8BI98J3Nn2iO8xTzkgd2vHz3pPGO3c=
X-Google-Smtp-Source: ABdhPJxVpq9ATvwrVOlUhzqTzju8r4KYNwoLvNp03yjBIy0fKFuIo1vfbAsqXA2tZnXMRu51L6raROplX5qwjf98m14=
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr7370788ejd.568.1631251111862;
 Thu, 09 Sep 2021 22:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <20210830072118.91921-4-sunshine@sunshineco.com> <xmqqwno2505w.fsf@gitster.g>
 <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
 <xmqqeeaa4y0v.fsf@gitster.g> <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
In-Reply-To: <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Sep 2021 01:18:20 -0400
Message-ID: <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 2:04 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> In the general case, such an extraction mechanism would be far too
> fragile since there are no guarantees that the commentary in the
> "Notes:" section hasn't been hand-edited after patch-generation.
> However, it's certainly possible that such a simple-minded extraction
> technique might be applicable in some well-controlled development
> pipeline somewhere.
>
> If we are worried about that, then we can drop this patch series.

Have we made a decision about whether this patch series -- which
avoids indenting blank notes lines -- is desirable? Or are we worried
about backward-compatibility? If we think there is value in this
series, then I can re-roll with Ævar suggestions. If not, perhaps I
can re-submit just patch [1/3] which makes a few tests less brittle.
Or, since those brittle tests aren't necessarily hurting anything, we
can just let this series die.

Thoughts?
