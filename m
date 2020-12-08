Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A9FC2BB40
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 12:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BA0236FB
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 12:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgLHMKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 07:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgLHMKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 07:10:49 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE66C061749
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 04:10:03 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id b18so15623890ots.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 04:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7tvTH7tchjGDxvkXINVY4jmeAdTASMyIuiP1SBDo3I0=;
        b=FjgEZeNaB2sLpGWWEHK26QpgdzpWYaAJroJPz40XQX2m7Wxcgw4o/ofi0hjeZzSN5O
         4Nm0F78RFQKoiV3SgyNr8uVhiqhUbZ9d3Sz0//ekSUzznkawLYy7tGepoUXG+KvwTU+5
         zZBO3bhNCX8WE7v9pGUN0dUKLmaSkpxZ20SUoJ6KBKXaVNf3wv/fl57Ac4wGJJ3ucDfr
         VnY+ETYwXHG7T150jO/7CycjiNyUROBQE00pJ8ShbLY9AL1hLueGQ2ExPNnX7e8jDpxi
         T/f3bfH+u+Lp6C3g2+g+TGbKJx4/MI10Eu22V6yPE1A7mOcCvs3hl3ZEOp/VjzopMb5i
         o9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7tvTH7tchjGDxvkXINVY4jmeAdTASMyIuiP1SBDo3I0=;
        b=LPWLKBX+r9bjiuJ1wo2f9RRxlmTbORQAZsybstPPqJi7nsRRx9FIgKDIOfJsJKDpky
         UVUczxTJ6jBmpE7Od2/lVuuUH32hmdI8VEqAxxy116RctLjoYVN8GJKHuydt8W3iRM9C
         mP1HqEn4h7iNur+T5O6Og/4EzKWKShFbke2XFXpULWFXmXv+AgpJXDMp9pWirtAILj6w
         QdC9/+kDrnwzKrxmLALGPHRHvKV94PwGXEmayQy/n6tBDtbt7ow4hkG85yLJ30xNgVYC
         j0cG5cYu1msraxX4Dh3P6B+MerZZ4Iffn3bOyFGgIq4bVSYjeRlnOoVZvLjEf2cy6KHM
         /GZg==
X-Gm-Message-State: AOAM531qWzTtZmRpyE9Kzlt6kQCmReJ4hSRWRE36ONLHXdcjW8EsACWr
        YIdwwY0TAEIUZ5BR8SZzVv27BmDm+3BR0cEsq3a6s/YU0g1yyg==
X-Google-Smtp-Source: ABdhPJyYseCN5jzkjVgmAnVnozT662uXqQyzDFcrYR2dtaNFpmosfO88aRvBZkQY46ZjTES2dctkX3rmlRtk+ibdqMU=
X-Received: by 2002:a05:6830:1657:: with SMTP id h23mr16553679otr.184.1607429402626;
 Tue, 08 Dec 2020 04:10:02 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 8 Dec 2020 17:39:51 +0530
Message-ID: <CAPSFM5doEKU7KOGV+So_ReSykGS6OptXzbH3xJM9ig3sXijZQg@mail.gmail.com>
Subject: [Outreachy ] Project Blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone !

I am happy to share that, I am working on the project "Implement
reword! and drop! commit in git interactive rebase" and will be
posting about my progress at https://charvi-077.github.io/

Also, I have added my latest post, about the progress till now.
Please let me know if you have any feedback and suggestions.

Thanks and Regards,
Charvi
