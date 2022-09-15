Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7132BC32771
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIOXZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiIOXZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 19:25:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21373915
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 16:25:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k21so9268813pls.11
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=mWTMUeDVXFnSaNb3jgGw7+X+Xu5QeeB1CHXGlYA5UHI=;
        b=e7SQdwEneEzH8i3yhxJWDHsiLIwTpJ6eRJryAigE2SERBEy7VXAbd6Ow+cpNgaLqvr
         ueaStAl1o7XYRRnSeIRQmeWCEaM14dWnu3mffHeeQxtLRkgJlf5LTK6Q++4TkSGGFqkj
         e8LxItmMdmOcy9zLA14URRIJu9+xRQFytvyoNUWyXB/7cLdxI1T1JO1z9vfA9sFgkF5m
         +jvyM/cOrUsENliCcfaYPVzCTstiu1xXJM7OknjPvNB6oPSLEpd0Dg16o/doAuISsQpq
         +pg/4+uIL4wE/6gLCP6wRtLXwW8YNPkyyiLVgYqNAPWfFkE/INpsO1I1DMBeavlETfoP
         2RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mWTMUeDVXFnSaNb3jgGw7+X+Xu5QeeB1CHXGlYA5UHI=;
        b=tD/KMCBEP/huWAdoesPxyDWBKHNUm3oACAPFfD64RZPo6hLQlXZOZs0HEP9Hxf5Rnp
         LPrnj+kCvIg3B+bm3pB90G+rb+GAB5HOPIkRyKpEFYh83y8KnsFliPg1G0/M/A4cC1jE
         /I3toS0FgCqk39z5qTGfHACn8TOuRJ7e0KHgvrUrnnGGwJk/aF6k54ZEwCUqVYkhMgMv
         iMpGM5iQwnx63Z7Ucjt+eEh5hM46WPUA9QFJkDts/WBXkXUoEnRFwjMfSZSf8OgFK49m
         kNTh/4NR2pkTWqdG5qleidCde2n4HG6UxxmT8GY9tua3QKGH3cyFgkTyLi0QhiHWksYq
         VSSg==
X-Gm-Message-State: ACrzQf3u8IxQar2uTUVhCowOp9cykfW7IWNvBLvPhmCyufELg07r7YK4
        BnuBdod6IJcz0P4Keu+xIyhDJA==
X-Google-Smtp-Source: AMsMyM7CfgjX6/84Yt5Gc8XsDihYW9p+APOuWcfVCdRel1BoRaM7dPkVgwu9nVPUWAO2Rw/PckKSdQ==
X-Received: by 2002:a17:90b:3b91:b0:202:91d7:6a5d with SMTP id pc17-20020a17090b3b9100b0020291d76a5dmr2247045pjb.101.1663284315099;
        Thu, 15 Sep 2022 16:25:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:d04f:bcc9:b0ae:210d])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a050800b00203125b6394sm155016pjh.40.2022.09.15.16.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 16:25:14 -0700 (PDT)
Date:   Thu, 15 Sep 2022 16:25:07 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] Documentation: add ReviewingGuidelines
Message-ID: <YyO0U+52vJuTlfo7@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I like all the advice here, thanks for the patch! My only quibble is
that the items in the "Reviewing patches" section might be worth
re-ordering based on topic / importance. For example, I think
"philosophy" items like "patches should include test coverage" is more
important than tips on how to use diff flags, and so it would make sense
to be listed earlier. But this is subjective, and the doc is short so
in practice it probably doesn't matter.

Thanks again!

Reviewed-by: Josh Steadmon <steadmon@google.com>


