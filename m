Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E8EC64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 03:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjB1DzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 22:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1Dy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 22:54:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0C11449E
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 19:54:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x34so8441132pjj.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 19:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yqXkJCRsjRAIdecRLncfMvAdkqp2JhADjzXE22s4dc=;
        b=DJuZwcYjKCib6dtSsoG4u3CuQm+NQ7rfRSKAjPc2FPUCjEYViIFoA8pPEYtDMJ8qNS
         3zrjHS+eZ/jNwQeh+Wm8CpaxYWqdLT8hMl/OFW2RhHTjcIdlJm9a+/pkZdsahdGtOvtu
         dTGu/8Zqo4W7lUA5DNOQ+Z5FjLW6BXGltw3hS5Q0uuh2y/QK0N9RAPCxyL0pB2/H4vDS
         xtodtz+1M+IVJapFpEBIKW6PuEa9oLAsU5X4SO5gbKzuGBSLHsE2V/rW4rE4F++Ayk+8
         ZuofG/lvn40nukAZWJ1xDMAWrAd7EMv1SVbO4bPVEZgs41szAG3Fi+CrBJAgfaFzJETB
         jrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yqXkJCRsjRAIdecRLncfMvAdkqp2JhADjzXE22s4dc=;
        b=5IfqxnvarJAR1QPDclOiRW4h+uKFsa3dVGW0q7Vrs/D2fblTNF4ok/gqVbZpqyUQiF
         6//VHxMDlFR1Os4OuEx79S1/Jbxynn9qq629awElBjDdLi1LOaHblnGviiaJ9fCLSRQs
         bvJo08yjqjTsDTMiSm0AYeh7KWNJnYYY1xJ9WLO2Z4kFzVqUhsxnqydcZ72dKJAzL6MH
         O+Zhwgf6ADoh1OD98Ba2bqf5cw5SuQX4cOXLgwFFD8nWhgpnYK5lzQcxr8/eeGRiXepX
         IjA0v6t6UOPB/DCZdq8mmP9hXxlJtKeD+wFz+hkiarndR05b5tvwY12ZUQnCE44lChuO
         /UUQ==
X-Gm-Message-State: AO0yUKWwH+n/Hs6QUNvCZm2qe2qzWRvR2LCnUoNc2NAiGMHENiY2w01X
        gchlhAYY6Yhn/tHFMe7TqfA=
X-Google-Smtp-Source: AK7set80WD255puNIAQUdkGQ9Dya9r4SjV7nIvByYGGz3oWVc3htGIeG1TOg1U0emp6KUPWa0Tp+eg==
X-Received: by 2002:a05:6a20:7350:b0:cc:3bf0:ed91 with SMTP id v16-20020a056a20735000b000cc3bf0ed91mr1912742pzc.51.1677556494336;
        Mon, 27 Feb 2023 19:54:54 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.144.2])
        by smtp.gmail.com with ESMTPSA id s26-20020a63af5a000000b00502fdc69b97sm4585308pgo.67.2023.02.27.19.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 19:54:53 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, five231003@gmail.com
Subject: Re: [PATCH] index-pack: remove fetch_if_missing=0
Date:   Tue, 28 Feb 2023 09:24:48 +0530
Message-Id: <20230228035448.10700-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230227221451.2433306-1-jonathantanmy@google.com>
References: <20230227221451.2433306-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Feb 2023 at 03:44, Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> > A collision test is triggered in sha1_object(), whenever there is an
> > object file in our repo. If our repo is a partial clone, then checking
> > for this file existence has the behavior of lazy-fetching the object
> > because we have one or more promisor remotes.
>
> Hmm...this is not true, because (as you said)...
>
> > This behavior is controlled by setting fetch_if_missing to 0,
>
> ...this makes it so that we don't fetch in this situation.

Yes, that statement is false if fetch_if_missing is set to 0. But my original
thought in writing it was so that the anyone who is reading the commit message
understands the motivation as to why we are setting fetch_if_missing to 0.

