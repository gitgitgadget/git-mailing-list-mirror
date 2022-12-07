Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B10C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 11:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLGLk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 06:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGLk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 06:40:57 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2E022BD4
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 03:40:56 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v19-20020a9d5a13000000b0066e82a3872dso9063724oth.5
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8piAZxdhaMEUlsauUfbHZEP3AUMED5sJVO8t8tMy3QY=;
        b=d2kBAAJM18a4/cdJKX7TNML4R/uQ0F+1jOTsijoKoCIYEWvlP6R94bppOE6oAIEot8
         gB4yUuErHWLdjrUIkx6dJ6LmFOaUvgj0Qv7yKevYkroZde+S47/wv3a6eivBrjDMgxgs
         SHOIcEPB1fJvMp2ltt/EU/KpqE5hYnF0hbQe4bOfMWsFqWTzhkH/yayeGsJzmcnyVOAf
         7egzMb3uXiB1ralZfQyazrrT4jZM4FNxbhQduQEN+BhwPDBB1ioI0u4iC4J8Pek8VHvb
         /bRBsWi8QjB9qrptax3IfioAk/EbMafzoS3E+zSlwIzD/QprZEIzktY6VfhsmBDieaIY
         eXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8piAZxdhaMEUlsauUfbHZEP3AUMED5sJVO8t8tMy3QY=;
        b=kwhzTutEdDKw5LhzD1kuhAXaXV7kW6lH4wtK1yaP2dMa82spXidrtfG1PjlgiLEdbf
         x5+PleaUSLVoyQ9rvKVpXudEZe8KbRUFn5fnXMmBlpfro9+Tt2PR31YsbwO9zWo1HVGw
         j5RFsR1s2qFiQy+SLWPfpsr6FY7s2zd3VMdWI5Rh0NvkLF55+YSM4b2rcrqYe16lAXFE
         mRlyp8eKVVtyumtXFG6d/RuoMPQFDyDm7RWglY6dt7Qmqmln1tVRlyfjdYA7NIOK+TSx
         9dPlBDR+GcRXWzwb8snwBp7JVcrGqwMxr1p2heuQAzlbpnjXaxpJbHV8TwkB8AfTCn0L
         tN+w==
X-Gm-Message-State: ANoB5pmidEz7J0mC83WW023QmGOtBc2d/IBZzjgclU77L77If/VJ4FuB
        LmVAHocB6yIFTmsdPqnomDYWZxFKdOiczhMSqiFo8/KaUoiFxw==
X-Google-Smtp-Source: AA0mqf7KKpZu1/xHausEp2EbV4GJ+i5KpMvBMMGC2YCljX1v0DGwRnSMyghYZKO/tfr30iEWkulzvj/0Wmzm30i7wI8=
X-Received: by 2002:a9d:7656:0:b0:663:c86f:7573 with SMTP id
 o22-20020a9d7656000000b00663c86f7573mr36534398otl.187.1670413255802; Wed, 07
 Dec 2022 03:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20221206103736.53909-1-karthik.188@gmail.com> <20221206103736.53909-3-karthik.188@gmail.com>
 <xmqqedtc842m.fsf@gitster.g>
In-Reply-To: <xmqqedtc842m.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 7 Dec 2022 12:40:29 +0100
Message-ID: <CAOLa=ZS5k=s98Bo9GE+RRa3jtanehL35y-hhLhy1DoM7GyO0cQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2022 at 1:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > Add a new flag `--revision`/`-r` which will allow it work with
> > revisions. This command will now, instead of checking the files/index,
> > try and receive the blob for the given attribute file against the
> > provided revision. The flag overrides checking against the index and
> > filesystem and also works with bare repositories.
>
> As "check-attr" was not invented as a user-facing subcommand but was
> a hack for debugging, I would have minded this change, but these
> days people seem to treat it as if it is just one of the proper
> plumbing commands, the new command line convention bothers me a
> bit.  No other command uses --<anything> to signal that what comes
> after it is a rev.
>
> But I do not think of a better alternative without making the
> command line ambiguous, so I'll stop at raising a concern, so that
> others who may be better at UI can come up with one.
>

I understand this concern, but I do think it would be really useful. I see that
Taylor and Brian have also mentioned how this would be useful. As such, I
think it's a good indication to take this forward.

> As to the C API, please do not append the new parameter at the end.
> When there are no logical ordering among the things listed, be it in
> the members of a struct or the parameters to a function, we encourage
> to append, but in this case
>
>     void git_check_attr(struct index_state *istate,
>                         const char *path,
>                         struct attr_check *check)
>
> we are saying "pick <path>, referring to .gitattributes files from
> the index as needed, and apply the checks in check[]", and the new
> behaviour is "pick <path>, referring to .gitattributes files from
> the tree-ish as needed, and do the same", so istate and the tree-ish
> object should sit together.
>

I will be more cognizant of this approach and make these changes.

> Also, at the C API level, I suspect that we strongly prefer to pass
> around either the "struct object_id *" or "struct tree *", not working
> with end-user supplied character strings without any sanity-checking
> or parsing.
>

I must admit, I did take the path of least resistance here. So we finally need
to parse the `revision:<pathname>` where the `<pathname>` is generated
dynamically as we move through the check-attr stack.

My question is, if I generate an `object_id` at the start (in
builtin/check-attr.c)
with only the `revision`, is there a way to traverse to find the blob
for each of
the different <pathnames>? I haven't looked at Git code for a while now, and
I'm not sure what the best way to do this. Maybe I've missed some API which
would make this simple, any help is appreciated.

> Another concern, among many existing callers of git_check_attr(),
> is there any that will conceivably benefit in the future if they
> could read the attributes from a tree-ish?  If not, it may make a
> lot more sense if you did not butcher them, and instead introduce a
> new API function git_check_attr_from_tree() and use it in the only
> place you handle the "-r tree-ish" command line option in the
> updated part of the "git check-attr" command.
>

The concern then is that we'll also have to duplicate some of the code in
`git_all_attrs` and `git_check_attr` and have some logic to work
correctly for with
and without the `-a` option. All in all, this was much easier.

I don't have enough knowledge to say if the other callers will someday
want to extend
to providing a revision too, so I'll leave that to you!

> Thanks.

Thanks for the review.

--
- Karthik
