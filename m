Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A621C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 07:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJNHlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 03:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJNHlc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 03:41:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC071B6CBF
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 00:41:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f37so5939960lfv.8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9yVV9DcltSKJDu4no/eBjTheJHXhT5xOv7mEGb989w=;
        b=jjTD/likVk0jFMPv+TRdU2rCgWOrgAa0Ama+xbFNOubZSzcNBoW8hzFgDqm5kimPEv
         2rz6bu/A7OdAkqMrpQB5he0rFXFkSjJXUSlBkL2L5pjkuev9xHd7GYS5H2NVBbYY5aU7
         hpx3eV+MmbfwVbY9N6YLhb8BSmxuXoUulMAY0Q2D0/UF5FbvQM62x41xDdI3Y3RnKt36
         Xk27rr5TKFaf5/lGVorjD0N35T420q5Mnhx2PJ483cw+noI23fjCRY4hkD+fRStfC3mR
         Fe+6/x+gjI4VGJ7qNUqI0vNMmYIuNvWe/gdz+fzG/C6owmosD+MkYc/+7fR3qNu1ie+K
         qyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9yVV9DcltSKJDu4no/eBjTheJHXhT5xOv7mEGb989w=;
        b=u3lsi9PM0oOyBdgOQJT/HjtM/MMs8NcgeLwF9IspvkEY9mL/6BXxlsnHMM39PGCfFx
         w3iv4ZaftmO/OsTPYJ/ArapUZjmqGPUP6XMHbrj+D8UKXlTTmZSG6cUkcQSjZh8oOmoJ
         dmeKnh0QkhYXGJPp2PEKZDqUqE7Em9K5WY2uQWh6Z5hwJ42UjvythgyXbb7YP3f7d35W
         +NSTtB6JpcNw+iURL7f1HcscFJe8xPeRJI6s+/UHbjGT8Nx5xWIGkum+XLJbIYC5yn9J
         gKdwwdRo9LDzZL9+7jrwvn5psX8jJj4bgx/l1X6kbJG81RxaFGAPG656j9lqXyy6PxiW
         znOA==
X-Gm-Message-State: ACrzQf35SKqTkLyWgnPAVl1Sbsyhk+j3kwV1DxJ5Aiqzx1IO7Ck5wj6t
        NQhQsyS9ZMeXBE5zgrQSkB5p2sQCHENjF9K+Qoc=
X-Google-Smtp-Source: AMsMyM5JKyol+YH3xBSZfB/ujwdHBoQNHRe8ZjNHOJg5f5F8P4dLhl1OUajqwy4rN5Zm/pCpJrGD7+VfJ27huAZtEZ0=
X-Received: by 2002:a19:5052:0:b0:4a2:caa1:e2f6 with SMTP id
 z18-20020a195052000000b004a2caa1e2f6mr1215403lfj.65.1665733283562; Fri, 14
 Oct 2022 00:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
In-Reply-To: <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Oct 2022 00:41:11 -0700
Message-ID: <CABPp-BHaMCcLjdx2m4CALZQiTRQy_LovWfbdrga6XWhQJhoxWQ@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     Tao Klerks <tao@klerks.biz>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2022 at 11:49 PM Tao Klerks <tao@klerks.biz> wrote:
>
[...]
> I understand that case-folding is a complex topic, and doing it
> correctly in some universal sense is undoubtedly beyond me - but "my"
> context certainly does not require a high standard of correctness:
> There's a repo shared by some 1000 engineers, 200k files, lots of
> activity, three different OSes of which two default to
> case-insensitive filesystems, and every once in a while a user on
> linux creates a case-insensitive-duplicate file with differing
> content, which causes git on case-insensitive filesystems to lose the
> plot (you end up with one file's content looking like changes to the
> other file's content - "ghost changes" that appear as soon as you
> check out, that prevent you from doing a simple "pull", and that you
> just can't reset).

I've felt that same pain.

> I don't imagine I can make a perfectly correct and universal fix to
> this, but with case-insensitive matching on ls-tree in an update hook
> I believe I could reduce the frequency of this already-infrequent
> issue by at least 1000X, which would suit my purposes just fine. In my
> case filenames are mostly ansi-based, and I don't expect we've ever
> had Turkish filenames (turkish "i" being the most famous case-folding
> gotcha I think?).

How exactly would case-insensitive matching in ls-tree help you here?
Can't you write a hook without such capability that rejects such
collisions?

> I don't see this being something I can take on in my spare time, so
> for now I suspect I'll have to do a full-tree duplicate-file-search on
> every ref update, and simply accept the 1-second update hook
> processing time/delay per pushed ref :(

I don't see why you need to do full-tree with existing options, nor
why the ls-tree option you want would somehow make it easier to avoid.
I think you can avoid the full-tree search with something like:

git diff --diff-filter=A --no-renames --name-only $OLDHASH $NEWHASH |
sed -e s%/[^/]*$%/% | uniq | xargs git ls-tree --name-only $NEWHASH |
\
   sort | uniq -i -d

The final "sort | uniq -i -d" is taken from Torsten's suggestion.

The git diff ... xargs git ls-tree section on the first line will
provide a list of all files (& subdirs) in the same directory as any
added file.  (Although, it has a blind spot for paths in the toplevel
directory.)
