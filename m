Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B10C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 06:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJMGfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 02:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMGf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 02:35:29 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546210691E
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 23:35:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i9so757268qvo.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 23:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMusKAnn8u/RPZYAvzUXT2LTniDx8U0ZKYlJm6eI018=;
        b=aj5WNr1qtk3XYVaY9s2gTNmmHRa2h9EMBtOKvIKdbb6nXyRaDFkYP00KIFZiJkH8TX
         l5SDFAaM67xNExizqCoZjoTswvgzjMqT62QFr+NwW34JeUayr4uHuDiq6bC+N4qJqdyv
         3NsbecqBKsz7BA2APXKWqBUO25PvNhucFbTkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMusKAnn8u/RPZYAvzUXT2LTniDx8U0ZKYlJm6eI018=;
        b=Bq81V2I7wLDGjcSVj03XyUvVhDS7tAx0WoGePZCDRuAG/JFaWlc4DvPUlZzpTlqsyE
         w8qk/pD/EEctRsZqvcz3xQMr6ER4Igm9xQszf3ZAhHIlSUyDmCOvLORLsU5+nUNQsg0Z
         n40bH9LROnfPpEMjfBlgUO0uJN9px+x4vS2efrFvD71bdaoZuSVBjqkCnVHeLLqOHgS+
         K6EefiJGZjUZ0jSAnpf/TVeWWqTa4Y0F9WntlXCXE6eLWe8j5sgx1QrfsOMj9dQckwZ1
         zSKIe5VOGAhixKDFpBiQv+khO0B4qRsXwjKJwNHbdXjIJ27uIDz8pRMO5BSKR/ri/AQY
         sLXQ==
X-Gm-Message-State: ACrzQf20o7CyRwLPjHa8bTs6smzkO4g14g0+ajpCKGRRDZZO1o5yHlks
        Vs0Ci7ra91RUYNUenxJwvEjUBIHHguqIDAjinwrcaA==
X-Google-Smtp-Source: AMsMyM6dsFIWrUdwZhemLftTuhWF3HUwNd/UdohkwCKG5min2io6Io4vYnHYvJPISqoqTaUiUxt7DkG8taHFPhz0lDo=
X-Received: by 2002:a0c:a711:0:b0:4b1:8816:4168 with SMTP id
 u17-20020a0ca711000000b004b188164168mr25759136qva.46.1665642923529; Wed, 12
 Oct 2022 23:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com> <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
In-Reply-To: <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 13 Oct 2022 08:35:11 +0200
Message-ID: <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
Subject: Re: icase pathspec magic support in ls-tree
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 2, 2022 at 9:07 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-09-30 at 13:53:16, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > You might find ASCII-only sufficient, but note that even if you get thi=
s
> > working you won't catch the more complex Unicode normalization rules
> > various filesystems perform, see the fsck code we carefully crafted to
> > make sure we don't get something those FS's will mistake for a ".git"
> > directory in-tree.
>
> What's even worse is that different OSes case-fold differently and the
> behaviour differs based on the version of the OS that formatted the file
> system (which is of course not exposed to userspace), so in general it's
> impossible to know exactly how case folding works on a particular
> system.
>
> It might be possible to implement some general rules that are
> overzealous (in that they will catch patterns that will case-fold on
> _some_ system), but in general this is very difficult.  The rules will
> also almost certainly change with newer versions of Unicode.
>
> I'll also point out that there is no locale-independent way to correctly
> case-fold Unicode text.  Correct case-folding is sensitive to the
> language, script, and region.

Thanks for the feedback!

If I'm understanding correctly, both of these responses were targeted
specifically at my motivation/usecase (preventing the submission of
case-insensitively duplicate files into a repository) rather than the
question of whether anyone has worked or is working on anything
relevant to adding icase pathspec magic support to ls-tree.

I understand that case-folding is a complex topic, and doing it
correctly in some universal sense is undoubtedly beyond me - but "my"
context certainly does not require a high standard of correctness:
There's a repo shared by some 1000 engineers, 200k files, lots of
activity, three different OSes of which two default to
case-insensitive filesystems, and every once in a while a user on
linux creates a case-insensitive-duplicate file with differing
content, which causes git on case-insensitive filesystems to lose the
plot (you end up with one file's content looking like changes to the
other file's content - "ghost changes" that appear as soon as you
check out, that prevent you from doing a simple "pull", and that you
just can't reset).

I don't imagine I can make a perfectly correct and universal fix to
this, but with case-insensitive matching on ls-tree in an update hook
I believe I could reduce the frequency of this already-infrequent
issue by at least 1000X, which would suit my purposes just fine. In my
case filenames are mostly ansi-based, and I don't expect we've ever
had Turkish filenames (turkish "i" being the most famous case-folding
gotcha I think?).

Coming at this from another angle, I guess we could teach git on
case-insensitive filesystems to detect this situation (where two files
in the index, with different contents, are pointing to the exact same
filesystem file) and more explicitly warn the user of what's wrong,
giving them clear help on how to fix it? And temporarily exclude those
two files from its change reconciliation processes altogether to avoid
ghost changes interfering with recovery actions like "pull"? Certainly
that would be better than the current "ghost changes" behavior... but
it would still be far less convenient than preventing (the vast
majority of) these issues altogether, be that with a custom hook or a
core option prohibiting clearly case-insensitive-duplicate files from
being pushed.

By the time a case-insensitive-FS-user encounters this issue in their
repo as they checkout or clone, it's likely that the problem is in
master/main and others are already affected, and both the cycle time
to fixing the issue, and the communication impact in the current state
("please wait, the issue is being addressed, once the remote branch is
fixed here's what you'll do to 'pull' successfully in spite of the
local repo thinking there are filesystem changes that really don't
exist and can't be reset") are... suboptimal.

It feels like adding case-insensitivity pathspec magic support to
ls-tree (however reliable or universal the subsequent
duplicate-detection is or isn't) *should* be much simpler than what it
would have taken to support it in ls-files in the first place - but at
a glance, I see the official pathspec-supporting function
"match_pathspec()" is deep in index-land, with an "index_state"
structure being passed around all over the place. If it really was
easy, someone would already have done it I guess? :)

I don't see this being something I can take on in my spare time, so
for now I suspect I'll have to do a full-tree duplicate-file-search on
every ref update, and simply accept the 1-second update hook
processing time/delay per pushed ref :(

I'm assuming the "ghost changes" behavior I allude to here (where two
different files in the index, with different contents, point to the
same single file in the case-insensitive filesystem, and one or the
other index file appears modified / the working tree looks "dirty") is
a known issue, but if there's any value in my opening a thread more
clearly/explicitly about this behavior, please let me know.

Thanks,
Tao
