Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C8EB64DD
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 03:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGZDFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 23:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGZDFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 23:05:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0323A1BCD
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso53865105e9.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690340703; x=1690945503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcHQQjAEG5QLBvuo48twEkY0C4wPxWQoXJtsfEP3Xl8=;
        b=WAVr/8J5HVlod3mzvLMI54k+o3vxlWYRoOG/QMwpK5zlb+yorUPTttSk5mHJfRXzha
         Sa/Cvq61G07gYTlpN88/8IlJUhoAaGfjpx6TpI+/1BJCXt21AnHqY4Y3akBdzSx0kQQ/
         IfdOLsH2jUEKTX0UMA1NiMd1zVTVMMSgkPUpPI47/B05+0t528Y7AMP/6pBHRV1TWhWY
         /7iWhohSut9IatQdkWCeJieopGxjP0BPIehvqN/OTZooJm4CWGBNTCM2U9DeFzfRIPUu
         GegcCazE8GbFFtdJabjtqhJRYc+ADnSaJym2/bGUYQLv+ZrZCF6whvHVB0ewf0c7CElZ
         zHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340703; x=1690945503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcHQQjAEG5QLBvuo48twEkY0C4wPxWQoXJtsfEP3Xl8=;
        b=QAXIG6Q+sLtFAS97NK+eZpx2s2HQ3w+/v6mcofG6wnLRKee2BYsiv469wI5w76rnIF
         gYdLtdmMdY6JdGZ6XNFx5j7vdIHMUSV4rDdJ6rK5kXfdHXnm65eVP6K4yS9sTj7iZtiU
         aT09DiXZAA9kpt0J87/99cjcuPBB7bQ55yTAzHJ3ZIgft2MMloAyescNnGfZX2v6acLe
         70q6FoVfcd2/DGwsBxPkdzx/QI6GZ2xnWmhnH6JLEoFdiTACYshgYPkn99UomE0HeG/c
         sbC/nfhavfqgET5dRRRSU3bmqL4f5YD/xwZt5kCVrqfojBJ7M3EBeSZDckiv/u33DYGM
         j2pA==
X-Gm-Message-State: ABy/qLabXwYTLuz7qDoGVNaSq3UFHBizB2X54gqeGGdc9tY8MfRL/wLn
        UYJNCLBYSM35EM0DnGG8KCrnnn23NgQ=
X-Google-Smtp-Source: APBJJlF2igCi+ApC5uMdnSE8xiK3tf1opasLlVO6h4QdPGQSzwOHSllEl/irJFVj5sQ/53lUqglfaw==
X-Received: by 2002:a05:600c:c8:b0:3fc:5a3:367c with SMTP id u8-20020a05600c00c800b003fc05a3367cmr385966wmm.32.1690340702999;
        Tue, 25 Jul 2023 20:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c211100b003f90b9b2c31sm641363wml.28.2023.07.25.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:05:02 -0700 (PDT)
Message-ID: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 03:04:56 +0000
Subject: [PATCH v3 0/5] SubmittingPatches: clarify which branch to use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series rewords the "base-branch" section (now renamed to
"choose-starting-point") to be more informative in general to new
contributors, who may not be as familiar with the various integration
branches. Other smaller cleanups and improvements were made along the way.


Updates in v3
=============

 * We add a little more detail about when you'd want to use the tip of a
   maintenance track (e.g., maint-2.30) instead of maint.
 * The language about the instability of "next" and "seen" has been
   de-emphasized, in favor of saying that these branches just have lots of
   other topics (some not ready) in it.


Updates in v2
=============

 * The language about choosing the "oldest" branch was retained, and
   expanded. It turns out that this language is also present in
   gitworkflows, however the meaning of the word "oldest" was not explained
   properly in the "base-branch" section. This has been addressed.
 * Rename "base-branch" to "choose-starting-point"
 * Patch 04 (emphasize need to communicate non-default starting points) is
   new.

