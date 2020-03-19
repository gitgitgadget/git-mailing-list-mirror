Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF52BC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9397B2080C
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gni8NaEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgCSR2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:28:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44224 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCSR2K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:28:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id z3so3690825edq.11
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=H8WQBglm68tPdKpwUDE/SYrqSIHbk1tUT9QUquqz9DY=;
        b=Gni8NaEFjPDiUNypWRYdc92VFzLL/ebg6GelJMYlLhPxsB9nAMtgUHrgCj4uo2lNYb
         KVQqkgSw7IacksxAnYiNKSmk3AUFV5pGa0D0vuSIsnqhSiHTKw0m0FWCQxM0C3HArzFx
         4ZBFPTknIC6FVLnDt31/A1Svst7s/Zadi88AkELow1KecKU/CRfohUHYqdD97IgDOxuY
         aLb6Z56InpuaNEvCD+vxT4CQhKIJ5JMWW7pl1uIoA0kEFga6wAytpcx+EHFmzdppZFuT
         uOBOD1PcUTGyUU9OKAc0l2NggtYuyMPWfV0h4q97Dt0xszYtu9kdArQtTIriKuvdHAMp
         Yjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H8WQBglm68tPdKpwUDE/SYrqSIHbk1tUT9QUquqz9DY=;
        b=CTQD3YZv7WPFjFVgREnDiRiC7G9y3mkJ6cKOa3+cBeSJBJtBhL5iqxWTRpn7mtpSMO
         GjtIL/F8+37Fj2IIOkMP6osHqq7MAjj5AzSY/aIgSFwQ+LuXL+Q5b4OEOtXSbhzNa2fe
         c5YWLhnojwtu665acUmBSaKjHabJHN0jzKRZ0rvHdutH2VN8xnzHi7ZHp7b35S/cnKQD
         ziVceMVluyaL8AGEopFR8vt5q+zWPkUJ4BHkg2KJC7eb4RWh0UCNUU5iwkoVhOndylnT
         NElgBucxEaIrb8wa6RZOxnjk3G0Sn2aZHyT+KbPJUhSpqgB/3wqG80f0t4UX2oqhSFer
         Z1Xg==
X-Gm-Message-State: ANhLgQ0bLL1DFPZ3akqhj7JRagfxyuBri2qBsSNdIEyWoXtZBU8YzYE+
        Qal7q2mJUgDiQFDe9noaCY+5HLsG
X-Google-Smtp-Source: ADFU+vvVVwqLW1InbIzNe46SocLmDrKp7ZusU+Myxk8Ajah81B3iHuvNowq+jlcpIbdIUl/hah7v6g==
X-Received: by 2002:aa7:c41a:: with SMTP id j26mr3891297edq.33.1584638888242;
        Thu, 19 Mar 2020 10:28:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e19sm198718edr.77.2020.03.19.10.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:28:07 -0700 (PDT)
Message-Id: <pull.586.git.1584638887.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Mar 2020 17:28:05 +0000
Subject: [PATCH 0/2] Slightly simplify partial clone user experience
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was something discussed briefly at the contributor summit: users will
have a hard time remembering git clone --filter=blob:none <url>. This series
simply adds a --partial option that is equivalent to --filter=blob:none,
with the ability to specify a size using --partial=<size> that is equivalent
to --filter=blob:limit=<size>.

While going to the git clone documentation to add this option, I noticed
that there is no reference to the --filter option there, nor any discussion
of partial clone. I resolved the former.

REQUEST FOR HELP: If anyone out there is looking for an opportunity to
contribute documentation, I feel there is a need to include a section in the 
git clone documentation devoted to partial clone. Hopefully such a section
would include answers to these questions:

 1. What is a partial clone?
 2. Why would I want a partial clone?
 3. How do I need to be careful when using a partial clone?

I don't have time to write such a document right now, which is why I'm
asking for help if anyone is looking for a non-code way to contribute to the
project.

Thanks, -Stolee

Derrick Stolee (2):
  partial-clone: set default filter with --partial
  clone: document --partial and --filter options

 Documentation/git-clone.txt   | 15 ++++++++++++-
 list-objects-filter-options.c | 18 +++++++++++++++
 list-objects-filter-options.h |  8 ++++++-
 t/t5616-partial-clone.sh      | 42 ++++++++++++++++++++++++++---------
 4 files changed, 71 insertions(+), 12 deletions(-)


base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-586%2Fderrickstolee%2Fpartial-clone-ux-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-586/derrickstolee/partial-clone-ux-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/586
-- 
gitgitgadget
