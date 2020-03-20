Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EE4C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD242076E
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNlj1AYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCTMiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:38:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34956 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTMiO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 08:38:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20so6962125edj.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gUzFmiPZQvSc+Pfonjmn7O7YKRYq6jj/7mMDzNSoaks=;
        b=QNlj1AYynjF00e3FcoVJ4q+cBVRtg46ZO8Y8tbND/jvm5Z5Pt84CLmTIo1QZLF+hq0
         OreK4QDABVQkHjmbb0JZ0gTin36Iy/Fhx1l1ZLod4RVZO5mBWhaph7r1RkiODJGuQa2M
         rj4xPT+WQYn5lI/xZVbvhgWxW9DkgHKAcANGK/DYQWuLV/INUwmk1XkbCES8LN+g4zRM
         aZbc2gNL4YnrGpJ2+pR4xhfoo35f4VAqWjDHovFSl1h4uwbBCLA7FmiEFFGfvV+ZzUMv
         c8xn6aMga4hcUI6FuXsDu/Skd2uNfOG6E0ZfhFRhFlEFLNqXnyMPnLuf0AJ11pp39rBr
         ptyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gUzFmiPZQvSc+Pfonjmn7O7YKRYq6jj/7mMDzNSoaks=;
        b=ujfPq5Mp88MFKP6JY1Mq/vSUNeffCvTMXU7+OvXJCUtLtuKa225Wb7+wOw79uvZUSR
         6UAC87XUacQY0CQK80ltq6EHkZNTXYxUrgIpbDPlx/udPagVH1G+ky8IlvxjB+RzP2kJ
         lBsQ7JcKvKpSxzPp2a0l0h9HgZ6oVuOIEXWweQmN7PWiaTBWburUf5vrHsUvGvvDSmx7
         Z6r7DTQmtaR/LHaC4I3CJ3qnLO5zDdTXYTiRHEnIkyt8hN1qpYkgSxR0l6SeifALxLn3
         OhDZ7AwWfq3rSmDzDekD1psgB5L8KPIgz2j/WuAb+N/st/kmF4yYrnvLsrQrXYgCN1/G
         L9CA==
X-Gm-Message-State: ANhLgQ2H6tpCmfbQ7R8HYNXNlcidDWx9getT+h0z6rnu+lB6aoY5cjGm
        AWccQOLhodwSiGn8RiQnKjObWTHA
X-Google-Smtp-Source: ADFU+vtEOl/2YbspL8evPXzbB4QYzPhdOwXdq+tWr//xH397ASYXSlZy32ntcFgT3M3CqRZwy5JKUg==
X-Received: by 2002:aa7:d797:: with SMTP id s23mr7334334edq.67.1584707891985;
        Fri, 20 Mar 2020 05:38:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c64sm345421edd.66.2020.03.20.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:38:11 -0700 (PDT)
Message-Id: <pull.585.v3.git.1584707890.gitgitgadget@gmail.com>
In-Reply-To: <pull.585.v2.git.1584707247753.gitgitgadget@gmail.com>
References: <pull.585.v2.git.1584707247753.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Mar 2020 12:38:08 +0000
Subject: [PATCH v3 0/2] config: set pack.useSparse=true by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small patch to convert pack.useSparse to true by default. It's
been released for over a year, so the feature is quite stable. I'm
submitting this now to allow it to cook for a while during the next release
cycle.

UPDATE IN V3: (I'm sorry for the rapid v3, I forgot to push the commit that
included this bit about GIT_TEST_PACK_SPARSE.)

Thanks to Jonathan Nieder pointing out the test implications, I've added a
patch to swap the role of GIT_TEST_PACK_SPARSE to test the other mode.

Thanks, -Stolee

Derrick Stolee (2):
  config: set pack.useSparse=true by default
  pack-objects: flip the use of GIT_TEST_PACK_SPARSE

 Documentation/config/feature.txt   |  3 ---
 Documentation/config/pack.txt      |  4 ++--
 Documentation/git-pack-objects.txt | 10 ++++++----
 builtin/pack-objects.c             |  4 ++--
 repo-settings.c                    |  3 ++-
 t/README                           |  6 +++---
 t/t5322-pack-objects-sparse.sh     |  4 +++-
 7 files changed, 18 insertions(+), 16 deletions(-)


base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-585%2Fderrickstolee%2Fpack-use-sparse-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-585/derrickstolee/pack-use-sparse-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/585

Range-diff vs v2:

 1:  60b5cc6f337 = 1:  60b5cc6f337 config: set pack.useSparse=true by default
 -:  ----------- > 2:  908d5c77c96 pack-objects: flip the use of GIT_TEST_PACK_SPARSE

-- 
gitgitgadget
