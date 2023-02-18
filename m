Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A0C636D6
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 01:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBRBQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 20:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBRBQW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 20:16:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE74FC8A
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 17:16:18 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x4so3522081lfq.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 17:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHu0pZqUd+IFNfJtfPVZ8SDQsvwfLH3F6Yto7kf0sVA=;
        b=X9Cpm+voLSrEwqfbgAiEzDBDtPgwAzbJfBzyE7w4/SFg6YAzdgZB6jBDTkRDkAg7Xq
         LaLDJJR+UvmhtgVvjazmVRLBjoP8zDz3L1s3SSJVbLDgczA6hvMvcWkS3M8iASDWoh/M
         eQkUiyhsLnbLhcTkQkO1ATIg4y6cdWzk0tITCaPOEfl11ys+CvKLuaJS2yhQShzkOYab
         QhWO73+5Mn16YeTZvS1XpyYMuo8Mm/Sdej1ycxOvI6/6mqLgxlZK6Pent659+mGXsCrp
         ayprzantolToOWLGjCFe1cDb0SOgi5J0INDC7WhRC1Mvw8bSZ8L+BC+F//Ie8E5eBoEl
         /x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHu0pZqUd+IFNfJtfPVZ8SDQsvwfLH3F6Yto7kf0sVA=;
        b=J20FOBRn+mM+GuELGkDOYAGAE/U5tcz8eeCiQxGqN3kE/whU9RIM2/PO0fu28CFutv
         pQM/w93d+PuV2iUzXigiEMAiWSTlhCtDa05aGrNVGWPAm8XicQ9Gv63t9qhU9nSKzyd9
         ii9ad8iz/MKw0d5aMrumWieXi13l7FMgmKrs6D+8AwUWQIKHobFG0+dDyeDRAwT1+sSP
         lcab/oIayUy6iwWoDTMmcP07V0FTO4NX7mISUoZLjxMg9A8zlBn6NV9h/1zPQ56FNLNj
         4zRhdCVqxU9fH0LBtkJJmDbxd6w/Uhhy+C4X1OmfX3CK6lNifksTxzHJDQwQDzwDi6iw
         RyZQ==
X-Gm-Message-State: AO0yUKWTiE/EagRXxoJD76456PD4OpvW6E0Lic+tks9TgbPfpKeVDFR2
        vyHZUQK16FMRjmay2T+TWBPMLwEbPLnPCo1VyRi+UyMd38U=
X-Google-Smtp-Source: AK7set+1Yt70WS7EzsvroUtXWrrU1cOFoMmSNJnyRT6NEdJBMBrjhEvQWHoXSLzEJRLCN+SbPOxC9glQomKPTfCdaHk=
X-Received: by 2002:ac2:5593:0:b0:4db:1326:79b2 with SMTP id
 v19-20020ac25593000000b004db132679b2mr945251lfg.2.1676682976640; Fri, 17 Feb
 2023 17:16:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com> <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 Feb 2023 17:16:04 -0800
Message-ID: <CABPp-BH4042YS7yjXGpaD=1vZOLnTZQY7L2qqpdOvsGmCxO6Dw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Teach diff to honor diff algorithms set through
 git attributes
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 12:21 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> When a repository contains different kinds of files, it may be desirable =
to
> use different algorithms based on file type. This is currently not feasib=
le
> through the command line or using git configs. However, we can leverage t=
he
> fact that gitattributes are path aware.
>
> Teach the diff machinery to check gitattributes when diffing files by usi=
ng
> the existing diff. scheme, and add an "algorithm" type to the external
> driver config.
[...]
> To address some of the performance concerns in the previous series, a
> benchmark shows that a performance penalty is no longer incurred, now tha=
t
> we are no longer adding an additional attributes parsing call:
>
> $ hyperfine -r 5 -L a bin-wrappers/git,git '{a} diff v2.0.0 v2.28.0'
> Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0 Time (mean =C2=B1 =CF=83=
): 1.072 s =C2=B1
> 0.289 s [User: 0.626 s, System: 0.081 s] Range (min =E2=80=A6 max): 0.772=
 s =E2=80=A6 1.537
> s 5 runs
>
> Benchmark 2: git diff v2.0.0 v2.28.0 Time (mean =C2=B1 =CF=83): 1.003 s =
=C2=B1 0.065 s
> [User: 0.684 s, System: 0.067 s] Range (min =E2=80=A6 max): 0.914 s =E2=
=80=A6 1.091 s 5 runs
>
> Summary 'git diff v2.0.0 v2.28.0' ran 1.07 =C2=B1 0.30 times faster than
> 'git-bin-wrapper diff v2.0.0 v2.28.0'

I'm sorry, I don't understand this.  What are you measuring?  I
presume bin-wrappers/git refers to the version of git built with your
changes, but what version of git does "git" refer to?  Also, do you
have any .gitattributes or .git/config changes present when you are
testing to trigger the new functionality you have written?

Also, doesn't this benchmark demonstrate the opposite of your claim?
You said there was no performance penalty, but the benchmark shows a
7% slowdown.  We've battled hard to get smaller improvements than
that, so this is still worrisome, even if it's no longer a factor of 2
or whatever it was.  But, again, I'm not sure what is being measured.
If the difference is because patience diff was used for some files,
then it's not an apples-to-apples comparison, and a 7% slowdown would
be no cause for concern.

Since I was curious, I compiled both a version of git from directly
before your series, and directly after, then added a '*.[ch]
diff=3Dother' line to the end of .gitattributes, then ran:

$ hyperfine -L a ./older-git,./newer-git '{a} -c
diff.other.algorithm=3Dmyers diff --numstat v2.0.0 v2.28.0'
Benchmark 1: ./older-git -c diff.other.algorithm=3Dmyers diff --numstat
v2.0.0 v2.28.0
  Time (mean =C2=B1 =CF=83):     870.2 ms =C2=B1   4.4 ms    [User: 755.2 m=
s, System: 109.8 ms]
  Range (min =E2=80=A6 max):   861.0 ms =E2=80=A6 876.8 ms    10 runs

Benchmark 2: ./newer-git -c diff.other.algorithm=3Dmyers diff --numstat
v2.0.0 v2.28.0
  Time (mean =C2=B1 =CF=83):     876.9 ms =C2=B1   4.8 ms    [User: 758.0 m=
s, System: 113.1 ms]
  Range (min =E2=80=A6 max):   870.7 ms =E2=80=A6 884.1 ms    10 runs

Summary
  './older-git -c diff.other.algorithm=3Dmyers diff --numstat v2.0.0 v2.28.=
0' ran
    1.01 =C2=B1 0.01 times faster than './newer-git -c
diff.other.algorithm=3Dmyers diff --numstat v2.0.0 v2.28.0'

I specifically specified 'myers' to match what we'd get from the
default anyway, so I would only be testing the slowdown from the
.gitattribute parsing.  So, I think the performance overhead comes out
to just 1% rather than 7% (and further that's when I make it only
print overall stats about the diff rather than the full diff, since I
know that's faster.  If I didn't do that, the perf hit might appear to
be less than 1%).
