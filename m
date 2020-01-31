Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD68AC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845E5215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 17:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDo5+Lro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgAaRr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:47:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33596 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgAaRr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 12:47:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so7395019otp.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eDlZDnTZ7WRMKL0Zd2Ip7SQU/+vgehG7wtKKSuj87+o=;
        b=YDo5+Lro142QP5/SFm6qGbadceoVHRGg4/kzWCySt+OTPDzRghvw8kchYZhtLfkIk+
         aZdmjAXZz0hAZkYifIfn4vvKZ2mIBWkopePIe0VmWMXBwQYdGqSQThjMbR5yT+dnqTdQ
         jzzi03Nsd9K4j5RFmRqZmKpIGs/XAwx6XcrmuHsffGC6Pq+o1M+f3HOrA41K2ks/qrwb
         +7bbzoVarDUJ4PMTlGzR47ri/lxUpc/4oW8HUNUd3IWPctuwBuvhJk3YvDWMrDq8wIsW
         ZiJ+ZSlyV/wLNJkpQIw9LvXKXClM5EYOlNweLDoIpx6Py9+Z1IrSEf4wJH4L6CgNVsQv
         v/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eDlZDnTZ7WRMKL0Zd2Ip7SQU/+vgehG7wtKKSuj87+o=;
        b=TaMK+FWRa7i5nraYTHERS1Y4PKcYcVa7BscbftYLOXjPeGLs0Zf/GKOtCJDT3oxOnv
         oGt4qJlhTR5rU7Z0pwIcmrTGspg1sa34piTULzvIU2Y6hin156jVWkYMdEnA5pf94wRp
         qzCYTJHMVF48N9fTawPRmqTPhrfXYP8K+bN0fVESofTUVTmL769RieY7yBhmD7TpdaGo
         EwFb9dgEe0a9oIFSX0RKatWyGMjt8zLKdB6stvFCF/RmEaFxPYc67keisiUWWd0ACb4v
         cjPz5CmJnO/O7G9Gvxd2CklOkGTCUtsaU23Q8/+uLDqzWhzEgXYD4XyFI1Yq/3aPg3/+
         qxRw==
X-Gm-Message-State: APjAAAV+iloL1GkNuCTXBYijKQRV82Y9zPqSL8Ovn58nBvl2cfRre10F
        znQIaPHfkN2dKV8d3MScQf7VkP/RElZzIaRSp4k=
X-Google-Smtp-Source: APXvYqy/iflAqMetIEKs6z5F7zzbQfyUKuqMxzY+XfB1RgZEm5S3MGqSf+Y0TWuVZL+UIv7ydtK8KSIBDHEj7GT+0pg=
X-Received: by 2002:a9d:634e:: with SMTP id y14mr8791457otk.162.1580492877176;
 Fri, 31 Jan 2020 09:47:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <40b378e7adbbff5ecfd95fd888465fd0f99791c8.1580335424.git.gitgitgadget@gmail.com>
 <20200131171341.GH10482@szeder.dev>
In-Reply-To: <20200131171341.GH10482@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Jan 2020 09:47:45 -0800
Message-ID: <CABPp-BG8wAmOL03mU2Tf8woVKdWw7o6muXenMH4G-Z6_kBEajQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] dir: replace exponential algorithm with a linear one
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 9:13 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Wed, Jan 29, 2020 at 10:03:42PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > Part of the tension noted above is that the treatment of a directory ca=
n
> > changed based on the files within it, and based on the various settings
>
> s/changed/change/, or perhaps s/changed/be changed/ ?
>
> > Since dir.c is somewhat complex, extra cruft built up around this over
> > time.  While trying to unravel it, I noticed several instances where th=
e
> > first call to read_directory_recursive() would return e.g.
> > path_untracked for a some directory and a later one would return e.g.
>
> s/for a some/for some/
>
> > However, on the positive side, it does make the code much faster.  For
> > the following simple shell loop in an empty repository:
> >
> >   for depth in $(seq 10 25)
> >   do
> >     dirs=3D$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
> >     rm -rf dir
> >     mkdir -p $dirs
> >     >$dirs/untracked-file
> >     /usr/bin/time --format=3D"$depth: %e" git status --ignored >/dev/nu=
ll
> >   done
> >
> > I saw the following timings, in seconds (note that the numbers are a
> > little noisy from run-to-run, but the trend is very clear with every
> > run):
> >
> >     10: 0.03
> >     11: 0.05
> >     12: 0.08
> >     13: 0.19
> >     14: 0.29
> >     15: 0.50
> >     16: 1.05
> >     17: 2.11
> >     18: 4.11
> >     19: 8.60
> >     20: 17.55
> >     21: 33.87
> >     22: 68.71
> >     23: 140.05
> >     24: 274.45
> >     25: 551.15
> >
> > After this fix, those drop to:
> >
> >     10: 0.00
> >     11: 0.00
> >     12: 0.00
> >     13: 0.00
> >     14: 0.00
> >     15: 0.00
> >     16: 0.00
> >     17: 0.00
> >     18: 0.00
> >     19: 0.00
> >     20: 0.00
> >     21: 0.00
> >     22: 0.00
> >     23: 0.00
> >     24: 0.00
> >     25: 0.00
>
> I agree with Derrick here: if you just said that all these report
> 0.00, I would have taken your word for it.

Thanks, I'll include all these fixes.  Good timing too, as I was about
to send a re-roll.

> Having said that...  I don't know how to get more decimal places out
> of /use/bin/time, but our trace performance facility uses nanosecond
> resolution timestamps.  So using this command in the loop above:
>
>   GIT_TRACE_PERFORMANCE=3D2 git status --ignored 2>&1 >/dev/null |
>     sed -n -e "s/.* performance: \(.*\): git command.*/$depth: \1/p"
>
> gave me this:
>
>   1: 0.000574302 s
>   2: 0.000584995 s
>   3: 0.000608684 s
>   4: 0.000951336 s
>   5: 0.000762019 s
>   6: 0.000816685 s
>   7: 0.000672516 s
>   8: 0.000912628 s
>   9: 0.000661538 s
>   10: 0.000687465 s
>   11: 0.000708880 s
>   12: 0.000693754 s
>   13: 0.000726120 s
>   14: 0.000737334 s
>   15: 0.000787362 s
>   16: 0.000856687 s
>   17: 0.000780892 s
>   18: 0.000790798 s
>   19: 0.000834411 s
>   20: 0.000859094 s
>   21: 0.001230912 s
>   22: 0.001048852 s
>   23: 0.000891057 s
>   24: 0.000934097 s
>   25: 0.001051704 s
>
> Not sure it's worth including, though.

Yeah, I'm afraid people will spend time trying to analyze it and the
numbers are extremely noisy.  I instead included some words about
counting the number of untracked files opened according to strace,
which shows before we had 2^(1+$depth)-2 untracked directories get
opened and after we had exactly $depth get opened.
