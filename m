Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF72CECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 04:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIAEB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 00:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIAEB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 00:01:26 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA329153D15
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 21:01:25 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b2so12361572qkh.12
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=C/ZpX+aOFi6r4E2xrmr5LxlK0Lo7LXii4SafhrXbgH8=;
        b=PWrGFLX2RPrdy1T5QuRP09Ne3ede1o0Fn6FVnxYCWgjhWZRY25T7XLCbTugp35QLsw
         5Hftr6NXG0Cy/MmDiefXoKHQhqZTDkvQAfEJAcsQ1+jW5gvOrr0B72PfSLxerf9bkJQO
         a+Yk4rehVX9R1PWQhXM2wCPqx75/ysFzswhoCp9K3Q4Lb+vYjkYBmRrdcB2hxlkLyJo2
         MGz5Lnk58yEqsFSwpRS8Bj0Si7pmA632PDnMPKDBUgmjJZoR3uaBO6uOSTo5bzUpFEFe
         n1EU2jtnZA3B1tDya7qz5SEPkoq4BH8y0hVht4gSUhWDNM3outjWB4ak0Jfpr2A+WZ9l
         ZedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=C/ZpX+aOFi6r4E2xrmr5LxlK0Lo7LXii4SafhrXbgH8=;
        b=EmaGRfxe8LItraXve6c0+W+IbpSSf18RV+fg0l0P0fLdrTUNDAkI7VTfbFfIiZp/M6
         rymxtVUF9o2SFxUCzZ3pecR2GUbpehNwNhNyn6SalHqNEO74CCLiaKEgLXDQp3NMSRi/
         3ZattaEFrQS2ZdEuCLLQV3tZ/aE1xa8OOCDIJLFm1F5k4c9PhxHMeW2eD07xamEK9Z2y
         Kshq7TIldbBEXgbmrim8Eq/7aCYQBr3sXQ0LylHysAzWWMTjtHUPJkUXioODQ28AmrhC
         yr9YF+eO8x5zVuVlgw9n6IfS3Z4os7ylvrIs5e7PIKRWcCKrbKJwovTzAfxK/KjOzL1L
         zd3Q==
X-Gm-Message-State: ACgBeo271JVb2yoU98SQnzP4TPS51Z7ETBLmo9Z3TfikmPea18gtpgd9
        W6rPUS1lT4yt/0Njc4o3gxt/9gYTNwQCkCI1KRE=
X-Google-Smtp-Source: AA6agR75OAp58d2UyNPtGfH0Nv3qerfjkKDUuxlmaftWPi5jdzE61kNSVqew0hoUv8inki6oDAUDK1JeAbgEzzDppDI=
X-Received: by 2002:a05:620a:4546:b0:6bb:da4a:e0d9 with SMTP id
 u6-20020a05620a454600b006bbda4ae0d9mr18293929qkp.187.1662004885041; Wed, 31
 Aug 2022 21:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
 <xmqqv8q7dhh4.fsf@gitster.g> <CABPp-BHULBGAbmY1r9fpRr+MrjqOp7j-devOgkfA25jpYBGY9g@mail.gmail.com>
In-Reply-To: <CABPp-BHULBGAbmY1r9fpRr+MrjqOp7j-devOgkfA25jpYBGY9g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Aug 2022 21:01:14 -0700
Message-ID: <CABPp-BFJ3-MxJOuU+Rd-1AtVeC0SH3NJnpN=L0511vhkLchiJA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Output fixes for --remerge-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 8:47 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Aug 31, 2022 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Philippe Blain found and reported a couple issues with the output of
> > > --remerge-diff[1]. After digging in, I think one of them actually counts as
> > > two separate issues, so here's a series with three patches to fix these
> > > issues. Each includes testcases to keep us from regressing.
> >
> > Including this to 'seen' seems to break the leaks-check CI job X-<.
> >
> > https://github.com/git/git/runs/8124648321?check_suite_focus=true
>
> That's...surprising.  Any chance of a mis-merge?
>
> I ask for two reasons:
>   * This series, built on main, passed the leaks-check job.
>   * The link you provide points to t4069 as the test failing, but the
> second patch of this series removes the TEST_PASSES_SANITIZE_LEAK=true
> line from t4069, which should make that test a no-op for the
> leaks-check job.

Actually, looks not like a mis-merge, but some kind of faulty `git am`
application.  The merge in question isn't available for me to fetch,
but clicking through the UI from the link you provide eventually leads
me to:

    https://github.com/git/git/commit/81f120208d02afee71543d4f588b471950f156f2

which does NOT match what I submitted:

    https://lore.kernel.org/git/feac97494600e522125b7bb202f4dc5ca020ca99.1661926908.git.gitgitgadget@gmail.com/

It's close, but despite still including this part of my commit message:

"""
This also removes the TEST_PASSES_SANITIZE_LEAK=true declaration from
t4069, as there is apparently some kind of memory leak with the pickaxe
code.
"""

it's missing this part of the diff:

diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index e3e6fbd97b2..95a16d19aec 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,7 +2,6 @@

 test_description='remerge-diff handling'

-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh

 # This test is ort-specific


That part of the diff is important.  I did not add any leaks to the
code (I did run the leaks-checking job and looked through the output
to verify that none of them involved any codepath I added or
modified), but I did add some test code which exercises pre-existing
memory leaks, and testing those codepaths is critical to verify I got
the appropriate fixes.  Any idea what happened here?

Either way, I'm going to resubmit the series due to your other
suggestion.  So long as the unfortunate munging doesn't occur again,
things should be fine if you just take the new series.
