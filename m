Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A462C433F5
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 13:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiDJOB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiDJOB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 10:01:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4021E3C7
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 06:59:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z12so2662540edl.2
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ks/fIPAyILWDieqlMXOUyz2KPbdbi9jp3GrZnG49RQ=;
        b=ixAcu2o/sLZeneOzQMblf6+HGrxph9fbOQuZL5GDK6H8qKgJ9qE8OnfXGej7nOTcaH
         Ejxku554JwvfpPGhhSJPlmlf8OK27Z5QJRSoWTnSPnmmrWo0hKiWMmNCsrTj1hY/3TsR
         aj4Al2WaxgQ66yoXkuVR2Y2GfRH5Ph3OsjGv5OHTAy+UOOGYahGrvI/HZCBFvnNIbEw9
         GdwytfesTZ4Qnikc0U9kGA/M5bodJAFkX2xMyMRIau3PVxt2XuMCGbL+SnDSlNpZwioi
         UcuumJOL1b6nPaNwteLoL74K3J5DHHwp4kXnlKPyiXqb9mLVS0GQq4DURfHeQRhL3Hz0
         7PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ks/fIPAyILWDieqlMXOUyz2KPbdbi9jp3GrZnG49RQ=;
        b=STBKZ4/yJssRVvrlawR3t6+LJybe+wjwsItxKHRUAkkP1x1M2HIPHSmP1jv8aPjEIk
         hnrYDldv6vvGLYTrLDSn3/hYMJeBVdwhOeKi5iZyWp/JijaNK3Wwh/uXFdv5hv9EUVHx
         x15DWfxp+AZklV/fDkpEN1ETkWxGbjs+qKA+HGAWEDFrH3+9Na4GcfLajWh6ErUsKeoR
         TkPB2kp0ETFY3b33AWTZKuEhhRz0hzcvspH6J4B3uTvORRW1avKHoST/9cTuZQ2IqE+0
         BhPs+PiCYdo9gRmZpZcen8bC2aPKRH7SXPfewVElvMjQFpzvrLiuEJzbiyZmamjGIPXt
         67Cw==
X-Gm-Message-State: AOAM532ZUFf7T6/rHKNLB+Pj6c/usXQ50rwiy4Rnab8owbhsEYWPlUnP
        8qCTuwK9rSLai9D4LyjqT9iNPb2pDHfsa+3dmYjceQ==
X-Google-Smtp-Source: ABdhPJxdPQesuW8GOrbFvrK3T67QPGom3cVK8BqW5DDA9Xo3QTq4ZfzHi6frYinQJGmQP0tgVgUbC/tLHky2HkBmm6w=
X-Received: by 2002:a05:6402:1c02:b0:41d:61b0:3f89 with SMTP id
 ck2-20020a0564021c0200b0041d61b03f89mr8986143edb.281.1649599184405; Sun, 10
 Apr 2022 06:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net> <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz>
In-Reply-To: <20220409113244.GX163591@kunlun.suse.cz>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 10 Apr 2022 15:59:33 +0200
Message-ID: <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
Subject: Re: Make commit messages optional
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 9, 2022 at 1:32 PM Michal Such=C3=A1nek <msuchanek@suse.de> wro=
te:
>
> On Fri, Apr 08, 2022 at 07:32:03PM -0400, rsbecker@nexbridge.com wrote:
> > On April 8, 2022 6:30 PM, brian m. carlson wrote:
> > >On 2022-04-08 at 03:35:04, jurgen_gjoncari@icloud.com wrote:
> > >> I think that often commit messages are unnecessary. I propose that b=
y
> > >> default a user should be able to commit without a message.
[...]
> > >We want to encourage good software engineering practices.
> > >
[...]
> > >
> > >Users who want this behaviour can use --allow-empty-message or create =
an alias
> > >with that option.  The functionality already exists.  I use aliases ex=
tensively in my
> > >development and I know others do as well, so this shouldn't be an impe=
diment if
> > >you're working on projects where this is acceptable.
> > >
[...]
>
> There is nothing stopping you using '.' as the commit message which is
> as informative as when it is empty. Hence this enforcement of non-empty
> commit message does not serve the stated purpose.

My apologies if this proposal has already been made in this or prior
discussions - the list server and gmail are having another
disagreement, so I think I'm a few hours out of date.

I believe the main argument *for* allowing empty commit messages by
default is "we shouldn't make it hard to do what you want to do, if
you can fix it later", and the main argument *against* is "for most
people (non-advanced users), what you do initially is what you end up
pushing, or at least trying to push, and fixing things later is *hard*
- it requires a much deeper understanding of git than most people
otherwise necessarily need to develop".

In that sense, allowing people to create empty commit messages when
they shouldn't, is often "trapping" them into a commit history that is
less valuable (or even acceptable) than they might otherwise have
achieved.

While I therefore disagree with Aevar's proposal to "allow empty, and
advise", I do think the notion of giving advice makes perfect sense -
let's do it the other way around, with an advice message something
like:

---
Empty commit messages aren't normally allowed, as they reduce the
understandability of the commit history. If you do need to create a
commit with an empty message, you can do so by providing the
'--allow-empty-message' argument to 'git commit'.
---

Has this already been considered/discussed? Would it meet the
objectives of those folks saying "the rejection of empty messages
wasted my time", while also keeping the spirit of "we should make it
easy to do the right thing and harder to do the wrong thing,
especially for beginners"?

Thanks,
Tao