> [...]
>
> > @@ -1728,14 +1727,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
> >       int report_end_of_input = 0;
> >       int hash_algo = 0;
> >
> > -     /*
> > -      * index-pack never needs to fetch missing objects except when
> > -      * REF_DELTA bases are missing (which are explicitly handled). It only
> > -      * accesses the repo to do hash collision checks and to check which
> > -      * REF_DELTA bases need to be fetched.
> > -      */
> > -     fetch_if_missing = 0;
>
> I think that the author of such a commit (you) should also independently
> verify that this comment is true (and if it is, then yes, all the
> remaining cases are handled and we can remove this assignment to
> fetch_if_missing). I believe this comment to be true, but I haven't
> checked the code in a while so I'm not sure myself.

It seems indeed that this is the only place where lazy-fetching is possible.
I checked this by looking up the calls for oid_object_info_extended() or
any other function in object-file.c which depends on it.

In builtin/index-pack.c, we have (in the order that these functions appear)

- check_object()
    Call to oid_object_info(), but we return early with
    0 if we don't have an object.

- sha1_object()
    Call to has_object_file_with_flags() (which this patch replaces with
    has_object()), where lazy-fetching is possible.
    
    Calls to oid_object_info() and read_object_file(), which trigger only
    when the above has_object_file_with_flags() succeeds.

- fix_unresolved_deltas()
    Call to oid_object_info_extended(), we prefetch delta bases.

    Call to read_object_file(), but we only read data from ref_delta_entry.
    In case it was a delta base, we already prefetched it.

There are cases where we fsck objects, but lazy-fetching is already handled
in fsck (although by setting fetch_if_missing to 0).

Do we need to be explicit about this in the commit message? That sha1_object()
is the only place where there is a chance to lazy-fetch if it is a partial clone?

> > +test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collisions' '
> > +     rm -rf server promisor-remote client &&
> > +     rm -rf object-count &&
> > +
> > +     git init server &&
> > +     for i in 1 2 3 4
> > +     do
> > +             echo $i >$(pwd)/server/file$i &&
> > +             git -C server add file$i &&
> > +             git -C server commit -am "Commit $i" || return 1
> > +     done &&
> > +     git -C server config --local uploadpack.allowFilter 1 &&
> > +     git -C server config --local uploadpack.allowAnySha1InWant 1 &&
> > +     HASH=$(git -C server hash-object file3) &&
> > +
> > +     git init promisor-remote &&
> > +     git -C promisor-remote fetch --keep "file://$(pwd)/server" $HASH &&
> > +
> > +     git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
> > +     git -C client remote set-url origin "file://$(pwd)/promisor-remote" &&
> > +     git -C client config extensions.partialClone 1 &&
> > +     git -C client config remote.origin.promisor 1 &&
> > +
> > +     # make sure that index-pack is run from within the repository
> > +     git -C client index-pack $(pwd)/client/.git/objects/pack/*.pack &&
> > +     test_path_is_missing $(pwd)/client/file3
> > +'
>
> How does this check that no lazy fetch has occurred? It seems to me
> that you're just checking the existence of a file in the worktree,
> which does not indicate the presence or absence of a lazy fetch.

What I had in mind was if the file was lazy-fetched (because of the failure
of has_object_file_with_flags() and fetch_if_missing not set to 0), then
it would be unpacked and we would find it in the worktree. Since, we
prevent this exact behavior by using has_object(), we should not find
such a file in our repo.

> I think the way to test needs to be more complicated: you need
> to create a partial clone, fetch into it from another repo, and
> then verify that no fetches were made to the original partial
> clone.

So, after the fetch, during the pack indexing phase, we look for
any additional fetches made. This makes more sense and it would
be way more clear, to anyone reading, than what I wrote.

Will do a reroll. If there needs to be a change in the commit message
as well, please let me know.

Thanks for the review
