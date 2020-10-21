Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196D0C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C282415A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z46sj36W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505497AbgJUUp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505489AbgJUUpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:45:25 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D21C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 13:45:25 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so4662431ior.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aSj7CbtEsn0aZFNJly3fSP0VMfSe+5bSlZ/lH3ghdg=;
        b=Z46sj36W6rxs1+CD6I/atKe5QUsj0JjvhLVFzP7/47S/7ZF/suVoY/SzFLOkuAA/FJ
         e4T8dVDPDyXcOv4Umchu4ZXubQunMyu2mOiDu1MPG9vGJQB/82YYdW0hLSUNpJkDYodX
         vKed1gqa1f3JGQn3pAHHLyXaxCX1bY+UOCf5pkOz8xtr+S6oCfQzS+z8OEihVw06cIDh
         DHhKFS+OCZljIsMPZ1SEIlFwedPXlB4oJ2DGgs/0th033NJRXxkAM25bfWLvjJeS0LBB
         BPv+f5n0C+cAFn37MDKCPRGr5OtvyzqNjXpu5v/XpkKn3fkRAbimz1sL3d+sHjv72CIh
         IQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aSj7CbtEsn0aZFNJly3fSP0VMfSe+5bSlZ/lH3ghdg=;
        b=Uc1f+rdlah7P03AL8Jcc5kXUANl5DAmhHNvnGZnX0Nc4vDKhjmiAPMFCnITqc1cEQ8
         wxu3N4lct8+TMh4YkTeiEtqfPuaSFibl0ZPGiDn1vLp5f0srrPfuEb/0onbkk7ET9qn1
         vizaXaRBO7jNpvi/igE5hqgx2aiIrnC0LG7ryIw93At9w+yRLotnH9ITLZ/v1AsmI4oe
         HKnab1hwr+7AdXzPyPKSRbEeSDD6eHGsUmXhu88wUTbt3PQUcL+J43oo3KtAbr766bEk
         TAszoJjKiCqxKr6V/hNFSV/GsJp86lNZftUlHkB6BK3fSC8vSAcAdHItMzc97MVB2R5f
         CqYw==
X-Gm-Message-State: AOAM533Kkosx1ZzVuJLhyqPKCIIH/E/y39cHr8GhsYCWOIoa1MzXt+5q
        B122PgfIj9Ey9PiTjg3BlVsRuKYH7d7SROpy4kk=
X-Google-Smtp-Source: ABdhPJwa2i+pwBOVai63oxXjJvN3BC0CcQ7XPE77JSxcVzbJSyumCzt2rzcHY3ZnYyFKQShQ/vBpUoBJGg5AS8FUn9Y=
X-Received: by 2002:a05:6602:38d:: with SMTP id f13mr4162344iov.6.1603313124496;
 Wed, 21 Oct 2020 13:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201021062430.2029566-1-eantoranz@gmail.com> <xmqqv9f37476.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9f37476.fsf@gitster.c.googlers.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 21 Oct 2020 14:45:13 -0600
Message-ID: <CAOc6etbSbg0rDrqu__MASTEdz2FhnhxtQLn6gvhBZL8BLz+AQQ@mail.gmail.com>
Subject: Re: [RFC] sequencer: allow metadata to be saved if using cherry-pick --no-commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 1:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> So, personally, I am fairly negative on this line of change.  If the
> user says upfront "--no-commit", then user does not want a commit,
> so why should we even allow "--continue"?

This is the way merge --no-commit works, actually. You run
--no-commit, then you run merge --continue to wrap it up and that's
why to me it had always felt a bit off in terms of consistency of the
UI.

>
> Before dismissing the idea totally, let's see what potential use
> cases this change _could_ benefit, and see if there are already ways
> to satisfy these use cases without making this change.  For example,
> if the user wants to examine the result before actually "committing"
> to move the target branch forward with this change, keeping it an
> option to back out if the result of cherry-picking turns out to be
> bad, the "--no-commit first, examine, and --continue or --abort"
> sequence may help such a workflow.

Case in point, I am working on a script that corrects EOL format of
files in a branch. When I started developing it, I was trusting that I
could run cherry-pick --no-commit so that I could then check the exit
code of git to see if there had been problems or not in the operation.
If there were, I would correct the EOL format of the files. Then,
successful cherry-pick or not, I would run cherry-pick --no-commit and
it would work.... but that was when I realized that cherry-pick
--no-commit is not keeping the information. Given that --no-commit
_forgets_ the information from the revision, I have to run a normal
cherry-pick. If it fails, I correct the EOL format and then I run
cherry-pick --continue. It is noty like a game changer, you know... I
can live with it.... how many people have complained about it, anyway?
I just find it inconsistent in terms of how cherry-pick/merge
--no-commit behave.

https://github.com/eantoranz/conflict_book/blob/0385d240dda962512b215781039ed42ec2f12ec2/scripts/correct_eol.sh#L197

Anyway, thanks for all your feedback and let's see if there are more comments.

BR


>
> But the user can already do so without this change:
>
>     $ git checkout target_branch^0 ;#detach
>     $ git cherry-pick source_branch
>     ... examine the result ...
>     ... and if it is satisfactory ...
>     $ git checkout -B target_branch
>     ... or if it is not, then discard ...
>     $ git checkout target_branch
>
> > With this patch, we allow sequencer to save the metadata from the original
> > cherry-pick operation so that 'git cherry-pick --continue' can be called.
>
