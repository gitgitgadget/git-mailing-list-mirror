Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B097C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 10:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiCNKx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiCNKxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 06:53:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497AA30F49
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:52:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c25so17048967edj.13
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=so33wluLcWntS9CdZf0ow0HvtXr+nqJClnUMi9O0kFY=;
        b=YZIKQfXTkJBgKMIRQcccazXt/rhwrPQq9reuexp9ZKRu1EbvVirKARwymY05OWouFh
         9wE+0yB2+8S4D41im7U/nql+W3SQnIX0VmHR/F5SXmRYKghRvApaR/TL26U5QTaaRby5
         0A/O7iiJGxPAyOi7hykwDKDX2hJYxQKjKQAfEb5C+DkxBhyCbFHQmIVtWfy001Qt3GfX
         DK4iblTZhPzb5ATzz/wlSUJMUl9//ynIT+kx7tsGbgdvxbHdb+ebpc+zHPK3MfuIjBsQ
         8lo4c3+i/zmFowhVyLUxo/ldDsEpzYYvlO/XfdLKzGxWwe8dIjMsK6pq5EcN8tArH4RH
         e5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=so33wluLcWntS9CdZf0ow0HvtXr+nqJClnUMi9O0kFY=;
        b=WKbrQTfC1gakqmQVD22SNxE6ZnS5WmBkdP/jcZ80S1NrtRTfADStYE3N4My9Gmhx+F
         mAywTIoaRwLuUveGM4aqi7Uqfa8PCOJ2I2c9+HVVsxoFCgNdC6ujN7unLgxiStHXYv7J
         Hir24DGpbUA+qDhnFXDzRODA56Dq2vbngm8SVS4TaJSGP5hrmIreug/UiJJ54I+mxbYd
         jpEP6qcfqGKthUgPNSYWIupOGD/rNEWLWunsWFv18VimWvXwsuzIwTcXzU472pm9tFPA
         rGDCTn96BC2pUuxL/F/zn++xxE2rJMgASG3FcyMX/lMuCZU9QXjcQLfzDrOMOUyB3a3c
         ZfDA==
X-Gm-Message-State: AOAM531R2p1SiubrrI3udcBHYw8MZb1K3TN1OG5zu3j2+Dltg2ndVtJJ
        CqBjQ23mVO625yG4Dbewemo=
X-Google-Smtp-Source: ABdhPJxR8cfWtOEFIcWen8Y5o3C+AmO59HgVH5QYfXVUDpIcVGgMZYM8EpC/51f1Tt/1Ds0YkohlGw==
X-Received: by 2002:a05:6402:cac:b0:410:a920:4e90 with SMTP id cn12-20020a0564020cac00b00410a9204e90mr19953947edb.60.1647255134659;
        Mon, 14 Mar 2022 03:52:14 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i2-20020a1709067a4200b006db720b1231sm6491449ejo.2.2022.03.14.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 03:52:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nTiJB-000P6y-MW;
        Mon, 14 Mar 2022 11:52:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>
Subject: Re: Keep reflogs for deleted (remote tracking) branches?
Date:   Mon, 14 Mar 2022 11:44:43 +0100
References: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
 <CAFQ2z_Oht=-QrzoH8FW_Jm-B7u9O0wXUaY-ifwZah6gkcgVVSA@mail.gmail.com>
 <220308.868rtky4q8.gmgdl@evledraar.gmail.com>
 <CAPMMpoiDTprbf_9J3gY6WQwUVWfOTms6LVyJDYQUOcUp-42doA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPMMpoiDTprbf_9J3gY6WQwUVWfOTms6LVyJDYQUOcUp-42doA@mail.gmail.com>
Message-ID: <220314.86y21cerhe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 14 2022, Tao Klerks wrote:

> On Tue, Mar 8, 2022 at 2:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> More generally I have not really run into this as a practical
>> problem.
>
> That's fair, nor have I - but I *have* come reasonably close: one
> person accidentally deletes a branch that someone else had prepared
> *without even realizing*, and the initial author is not available, and
> I only find out about it a few hours later. Dangling commit hunt, here
> we come. (the original author became available and re-pushed before it
> came to that)

I think you might find it interesting to have pre-receive hooks
e.g. reject pushes if you're deleting a topic whose commits aren't
entirely <your author> i.e. just something like:

    git push -o ireallymeanit=3D1 --delete topic

I.e. it's an easy to implement extra safety check that people can always
opt-out of, print a scary message and most people will think twice :)

>> Another way to solve a similar problem is to have
>> pre-receive/post-receive hooks log attempted/successful pushes, which
>> along with an appropriate "gc" policy will allow you to manually look up
>> these older branches (or even to fetch them, if you publish the log and
>> set uploadpack.allowAnySHA1InWant=3Dtrue).
>
> Yep, that's closer to my expected plan, thanks - my intent is to back
> up, on force-push and/or deletion, into a specific refspace with a
> cleanup policy, using a server hook. So after something is "deleted"
> (or force-pushed away), it can be easily recovered for a period of eg
> 3 months in that refspace, eg
> "refs/force-push-backups/YYYY-MM-DD-<BRANCHNAME>-<HASHPREFIX>".
>
> My question is specifically about the, in my opinion, very surprising
> behavior of deleting reflogs along with deleted branches - I mainly
> provided the example use-case for context.

Yes it's quite a mess, e.g. if you follow the rabit hole at the
recent[1].

One fundimental problem (discussed in various places around the reftable
backend) is that we carry N meanings for an empty reflog:

A. "This is an active branch, but we have expired the entries".

B. "I manually created this, knowing that the various core.* configs
   around reflog will say "oh, a reflog exists, let's log to it" (in
   some cases).

C. Another is: This is "stale" log, i.e. no branch exists, but the log
   is there.

Which is one reason[2] we'd delete them on branch deletion, because
otherwise we'd start logging again when a branch is re-created, which
possibly isn't what we wanted.

1. https://lore.kernel.org/git/de5e2b0e290791d0a4f58a893d8571b5fc8c4f1a.164=
6952843.git.avarab@gmail.com
2. I'm not saying this was intended, and haven't looked into this case,
   just that's it it's an emergent effect of how these files are treated
   now.
