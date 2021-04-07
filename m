Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A98C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28ED613A9
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbhDGNrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDGNq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 09:46:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD353C06175F
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 06:46:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n67so8783684ybf.11
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=cDQpm/ZlUsKMntHRT9YPZFpJT1poey/ijrEM16mSFJg=;
        b=fwhOtZdDTnmyvMyr2G6/1NzoCqHUqaiRYI/WH1Cuv/tCr2Vl2hwnz3MOh79uP//fj3
         nIC3DSljrORG6Go88vQgJWrhsQLvrhQtXcBnmolrU8rwXQi1SFgD21cKsxlr5PeTQ+z3
         ymAlJ8ixz/QrkWzdRkG1tAjv/cetyWHdMO+LKel4LS4+eB35MBaamN7IOsQvXMvT/75n
         8nmEh+Sm6eXaS93rlSsqxTgYXMyNGnkH/lR9+kZxN6u76zCsDD71onx2ECs3HzT/epGe
         RPJBEM2rjQjU9As9Jka2tY8k5Nvqvo3mCJZ/7mEtSuVDfQtEbW12PwBfELz9D5CWy8Zq
         bZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=cDQpm/ZlUsKMntHRT9YPZFpJT1poey/ijrEM16mSFJg=;
        b=m+FRIMppbdePnuPUvdr26s/4HLdFCE+cyzz4N7YQ0T5nJN8As7wLvyKADPSwMvpwjY
         1OLCF3nEDQfD6WfcRya7fqcY6TQtvhYGhsYebPgtV6Gfxui7R2ldlGzEZwktBlArFzik
         4oysHiJ2fp5UltqGYRL7C9r504nGbGJAe+uOhOUFgG5yjKwfo08WAbRWJjwQrBMu9oaN
         Y7m4nJl7NE9kDNs9rUl/I1GPJd1Ii0sRu0DniU9oqWLzD8Hq4zkKPZ83mw3aFiWhAHdG
         R/V5V+zhPRfR/kfNgCHm2Zq33hTSRq11OwhzMr8zkQ2beNODZBZHvl8LdmLZtUpxfMsc
         SF2w==
X-Gm-Message-State: AOAM530RUDOx+R3iVFDZtXF08gMzwYEGNMF3m3wGTN6HNphRh1vdmeDv
        MCnqB3jDSMsDTupZXUjhbHdWSIp8sT0=
X-Google-Smtp-Source: ABdhPJx1WplJ/xdZjSqtd2/GQaz9jDcxVZiLUKA40iSO7Dk/eDZQFCgNTfWKu5IK5nPoRL3DL3WpDxqnXRU=
X-Received: from lodato1.nyc.corp.google.com ([2620:0:1003:321:bcb2:6e4f:3c68:6618])
 (user=lodato job=sendgmr) by 2002:a25:5d0b:: with SMTP id r11mr4615835ybb.380.1617803208125;
 Wed, 07 Apr 2021 06:46:48 -0700 (PDT)
Date:   Wed,  7 Apr 2021 09:46:46 -0400
In-Reply-To: <YFJ/g2N+s1V3/qMo@google.com>
Message-Id: <20210407134646.2866522-1-lodato@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
From:   Mark Lodato <lodato@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Eli Schwartz <eschwartz@archlinux.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> This is useful context.  What URL forms does this package manager
> support (e.g., do you have a link to its documentation)?  What would
> the effect be for the package manager and its users if Git started
> supporting a git+https:// synonym for https://?

Here are two more examples:

- pip: https://pip.pypa.io/en/latest/cli/pip_install/#git
- SPDX: https://spdx.github.io/spdx-spec/3-package-information/#37-package-download-location

The common thread is that systems need a way to uniquely identify a git
repository or some object therein. I believe this means some combination
of:

- VCS type (git)
- Transport location (e.g. https://github.com/git/git)
- Ref (e.g. master)
- Resolved commit ID (e.g. 48bf2fa8bad054d66bd79c6ba903c89c704201f7)
- Path (e.g. contrib/diff-highlight)
- (possibly) Clone depth

As Drew has said, the current state of affairs is that, lacking a
standard, multiple systems are all inventing incompatible schemes using
the `git+https` name. This is not a good situation because the "URI" is
no longer "unique". Given such a URI in isolation, one cannot know how
to parse it.

It's not clear to me that git itself needs to support this scheme. It
would go a long way for git to simply recommend a particular scheme so
that all these systems can use a common format. (We could register that
with IANA.) The pip format seems to be the closest, but it doesn't
support both ref AND resolved commit ID, and it is currently specific to
pip (`egg=` could be replaced with `path=`).

Best,
Mark
