Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA2FC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C8B60FDA
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFGLGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:06:53 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:40788 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhFGLGw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:06:52 -0400
Received: by mail-wm1-f41.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so12373035wmd.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfWxBylq2fbm6VOTTIrrq2jUl1nn4Xq7MGaRrtqKcF0=;
        b=EIlbbXuZ3+dr7Isj8z8c8YQ1PWOWmHxronhHqYcwXgiSturYJnjTZYwoO9LPd4zsLy
         szLutD1W2ehTmDasbnmhmzrMIR12PxrJF8mrR8/4MqGizD1gkjQGvLdRl/PdQhbrVurW
         GKL9WAPkh+zc2M2krkAhrCBkoQLu5nqmRlgKt4T3mxC81TSS3awVqyUXjy/0Wo8fJqZr
         CmhkNqzKAKpRE9C9FftQ2umorzx1uqM2EyMkN1wu2lACTVayzziRe0nzIUkHXUw6uChV
         SFD1RNTYvm1ShLg2W0YROjHdSg32XR9Db1xj9TKXXtY4VVih/JvZCjNS+DPtEng9TJ7K
         Jv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfWxBylq2fbm6VOTTIrrq2jUl1nn4Xq7MGaRrtqKcF0=;
        b=h3/ejHivHLpSEUluhnOQAoyZhbBrmNnW0bW8CEnvXkCGFAqJ5/7RBK3Mhc/mmXawE1
         WUTkWi52bQwhaQTpGGo8dWjbdd+IvDNAb0VvfdePnIGCV1WpTeOLDCMkWvgCfsCvS2N4
         SN+aa1IjlbZPm/hqe4Rq7RbEBqClJwHROr0fG7wv9RRtylC5lueyDy2wOu/1bhAncXzu
         kTvZ+90BXpj8E5K0iwp2EjdeWlpB3Og+6UvkUcqV9y9NvAN8umGlCzcxiCpCIU+jRnZb
         lHF7ghdwHWuMKPUILkN0oGXkUoHgDf0R6tMxk7r6p3xPkaO2YRgDMUhhGRirzvyMQPuf
         l/vg==
X-Gm-Message-State: AOAM530eGbCZXQZtXEAf1YEoazwKqmG/GtCebmYKDcykUC3Usy/0vG1W
        DDI3TQPDWLO0lf91MYVDd2tdRARTDvg=
X-Google-Smtp-Source: ABdhPJyH/qFO7m0xiUEmPXNd+3thY0ZI8KxFxIh3pu5PEneaLKuAzNZXYd/QR/K+ApULd+nTHGOVGQ==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr16680700wmq.42.1623063826306;
        Mon, 07 Jun 2021 04:03:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c64sm17230575wma.15.2021.06.07.04.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:03:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] SubmittingPatches: a few unrelated minor fixes
Date:   Mon,  7 Jun 2021 13:03:40 +0200
Message-Id: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few minor updates to SubmittingPatches spotted while paging through
it the other day (or other month, given the delay until v2).

See
https://lore.kernel.org/git/cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com/
for the v1 discussion. This hopefully addresses all the outstanding
comments with it.

Ævar Arnfjörð Bjarmason (3):
  SubmittingPatches: move discussion of Signed-off-by above "send"
  SubmittingPatches: replace discussion of Travis with GitHub Actions
  SubmittingPatches: remove pine-specific hints from MUA hints

 Documentation/SubmittingPatches | 256 ++++++++++++--------------------
 1 file changed, 97 insertions(+), 159 deletions(-)

Range-diff against v1:
1:  d18a3caa07 = 1:  9fa5437bb5 SubmittingPatches: move discussion of Signed-off-by above "send"
2:  7add00cc87 ! 2:  7d5d2854e3 SubmittingPatches: replace discussion of Travis with GitHub Actions
    @@ Documentation/SubmittingPatches: the feature triggers the new behavior when it s
     -on open source projects), you can use their Travis CI integration to
     -test your changes on Linux, Mac (and hopefully soon Windows).  See
     -GitHub-Travis CI hints section for details.
    -+If you have an account at GitHub pushing to a fork of
    -+https://github.com/git/git will use their CI integration to test your
    -+changes on Linux, Mac and Windows. See the GitHub CI section for details.
    ++Pushing to a fork of https://github.com/git/git will use their CI
    ++integration to test your changes on Linux, Mac and Windows. See the
    ++GitHub CI section for details.
      
      Do not forget to update the documentation to describe the updated
      behavior and make sure that the resulting documentation set formats
    @@ Documentation/SubmittingPatches: their trees themselves.
     -source projects), you can use Travis CI to test your changes on Linux,
     -Mac (and hopefully soon Windows).  You can find a successful example
     -test build here: https://travis-ci.org/git/git/builds/120473209
    -+With an account at GitHub you can use GitHub CI to test your changes
    ++With an account at GitHub, you can use GitHub CI to test your changes
     +on Linux, Mac and Windows. See
     +https://github.com/git/git/actions/workflows/main.yml for examples of
     +recent CI runs.
    @@ Documentation/SubmittingPatches: Follow these steps for the initial setup:
     +can also download "Artifacts" which are tarred (or zipped) archives
     +with test data relevant for debugging.
     +
    -+Then fix the problem and push your fix to your Github fork. This will
    ++Then fix the problem and push your fix to your GitHub fork. This will
     +trigger a new CI build to ensure all tests pass.
      
      [[mua]]
3:  9da5bc4a0c ! 3:  a61885a198 SubmittingPatches: remove pine-specific hints from MUA hints
    @@ Metadata
      ## Commit message ##
         SubmittingPatches: remove pine-specific hints from MUA hints
     
    -    Remove the whole section about configuring pine with
    -    no-strip-whitespace-before-send.
    +    Replace the whole section about configuring pine with
    +    no-strip-whitespace-before-send with a note that users should use
    +    another MUA instead.
     
         There hasn't been a release of Pine since late 2005, in Alpine the
         no-strip-whitespace-before-send switch is already the default.
     
         This documentation was initially added in 9740d289ee7 (Update
    -    SubmittingPatches to add MUA specific notes., 2005-08-26), at this
    +    SubmittingPatches to add MUA specific notes., 2005-08-26). At this
         point it's safe to say that it's not useful to anyone anymore, let's
         remove it.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/SubmittingPatches ##
    -@@ Documentation/SubmittingPatches: first patch.\n", if you really want to put in the patch e-mail,
    - should come after the three-dash line that signals the end of the
    - commit message.
    +@@ Documentation/SubmittingPatches: commit message.
    + 
    + === Pine
      
    --
    --=== Pine
    --
     -(Johannes Schindelin)
     -
     -....
    @@ -219,7 +219,9 @@ PICO *pm;
     -"strip-whitespace-before-send", in which case you should avoid checking
     -it.
     -....
    --
    ++Abandoned by its uptsream and has known flowed text bugs, use its
    ++successor alpine or another MUA instead.
    + 
      === Thunderbird, KMail, GMail
      
    - See the MUA-SPECIFIC HINTS section of linkgit:git-format-patch[1].
-- 
2.32.0.rc3.434.gd8aed1f08a7

