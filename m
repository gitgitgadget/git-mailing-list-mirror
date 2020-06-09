Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F5C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 20:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4076E20734
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 20:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bocoup-com.20150623.gappssmtp.com header.i=@bocoup-com.20150623.gappssmtp.com header.b="z1D2Klv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFIUwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgFIUwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 16:52:40 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47684C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 13:52:40 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v13so17791246otp.4
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bocoup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=varxs+UypN+qXstDKWdzKfoWlRoz6qlYnXkRTepk2l4=;
        b=z1D2Klv3xfGa8Q5nIKFhhQQNvFWmqeAyI70EABtdn2l5d/C1OyR9KLMYm/lT/BtqKG
         +IIRcWGxOzJReDdGNlQvQ/7QMrlmCnol7/pXwWAjKq4rbbiKMbJzrIoNE/psRAbEvXul
         7XUadhU2Kc+EBiYC1OAS2oKklR99zjWoy4fS87R7xX2Itxn5VT0WoemW06/JFKnl5OPU
         cVKJTkRlCD/7fUEXIPZve8o+6vCuf8QkB5gQE+YaHLrRp4uenK86Y9L4VSTDoykGjLMw
         TepXlvXCDfXXitJrbevMI/UGXVLUX5BEngWSNSVvLmDBL3V3cMSkbMlF+v+lfxunvaPH
         iNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=varxs+UypN+qXstDKWdzKfoWlRoz6qlYnXkRTepk2l4=;
        b=FBdCDWpmwnNeT27MhyF6/x9ahUcxVrGXVubyEMptdFmTZzC8pRRj2f75oeTHMSx5JT
         YJUA5zwkEqkAVoPrVfrpcx522YA76icnw2cgoN+t2Vtd+dHrOof6g2zGamXExU8tP4hK
         fwZCaE/ZPX3fqowy+YqpNGxBQXJRe/ne5W9gslpU68viNUEGBz1o2pcGMj3EaUyi/HjR
         wC8I+o2lW0Ly/XZVxIGW9I85psD/NLo76DhwXDYVOV7HpVLlrvdL/WAzaRLydH3yQIH2
         XUiqA/u768IAUqegGuIKHKxs8KvZ9gPjByflgrnwu2QVTTHMExKn+WEIDMcJGD9i0x5r
         4zGw==
X-Gm-Message-State: AOAM532sTwb87CiRHOYfQC8Q9oG869fOy2XyXDCU3y6dsyDlmZTbxZ3r
        8pWFnJeQyCQk6Nz1VC4BFyat4ipVvTydSy/vb7BCXoaApsS2OA==
X-Google-Smtp-Source: ABdhPJwmE6cn7GshQ0H1RkeGws7SkwkwySj0RkRr1UoSBNmjkcZGuucfL6BxqcW2RjJE6MbE7S+nzqT1l4d8MPvcLnc=
X-Received: by 2002:a9d:6e84:: with SMTP id a4mr57803otr.112.1591735959461;
 Tue, 09 Jun 2020 13:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
 <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
From:   Simon Pieters <simon@bocoup.com>
Date:   Tue, 9 Jun 2020 22:52:28 +0200
Message-ID: <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Jun 9, 2020 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Simon Pieters <simon@bocoup.com> writes:
>
> > If someone is interested in helping with this, please follow up with
> > Don. But I would like to ask again for git mainline to seriously
> > consider adopting this change, given the information presented above
> > and the ongoing movement against systemic racism.
>
> I am OK in principle if a future version of Git, when used by a new
> user of Git who does not have any custom configuration, wrote a
> string other than 'master' in .git/HEAD when "git init" is run.
>
> Picking a good replacement word to mean the primary branch is
> tricky, though.  Just having a notion that one is special among
> many (i.e. the primary-ness of the thing being named with a word
> that will replace 'master') may already be offending to some folks.

I find this response not satisfactory:

- as far as I can tell, no evidence that "main" offends anyone.
- git trying to be neutral by not having any default name seems like a
weak response to this issue.
- having users have to pick a branch name when initiating a repo
increases the burden on users and makes the learning curve steeper for
beginners.
- git not being opinionated on the branch name doesn't address the
inconsistency problem pointed out in the original post.
- while git itself could avoid having a default branch name, platforms
that use git such as GitHub or GitLab will still likely want a
default.

I think git can lead the way and make things inclusive, consistent,
and not regress on usability.

cheers,

> Also notice that the qualified statement above talks only about the
> plain vanilla experience---the change of the default should be
> designed to avoid harming workflows in existing repositories and
> tools built around them.
>
> So, I think there are two separate tasks that can run in parallel.
>
>  * Pick the new default word to replace 'master'; it may turn out
>    that the Git project choose not to pick any to avoid offending
>    anybody, in which case "git init" may force end users pick the
>    default they want to use and offer recording in the ~/.gitconfig
>    file.
>
>  * Engineering work that uses the word that replaces 'master' by
>    default (if one got chosen) when not configured, and use the word
>    the end user chose when configured (iow, allow users to override
>    the default word that will replace 'master').  This includes
>    design work to decide what to do in existing repositories (if
>    there is anything that needs to be done).
>
> Without digging deeply, I think we are pretty good about basing
> things on HEAD (e.g. "git branch -d" protects the branch by seeing
> if it is already merged to 'HEAD' or its @{upstream}, and not treats
> 'master' any specially), so it might be the matter of teaching "git
> init" (it uses 'master' by default) and "git clone" (it tries to use
> the name of the branch the HEAD at origin points at, but falls back
> to 'master' when the branch name their HEAD points at cannot be
> determined).
>


--
Simon Pieters
Bocoup https://bocoup.com/
-- 
Simon Pieters
https://bocoup.com/
