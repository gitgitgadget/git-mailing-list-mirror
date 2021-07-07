Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13006C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 20:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00C661CCC
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 20:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhGGUt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGUt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 16:49:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B58C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 13:46:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so7659921lff.9
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WCHfgFVQaqdsTz3QzQJDzvs7NLmODi5D/qu7Yxs6N3I=;
        b=B90bf+jGg9f1oDR1UPZ0XQlPgMlRds8llJTOZY5HwjxHcCe4lFz/6sEDeiQ3f1XLg8
         VaekMtTtBR9B7A7khr8OvWc3jB1Qa6VLgq6voEWS+OIAI1Z1ba93z98GPoTpAJYcB/aL
         motq0web2VneZoyE58ooSaNpbkEq/yS0R4HczqJ63VzGSRV+DY8w1vva/6BNoyM4uPC2
         /lciQDcdLg5j2fuIVRSu9/cgRoeZ6uX6sawKHF5nnieoOdlfhn3NOqT40lAgikTbQH9x
         lvzYzzQ8SRSGgZ5ccZHo4tbSE6Brhs3Z6gIE9bVm46K/CRAdMNxny75XPCG/jJ7ErwB3
         VmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=WCHfgFVQaqdsTz3QzQJDzvs7NLmODi5D/qu7Yxs6N3I=;
        b=ml0GZGObPGw8A6dEXGbgwGCUxHKNJtwqiBTuRHCZemR7vPiohzg3rISpl7fZHvaYOF
         sL55P7bdvDSIKerNlsqQySUVpxLuB8pomQrWz1j5s5hAr1xVFvmiOoAkQqLbN5f3T6r/
         1CB9FgfQE/V+1GI4vfFQWPxun/EaUjEryaMZIw//rJT+APhMCAdr38jLo3c/prXQChWQ
         NYZ5upAg4Ge77qdfEd5I2fJMOtd/mWPQ8SwXDJSpL76+oIMGUT2m7gxfG+o9kgqawUuY
         ldcHAa20mfZJcEQuVcnTwSR2KVuEaV/5+JClsHT0YqWigpM8njzpvKqdxdlX7//ZP+YD
         rKog==
X-Gm-Message-State: AOAM532P0jEmuuwMGaf6DkM/sM+RdaUB6piU9EW1ILE5sdyUvvr2rO2O
        tWprRqIM3NJMaHtQr1r0AsPwsQTtbws=
X-Google-Smtp-Source: ABdhPJxT0a3muXkoOUsSXb/1nxhJDn91imoBJoiQSCmk9JORWdDQidzIRD7x73HskSZdA5Mg2X8P+g==
X-Received: by 2002:a19:e05c:: with SMTP id g28mr20762260lfj.299.1625690806280;
        Wed, 07 Jul 2021 13:46:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q15sm6785ljg.126.2021.07.07.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 13:46:45 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqk0mcy6g2.fsf@gitster.g>
        <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
        <xmqqpmw4uwh2.fsf@gitster.g>
        <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
        <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
Date:   Wed, 07 Jul 2021 23:46:44 +0300
In-Reply-To: <60e5f3981de5f_301437208bc@natae.notmuch> (Felipe Contreras's
        message of "Wed, 07 Jul 2021 13:34:00 -0500")
Message-ID: <87bl7d3l8r.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Martin <git@mfriebe.de> writes:
>> > On 01/07/2021 00:59, Junio C Hamano wrote:
>> >> Martin <git@mfriebe.de> writes:
>> >>
>> >>> And yes, for the documentation, it *should* be clear that, removing a
>> >>> branch, removes the
>> >>> commits on it.
>> >>> But then it must be said, that the branch is first removed. That is
>> >>> not currently the case.
>> >> Sorry, but I still do not see how it makes any difference if the
>> >> branch is first removed and then made to point at somewhere else, or
>> >> the branch gets just moved without any explicit or impolicit
>> >> removal.  A branch cannot point at two different commits at the same
>> >> time, so the end result is that the commit at the old tip is no
>> >> longer pointed at by the branch after the update.
>> >
>> > Well all very obvious, if you know git well.
>> >
>> > Let's take a step back. How exactly is the word "branch" actually
>> > defined? Well it does not matter.
>> > What matters is, how the word is used.
>> > What does a person mean, when they speak of the branch?
>> >
>> > And the answer is, it's not always clear.
>> 
>> Yep. The "branch" may mean a "chain of commits" or a "symbolic reference
>> to the tip of the branch", or even both, depending on the context.
>> 
>> It's somewhat similar to "file" vs "file name" in UNIX. You in fact
>> don't remove files in UNIX, you remove file names that refer to files
>> (entities on disk), yet "remove file" and "rename file" are often
>> used, even though they are not technically correct.
>
> It's not even specific to computers, it's semantics of identifiers.
>
> You can say John is not a person, "John" is the *name* of a person, the
> person is constituted by cells and so on.
>
> Most of the time it's not particularly useful to think on those terms,
> but sometimes it useful in the sense that we can confidently say
> "master" is not a branch, is the name of a branch.
>
> In Mercurial branches are more like commit labels, so it's easy to see
> the difference between a branch (a collection of commits), and a branch
> name. In Git it's trickier because the branch is a pointer, and it
> doesn't make much sense to think of a pointer without a name, but
> strickly speaking they are different.
>
>> > But true, my attempt on adding "the old branch is removed" does not either.
>> > So not sure which wording will do best.
>> > Probably
>> >        "Creates a new empty branch at <start point>"
>> >
>> > Even though "empty" may be a sloppy usage too....
>> >
>> 
>> Yes, it's sloppy. There are no empty branches from Git point of view, so
>> this is not an option for proper documentation. Any branch has at least
>> one commit, the one the branch name is pointing at. It's entirely user
>> interpretation how many of the commits from the chain the Git branch has
>> they consider their branch "contains".
>> 
>> Overall, if we aim at clear documentation, we need to define our
>> documentation terms as precise as possible, and then use them
>> consistently.
>> 
>> For example:
>> 
>> "branch": a chain of commits
>> 
>> "branch tip": the most recent commit in a branch
>> 
>> "branch name": specific type of symbolic reference pointing to a branch tip
>
> Completely agree on all three (although I would call it "branch head",
> not "branch tip").

I see why "branch head", as you later introduce "branch tail", but a
branch (of a plant) has no "head" (nor "tail"), right? BTW, how the base
of a plant branch is called in English, and how one finds "branch tail"
on a real tree anyway? I mean, there are probably a few of them, at
every fork. In Git it's even more vague, as a branch could logically
begin at any place, not necessarily at a fork point.

OTOH, "head" and "tail" are obviously taken from CS "list" concept, and,
provided "chain" == "list", it does make sense. And then we have 'HEAD'
that points to the current branch tip anyway.

Dunno, in fact I don't have any preference among "tip" and "head".

As for branch tail, I do have convention of marking start of a
long-standing branch with corresponding tag, where branch "foo" has
corresponding "foo-bp" tag marking its "branch point". Recently I
started to mark start of feature branch with yet another branch "foo-bp"
rather than tag, "foo" being set to track "foo-bp", that allows to
automate rebasing of "foo" against correct base.

Thanks,
-- 
Sergey Organov
