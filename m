Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E31C433E3
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 06:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476FC221EB
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 06:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfo5XL2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGNGec (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNGea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 02:34:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E458AC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 23:34:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t6so3451010plo.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 23:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QqWdoxPCzFIuoFeuQ03Qa+LeoBaFYBsyvQZ4ygHmAWs=;
        b=jfo5XL2zccaaexU0f61GR9IOahexMbSHrRTw55+eNfeJk4zSavEe6p/a0cG1iCsbkq
         Qeh8Yxe8gwcGsBM934wBSCJcRAXMGcjubyPrmDzUCYZIMeIC4z2OqkyEFMZcBh00kVWj
         g2T0H818YF1Za1Rc5urxgsE46YoEB8XmTQy+Um+FLtg5b6GVb7no/lDdEM7C2BJ3oCzv
         izNcEp8aLuAVu2yGGhsAXXShGrD00U+m2quvaV6UwxmdlW558kGiisaZgCiBq+tQ8S1s
         VVphKzMKWqQDMHNderJFyqxStX0tZKdkdjPNQeu8Oa50bAGUT9s+S7suLJDbr2vf/wXd
         TAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QqWdoxPCzFIuoFeuQ03Qa+LeoBaFYBsyvQZ4ygHmAWs=;
        b=UfydLbLQyoztOBfwwyLinGyy0w+1blIng18I89bqZDW+zYgEPm38rc0CVOOQoNonWz
         4qhM24WxzgJSfL+tQ7nJhzLd8QwcXklXz+u8dmM0q3AFxYYauijezTbmoC5/nG12xtO4
         2X9SupeQ/2v9ivSY/JWdKMYZGiXNEE1RxtOF9VmD5X7TnnZbO+SXQczABeW1S7APSBRB
         6DCoEH/MsXu+5zHFSLszeHYRIAdDh7/CFtXxG3geZbXHL44bkFjok+UDpEHovzHaPh/d
         Mwt4UabxM/yOYKyLtlAbYxYxZZorRZb64NkK1dh/wlAsL3xQLCJyPcfPDhoak9mGVzAI
         8BKA==
X-Gm-Message-State: AOAM533pnfV03V90B/D1+TaNHT8qWk3/wXeVIjy2+DYwYumRwHKPbU8h
        Xk2ZbPtSAHGpwwa027jjA22TN3DLsvE=
X-Google-Smtp-Source: ABdhPJzN4NW9muBJ2mlu2Mpc7nuTREq849uT6VpMQdod0j3IVNCPJV7h5z/OehzLSE0PIXHoEIJJgQ==
X-Received: by 2002:a17:902:a609:: with SMTP id u9mr2771764plq.5.1594708469141;
        Mon, 13 Jul 2020 23:34:29 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:e8a:69a1:3523:a8cb:2cbf:c365])
        by smtp.gmail.com with ESMTPSA id d9sm15662196pgv.45.2020.07.13.23.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 23:34:28 -0700 (PDT)
Date:   Tue, 14 Jul 2020 12:02:36 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC] Blog about week 6
Message-ID: <20200714063236.GB10242@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!

Over the last week, I started implementing generation number v2. Based
on the performance numbers and subsequent discussion, we have decided to
use generation data chunk approach, storing topological levels into CDAT
and corrected commit date offsets into GDAT chunk. Do note that we are
maintaining backward compatibility using topological level, not with
monotonic offsets.

I also found a performance regression with `commit-graph write
--reachable --changed_path` that sneaked in along with the patch on
moving generation and graph positions into commit-slab.

https://abhishekkumar2718.github.io/gsoc/2020/07/12/gsoc-week-6.html

https://github.com/gitgitgadget/git/pull/676

> Yes, I pushed without signing off or a cover letter. It's still a work
> in progress.

Thanks
Abhishek
