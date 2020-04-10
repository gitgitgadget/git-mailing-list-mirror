Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B57BC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D2A20753
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay1hERec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJL1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:27:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37049 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDJL1y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 07:27:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id de14so2102065edb.4
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lzH68EtxRs2IVGS4zNMQ53URBlC0f6SOeyc44Mx2Y9s=;
        b=Ay1hERecWuzc8VZKf+MnXyZVwaFZPH2HvbO60TQoAAq8D72yHn7bciiXEze/vZmu4z
         IF6kNe5RJPJpoD7XLklQ8feEufCQNX5AbkCBsEMZUS62xUZ1OeCjdmJkCP5qev3x9Nh8
         4IY1sg1i0MIH0W7A93x9LFirGIwd0WATQrw81BJ4D5wjs3iwfj2++cNuD9zvvWfkanb/
         ADNXpKEu3uQAkL+K4U8LCr0JTmPVs2rT7uu3SWiiyx71wAkRMA5+ElL1GxUPS4WxxFLc
         EOxPX+adeAqk7ZxlaXAUXlKbfSojoPFu4Cg/jnnn5nC83/q0HbJGq97rxSR2wVNCnmWL
         bNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lzH68EtxRs2IVGS4zNMQ53URBlC0f6SOeyc44Mx2Y9s=;
        b=NFN2WUJY/sGZ8Z7/vWpky/3h3j6XQnaAIHK7IPYQ4qZ/UF0Icr1beq1+JACzBXpP2r
         g+cRljfTZuV1+GfSs5wM4tgtKtWG903zBRjHcPPIqOE8GpbraVthS44aGTnka/1yx5cr
         LJcXAHtSB5yLxQszns65v8ywoq7gTFk+kV3hbDNQ2NGEOB/x0CxWD+91T1XSofDHYK6K
         9l76UzsyHfVl/0VTuKJC6121lbSHPlLzbsI/3go2c0xSHnS038PuzlnpQe7B0E9AK5JV
         JpcwZ/I4OEC9CNu3cjI4qfHFCTcfB3U3QKg6WY0npWPZTaZx2J35/AQ6EfpxsPI5LXC4
         G/Ig==
X-Gm-Message-State: AGi0PuaYVbSN55jaWs98xK7SJQHGdfKS1uFVbH7C3n1I6zkypKV8GH4P
        rSQa71V40sZ5+dpfnp1yK7CtuaMW
X-Google-Smtp-Source: APiQypJ3+fowKhm4Y05Rb/Yp3rchjYwEDxkXB5quwdYGC0Z8iGF3GfvGJWKD2CLd8EFEq41vDus4Iw==
X-Received: by 2002:a17:906:cd18:: with SMTP id oz24mr3442360ejb.195.1586518072858;
        Fri, 10 Apr 2020 04:27:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm103378eja.33.2020.04.10.04.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 04:27:52 -0700 (PDT)
Message-Id: <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
In-Reply-To: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 11:27:49 +0000
Subject: [PATCH v2 0/2] Explicitly fflush stdout in git clean
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch that was funneled through a Git for Windows PR,
read: it has been battle-tested.

Of course, the current iteration of this patch series has not been
battle-tested, so please do review carefully, so that we can prevent bugs
from slipping in during the review process.

Changes since v1:

 * Added a preparatory patch that refactors all interactive input reading
   via strbuf_getline(..., stdin).
 * Adjusted the patch and its commit message accordingly.

Johannes Schindelin (1):
  Refactor code asking the user for input interactively

마누엘 (1):
  Explicitly `fflush` stdout before expecting interactive input

 add-interactive.c |  4 ++--
 add-patch.c       |  4 ++--
 builtin/clean.c   | 14 ++++----------
 prompt.c          | 12 ++++++++++++
 prompt.h          |  2 ++
 shell.c           |  4 ++--
 6 files changed, 24 insertions(+), 16 deletions(-)


base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-755%2Fdscho%2Ffflush-in-git-clean-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-755/dscho/fflush-in-git-clean-v2
Pull-Request: https://github.com/git/git/pull/755

Range-diff vs v1:

 1:  21acd883b94 < -:  ----------- clean: explicitly `fflush` stdout
 -:  ----------- > 1:  9d2ee78a9e4 Refactor code asking the user for input interactively
 -:  ----------- > 2:  d3949e42004 Explicitly `fflush` stdout before expecting interactive input

-- 
gitgitgadget
