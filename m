Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B5CC433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16180207BB
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HQRmznjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgH2BCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgH2BCc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 21:02:32 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03DC061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 18:02:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t11so864951qtn.8
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zjFzozIwT7wNr9YJNsD24aMdZsWBxfh3qckMUXJyB1s=;
        b=HQRmznjMQZq45L/5FMrUQZWYebMNUxf7Zp1jrf4SluueiHchzsrgs4qdzsper1AJeN
         bk4bqCc1dwXn7q7MQZcuh25swMz5Hqbt2i4TS/WiT9S0VFccmaqNDdmBjCVuCB0H0RzJ
         /F7mruiCtQmmxrFu4taV2aj0XL3q4VTnsBeIAMns1KC9963YBBpmZuX4U7eYtaZ0b4AQ
         h0cTGtryw7N4cyXEm2LYLDvCbr6P8YwgPV3vdWvJOltImQQi8v/JC1ZxrwAIxG1zZksK
         1Sq4NI6f++e97N+K2E/DTUwy5soujTx2Ys7IhGRxQqzMuez8aliNuGpoXbsbHxc2vS7C
         ApSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zjFzozIwT7wNr9YJNsD24aMdZsWBxfh3qckMUXJyB1s=;
        b=swH37uEzVW+mjlXxKFeUF9+KnbsaXT8qllP4wxZk1wToA3wSS3E10nCsM9aMulAY6X
         JLDVzEsjDDBTSsKI2RXDwazU+03ZNLg9nqOxtG9Tdls8sGikz34lEHkmo84vejsDHYgY
         H1RjfCaz6T7Mnz4kW/neV44VGZDiuxujFMS+k3leald41zQsKUcJI7I9w25y4wFITi9X
         4FkA6mAEeF3ao1vmj4x2RIOAqpZzdxrjYgnJU48u2v5eGSltXLH8+yfySc29cjlQWVWE
         ze7P1sPNiW+P/yhvrgrO58fxUdfofHfnxH+ulTj+H+Nf4g7ZBoDbcqWUImgiHmdC4OJc
         M7JA==
X-Gm-Message-State: AOAM5330ugp91HdAvwAJGIZnufmfs5lnp/LahSFXIYOQyj6fanE9BMk6
        qIr90/TgykHDnJhTZ327Ys4g0+w+89SbknUFhljXh0UQhBAKvDcLBQ6UsnILnkbq/AMTVxS6zXe
        XfYyv8QYZtqhgtFcbR1lPvDAtbg6IqRI7q+QmfWtzD4XdEUgd5E6YLrsWs6SG0r/FAeT6iiIDcx
        9s
X-Google-Smtp-Source: ABdhPJzWITbFgeF/Q75IXIOLMlAiSRRfoJ4inzNRYzAtGHQ3woNotDactB/ZwYj1IuJDiVrLtR2hdyqY++rJ8Y4Iw/W2
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:aee1:: with SMTP id
 n33mr1143220qvd.141.1598662949830; Fri, 28 Aug 2020 18:02:29 -0700 (PDT)
Date:   Fri, 28 Aug 2020 18:02:25 -0700
In-Reply-To: <20200513004058.34456-1-jonathantanmy@google.com>
Message-Id: <cover.1598662525.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200513004058.34456-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 0/2] Fix for git checkout @{u} (non-local) then git status
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Jonathan Nieder wrote [1]:

>  A. Like you're hinting, could dwim_ref get a variant that returns -1
>     instead of die()ing on failure?  That way, we could fulfill the
>     intent described in b397ea48:
> 
> 	When it cannot figure out the original ref, it shows an abbreviated
> 	SHA-1.

Here are some patches that do this. As discussed, this is not the
complete solution, but at least now we can handle unresolvable marks.

I've also switched the commit messages and test from mentioning "git
branch" to mentioning "git status".

[1] https://lore.kernel.org/git/20200827014723.GA750502@google.com/

Jonathan Tan (2):
  sha1-name: replace unsigned int with option struct
  wt-status: tolerate dangling marks

 cache.h           | 27 +++++++++++++++++++--------
 refs.c            | 17 +++++++++++------
 refs.h            |  3 ++-
 revision.c        |  3 ++-
 sha1-name.c       | 45 +++++++++++++++++++++++++++++----------------
 t/t7508-status.sh | 12 ++++++++++++
 wt-status.c       |  2 +-
 7 files changed, 76 insertions(+), 33 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

