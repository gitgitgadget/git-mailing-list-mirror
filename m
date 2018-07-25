Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532731F597
	for <e@80x24.org>; Wed, 25 Jul 2018 18:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbeGYTim (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 15:38:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46693 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYTim (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 15:38:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so8274551wrw.13
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f1dyt/GCdU/9NX72vCCNbejzrcYE0j8GSoeuIu/FMv8=;
        b=KC/X2IWrX5w/p38gRbv/GBx7MVXU51Krrz1MZ0UuiidxmInjbpOKSYbY1N9GNpvyhJ
         krSCJB915YXc0QH7Rkr51LSudjwK5tjBvbXTcbvagkbeujrOc2Hkeo5bZVi8eDvXQ+y/
         6kOvkBWDVBvk9eMQB7EA1iYCR1lg+U8d5Nn8XcE2ynCswdtnLAyKQ0Z4MS6J6rmd42iM
         RKG53xAR8jZ2bAA3GV0SSoCGrKBzB7jxzFsf/D0fyYGgPfgn1DzpCAwyu0JLEU6xevic
         wibzrS+x17/aRhe4tn8oeodwPEyAdn/70963ilF1gC9QE+zdViuxy5EN9EizBy6KPx8s
         yn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f1dyt/GCdU/9NX72vCCNbejzrcYE0j8GSoeuIu/FMv8=;
        b=EcRpRIIaLDN2uLtvJbWnt2OtmBHIkEmBKd5jEhWLn2vbP4/gOkKZx5O8xpD7ymVoGn
         C1XkjrOaHhDU9uw0njNLdl5/VXATHe22fmKT/iggtURxIRxE1Myc/jWPuaRMZWPcOzzr
         sgSyAf7H4szUYBWKcGNj8IHURMtX+p5pV+1PJmRVZcs+ufvXMJhAdnzgbGB85GEkOIBN
         2GBV+6qOjYffRT41oYvgrCsk0zbsQkqCsoseI4JRndPeumjjAn4k4qo1N1/dXHicjT3j
         uXzbDZ6cCwHaBlWeihMqsG/GlqBvcYuT1VRvUA4KFKzSW9L5ok8NmG2r0jVgHg2OY+O7
         wyxA==
X-Gm-Message-State: AOUpUlF5AUTsQDJZYziitlIZNE2mL73prG3I1Qd2W32UOeBxnDjHinS5
        BZtJhSHyDEREqxx7vCjOTjI=
X-Google-Smtp-Source: AAOMgpeI8XrPTxem6OhmxkIBEYdn5SJ0Amczd5/mjp+/l7PU27FrjjK96wzAlKWCMvKdUnS2X7b4WA==
X-Received: by 2002:adf:ac2d:: with SMTP id v42-v6mr15509214wrc.142.1532543149599;
        Wed, 25 Jul 2018 11:25:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a11-v6sm15183731wrr.81.2018.07.25.11.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 11:25:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 07/14] range-diff: respect diff_option.file rather than assuming 'stdout'
References: <20180722095717.17912-1-sunshine@sunshineco.com>
        <20180722095717.17912-8-sunshine@sunshineco.com>
        <CAGZ79kZ0OMrU_O5_rPdG7bNHRWQxVV1RguEg3g-pOa+kkgPCaA@mail.gmail.com>
        <CAPig+cQtzs5ENzOR2sJVkZu13OF7iMnEcf4GG1jKGrzRhE0AUg@mail.gmail.com>
Date:   Wed, 25 Jul 2018 11:25:47 -0700
In-Reply-To: <CAPig+cQtzs5ENzOR2sJVkZu13OF7iMnEcf4GG1jKGrzRhE0AUg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 23 Jul 2018 19:20:15 -0400")
Message-ID: <xmqqmuufuq8k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jul 23, 2018 at 6:59 PM Stefan Beller <sbeller@google.com> wrote:
>> On Sun, Jul 22, 2018 at 2:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > The actual diffs output by range-diff respect diff_option.file, which
>> > range-diff passes down the call-chain, thus are destination-agnostic.
>> > However, output_pair_header() is hard-coded to emit to 'stdout'. Fix
>> > this by making output_pair_header() respect diff_option.file, as well.
>> >
>> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>>
>> Depending how much the range diff series has progressed
>> already, it might make sense to squash it there?
>
> It could be done that way, though it would be nice for Dscho's
> range-diff series to land without another re-roll, and it looks like
> I'll probably be re-rolling this series, anyhow, to move
> show_interdiff() to diff-lib.c and to fix its signature. Junio could
> manage it as a "squash", but that's probably more work for him than
> for me to retain it in this series. *And*, this change _is_ required
> for this series, whereas it doesn't really matter for Dscho's series,
> even though it's an obvious "fix".
>
> Anyhow, whichever way Junio and Dscho would like to play it is fine with me.

Having it at the beginning of your series (I consider 1-6/14 to be a
separate series, on top of which another series whose first change
is this 7/14 is builds upon) like you do here is probably fine.
