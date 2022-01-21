Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BCC4332F
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 16:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381926AbiAUQ5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 11:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379861AbiAUQ4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 11:56:49 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CCBC06176A
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 08:55:38 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id j2so1729490ejk.6
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7pzXx3ke6/NCsWYlndVWlQY7pgz2IYF3bgFSKMiyUI=;
        b=km2vRphY6DwuYh4ZYov/n6aE5hW7nUaJ9Ax1ug/ZSHJIx7WgUdOEgiQFUpLfxgsGQZ
         Oh/lScVuwVaz+5CSpHNryoE6uXSd9xG/jPF/RdgJu90n8jCBn+yxuR2f58S0BRhD1yDJ
         OL8r1HJgKfrPWZQoysvzeAb7uPzdVo472FfkP+9/wJ/K601kW4A0L324GkORBgA+RH9v
         3xVBBnIIAOG58ZXKgpkdtUeSpoqpmEjR+obxzbt+wy+WCVVJXKNE8sYUq1uDjoLI5TIK
         tPDkTePmtvMlM7A5PbgVX2eM6g/SzMzcBa8hZK3H4t9Sb9ai8pCV51FYRF3Q/VmuQhXJ
         CsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7pzXx3ke6/NCsWYlndVWlQY7pgz2IYF3bgFSKMiyUI=;
        b=2nzIXvAqwb3bE5OWD1JauCEo/X9VAPMU2OhuhCWqPLaSHPGRAn3nStUl0frilWj8uZ
         q3hR018MD3ukuoNmWyK0Uaf8IRN/xyBO70/I6EJZ0B1lpmLiWRW2MaPInJF7R15l5jgT
         PsrJIHb8gdGYj47mp6LWLvTi/GS3HnL7787ZTRNg2fEsgNp7xbjtJMi90FOiQa7Dk3Lk
         X8ftQhRMGPcDydn/fsH4GACm6A/GN3m8ERKdUi0AsFyTrjO4qSU1GHxQbL7JFBYlc8Dn
         bAP5sLZIM2r4Enf/u9c61YMwLGZHg4jj/wO5WgS3jwPxhhSDK1S85UYR/LL5QTWJPxYk
         GOpQ==
X-Gm-Message-State: AOAM532Kb4I7wwCcHBnJjIqo43dyxJfZlssm/jLUv1Vask2GXlHL08hd
        riQa2ziy+Dd/pJngaSY+gxNy8SFvxjT1YKVlIVk=
X-Google-Smtp-Source: ABdhPJyCOegqnqGMj58Bg8CLVVogjHHG0sU7o2LhUa0wCL0b+zY7MRvy4og4gMNOVly6z8BISIpJV6Om8VNldplnNG8=
X-Received: by 2002:a17:906:dc8e:: with SMTP id cs14mr3925536ejc.269.1642784136497;
 Fri, 21 Jan 2022 08:55:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com> <78ec1f44e4eacdb05c9da749a2160f4748565ad3.1640907369.git.gitgitgadget@gmail.com>
 <220120.868rvamyu9.gmgdl@evledraar.gmail.com> <CABPp-BHjU+wDXNnf-rsGy86GvOFWH6qVLPEfAA2JDfLFRU4WSA@mail.gmail.com>
In-Reply-To: <CABPp-BHjU+wDXNnf-rsGy86GvOFWH6qVLPEfAA2JDfLFRU4WSA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Jan 2022 08:55:24 -0800
Message-ID: <CABPp-BFgWH9Vn3oaiOe26ktSDUHzJZYzCa9FNpUxKt+r=PrRZw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] show, log: include conflict/warning messages in
 --remerge-diff headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 6:16 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jan 20, 2022 at 3:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
...
> > As noted before I find the current output really useful already. I've
> > just been trying to poke it in various ways to see if I can uncover any
> > bugs or unintended behavior.
>
> Very helpful, thanks.  So, I think there are three issues here:
>
>    * default history simplification is surprising for
> --diff-merges=3D{separate,first-parent,remerge}, particularly in
> combination with pathspecs.  Document that, or just have these options
> turn on --full-history.
>    * more tests would be useful (though I'm worried about
> combinatorial explosion, so I think just a few more would be good,
> particularly around the --diff-filter options)
>    * interactions with --diff-filter are suboptimal.  We need
> something better, but if I revert my other changes to fix that issue
> then I break the simple "Did this merge have conflicts?" usecase.  We
> need some clever solution.

I tried out making the conflict headers be shown by --diff-filter=3DU
*OR* whenever the associated diff for that file would be shown (e.g.
if --diff-filter=3DR selects the file and it had a conflict header, it'd
show the conflict header.)  For diff-filters other than U that don't
match the filediff, nothing for the file shows up.  Seems to work
great, and cleans up the output quite a bit.

I've added more tests, including one for pathspecs since that did need
just a little more work.  I'll get it cleaned up and resubmitted soon.
