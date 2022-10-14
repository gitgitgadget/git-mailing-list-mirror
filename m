Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCA4C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 12:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJNMAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 08:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJNMAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 08:00:50 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1D824F12
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 05:00:45 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id z97so6521742ede.8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 05:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSED5SwoLC08AzqNOuZX0i0mMiKP9ERN69tLe8C4HII=;
        b=o2znDBnibo260tRwjZuhWwumBGrLouWVZqzCgiUrsqV4W+D5havAIRkZXTfHT2Qp65
         TWpNcmvnSecgBxfRXxycSlFH0yOMPFuasaF4KYcT4H1xHTKle0iArSEVnkHDJ8iYnlDU
         c0oGVjhRupaJ+BI37HzWPrz/jvcOko2UgziwQ6flbdBj0zUqAs/0eVycw33FphkMb8Zn
         h7voADRpp2yg1wmWqB/1fCCNX/U+kHpfUE70llKFE7c3Z8vwQxbsMPwU155lLTWAVZBD
         1NwRvCQIg483ARsS51hBJZ+9IKYjlaarMDUlfLlEJCanP/l0EVHaUHeIi1TlyhRBmupA
         2MMQ==
X-Gm-Message-State: ACrzQf2+dq6mbt9xn/IEhxhzIustBWlj6M+oB1CaDVs3I5t4clOOrSOd
        Wv4uqoBkpm5VtPJ6az35kfdKeCDAwLdpZUNtxaxoe+S8qYSCTg==
X-Google-Smtp-Source: AMsMyM7nm5iPyoFeQWHQjHIqgOg/ku4db0cJvPrysh/Pt7mt26YB8C/bVZlYn8fGPdBcEVs4z6V9g+KaGwIUY5WBEak=
X-Received: by 2002:aa7:c78d:0:b0:454:fe1d:8eb1 with SMTP id
 n13-20020aa7c78d000000b00454fe1d8eb1mr3945596eds.59.1665748843829; Fri, 14
 Oct 2022 05:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
 <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com>
 <CAPMMpojvDj7Yc27HKQU4seSqg5Tx61RY3LOgMfkK=a0J25QYQw@mail.gmail.com> <CAPMMpog94YUDPZswcGZ0ns10QXhaWOGmE95mgZEpdcx4GKsV3w@mail.gmail.com>
In-Reply-To: <CAPMMpog94YUDPZswcGZ0ns10QXhaWOGmE95mgZEpdcx4GKsV3w@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 14 Oct 2022 14:00:07 +0200
Message-ID: <CA+JQ7M9nEHeALeHKO465xsNwmP8C3TXXDjuXAN9cFMmC-XEJnA@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Tao Klerks <tao@klerks.biz>
Cc:     Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 10:58 AM Tao Klerks <tao@klerks.biz> wrote:
>
> I don't understand this suggestion; doesn't it only catch duplicates
> where both instances were introduced in the same 100-commit range?

Yes. It was a bit half-baked but the main idea was to limit the tree
to a smaller subset (and not the whole tree) and incrementally
checking for introduced duplicates instead of a full tree search. I
think that's basically Elijah's idea. Get all (added?) files
introduced in a certain revision range (last change, since yesterday
etc.) and then only check those against the tree for duplicates in a
manner of how you define duplicates

On Fri, Oct 14, 2022 at 10:50 AM Tao Klerks <tao@klerks.biz> wrote:
>
> Directories have been the problem, in "my" repo, around one-third of
> the time - typically someone does a directory rename, and someone else
> does a bad merge and reintroduces the old directory.

That adds a bit of complexity :/
but should still be doable.

Not perfect but maybe something along these lines? (caveat, possibly GNU only)

#!/bin/sh

# files added between revisions x y
added_files() {
    git diff --diff-filter=A --name-only --no-renames $1 $2 ;
}

# folders of those added files
added_folders() {
    added_files $1 $2 |
        sed -e '/[^\/]*/s@^@./@' -e 's@/[^/]*$@/@' |
         sort -u ;
}

# all files tracked by git in *those* folders at HEAD
possible_dupes() {
    added_folders $1 $2 |
        xargs git ls-tree --name-only HEAD ;
}

# case insensitive columns separated by \x1
# eg.
#path\x1PaTh
#path\x1path
case_insensitive() {
    sed -e 's@.*@\L\0\E\x1\0@' |
        sort ;
}


x=$1
y=$2
# Find all duplicates paths (case insensitive)
# in directories which were added between $x $y
possible_dupes $x $y |
    case_insensitive |
    awk -F '\x1' '
        # actual "duplicate" paths, column $2
        # as determined by case-insensitive column $1
        $1 in a { print a[$1]; print $2 }
        { a[$1]=$2 }
    '    | uniq
