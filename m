Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE927C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 13:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIVN3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiIVN31 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 09:29:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A55FD4DD9
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 06:29:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t14so15532802wrx.8
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=EK8uPVUunIw2qG7QDBYEDlY6YUujjSpF1J9NMeO9r1U=;
        b=jpASJRQmTrYVPtpYrl4eFNef+iFaqrz6AagIxBaYGuyfTolgH3z65epdIG7BHMyvgt
         MuKOuSkxOu92VgtEVI4LU90uoyWQQORKvNgYpSWPyM70kRzWvxrNt6sa6usos0BG+UUM
         ysxWYY5IxUvWzmt17vWwmKtDOfHYA5oz7kinYHEfcxQytAZ0leU/KZ/cPLLsXRuQlJfS
         bcMGVWzHritst1Xsf11KuR5cQrx5ubgSvp+TcGsAUSm2L7C/pTAdpfbWDC9u1mQVMNwP
         tuE6+/RpZ2GmJJ7trj7hgN7hX/N2PRQ5vrMLfC2iMMt1d4b77o5YguCWajB5FEaCIOR/
         iyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=EK8uPVUunIw2qG7QDBYEDlY6YUujjSpF1J9NMeO9r1U=;
        b=nO21eYGv+GalSizADyO8kAlg3LZDXCraEfAiz0QkPq55kSk5Z1WaP13KK7+JI4JcEb
         gvbdGmnGGFlHVA6Alq+4BZmFbsNexql0ddG9pgkDd+J2QA5IflnwjbmCj7HqPAXx27pL
         hns3w1pOkA0P+8k+jRqk6xkUsu6lPxH2xPK/pr8tQxi1y5k2XcBgBaYytD9D8Y1Du1Bz
         GJT5CWNa4Ad5KFalVncquvnr3MYpLTdWnkq4L9IUz2FzIq5ZULSzzMwmpVRNOgf2tl19
         AvzEeP5Hbid57fZvqrM+dFp/O24q0bXQAuT3HgBDBk7x6OnitdxzXOfIcAB79IUqYCRS
         PtWw==
X-Gm-Message-State: ACrzQf1MWAqFdKDioc6ty7GsZc/wgwKa9vHaKVqT9HzjCZ7+mTV05joi
        gIKG0GpuaJP+u0/S7FJqyeI=
X-Google-Smtp-Source: AMsMyM5C4Z7lL2tGZfrcFg5ELSDaD5sJijQ9yRdDXA1aB74S3AAXdb3cVUw6BOJtRgTPXzilhHcxhQ==
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id i15-20020a5d522f000000b00228dc7fb9a8mr2167608wra.617.1663853364506;
        Thu, 22 Sep 2022 06:29:24 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id v2-20020a5d6b02000000b00229e0def760sm5102480wrw.88.2022.09.22.06.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 06:29:23 -0700 (PDT)
Message-ID: <93d4683a-81db-2d9a-edd9-a3790c16a5db@gmail.com>
Date:   Thu, 22 Sep 2022 14:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] Documentation: add ReviewingGuidelines
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com, Johannes.Schindelin@gmx.de,
        steadmon@google.com, chooglen@google.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
 <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

Thanks for working on this, sorry it has taken me a while to get round 
to looking at it. I think it makes a really useful addition to our 
documentation. I've left a few comments below, the only one I feel 
strongly about is adding something to say what the purpose of the review 
should be and emphasizing positive comments earlier in the document.

On 19/09/2022 20:12, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>

