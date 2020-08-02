Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF2EC433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 13:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707AE2075A
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 13:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkBl6CcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHBNWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 09:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgHBNWv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 09:22:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3266C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 06:22:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ep8so692921pjb.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:message-id:date
         :to;
        bh=R3TUtOR7hmFQzKXdrZhKX+31caMu5mYqFUS2svXoHAU=;
        b=FkBl6CcUPIFHgW5ireiWI1wYa4GyuPN6Mh2la0lKONC0xEbxOTsUULit3S9TAyN8ky
         GlbMBcOUHSHt/ty3Qo9RDKjC4XF/B++N2dXOWVqcuo0Wx7Gy8K6LSUwaZdBqSiDwao3K
         6drt3KarxTrUD2JWx7+IlHIb3QC+8OY9fOBnHkNyUybjRc+wadm6aYmcZNA/MkxzzjrY
         LFdqLYFGeDwyArWcXnuHPbUCZc9NBW3H6ADRvgPfvVJRy38ajjLpJh/8RHbKiam899Qc
         1dEPS0Ly0hUOUox208zHlySKkdimCdwXrKd3HQNRGpRu7ns3u+rOQoRj+FKxVQVE9qff
         cBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:message-id:date:to;
        bh=R3TUtOR7hmFQzKXdrZhKX+31caMu5mYqFUS2svXoHAU=;
        b=nCl1yBee3nTmVFUj5poyEYYQ1bZMC0G8K0Lh7pKNJpSwTbit3iPwnOt7dTPez0wQV3
         YCYc9tEcSxp5vl/8pgJ8O4i4fNJx9+gdvWrTyAe4SD5VbbM2FJPVLafxx9vfJkuFCPo5
         WrNEkOJJr7iYK8d1cRKqigr/aKZRZ3/SGD9wiG1OZCxDASQfyibZD45S9RRuvxps5mqC
         LAZZUuMSlgvDn4Ec7rdWjIprYQKhhFtri3xk+p1+KELq3I1CefuVWGI4e9EiwfVoxwjB
         2jdtDAkUly7jNa4qepUoltv/5F1j4PYLtG/9lXm+p9/VJYoMx+88XwLy+8ngkDAqDacX
         pdzQ==
X-Gm-Message-State: AOAM531YbR1cyV+Vq3E2R3t+MiOOP+TflBHnQqhFGD79oapyIBwYHmgu
        vr7c+L5+ZRCy0S1NnhhbN8PIhiDz
X-Google-Smtp-Source: ABdhPJxtcSkWSlpHGJHHdj75qxI0/NldiQ+jPFGzW77Dps+C03rkD0Xi77ukl0JqXLl4f6dx3Qx3xw==
X-Received: by 2002:a17:90b:390f:: with SMTP id ob15mr12461094pjb.156.1596374571196;
        Sun, 02 Aug 2020 06:22:51 -0700 (PDT)
Received: from [192.168.0.150] (097-093-071-077.biz.spectrum.com. [97.93.71.77])
        by smtp.gmail.com with ESMTPSA id y10sm16874269pfp.130.2020.08.02.06.22.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 06:22:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andrea Wyss <andrea.wyss@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: amend param not available to the pre-commit hook
Message-Id: <30DFCBF3-FEA8-4FF5-94ED-A81AB10B04A3@gmail.com>
Date:   Sun, 2 Aug 2020 06:22:49 -0700
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (17G68)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=EF=BB=BFIssue
amend param not available to the pre-commit hook

Problem
Cannot write a pre-commit hook that stops amending a commit that is present i=
n other branches.

Steps to Reproduce (git version 2.21.1)
1. Code in the pre-commit hook:
  echo "DEBUG 0=3D'$0' 1=3D'$1'"

2. run:
  git commit --amend

Current Result
  DEBUG 0=3D'.git/hooks/pre-commit' 1=3D''

Expected Result
  DEBUG 0=3D'.git/hooks/pre-commit' 1=3D'--amend'

Please, let me know if you need other info.
I'm looking forward for a fix or workaround.

Thank you,
Andrea Wyss
