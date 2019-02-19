Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,RCVD_IN_RP_RNBL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C07D1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfBSWaA (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:30:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37931 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfBSW37 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:29:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so4409113wmh.3
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=10Tx4U8TT5zUfZerBA+J6/k/nGdg1WeGl48WuSowdUU=;
        b=gvabeXDWM/2W733L5cibafU5+PrYPIt63OtmiNoeKLNLW0bNspQILACN2m/yt4Uu3+
         df0ukJtqBqGPfuNhTeAvpTFi7nJdLx6id6SzhTxUsyk1TQD4GYaoMhbObAknGpl6oo32
         qaB9srWDEO2eJel2ffdU3WcHdFonRrlGf1hBsOwNrDKSk4/BiAdo6flY163jBDxnv8hI
         toKoMAso/yhHdwdPZs7FgzPTVw7NRbijt9imFjW2haf2YQ7W9f8zJeh1op9+ose4jYvX
         P+Lf1ooArybv/5qKzdoR5ptMC27PDmhHWxdAoCq5+7PdqIeniMDn6u0Bv/86vlyUZfJX
         hQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=10Tx4U8TT5zUfZerBA+J6/k/nGdg1WeGl48WuSowdUU=;
        b=S33N1hItC0iBTx6RBsK51uWR79gbCFWS+RqmbqwmFJWZr2SW9jaR6hJffzzyy8D2CW
         4hGPwOi3SzsEiNk/8ekLNuAXG6NJUsEk1wvKBa3yqNHEGXRT6MWEpnF6U1mK8QIIkdl3
         FfVpy/oF54FUK84aZ09foGe7v3h4gYS0+6s70YySbrI7L1JCjOyiRceAWUH39EPi6eIN
         Xho2vsWO5Z8Sby98ROGeqLzmAceNyKs1lj+TFq1cZRKOXNj/QffI23MtGsTH/Gq3jU0F
         4L3lDgNMlHJ2HC35ddGXYmwuQ3SvhXQYBkbZlzTcvNu9qeyaUiWLjZ54PqudVSMJXD3w
         MVMg==
X-Gm-Message-State: AHQUAuZqrcMIVYV+VP6ztl4UYKP4bPfqlACPLKslgaL1N29f/i+0vvsq
        MFEUGNda7VAgJAK9tWQyh7U=
X-Google-Smtp-Source: AHgI3IaQZna4XZrJRnKvdmlvOjwVRDiVCVq1GMsfF9JfeHfFuWeaX9Ej9K+bbtrmhkI7ottNL4ZJxg==
X-Received: by 2002:a1c:eb1a:: with SMTP id j26mr4154794wmh.127.1550615396940;
        Tue, 19 Feb 2019 14:29:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o5sm3863512wmh.12.2019.02.19.14.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:29:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
        <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
        <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
        <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
        <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
        <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com>
        <xmqqo9771tnj.fsf@gitster-ct.c.googlers.com>
        <CABPp-BERuEtdjHhqaao+2=rsLXiPdkG4SbeULQ6=59hgWS5BLg@mail.gmail.com>
Date:   Tue, 19 Feb 2019 14:29:55 -0800
In-Reply-To: <CABPp-BERuEtdjHhqaao+2=rsLXiPdkG4SbeULQ6=59hgWS5BLg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 19 Feb 2019 14:04:56 -0800")
Message-ID: <xmqq1s431kf0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Feb 19, 2019 at 11:10 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > I am getting the impression that to save typing, you would want to
>> > make "--index --worktree" the default (i.e. among the above, only
>> > --no-index and --no-worktree need to be spelled explicitly), but
>> > there is one glitch.  Updating from the index must be spelled
>> > explicitly with "--no-index --worktree".
>>
>> And after getting reminded by Elijah, the default pair is
>> <--no-index, --worktree>.
>
> Why would you want --no-index or --no-worktree as flags?  That seems
> to presume a default of modifying both the index and the working tree,
> as these names imply undoing pieces of such a default.

By "flags" I think you mean "treat them as two orthogonal booleans"?

It was just how I read Duy's examples (especially the "both --index
and --worktree given" example where "--source <tree>" becomes
mandatory).  I do not have strong preference either way myself, but
I tend to think that treating these as two independent booleans
would be a way to make it clear that the new design departs from
what we have been doing (i.e. "--index" means "both", "--cached"
means "index only" and if we were to introduce the "cat-file -p >"
variant that would be called "--worktree-only"; in these, there is
no "two orthogonal booleans" that can be mixed---instead they come
premixed).

> I'd rather have a flag like --worktree which alone only modifies the
> working tree and is presumed to be the default (but useful to be
> explicit or as mentioned later), have a flag for applying the changes
> to the index instead (--index?), and treat applying to both the
> working tree and the index as unusual and require either both flags
> (--worktree --index ?) or some special flag that likely has a longer
> name (--worktree-and-index?).

So you are in favor of pre-mixed set of options, all are mutually
exclusive.  Which I am perfectly fine with.


I however do think "both worktree and index" is quite common when
tweaking the tree to prepare for the next commit.  A path with
contents freshly taken out of an existing tree may not match exactly
what you plan to record in your next commit, and you would not be
recording it immediately in a commit as-is.  But having the contents
taken from an existing tree recorded as the baseline in the index
would make "git diff (no tree-ish) <path>" a handy tool to review
your progress toward the next commit since that baseline state, in
addition to "git diff HEAD <path>" that is the usual "how does the
overall change relative to the parent of the commit I am preparing
for look like".

So I'd hesitate to endorse "a deliberately longer and harder to type
option" to populate both the index and the working tree files at the
same time.

