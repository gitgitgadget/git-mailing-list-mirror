Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F911F404
	for <e@80x24.org>; Mon, 19 Mar 2018 20:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934991AbeCSUqc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 16:46:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36792 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935056AbeCSSKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:10:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id x82so4647782wmg.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SAk/62goct6QTRf6pBUAODwki66SbnTL1YSHkcTIUIE=;
        b=pTWFgoPIuXhaHRfqznzIW5wmeJ9VZRZhtKHsLM2Rh36R6Q/qbXSuCXTrRdvqnuWNz4
         XdV09tBOxJ7pjywEY431wOwHTMBZDi2XyIzUHQWeKnOh0Ic/5nL6RhhS1RyAUurJks5K
         W6V10qMis+L6CMEYj7xx1WXRsdP/T4PW6LCOm5zhC2DtBVWgeZ67GLTgYReXDd8i5Ng4
         y43aQ4d1qnI5Vywj2vXbcEGaA7P3ORZNww4+jC8/HgPmaGbfNn8iPQWGFvpkq4WQF5QA
         ynXLHW0lo8AzRHGOuGHe4S3ekk5FvTWiv4znn6RZy4P7Lk9sBHaZ+iVLkw+aiGE9GOwJ
         VmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SAk/62goct6QTRf6pBUAODwki66SbnTL1YSHkcTIUIE=;
        b=f52KIflvlyJv0K6JDFpPnJEO3HvDEuRnH1X64tOEJnh4ojCUecEbR1tzaNnzwVuj39
         DiOeGQpMg/XeC/CitfdSl35HkDKmuVq7xbHUY4C8N2Zm7v87QVgGjg94NOJupoRD54ux
         psYNjYnA4beklp9XdkAAEHnYezmeNOun6FzYpyUdSg6ncG5kwVZgikiNqOwHh0BE4A6R
         nThVSAa8OTJ47mInbzZFfOqBz/EvsYNNhBUa7n8TZzQhZo4FW1L7V5g3gZgPdrk92cf8
         L/qTh5sT0bav5EyHWKvyCOtX5p5uUsBWiNK+APlqAPqRzOqjaCZqIDpI/VhmnbO1coem
         20kQ==
X-Gm-Message-State: AElRT7HXOsQX5G1lfUqHSVPs3SU3s1QCA9F+USLAkDxzoD3WhNnzhHaa
        T64Jz8tdBcmVHZ5yImuItIo=
X-Google-Smtp-Source: AG47ELtHIuzDjNbMnH8ZTT35w4zlHPruJv5NGxOnHWJthSwXega/N752sxqC8mr0Dw9KBKWZWyM5wQ==
X-Received: by 10.28.234.207 with SMTP id g76mr7140763wmi.149.1521482999719;
        Mon, 19 Mar 2018 11:09:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c34sm727333wrc.60.2018.03.19.11.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 11:09:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/4] worktree: improve message when creating a new worktree
References: <20180317220830.30963-1-t.gummerer@gmail.com>
        <20180317222219.4940-1-t.gummerer@gmail.com>
        <20180317222219.4940-2-t.gummerer@gmail.com>
        <CACsJy8DvUB7Sv6m384ccgDPnMnFfD80W5EZ=Pbkj8cyhFO_OqA@mail.gmail.com>
Date:   Mon, 19 Mar 2018 11:09:58 -0700
In-Reply-To: <CACsJy8DvUB7Sv6m384ccgDPnMnFfD80W5EZ=Pbkj8cyhFO_OqA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 19 Mar 2018 18:11:39 +0100")
Message-ID: <xmqqpo40uebt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> @@ -320,10 +318,19 @@ static int add_worktree(const char *path, const char *refname,
>>         if (ret)
>>                 goto done;
>>
>> +       fprintf(stderr, _("worktree HEAD is now at %s"),
>
> We use the term "working tree" for UI and documents. "worktree" is
> only used in code comments and stuff.

Hmph, that is a bit different from what I recall.  "working tree" is
the phrase we have used and we still use to refer to those things
that are checked out (as opposed to the in-repo data).  We say
"worktree" when we want to stress the fact that we are talking about
a single instance among possibly multiple instances of the "working
tree" that are associated to a single repository.

Technically speaking, the traditional "working tree" is everything
in the directory immediately above ".git/" plus ".git/index"; a
single "worktree" consists of a bit more, as we have to count per
worktree states like .git/rebase-apply/ and .git/refs/bisect/ as
part of it.

And from that point of view, HEAD is one of those per worktree
states, so...
