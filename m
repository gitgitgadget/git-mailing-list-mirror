Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8945BC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 08:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1504020848
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 08:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPgL1KCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394597AbgJPI2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 04:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390161AbgJPI2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 04:28:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226AEC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 01:28:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x13so1049140pfa.9
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+KFkVhjGIAYc1hzSizHag64Q25VbOSTWo0ii+llVvSY=;
        b=BPgL1KCUbaD+CfMEhXvd7NhxucweQsukHaG9/uwB91rZYNqGLT4wqHGaTcnwTs6tBF
         IoAa/OlY1JiR9f2B9oMddMUayXEWR26QzTDPtVcQd7GS9q/5dTYCZfPBb4gb+g9RXAMs
         lo8sJpG3kyCJNMgkj5mQm2L+idhF3uQtOcp+yOvWCkE7nPaBSJXuahOY74OcIhRXERwQ
         sog7McPeCEtHBONMl7icxikRXja2RVFNzqdXj9HJZGpt7KwUmzGTf9sgetZ0raALM2oM
         k4ARKK5BrlTEb3mOfFQ+rlZHhr7sMJVNrsG21ALCPmQZmH1k1JNt2VfMgTMomDh2Pc1v
         EAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+KFkVhjGIAYc1hzSizHag64Q25VbOSTWo0ii+llVvSY=;
        b=LXrPuv5/ROAhkW3+5Ex28fUpcaPqe2sGd+X+Rd9gXBTJ72PPuu4jiTR15lZHUgJmX1
         fNcGhiwlz11CBtSsQZFKFDCEIBJ4EmIMkcL0H7JLkw7j1q2tNT/DKED/rQiypU1UUZLw
         04JkmfjK1TKod5DCUSR3FxKp7R32mTcrBn4k4+N/KirZ1MB6ZfsQzie2s6JXvwHSkeI5
         6Yh+MSo9C+snaMhoDAIZmkytgxcm5boBbKY8AdX0BIgLZzn49IyT0enq1qbbTY/ApRWl
         XCx324jOtFhoaaMYxyOQPRV7uN3gFVAEK3xzZZkQGk2IMTCI92J+sO2k46wGb7vM74L0
         +43g==
X-Gm-Message-State: AOAM532XpIiNSrGzZPPggvw6ugWnQJyj1Be9B/36CY/QRZLWEEmv+DvJ
        07rlgntQRYxD9R8m6OgS3ABt8K/z+pCdiY83p+U=
X-Google-Smtp-Source: ABdhPJyhVjkdN0BwLuVsQ8ycSzR1aXqie+6ySo2rxFrAN8kmmY4HTSzY+Kx7ygHh3Ukgb2ZMzeQHP+CLiOSlwBFDLoY=
X-Received: by 2002:a63:3dc7:: with SMTP id k190mr2136262pga.291.1602836930434;
 Fri, 16 Oct 2020 01:28:50 -0700 (PDT)
MIME-Version: 1.0
From:   Zodwa Phakathi <phakathizc@gmail.com>
Date:   Fri, 16 Oct 2020 10:28:39 +0200
Message-ID: <CAGdqGXp07VAUFGTsgvc83V6HgswhpqMnKGAbEaiWXpiEj_Q1rQ@mail.gmail.com>
Subject: [Outreachy] Introduction
To:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day,

I hope this email finds you well. My name is Zodwa Phakathi from South Africa.
I am one of the Outreach applicants. I would like to participate in
the following project by the title of Rename detection and the
"range-diff" command in Git. I would like some advice on which
microproject I can participate in. I am interested in the Modernize a
test script microproject, Kindly advise if it is still available to
work on it and how to set up the project.

kind regards,
Zodwa.