On 2022.09.09 18:13, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Add a reviewing guidelines document including advice and common terminology
> used in Git mailing list reviews. The document is included in the
> 'TECH_DOCS' list in order to include it in Git's published documentation.
> 
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>     Documentation: add ReviewingGuidelines
>     
>     This patch follows up on a discussion a few weeks ago in the Git IRC
>     standup [1], where it was mentioned that it would be nice to have
>     consistent definitions for common review terminology (like 'nit:'). The
>     "ReviewingGuidelines" document created here builds on that idea, as well
>     as past discussions around the idea of advice for reviewers (similar to
>     the guidelines for new contributors in MyFirstContribution [2]).
>     
>     The goal of this document is to clarify & standardize some of the more
>     niche concepts important to the Git project ("What's cooking" emails,
>     terminology), as well as provide general reviewing advice based on my
>     observations of effective reviews from others on the mailing list.
>     
>     One thing that's particularly important to me here is that the advice
>     presented here does not gatekeep or otherwise denigrate the personal
>     preferences or style of reviewers. With that in mind, one of the things
>     I'm looking for in reviews of this document is making sure that the tone
>     & content reflect that more positive/encouraging intent. And, of course,
>     I'm happy to hear what other tips & terminology people think would be
>     helpful to include!
>     
>     Thanks!
>     
>      * Victoria
>     
>     [1]
>     https://colabti.org/irclogger/irclogger_log/git-devel?date=2022-08-29#l53
>     [2] https://git-scm.com/docs/MyFirstContribution
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1348%2Fvdye%2Ffeature%2Freviewing-guidelines-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1348/vdye/feature/reviewing-guidelines-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1348
> 
>  Documentation/Makefile                |   1 +
>  Documentation/ReviewingGuidelines.txt | 160 ++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/ReviewingGuidelines.txt
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index bd6b6fcb930..d3a19df8bed 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -101,6 +101,7 @@ SP_ARTICLES += howto/coordinate-embargoed-releases
>  API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
>  SP_ARTICLES += $(API_DOCS)
>  
> +TECH_DOCS += ReviewingGuidelines
>  TECH_DOCS += MyFirstContribution
>  TECH_DOCS += MyFirstObjectWalk
>  TECH_DOCS += SubmittingPatches
> diff --git a/Documentation/ReviewingGuidelines.txt b/Documentation/ReviewingGuidelines.txt
> new file mode 100644
> index 00000000000..bcc59baf863
> --- /dev/null
> +++ b/Documentation/ReviewingGuidelines.txt
> @@ -0,0 +1,160 @@
> +Reviewing Patches in the Git Project
> +====================================
> +
> +Introduction
> +------------
> +The Git development community is a widely distributed, diverse, ever-changing
> +group of individuals. Asynchronous communication via the Git mailing list poses
> +unique challenges when reviewing or discussing patches. This document contains
> +some guiding principles and helpful tools you can use to make your reviews both
> +more efficient for yourself and more effective for other contributors.
> +
> +Note that none of the recommendations here are binding or in any way a
> +requirement of participation in the Git community. They are provided as a
> +resource to supplement your skills as a contributor.
> +
> +Principles
> +----------
> +
> +Selecting patch(es) to review
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +If you are looking for a patch series in need of review, start by checking
> +latest "What's cooking in git.git" email
> +(https://lore.kernel.org/git/xmqqilm1yp3m.fsf@gitster.g/[example]). The "What's
> +cooking" emails & replies can be found using the query `s:"What's cooking"` on
> +the mailing list archive; alternatively, you can find the contents of the
> +"What's cooking" email tracked in `whats-cooking.txt` on the `todo` branch of
> +Git. Topics tagged with "Needs review" and those in the "[New Topics]" section
> +are typically those that would benefit the most from additional review.
> +
> +Patches can also be searched manually in the mailing list archive using a query
> +like `s:"PATCH" -s:"Re:"`. You can browse these results for topics relevant to
> +your expertise or interest.
> +
> +If you've already contributed to Git, you may also be CC'd in another
> +contributor's patch series. These are usually topics where the author feels that
> +your attention is warranted; this may be due to prior contributions,
> +demonstrated expertise, and/or interest in related topics. There is no
> +requirement to review these series, but you may find them easier to review as a
> +result of your preexisting background knowledge on the topic.
> +
> +Reviewing patches
> +~~~~~~~~~~~~~~~~~
> +While every contributor takes their own approach to reviewing patches, here are
> +some general pieces of advice to make your reviews to be as clear and helpful as
> +possible.
> +
> +- Provide your review comments per-patch in a plaintext "Reply-All" email to the
> +  relevant patch. Comments should be made inline, immediately below the relevant
> +  section(s).
> +
> +- Remember to review the content of commit messages for correctness and clarity,
> +  in addition to the code change in the patch's diff. The commit message of a
> +  patch should accurately and fully explain the code change being made in the
> +  diff.
> +
> +- You may find that the limited context provided in the patch diff is sometimes
> +  insufficient for a thorough review. In such cases, you can review patches in
> +  your local tree by either applying patches with linkgit:git-am[1] or checking
> +  out the associated branch from https://github.com/gitster/git once the series
> +  is tracked there.
> +
> +- Large, complicated patch diffs are sometimes unavoidable, such as when they
> +  refactor existing code. If you find such a patch difficult to parse, try
> +  reviewing the diff produced with the `--color-moved` and/or
> +  `--ignore-space-change` options.
> +
> +- Reviewing test coverage is an important - but easy to overlook - component of
> +  reviews. A patch's changes may be covered by existing tests, or new tests may
> +  be introduced to exercise new behavior. Checking out a patch or series locally
> +  allows you to manually mutate lines of new & existing tests to verify expected
> +  pass/fail behavior. You can use this information to verify proper coverage or
> +  to suggest additional tests the author could add.
> +
> +- If a patch is long, you can delete parts of it that are unrelated to your
> +  review from the email reply. Make sure to leave enough context for readers to
> +  understand your comments!
> +
> +- When pointing out an issue, try to include suggestions for how the author
> +  could fix it. This not only helps the author to understand and fix the issue,
> +  it also deepens and improves your understanding of the topic.
> +
> +- Reviews do not need to exclusively point out problems. Feel free to "think out
> +  loud" in your review: describe how you read & understood a complex section of
> +  a patch, ask a question about something that confused you, point out something
> +  you found exceptionally well-written, etc. In particular, uplifting feedback
> +  goes a long way towards encouraging contributors to participate more actively
> +  in the Git community.
> +
> +- When providing a recommendation, be as clear as possible about whether you
> +  consider it "blocking" (the code would be broken or otherwise made worse if an
> +  issue isn't fixed) or "non-blocking" (the patch could be made better by taking
> +  the recommendation, but acceptance of the series does not require it).
> +  Non-blocking recommendations can be particularly ambiguous when they are
> +  related to - but outside the scope of - a series ("nice-to-have"s), or when
> +  they represent only stylistic differences between the author and reviewer.
> +
> +- If you cannot complete a full review of a series all at once, consider letting
> +  the author know (on- or off-list) if/when you plan to review the rest of the
> +  series.
> +
> +- If you read and review a series but find nothing that warrants inline
> +  commentary, reply to the series' cover letter to indicate that you've reviewed
> +  the changes.
> +
> +Completing a review
> +~~~~~~~~~~~~~~~~~~~
> +Once each patch of a series is reviewed, the author (and/or other contributors)
> +may discuss the review(s). This may result in no changes being applied, or the
> +author will send a new version of their patch(es).
> +
> +After a series is rerolled in response to your or others' review, make sure to
> +re-review the updates. If you are happy with the state of the patch series,
> +explicitly indicate your approval (typically with a reply to the latest
> +version's cover letter). Optionally, you can let the author know that they can
> +add a "Reviewed-by: <you>" trailer to subsequent versions of their series.
> +
> +Finally, subsequent "What's cooking" emails may explicitly ask whether a
> +reviewed topic is ready for merging to the `next` branch (typically phrased
> +"Will merge to 'next'?"). You can help the maintainer and author by responding
> +with a short description of the state of your (and others', if applicable)
> +review.
> +
> +Terminology
> +-----------
> +nit: ::
> +	Denotes a small issue that should be fixed, such as a typographical error
> +	or mis-alignment of conditions in an `if()` statement.
> +
> +aside: ::
> +optional: ::
> +non-blocking: ::
> +	Indicates to the reader that the following comment should not block the
> +	acceptance of the patch or series. These are typically recommendations
> +	related to code organization & style, or musings about topics related to
> +	the patch in question, but beyond its scope.
> +
> +s/<before>/<after>/::
> +	Shorthand for "you wrote <before>, but I think you meant <after>," usually
> +	for misspellings or other typographical errors. The syntax is a reference
> +	to "substitute" command commonly found in Unix tools such as `ed`, `sed`,
> +	`vim`, and `perl`.
> +
> +cover letter::
> +	The "Patch 0" of a multi-patch series. This email describes the
> +	high-level intent and structure of the patch series to readers on the
> +	Git mailing list. It is also where the changelog notes and range-diff of
> +	subsequent versions are provided by the author.
> ++
> +On single-patch submissions, cover letter content is typically not sent as a
> +separate email. Instead, it is inserted between the end of the patch's commit
> +message (after the `---`) and the beginning of the diff.
> +
> +#leftoverbits::
> +  Used by either an author or a reviewer to describe features or suggested
> +  changes that are out-of-scope of a given patch or series, but are relevant
> +  to the topic for the sake of discussion.
> +
> +See Also
> +--------
> +link:MyFirstContribution.html[MyFirstContribution]
> 
> base-commit: 79f2338b3746d23454308648b2491e5beba4beff
> -- 
> gitgitgadget
