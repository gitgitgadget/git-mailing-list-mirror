Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE07CC433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B49822507
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 18:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgL0SC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 13:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgL0SC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 13:02:28 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563B5C061794
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 10:01:48 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q205so9431728oig.13
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 10:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FZ21dHrF4Q/nxK2uam8AxS5Fn6XBiLIlIeIW7W0Ea9o=;
        b=Rng4TBtEWZ0fd3raum5rveovNhSOlRToiel7gAeq0nzfyo3ISBpSr2LiO2LMRp6KlK
         E1rsgHUZs6ILH61vQLYkgyjkS0/dsYFyrraIi4TvgalRPY1VLEvuW/pEnZPPGjToBCkl
         skxJ5dXuGqhU1cj0+S9UKmQEWMJa9KwU4rMlh2qobfhUxSuKeElo4/jO1q18VyNPU/Ii
         CMRIj/5W6TC0BO0WwB8ImMLMHiYNfheCCHQuC5zUdOVxbql1p6HLcUmolt9CpopKHObm
         MqZrOnoetcqRsYFpEJo9a6JsvYgmnjOpF4yOVvFMFbRelSXU5fIZRySWxAM/SHxZHI6a
         234w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FZ21dHrF4Q/nxK2uam8AxS5Fn6XBiLIlIeIW7W0Ea9o=;
        b=O8xNeNZkQETQmAmelV78rLFjILzBBS0LzJ01X0XZydyjRxBo62jlWZVXuWik1xN0gb
         zjCfdBIMv5MN89b9J1ad7Raq62jtUu2G4DoiHoAChqv68eVELCTBqYXNy96PKaEku0C6
         AH/SVdJqeMyiIBnumlvX53VvdoGeYXc+vdWwq2Pv0cfQPNaKRT2moYuSQkJ4ch8PlsmN
         QBPmQJ/0WqyDRf6rGsJE2f8acy3kOh+Hga72xiVBzgdwqKcGwGcvpWwVTRddYGp4iinj
         +AWROGOkzHh0WQWqaox1HVHrcBxHtWPrEoCGtNdYMphK5mnaLgInoRYUz5mWkG6FyrNB
         nIGA==
X-Gm-Message-State: AOAM533PtTPJmTF6WU4FN3unhEBtlFzuzGayi0IerZW0S1Tkmn7y+c+V
        A1AKcFpcVB948qi3P9ED864=
X-Google-Smtp-Source: ABdhPJxmMtaaUdo8q0oaPPFTxyzfXQo+FaH4YmdvRYWfrb9lNtqjUXpiqLF8fif2uadTHAz0ANgiYQ==
X-Received: by 2002:aca:ebd0:: with SMTP id j199mr9901153oih.155.1609092107601;
        Sun, 27 Dec 2020 10:01:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m18sm8681509ooa.24.2020.12.27.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 10:01:46 -0800 (PST)
Date:   Sun, 27 Dec 2020 12:01:45 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fe8cc0998fc0_e22d208c5@natae.notmuch>
In-Reply-To: <xmqq4kka3ke8.fsf@gitster.c.googlers.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201223045358.100754-2-felipe.contreras@gmail.com>
 <xmqqblekabof.fsf@gitster.c.googlers.com>
 <5fe352e3968f6_198be2083@natae.notmuch>
 <xmqqblek8e94.fsf@gitster.c.googlers.com>
 <5fe3dd62e12f8_7855a2081f@natae.notmuch>
 <xmqqv9cs3uxo.fsf@gitster.c.googlers.com>
 <5fe3f083f27cd_7855a20885@natae.notmuch>
 <xmqqim8r4tjh.fsf@gitster.c.googlers.com>
 <5fe4baed206cc_19c9208e8@natae.notmuch>
 <xmqq4kka3ke8.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> >> Yup, I already mentioned UI mistake so you do not have to repeat
> >> >
> >> > You said it was a UI mistake, not me. I am a different mind than yours.
> >> 
> >> Yes, but the point is that I do not need to nor particularly want to
> >> hear your opinion on the behaviour of "git merge-file".
> >
> >> I know (and others reading the thread on the list also know) that the
> >> exit code of the command is misdesigned already.
> >
> > Unless you can read minds, you don't know that.
> 
> Actually I do, because they heard from me already ;-).

They heard that you *think* it's a UI mistake.

The fact that you think something is a mistake doesn't necessarily mean
it's actually a mistake, and other community members might think
otherwise.

You do not dictate what others on the list know.

> >> Again, please realize that on list discussion is a team effort to
> >> come up together a better design of a shared solution.
> >
> > Which is why agreement in a team with different minds and different
> > viewpoints is important.
> 
> It is not like opinions on all points are important.  Whether the
> exit code from merge-file is or is not a UI mistake does NOT have
> any influence on what we were discussing.

Which is why I initially did not express such an opinion.

But you did, presumably you had some reason to do so, so I simply
did the same and expressed mine.

> I am already trying to ignore your opinions on things that do not
> matter in the context of this project, as you told me earlier ;-)
> But just like patches, messages are written only once but read by
> many people, so I'd always aim for reducing noise at the source.

What you consider noise others might not.

Good writers say you should not assume what your readers know.

Yes, some readers might think exactly like you do, and they don't need
what you consider obvious information. But for every person that
thinks exactly like you, there are dozens that don't, and it's those you
should keep in mind.

Most people err on the side of not providing enough information to the
minds dissimilar to theirs.

This is called the curse of knowledge [1].

I try not to do that.

> Anyway, happy holidays and pleasant new year to you and to
> everybody.

Same to you.

Cheers.

[1] https://en.wikipedia.org/wiki/Curse_of_knowledge

-- 
Felipe Contreras
