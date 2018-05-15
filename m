Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CFD1F42D
	for <e@80x24.org>; Tue, 15 May 2018 07:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeEOHec (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 03:34:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38404 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeEOHeb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 03:34:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id m129-v6so19475617wmb.3
        for <git@vger.kernel.org>; Tue, 15 May 2018 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9+fFMElKxDgcgF3AOQ7D7cRF6Yr+HQMT8NyysnWToe0=;
        b=fqytndvF6i404Pc1wEHIZxigPDk/DtXyg88tW/q9CaLOnsHsBpwgdWUb5lZVM682rS
         KzVHSciX3N2M5as3jc4ft9uK580Vwa2v+NckFjgYJ2Trq5QxMnncYnceao+ZPbFsRPhD
         3A1R7O5rvacUqwTSx7tfQEbGe1iFrQzF6jQHFaX6XAt0KF2HySWVoQy/nW0LXPWKZn3W
         ksTzDVWj72cr4QwWw/onARj23UYPmQuoBDBtLyu/PQTb1rzc50se/TBmAeiHMoKc0A9x
         4y/ipmPDsumYXrw9GAUCQPqORDAqKsJVHd1ztEqclM6AQmVf92FNCqzFFDxU32Dzj0R8
         bHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9+fFMElKxDgcgF3AOQ7D7cRF6Yr+HQMT8NyysnWToe0=;
        b=rVwYqSvzP/mKdbFL/aoJW98uCyi7UIWb3QNLHOb2REitsVL0POQnzTiZlhPEpxcEei
         1UX37YxyEbnTsGsg+Q5ssvdECwhD9d5rw4Qai4vR1gux+EB0dAzQt1zbiTPtuy1ZUcPG
         GfqoWysICj96C6E8dJpHswYYbxocVC9gWrity3I5t1vrzfnx6FUF+M0HKHF5ANAvY4FR
         20mXmDOg6gnlH+Q3MF+dIb7WLtOkB+DrL+GH3amurX4x3kRY/TA00aG8b4VNAWH3rVmc
         RtpxFqLZo/C6Lwi9xuOc5yQR1a8VMUphfOcrT4GydgYqjHFRcU3cPdr50svVSG4vcPzp
         bQZQ==
X-Gm-Message-State: ALKqPwdbt/3e+EMTw5PAeAsDV5H7q2xrzgF+Xx+342RevhvdOsSfmimF
        qgSQy/BzvoJiQQjFqBUt3hg=
X-Google-Smtp-Source: AB8JxZryKSu3UR3TdD2cV8Y197RPhYeQcOjorcoHKIQ6bQigDFPTgJMZ5cyhCrCLOjFAvpXFgVTG9A==
X-Received: by 2002:a1c:c6ca:: with SMTP id w193-v6mr7078349wmf.68.1526369670135;
        Tue, 15 May 2018 00:34:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m134-v6sm10671027wmg.4.2018.05.15.00.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 00:34:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Leif Middelschulte <leif.middelschulte@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Inform about fast-forwarding of submodules during merge
References: <CAGZ79kaiFkq20Com7gOLin371D2KhTPG7cqn1mQ6OaFU12kKPQ@mail.gmail.com>
        <20180514205737.21313-1-leif.middelschulte@gmail.com>
        <20180514205737.21313-2-leif.middelschulte@gmail.com>
        <CABPp-BGp_zP8Z2S8FskiNvhNeQH3f=HdnQ39vX6xQz=oSyVfMQ@mail.gmail.com>
Date:   Tue, 15 May 2018 16:34:27 +0900
In-Reply-To: <CABPp-BGp_zP8Z2S8FskiNvhNeQH3f=HdnQ39vX6xQz=oSyVfMQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 14 May 2018 18:17:09 -0700")
Message-ID: <xmqqzi118j98.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi Leif,
>
> On Mon, May 14, 2018 at 1:57 PM, Leif Middelschulte
> <leif.middelschulte@gmail.com> wrote:
>
> Thanks for updating the patch on top of Stefan's series.  :-)
>
>>         /* Case #1: a is contained in b or vice versa */
>>         if (in_merge_bases(commit_a, commit_b)) {
>>                 oidcpy(result, b);
>> +               output(o, 1, _("Note: Fast-forwarding submodule %s to the following commit"), path);
>> +               output_commit_title(o, commit_b);
>
> Level 1 is for conflicts; I don't think this message should have
> higher priority than "Auto-merging $PATH" for normal files, so it
> needs to be 2 (or maybe 3, see below) rather than 1.  (The default
> output level is 2, so it'd still be shown, but we do allow people to
> remove informational message and just get conflicts by setting
> GIT_MERGE_VERBOSITY to 1, or request extra information by setting it
> higher)
>
> Also, this two-line message seems somewhat verbose compared to the
> other messages in merge_submdoule(), and when compared to the simple
> "Auto-merging $PATH" we do for normal files.  The multi-line nature of
> it particularly strikes me; the merge-recursive code has generally
> avoided multi-line messages even for conflicts.
>
> In comparison, your original patch just had ("Fast-forwarding
> submodule %s", path).

FWIW, I share both of your surprises.  Between level 2 and 3, after
skimming merge-recursive.c for existing use of output levels, I
think the situation for non-submodule merges that is closest to
these two cases the patch covers for submodules is probably the
message given when content merge happened to end up with what we
already had.  It is part of a normal merge operation that is not a
singificant event in the larger picture, yet it is rather rare and
interesting when you are curious on events that occur infrequently.

So a one-liner message as everybody else emitted at level 3 or more
verbose would probably be a good balance with the remainder of the
system, I would think.

Thanks for a review.
