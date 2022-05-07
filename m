Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B690CC433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 16:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446652AbiEGQjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiEGQjK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 12:39:10 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068DD18378
        for <git@vger.kernel.org>; Sat,  7 May 2022 09:35:19 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id kl21so7535366qvb.9
        for <git@vger.kernel.org>; Sat, 07 May 2022 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcMbHZLdQFhr2YCk9B9NF6L8elAnXfbtlogku8oMenQ=;
        b=E1CUkUn8GIROAT1rpprQ3JxwBtsROSBp0O4TNpz4x/R8T0U6JOpOto2BPLNntd9b5E
         QmXBbz5qvpsYjPZG32P6nOqBhpN/K884TJbTOVQnOC27+P+U2EbHtRPid77+miqzcZQE
         uhbpjmjvB6iPz6APpt0efHavpyxdODrlgABh+7LiyXHuv6fg9DiWP1bDybNOJR3U6v0+
         B9ztrwryrpIo9VuD1x/0uDc1KMSLAyJcvF9T4pLJ75Z7nQ6oxp+zcMBkjsJKAK0BS27c
         IaZeLhYCJnm+e5Kcd3mqB6lgITMc+R8sYid0T7/IWybcX3Y1jCQlvdkL8I84u/mRcN3u
         bWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcMbHZLdQFhr2YCk9B9NF6L8elAnXfbtlogku8oMenQ=;
        b=h+7DAI9/FYhHt/b12K+IQn+jqJYq8B+RNdIiUnnp23A8gl7xpV2TFSe4U83zV5zHRW
         9sKPGc491dKyn9iZWJswtOV3LSI2sYask/csq+xokw2f3mMc8VR3V26zRCyKjxPijmWr
         GoiBYJyee7aVnk4eBgSMX8XS38Zx/GblwT2vNKAEjoBN/IH4+Mdo1ow4Ql6ToueyJ+1f
         OFf4iFbxPFqvPvey1SEBta2lQa3aDo+QjJMiw8PsKArlxcJbruMFlSY4i6rgHFe7MOCZ
         saT1+IPFiRqbZ4Kct/amKk3vwlm8Ss7SM1PuXcmtZ2iTksC2DoNfmWCuMZYehHqEaBfj
         GDbA==
X-Gm-Message-State: AOAM5338h0JfYoH1nY4DE144ethdWmLZ/YycM4HFTsRI/j+/4Wyf9tb+
        oulMimSjAC9c0DS6t4ON8RkAA+7WNfc=
X-Google-Smtp-Source: ABdhPJy1Ky5TdkXuKfjq15lT7w68fxmrk2kiu9g9NCzn8HWiBiQi/jWuX9GoW3TkLuFeUafxXJH+9A==
X-Received: by 2002:a05:6214:19ec:b0:45b:f0:8d0a with SMTP id q12-20020a05621419ec00b0045b00f08d0amr915629qvc.110.1651941317970;
        Sat, 07 May 2022 09:35:17 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id l15-20020ac848cf000000b002f39b99f6c3sm4244564qtr.93.2022.05.07.09.35.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 May 2022 09:35:17 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v4 0/3] fix `sudo make install` regression in maint
Date:   Sat,  7 May 2022 09:35:05 -0700
Message-Id: <20220507163508.78459-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220503065442.95699-1-carenas@gmail.com>
References: <20220503065442.95699-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A reroll for cb/path-owner-check-with-sudo with most of the suggestions
included but planned originally as an RFC, because I am frankly not sure
that I read and addressed all of it, but also because after seeing how
my only chance to get an official Reviewed-by: Junio vanished I also
realized that I wasn't been clear enough and careful enough from the
beginning to explain the code correctly and therefore had maybe wasted
more of the review quota this change should require.

Important changes (eventhough most are not affecting the logic)
* Document hopefully better which environments are supported and what
  to do if you want to test it in one that is not (thanks to dscho)
* Removed the arguably premature optimization to try to keep the sudo
  cache warm which was actually buggy, as it was also not needed.
  The CI does passwordless sudo unconditionally and even when running
  it locally it will go so fast that is shouldn't be an issue (thanks
  to Philip)
* No longer using the ugly and controversial variable name so now it
  will need GIT_TEST_ENABLE_SUDO to be used to enable it on CI (which
  is not done in this series, but a run with it enabled on top of
  seen is available[1])
* Stop the arguing about what is or not a regression worth fixing and
  instead document it as one through a test, which would be easy to
  fix in a follow up since the code was already provided by Junio

Lastly I am little concerned by the fact this is going to maint but
has a "weather balloon" of sorts, which might not be wise, since it
might prevent people that might be affected from upgrading if they
have a -Werror policy.

The effect is minor though, as worst case, if someone has a system
with a signed uid_t then this "feature" wouldn't work for them and
nothing has changed but I think it is worth to consider the alternatives
which are (in my own order of preference)

* Revert the change to use unsigned long and strtoul()

  This will mean that people running in a 32bit system with an uid bigger
  than INT_MAX wouldn't be able to use the feature

* Move the code out (which is indeed an artificial restriction) so that
  we can use intmax_t and strtoimax() instead and a cast to compare the
  uid_t.

  This avoids all issues and restrictions but means more code changes

* Throw away the custom function and expand the API ones to be used
  instead as dscho suggested.

  Even more code changes, but maybe less risk as we will be building
  on top of battle tested code.

[1] https://github.com/carenas/git/actions/runs/2286452160

Carlo Marcelo Arenas Belón (3):
  t: regression git needs safe.directory when using sudo
  git-compat-util: avoid failing dir ownership checks if running
    privileged
  t0034: add negative tests and allow git init to mostly work under sudo

 Documentation/config/safe.txt  |  10 ++++
 git-compat-util.h              |  49 +++++++++++++++-
 t/lib-sudo.sh                  |  12 ++++
 t/t0034-root-safe-directory.sh | 103 +++++++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-sudo.sh
 create mode 100755 t/t0034-root-safe-directory.sh

-- 
2.36.1.371.g0fb0ef0c8d

