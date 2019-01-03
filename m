Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7331B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 23:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfACXjT (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 18:39:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45206 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfACXjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 18:39:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so35105191wrr.12
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 15:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sXHBe32MfoIewh5M4AZ1UshDPSxCniIGyXXiDonN40M=;
        b=R+DQRjZHtoHb7kiQEinKylCC4KTwD333nHEZQZ4JuH0P53M1yG8EerdjuVzuT8Uj87
         m9JG3mXAcjBBfpB6g4cjJGSayruanPDykIO2SDuS/KWJBMFjuHytXxWGNsBm+Th4Dcx0
         gz7KUPawsqJy+iMVo8uur8uHd9GTJoDCqUfsmus3olcQcBIbr4NgMsNdQ772TsoWBPRY
         BOLl27Ankj8t0tp85l33WOEUbkbtx3Qcpn3dhucVvlsNXfAksrqdhTza4IACntISTo2a
         Xi1iC75LnLf2crxdNeDdsdnuwQuWpuIXQRW2ZU4ye6gKS4vX3Qs6S7y4rKZBxEOsy8r4
         87pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sXHBe32MfoIewh5M4AZ1UshDPSxCniIGyXXiDonN40M=;
        b=uFLGAsufnU/S7FPpZQ5euy5DyR1u2Fu9UMQDmFI2rAqGaMz2LkHkxVRY4dy8d9/ngK
         de589fH2cN0wO01Y4Z50HHcobt6RCW4uz4kdQkq6DHFYOepafLDhq6TmJJW4MqAEESnr
         ed92BTKzk/ZvA4lTU7HAFOtMtz6x1Mf80gU5DRQiv0XkNKd58Wc72+wsDfCZ98fn/g77
         fuiMHolDIipcygkaXrrlLmnfeMX6p7F2VvK5U2G8I9D9tCdoC0JGdHDqnmuT48LLFTKg
         qzfVbyvwZh4mtiP89rA5bWJjQlKRWNNTTLCKGSyhM7kx7vldmDemmfbVSgTfMUrZOMvA
         bLFQ==
X-Gm-Message-State: AJcUukcP5Jmqd1QMYaVamNKoYRqv59SvoMQiAtJIovLHkM9S90po5yCc
        hhtvnbawxbzQz1X4/VB/Ogc=
X-Google-Smtp-Source: ALg8bN67EswJkuZX+TDApuRUcyzarHVWowBW1j96/2fHpV+r0SgHswNVzdMGsCy5LYkZsvI+7Y+WhA==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr42015418wrq.38.1546558756813;
        Thu, 03 Jan 2019 15:39:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r69sm47356026wmd.4.2019.01.03.15.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:39:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 00/26] Convert "git stash" to C builtin
References: <https://public-inbox.org/git/cover.1542925164.git.ungureanupaulsebastian@gmail.com/>
        <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
Date:   Thu, 03 Jan 2019 15:39:15 -0800
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Thu, 20 Dec 2018 21:44:16
        +0200")
Message-ID: <xmqqa7khfh0c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> This is a new iteration of git-stash which also takes
> sd/stash-wo-user-name into account. I cherry-picked
> some of dscho's commits (from [1]) to keep the scripted
> version of `git stash` as `git-legacy-stash`.

I took a brief look and left a comment on 04/26 last year.  I had
some time blocked for this topic today to take another look at the
whole series again.  Thanks for working on this.

It seems that the last three or so steps are new, relative to the
previous round.  I made sure that what is added back at step 24
exactly matches the result of merging sd/stash-wo-user-name into the
current 'master', but such a manual validation is error prone.  Is
it possible to avoid "remove the scripted one prematurely at step
23, and then add it back as 'oops, that was wrong' fix at step 24"?
That would have been much more robust approach.

Thanks.
