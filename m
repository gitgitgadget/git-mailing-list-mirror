Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8F1C433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 01:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5184461057
	for <git@archiver.kernel.org>; Sun,  2 May 2021 01:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEBBwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 21:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEBBwb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 21:52:31 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ADBC06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 18:51:41 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n184so2102017oia.12
        for <git@vger.kernel.org>; Sat, 01 May 2021 18:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zG7uBQuqucQHrFbSxqTezpsrTS4tKEg0yJj0HrH2toQ=;
        b=M4uDd5jvA9HT2jkCRpaEx+w4/iyO8CrwKH86JWCzelg5oOVkwmHH9ofYCYpKoz4/mQ
         1l94db2FHx9UPDRikwmNIWMi92bX1PcqNCjhksxx434oivkByJex1vyJmJ2d73WeaZhT
         w8q06iMi30QrAvVGevSvbBKO5v91gnkO3xsNcW85nv+xEytn6E7sDxawE8LST9YetMVf
         N1xAsPKSgtmtqKFSzclKHIo3M81VnVN9aH2kOnLSnzF51hjKNiNgKgy+qBIvpv2AM4qS
         +OPDY0F7zZ8qS387KLQskwIXjXXm1WMc9BhGaLBw46cyi6sYQtdILTEnC1L30pdzYJsl
         gXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zG7uBQuqucQHrFbSxqTezpsrTS4tKEg0yJj0HrH2toQ=;
        b=bzYXu56F5e3Rra70fP+DnRRXNIF4tfBnZ6wsutOdKXACnG/MZIy6xqHbmQVeJeb3Ie
         TloJkr+KVLCoaXD0kDNJSedGaAL6p0ucu8vSvt4pQEDusd0kDICBtvnPJgTLCYRBLtT2
         M4YwWiqe9DQSBCP3+Cv6pUI5jMVCvoMLN1xzw0H9x1EiIxtbQxNQ9DudwNKzi+607MKv
         zvgWG2nayd4KZvfKGd9i/W501ayh3cU+ZpMYVtwtrrH0I42sxjt+ZDJiShTj7rAbEGs+
         +n4GT3UF3756jQiSYGk/1WkHWfzCsPl9vSL4t9Tt+XVtI0Jxz7uEYYJnlNhAUpXQenXQ
         ERWQ==
X-Gm-Message-State: AOAM531vwkDd7ySr0bg4CJPjKSW+V0lxYGrMNO7HnG8kZgkIOd+Jr69/
        /owz07alXs/Z3RNCszp5u2UHlQpKI5boVnVezGU=
X-Google-Smtp-Source: ABdhPJwkyLeAqjblqZz4qygbPWSJEJh77K0VpTgAU9fM7y+R4lQ4IKlWNpKIuoCHyJCV0tTvtneiW8DUyogsZM5ry1M=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr15670010oif.5.1619920300309;
 Sat, 01 May 2021 18:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
 <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com> <xmqqbl9zcawf.fsf@gitster.g>
 <xmqqk0ol7cka.fsf@gitster.g>
In-Reply-To: <xmqqk0ol7cka.fsf@gitster.g>
From:   Josh Soref <jsoref@gmail.com>
Date:   Sat, 1 May 2021 21:51:29 -0400
Message-ID: <CACZqfqCXrhUtsC3TLYaw6u7D0VohsBcz10aVxpe-1u8gg77qxQ@mail.gmail.com>
Subject: Re: [PATCH v3] git-merge: rewrite already up to date message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Josh Soref <jsoref@gmail.com>
> Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Josh Soref <jsoref@gmail.com>

Junio C Hamano <gitster@pobox.com> writes:
> I am not sure why this is Co-au, and not the more usual "Helped-by".

If you look at the thread, you'll see that the code in question was
written by Eric [1]. The only change from it was the addition of
`void` to the function prototype by me.

That said, it's my first foray into patches for git. I didn't use
helped-by because gitgitgadget didn't tell me to [2].

I have no opinion on the details. At this point, it's likely that a
second commit would include a helped-by referencing you. Maybe. I'm
not sure of the semantics of helped-by [2].

Junio C Hamano <gitster@pobox.com> wrote:
> Actually, not so fast.  The end-users do not care really where the
> message originates.
>
> $ git grep -e 'Already up[- ]to' \*.c
> maint:builtin/merge.c:          finish_up_to_date(_("Already up to date."));
> maint:builtin/merge.c:                  finish_up_to_date(_("Already up to date. Yeeah!"));
> maint:merge-ort-wrappers.c:             printf(_("Already up to date!"));
> maint:merge-recursive.c:                output(opt, 0, _("Already up to date!"));
> maint:notes-merge.c:                    printf("Already up to date!\n");
>
> It probably makes sense to replace the exclamation point with a full
> stop for others, no?

Maybe. I'm not sure what they mean.

I'm fully capable of wearing a grammar / UX hat and rewriting the
entire UX for a project if you invite me to do so.

I generally try not to do that when I initially approach a project, I
prefer to get more comfortable w/ it and let it get more comfortable
w/ me before I make significant change proposals.

(As an aside, I did start looking into what these messages meant /
what to change them to, but other things have come up, and I've
decided that I should at least respond to this message instead of just
appearing to disappear.)

> Also, I didn't notice when reading the patch submission earlier, but
> what does
>
> >> (All localizations of the previous strings are broken.)
>
> mean, exactly?  Do you mean to say
>
>     Because this changes some messages, the old messages that were
>     already translated will no longer be used, and these new
>     messages need to be translated anew.

Yes, this is what I meant. It's probably technically obvious to some
people, but since I'm invited to describe the effects of my change, it
seemed worth noting. Anyone cutting a release with this commit but not
updating the translations would be bleeding en-US into the
translations where before they would have had translated content.
(Whether that translated content was any good given the fact that it
was pasted together is a different story, but...)

[1] https://lore.kernel.org/git/CAPig+cT=xeLn9KNHz7hiNWo0QTfc1zZ1X-czJ4n503RRhBA0XQ@mail.gmail.com/
[2] https://github.com/gitgitgadget/gitgitgadget/issues/543
