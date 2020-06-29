Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98640C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1EB20720
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfOCSNHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbgF2VBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbgF2TM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:57 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99439C0D9418
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 04:59:41 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e18so3517216ilr.7
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=IAJ7/P9WCx+2j07Dv3e7WtrU2SwAe4SzfFm1Sex6vIQ=;
        b=hfOCSNHMDOwnt83nsefXHYgleXIO2wu/YhZGlVx51WieGiMg1A5YEEoTZhx4NsQGq8
         2TVOmsWAPL3Y/dE8O/INEMItVOMLdUP2pgeA7YUf+K+2iAj0jyY8ivuLZbrH7bRjFL1x
         iARJvjX7LCcDvz/1chkcJZiIs9DpPcIcM5q4vSIClBhm/MvLboCZzGm8NQ9OIFB2QVa6
         3c/A5D/FWP/wtN8b7J0/q2zgJjOnOSJTqYRhfMkDb+umLaQVylUhUBzJq0ZufYePXmoV
         V3dqDqPM5tECW60P6hCBdZw8yZBwfTTnp4QU6mZNzg0WGZDymPmD/Ll/F/e0fkh8e/1a
         6Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=IAJ7/P9WCx+2j07Dv3e7WtrU2SwAe4SzfFm1Sex6vIQ=;
        b=WKALx3wp/u4fg/OOZe+aDtZ/Tba40OEU/+mek5qyDkfEsET/h54NSxWG5aOmUk0WOh
         j4j7CPLlpilqsl+8EbN41jOHdNueDGonivZ+FTVUgPRRLF7Z1sCPhYLVTFQJ5qO/5aqu
         kJr3zKX0jbyvXBkdcVX+vP9bcGYI5s1sFo7z746DDfg7JgC+d3PMxIuGrHR64oCK17ov
         TPuX0GTMnCmoPZw0cWCAXFuUIQ97b92OkR1Y2MRQ9XLpWuIabJlGjHPDxAz3qrm8ihqs
         /Rodqyp3hdf5NA+ICmsIeTKvcTW3+aWJ/AQ2YpdlcUezLrVk6O9JR427SGvtJ9d3F1HZ
         1Bhw==
X-Gm-Message-State: AOAM531iw0oYFYmkRX7ehrkMNT+XGRz2yZpm7laSEkxhTR6QxDu6qd4x
        LhWKcFxx2XGqGtHqILra5o/dUdwAAuxLA0mVmDdM8B9N
X-Google-Smtp-Source: ABdhPJxKU0WtDZnRpL8sdPWu8x3phhhu7GhqJW3WkJS1mu8gdZ+WI/D0ZBVynRriPb8FguXts4HRKmAzNAHDGMY+1Ac=
X-Received: by 2002:a92:d181:: with SMTP id z1mr15764416ilz.41.1593431980893;
 Mon, 29 Jun 2020 04:59:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 29 Jun 2020 07:59:10 -0400
Message-ID: <CAH8yC8kJPjKSZajpHQjKJGa+sAeCxmimjGXY4QNWZ=xjPXJVSw@mail.gmail.com>
Subject: How to get back missing files after rebase?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just rebased in preparation for a commit and then pull request.

My forced push failed. It looks like Git just deleted all my work:

    BLAKE2/ppc$ ls
    BLAKE2/ppc$

WTF? How do I get back my work? Why is Git deleting my shit?

Jeff