> diff --git a/Documentation/ReviewingGuidelines.txt b/Documentation/ReviewingGuidelines.txt
> new file mode 100644
> index 00000000000..0e323d54779
> --- /dev/null
> +++ b/Documentation/ReviewingGuidelines.txt
> @@ -0,0 +1,162 @@
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
> +the https://lore.kernel.org/git/[`lore.kernel.org` mailing list archive];
> +alternatively, you can find the contents of the "What's cooking" email tracked
> +in `whats-cooking.txt` on the `todo` branch of Git. Topics tagged with "Needs
> +review" and those in the "[New Topics]" section are typically those that would
> +benefit the most from additional review.
> +
> +Patches can also be searched manually in the mailing list archive using a query
> +like `s:"PATCH" -s:"Re:"`. You can browse these results for topics relevant to
> +your expertise or interest.
> +
> +If you've already contributed to Git, you may also be CC'd in another
> +contributor's patch series. These are topics where the author feels that your
> +attention is warranted. This may be because their patch changes something you
> +wrote previously (making you a good judge of whether the new approach does or
> +doesn't work), or because you have the expertise to provide an exceptionally

[optional] Maybe this says something about me, but the use of 
"exceptionally" here feels like it is setting quite high expectations 
for the review. Perhaps we could say "particularly" instead

> +helpful review. There is no requirement to review these patches but, in the
> +spirit of open source collaboration, you should strongly consider doing so.
> +
> +Reviewing patches
> +~~~~~~~~~~~~~~~~~
> +While every contributor takes their own approach to reviewing patches, here are
> +some general pieces of advice to make your reviews as clear and helpful as
> +possible. The advice is broken into two rough categories: high-level reviewing
> +guidance, and concrete tips for interacting with patches on the mailing list.
> +
> +==== High-level guidance

I think it would be worth adding something here (or maybe extending the 
previous paragraph) to state the purpose of the review and emphasize the 
importance of positive comments. Maybe something like this (which is a 
reworked version of your final list item)

The purpose of the review is to provide constructive feedback explaining 
how you think the patch could be improved or in some cases why the patch 
is not suitable for inclusion. As well as pointing out any problems it 
is helpful to provide positive feedback on aspects that you particularly 
liked. You should also feel free to "think outloud" in your review 
describing how you read & understood a complex section of a patch. It is 
also useful to ask questions about anything that confused you

> +- Remember to review the content of commit messages for correctness and clarity,
> +  in addition to the code change in the patch's diff. The commit message of a
> +  patch should accurately and fully explain the code change being made in the
> +  diff.
> +
> +- Reviewing test coverage is an important - but easy to overlook - component of
> +  reviews. A patch's changes may be covered by existing tests, or new tests may
> +  be introduced to exercise new behavior. Checking out a patch or series locally
> +  allows you to manually mutate lines of new & existing tests to verify expected
> +  pass/fail behavior. You can use this information to verify proper coverage or
> +  to suggest additional tests the author could add.
> +
> +- When providing a recommendation, be as clear as possible about whether you
> +  consider it "blocking" (the code would be broken or otherwise made worse if an
> +  issue isn't fixed) or "non-blocking" (the patch could be made better by taking
> +  the recommendation, but acceptance of the series does not require it).
> +  Non-blocking recommendations can be particularly ambiguous when they are
> +  related to - but outside the scope of - a series ("nice-to-have"s), or when
> +  they represent only stylistic differences between the author and reviewer.
> +
> +- When commenting on an issue, try to include suggestions for how the author
> +  could fix it. This not only helps the author to understand and fix the issue,
> +  it also deepens and improves your understanding of the topic.
> +
> +- Reviews do not need to exclusively point out problems. Feel free to "think out
> +  loud" in your review: describe how you read & understood a complex section of
> +  a patch, ask a question about something that confused you, point out something
> +  you found exceptionally well-written, etc. In particular, uplifting feedback
> +  goes a long way towards encouraging contributors to participate more actively
> +  in the Git community.

As I said above I'd like to see this come higher up the list

> +==== Performing your review
> +- Provide your review comments per-patch in a plaintext "Reply-All" email to the
> +  relevant patch. Comments should be made inline, immediately below the relevant
> +  section(s).
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

[optional] --ignore-space-change is quite a blunt instrument, perhaps we 
could suggest using --color-moved-ws=allow-indentation-change which I 
find particularly useful for refactorings. I'd also second Elijah's 
suggestion to mention --color-words for documentation changes.

> +- If a patch is long, you are encouraged to delete parts of it that are
> +  unrelated to your review from the email reply. Make sure to leave enough
> +  context for readers to understand your comments!
> +
> +- If you cannot complete a full review of a series all at once, consider letting
> +  the author know (on- or off-list) if/when you plan to review the rest of the
> +  series.
> +
> +Completing a review
> +~~~~~~~~~~~~~~~~~~~
> +Once each patch of a series is reviewed, the author (and/or other contributors)
> +may discuss the review(s). This may result in no changes being applied, or the
> +author will send a new version of their patch(es).
> +
> +After a series is rerolled in response to your or others' review, make sure to
> +re-review the updates. 

[optional] Maybe add

When re-reviewing the series it is helpful to inspect the range diff to 
see what the author has changed since your last review.

> If you are happy with the state of the patch series,
> +explicitly indicate your approval (typically with a reply to the latest
> +version's cover letter). Optionally, you can let the author know that they can
> +add a "Reviewed-by: <you>" trailer if they resubmit the reviewed patch verbatim
> +in a later iteration of the series.
> +
> +Finally, subsequent "What's cooking" emails may explicitly ask whether a
> +reviewed topic is ready for merging to the `next` branch (typically phrased
> +"Will merge to \'next\'?"). You can help the maintainer and author by responding
> +with a short description of the state of your (and others', if applicable)
> +review, including the links to the relevant thread(s).
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

[optional] The reference to code style made me wonder if we should add 
something recommending that reviewers refer patch authors to our coding 
guidelines where appropriate.

Thanks again for working on this

Phillip

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

