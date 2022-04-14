Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE431C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 20:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiDNUFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 16:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiDNUFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 16:05:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16F5DCAB6
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 13:02:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eba71ef663so50745447b3.14
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=UlcJHzxzuX2ciTSBwcc0PWMo5Dwc1Rrg2qdpBEGUl4I=;
        b=csDKL1kjk7FsqhZCVA9gyLJhxjUtwJnwh97oR9S2Ll8CEnstA+18L5/GPM2kDGSJBR
         JeIfvDX4eBDV+3WWbXSyXm6wbquK+w1Lmqrj0p6hJQhKpYCJDi/1JlmzprAJFtIc/7Jw
         DL4Y/4Dv4T87VrzXn7OFULVn973O+TQQK+YRhuD+7veilTqGrbI9Y0L3ZLU9aswb50tX
         YhEKcXCUstYD5O7ntnabqjQpz6E4q1VBl+kNoK46qCjsxZgsbrOJnYgrjYB1b+q7XGcY
         5FIfVt4ZSIEg0+eZmhODl7Za7QY4K56oFbLRc1QXcMEhQMnWyN2IMS4mRR2aHzsnPaQC
         xQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=UlcJHzxzuX2ciTSBwcc0PWMo5Dwc1Rrg2qdpBEGUl4I=;
        b=nL658yZZQWU6IG8f3WG+ATY6R5UUwXuJAMBKAy9LKwrdgiOMlOhT/Ye3uwA8oKiQZn
         duZhxHlr+gy3cToRS7ZqxeqhaLfVbgQHmsrwRS37wV4LNqzKNtG67qzT1G9k6rEscuTm
         tqqHh99r1jZRcXy/INKJvRvT1ZLW5KsjNdAtPyABjIFYj/3U+X8sb9NMseTOGu2cwr/f
         uqtLNQL5Fb9W2CbwUdz1vLaGzB3apKVWXeQ08mwe4Gq4YC0RE73e07vzWcXwohBtu0ia
         tD+c1peK3itRX6eGtB7XB72eY7erI08tTesNDi94qKrj6gGS+8TMNeDnH2p3g1uU1EIV
         fy7A==
X-Gm-Message-State: AOAM531+XvYCYXLbA5FLfN7kSMyjIdATRl1s8AxoMnWas3rtzk0SYBN9
        6I8f+Oj6sT+KSvIREyRIC8cUQtytGSXTuw==
X-Google-Smtp-Source: ABdhPJzeyN057ek0igPVDv43h7i+SmeqTy4lmYPl7H8kXwRqV5JQAcfHm1W0ThuNN54Pn8ieuN1B+SN2c6D39A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a5b:783:0:b0:641:7e2f:80d with SMTP id
 b3-20020a5b0783000000b006417e2f080dmr2909299ybq.483.1649966563173; Thu, 14
 Apr 2022 13:02:43 -0700 (PDT)
Date:   Thu, 14 Apr 2022 13:02:33 -0700
In-Reply-To: <220407.86lewhc6bz.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lee1z8mcm.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220406232231.47714-1-chooglen@google.com> <nycvar.QRO.7.76.6.2204071440520.347@tvgsbejvaqbjf.bet>
 <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com> <220407.86lewhc6bz.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 07 2022, Derrick Stolee wrote:
>
>> A more complete protection here would be:
>>
>>  1. Warn when finding a bare repo as a tree (this patch).
>>
>>  2. Suppress warnings on trusted repos, scoped to a specific set of know=
n
>>     trees _or_ based on some set of known commits (in case the known tre=
es
>>     are too large).
>>
>>  3. Prevent writing a bare repo to the worktree, unless the user provide=
d
>>     an opt-in to that behavior.
>>
>> Since your patch is moving in the right direction here, I don't think
>> steps (2) and (3) are required to move forward with your patch. However,
>> it is a good opportunity to discuss the full repercussions of this issue=
.
>
> Isn't a gentler solution here to:
>
>  1. In setup.c, we detect a repo
>  2. Walk up a directory
>  3. Do we find a repo?
>  4. Does that repo "contain" the first one?
>     If yes: die on setup
>     If no: it's OK
>
> It also seems to me that there's pretty much perfect overlap between
> this and the long-discussed topic of marking a submodule with config
> v.s. detecting it on the fly.

Your suggestion seems similar to:

  =3D=3D 3. Detect that we are in an embedded bare repo and ignore the embe=
dded bare
  repository in favor of the containing repo.

which I also think is a simple, robust mitigation if we put aside the
problem of walking up to the root in too many situations. I seem to
recall that this problem has come up before in [1] (and possibly other
topics? I wasn't really able to locate them through a cursory search..),
so I assume that's what you're referring to by "long-discussed topic".

(Forgive me if I'm asking you to repeat yourself yet another time) I
seem to recall that we weren't able to reach consensus on whether it's
okay for Git to opportunistically walk up the directory hierarchy during
setup, especially since There are some situations where this is
extremely expensive (VFS, network mount).

I actually like this option quite a lot, but I don't see how we could
implement this without imposing a big penalty to all bare repo users -
they'd either be forced to set GIT_DIR or GIT_CEILING_DIRECTORIES, or
take a (potentially big) performance hit. Hopefully I'm just framing
this too narrowly and you're approaching this differently.

PS: As an aside, wouldn't this also break libgit2? We could make this
opt-out behavior, though that requires us to read system config _before_
discovering the gitdir (as I discussed in [2]).

[1] https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com=
/
[2] https://lore.kernel.org/git/kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.c=
orp.google.com
