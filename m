Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E53C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 06:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203DF60F4F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 06:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhG0Gbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhG0Gbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 02:31:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199DCC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 23:31:53 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u10so13998919oiw.4
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 23:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ihbf63FR/J4GzNbrFBanpgciD99It3Vts05SQ0Ab3PA=;
        b=F7gZiIOfduCMo61L1dXssNaDGD2crvvd5+DPi/7ogv/s2I1vWCoHAaHs/iKbsyVEYD
         6C1L01w00OfrGqptR55xu3rsJoVoBkGvUWIaThsAWyroXxuD33Q41O0y+hTksOQkx85h
         3BkK/ql3p78SMFY3hY7xdzJrNhMXNdEeHZyzNoHxECK3w0eJTn9Vx8ArsezZReKenYP+
         HW/P/8OkyH51o5KFDVECrvRqt9atXkZB1eV6JpBFmIdADnz5BCfDeeGLAUO3lZ5MLYoa
         5uYlwKSvvmc+708aYkbv4CPZO8LQKjsPioTRZH0f5jR7bgKIyM9WATuq2b5jHvbkGW07
         i97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ihbf63FR/J4GzNbrFBanpgciD99It3Vts05SQ0Ab3PA=;
        b=fUtM63TWlpvs1twdCaoIlmC6a2WT0YTZZP2tVWghsm5FrKoN+BHcfpWkTdZUdS5GPF
         CKZSgU2ZGAVX+e5AK3RvqPAc0FceIiKgY1yPMeiC0YLUsQsveHRAdv10gJjpsD7SFtim
         tz/GAHeB9FIcgQqcFyK97VyUsGV22MX0V8sIn3sRlnzod1G1FhszWB9QlxJh9uX6xV4W
         qGXDaM+GhB0bmbHiAyI1aYf4Ufi5MxZrifFD2EvCRm2neJLl4g5jlGpyKdlAJY74GKRs
         /EhmX7iHJmgJ5OpHtc4vi6VPpn9arBKKdRexZG23p6rMDGwScVUDlZPxxV3Q3LdsseVI
         jFwA==
X-Gm-Message-State: AOAM533OfOXHHbGyMUiaZVnKpXRV1eut1YsR/Pl2m6RD6ZAJRyKd91Ik
        cDxiYHOqKZ+VQzPMeKTZwhk=
X-Google-Smtp-Source: ABdhPJz6OWD3Z80Z6suGTBPQuRsNzhfWFFXcMkwdDCmLJluHo3ve/J944JNKYXTtbklAiDYJom9CuQ==
X-Received: by 2002:aca:4406:: with SMTP id r6mr13614765oia.50.1627367512481;
        Mon, 26 Jul 2021 23:31:52 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a192sm369931ooc.10.2021.07.26.23.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 23:31:51 -0700 (PDT)
Date:   Tue, 27 Jul 2021 01:31:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git List Mailing <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>
Message-ID: <60ffa856a332d_7d082086f@natae.notmuch>
In-Reply-To: <xmqqeebregns.fsf@gitster.g>
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
 <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
 <xmqqeebregns.fsf@gitster.g>
Subject: Re: [PATCH v2] pull: introduce --merge option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Wed, Jul 21, 2021 at 6:47 AM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >>
> >> Users need to specify if they want to either --merge or --rebase, but
> >> unfortunately the former is missing.
> >
> > Ack. I think it's just historical, because long long ago it used to be
> > that 'git pull' always merged unless told otherwise with --rebase.
> 
> The "--no-rebase" option, which is documented as a synonym for
> "--rebase=false", has been there, but the implementation is buggy in
> some corner cases, which has been worked on recently in a separate
> thread.  I do not think it is too bad to add "--merge" as yet
> another synonym for "--rebase=false".

Any particular reason why this is not a topic? [1]

[1] https://lore.kernel.org/git/xmqq35s0fj9o.fsf@gitster.g/

-- 
Felipe Contreras
