Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C23AC433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 14:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiDWO3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 10:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiDWO3S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 10:29:18 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01F1BEB5
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:20 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-deb9295679so11579357fac.6
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3sJGGybT/WW33tUVJcF9Wr30gyDYhd8w6+B5dPyUCc=;
        b=KDUCFNSlrVn/YlEYgswyPeGohkBNfiGE0p4Q96hfxWhbF5hV55NJraR+w6Vgyfj6ZL
         n0y5ZWLkSftPVkm6L4fs2gx4wP0AhWYXpktfbcklKmx/NYjWBSOj7O80PGlOHbmKxiy0
         uwbuHe/HZFRIvGeakslXopAM7JF5r/hBTgx9uJoZzJ8ErjplSGf/lrveZWluI0+0PFY1
         58XXMMp++nsQJQiBGmvnIAeo5c2T2wuk6pBgD6GP6gVhclEFoH5hXYg1MR/DRIdjw2p0
         Gst4M8hw3LEjMZfd03vwhHPD2T9uXOmF98ScbSxypLio4+6uOjniBjV982uw24d6oaNG
         mMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3sJGGybT/WW33tUVJcF9Wr30gyDYhd8w6+B5dPyUCc=;
        b=o7yKcgD7ZHCNG2gNl5Rfb+HDN1RxHYhU7vcTelElC7LQBkPgvDFhso34vtLvvtxP3u
         JUqJadd9yeygoOe6SQEIOn31VpxHYkHnm74TfnwtkxuafaJt1yjb/j0G5coUDXHJ2Bqs
         1BZRFDJxAOjPsZwwr7ExCAN9i8PVwXSphbpF1dZDmIzwTgJTK1I0srraRTE6OLPWaQqz
         +Z1QZw7XvNLRyF5aUS7ZH5yLycyb0MUt9mApq2fbwQdSWaGOtUaNDNjHToWG06E+xrHs
         qKiBvA3nCCHZB8Qussm6CgcWsKeFYfw6xtTTGiYPSV5/u5WmnegZqOTvChxqyoxpNV6/
         EXBQ==
X-Gm-Message-State: AOAM530bQLNTPYFfW6K3HhHuKvgRnhjag0BxX7s+EwvwrjQhxvtKHM7e
        CefRpiT330KP1GfzPX/EQ1zYpTqtdqA=
X-Google-Smtp-Source: ABdhPJye5qbgea4Zpxu7MGmZ9f16AdI+Lvl0hH+hKWAACrz9BP1nivo7r+OieGc8Iq5qaB9tWMUTKw==
X-Received: by 2002:a05:6871:588:b0:e9:4ae:e5e5 with SMTP id u8-20020a056871058800b000e904aee5e5mr2771874oan.225.1650723978303;
        Sat, 23 Apr 2022 07:26:18 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s4-20020a0568301e0400b006015bafee43sm1869993otr.46.2022.04.23.07.26.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Apr 2022 07:26:18 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 0/4] ci: avoid perforce/brew issues affecting macOS
Date:   Sat, 23 Apr 2022 07:25:55 -0700
Message-Id: <20220423142559.32507-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220422013911.7646-1-carenas@gmail.com>
References: <20220422013911.7646-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is an alternative to ab/ci-osx-loosen-package-requirement
and includes the parts proposed on it in v2 that didn't conflict.

The first patch is just a slightly modified version from the one
proposed by Junio and that adds also a message if git-lfs wasn't found
just like we do now for perforce while making those messages go to stderr.

The second patch replaces the original proposal with a more complicated
one that removes the use of brew as suggested by Ævar, it is also a
little bigger than it really needs to be just to make sure it won't
conflict with on the fly changes, and for the same reason uses some
hardcoded values that would be worth fixing after.

The third patch is only needed to avoid regressions with Azure Pipelines
which might be deprecated as proposed in other on the fly changes, so it
might not be needed in seen, but is still needed if this progresses
further first.  It was made independent so it could be easy to revert if
Azure support is going away just like TravisCI did.

The last patch was taken from Ævar's v2 and is the only one that will
require changes in other core on the fly but the conflict resolution is
trivial, and more importantly doesn't conflict when merged to seen in
the current spot this branch uses.

For an example of a "successful" run with it merged on top of seen
(with the previous iteration reverted) see:

  https://github.com/carenas/git/runs/6140236148

Note that perforce no longer fails because someone fixed the issue
with their Cask but still most of the new code is excercised correctly.

This introduces a problem identified by Ævar of making the CI runs less
consistent, as they might be skipping some of the perforce integrations
if installing that fails again, but the likelyhood of that failing has
been reduced by removing the inherent brew flakyness, and so improving
the UI so that it will be more visible when that happens is probably
something that can be addressed later, once all other CI related changes
are settled, or we could reintroduce the hard dependency on installing
perforce for macOS (just like it is done in Linux)

Carlo Marcelo Arenas Belón (3):
  ci: make failure to find perforce more user friendly
  ci: avoid brew for installing perforce
  ci: reintroduce prevention from perforce being quarantined in macOS

Ævar Arnfjörð Bjarmason (1):
  CI: use https, not http to download binaries from perforce.com

 ci/install-dependencies.sh | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
2.36.0.266.g59f845bde02

