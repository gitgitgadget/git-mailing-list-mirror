Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9DC433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DA7207DE
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4O0ijm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgHTRdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730496AbgHTRde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 13:33:34 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB5C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 10:33:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q9so2109385oth.5
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYIY8kmK2um7K50hdfPC5g+H6YWX3qPMXbGUmrVIJ7g=;
        b=s4O0ijm/klUTb9Vhkp+SfMk/AQspS0lWgjIq656Vfyw1kh2cHV1niISLCwwlxZgvUt
         jIdMbNedZclpH0CgBvMrkMb7bMhwkKoZxSD2WNifXHKZjp6s97tzKtvDmaeJtb52md3G
         N5hIYxywGJxxLyMVcRn8Ohx5Pay9Q2kedhIPA7W0tdzRo11r3QMxeoDdETUF10yVtBKF
         Cmp+JxbGUGEYHqYF+ZtGjApAnqjdiiclxcz9r+L+9R0uGOoZ7IwmESysxK1dnWcHtcXG
         OTJwfbcqt9ttV1x8IdUk9gVBAOiEPiZOr5G/hVq5Agu6HczlG/CJB8Bd2WdjpDLagqiE
         iZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYIY8kmK2um7K50hdfPC5g+H6YWX3qPMXbGUmrVIJ7g=;
        b=p1KawJrmNJvDvef2+tBVyUrjbmwdhXrFqGKkNFPDLJ61GUSWHv89e0dkmNuk0X8tzn
         a+zg446tYw0OT1PoPEZqjH9WK5jhJiYMNptNJSyg/ByzPeqqcOqmHoD28xYtuyyRkp7e
         uITzGescDKLM+/HZnVdwXYqmXFT2UrhylUsoN8eQf1VkkfS6g5ksftiJF5BgXfop3W67
         uFSkJfTlm2JNHwOA8PZ2JphSekt67OF78LsNOizU4kSbPFbHetf+OwxfviN0gDrzI7/Y
         KMDbCbHDCao4Vs0vltJLcligG2Sh8SMsFSLozmGex4/2E7BA5unTZ7v8RKNnNPTZZ9G5
         7bEg==
X-Gm-Message-State: AOAM533RRQ9qjX6hdZF2heh8hibbrOpSkN2EID1GJXMvT2xUUdBXgcBY
        KWTr/ajvkne4MpMnd+GCVSrvCQVK1HuovSxbUKM=
X-Google-Smtp-Source: ABdhPJxVo4Tm9izBFsf76Dk+2D0eQhqfqi1SeEUxkrJ5YGJOoHVmJnB+xHN5LjP0AOEpb4ZXB55/HrSej/Vb7ZTtGQ0=
X-Received: by 2002:a9d:ae9:: with SMTP id 96mr2838295otq.241.1597944812254;
 Thu, 20 Aug 2020 10:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
 <pull.684.v3.git.1597687822.gitgitgadget@gmail.com> <0ad22c7cdd3c692aa5b46444e64a3b76f1e87b4c.1597687822.git.gitgitgadget@gmail.com>
 <xmqqpn7p1373.fsf@gitster.c.googlers.com> <CA+CkUQ9tkwXmrHq_ZV+RCgwoFHZ0M4dEhBkjUd97Xi+3shB-WQ@mail.gmail.com>
 <xmqqimdevd4l.fsf@gitster.c.googlers.com> <xmqqeeo2vcsl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeeo2vcsl.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Thu, 20 Aug 2020 23:03:21 +0530
Message-ID: <CA+CkUQ8tkKM6SKrpJJ9-+9Nj+4Ly3FWHKUp1BQgJEG0-XyWENw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] pretty: refactor `format_sanitized_subject()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Aug 19, 2020 at 9:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Hariom verma <hariom18599@gmail.com> writes:
> >
> >>> Also, because neither LF or SP is a titlechar(), wouldn't the "if
> >>> r[i] is LF, replace it with SP" a no-op wrt what will be in sb at
> >>> the end?
> >>
> >> Maybe its better to directly replace LF with hyphen? [Instead of first
> >> replacing LF with SP and then replacing SP with '-'.]
> >
> > Why do you think LF is so special?
> >
> > Everything other than titlechar() including HT, '#', '*', SP is
> > treated in the same way as the body of that loop.  It does not
> > directly contribute to the final contents of sb, but just leaves
> > the marker in the variable "space" the fact that when adding the
> > next titlechar() to the resulting sb, we need a SP to wordbreak.
>
> I was undecided between mentioning and not mentioning the variable
> name "space" here.  On one hand, one _could_ argue that "space" is
> used to remember we saw "space and the like" and if it were named
> "seen_non_title_char", then such a confusion to treat LF so
> specially might not have occurred.  But on the other hand, "space"
> is what the variable exactly keeps track of; it is just the need for
> space on the output side, i.e. we remember that "space needed before
> the next output" with that variable.
>
> I am inclined not to suggest renaming "space" at all, but it won't
> be the end of the world if it were renamed to "need_space" (before
> the next output), or "seen_nontitle".  If we were to actually
> rename, I have moderately strong preference to the "need_space" over
> "seen_nontitle", as it won't have to be renamed again when the logic
> to require a space before the next output has to be updated to
> include cases other than just "we saw a nontitle character".

Yeah, if it was named "seen_non_title_char", I might not get confused.
But now as you have already explained its working pretty well, "space"
makes more sense to me.
Well, I'm okay with both "space" and "need_space".

I wonder what others have to say on this? "space" or "need_space"?

Thanks,
Hariom
