Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A2C636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 16:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjBTQVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 11:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjBTQVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 11:21:38 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF846B8
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:21:36 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a30so1825021ljr.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQCLq0BB5DJNVFEhyan2iEBflsKJP2GauX66mgOEtIM=;
        b=L1AbkExtYoVsCadKtKRhGTQ/wBqclUOwhDrKKiRuBSF/q90gtF/ER0hPOhsFwtbxP5
         +jcS03Oa596mzMITMhPPLXHoi7ftrdJx2wscsuGTKpNEk6ctTjCgF644osLFx1Y36gFb
         GBmMi89XYAFkVs3am45jk0o0bNQ7GkABNXfNAqQqzkoPbMjQPJp9OE5A6a6gI9xPVVP8
         u3uf7GiP4EG7BgNBXj8aYSA6byjkYPX/L1HNJLqa211Y5CHrCa1kEMNw080HkbZl/26H
         44XXBFbxkQWVHD2bXd3jijRWIMdlkZtuKyULUh7nXDEdRpAAcEA5YxWgFP4WO9+OuLVT
         0ANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQCLq0BB5DJNVFEhyan2iEBflsKJP2GauX66mgOEtIM=;
        b=O061p7wJH68UwLoZbsFIL2VAq5UjDXMPphyDndMboyLYNEmQNHQHlgk5xlD2Uu/h9u
         f6wtCaaBreBv5Vbs+p4JdIm1wXrqWlvG3izQ9h4slOQ+OgSO3jVGIZ+zqOBaLiUWIALP
         B2qvV1s7vdGYrQM8TWfcYtgVuRI5/+v48mfnf1hKVY6QbBslXzXyBEO15+ax6x5NYmUF
         fe7rtsWDvd5N/4fSQoDnPEtGR6eY/GBfKTbAgts1xVYcjmfE0uDTWBZGVai4bL7RzLmm
         ArCQvcROR0zvqYCZi9+hC+x+Wb/IQEg/SYzj4k1/m8HCfiws2bYAooqKnSbh58R0ZQxw
         qnlw==
X-Gm-Message-State: AO0yUKWSRqNATBdIgmrwKoj/2lhq1OLBlITIL76rnC2q9ymlDoYk/uGd
        LAsm/sFwaK8tUyAEDlyCvkTgcrqG8ol0Npt3SAHtKFd683M=
X-Google-Smtp-Source: AK7set9fLCUk7obApHlSQ/mG43C8Hh3hEz337cJYQ2usi27y79dHg8wTc/WH/tPiCG/1FCq2a1XuUKR4hyfWmOe9GLU=
X-Received: by 2002:a05:651c:10aa:b0:293:4be3:9e6c with SMTP id
 k10-20020a05651c10aa00b002934be39e6cmr812724ljn.1.1676910094562; Mon, 20 Feb
 2023 08:21:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com> <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
 <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com> <EE7565DF-BE70-4C45-AF0B-95C85050DFA4@gmail.com>
In-Reply-To: <EE7565DF-BE70-4C45-AF0B-95C85050DFA4@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Feb 2023 08:21:22 -0800
Message-ID: <CABPp-BGDi1VQXFdGw_Y8i0ZDBOoHJe9039fh4mO44qJ-nJE1ig@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 7:32 AM John Cai <johncai86@gmail.com> wrote:
[...]
> > I'm still curious if this should this also include warnings/caveats, such as:
> >   * The diff attribute specified in .gitattributes will be ignored in
> > a bare clone
> >   * The diff attribute specified in .gitattributes will be ignored if
> > it is only specified in another branch (e.g. on a branch "special-file
> > diff=patience" recorded in .gitattributes, then checkout master but
> > run `git log -1 -p $branch`)
> >   * When a file is renamed, the diff attribute for the pre-image name
> > is the only one the system pays attention to (thus adding "-R" can
> > flip which diff algorithm is run for the renamed file).
>
> I would be fine with adding that--though originally I was thinking that these
> can be inferred from the way that gitattributes are documented in [1]. Calling
> these out would make it more clear though, so I could go either way.
>
> >
> > Also, since I tested the three items above to verify they are valid
> > warnings, I'm a bit confused.  I thought your intent was to use this
> > server-side[1], so isn't the bare clone aspect a deal-breaker for your
> > intended usecase?
> >
> > [1] https://lore.kernel.org/git/7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gmail.com/
>
> yes, indeed. I was planning on adding bare repository support in a separate
> patch series, since the additions in [2] allows .gitattributes to be read from a
> bare repository.
>
> 1. https://git-scm.com/docs/gitattributes
> 2. https://lore.kernel.org/git/0ca8b2458921fc40269b0c43b5ec86eba77d6b54.1673684790.git.karthik.188@gmail.com/
>
> thanks!
> John

Oh, interesting, I didn't know about [2].  So, is the plan to take the
--source option from that series and add it to diff (perhaps with a
different name, since log tends to consume diff options and --source
is already taken)?

And do you expect to get the tree-ish from the two the users are
already specifying to diff?  If so, which one do you use (the two
commits being diffed might have differing .gitattributes files)?  If
not, what does that mean for users of e.g. the GitLab UI who have to
specify a third tree when diffing?
