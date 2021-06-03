Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E92C4709A
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD2760E0B
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhFCKDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:03:18 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:42562 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFCKDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 06:03:16 -0400
Received: by mail-lj1-f170.google.com with SMTP id a4so6351903ljq.9
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F0iWqqouc+/r+xsgE/aYmwUokhCin2DqPuOgYL850Jg=;
        b=YbV4bEmV6OoliIOSYpM/EC4yb1sbHizgazhc7FF9a+eAvvBckl5pXrmMNR50VptHTF
         HABQz5HhD1VdwJ4SGcuqQthaw09a/XzkpbYTSBPcZc3qhovN0ZZGWjzXaj20pKyufIux
         GNhMBrO/dYHE2RfG7nrh7DevDlqizxcCaHze7CHSO2PqNKoC2clUk3oP62tznvDYokIn
         egifyVC8xBbTm7zD/nTDHa/16NOwRJZXcfzU+YyxLHLkZGxU03Lqss/OqhutoUGcrJuP
         xxvTbT6M2H3eBU9NbSrIyIwC57VczwD0No1yF11O9mRWOnaClZzYmSXffEaOxMsO2PzA
         B2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=F0iWqqouc+/r+xsgE/aYmwUokhCin2DqPuOgYL850Jg=;
        b=P4A1fY/aqINqYHVDV3ZcRM6v3UtHPdjmkDcEbhpxP7GaQwYeBDiWGxsHtFmhuz469j
         dQqIKAQayuqc3WWeqPZ37mkGoiFIazmDg938oFOSMtJOFOqfNpa6AUzf1Menxgb54Efh
         7q6APRYcFiUvCjTuZY88KgVitfRUdUzL+Kg5DfI7gOPYpZBPE376Y1kHl/7M+ixdQpqw
         kgJ4U/jpiIMmqR3Ndzbeby7wB7fm7ucs4BrVQIISF1cm7h1l5Gue+v93A/jnVGgONCSz
         PaVIIRkvSxVFt7JIXEHYqUZjWxqZflqb4nCgHz5Zthw+7a1+rsRnUYcNZj18b4Xy7DOz
         Xhug==
X-Gm-Message-State: AOAM533P45iDSVTS8lmFvEyxzQO+tS0d6WgQUmi2JcPjt9aHfCVyAuoF
        YIeBZGDchWcXyqWQ3sYuDxm1AVJaS3I=
X-Google-Smtp-Source: ABdhPJyLIBIUisS1HvmZbGFvqhISXAd+FfvKGrHRSWf58y1oo6E2RKZZEMysO4tt/dWpPwsz6uKlWw==
X-Received: by 2002:a2e:a547:: with SMTP id e7mr28716207ljn.408.1622714414045;
        Thu, 03 Jun 2021 03:00:14 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i24sm269034lfc.238.2021.06.03.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:00:13 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
        <xmqqzgw9qky5.fsf@gitster.g> <60b6bef41791a_404420881@natae.notmuch>
        <87im2wtqg2.fsf@osv.gnss.ru> <xmqqmts764ae.fsf@gitster.g>
Date:   Thu, 03 Jun 2021 13:00:12 +0300
In-Reply-To: <xmqqmts764ae.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        03 Jun 2021 12:00:25 +0900")
Message-ID: <87lf7r2rpv.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I'm second here. Wanted to get rid of some recorded resolutions, but
>> didn't find a suitable way to.
>
> J6t gave a good summary on a side thread.  "rerere forget" followed
> by "checkout -m" is your friend (alternatively you can redo the
> operation that applied a "wrong" resolution after doing the "rerere
> forget" step, of course).

Well, I was not in the middle of any merge when I wanted the feature,
and "forget", according to its documentation, deals with "the current
conflict".

As far as I recall, I wanted rerere to just forget everything it ever
knew about merge resolutions for all the paths in particular
sub-directory, before I even start the merge, and I rather ended up
doing the merge in a fresh clone.

Thanks,
-- Sergey Organov