Linus Arver (5):
  SubmittingPatches: reword awkward phrasing
  SubmittingPatches: discuss subsystems separately from git.git
  SubmittingPatches: de-emphasize branches as starting points
  SubmittingPatches: emphasize need to communicate non-default starting
    points
  SubmittingPatches: simplify guidance for choosing a starting point

 Documentation/SubmittingPatches | 134 ++++++++++++++++++++++----------
 1 file changed, 93 insertions(+), 41 deletions(-)


base-commit: aa9166bcc0ba654fc21f198a30647ec087f733ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1556%2Flistx%2Fdoc-submitting-patches-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1556/listx/doc-submitting-patches-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1556

Range-diff vs v2:

 1:  08deed14d96 = 1:  08deed14d96 SubmittingPatches: reword awkward phrasing
 2:  8d4b57a8704 = 2:  8d4b57a8704 SubmittingPatches: discuss subsystems separately from git.git
 3:  69fef8afe64 = 3:  69fef8afe64 SubmittingPatches: de-emphasize branches as starting points
 4:  f8f96a79b92 = 4:  f8f96a79b92 SubmittingPatches: emphasize need to communicate non-default starting points
 5:  5ec91d02b7a ! 5:  1273f50c8a8 SubmittingPatches: simplify guidance for choosing a starting point
     @@ Commit message
          workflows, 2008-10-19).
      
          Summary: This change simplifies the guidance by pointing users to just
     -    "maint" or "master". But it also gives an explanation of why that is
     -    preferred and what is meant by preferring "older" branches (which might
     -    be confusing to some because "old" here is meant in relative terms
     -    between these named branches, not in terms of the age of the branches
     -    themselves). We also add an example to illustrate why it would be a bad
     -    idea to use "next" as a starting point, which may not be so obvious to
     -    new contributors.
     +    "maint" or "master" for most cases. But it also gives an explanation of
     +    why that is preferred and what is meant by preferring "older"
     +    branches (which might be confusing to some because "old" here is meant
     +    in relative terms between these named branches, not in terms of the age
     +    of the branches themselves). We also explain in detail why it would be a
     +    bad idea to use "next" or "seen" as starting points, which may not be so
     +    obvious to new contributors.
      
          Helped-by: Jonathan Nieder <jrnieder@gmail.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     @@ Documentation/SubmittingPatches: available which covers many of these same guide
      +* If you are fixing bugs in the released version, use `maint` as the
      +  starting point (which may mean you have to fix things without using
      +  new API features on the cutting edge that recently appeared in
     -+  `master` but were not available in the released version).
     ++  `master` but were not available in the released version). If the bug
     ++  exists in an older version (e.g., commit `X` introduced the bug, and
     ++  `git describe --containx X` says `v2.30.0-rc2-gXXXXXX` has it), then
     ++  use the tip of the maintenance branch for the 2.30.x versions in the
     ++  `maint-2.30` branch in https://github.com/gitster/git[the maintainer's
     ++  repo].
      +
      +* Otherwise (such as if you are adding new features) use `master`.
      +
      +This also means that `next` or `seen` are inappropriate starting points
      +for your work, if you want your work to have a realistic chance of
     -+graduating to `master`.  They are simply not designed to provide a
     -+stable base for new work, because they are (by design) frequently
     -+re-integrated with incoming patches on the mailing list and force-pushed
     -+to replace previous versions of these branches.
     ++graduating to `master`.  They are simply not designed to be used as a
     ++base for new work; they are only there to make sure that topics in
     ++flight work well together. This is why both `next` and `seen` are
     ++frequently re-integrated with incoming patches on the mailing list and
     ++force-pushed to replace previous versions of themselves. A topic that is
     ++literally built on top of `next` cannot be merged to 'master' without
     ++dragging in all the other topics in `next`, some of which may not be
     ++ready.
      +
      +For example, if you are making tree-wide changes, while somebody else is
      +also making their own tree-wide changes, your work may have severe

-- 
gitgitgadget
